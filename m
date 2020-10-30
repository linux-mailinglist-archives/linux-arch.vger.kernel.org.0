Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132152A0C1A
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 18:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgJ3RJC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 13:09:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:13811 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgJ3RJB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 13:09:01 -0400
IronPort-SDR: bWTmw4Efsl5sFzG3jdd1RNUC/yWDFefshp4ifXGR761b9ZQaKPZuMC6w1dQoiL0wQYtkXOsf4P
 NoyO799ES/Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="186447335"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="186447335"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 10:09:01 -0700
IronPort-SDR: i0Y6wd8dTGLXXQKn4+vOxH23rosXZ3J0hO6vfehpHsPhG1q1gevDZRviG4OU2I3QdZ0mKP0ERn
 D5wqBCs/fILg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="304992077"
Received: from lkp-server02.sh.intel.com (HELO fcc9f8859912) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 30 Oct 2020 10:08:59 -0700
Received: from kbuild by fcc9f8859912 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYXta-0000Dy-S6; Fri, 30 Oct 2020 17:08:58 +0000
Date:   Sat, 31 Oct 2020 01:08:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-arch@vger.kernel.org
Subject: [asm-generic:asm-generic-timers 1/15] arch/arm/Kconfig:271: syntax
 error
Message-ID: <202010310100.VJcGP2Sk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-timers
head:   9e49c5debd62585e5b2097a625d18425d6ce513b
commit: 3621395d9bdc98541ffb77efdf99330a998988cd [1/15] ARM: remove ebsa110 platform
config: arm-randconfig-r036-20201030
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project fa5a13276764a2657b3571fa3c57b07ee5d2d661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=3621395d9bdc98541ffb77efdf99330a998988cd
        git remote add asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
        git fetch --no-tags asm-generic asm-generic-timers
        git checkout 3621395d9bdc98541ffb77efdf99330a998988cd
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm  randconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm/Kconfig:271: syntax error
   arch/arm/Kconfig:270: invalid statement
   arch/arm/Kconfig:271: invalid statement
   arch/arm/Kconfig:272: invalid statement
   arch/arm/Kconfig:273: invalid statement
   arch/arm/Kconfig:274: invalid statement
   arch/arm/Kconfig:275: unknown statement "Please"
   arch/arm/Kconfig:276:warning: ignoring unsupported character '.'
   arch/arm/Kconfig:276: unknown statement "location"
   make[2]: *** [scripts/kconfig/Makefile:71: oldconfig] Error 1
   make[1]: *** [Makefile:604: oldconfig] Error 2
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
>> arch/arm/Kconfig:271: syntax error
   arch/arm/Kconfig:270: invalid statement
   arch/arm/Kconfig:271: invalid statement
   arch/arm/Kconfig:272: invalid statement
   arch/arm/Kconfig:273: invalid statement
   arch/arm/Kconfig:274: invalid statement
   arch/arm/Kconfig:275: unknown statement "Please"
   arch/arm/Kconfig:276:warning: ignoring unsupported character '.'
   arch/arm/Kconfig:276: unknown statement "location"
   make[2]: *** [scripts/kconfig/Makefile:71: olddefconfig] Error 1
   make[1]: *** [Makefile:604: olddefconfig] Error 2
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.

vim +271 arch/arm/Kconfig

