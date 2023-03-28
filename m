Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8532D6CB616
	for <lists+linux-arch@lfdr.de>; Tue, 28 Mar 2023 07:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC1FaA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Mar 2023 01:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjC1F37 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2023 01:29:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7F71BD6
        for <linux-arch@vger.kernel.org>; Mon, 27 Mar 2023 22:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679981394; x=1711517394;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Pi/v/E0s++YLCIPUjGTEWYsW7l5wsSkOVVM7Pqy/sb8=;
  b=F5dno+RdoYHbh3MsuRa4he7yi6y6NbBJ5iLsAco9y2fstTN47Lep5Wef
   aaGB0fcD0zyA3+o5rQAgzCjhClDguJxtkwDfXRG8fS+OZuEdoaGNtKHFS
   eHhYksMotwgyxpKn97Gj9mu4ALXsAajuf74uUsjHW9SbAUtN6raYvlaB0
   dLsukLjcWTtN8TxkadvWWquLbzOGlEGQslGCTkKiI1ltlBb9jMsp8V1Go
   cq4FVtNswLub9nnTiVbO4xwfLL4B6mqOaX+KiuJJAk5+Hr2YyTHBYj8la
   E51hLJ58Mn/sghm3sanhPkg9+zmU+KFD6X3eFKzBT3+KOLmtAODxOorp2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328931709"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328931709"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 22:29:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="857925395"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="857925395"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2023 22:29:50 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ph1u1-000IIh-1O;
        Tue, 28 Mar 2023 05:29:49 +0000
Date:   Tue, 28 Mar 2023 13:28:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:dma-sync-rework-v1 22/23]
 arch/arm/mm/dma-mapping.c:1306:31: error: use of undeclared identifier 's'
Message-ID: <202303281326.s4BXzpx2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git dma-sync-rework-v1
head:   524c2e1f26db4535ab4a23797fe7e29092b2493c
commit: 7c9ef569f03eea4838f8c126d216d86c2cef085c [22/23] ARM: dma-mapping: split out arch_dma_mark_clean() helper
config: arm-randconfig-r024-20230326 (https://download.01.org/0day-ci/archive/20230328/202303281326.s4BXzpx2-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=7c9ef569f03eea4838f8c126d216d86c2cef085c
        git remote add arnd-asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags arnd-asm-generic dma-sync-rework-v1
        git checkout 7c9ef569f03eea4838f8c126d216d86c2cef085c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mm/ drivers/perf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303281326.s4BXzpx2-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/arm/mm/dma-mapping.c:1306:31: error: use of undeclared identifier 's'
                   arch_sync_dma_for_cpu(phys, s->length, dir);
                                               ^
   arch/arm/mm/dma-mapping.c:1309:29: error: use of undeclared identifier 's'
                   arch_dma_mark_clean(phys, s->length);
                                             ^
   arch/arm/mm/dma-mapping.c:1436:6: warning: unused variable 'len' [-Wunused-variable]
           int len = PAGE_ALIGN(size + offset);
               ^
>> arch/arm/mm/dma-mapping.c:1446:14: error: unknown type name 'mapping'
           iommu_unmap(mapping->domain, iova, len);
                       ^
>> arch/arm/mm/dma-mapping.c:1446:21: error: expected ')'
           iommu_unmap(mapping->domain, iova, len);
                              ^
   arch/arm/mm/dma-mapping.c:1446:13: note: to match this '('
           iommu_unmap(mapping->domain, iova, len);
                      ^
>> arch/arm/mm/dma-mapping.c:1446:2: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
           iommu_unmap(mapping->domain, iova, len);
           ^
           int
   arch/arm/mm/dma-mapping.c:1447:2: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
           __free_iova(mapping, iova, len);
           ^
           int
>> arch/arm/mm/dma-mapping.c:1447:14: error: a parameter list without types is only allowed in a function definition
           __free_iova(mapping, iova, len);
                       ^
>> arch/arm/mm/dma-mapping.c:1448:1: error: extraneous closing brace ('}')
   }
   ^
   1 warning and 8 errors generated.


