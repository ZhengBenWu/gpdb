-- @Description Ensures that a trucate during reindex operations is ok
-- 

DELETE FROM reindex_ao WHERE a < 128;
1: BEGIN;
1: REINDEX index idx_bitmap_reindex_ao;
2&: TRUNCATE TABLE reindex_ao;
1: COMMIT;
2<:
2: COMMIT;
3: SELECT COUNT(*) FROM reindex_ao where a > 128 ;
3: set enable_seqscan=false;
3: set enable_indexscan=true;
3: SELECT COUNT(*) FROM reindex_ao where a > 128 ;
3: INSERT INTO reindex_ao VALUES (0);
3: SELECT 1 AS relfilenode_same_on_all_segs from gp_dist_random('pg_class')   WHERE relname = 'idx_bitmap_reindex_ao' GROUP BY relfilenode having count(*) = (SELECT count(*) FROM gp_segment_configuration WHERE role='p' AND content > -1);
