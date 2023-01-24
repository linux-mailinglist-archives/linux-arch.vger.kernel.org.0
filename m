Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357DC678CB4
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jan 2023 01:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjAXATf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 19:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjAXATe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 19:19:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C16367E8;
        Mon, 23 Jan 2023 16:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674519573; x=1706055573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8akBJZSgOwqaCeNwd9vSz30jHqCfVyn9vginXj4vLpw=;
  b=Ensul0UXra+ZapjO0CDJTf2MDhIiIolb/7r7HANSCSlNwGOLO8bFrvzW
   Fl4w+FoxgsvkZa+w7YwJlqlZl5EznpUsvebENK+J97lPJbxuC9JC3FJH1
   XM76qLA80N4tE30dOXG3qbuw9q+tL1pXp6kxYyyV1ZXGAdHbzMsV61hvI
   QY47LWmWlT7rY4Z7iQdmrnCu0pgLylgXWv0/mqOQ38E2WXWNofEIMxb9G
   oUlKfqNbAFW5EWE4gkQJALg5uQ0Gu9xYTnm/dGqxz5vxjTLQ+Qe6JdTgB
   BUnbZ3ncAmhSd0fUDDC0w0AODSJ2uc8ofzdP8W5MGdYNAlz1a/XPpSHUE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="353468216"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="353468216"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:19:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="694143856"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="694143856"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Jan 2023 16:19:29 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pK728-0005yW-0V;
        Tue, 24 Jan 2023 00:19:28 +0000
Date:   Tue, 24 Jan 2023 08:19:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v4] riscv: Use PUD/P4D/PGD pages for the linear mapping
Message-ID: <202301240847.k2H9qZVL-lkp@intel.com>
References: <20230123112803.817534-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123112803.817534-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alexandre,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.2-rc5 next-20230123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Use-PUD-P4D-PGD-pages-for-the-linear-mapping/20230123-192952
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230123112803.817534-1-alexghiti%40rivosinc.com
patch subject: [PATCH v4] riscv: Use PUD/P4D/PGD pages for the linear mapping
config: riscv-nommu_virt_defconfig (https://download.01.org/0day-ci/archive/20230124/202301240847.k2H9qZVL-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b0cdf20b21efcc85ec67bffa6a10894dedd0d12e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexandre-Ghiti/riscv-Use-PUD-P4D-PGD-pages-for-the-linear-mapping/20230123-192952
        git checkout b0cdf20b21efcc85ec67bffa6a10894dedd0d12e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/mm/init.c: In function 'setup_bootmem':
>> arch/riscv/mm/init.c:222:9: error: 'riscv_pfn_base' undeclared (first use in this function)
     222 |         riscv_pfn_base = PFN_DOWN(phys_ram_base);
         |         ^~~~~~~~~~~~~~
   arch/riscv/mm/init.c:222:9: note: each undeclared identifier is reported only once for each function it appears in


vim +/riscv_pfn_base +222 arch/riscv/mm/init.c

   187	
   188	static void __init setup_bootmem(void)
   189	{
   190		phys_addr_t vmlinux_end = __pa_symbol(&_end);
   191		phys_addr_t max_mapped_addr;
   192		phys_addr_t phys_ram_end, vmlinux_start;
   193	
   194		if (IS_ENABLED(CONFIG_XIP_KERNEL))
   195			vmlinux_start = __pa_symbol(&_sdata);
   196		else
   197			vmlinux_start = __pa_symbol(&_start);
   198	
   199		memblock_enforce_memory_limit(memory_limit);
   200	
   201		/*
   202		 * Make sure we align the reservation on PMD_SIZE since we will
   203		 * map the kernel in the linear mapping as read-only: we do not want
   204		 * any allocation to happen between _end and the next pmd aligned page.
   205		 */
   206		if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
   207			vmlinux_end = (vmlinux_end + PMD_SIZE - 1) & PMD_MASK;
   208		/*
   209		 * Reserve from the start of the kernel to the end of the kernel
   210		 */
   211		memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
   212	
   213		phys_ram_end = memblock_end_of_DRAM();
   214		if (!IS_ENABLED(CONFIG_XIP_KERNEL))
   215			phys_ram_base = memblock_start_of_DRAM();
   216	
   217		/*
   218		 * Any use of __va/__pa before this point is wrong as we did not know the
   219		 * start of DRAM before.
   220		 */
   221		kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
 > 222		riscv_pfn_base = PFN_DOWN(phys_ram_base);
   223	
   224		/*
   225		 * memblock allocator is not aware of the fact that last 4K bytes of
   226		 * the addressable memory can not be mapped because of IS_ERR_VALUE
   227		 * macro. Make sure that last 4k bytes are not usable by memblock
   228		 * if end of dram is equal to maximum addressable memory.  For 64-bit
   229		 * kernel, this problem can't happen here as the end of the virtual
   230		 * address space is occupied by the kernel mapping then this check must
   231		 * be done as soon as the kernel mapping base address is determined.
   232		 */
   233		if (!IS_ENABLED(CONFIG_64BIT)) {
   234			max_mapped_addr = __pa(~(ulong)0);
   235			if (max_mapped_addr == (phys_ram_end - 1))
   236				memblock_set_current_limit(max_mapped_addr - 4096);
   237		}
   238	
   239		min_low_pfn = PFN_UP(phys_ram_base);
   240		max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
   241		high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
   242	
   243		dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));
   244		set_max_mapnr(max_low_pfn - ARCH_PFN_OFFSET);
   245	
   246		reserve_initrd_mem();
   247		/*
   248		 * If DTB is built in, no need to reserve its memblock.
   249		 * Otherwise, do reserve it but avoid using
   250		 * early_init_fdt_reserve_self() since __pa() does
   251		 * not work for DTB pointers that are fixmap addresses
   252		 */
   253		if (!IS_ENABLED(CONFIG_BUILTIN_DTB)) {
   254			/*
   255			 * In case the DTB is not located in a memory region we won't
   256			 * be able to locate it later on via the linear mapping and
   257			 * get a segfault when accessing it via __va(dtb_early_pa).
   258			 * To avoid this situation copy DTB to a memory region.
   259			 * Note that memblock_phys_alloc will also reserve DTB region.
   260			 */
   261			if (!memblock_is_memory(dtb_early_pa)) {
   262				size_t fdt_size = fdt_totalsize(dtb_early_va);
   263				phys_addr_t new_dtb_early_pa = memblock_phys_alloc(fdt_size, PAGE_SIZE);
   264				void *new_dtb_early_va = early_memremap(new_dtb_early_pa, fdt_size);
   265	
   266				memcpy(new_dtb_early_va, dtb_early_va, fdt_size);
   267				early_memunmap(new_dtb_early_va, fdt_size);
   268				_dtb_early_pa = new_dtb_early_pa;
   269			} else
   270				memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
   271		}
   272	
   273		dma_contiguous_reserve(dma32_phys_limit);
   274		if (IS_ENABLED(CONFIG_64BIT))
   275			hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
   276		memblock_allow_resize();
   277	}
   278	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