60460abffc71523 Seung-Woo Kim     2013-02-06  163  
75e7153abd220f1 Ralf Baechle      2007-02-09  164  config SYS_SUPPORTS_APM_EMULATION
75e7153abd220f1 Ralf Baechle      2007-02-09  165  	bool
75e7153abd220f1 Ralf Baechle      2007-02-09  166  
bc581770cfdd8c1 Linus Walleij     2009-09-15  167  config HAVE_TCM
bc581770cfdd8c1 Linus Walleij     2009-09-15  168  	bool
bc581770cfdd8c1 Linus Walleij     2009-09-15  169  	select GENERIC_ALLOCATOR
bc581770cfdd8c1 Linus Walleij     2009-09-15  170  
e119bfff1f102f8 Russell King      2010-01-10  171  config HAVE_PROC_CPU
e119bfff1f102f8 Russell King      2010-01-10  172  	bool
e119bfff1f102f8 Russell King      2010-01-10  173  
ce816fa88cca083 Uwe Kleine-König  2014-04-07  174  config NO_IOPORT_MAP
5ea817699400348 Al Viro           2007-02-11  175  	bool
5ea817699400348 Al Viro           2007-02-11  176  
^1da177e4c3f415 Linus Torvalds    2005-04-16  177  config SBUS
^1da177e4c3f415 Linus Torvalds    2005-04-16  178  	bool
^1da177e4c3f415 Linus Torvalds    2005-04-16  179  
f16fb1ecc5a1cb2 Russell King      2007-04-28  180  config STACKTRACE_SUPPORT
f16fb1ecc5a1cb2 Russell King      2007-04-28  181  	bool
f16fb1ecc5a1cb2 Russell King      2007-04-28  182  	default y
f16fb1ecc5a1cb2 Russell King      2007-04-28  183  
f16fb1ecc5a1cb2 Russell King      2007-04-28  184  config LOCKDEP_SUPPORT
f16fb1ecc5a1cb2 Russell King      2007-04-28  185  	bool
f16fb1ecc5a1cb2 Russell King      2007-04-28  186  	default y
f16fb1ecc5a1cb2 Russell King      2007-04-28  187  
7ad1bcb25c5623f Russell King      2006-08-27  188  config TRACE_IRQFLAGS_SUPPORT
7ad1bcb25c5623f Russell King      2006-08-27  189  	bool
cb1293e2f594558 Arnd Bergmann     2015-05-26  190  	default !CPU_V7M
7ad1bcb25c5623f Russell King      2006-08-27  191  
f0d1b0b30d250a0 David Howells     2006-12-08  192  config ARCH_HAS_ILOG2_U32
f0d1b0b30d250a0 David Howells     2006-12-08  193  	bool
f0d1b0b30d250a0 David Howells     2006-12-08  194  
f0d1b0b30d250a0 David Howells     2006-12-08  195  config ARCH_HAS_ILOG2_U64
f0d1b0b30d250a0 David Howells     2006-12-08  196  	bool
f0d1b0b30d250a0 David Howells     2006-12-08  197  
4a1b573346ee0d6 Eduardo Valentin  2013-06-13  198  config ARCH_HAS_BANDGAP
4a1b573346ee0d6 Eduardo Valentin  2013-06-13  199  	bool
4a1b573346ee0d6 Eduardo Valentin  2013-06-13  200  
a5f4c561b3b19a9 Stefan Agner      2015-08-13  201  config FIX_EARLYCON_MEM
a5f4c561b3b19a9 Stefan Agner      2015-08-13  202  	def_bool y if MMU
a5f4c561b3b19a9 Stefan Agner      2015-08-13  203  
b89c3b165fbec60 Akinobu Mita      2006-03-26  204  config GENERIC_HWEIGHT
b89c3b165fbec60 Akinobu Mita      2006-03-26  205  	bool
b89c3b165fbec60 Akinobu Mita      2006-03-26  206  	default y
b89c3b165fbec60 Akinobu Mita      2006-03-26  207  
^1da177e4c3f415 Linus Torvalds    2005-04-16  208  config GENERIC_CALIBRATE_DELAY
^1da177e4c3f415 Linus Torvalds    2005-04-16  209  	bool
^1da177e4c3f415 Linus Torvalds    2005-04-16  210  	default y
^1da177e4c3f415 Linus Torvalds    2005-04-16  211  
a08b6b7968e7a6a Al Viro           2005-09-06  212  config ARCH_MAY_HAVE_PC_FDC
a08b6b7968e7a6a Al Viro           2005-09-06  213  	bool
a08b6b7968e7a6a Al Viro           2005-09-06  214  
5ac6da669e2476d Christoph Lameter 2007-02-10  215  config ZONE_DMA
5ac6da669e2476d Christoph Lameter 2007-02-10  216  	bool
5ac6da669e2476d Christoph Lameter 2007-02-10  217  
c7edc9e326d53ca David A. Long     2014-03-07  218  config ARCH_SUPPORTS_UPROBES
c7edc9e326d53ca David A. Long     2014-03-07  219  	def_bool y
c7edc9e326d53ca David A. Long     2014-03-07  220  
58af4a244fa9f7e Rob Herring       2012-03-20  221  config ARCH_HAS_DMA_SET_COHERENT_MASK
58af4a244fa9f7e Rob Herring       2012-03-20  222  	bool
58af4a244fa9f7e Rob Herring       2012-03-20  223  
^1da177e4c3f415 Linus Torvalds    2005-04-16  224  config GENERIC_ISA_DMA
^1da177e4c3f415 Linus Torvalds    2005-04-16  225  	bool
^1da177e4c3f415 Linus Torvalds    2005-04-16  226  
^1da177e4c3f415 Linus Torvalds    2005-04-16  227  config FIQ
^1da177e4c3f415 Linus Torvalds    2005-04-16  228  	bool
^1da177e4c3f415 Linus Torvalds    2005-04-16  229  
13a5045d4ee5a24 Rob Herring       2012-02-07  230  config NEED_RET_TO_USER
13a5045d4ee5a24 Rob Herring       2012-02-07  231  	bool
13a5045d4ee5a24 Rob Herring       2012-02-07  232  
034d2f5af1b9766 Al Viro           2005-12-19  233  config ARCH_MTD_XIP
034d2f5af1b9766 Al Viro           2005-12-19  234  	bool
034d2f5af1b9766 Al Viro           2005-12-19  235  
dc21af99fadcfa0 Russell King      2011-01-04  236  config ARM_PATCH_PHYS_VIRT
c1becedc8871645 Russell King      2011-08-10  237  	bool "Patch physical to virtual translations at runtime" if EMBEDDED
c1becedc8871645 Russell King      2011-08-10  238  	default y
b511d75d6150892 Nicolas Pitre     2011-02-21  239  	depends on !XIP_KERNEL && MMU
dc21af99fadcfa0 Russell King      2011-01-04  240  	help
111e9a5ce66e64c Russell King      2011-05-12  241  	  Patch phys-to-virt and virt-to-phys translation functions at
111e9a5ce66e64c Russell King      2011-05-12  242  	  boot and module load time according to the position of the
111e9a5ce66e64c Russell King      2011-05-12  243  	  kernel in system memory.
dc21af99fadcfa0 Russell King      2011-01-04  244  
111e9a5ce66e64c Russell King      2011-05-12  245  	  This can only be used with non-XIP MMU kernels where the base
daece59689e76ed Nicolas Pitre     2011-08-12  246  	  of physical memory is at a 16MB boundary.
dc21af99fadcfa0 Russell King      2011-01-04  247  
c1becedc8871645 Russell King      2011-08-10  248  	  Only disable this option if you know that you do not require
c1becedc8871645 Russell King      2011-08-10  249  	  this feature (eg, building a kernel for a single machine) and
c1becedc8871645 Russell King      2011-08-10  250  	  you need to shrink the kernel to the minimal size.
dc21af99fadcfa0 Russell King      2011-01-04  251  
c334bc150524f83 Rob Herring       2012-03-04  252  config NEED_MACH_IO_H
c334bc150524f83 Rob Herring       2012-03-04  253  	bool
c334bc150524f83 Rob Herring       2012-03-04  254  	help
c334bc150524f83 Rob Herring       2012-03-04  255  	  Select this when mach/io.h is required to provide special
c334bc150524f83 Rob Herring       2012-03-04  256  	  definitions for this platform.  The need for mach/io.h should
c334bc150524f83 Rob Herring       2012-03-04  257  	  be avoided when possible.
c334bc150524f83 Rob Herring       2012-03-04  258  
0cdc8b921d68817 Nicolas Pitre     2011-09-02  259  config NEED_MACH_MEMORY_H
1b9f95f8ade9efc Nicolas Pitre     2011-07-05  260  	bool
1b9f95f8ade9efc Nicolas Pitre     2011-07-05  261  	help
0cdc8b921d68817 Nicolas Pitre     2011-09-02  262  	  Select this when mach/memory.h is required to provide special
0cdc8b921d68817 Nicolas Pitre     2011-09-02  263  	  definitions for this platform.  The need for mach/memory.h should
0cdc8b921d68817 Nicolas Pitre     2011-09-02  264  	  be avoided when possible.
1b9f95f8ade9efc Nicolas Pitre     2011-07-05  265  
1b9f95f8ade9efc Nicolas Pitre     2011-07-05  266  config PHYS_OFFSET
974c07249b06d94 Nicolas Pitre     2011-12-02  267  	hex "Physical address of main memory" if MMU
c6f54a9b3962609 Uwe Kleine-König  2014-07-23  268  	depends on !ARM_PATCH_PHYS_VIRT
974c07249b06d94 Nicolas Pitre     2011-12-02  269  	default DRAM_BASE if !MMU
3621395d9bdc985 Arnd Bergmann     2020-09-24  270  	default 0x00000000 ARCH_FOOTBRIDGE
c6f54a9b3962609 Uwe Kleine-König  2014-07-23 @271  	default 0x10000000 if ARCH_OMAP1 || ARCH_RPC
c6f54a9b3962609 Uwe Kleine-König  2014-07-23  272  	default 0x20000000 if ARCH_S5PV210
b8824c9a54bb380 H Hartley Sweeten 2015-06-15  273  	default 0xc0000000 if ARCH_SA1100
111e9a5ce66e64c Russell King      2011-05-12  274  	help
1b9f95f8ade9efc Nicolas Pitre     2011-07-05  275  	  Please provide the physical address corresponding to the
1b9f95f8ade9efc Nicolas Pitre     2011-07-05  276  	  location of main memory in your system.
cada3c0841e1dea Russell King      2011-01-04  277  

:::::: The code at line 271 was first introduced by commit
:::::: c6f54a9b39626090c934646f7d732e31b70ffce7 ARM: 8113/1: remove remaining definitions of PLAT_PHYS_OFFSET from <mach/memory.h>

:::::: TO: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
