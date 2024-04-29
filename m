Return-Path: <linux-arch+bounces-4054-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45558B6369
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2024 22:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78361C21521
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2024 20:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416B213AD18;
	Mon, 29 Apr 2024 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buHwDQ2a"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47061411E4;
	Mon, 29 Apr 2024 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422070; cv=none; b=C7m2ZusmJ2SkVCGLjXlZ+a46eTrAZ3ZnHzPkm31mwKmtJcyrHsxDgXCl5oWnk4jqtPOhvQ8fUe7Ukjkgd1XclSj4mZIk5CGY/MA031cwwRfhZKDfvhtQTS6sK/5SeUSokgxx6M0d/bJ350l86RZFTNHnmj2oh8bTclVlP+M+Kkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422070; c=relaxed/simple;
	bh=SdNlGX/uaGpUssHcXhYpYX2njGS0K2PmBsBV1Tx5yNE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kE+hkqWf1yxBc62ju+XxUyMi6Q85MLx3Bnb6RH1o6/Xv4tHLP35XkRqA2CAvVLhkFA4JqC6uHsjnYkogfBa6RmkKNpfJc38s9eJ8KnDTqsNDI7Ns2fJVambCr6iyGwJy2ztW6M+7m3EKCyRTlYJ2evWEy+wPGyhcwXh/ziuRdds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buHwDQ2a; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714422066; x=1745958066;
  h=date:from:to:cc:subject:message-id;
  bh=SdNlGX/uaGpUssHcXhYpYX2njGS0K2PmBsBV1Tx5yNE=;
  b=buHwDQ2ahM/ivTyFaQppgJw8yell5jh2MTIqfTsI4dDnq6UL3LZHIxZT
   BYbYmcCKyvOCHWXSAFO9xDKsZh5Ba3rXBfH3anpzoEEj25K2TlqLS7c+y
   RvrGeFAE1uwova9vwHkp7UNc5QEa1yufuLcBCKHnLL1eYgj2uC+2nG7G6
   YJtWYXA88Gvqivo+tQglm8kXxHr/C0C06RD+v71MWzSMPvJH084qQN+Qk
   vFpUCsZ17+oE9WFl9gQEaIKPvzqgYUkigVSup1X+5FGJlpYRR31wy/+Bc
   eSGvjko4wfDAstKSUpWgoEBy5oI9Lgsssv/x+w7+zpXu8UOd5592KnRi0
   g==;
X-CSE-ConnectionGUID: 5zM6EM/PTtOV1RPKOQij8g==
X-CSE-MsgGUID: 6QJaTSccQIqylB4yDNdpGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="9935053"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="9935053"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 13:21:02 -0700
X-CSE-ConnectionGUID: GeqF3OiuTo+00ZH3t6pCaA==
X-CSE-MsgGUID: u2rTVXtVT/KFOjTVfkZXTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26733655"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 29 Apr 2024 13:20:58 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1XUe-0007Pw-1o;
	Mon, 29 Apr 2024 20:20:56 +0000
Date: Tue, 30 Apr 2024 04:20:01 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 b0a2c79c6f3590b74742cbbc76687014d47972d8
Message-ID: <202404300455.Iw7o5UcT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: b0a2c79c6f3590b74742cbbc76687014d47972d8  Add linux-next specific files for 20240429

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202404292222.KkVw8MVg-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202404292317.uK7gvrSc-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202404300248.dblz5vZ7-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb: syscon@43000000: 'syscon@4008', 'syscon@4018' do not match any of the regexes: '^chipid@[0-9a-f]+$', '^clock-controller@[0-9a-f]+$', '^mux-controller@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
make[4]: *** No rule to make target 'arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtb', needed by 'arch/arm64/boot/dts/ti/'.
make[4]: *** No rule to make target 'arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtb', needed by 'arch/arm64/boot/dts/ti/dtbs-list'.

Unverified Error/Warning (likely false positive, please contact us if interested):

