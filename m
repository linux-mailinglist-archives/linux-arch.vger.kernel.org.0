Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8875118546
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2019 11:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLJKjt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Dec 2019 05:39:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:4135 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfLJKjt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Dec 2019 05:39:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 02:39:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,299,1571727600"; 
   d="gz'50?scan'50,208,50";a="215395518"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Dec 2019 02:39:44 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iecvf-000GvZ-OW; Tue, 10 Dec 2019 18:39:43 +0800
Date:   Tue, 10 Dec 2019 18:39:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com, christophe.leroy@c-s.fr,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 1/4] mm: define MAX_PTRS_PER_{PTE,PMD,PUD}
Message-ID: <201912101817.oYkeqYfv%lkp@intel.com>
References: <20191210044714.27265-2-dja@axtens.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y45hzqm3hexvj6du"
Content-Disposition: inline
In-Reply-To: <20191210044714.27265-2-dja@axtens.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--y45hzqm3hexvj6du
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20191209]
[also build test WARNING on linus/master v5.5-rc1]
[cannot apply to powerpc/next asm-generic/master v5.4]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Daniel-Axtens/KASAN-for-powerpc64-radix-plus-generic-mm-change/20191210-171342
base:    6cf8298daad041cd15dc514d8a4f93ca3636c84e
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/pgtable_types.h:359:0,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:38,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:19,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/asm-generic/pgtable-nopud.h:22:0: warning: "MAX_PTRS_PER_PUD" redefined
    #define MAX_PTRS_PER_PUD 1
    
   In file included from arch/x86/include/asm/processor.h:20:0,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:38,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:19,
                    from arch/x86/kernel/asm-offsets.c:9:
   arch/x86/include/asm/pgtable_types.h:261:0: note: this is the location of the previous definition
    #define MAX_PTRS_PER_PUD PTRS_PER_PUD
    
   In file included from arch/x86/include/asm/pgtable_types.h:385:0,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:38,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:19,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/asm-generic/pgtable-nopmd.h:21:0: warning: "MAX_PTRS_PER_PMD" redefined
    #define MAX_PTRS_PER_PMD 1
    
   In file included from arch/x86/include/asm/processor.h:20:0,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:38,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:19,
                    from arch/x86/kernel/asm-offsets.c:9:
   arch/x86/include/asm/pgtable_types.h:262:0: note: this is the location of the previous definition
    #define MAX_PTRS_PER_PMD PTRS_PER_PMD
    
--
   In file included from arch/x86/include/asm/pgtable_types.h:359:0,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:38,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:19,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/asm-generic/pgtable-nopud.h:22:0: warning: "MAX_PTRS_PER_PUD" redefined
    #define MAX_PTRS_PER_PUD 1
    
   In file included from arch/x86/include/asm/processor.h:20:0,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:38,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:19,
                    from arch/x86/kernel/asm-offsets.c:9:
   arch/x86/include/asm/pgtable_types.h:261:0: note: this is the location of the previous definition
    #define MAX_PTRS_PER_PUD PTRS_PER_PUD
    
   In file included from arch/x86/include/asm/pgtable_types.h:385:0,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:38,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:19,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/asm-generic/pgtable-nopmd.h:21:0: warning: "MAX_PTRS_PER_PMD" redefined
    #define MAX_PTRS_PER_PMD 1
    
   In file included from arch/x86/include/asm/processor.h:20:0,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:38,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:19,
                    from arch/x86/kernel/asm-offsets.c:9:
   arch/x86/include/asm/pgtable_types.h:262:0: note: this is the location of the previous definition
    #define MAX_PTRS_PER_PMD PTRS_PER_PMD
    
   5 real  3 user  2 sys  114.30% cpu 	make prepare

vim +/MAX_PTRS_PER_PUD +22 include/asm-generic/pgtable-nopud.h

    20	
    21	#define PUD_SHIFT		P4D_SHIFT
  > 22	#define MAX_PTRS_PER_PUD	1
    23	#define PTRS_PER_PUD		1
    24	#define PUD_SIZE  		(1UL << PUD_SHIFT)
    25	#define PUD_MASK  		(~(PUD_SIZE-1))
    26	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--y45hzqm3hexvj6du
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
y1Bccv8BpMVjgnxpAAA=

--y45hzqm3hexvj6du--
