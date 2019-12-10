Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839EA118612
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2019 12:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfLJLU4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Dec 2019 06:20:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:62175 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfLJLUz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Dec 2019 06:20:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 03:20:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,299,1571727600"; 
   d="gz'50?scan'50,208,50";a="244811667"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Dec 2019 03:20:50 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iedZR-000HYZ-UF; Tue, 10 Dec 2019 19:20:49 +0800
Date:   Tue, 10 Dec 2019 19:20:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com, christophe.leroy@c-s.fr,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
Message-ID: <201912101903.uTvLRIgy%lkp@intel.com>
References: <20191210044714.27265-5-dja@axtens.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="g62ettbvkg3kwp6n"
Content-Disposition: inline
In-Reply-To: <20191210044714.27265-5-dja@axtens.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--g62ettbvkg3kwp6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20191209]
[also build test ERROR on linus/master v5.5-rc1]
[cannot apply to powerpc/next asm-generic/master v5.4]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Daniel-Axtens/KASAN-for-powerpc64-radix-plus-generic-mm-change/20191210-171342
base:    6cf8298daad041cd15dc514d8a4f93ca3636c84e
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:7:0,
                    from include/linux/kernel.h:15,
                    from arch/powerpc/kernel/prom.c:15:
   arch/powerpc/kernel/prom.c: In function 'early_reserve_mem':
>> include/linux/kern_levels.h:5:18: error: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type 'phys_addr_t {aka unsigned int}' [-Werror=format=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^~~~~~~~
   include/linux/printk.h:304:9: note: in expansion of macro 'KERN_ERR'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~
>> arch/powerpc/kernel/prom.c:694:4: note: in expansion of macro 'pr_err'
       pr_err("===========================================\n"
       ^~~~~~
   arch/powerpc/kernel/prom.c:697:48: note: format string is defined here
        "The actual physical memory detected is %llu MB.\n"
                                                ~~~^
                                                %u
   cc1: all warnings being treated as errors
--
   In file included from include/linux/printk.h:7:0,
                    from include/linux/kernel.h:15,
                    from arch/powerpc//kernel/prom.c:15:
   arch/powerpc//kernel/prom.c: In function 'early_reserve_mem':
>> include/linux/kern_levels.h:5:18: error: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type 'phys_addr_t {aka unsigned int}' [-Werror=format=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^~~~~~~~
   include/linux/printk.h:304:9: note: in expansion of macro 'KERN_ERR'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~
   arch/powerpc//kernel/prom.c:694:4: note: in expansion of macro 'pr_err'
       pr_err("===========================================\n"
       ^~~~~~
   arch/powerpc//kernel/prom.c:697:48: note: format string is defined here
        "The actual physical memory detected is %llu MB.\n"
                                                ~~~^
                                                %u
   cc1: all warnings being treated as errors

vim +/pr_err +694 arch/powerpc/kernel/prom.c

   675	
   676		if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_PPC_BOOK3S_64)) {
   677			kasan_memory_size =
   678				((phys_addr_t)CONFIG_PHYS_MEM_SIZE_FOR_KASAN << 20);
   679	
   680			if (top_phys_addr < kasan_memory_size) {
   681				/*
   682				 * We are doomed. Attempts to call e.g. panic() are
   683				 * likely to fail because they call out into
   684				 * instrumented code, which will almost certainly
   685				 * access memory beyond the end of physical
   686				 * memory. Hang here so that at least the NIP points
   687				 * somewhere that will help you debug it if you look at
   688				 * it in qemu.
   689				 */
   690				while (true)
   691					;
   692			} else if (top_phys_addr > kasan_memory_size) {
   693				/* print a biiiig warning in hopes people notice */
 > 694				pr_err("===========================================\n"
   695					"Physical memory exceeds compiled-in maximum!\n"
   696					"This kernel was compiled for KASAN with %u MB physical memory.\n"
   697					"The actual physical memory detected is %llu MB.\n"
   698					"Memory above the compiled limit will not be used!\n"
   699					"===========================================\n",
   700					CONFIG_PHYS_MEM_SIZE_FOR_KASAN,
   701					top_phys_addr / (1024 * 1024));
   702			}
   703	
   704			kasan_shadow_start = _ALIGN_DOWN(kasan_memory_size * 7 / 8,
   705							 PAGE_SIZE);
   706			DBG("reserving %llx -> %llx for KASAN",
   707			    kasan_shadow_start, top_phys_addr);
   708			memblock_reserve(kasan_shadow_start,
   709					 top_phys_addr - kasan_shadow_start);
   710		}
   711	}
   712	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--g62ettbvkg3kwp6n
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/kQSmnpMEcrnDaxA1fj/NY/aVLRaAAA=

--g62ettbvkg3kwp6n--
