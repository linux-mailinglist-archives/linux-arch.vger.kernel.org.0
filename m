Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADDA0E431E
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2019 07:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393814AbfJYFxO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Oct 2019 01:53:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:41381 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393069AbfJYFxO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Oct 2019 01:53:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 22:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="gz'50?scan'50,208,50";a="192432491"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 24 Oct 2019 22:53:06 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iNsX4-000A44-0E; Fri, 25 Oct 2019 13:53:06 +0800
Date:   Fri, 25 Oct 2019 13:52:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Mike Rapoport <rppt@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-um@lists.infradead.org, sparclinux@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 05/12] m68k: mm: use pgtable-nopXd instead of 4level-fixup
Message-ID: <201910251330.Ez7cfoVA%lkp@intel.com>
References: <1571822941-29776-6-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="w2vjfribnqpryzye"
Content-Disposition: inline
In-Reply-To: <1571822941-29776-6-git-send-email-rppt@kernel.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--w2vjfribnqpryzye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mike,

I love your patch! Yet something to improve:

[auto build test ERROR on mmotm/master]

url:    https://github.com/0day-ci/linux/commits/Mike-Rapoport/mm-remove-__ARCH_HAS_4LEVEL_HACK/20191025-063009
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: m68k-multi_defconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/m68k/sun3x/dvma.c: In function 'dvma_map_cpu':
>> arch/m68k/sun3x/dvma.c:98:33: error: passing argument 2 of 'pmd_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
      if((pmd = pmd_alloc(&init_mm, pgd, vaddr)) == NULL) {
                                    ^~~
   In file included from arch/m68k/sun3x/dvma.c:17:0:
   include/linux/mm.h:1917:22: note: expected 'pud_t * {aka struct <anonymous> *}' but argument is of type 'pgd_t * {aka struct <anonymous> *}'
    static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
                         ^~~~~~~~~
   cc1: some warnings being treated as errors

vim +/pmd_alloc +98 arch/m68k/sun3x/dvma.c

^1da177e4c3f41 Linus Torvalds     2005-04-16   75  
^1da177e4c3f41 Linus Torvalds     2005-04-16   76  
^1da177e4c3f41 Linus Torvalds     2005-04-16   77  /* create a virtual mapping for a page assigned within the IOMMU
^1da177e4c3f41 Linus Torvalds     2005-04-16   78     so that the cpu can reach it easily */
^1da177e4c3f41 Linus Torvalds     2005-04-16   79  inline int dvma_map_cpu(unsigned long kaddr,
^1da177e4c3f41 Linus Torvalds     2005-04-16   80  			       unsigned long vaddr, int len)
^1da177e4c3f41 Linus Torvalds     2005-04-16   81  {
^1da177e4c3f41 Linus Torvalds     2005-04-16   82  	pgd_t *pgd;
^1da177e4c3f41 Linus Torvalds     2005-04-16   83  	unsigned long end;
^1da177e4c3f41 Linus Torvalds     2005-04-16   84  	int ret = 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16   85  
^1da177e4c3f41 Linus Torvalds     2005-04-16   86  	kaddr &= PAGE_MASK;
^1da177e4c3f41 Linus Torvalds     2005-04-16   87  	vaddr &= PAGE_MASK;
^1da177e4c3f41 Linus Torvalds     2005-04-16   88  
^1da177e4c3f41 Linus Torvalds     2005-04-16   89  	end = PAGE_ALIGN(vaddr + len);
^1da177e4c3f41 Linus Torvalds     2005-04-16   90  
4eee1e72ad06bd Geert Uytterhoeven 2016-12-06   91  	pr_debug("dvma: mapping kern %08lx to virt %08lx\n", kaddr, vaddr);
^1da177e4c3f41 Linus Torvalds     2005-04-16   92  	pgd = pgd_offset_k(vaddr);
^1da177e4c3f41 Linus Torvalds     2005-04-16   93  
^1da177e4c3f41 Linus Torvalds     2005-04-16   94  	do {
^1da177e4c3f41 Linus Torvalds     2005-04-16   95  		pmd_t *pmd;
^1da177e4c3f41 Linus Torvalds     2005-04-16   96  		unsigned long end2;
^1da177e4c3f41 Linus Torvalds     2005-04-16   97  
^1da177e4c3f41 Linus Torvalds     2005-04-16  @98  		if((pmd = pmd_alloc(&init_mm, pgd, vaddr)) == NULL) {
^1da177e4c3f41 Linus Torvalds     2005-04-16   99  			ret = -ENOMEM;
^1da177e4c3f41 Linus Torvalds     2005-04-16  100  			goto out;
^1da177e4c3f41 Linus Torvalds     2005-04-16  101  		}
^1da177e4c3f41 Linus Torvalds     2005-04-16  102  
^1da177e4c3f41 Linus Torvalds     2005-04-16  103  		if((end & PGDIR_MASK) > (vaddr & PGDIR_MASK))
^1da177e4c3f41 Linus Torvalds     2005-04-16  104  			end2 = (vaddr + (PGDIR_SIZE-1)) & PGDIR_MASK;
^1da177e4c3f41 Linus Torvalds     2005-04-16  105  		else
^1da177e4c3f41 Linus Torvalds     2005-04-16  106  			end2 = end;
^1da177e4c3f41 Linus Torvalds     2005-04-16  107  
^1da177e4c3f41 Linus Torvalds     2005-04-16  108  		do {
^1da177e4c3f41 Linus Torvalds     2005-04-16  109  			pte_t *pte;
^1da177e4c3f41 Linus Torvalds     2005-04-16  110  			unsigned long end3;
^1da177e4c3f41 Linus Torvalds     2005-04-16  111  
872fec16d9a0ed Hugh Dickins       2005-10-29  112  			if((pte = pte_alloc_kernel(pmd, vaddr)) == NULL) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  113  				ret = -ENOMEM;
^1da177e4c3f41 Linus Torvalds     2005-04-16  114  				goto out;
^1da177e4c3f41 Linus Torvalds     2005-04-16  115  			}
^1da177e4c3f41 Linus Torvalds     2005-04-16  116  
^1da177e4c3f41 Linus Torvalds     2005-04-16  117  			if((end2 & PMD_MASK) > (vaddr & PMD_MASK))
^1da177e4c3f41 Linus Torvalds     2005-04-16  118  				end3 = (vaddr + (PMD_SIZE-1)) & PMD_MASK;
^1da177e4c3f41 Linus Torvalds     2005-04-16  119  			else
^1da177e4c3f41 Linus Torvalds     2005-04-16  120  				end3 = end2;
^1da177e4c3f41 Linus Torvalds     2005-04-16  121  
^1da177e4c3f41 Linus Torvalds     2005-04-16  122  			do {
4eee1e72ad06bd Geert Uytterhoeven 2016-12-06  123  				pr_debug("mapping %08lx phys to %08lx\n",
^1da177e4c3f41 Linus Torvalds     2005-04-16  124  					 __pa(kaddr), vaddr);
^1da177e4c3f41 Linus Torvalds     2005-04-16  125  				set_pte(pte, pfn_pte(virt_to_pfn(kaddr),
^1da177e4c3f41 Linus Torvalds     2005-04-16  126  						     PAGE_KERNEL));
^1da177e4c3f41 Linus Torvalds     2005-04-16  127  				pte++;
^1da177e4c3f41 Linus Torvalds     2005-04-16  128  				kaddr += PAGE_SIZE;
^1da177e4c3f41 Linus Torvalds     2005-04-16  129  				vaddr += PAGE_SIZE;
^1da177e4c3f41 Linus Torvalds     2005-04-16  130  			} while(vaddr < end3);
^1da177e4c3f41 Linus Torvalds     2005-04-16  131  
^1da177e4c3f41 Linus Torvalds     2005-04-16  132  		} while(vaddr < end2);
^1da177e4c3f41 Linus Torvalds     2005-04-16  133  
^1da177e4c3f41 Linus Torvalds     2005-04-16  134  	} while(vaddr < end);
^1da177e4c3f41 Linus Torvalds     2005-04-16  135  
^1da177e4c3f41 Linus Torvalds     2005-04-16  136  	flush_tlb_all();
^1da177e4c3f41 Linus Torvalds     2005-04-16  137  
^1da177e4c3f41 Linus Torvalds     2005-04-16  138   out:
^1da177e4c3f41 Linus Torvalds     2005-04-16  139  	return ret;
^1da177e4c3f41 Linus Torvalds     2005-04-16  140  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  141  

:::::: The code at line 98 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--w2vjfribnqpryzye
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--w2vjfribnqpryzye--
