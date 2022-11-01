Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBD66151B7
	for <lists+linux-arch@lfdr.de>; Tue,  1 Nov 2022 19:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiKASoO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Nov 2022 14:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiKASoM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Nov 2022 14:44:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74431C435;
        Tue,  1 Nov 2022 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667328250; x=1698864250;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bQSMHznVBZB4rDVU8y/w9qHpcPgIeTyy6fMjKL2pzz8=;
  b=TaUBXl6AAY8xzJixlz9Zh4USoORXfDIcOCJtQAbFwLR5swrYWEAKvmdA
   oVjUOfY/yVfPcq5sGt1eqdm7w0enflIEYlnI8iI0HrV3/ZbWoIZRQZvpc
   CBA+yio42lBQD9n4BYqDtro+CXG45AvMB+/Hib2hp9eYjMziRBgSU6oOa
   dc0dvN40YNyoBx2L1rMzX4H9MvxY0zUC5Hs7VANySiLzOv2jKA2Cq8f1X
   wRNdaKM8l/6SFa6ITF949QW/wjB5GkGjVqL4YoFi0HpruyZaHaRENnrbk
   FyeuuoWSid+0v6ZuXeuccbMSINQNTbGO5XFLxWj/9BB5SRfB3w9Z44Bi8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="289601846"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="289601846"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 11:44:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="808996415"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="808996415"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 01 Nov 2022 11:44:07 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1opwF4-000Dvo-2t;
        Tue, 01 Nov 2022 18:44:06 +0000
Date:   Wed, 02 Nov 2022 02:43:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     sound-open-firmware@alsa-project.org, linux-pm@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        kvm@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 e9d267f752f8ff62f0111cea90e3ced4fc595b4f
Message-ID: <636168d9.QfrzhK0gRCwBz/jv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: e9d267f752f8ff62f0111cea90e3ced4fc595b4f  Add linux-next specific files for 20221101

Error/Warning reports:

https://lore.kernel.org/linux-mm/202210090954.pTR6m6rj-lkp@intel.com
https://lore.kernel.org/linux-mm/202210261404.b6UlzG7H-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202210270637.Q5Y7FiKJ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202210271517.snUEnhD0-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202210290926.rwDI063c-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4878: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:5044:24: warning: implicit conversion from 'enum <anonymous>' to 'enum dc_status' [-Wenum-conversion]
drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:102:9: error: implicit declaration of function 'u32p_replace_bits' [-Werror=implicit-function-declaration]
drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:127:16: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:233:23: error: implicit declaration of function 'u32_encode_bits' [-Werror=implicit-function-declaration]
include/asm-generic/div64.h:222:35: warning: comparison of distinct pointer types lacks a cast
include/asm-generic/div64.h:234:32: warning: right shift count >= width of type [-Wshift-count-overflow]
lib/test_maple_tree.c:453:12: warning: result of comparison of constant 4398046511104 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
sound/soc/sof/amd/../ops.h:309:75: error: macro "writeb" passed 3 arguments, but takes just 2
sound/soc/sof/amd/../ops.h:336:74: error: macro "readb" passed 2 arguments, but takes just 1
sound/soc/sof/imx/../ops.h:309:75: error: macro "writeb" passed 3 arguments, but takes just 2
sound/soc/sof/imx/../ops.h:336:74: error: macro "readb" passed 2 arguments, but takes just 1
sound/soc/sof/intel/../ops.h:309:56: error: too many arguments provided to function-like macro invocation
sound/soc/sof/intel/../ops.h:309:75: error: macro "writeb" passed 3 arguments, but takes just 2
sound/soc/sof/intel/../ops.h:336:10: error: incompatible pointer to integer conversion returning 'u8 (*)(struct snd_sof_dev *, void *)' (aka 'unsigned char (*)(struct snd_sof_dev *, void *)') from a function with result type 'u8' (aka 'unsigned char') [-Wint-conversion]
sound/soc/sof/intel/../ops.h:336:74: error: macro "readb" passed 2 arguments, but takes just 1
sound/soc/sof/mediatek/../ops.h:309:75: error: macro "writeb" passed 3 arguments, but takes just 2
sound/soc/sof/mediatek/../ops.h:336:74: error: macro "readb" passed 2 arguments, but takes just 1
sound/soc/sof/mediatek/mt8186/../../ops.h:309:75: error: macro "writeb" passed 3 arguments, but takes just 2
sound/soc/sof/mediatek/mt8186/../../ops.h:336:74: error: macro "readb" passed 2 arguments, but takes just 1
sound/soc/sof/mediatek/mt8195/../../ops.h:309:75: error: macro "writeb" passed 3 arguments, but takes just 2
sound/soc/sof/mediatek/mt8195/../../ops.h:336:74: error: macro "readb" passed 2 arguments, but takes just 1
sound/soc/sof/ops.h:309:75: error: macro "writeb" passed 3 arguments, but takes just 2
sound/soc/sof/ops.h:336:74: error: macro "readb" passed 2 arguments, but takes just 1

