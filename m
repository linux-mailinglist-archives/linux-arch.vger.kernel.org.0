Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEB86142D6
	for <lists+linux-arch@lfdr.de>; Tue,  1 Nov 2022 02:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiKABm1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Oct 2022 21:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiKABmZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Oct 2022 21:42:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44B017402;
        Mon, 31 Oct 2022 18:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667266943; x=1698802943;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4OYGu0RKdW2L34vFwgyzV4Q3BN/6r7P6a5YCMK9FnSI=;
  b=TbxqET0+S+Pp+DCxMfnzCGfvxfAfXbCViGhpQ394H98lyXUcrXi6Fy+f
   o9XZVMdG5uHveEIz9F+Jp03aDl/IP0fsE6l/41lavlP3uAdixxXKjPPwk
   FNeDAOEHSi1W/zyuhs4bMAd/LdOrX9T1HpnAwHlOkUn28XWWjpMtPU/oc
   ePavYyz/1qIGXPyWQotnVHBpbm8pB6/jIjWjdUiJKLyaEn01rsp5ibIYO
   TlHZujfsmF3oe//GHHJrrX89ocyWrGXxbXWDnAuhlFHmuQz7paIkGV1ju
   gTGQsCa18o+DyO0zc03vfOaVz4qA6cmmoGn3Q58zTDNwxH+pL8eBw7YbH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="310136106"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="310136106"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 18:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="628433612"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="628433612"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 31 Oct 2022 18:42:19 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1opgIF-000DBA-00;
        Tue, 01 Nov 2022 01:42:19 +0000
Date:   Tue, 01 Nov 2022 09:42:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     sound-open-firmware@alsa-project.org, ntfs3@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arch@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 6fbda10ec6f8d70d0f4446f861f7db726c2f2e7c
Message-ID: <6360796a.Im9eP1m6DSU/3Bdw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 6fbda10ec6f8d70d0f4446f861f7db726c2f2e7c  Add linux-next specific files for 20221031

Error/Warning reports:

https://lore.kernel.org/linux-mm/202210090954.pTR6m6rj-lkp@intel.com
https://lore.kernel.org/linux-mm/202210111318.mbUfyhps-lkp@intel.com
https://lore.kernel.org/linux-mm/202210261404.b6UlzG7H-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202210270637.Q5Y7FiKJ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202210271517.snUEnhD0-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202210290926.rwDI063c-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202210300751.rG3UDsuc-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4878: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:5044:24: warning: implicit conversion from 'enum <anonymous>' to 'enum dc_status' [-Wenum-conversion]
drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:102:9: error: implicit declaration of function 'u32p_replace_bits' [-Werror=implicit-function-declaration]
drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:127:16: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:233:23: error: implicit declaration of function 'u32_encode_bits' [-Werror=implicit-function-declaration]
include/asm-generic/div64.h:222:35: warning: comparison of distinct pointer types lacks a cast
include/asm-generic/div64.h:234:32: warning: right shift count >= width of type [-Wshift-count-overflow]
lib/test_maple_tree.c:453:12: warning: result of comparison of constant 4398046511104 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
mm/hugetlb_vmemmap.c:419:11: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
mm/hugetlb_vmemmap.c:419:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
mm/hugetlb_vmemmap.c:419:59: error: expected ')' before 'bool'
mm/hugetlb_vmemmap.c:419:60: error: unexpected type name 'bool': expected identifier
mm/hugetlb_vmemmap.c:419:66: error: expected identifier
sound/soc/sof/amd/../ops.h:309:56: error: too many arguments provided to function-like macro invocation
sound/soc/sof/amd/../ops.h:309:75: error: macro "writeb" passed 3 arguments, but takes just 2
sound/soc/sof/amd/../ops.h:336:10: error: incompatible pointer to integer conversion returning 'u8 (*)(struct snd_sof_dev *, void *)' (aka 'unsigned char (*)(struct snd_sof_dev *, void *)') from a function with result type 'u8' (aka 'unsigned char') [-Wint-conversion]
sound/soc/sof/amd/../ops.h:336:74: error: macro "readb" passed 2 arguments, but takes just 1
sound/soc/sof/imx/../ops.h:309:75: error: macro "writeb" passed 3 arguments, but takes just 2
sound/soc/sof/imx/../ops.h:336:74: error: macro "readb" passed 2 arguments, but takes just 1
sound/soc/sof/intel/../ops.h:309:75: error: macro "writeb" passed 3 arguments, but takes just 2
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

