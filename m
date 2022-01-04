Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D736484431
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 16:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiADPGE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 10:06:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:52556 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233314AbiADPGE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Jan 2022 10:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641308764; x=1672844764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cGWYNxU7BuJESat3SiSLHAA1ihw43MeTB0P3aR0urlc=;
  b=TwRY5eAT0XbBaSHk1GjOFl/rNPCBG2CXWuwkF7BWfI+QAOJPeOrM4Oot
   kgBmd2KmJW3oBXTxxYEX0MmL7b3P2DSkCuYw3lPHKWbV2QJkMafaME3Qn
   nOPIBheMUlip7nC8RNpFLNlqjCSxER4CQHhnRc0UlIODmwre99gizTy7P
   2dSrbsyNewXT4fBdfxMOan57mIBp9rNxOVifLtQNrEtFbtC6EbTOIiygT
   KzHJjtQ7hMmwpkATY14Nym0GGzO5rS+GSgr/Ij+W0c5IMQ8MXC95cYK58
   eu6/dFMVTPbHuw7b4QyaW3QMLUeunol0y87gmhDjEAyhTnxa5YqMMUpot
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222229706"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="222229706"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 07:05:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="762846629"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jan 2022 07:05:55 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4lNq-000FVh-DS; Tue, 04 Jan 2022 15:05:54 +0000
Date:   Tue, 4 Jan 2022 23:05:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] headers/deps: dcache: Move the ____cacheline_aligned
 attribute to the head of the definition
Message-ID: <202201042231.vdt1cNrS-lkp@intel.com>
References: <YdQpSigW9X224obC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdQpSigW9X224obC@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Ingo,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.16-rc8 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ingo-Molnar/headers-deps-dcache-Move-the-____cacheline_aligned-attribute-to-the-head-of-the-definition/20220104-190351
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c9e6606c7fe92b50a02ce51dda82586ebdf99b48
config: arm64-buildonly-randconfig-r004-20220104 (https://download.01.org/0day-ci/archive/20220104/202201042231.vdt1cNrS-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b50fea47b6c454581fce89af359f3afe5154986c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/a9357af49d3cae2b1b4b8bbb7f1adf9ed381bf46
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ingo-Molnar/headers-deps-dcache-Move-the-____cacheline_aligned-attribute-to-the-head-of-the-definition/20220104-190351
        git checkout a9357af49d3cae2b1b4b8bbb7f1adf9ed381bf46
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/phy/amlogic/ lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm64/kernel/asm-offsets.c:10:
   In file included from include/linux/arm_sdei.h:8:
   In file included from include/acpi/ghes.h:5:
   In file included from include/acpi/apei.h:9:
   In file included from include/linux/acpi.h:15:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:8:
>> include/linux/dcache.h:137:1: warning: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Wignored-attributes]
   ____cacheline_aligned
   ^
   include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
   #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
                                                ^
   1 warning generated.
--
   In file included from drivers/phy/amlogic/phy-meson-g12a-usb2.c:16:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:8:
>> include/linux/dcache.h:137:1: warning: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Wignored-attributes]
   ____cacheline_aligned
   ^
   include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
   #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
                                                ^
   drivers/phy/amlogic/phy-meson-g12a-usb2.c:311:17: warning: cast to smaller integer type 'enum meson_soc_id' from 'const void *' [-Wvoid-pointer-to-enum-cast]
           priv->soc_id = (enum meson_soc_id)of_device_get_match_data(&pdev->dev);
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.
--
   In file included from lib/radix-tree.c:15:
   In file included from include/linux/cpu.h:17:
   In file included from include/linux/node.h:18:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:8:
>> include/linux/dcache.h:137:1: warning: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Wignored-attributes]
   ____cacheline_aligned
   ^
   include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
   #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
                                                ^
   lib/radix-tree.c:288:6: warning: no previous prototype for function 'radix_tree_node_rcu_free' [-Wmissing-prototypes]
   void radix_tree_node_rcu_free(struct rcu_head *head)
        ^
   lib/radix-tree.c:288:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void radix_tree_node_rcu_free(struct rcu_head *head)
   ^
   static 
   2 warnings generated.
