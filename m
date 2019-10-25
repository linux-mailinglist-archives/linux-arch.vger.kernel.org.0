Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13241E4164
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2019 04:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389501AbfJYCS2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 22:18:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:21129 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732877AbfJYCS2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 Oct 2019 22:18:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 19:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,226,1569308400"; 
   d="gz'50?scan'50,208,50";a="202481808"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Oct 2019 19:18:04 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iNpAx-0009Th-Po; Fri, 25 Oct 2019 10:18:03 +0800
Date:   Fri, 25 Oct 2019 10:17:29 +0800
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
Subject: Re: [PATCH 06/12] microblaze: use pgtable-nopmd instead of
 4level-fixup
Message-ID: <201910251024.I6neM4qC%lkp@intel.com>
References: <1571822941-29776-7-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="663xtopnljfubs7d"
Content-Disposition: inline
In-Reply-To: <1571822941-29776-7-git-send-email-rppt@kernel.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--663xtopnljfubs7d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mike,

I love your patch! Yet something to improve:

[auto build test ERROR on mmotm/master]

url:    https://github.com/0day-ci/linux/commits/Mike-Rapoport/mm-remove-__ARCH_HAS_4LEVEL_HACK/20191025-063009
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: microblaze-mmu_defconfig (attached as .config)
compiler: microblaze-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=microblaze 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/shm.h:6:0,
                    from include/linux/sched.h:16,
                    from arch/microblaze/mm/consistent.c:15:
   arch/microblaze/mm/consistent.c: In function 'consistent_virt_to_pte':
>> arch/microblaze/include/asm/pgtable.h:458:34: error: passing argument 1 of 'pmd_offset' from incompatible pointer type [-Werror=incompatible-pointer-types]
    #define pgd_offset(mm, address)  ((mm)->pgd + pgd_index(address))
                                     ^
   arch/microblaze/include/asm/page.h:105:30: note: in definition of macro 'pgd_val'
    #   define pgd_val(x)      ((x).pgd)
                                 ^
>> include/asm-generic/pgtable-nopud.h:50:24: note: in expansion of macro 'p4d_val'
    #define pud_val(x)    (p4d_val((x).p4d))
                           ^~~~~~~
>> include/asm-generic/pgtable-nopmd.h:49:24: note: in expansion of macro 'pud_val'
    #define pmd_val(x)    (pud_val((x).pud))
                           ^~~~~~~
>> arch/microblaze/include/asm/pgtable.h:448:48: note: in expansion of macro 'pmd_val'
    #define pmd_page_kernel(pmd) ((unsigned long) (pmd_val(pmd) & PAGE_MASK))
                                                   ^~~~~~~
>> arch/microblaze/include/asm/pgtable.h:464:13: note: in expansion of macro 'pmd_page_kernel'
     ((pte_t *) pmd_page_kernel(*(dir)) + pte_index(addr))
                ^~~~~~~~~~~~~~~
>> arch/microblaze/mm/consistent.c:162:9: note: in expansion of macro 'pte_offset_kernel'
     return pte_offset_kernel(pmd_offset(pgd_offset_k(addr), addr), addr);
            ^~~~~~~~~~~~~~~~~
>> arch/microblaze/include/asm/pgtable.h:454:31: note: in expansion of macro 'pgd_offset'
    #define pgd_offset_k(address) pgd_offset(&init_mm, address)
                                  ^~~~~~~~~~
>> arch/microblaze/mm/consistent.c:162:38: note: in expansion of macro 'pgd_offset_k'
     return pte_offset_kernel(pmd_offset(pgd_offset_k(addr), addr), addr);
                                         ^~~~~~~~~~~~
   In file included from arch/microblaze/include/asm/pgtable.h:62:0,
                    from include/linux/mm.h:99,
                    from arch/microblaze/include/asm/uaccess.h:15,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/ptrace.h:7,
                    from arch/microblaze/mm/consistent.c:20:
   include/asm-generic/pgtable-nopmd.h:44:23: note: expected 'pud_t * {aka struct <anonymous> *}' but argument is of type 'pgd_t * {aka struct <anonymous> *}'
    static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
                          ^~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/pmd_offset +458 arch/microblaze/include/asm/pgtable.h

15902bf63c8332 Michal Simek   2009-05-26  444  
15902bf63c8332 Michal Simek   2009-05-26  445  /* Convert pmd entry to page */
15902bf63c8332 Michal Simek   2009-05-26  446  /* our pmd entry is an effective address of pte table*/
15902bf63c8332 Michal Simek   2009-05-26  447  /* returns effective address of the pmd entry*/
15902bf63c8332 Michal Simek   2009-05-26 @448  #define pmd_page_kernel(pmd)	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
15902bf63c8332 Michal Simek   2009-05-26  449  
15902bf63c8332 Michal Simek   2009-05-26  450  /* returns struct *page of the pmd entry*/
15902bf63c8332 Michal Simek   2009-05-26  451  #define pmd_page(pmd)	(pfn_to_page(__pa(pmd_val(pmd)) >> PAGE_SHIFT))
15902bf63c8332 Michal Simek   2009-05-26  452  
15902bf63c8332 Michal Simek   2009-05-26  453  /* to find an entry in a kernel page-table-directory */
15902bf63c8332 Michal Simek   2009-05-26 @454  #define pgd_offset_k(address) pgd_offset(&init_mm, address)
15902bf63c8332 Michal Simek   2009-05-26  455  
15902bf63c8332 Michal Simek   2009-05-26  456  /* to find an entry in a page-table-directory */
15902bf63c8332 Michal Simek   2009-05-26  457  #define pgd_index(address)	 ((address) >> PGDIR_SHIFT)
15902bf63c8332 Michal Simek   2009-05-26 @458  #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
15902bf63c8332 Michal Simek   2009-05-26  459  
15902bf63c8332 Michal Simek   2009-05-26  460  /* Find an entry in the third-level page table.. */
15902bf63c8332 Michal Simek   2009-05-26  461  #define pte_index(address)		\
15902bf63c8332 Michal Simek   2009-05-26  462  	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
15902bf63c8332 Michal Simek   2009-05-26  463  #define pte_offset_kernel(dir, addr)	\
15902bf63c8332 Michal Simek   2009-05-26 @464  	((pte_t *) pmd_page_kernel(*(dir)) + pte_index(addr))
15902bf63c8332 Michal Simek   2009-05-26  465  #define pte_offset_map(dir, addr)		\
ece0e2b6406a99 Peter Zijlstra 2010-10-26  466  	((pte_t *) kmap_atomic(pmd_page(*(dir))) + pte_index(addr))
15902bf63c8332 Michal Simek   2009-05-26  467  

:::::: The code at line 458 was first introduced by commit
:::::: 15902bf63c8332946e5a1f48a72e3ae22874b11b microblaze_mmu_v2: Page table - ioremap - pgtable.c/h, section update

:::::: TO: Michal Simek <monstr@monstr.eu>
:::::: CC: Michal Simek <monstr@monstr.eu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--663xtopnljfubs7d
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--663xtopnljfubs7d--
