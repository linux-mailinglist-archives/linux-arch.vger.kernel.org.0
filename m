Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8410F61C2
	for <lists+linux-arch@lfdr.de>; Sat,  9 Nov 2019 23:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfKIWkm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Nov 2019 17:40:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:44467 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfKIWkl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 9 Nov 2019 17:40:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2019 14:40:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,286,1569308400"; 
   d="gz'50?scan'50,208,50";a="201997222"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Nov 2019 14:40:24 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iTZP5-0001rn-JE; Sun, 10 Nov 2019 06:40:23 +0800
Date:   Sun, 10 Nov 2019 06:39:42 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] mm: fixmap: convert __set_fixmap_offset() to an inline
 function
Message-ID: <201911100603.rol7f1bS%lkp@intel.com>
References: <20191108124133.31751-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ym7boomnatv3sesx"
Content-Disposition: inline
In-Reply-To: <20191108124133.31751-1-yamada.masahiro@socionext.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--ym7boomnatv3sesx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mmotm/master]
[also build test WARNING on v5.4-rc6 next-20191108]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/mm-fixmap-convert-__set_fixmap_offset-to-an-inline-function/20191110-045158
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/fixmap.h:75:0,
                    from arch/powerpc/include/asm/book3s/32/pgtable.h:149,
                    from arch/powerpc/include/asm/book3s/pgtable.h:8,
                    from arch/powerpc/include/asm/pgtable.h:18,
                    from arch/powerpc/include/asm/kup.h:30,
                    from arch/powerpc/include/asm/uaccess.h:9,
                    from include/linux/uaccess.h:11,
                    from include/linux/crypto.h:21,
                    from include/crypto/hash.h:11,
                    from include/linux/uio.h:10,
                    from include/linux/socket.h:8,
                    from include/linux/compat.h:15,
                    from arch/powerpc/kernel/asm-offsets.c:14:
   include/asm-generic/fixmap.h: In function '__set_fixmap_offset':
   include/asm-generic/fixmap.h:78:2: error: implicit declaration of function '__set_fixmap'; did you mean 'set_fixmap'? [-Werror=implicit-function-declaration]
     __set_fixmap(idx, phys, flags);
     ^~~~~~~~~~~~
     set_fixmap
   In file included from arch/powerpc/include/asm/book3s/32/pgtable.h:149:0,
                    from arch/powerpc/include/asm/book3s/pgtable.h:8,
                    from arch/powerpc/include/asm/pgtable.h:18,
                    from arch/powerpc/include/asm/kup.h:30,
                    from arch/powerpc/include/asm/uaccess.h:9,
                    from include/linux/uaccess.h:11,
                    from include/linux/crypto.h:21,
                    from include/crypto/hash.h:11,
                    from include/linux/uio.h:10,
                    from include/linux/socket.h:8,
                    from include/linux/compat.h:15,
                    from arch/powerpc/kernel/asm-offsets.c:14:
   arch/powerpc/include/asm/fixmap.h: At top level:
>> arch/powerpc/include/asm/fixmap.h:77:20: warning: conflicting types for '__set_fixmap'
    static inline void __set_fixmap(enum fixed_addresses idx,
                       ^~~~~~~~~~~~
   arch/powerpc/include/asm/fixmap.h:77:20: error: static declaration of '__set_fixmap' follows non-static declaration
   In file included from arch/powerpc/include/asm/fixmap.h:75:0,
                    from arch/powerpc/include/asm/book3s/32/pgtable.h:149,
                    from arch/powerpc/include/asm/book3s/pgtable.h:8,
                    from arch/powerpc/include/asm/pgtable.h:18,
                    from arch/powerpc/include/asm/kup.h:30,
                    from arch/powerpc/include/asm/uaccess.h:9,
                    from include/linux/uaccess.h:11,
                    from include/linux/crypto.h:21,
                    from include/crypto/hash.h:11,
                    from include/linux/uio.h:10,
                    from include/linux/socket.h:8,
                    from include/linux/compat.h:15,
                    from arch/powerpc/kernel/asm-offsets.c:14:
   include/asm-generic/fixmap.h:78:2: note: previous implicit declaration of '__set_fixmap' was here
     __set_fixmap(idx, phys, flags);
     ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2
   17 real  5 user  2 sys  44.62% cpu 	make prepare

vim +/__set_fixmap +77 arch/powerpc/include/asm/fixmap.h

2c419bdeca1d95 include/asm-powerpc/fixmap.h      Kumar Gala       2008-04-23  76  
4cfac2f9c7f116 arch/powerpc/include/asm/fixmap.h Christophe Leroy 2017-08-02 @77  static inline void __set_fixmap(enum fixed_addresses idx,
4cfac2f9c7f116 arch/powerpc/include/asm/fixmap.h Christophe Leroy 2017-08-02  78  				phys_addr_t phys, pgprot_t flags)
4cfac2f9c7f116 arch/powerpc/include/asm/fixmap.h Christophe Leroy 2017-08-02  79  {
c766ee72235d09 arch/powerpc/include/asm/fixmap.h Christophe Leroy 2018-10-09  80  	map_kernel_page(fix_to_virt(idx), phys, flags);
4cfac2f9c7f116 arch/powerpc/include/asm/fixmap.h Christophe Leroy 2017-08-02  81  }
4cfac2f9c7f116 arch/powerpc/include/asm/fixmap.h Christophe Leroy 2017-08-02  82  

:::::: The code at line 77 was first introduced by commit
:::::: 4cfac2f9c7f116af8516d0b3d0e7383189eca376 powerpc/mm: Simplify __set_fixmap()

:::::: TO: Christophe Leroy <christophe.leroy@c-s.fr>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--ym7boomnatv3sesx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
d33tx4NsM4sqH6j4SdGeWgAA

--ym7boomnatv3sesx--
