Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A9B6FDF84
	for <lists+linux-arch@lfdr.de>; Wed, 10 May 2023 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbjEJOEN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 May 2023 10:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbjEJOEL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 May 2023 10:04:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C3310E5;
        Wed, 10 May 2023 07:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683727448; x=1715263448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Weuc/6wmFMlzgZQqjXSqsrKdE93+EcAW+jgAmHsBAc4=;
  b=Ixho5MbDlAFV8ZJNP/LQtQbDmfDHnNKj9b3tt0DmiDPNAy388dqYzxN4
   5H7WLVCzF3+WtCROsO26l3DnJaMiOQwK+Md2QIfMzXncJGUr9ekl/AB4u
   fL/0A/+S3ZwLtHbQNYzXzPvRhkzD2tm5UX1C3RYpL22AwDhi1c33np9FD
   5YQJIjSeVXdSZfkyuRGyN0h/joCa67MZCiGwYkwF8mIUNln3nKC62w9BI
   aV+pvditBZuUpV6zIEZQS9YIV0xQkLDaXxRm1gk6iQaUKIVG1J3ZyLnFk
   8aadsogDlRbvSlIMpmD9ydAUjgkHUgIP86XSJVuoZM7pGXY+P1gOug2TY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="350253422"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="350253422"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 07:03:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="768924681"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="768924681"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 May 2023 07:03:33 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwkPk-0003Li-2b;
        Wed, 10 May 2023 14:03:32 +0000
Date:   Wed, 10 May 2023 22:03:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        geert@linux-m68k.org, javierm@redhat.com, daniel@ffwll.ch,
        vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        davem@davemloft.net, James.Bottomley@hansenpartnership.com,
        arnd@arndb.de, sam@ravnborg.org, suijingfeng@loongson.cn
Cc:     oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 5/6] fbdev: Move framebuffer I/O helpers into
 <asm/fb.h>