{standard input}:2000: Error: unknown pseudo-op: `.lfe4886'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arc-allmodconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arc-allyesconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arc-randconfig-001-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-allmodconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-allyesconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm64-defconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm64-randconfig-r131-20230824
|   `-- make:No-rule-to-make-target-arch-arm64-boot-dts-ti-k3-j784s4-evm-usxgmii-exp1-exp2.dtb-needed-by-arch-arm64-boot-dts-ti-dtbs-list-.
|-- csky-allmodconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- csky-allyesconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-allmodconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-allyesconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-buildonly-randconfig-005-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-141-20240429
|   |-- drivers-gpu-drm-bridge-cadence-cdns-mhdp8546-core.c-cdns_mhdp_atomic_enable()-warn:inconsistent-returns-mhdp-link_mutex-.
|   |-- drivers-pwm-core.c-pwm_put()-warn:variable-dereferenced-before-check-pwm-(see-line-)
|   `-- drivers-usb-typec-ucsi-ucsi.c-ucsi_get_pd_caps()-warn:passing-zero-to-ERR_PTR
|-- loongarch-allmodconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- loongarch-randconfig-002-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- m68k-allmodconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- m68k-allyesconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- microblaze-allmodconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- microblaze-allyesconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- mips-allyesconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- nios2-allmodconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- nios2-allyesconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- nios2-randconfig-001-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- nios2-randconfig-002-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- openrisc-allyesconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- parisc-allmodconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- parisc-allyesconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- parisc-randconfig-002-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- powerpc-allmodconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- powerpc-randconfig-002-20240429
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-calcs-dcn_calc_auto.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-calcs-dcn_calc_math.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-calcs-dcn_calcs.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn20-dcn20_fpu.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn20-display_mode_vba_20.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn20-display_mode_vba_20v2.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn20-display_rq_dlg_calc_20.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn20-display_rq_dlg_calc_20v2.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn21-display_mode_vba_21.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn21-display_rq_dlg_calc_21.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn30-dcn30_fpu.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn30-display_mode_vba_30.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn30-display_rq_dlg_calc_30.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn301-dcn301_fpu.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn302-dcn302_fpu.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn303-dcn303_fpu.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn31-dcn31_fpu.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn31-display_mode_vba_31.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn31-display_rq_dlg_calc_31.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn314-dcn314_fpu.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn314-display_mode_vba_314.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn314-display_rq_dlg_calc_314.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn32-dcn32_fpu.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn32-display_mode_vba_32.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn32-display_mode_vba_util_32.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn32-display_rq_dlg_calc_32.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn321-dcn321_fpu.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn35-dcn35_fpu.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn351-dcn351_fpu.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dcn401-dcn401_fpu.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-display_mode_vba.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dml1_display_rq_dlg_calc.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dsc-rc_calc_fpu.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-display_mode_core.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-display_mode_util.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-dml21_translation_helper.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-dml21_utils.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_dcn4.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_dcn4_calcs.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_shared.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-floa
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_dpmm-dml2_dpmm_dcn4.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_mcg-dml2_mcg_dcn4.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_dcn3.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_dcn4.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_dcn4_fams2.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-fl
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_standalone_libraries-lib_float_math.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_top-dml_top_mcache.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml2_mall_phantom.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml2_policy.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml2_translation_helper.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml2_utils.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml2_wrapper.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   `-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml_display_rq_dlg_calc.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|-- powerpc-randconfig-r111-20240429
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_dcn4_calcs.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_shared.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_dpmm-dml2_dpmm_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_mcg-dml2_mcg_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_dcn4.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_top-dml_top_mcache.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dmub-src-dmub_dcn401.c:sparse:sparse:static-assertion-failed:DMUB-command-size-mismatch
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-calcs-dcn_calc_auto.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-calcs-dcn_calc_math.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-calcs-dcn_calcs.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn20-dcn20_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn20-display_mode_vba_20.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn20-display_mode_vba_20v2.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn20-display_rq_dlg_calc_20.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn20-display_rq_dlg_calc_20v2.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn21-display_mode_vba_21.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn21-display_rq_dlg_calc_21.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn30-dcn30_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn30-display_mode_vba_30.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn30-display_rq_dlg_calc_30.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn301-dcn301_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn302-dcn302_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn303-dcn303_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn31-dcn31_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn31-display_mode_vba_31.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn31-display_rq_dlg_calc_31.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn314-dcn314_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn314-display_mode_vba_314.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn314-display_rq_dlg_calc_314.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn32-dcn32_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn32-display_mode_vba_32.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn32-display_mode_vba_util_32.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn32-display_rq_dlg_calc_32.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn321-dcn321_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn35-dcn35_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn351-dcn351_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dcn401-dcn401_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-display_mode_vba.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dml1_display_rq_dlg_calc.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml-dsc-rc_calc_fpu.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-display_mode_core.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-display_mode_util.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-dml21_translation_helper.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-dml21_utils.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_core-dml2_core_dcn4.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_core-dml2_core_dcn4_calcs.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_core-dml2_core_shared.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_dpmm-dml2_dpmm_dcn4.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_mcg-dml2_mcg_dcn4.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_dcn3.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_dcn4.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_dcn4_fams2.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_standalone_libraries-lib_float_math.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml21-src-dml2_top-dml_top_mcache.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml2_mall_phantom.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml2_policy.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml2_translation_helper.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml2_utils.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml2_wrapper.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|   `-- powerpc-linux-ld:drivers-gpu-drm-amd-display-dc-dml2-dml_display_rq_dlg_calc.o-uses-hard-float-arch-powerpc-kernel-udbg.o-uses-soft-float
|-- riscv-randconfig-001-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- s390-allyesconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- s390-randconfig-001-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sh-buildonly-randconfig-r006-20220416
|   `-- standard-input:Error:unknown-pseudo-op:lfe4886
|-- sparc-allmodconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sparc-randconfig-001-20240429
|   `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|-- sparc-randconfig-002-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sparc-randconfig-r053-20240429
|   `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|-- sparc64-allmodconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sparc64-allyesconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sparc64-randconfig-001-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- um-allyesconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-002-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-006-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-012-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-073-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-121-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-123-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-r132-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
`-- xtensa-randconfig-002-20240429
    `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