Unverified Error/Warning (likely false positive, please contact us if interested):

arc-rimi.c:(.exit.text+0x54): undefined reference to `iounmap'
arc-rimi.c:(.init.text+0x5b6): undefined reference to `ioremap'
arc-rimi.c:(.text+0x5a): undefined reference to `ioremap'
drivers/iio/adc/at91-sama5d2_adc.c:892 at91_adc_config_emr() error: uninitialized symbol 'osr'.
drivers/thermal/thermal_core.c:929 __thermal_cooling_device_register() warn: passing zero to 'ERR_PTR'
drivers/vfio/pci/vfio_pci_core.c:958 vfio_pci_ioctl_get_region_info() warn: potential spectre issue 'pdev->resource' [w]
lib/zstd/compress/huf_compress.c:460 HUF_getIndex() warn: the 'RANK_POSITION_LOG_BUCKETS_BEGIN' macro might need parens
lib/zstd/decompress/zstd_decompress_block.c:1009 ZSTD_execSequence() warn: inconsistent indenting
lib/zstd/decompress/zstd_decompress_block.c:894 ZSTD_execSequenceEnd() warn: inconsistent indenting
lib/zstd/decompress/zstd_decompress_block.c:942 ZSTD_execSequenceEndSplitLitBuffer() warn: inconsistent indenting
lib/zstd/decompress/zstd_decompress_internal.h:206 ZSTD_DCtx_get_bmi2() warn: inconsistent indenting
s390x-linux-ld: arc-rimi.c:(.init.text+0x616): undefined reference to `iounmap'
s390x-linux-ld: arc-rimi.c:(.init.text+0x954): undefined reference to `ioremap'
s390x-linux-ld: arc-rimi.c:(.text+0xaa): undefined reference to `iounmap'
s390x-linux-ld: main.c:(.text+0x374): undefined reference to `iounmap'
s390x-linux-ld: main.c:(.text+0xf26): undefined reference to `ioremap'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:implicit-conversion-from-enum-anonymous-to-enum-dc_status
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:implicit-conversion-from-enum-anonymous-to-enum-dc_status
|   |-- include-asm-generic-div64.h:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- include-asm-generic-div64.h:warning:right-shift-count-width-of-type
|   |-- sound-soc-sof-amd-..-ops.h:error:macro-readb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-amd-..-ops.h:error:macro-writeb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-imx-..-ops.h:error:macro-readb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-imx-..-ops.h:error:macro-writeb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-intel-..-ops.h:error:macro-readb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-intel-..-ops.h:error:macro-writeb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-mediatek-..-ops.h:error:macro-readb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-mediatek-..-ops.h:error:macro-writeb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-mediatek-mt8186-..-..-ops.h:error:macro-readb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-mediatek-mt8186-..-..-ops.h:error:macro-writeb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-mediatek-mt8195-..-..-ops.h:error:macro-readb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-mediatek-mt8195-..-..-ops.h:error:macro-writeb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-ops.h:error:macro-readb-passed-arguments-but-takes-just
|   `-- sound-soc-sof-ops.h:error:macro-writeb-passed-arguments-but-takes-just
|-- arc-randconfig-m041-20221031
|   |-- drivers-thermal-thermal_core.c-__thermal_cooling_device_register()-warn:passing-zero-to-ERR_PTR
|   |-- lib-zstd-decompress-zstd_decompress_block.c-ZSTD_execSequence()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-zstd_decompress_block.c-ZSTD_execSequenceEnd()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-zstd_decompress_block.c-ZSTD_execSequenceEndSplitLitBuffer()-warn:inconsistent-indenting
|   `-- lib-zstd-decompress-zstd_decompress_internal.h-ZSTD_DCtx_get_bmi2()-warn:inconsistent-indenting
|-- arc-randconfig-r043-20221101
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:implicit-conversion-from-enum-anonymous-to-enum-dc_status
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:implicit-conversion-from-enum-anonymous-to-enum-dc_status
|   |-- drivers-pinctrl-qcom-pinctrl-lpass-lpi.c:error:implicit-declaration-of-function-FIELD_GET
|   |-- drivers-pinctrl-qcom-pinctrl-lpass-lpi.c:error:implicit-declaration-of-function-u32_encode_bits
|   |-- drivers-pinctrl-qcom-pinctrl-lpass-lpi.c:error:implicit-declaration-of-function-u32p_replace_bits
|   |-- include-asm-generic-div64.h:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   |-- include-asm-generic-div64.h:warning:right-shift-count-width-of-type
|   |-- sound-soc-sof-amd-..-ops.h:error:macro-readb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-amd-..-ops.h:error:macro-writeb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-imx-..-ops.h:error:macro-readb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-imx-..-ops.h:error:macro-writeb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-intel-..-ops.h:error:macro-readb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-intel-..-ops.h:error:macro-writeb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-mediatek-..-ops.h:error:macro-readb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-mediatek-..-ops.h:error:macro-writeb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-mediatek-mt8186-..-..-ops.h:error:macro-readb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-mediatek-mt8186-..-..-ops.h:error:macro-writeb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-mediatek-mt8195-..-..-ops.h:error:macro-readb-passed-arguments-but-takes-just
clang_recent_errors
|-- arm-randconfig-r012-20221031
|   |-- sound-soc-sof-intel-..-ops.h:error:incompatible-pointer-to-integer-conversion-returning-u8-(-)(struct-snd_sof_dev-void-)-(aka-unsigned-char-(-)(struct-snd_sof_dev-void-)-)-from-a-function-with-result-
|   `-- sound-soc-sof-intel-..-ops.h:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- hexagon-randconfig-r011-20221101
|   `-- lib-test_maple_tree.c:warning:result-of-comparison-of-constant-with-expression-of-type-unsigned-long-is-always-false
`-- s390-randconfig-r035-20221031
    |-- arc-rimi.c:(.exit.text):undefined-reference-to-iounmap
    |-- arc-rimi.c:(.init.text):undefined-reference-to-ioremap
    |-- arc-rimi.c:(.text):undefined-reference-to-ioremap
    |-- s39-linux-ld:arc-rimi.c:(.init.text):undefined-reference-to-ioremap
    |-- s39-linux-ld:arc-rimi.c:(.init.text):undefined-reference-to-iounmap
    |-- s39-linux-ld:arc-rimi.c:(.text):undefined-reference-to-iounmap
    |-- s39-linux-ld:main.c:(.text):undefined-reference-to-ioremap
    `-- s39-linux-ld:main.c:(.text):undefined-reference-to-iounmap