--
   In file included from lib/test_bitops.c:9:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:8:
>> include/linux/dcache.h:137:1: error: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Werror,-Wignored-attributes]
   ____cacheline_aligned
   ^
   include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
   #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
                                                ^
   1 error generated.
--
   In file included from lib/test_ida.c:10:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:8:
>> include/linux/dcache.h:137:1: warning: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Wignored-attributes]
   ____cacheline_aligned
   ^
   include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
   #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
                                                ^
   lib/test_ida.c:16:6: warning: no previous prototype for function 'ida_dump' [-Wmissing-prototypes]
   void ida_dump(struct ida *ida) { }
        ^
   lib/test_ida.c:16:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void ida_dump(struct ida *ida) { }
   ^
   static 
   2 warnings generated.
--
   In file included from lib/test_printf.c:10:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:8:
>> include/linux/dcache.h:137:1: warning: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Wignored-attributes]
   ____cacheline_aligned
   ^
   include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
   #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
                                                ^
   lib/test_printf.c:157:52: warning: format specifies type 'unsigned char' but the argument has type 'int' [-Wformat]
           test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
                                  ~~~~                       ^
                                  %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:157:55: warning: format specifies type 'unsigned char' but the argument has type 'int' [-Wformat]
           test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
                                       ~~~~                     ^
                                       %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:157:58: warning: format specifies type 'unsigned char' but the argument has type 'int' [-Wformat]
           test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
                                            ~~~~                   ^~~
                                            %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:157:63: warning: format specifies type 'unsigned char' but the argument has type 'int' [-Wformat]
           test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
                                                 ~~~~                   ^~~
                                                 %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:157:68: warning: format specifies type 'unsigned char' but the argument has type 'int' [-Wformat]
           test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
                                                      ~~~~                   ^~
                                                      %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:158:52: warning: format specifies type 'char' but the argument has type 'int' [-Wformat]
           test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
                                  ~~~~                       ^
                                  %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:158:55: warning: format specifies type 'char' but the argument has type 'int' [-Wformat]
           test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
                                       ~~~~                     ^
                                       %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:158:58: warning: format specifies type 'char' but the argument has type 'int' [-Wformat]
           test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
                                            ~~~~                   ^~~
                                            %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:158:63: warning: format specifies type 'char' but the argument has type 'int' [-Wformat]
           test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
                                                 ~~~~                   ^~~
                                                 %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:158:68: warning: format specifies type 'char' but the argument has type 'int' [-Wformat]
           test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
                                                      ~~~~                   ^~
                                                      %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:159:41: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
           test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
                                     ~~~          ^~~~
                                     %o
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:159:47: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
           test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
                                        ~~~             ^~~~
                                        %o
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:159:53: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
           test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
                                           ~~~~               ^~~~~~
                                           %#o
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   14 warnings generated.
--
   In file included from lib/crc32test.c:28:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:8:
>> include/linux/dcache.h:137:1: warning: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Wignored-attributes]
   ____cacheline_aligned
   ^
   include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
   #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
                                                ^
   lib/crc32test.c:674:13: warning: variable 'crc' set but not used [-Wunused-but-set-variable]
           static u32 crc;
                      ^
   lib/crc32test.c:754:13: warning: variable 'crc' set but not used [-Wunused-but-set-variable]
           static u32 crc;
                      ^
   3 warnings generated.
--
   In file included from lib/test_rhashtable.c:17:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:8:
>> include/linux/dcache.h:137:1: warning: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Wignored-attributes]
   ____cacheline_aligned
   ^
   include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
   #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
                                                ^
   lib/test_rhashtable.c:451:18: warning: variable 'insert_retries' set but not used [-Wunused-but-set-variable]
           unsigned int i, insert_retries = 0;
                           ^
   2 warnings generated.
