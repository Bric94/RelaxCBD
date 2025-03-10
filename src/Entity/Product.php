<?php

namespace App\Entity;

use App\Repository\ProductRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ProductRepository::class)]
class Product
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $name = null;

    #[ORM\Column(type: Types::TEXT)]
    private ?string $description = null;

    #[ORM\Column]
    private ?float $price = null;

    #[ORM\Column]
    private ?int $stock = null;

    #[ORM\Column]
    private ?\DateTime $createdAt = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $image = null;

    #[ORM\Column(type: 'json', nullable: true)]
    private ?array $discountByWeight = null; // Réductions par grammage (ex: {"3g": 5, "5g": 10})

    #[ORM\ManyToOne(targetEntity: Category::class, inversedBy: 'products')]
    private ?Category $category = null;

    /**
     * @var Collection<int, OrderItem>
     */
    #[ORM\OneToMany(targetEntity: OrderItem::class, mappedBy: 'product')]
    private Collection $orderItems;

    /**
     * @var Collection<int, Review>
     */
    #[ORM\OneToMany(targetEntity: Review::class, mappedBy: 'product')]
    private Collection $reviews;

    /**
     * @var Collection<int, Discount>
     */
    #[ORM\ManyToMany(targetEntity: Discount::class, mappedBy: 'products')]
    private Collection $discounts;

    #[ORM\Column(type: 'boolean')]
    private bool $isWeightBased = false; // Indique si le produit est vendu au poids (ex: fleurs de CBD)

    #[ORM\Column(type: 'json', nullable: true)]
    private ?array $priceByWeight = null;  // Prix par grammage (ex: {"1g": 10, "3g": 25, "5g": 40})

    #[ORM\Column(type: 'json', nullable: true)]
    private ?array $stockByWeight = null; // Stock par grammage (ex: {"1g": 50, "3g": 30, "5g": 20})


    public function __construct()
    {
        $this->orderItems = new ArrayCollection();
        $this->reviews = new ArrayCollection();
        $this->discounts = new ArrayCollection();
        $this->createdAt = new \DateTime();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): static
    {
        $this->name = $name;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(string $description): static
    {
        $this->description = $description;

        return $this;
    }

    public function getPrice(): ?float
    {
        return $this->price;
    }

    public function setPrice(float $price): static
    {
        $this->price = $price;

        return $this;
    }

    public function getStock(): ?int
    {
        return $this->stock;
    }

    public function setStock(int $stock): static
    {
        $this->stock = $stock;

        return $this;
    }

    public function getImage(): ?string
    {
        return $this->image;
    }

    public function setImage(?string $image): static
    {
        $this->image = $image;
        return $this;
    }

    public function getCreatedAt(): ?\DateTime
    {
        return $this->createdAt;
    }

    public function setCreatedAt(\DateTime $createdAt): static
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    public function getCategory(): ?Category
    {
        return $this->category;
    }

    public function setCategory(?Category $category): static
    {
        $this->category = $category;

        return $this;
    }

    public function getDiscountByWeight(): ?array
    {
        return $this->discountByWeight;
    }

    public function setDiscountByWeight(?array $discountByWeight): static
    {
        $this->discountByWeight = $discountByWeight;
        return $this;
    }

    public function getDiscountForWeight(?string $weight): int
    {
        if ($weight === null) {
            return 0; // Pas de réduction si aucun poids n'est spécifié
        }

        return $this->discountByWeight[$weight] ?? 0;
    }



    /**
     * @return Collection<int, OrderItem>
     */
    public function getOrderItems(): Collection
    {
        return $this->orderItems;
    }

    public function addOrderItem(OrderItem $orderItem): static
    {
        if (!$this->orderItems->contains($orderItem)) {
            $this->orderItems->add($orderItem);
            $orderItem->setProduct($this);
        }

        return $this;
    }

    public function removeOrderItem(OrderItem $orderItem): static
    {
        if ($this->orderItems->removeElement($orderItem)) {
            // set the owning side to null (unless already changed)
            if ($orderItem->getProduct() === $this) {
                $orderItem->setProduct(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Review>
     */
    public function getReviews(): Collection
    {
        return $this->reviews;
    }

    public function addReview(Review $review): static
    {
        if (!$this->reviews->contains($review)) {
            $this->reviews->add($review);
            $review->setProduct($this);
        }

        return $this;
    }

    public function removeReview(Review $review): static
    {
        if ($this->reviews->removeElement($review)) {
            // set the owning side to null (unless already changed)
            if ($review->getProduct() === $this) {
                $review->setProduct(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Discount>
     */
    public function getDiscounts(): Collection
    {
        return $this->discounts;
    }

    public function addDiscount(Discount $discount): static
    {
        if (!$this->discounts->contains($discount)) {
            $this->discounts->add($discount);
            $discount->addProduct($this);
        }

        return $this;
    }

    public function removeDiscount(Discount $discount): static
    {
        if ($this->discounts->removeElement($discount)) {
            $discount->removeProduct($this);
        }

        return $this;
    }

    public function isWeightBased(): bool
    {
        return $this->isWeightBased;
    }

    public function setIsWeightBased(bool $isWeightBased): static
    {
        $this->isWeightBased = $isWeightBased;
        return $this;
    }

    public function getPriceByWeight(): ?array
    {
        return $this->priceByWeight;
    }

    public function setPriceByWeight(?array $priceByWeight): static
    {
        $this->priceByWeight = $priceByWeight;
        return $this;
    }

    public function getStockByWeight(): ?array
    {
        return $this->stockByWeight;
    }

    public function setStockByWeight(?array $stockByWeight): static
    {
        $this->stockByWeight = $stockByWeight;
        return $this;
    }

    public function updateStockForWeight(string $weight, int $quantity): static
    {
        if (isset($this->stockByWeight[$weight])) {
            $this->stockByWeight[$weight] -= $quantity;
            if ($this->stockByWeight[$weight] < 0) {
                $this->stockByWeight[$weight] = 0; // Évite un stock négatif
            }
        }
        return $this;
    }
}
