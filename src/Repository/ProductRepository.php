<?php

namespace App\Repository;

use App\Entity\Product;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Tools\Pagination\Paginator;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Product>
 */
class ProductRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Product::class);
    }


    //    /**
    //     * @return Product[] Returns an array of Product objects
    //     */
    //    public function findByExampleField($value): array
    //    {
    //        return $this->createQueryBuilder('p')
    //            ->andWhere('p.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->orderBy('p.id', 'ASC')
    //            ->setMaxResults(10)
    //            ->getQuery()
    //            ->getResult()
    //        ;
    //    }

    //    public function findOneBySomeField($value): ?Product
    //    {
    //        return $this->createQueryBuilder('p')
    //            ->andWhere('p.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }

    public function findPaginatedProducts(?int $categoryId, int $page, int $limit = 10): Paginator
    {
        $queryBuilder = $this->createQueryBuilder('p')
            ->orderBy('p.createdAt', 'DESC')
            ->setFirstResult(($page - 1) * $limit)
            ->setMaxResults($limit);

        if ($categoryId !== null) {
            $queryBuilder->join('p.category', 'c')
                ->where('c.id = :categoryId')
                ->setParameter('categoryId', $categoryId);
        }

        return new Paginator($queryBuilder->getQuery());  // ✅ Maintenant, Paginator reçoit bien un Query
    }


    public function searchProducts(?string $query, ?int $category, ?string $sort, int $page = 1, int $limit = 10)
    {
        $qb = $this->createQueryBuilder('p');

        if ($query) {
            $qb->andWhere('p.name LIKE :query OR p.description LIKE :query')
                ->setParameter('query', '%' . $query . '%');
        }

        if ($category) {
            $qb->andWhere('p.category = :category')
                ->setParameter('category', $category);
        }

        switch ($sort) {
            case 'price_asc':
                $qb->orderBy('p.price', 'ASC');
                break;
            case 'price_desc':
                $qb->orderBy('p.price', 'DESC');
                break;
            case 'newest':
            default:
                $qb->orderBy('p.createdAt', 'DESC');
                break;
        }

        $results = $qb
            ->getQuery()
            ->getResult();

        $offset = ($page - 1) * $limit;
        return array_slice($results, $offset, $limit);
    }

    public function getPaginatedProducts(int $page, int $limit = 10)
    {
        $query = $this->createQueryBuilder('p')
            ->setFirstResult(($page - 1) * $limit)
            ->setMaxResults($limit);

        return new Paginator($query);
    }

    public function findTopSellingProducts(int $limit = 5)
    {
        return $this->createQueryBuilder('p')
            ->leftJoin('p.orderItems', 'oi')
            ->select('p, COUNT(oi.id) as sales')
            ->groupBy('p.id')
            ->orderBy('sales', 'DESC')
            ->setMaxResults($limit)
            ->getQuery()
            ->getResult();
    }
}