elapsed time: 720m

configs tested: 58
configs skipped: 2

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                              defconfig
arc                                 defconfig
x86_64                        randconfig-a015
s390                             allmodconfig
alpha                               defconfig
alpha                            allyesconfig
arc                  randconfig-r043-20221101
x86_64                               rhel-8.3
arc                              allyesconfig
x86_64                           allyesconfig
s390                                defconfig
m68k                             allyesconfig
arm                                 defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
s390                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
i386                             allyesconfig
i386                          randconfig-a014
mips                             allyesconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
sh                               allmodconfig
i386                          randconfig-a016
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
i386                 randconfig-a001-20221031
i386                 randconfig-a003-20221031
i386                 randconfig-a002-20221031
i386                 randconfig-a004-20221031
i386                 randconfig-a006-20221031
i386                 randconfig-a005-20221031
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221101
hexagon              randconfig-r045-20221101
riscv                randconfig-r042-20221101
s390                 randconfig-r044-20221101
x86_64               randconfig-a004-20221031
x86_64               randconfig-a005-20221031
x86_64               randconfig-a003-20221031
i386                          randconfig-a013
x86_64               randconfig-a002-20221031
i386                          randconfig-a011
x86_64               randconfig-a001-20221031
x86_64               randconfig-a006-20221031
i386                          randconfig-a015
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