vim +/s +1306 arch/arm/mm/dma-mapping.c

  1300	
  1301	static void arm_iommu_sync_dma_for_cpu(phys_addr_t phys, size_t len,
  1302					       enum dma_data_direction dir,
  1303					       bool dma_coherent)
  1304	{
  1305		if (!dma_coherent)
> 1306			arch_sync_dma_for_cpu(phys, s->length, dir);
  1307	
  1308		if (dir == DMA_FROM_DEVICE)
  1309			arch_dma_mark_clean(phys, s->length);
  1310	}
  1311	
  1312	/**
  1313	 * arm_iommu_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
  1314	 * @dev: valid struct device pointer
  1315	 * @sg: list of buffers
  1316	 * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
  1317	 * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  1318	 *
  1319	 * Unmap a set of streaming mode DMA translations.  Again, CPU access
  1320	 * rules concerning calls here are the same as for dma_unmap_single().
  1321	 */
  1322	static void arm_iommu_unmap_sg(struct device *dev,
  1323				       struct scatterlist *sg, int nents,
  1324				       enum dma_data_direction dir,
  1325				       unsigned long attrs)
  1326	{
  1327		struct scatterlist *s;
  1328		int i;
  1329	
  1330		for_each_sg(sg, s, nents, i) {
  1331			if (sg_dma_len(s))
  1332				__iommu_remove_mapping(dev, sg_dma_address(s),
  1333						       sg_dma_len(s));
  1334			if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
  1335				arm_iommu_sync_dma_for_cpu(sg_phys(s), s->length, dir,
  1336							   dev->dma_coherent);
  1337		}
  1338	}
  1339	
  1340	/**
  1341	 * arm_iommu_sync_sg_for_cpu
  1342	 * @dev: valid struct device pointer
  1343	 * @sg: list of buffers
  1344	 * @nents: number of buffers to map (returned from dma_map_sg)
  1345	 * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  1346	 */
  1347	static void arm_iommu_sync_sg_for_cpu(struct device *dev,
  1348				struct scatterlist *sg,
  1349				int nents, enum dma_data_direction dir)
  1350	{
  1351		struct scatterlist *s;
  1352		int i;
  1353	
  1354		for_each_sg(sg, s, nents, i)
  1355			arm_iommu_sync_dma_for_cpu(sg_phys(s), s->length, dir,
  1356						   dev->dma_coherent);
  1357	}
  1358	
  1359	/**
  1360	 * arm_iommu_sync_sg_for_device
  1361	 * @dev: valid struct device pointer
  1362	 * @sg: list of buffers
  1363	 * @nents: number of buffers to map (returned from dma_map_sg)
  1364	 * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  1365	 */
  1366	static void arm_iommu_sync_sg_for_device(struct device *dev,
  1367				struct scatterlist *sg,
  1368				int nents, enum dma_data_direction dir)
  1369	{
  1370		struct scatterlist *s;
  1371		int i;
  1372	
  1373		if (dev->dma_coherent)
  1374			return;
  1375	
  1376		for_each_sg(sg, s, nents, i)
  1377			arch_sync_dma_for_device(page_to_phys(sg_page(s)) + s->offset,
  1378						 s->length, dir);
  1379	}
  1380	
  1381	/**
  1382	 * arm_iommu_map_page
  1383	 * @dev: valid struct device pointer
  1384	 * @page: page that buffer resides in
  1385	 * @offset: offset into page for start of buffer
  1386	 * @size: size of buffer to map
  1387	 * @dir: DMA transfer direction
  1388	 *
  1389	 * IOMMU aware version of arm_dma_map_page()
  1390	 */
  1391	static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
  1392		     unsigned long offset, size_t size, enum dma_data_direction dir,
  1393		     unsigned long attrs)
  1394	{
  1395		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
  1396		dma_addr_t dma_addr;
  1397		int ret, prot, len = PAGE_ALIGN(size + offset);
  1398	
  1399		if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
  1400			arch_sync_dma_for_device(page_to_phys(page) + offset,
  1401						 size, dir);
  1402	
  1403		dma_addr = __alloc_iova(mapping, len);
  1404		if (dma_addr == DMA_MAPPING_ERROR)
  1405			return dma_addr;
  1406	
  1407		prot = __dma_info_to_prot(dir, attrs);
  1408	
  1409		ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len,
  1410				prot, GFP_KERNEL);
  1411		if (ret < 0)
  1412			goto fail;
  1413	
  1414		return dma_addr + offset;
  1415	fail:
  1416		__free_iova(mapping, dma_addr, len);
  1417		return DMA_MAPPING_ERROR;
  1418	}
  1419	
  1420	/**
  1421	 * arm_iommu_unmap_page
  1422	 * @dev: valid struct device pointer
  1423	 * @handle: DMA address of buffer
  1424	 * @size: size of buffer (same as passed to dma_map_page)
  1425	 * @dir: DMA transfer direction (same as passed to dma_map_page)
  1426	 *
  1427	 * IOMMU aware version of arm_dma_unmap_page()
  1428	 */
  1429	static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
  1430			size_t size, enum dma_data_direction dir, unsigned long attrs)
  1431	{
  1432		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
  1433		dma_addr_t iova = handle & PAGE_MASK;
  1434		phys_addr_t phys;
  1435		int offset = handle & ~PAGE_MASK;
  1436		int len = PAGE_ALIGN(size + offset);
  1437	
  1438		if (!iova)
  1439			return;
  1440	
  1441		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
  1442			phys = iommu_iova_to_phys(mapping->domain, handle);
  1443			arm_iommu_sync_dma_for_cpu(phys, size, dir, dev->dma_coherent);
  1444		}
  1445	
> 1446		iommu_unmap(mapping->domain, iova, len);
> 1447		__free_iova(mapping, iova, len);
> 1448	}
  1449	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