--
   In file included from lib/devmem_is_allowed.c:11:
   In file included from include/linux/mm.h:717:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:8:
>> include/linux/dcache.h:137:1: warning: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Wignored-attributes]
   ____cacheline_aligned
   ^
   include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
   #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
                                                ^
   lib/devmem_is_allowed.c:20:5: warning: no previous prototype for function 'devmem_is_allowed' [-Wmissing-prototypes]
   int devmem_is_allowed(unsigned long pfn)
       ^
   lib/devmem_is_allowed.c:20:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int devmem_is_allowed(unsigned long pfn)
   ^
   static 
   2 warnings generated.
--
   In file included from lib/lz4/lz4_decompress.c:39:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:8:
>> include/linux/dcache.h:137:1: warning: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Wignored-attributes]
   ____cacheline_aligned
   ^
   include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
   #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
                                                ^
   lib/lz4/lz4_decompress.c:506:5: warning: no previous prototype for function 'LZ4_decompress_safe_forceExtDict' [-Wmissing-prototypes]
   int LZ4_decompress_safe_forceExtDict(const char *source, char *dest,
       ^
   lib/lz4/lz4_decompress.c:506:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int LZ4_decompress_safe_forceExtDict(const char *source, char *dest,
   ^
   static 
   2 warnings generated.
--
   In file included from arch/arm64/kernel/asm-offsets.c:10:
   In file included from include/linux/arm_sdei.h:8:
   In file included from include/acpi/ghes.h:5:
   In file included from include/acpi/apei.h:9:
   In file included from include/linux/acpi.h:15:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:8:
>> include/linux/dcache.h:137:1: warning: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Wignored-attributes]
   ____cacheline_aligned
   ^
   include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
   #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
                                                ^
   1 warning generated.
   arch/arm64/kernel/vdso/vgettimeofday.c:9:5: warning: no previous prototype for function '__kernel_clock_gettime' [-Wmissing-prototypes]
   int __kernel_clock_gettime(clockid_t clock,
       ^
   arch/arm64/kernel/vdso/vgettimeofday.c:9:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __kernel_clock_gettime(clockid_t clock,
   ^
   static 
   arch/arm64/kernel/vdso/vgettimeofday.c:15:5: warning: no previous prototype for function '__kernel_gettimeofday' [-Wmissing-prototypes]
   int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
       ^
   arch/arm64/kernel/vdso/vgettimeofday.c:15:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
   ^
   static 
   arch/arm64/kernel/vdso/vgettimeofday.c:21:5: warning: no previous prototype for function '__kernel_clock_getres' [-Wmissing-prototypes]
   int __kernel_clock_getres(clockid_t clock_id,
       ^
   arch/arm64/kernel/vdso/vgettimeofday.c:21:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __kernel_clock_getres(clockid_t clock_id,
   ^
   static 
   3 warnings generated.


vim +137 include/linux/dcache.h

   136	
 > 137	____cacheline_aligned
   138	struct dentry_operations {
   139		int (*d_revalidate)(struct dentry *, unsigned int);
   140		int (*d_weak_revalidate)(struct dentry *, unsigned int);
   141		int (*d_hash)(const struct dentry *, struct qstr *);
   142		int (*d_compare)(const struct dentry *,
   143				unsigned int, const char *, const struct qstr *);
   144		int (*d_delete)(const struct dentry *);
   145		int (*d_init)(struct dentry *);
   146		void (*d_release)(struct dentry *);
   147		void (*d_prune)(struct dentry *);
   148		void (*d_iput)(struct dentry *, struct inode *);
   149		char *(*d_dname)(struct dentry *, char *, int);
   150		struct vfsmount *(*d_automount)(struct path *);
   151		int (*d_manage)(const struct path *, bool);
   152		struct dentry *(*d_real)(struct dentry *, const struct inode *);
   153	};
   154	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