Message-ID: <202305102136.eMjTSPwH-lkp@intel.com>
References: <20230510110557.14343-6-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510110557.14343-6-tzimmermann@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[cannot apply to deller-parisc/for-next arnd-asm-generic/master linus/master davem-sparc/master v6.4-rc1 next-20230510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/fbdev-matrox-Remove-trailing-whitespaces/20230510-190752
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230510110557.14343-6-tzimmermann%40suse.de
patch subject: [PATCH v6 5/6] fbdev: Move framebuffer I/O helpers into <asm/fb.h>
config: sh-randconfig-r024-20230509 (https://download.01.org/0day-ci/archive/20230510/202305102136.eMjTSPwH-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/46cc7edd7f28cc167c5b38d0e4f0aa8c3ac67328
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Thomas-Zimmermann/fbdev-matrox-Remove-trailing-whitespaces/20230510-190752
        git checkout 46cc7edd7f28cc167c5b38d0e4f0aa8c3ac67328
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/video/fbdev/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305102136.eMjTSPwH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   cc1: warning: arch/sh/include/mach-hp6xx: No such file or directory [-Wmissing-include-dirs]
   cc1: warning: arch/sh/include/mach-hp6xx: No such file or directory [-Wmissing-include-dirs]
   In file included from drivers/video/fbdev/hitfb.c:27:
   drivers/video/fbdev/hitfb.c: In function 'hitfb_accel_wait':
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 1 of 'fb_readw' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:93:33: note: in expansion of macro 'HD64461_IO_OFFSET'
      93 | #define HD64461_GRCFGR          HD64461_IO_OFFSET(0x1044)       /* Accelerator Configuration Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:47:25: note: in expansion of macro 'HD64461_GRCFGR'
      47 |         while (fb_readw(HD64461_GRCFGR) & HD64461_GRCFGR_ACCSTATUS) ;
         |                         ^~~~~~~~~~~~~~
   In file included from arch/sh/include/asm/fb.h:5,
                    from include/linux/fb.h:19,
                    from drivers/video/fbdev/hitfb.c:22:
   include/asm-generic/fb.h:52:57: note: expected 'const volatile void *' but argument is of type 'unsigned int'
      52 | static inline u16 fb_readw(const volatile void __iomem *addr)
         |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/video/fbdev/hitfb.c: In function 'hitfb_accel_start':
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:93:33: note: in expansion of macro 'HD64461_IO_OFFSET'
      93 | #define HD64461_GRCFGR          HD64461_IO_OFFSET(0x1044)       /* Accelerator Configuration Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:53:30: note: in expansion of macro 'HD64461_GRCFGR'
      53 |                 fb_writew(6, HD64461_GRCFGR);
         |                              ^~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:93:33: note: in expansion of macro 'HD64461_IO_OFFSET'
      93 | #define HD64461_GRCFGR          HD64461_IO_OFFSET(0x1044)       /* Accelerator Configuration Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:55:30: note: in expansion of macro 'HD64461_GRCFGR'
      55 |                 fb_writew(7, HD64461_GRCFGR);
         |                              ^~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/video/fbdev/hitfb.c: In function 'hitfb_accel_set_dest':
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:116:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     116 | #define HD64461_BBTDWR          HD64461_IO_OFFSET(0x105c)       /* Destination Block Width Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:66:28: note: in expansion of macro 'HD64461_BBTDWR'
      66 |         fb_writew(width-1, HD64461_BBTDWR);
         |                            ^~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:117:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     117 | #define HD64461_BBTDHR          HD64461_IO_OFFSET(0x105e)       /* Destination Block Height Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:67:29: note: in expansion of macro 'HD64461_BBTDHR'
      67 |         fb_writew(height-1, HD64461_BBTDHR);
         |                             ^~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:115:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     115 | #define HD64461_BBTDSARL        HD64461_IO_OFFSET(0x105a)       /* Destination Start Address Register (L) */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:69:35: note: in expansion of macro 'HD64461_BBTDSARL'
      69 |         fb_writew(saddr & 0xffff, HD64461_BBTDSARL);
         |                                   ^~~~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:114:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     114 | #define HD64461_BBTDSARH        HD64461_IO_OFFSET(0x1058)       /* Destination Start Address Register (H) */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:70:32: note: in expansion of macro 'HD64461_BBTDSARH'
      70 |         fb_writew(saddr >> 16, HD64461_BBTDSARH);
         |                                ^~~~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/video/fbdev/hitfb.c: In function 'hitfb_accel_bitblt':
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:122:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     122 | #define HD64461_BBTROPR         HD64461_IO_OFFSET(0x1068)       /* ROP Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:83:24: note: in expansion of macro 'HD64461_BBTROPR'
      83 |         fb_writew(rop, HD64461_BBTROPR);
         |                        ^~~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:123:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     123 | #define HD64461_BBTMDR          HD64461_IO_OFFSET(0x106a)       /* BitBLT Mode Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:94:49: note: in expansion of macro 'HD64461_BBTMDR'
      94 |                         fb_writew((1 << 5) | 1, HD64461_BBTMDR);
         |                                                 ^~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:123:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     123 | #define HD64461_BBTMDR          HD64461_IO_OFFSET(0x106a)       /* BitBLT Mode Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:96:38: note: in expansion of macro 'HD64461_BBTMDR'
      96 |                         fb_writew(1, HD64461_BBTMDR);
         |                                      ^~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:123:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     123 | #define HD64461_BBTMDR          HD64461_IO_OFFSET(0x106a)       /* BitBLT Mode Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:101:45: note: in expansion of macro 'HD64461_BBTMDR'
     101 |                         fb_writew((1 << 5), HD64461_BBTMDR);
         |                                             ^~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:123:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     123 | #define HD64461_BBTMDR          HD64461_IO_OFFSET(0x106a)       /* BitBLT Mode Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:103:38: note: in expansion of macro 'HD64461_BBTMDR'
     103 |                         fb_writew(0, HD64461_BBTMDR);
         |                                      ^~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:116:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     116 | #define HD64461_BBTDWR          HD64461_IO_OFFSET(0x105c)       /* Destination Block Width Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:110:26: note: in expansion of macro 'HD64461_BBTDWR'
     110 |         fb_writew(width, HD64461_BBTDWR);
         |                          ^~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:117:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     117 | #define HD64461_BBTDHR          HD64461_IO_OFFSET(0x105e)       /* Destination Block Height Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:111:27: note: in expansion of macro 'HD64461_BBTDHR'
     111 |         fb_writew(height, HD64461_BBTDHR);
         |                           ^~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:113:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     113 | #define HD64461_BBTSSARL        HD64461_IO_OFFSET(0x1056)       /* Source Start Address Register (L) */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:112:35: note: in expansion of macro 'HD64461_BBTSSARL'
     112 |         fb_writew(saddr & 0xffff, HD64461_BBTSSARL);
         |                                   ^~~~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:112:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     112 | #define HD64461_BBTSSARH        HD64461_IO_OFFSET(0x1054)       /* Source Start Address Register (H) */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:113:32: note: in expansion of macro 'HD64461_BBTSSARH'
     113 |         fb_writew(saddr >> 16, HD64461_BBTSSARH);
         |                                ^~~~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:115:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     115 | #define HD64461_BBTDSARL        HD64461_IO_OFFSET(0x105a)       /* Destination Start Address Register (L) */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:114:35: note: in expansion of macro 'HD64461_BBTDSARL'
     114 |         fb_writew(daddr & 0xffff, HD64461_BBTDSARL);
         |                                   ^~~~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:114:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     114 | #define HD64461_BBTDSARH        HD64461_IO_OFFSET(0x1058)       /* Destination Start Address Register (H) */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:115:32: note: in expansion of macro 'HD64461_BBTDSARH'
     115 |         fb_writew(daddr >> 16, HD64461_BBTDSARH);
         |                                ^~~~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:121:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     121 | #define HD64461_BBTMARL         HD64461_IO_OFFSET(0x1066)       /* Mask Start Address Register (L) */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:118:43: note: in expansion of macro 'HD64461_BBTMARL'
     118 |                 fb_writew(maddr & 0xffff, HD64461_BBTMARL);
         |                                           ^~~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:120:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     120 | #define HD64461_BBTMARH         HD64461_IO_OFFSET(0x1064)       /* Mask Start Address Register (H) */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:119:40: note: in expansion of macro 'HD64461_BBTMARH'
     119 |                 fb_writew(maddr >> 16, HD64461_BBTMARH);
         |                                        ^~~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/video/fbdev/hitfb.c: In function 'hitfb_fillrect':
   arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:122:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     122 | #define HD64461_BBTROPR         HD64461_IO_OFFSET(0x1068)       /* ROP Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:130:35: note: in expansion of macro 'HD64461_BBTROPR'
     130 |                 fb_writew(0x00f0, HD64461_BBTROPR);
         |                                   ^~~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:123:33: note: in expansion of macro 'HD64461_IO_OFFSET'
     123 | #define HD64461_BBTMDR          HD64461_IO_OFFSET(0x106a)       /* BitBLT Mode Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:131:31: note: in expansion of macro 'HD64461_BBTMDR'
     131 |                 fb_writew(16, HD64461_BBTMDR);
         |                               ^~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:92:33: note: in expansion of macro 'HD64461_IO_OFFSET'
      92 | #define HD64461_GRSCR           HD64461_IO_OFFSET(0x1042)       /* Solid Color Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:135:35: note: in expansion of macro 'HD64461_GRSCR'
     135 |                                   HD64461_GRSCR);
         |                                   ^~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:92:33: note: in expansion of macro 'HD64461_IO_OFFSET'
      92 | #define HD64461_GRSCR           HD64461_IO_OFFSET(0x1042)       /* Solid Color Register */
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:140:48: note: in expansion of macro 'HD64461_GRSCR'
     140 |                         fb_writew(rect->color, HD64461_GRSCR);
         |                                                ^~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/video/fbdev/hitfb.c: In function 'hitfb_pan_display':
   arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 2 of 'fb_writew' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:53:33: note: in expansion of macro 'HD64461_IO_OFFSET'
      53 | #define HD64461_LCDCBAR         HD64461_IO_OFFSET(0x1000)
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:165:56: note: in expansion of macro 'HD64461_LCDCBAR'
     165 |         fb_writew((yoffset*info->fix.line_length)>>10, HD64461_LCDCBAR);
         |                                                        ^~~~~~~~~~~~~~~
   include/asm-generic/fb.h:86:60: note: expected 'volatile void *' but argument is of type 'unsigned int'
      86 | static inline void fb_writew(u16 b, volatile void __iomem *addr)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/video/fbdev/hitfb.c: At top level:
   drivers/video/fbdev/hitfb.c:170:5: warning: no previous prototype for 'hitfb_blank' [-Wmissing-prototypes]
     170 | int hitfb_blank(int blank_mode, struct fb_info *info)
         |     ^~~~~~~~~~~
   drivers/video/fbdev/hitfb.c: In function 'hitfb_blank':
   arch/sh/include/asm/hd64461.h:18:33: warning: passing argument 1 of 'fb_readw' makes pointer from integer without a cast [-Wint-conversion]
      18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 unsigned int
   arch/sh/include/asm/hd64461.h:70:33: note: in expansion of macro 'HD64461_IO_OFFSET'
      70 | #define HD64461_LDR1            HD64461_IO_OFFSET(0x1010)
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/hitfb.c:175:30: note: in expansion of macro 'HD64461_LDR1'
     175 |                 v = fb_readw(HD64461_LDR1);


vim +/fb_readw +18 arch/sh/include/asm/hd64461.h

^1da177e4c3f41 include/asm-sh/hd64461/hd64461.h Linus Torvalds     2005-04-16  15  
be15d65d97f924 include/asm-sh/hd64461.h         Kristoffer Ericson 2007-07-12  16  /* Area 6 - Slot 0 - memory and/or IO card */
bec36eca6f5d1d arch/sh/include/asm/hd64461.h    Paul Mundt         2009-05-15  17  #define HD64461_IOBASE		0xb0000000
bec36eca6f5d1d arch/sh/include/asm/hd64461.h    Paul Mundt         2009-05-15 @18  #define HD64461_IO_OFFSET(x)	(HD64461_IOBASE + (x))
bec36eca6f5d1d arch/sh/include/asm/hd64461.h    Paul Mundt         2009-05-15  19  #define	HD64461_PCC0_BASE	HD64461_IO_OFFSET(0x8000000)
be15d65d97f924 include/asm-sh/hd64461.h         Kristoffer Ericson 2007-07-12  20  #define	HD64461_PCC0_ATTR	(HD64461_PCC0_BASE)				/* 0xb80000000 */
be15d65d97f924 include/asm-sh/hd64461.h         Kristoffer Ericson 2007-07-12  21  #define	HD64461_PCC0_COMM	(HD64461_PCC0_BASE+HD64461_PCC_WINDOW)		/* 0xb90000000 */
be15d65d97f924 include/asm-sh/hd64461.h         Kristoffer Ericson 2007-07-12  22  #define	HD64461_PCC0_IO		(HD64461_PCC0_BASE+2*HD64461_PCC_WINDOW)	/* 0xba0000000 */
^1da177e4c3f41 include/asm-sh/hd64461/hd64461.h Linus Torvalds     2005-04-16  23  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
