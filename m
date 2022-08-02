Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F0D58775E
	for <lists+linux-arch@lfdr.de>; Tue,  2 Aug 2022 09:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiHBHBR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Aug 2022 03:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiHBHBQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Aug 2022 03:01:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67F2B7F8;
        Tue,  2 Aug 2022 00:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659423674; x=1690959674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jCjvLaBxmp2E3FvGdoq4c5UFWwHPuOwd+qnY5JFqxA4=;
  b=LjLLn25QiOAdCjZpf8fJ8Mx2RO8LeMojF6kit3xQQEosCOa34rxzgiBk
   bS+BnkbGmcsBtYT51c4aclmfKBp4nEo2lVC9MsL8dhVT5vWtOKNWRTBAm
   iHwgfriFYitAoted2RHXudXEQr9Z4a1K/eMLe5nrs6+zr0mYjJLlXhcGI
   ptynbxbVUR3AsduWhYUAeRf3SP0pxnXrsGRTSa1d4fq9UD2YP04VElCY4
   44tIssjHwpIy5XsnLb81w85WK0r8ieinpKw+TfoxX9PL1UPIx9UwtIro/
   ay+t6Uu8b71lmRlmO7HhHls8v113zJZ880OO/eUrCdJaWfLkSvmCRIOGV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="351047970"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="351047970"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 00:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="661499498"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Aug 2022 00:01:08 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIlts-000FnT-0R;
        Tue, 02 Aug 2022 07:01:08 +0000
Date:   Tue, 2 Aug 2022 15:00:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     kbuild-all@lists.01.org, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Min Zhou <zhoumin@loongson.cn>
Subject: Re: [PATCH V6 2/4] LoongArch: Add sparse memory vmemmap support
Message-ID: <202208021409.KLLd0NYP-lkp@intel.com>
References: <20220728113801.2235151-3-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728113801.2235151-3-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Huacai,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on kvm/queue arm64/for-next/core linus/master v5.19]
[cannot apply to akpm-mm/mm-everything tip/x86/mm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/mm-sparse-vmemmap-Generalise-helpers-and-enable-for-LoongArch/20220728-194351
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: loongarch-randconfig-p002-20220801 (https://download.01.org/0day-ci/archive/20220802/202208021409.KLLd0NYP-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d391b94d4c12d54baaf038273712f8da86d50e8d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Huacai-Chen/mm-sparse-vmemmap-Generalise-helpers-and-enable-for-LoongArch/20220728-194351
        git checkout d391b94d4c12d54baaf038273712f8da86d50e8d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash arch/loongarch/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/loongarch/mm/init.c:161:15: warning: no previous prototype for 'vmemmap_populate_hugepages' [-Wmissing-prototypes]
     161 | int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/loongarch/mm/init.c:223:6: warning: no previous prototype for 'vmemmap_free' [-Wmissing-prototypes]
     223 | void vmemmap_free(unsigned long start, unsigned long end,
         |      ^~~~~~~~~~~~


vim +/vmemmap_free +223 arch/loongarch/mm/init.c

   159	
   160	#ifdef CONFIG_SPARSEMEM_VMEMMAP
 > 161	int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
   162						 int node, struct vmem_altmap *altmap)
   163	{
   164		unsigned long addr = start;
   165		unsigned long next;
   166		pgd_t *pgd;
   167		p4d_t *p4d;
   168		pud_t *pud;
   169		pmd_t *pmd;
   170	
   171		for (addr = start; addr < end; addr = next) {
   172			next = pmd_addr_end(addr, end);
   173	
   174			pgd = vmemmap_pgd_populate(addr, node);
   175			if (!pgd)
   176				return -ENOMEM;
   177			p4d = vmemmap_p4d_populate(pgd, addr, node);
   178			if (!p4d)
   179				return -ENOMEM;
   180			pud = vmemmap_pud_populate(p4d, addr, node);
   181			if (!pud)
   182				return -ENOMEM;
   183	
   184			pmd = pmd_offset(pud, addr);
   185			if (pmd_none(*pmd)) {
   186				void *p = NULL;
   187	
   188				p = vmemmap_alloc_block_buf(PMD_SIZE, node, NULL);
   189				if (p) {
   190					pmd_t entry;
   191	
   192					entry = pfn_pmd(virt_to_pfn(p), PAGE_KERNEL);
   193					pmd_val(entry) |= _PAGE_HUGE | _PAGE_HGLOBAL;
   194					set_pmd_at(&init_mm, addr, pmd, entry);
   195	
   196					continue;
   197				}
   198			} else if (pmd_val(*pmd) & _PAGE_HUGE) {
   199				vmemmap_verify((pte_t *)pmd, node, addr, next);
   200				continue;
   201			}
   202			if (vmemmap_populate_basepages(addr, next, node, NULL))
   203				return -ENOMEM;
   204		}
   205	
   206		return 0;
   207	}
   208	
   209	#if CONFIG_PGTABLE_LEVELS == 2
   210	int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
   211			struct vmem_altmap *altmap)
   212	{
   213		return vmemmap_populate_basepages(start, end, node, NULL);
   214	}
   215	#else
   216	int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
   217			struct vmem_altmap *altmap)
   218	{
   219		return vmemmap_populate_hugepages(start, end, node, NULL);
   220	}
   221	#endif
   222	
 > 223	void vmemmap_free(unsigned long start, unsigned long end,
   224			struct vmem_altmap *altmap)
   225	{
   226	}
   227	#endif
   228	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