clang_recent_errors
|-- arm-defconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-randconfig-002-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-i915-display-intel_cursor.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-phy-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_dpll_mgr.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-intel_dpll_id-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_hotplug.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_pipe_crc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_tc.c:error:arithmetic-between-different-enumeration-types-(-enum-intel_display_power_domain-and-enum-tc_port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_vdsc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_universal_plane.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_watermark.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|   `-- make:No-rule-to-make-target-arch-arm64-boot-dts-ti-k3-j784s4-evm-usxgmii-exp1-exp2.dtb-needed-by-arch-arm64-boot-dts-ti-dtbs-list-.
|-- arm64-allyesconfig
|   `-- arch-arm64-boot-dts-ti-k3-am62a7-sk.dtb:syscon:syscon-syscon-do-not-match-any-of-the-regexes:chipid-9a-f-clock-controller-9a-f-mux-controller-9a-f-phy-9a-f-pinctrl
|-- arm64-randconfig-001-20240429
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   `-- make:No-rule-to-make-target-arch-arm64-boot-dts-ti-k3-j784s4-evm-usxgmii-exp1-exp2.dtb-needed-by-arch-arm64-boot-dts-ti-.
|-- hexagon-allmodconfig
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|-- hexagon-allyesconfig
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|-- hexagon-randconfig-001-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- hexagon-randconfig-r122-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-buildonly-randconfig-001-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-buildonly-randconfig-002-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-004-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-006-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-051-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-052-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-053-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- powerpc-randconfig-r051-20240429
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_dpmm-dml2_dpmm_dcn4.c:error:arithmetic-between-enumeration-type-enum-dentist_divider_range-and-floating-point-type-double-Werror-Wenum-floa
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-i915-display-intel_cursor.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-phy-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_dpll_mgr.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-intel_dpll_id-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_hotplug.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_pipe_crc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_tc.c:error:arithmetic-between-different-enumeration-types-(-enum-intel_display_power_domain-and-enum-tc_port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_vdsc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_universal_plane.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_watermark.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_dpmm-dml2_dpmm_dcn4.c:error:arithmetic-between-enumeration-type-enum-dentist_divider_range-and-floating-point-type-double-Werror-Wenum-floa
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_cursor.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-phy-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_dpll_mgr.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-intel_dpll_id-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_hotplug.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_pipe_crc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_tc.c:error:arithmetic-between-different-enumeration-types-(-enum-intel_display_power_domain-and-enum-tc_port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_vdsc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_universal_plane.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_watermark.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- x86_64-allnoconfig
|   |-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-display-exynos
|   |-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-reserved-memory-qcom
|   `-- net-ipv6-udp.c:trace-events-udp.h-is-included-more-than-once.
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
`-- x86_64-randconfig-101-20240429
    `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used

elapsed time: 727m

configs tested: 178
configs skipped: 4

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240429   gcc  
arc                   randconfig-002-20240429   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240429   clang
arm                   randconfig-002-20240429   clang
arm                   randconfig-003-20240429   clang
arm                   randconfig-004-20240429   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240429   clang
arm64                 randconfig-002-20240429   gcc  
arm64                 randconfig-003-20240429   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240429   gcc  
csky                  randconfig-002-20240429   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240429   clang
hexagon               randconfig-002-20240429   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240429   clang
i386         buildonly-randconfig-002-20240429   clang
i386         buildonly-randconfig-003-20240429   gcc  
i386         buildonly-randconfig-004-20240429   clang
i386         buildonly-randconfig-005-20240429   gcc  
i386         buildonly-randconfig-006-20240429   clang
i386                                defconfig   clang
i386                  randconfig-001-20240429   clang
i386                  randconfig-002-20240429   clang
i386                  randconfig-003-20240429   clang
i386                  randconfig-004-20240429   clang
i386                  randconfig-005-20240429   gcc  
i386                  randconfig-006-20240429   clang
i386                  randconfig-011-20240429   gcc  
i386                  randconfig-012-20240429   gcc  
i386                  randconfig-013-20240429   clang
i386                  randconfig-014-20240429   gcc  
i386                  randconfig-015-20240429   clang
i386                  randconfig-016-20240429   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240429   gcc  
loongarch             randconfig-002-20240429   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240429   gcc  
nios2                 randconfig-002-20240429   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240429   gcc  
parisc                randconfig-002-20240429   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   clang
powerpc                   currituck_defconfig   clang
powerpc                 mpc834x_itx_defconfig   clang
powerpc               randconfig-001-20240429   gcc  
powerpc               randconfig-002-20240429   gcc  
powerpc               randconfig-003-20240429   gcc  
powerpc                     tqm8548_defconfig   clang
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240429   clang
powerpc64             randconfig-002-20240429   clang
powerpc64             randconfig-003-20240429   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240429   gcc  
riscv                 randconfig-002-20240429   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240429   gcc  
s390                  randconfig-002-20240429   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240429   gcc  
sh                    randconfig-002-20240429   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240429   gcc  
sparc64               randconfig-002-20240429   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240429   gcc  
um                    randconfig-002-20240429   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240429   clang
x86_64       buildonly-randconfig-002-20240429   gcc  
x86_64       buildonly-randconfig-003-20240429   clang
x86_64       buildonly-randconfig-004-20240429   gcc  
x86_64       buildonly-randconfig-005-20240429   clang
x86_64       buildonly-randconfig-006-20240429   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240429   clang
x86_64                randconfig-002-20240429   gcc  
x86_64                randconfig-003-20240429   clang
x86_64                randconfig-004-20240429   gcc  
x86_64                randconfig-005-20240429   clang
x86_64                randconfig-006-20240429   gcc  
x86_64                randconfig-011-20240429   gcc  
x86_64                randconfig-012-20240429   gcc  
x86_64                randconfig-013-20240429   gcc  
x86_64                randconfig-014-20240429   clang
x86_64                randconfig-015-20240429   clang
x86_64                randconfig-016-20240429   gcc  
x86_64                randconfig-071-20240429   clang
x86_64                randconfig-072-20240429   clang
x86_64                randconfig-073-20240429   gcc  
x86_64                randconfig-074-20240429   gcc  
x86_64                randconfig-075-20240429   clang
x86_64                randconfig-076-20240429   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240429   gcc  
xtensa                randconfig-002-20240429   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