drivers/thermal/thermal_core.c:929 __thermal_cooling_device_register() warn: passing zero to 'ERR_PTR'
lib/zstd/compress/huf_compress.c:460 HUF_getIndex() warn: the 'RANK_POSITION_LOG_BUCKETS_BEGIN' macro might need parens
lib/zstd/decompress/zstd_decompress_block.c:1009 ZSTD_execSequence() warn: inconsistent indenting
lib/zstd/decompress/zstd_decompress_block.c:894 ZSTD_execSequenceEnd() warn: inconsistent indenting
lib/zstd/decompress/zstd_decompress_block.c:942 ZSTD_execSequenceEndSplitLitBuffer() warn: inconsistent indenting
lib/zstd/decompress/zstd_decompress_internal.h:206 ZSTD_DCtx_get_bmi2() warn: inconsistent indenting

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:implicit-conversion-from-enum-anonymous-to-enum-dc_status
|-- alpha-randconfig-m041-20221030
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:implicit-conversion-from-enum-anonymous-to-enum-dc_status
|   |-- drivers-thermal-thermal_core.c-__thermal_cooling_device_register()-warn:passing-zero-to-ERR_PTR
|   `-- lib-zstd-decompress-zstd_decompress_block.c-ZSTD_execSequenceEndSplitLitBuffer()-warn:inconsistent-indenting
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
|-- arc-randconfig-r043-20221030
|   |-- include-asm-generic-div64.h:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|   `-- include-asm-generic-div64.h:warning:right-shift-count-width-of-type
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
|   |-- sound-soc-sof-mediatek-mt8195-..-..-ops.h:error:macro-writeb-passed-arguments-but-takes-just
|   |-- sound-soc-sof-ops.h:error:macro-readb-passed-arguments-but-takes-just
clang_recent_errors
|-- hexagon-allmodconfig
|   `-- lib-test_maple_tree.c:warning:result-of-comparison-of-constant-with-expression-of-type-unsigned-long-is-always-false
|-- riscv-randconfig-r024-20221030
|   |-- sound-soc-sof-amd-..-ops.h:error:incompatible-pointer-to-integer-conversion-returning-u8-(-)(struct-snd_sof_dev-void-)-(aka-unsigned-char-(-)(struct-snd_sof_dev-void-)-)-from-a-function-with-result-ty
|   `-- sound-soc-sof-amd-..-ops.h:error:too-many-arguments-provided-to-function-like-macro-invocation
`-- s390-randconfig-r044-20221030
    |-- mm-hugetlb_vmemmap.c:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
    |-- mm-hugetlb_vmemmap.c:error:expected-identifier
    |-- mm-hugetlb_vmemmap.c:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
    `-- mm-hugetlb_vmemmap.c:error:unexpected-type-name-bool:expected-identifier

elapsed time: 1039m

configs tested: 85
configs skipped: 3

gcc tested configs:
arm                                 defconfig
um                           x86_64_defconfig
arm                              allyesconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64               randconfig-a014-20221031
x86_64               randconfig-a012-20221031
x86_64               randconfig-a011-20221031
x86_64               randconfig-a013-20221031
i386                 randconfig-a011-20221031
x86_64               randconfig-a016-20221031
i386                 randconfig-a012-20221031
x86_64               randconfig-a015-20221031
x86_64                               rhel-8.3
m68k                             allmodconfig
powerpc                           allnoconfig
arc                              allyesconfig
x86_64                           allyesconfig
i386                 randconfig-a013-20221031
arm                     eseries_pxa_defconfig
powerpc                          allmodconfig
ia64                             allmodconfig
i386                 randconfig-a015-20221031
alpha                            allyesconfig
m68k                             allyesconfig
arc                      axs103_smp_defconfig
sh                               allmodconfig
i386                 randconfig-a014-20221031
x86_64                           rhel-8.3-syz
i386                             allyesconfig
i386                 randconfig-a016-20221031
arm                           stm32_defconfig
mips                             allyesconfig
powerpc                     ep8248e_defconfig
m68k                       bvme6000_defconfig
arc                  randconfig-r043-20221031
riscv                randconfig-r042-20221031
arc                  randconfig-r043-20221030
arm                         cm_x300_defconfig
s390                 randconfig-r044-20221031
arm                        mvebu_v7_defconfig
x86_64                           rhel-8.3-kvm
m68k                            q40_defconfig
powerpc                      chrp32_defconfig
xtensa                           alldefconfig
x86_64                         rhel-8.3-kunit
loongarch                 loongson3_defconfig
openrisc                 simple_smp_defconfig
powerpc                    adder875_defconfig
sh                                  defconfig
sh                            hp6xx_defconfig
i386                          randconfig-c001
sh                           se7705_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig

clang tested configs:
i386                 randconfig-a003-20221031
i386                 randconfig-a002-20221031
i386                 randconfig-a004-20221031
i386                 randconfig-a006-20221031
i386                 randconfig-a005-20221031
i386                 randconfig-a001-20221031
hexagon              randconfig-r045-20221031
hexagon              randconfig-r041-20221030
arm                        mvebu_v5_defconfig
riscv                randconfig-r042-20221030
x86_64               randconfig-a004-20221031
s390                 randconfig-r044-20221030
x86_64               randconfig-a003-20221031
hexagon              randconfig-r041-20221031
x86_64               randconfig-a002-20221031
hexagon              randconfig-r045-20221030
x86_64               randconfig-a001-20221031
x86_64               randconfig-a006-20221031
x86_64               randconfig-a005-20221031
arm                         lpc32xx_defconfig
powerpc                       ebony_defconfig
arm                        vexpress_defconfig
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
