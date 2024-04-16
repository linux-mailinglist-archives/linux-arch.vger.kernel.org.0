Return-Path: <linux-arch+bounces-3739-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE488A76D6
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 23:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A571F2163A
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 21:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA7613A24D;
	Tue, 16 Apr 2024 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsxyYhKr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07615A0F9;
	Tue, 16 Apr 2024 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713303320; cv=none; b=GJ/pKZhEo6oEjYbqrdfJuDj9Gvp+PiBe0I+C1OWc+IPhpwHZ9zIuDXtAfzTt5QmEZDgiCEnsRA4W8Nx83A2Izunyz/J1Nq1f0WxdEJGJKRheC7KnzLsu6nDZpYxeVMQzV5YZsxzLpWlYNkqH+DdYLA+989FshrcWb+UxeF/cqNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713303320; c=relaxed/simple;
	bh=XMDdbm2KXFf7zWjnoitvevP7bZJiwaNDpjn64QZsEso=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZSn270jxpZeTdDpR9NeaQGZkTK5crqOyabNoTWPdGNrd5drrNe7pCmQ1EAzYRm6uEXUgqRWXRdoK8eZaL539M14HI5AhOB7CZWnw3xkjbdny6DzidrLSd75YqwpSRGPID1IXSBvLvzW5yGeRn2XDlEdoXA+wpsoGIHmBU9VKW5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsxyYhKr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713303317; x=1744839317;
  h=date:from:to:cc:subject:message-id;
  bh=XMDdbm2KXFf7zWjnoitvevP7bZJiwaNDpjn64QZsEso=;
  b=FsxyYhKrMQ+21qgJ70gjCPNt8j45IhhPa6xJ85+eOG0Gw8yyMkbeav8N
   71MftxEVuQ+skFax5WuH//zZgvDzaS/7l6p/5B599iWNb9hT12dKj/Pwj
   52KjG9O+4/WkuaD39d1oNK1MBGfW2SEheiE0rejYbFbE2e2fHhSVNeiFB
   cuzo3Fan0ksxJ2G35iRdiAPai8Togtb7tWcfytL7wj2hUwKb6IYZe/qc9
   Wk8njCpjfxq1KihdhAJjk9lQm52WgK7IjcHosWBkYtt/aHMXuSZ3VoC/e
   tBR1u8NwbdA0OwPPbwHkC8Hz7EQeu+cJDuXDj+fN2QaWBsLr+wwdPeMY+
   g==;
X-CSE-ConnectionGUID: ZLA6TRvGQ8KvIU9WVZNXmg==
X-CSE-MsgGUID: 88wAn9DhSdicXkmQw+QbHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19920211"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19920211"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:35:16 -0700
X-CSE-ConnectionGUID: urwpmcO0QFKH/A3/Y0SfhA==
X-CSE-MsgGUID: +RaioJseTR6Z6qEIPTuT0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26827693"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 16 Apr 2024 14:35:12 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwqSL-0005lp-36;
	Tue, 16 Apr 2024 21:35:09 +0000
Date: Wed, 17 Apr 2024 05:34:30 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 netdev@vger.kernel.org, nouveau@lists.freedesktop.org,
 openipmi-developer@lists.sourceforge.net
Subject: [linux-next:master] BUILD REGRESSION
 66e4190e92ce0e4a50b2f6be0e5f5b2e47e072f4
Message-ID: <202404170525.h1vxGb4X-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 66e4190e92ce0e4a50b2f6be0e5f5b2e47e072f4  Add linux-next specific files for 20240416

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202404161933.izfqZ32k-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202404170348.thxrboF1-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/arc/include/asm/cmpxchg.h:50:26: error: implicit declaration of function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
arch/mips/sgi-ip27/ip27-irq.c:280:13: warning: unused variable 'i' [-Wunused-variable]
netdev.c:(.text+0x2288): undefined reference to `page_pool_create'
netdev.c:(.text+0x378): undefined reference to `page_pool_alloc_pages'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- alpha-randconfig-r112-20240416
|   `-- kernel-bpf-verifier.c:sparse:sparse:cast-truncates-bits-from-constant-value-(fffffffc00000000-becomes-)
|-- arc-allmodconfig
|   `-- arch-arc-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- arc-allnoconfig
|   `-- arch-arc-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- arc-allyesconfig
|   `-- arch-arc-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- arc-defconfig
|   `-- arch-arc-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- arc-nsimosci_hs_smp_defconfig
|   `-- arch-arc-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- arc-randconfig-001-20240416
|   `-- arch-arc-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- arc-randconfig-002-20240416
|   `-- arch-arc-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- csky-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- csky-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- i386-randconfig-141-20240416
|   |-- drivers-pwm-core.c-pwm_cdev_ioctl()-warn:possible-spectre-second-half.-pwm
|   `-- drivers-pwm-core.c-pwm_cdev_ioctl()-warn:potential-spectre-issue-cdata-pwm-r
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- loongarch-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- microblaze-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- microblaze-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- mips-ip27_defconfig
|   `-- arch-mips-sgi-ip27-ip27-irq.c:warning:unused-variable-i
|-- openrisc-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- parisc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- powerpc-randconfig-002-20240416
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
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-display_mode_vba.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dml1_display_rq_dlg_calc.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-dsc-rc_calc_fpu.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-display_mode_core.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-display_mode_util.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml2_mall_phantom.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml2_policy.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml2_translation_helper.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml2_utils.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml2_wrapper.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   `-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml_display_rq_dlg_calc.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|-- powerpc-randconfig-r006-20211103
|   |-- netdev.c:(.text):undefined-reference-to-page_pool_alloc_pages
|   `-- netdev.c:(.text):undefined-reference-to-page_pool_create
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- sparc64-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- sparc64-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
`-- x86_64-randconfig-161-20240416
    `-- drivers-gpu-drm-bridge-cadence-cdns-mhdp8546-core.c-cdns_mhdp_atomic_enable()-warn:inconsistent-returns-mhdp-link_mutex-.
clang_recent_errors
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-i915-display-intel_cursor.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-phy-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-port-)-Werror-Wenum-enum-conversion
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
|   |-- drivers-gpu-drm-renesas-rcar-du-rcar_cmm.c:error:unused-function-rcar_cmm_read-Werror-Wunused-function
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- hexagon-allmodconfig
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|-- hexagon-allyesconfig
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-i915-display-intel_cursor.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-phy-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-port-)-Werror-Wenum-enum-conversion
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
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
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
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- x86_64-allnoconfig
|   |-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-display-exynos
|   |-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-reserved-memory-qcom
|   |-- drivers-char-ipmi-ipmi_msghandler.c:linux-workqueue.h-is-included-more-than-once.
|   `-- net-ipv6-udp.c:trace-events-udp.h-is-included-more-than-once.
`-- x86_64-allyesconfig
    |-- drivers-gpu-drm-bridge-synopsys-dw-hdmi-i2s-audio.c:error:unused-function-hdmi_read-Werror-Wunused-function
    |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
    |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
    |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_hi_bits-Werror-Wunused-function
    |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_low_bits-Werror-Wunused-function
    `-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast

elapsed time: 741m

configs tested: 178
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240416   gcc  
arc                   randconfig-002-20240416   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20240416   clang
arm                   randconfig-002-20240416   clang
arm                   randconfig-003-20240416   gcc  
arm                   randconfig-004-20240416   clang
arm                         s5pv210_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240416   gcc  
arm64                 randconfig-002-20240416   clang
arm64                 randconfig-003-20240416   gcc  
arm64                 randconfig-004-20240416   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240416   gcc  
csky                  randconfig-002-20240416   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240416   clang
hexagon               randconfig-002-20240416   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240416   gcc  
i386         buildonly-randconfig-002-20240416   gcc  
i386         buildonly-randconfig-003-20240416   clang
i386         buildonly-randconfig-004-20240416   clang
i386         buildonly-randconfig-005-20240416   clang
i386         buildonly-randconfig-006-20240416   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240416   clang
i386                  randconfig-002-20240416   clang
i386                  randconfig-003-20240416   gcc  
i386                  randconfig-004-20240416   clang
i386                  randconfig-005-20240416   gcc  
i386                  randconfig-006-20240416   gcc  
i386                  randconfig-011-20240416   clang
i386                  randconfig-012-20240416   gcc  
i386                  randconfig-013-20240416   clang
i386                  randconfig-014-20240416   gcc  
i386                  randconfig-015-20240416   clang
i386                  randconfig-016-20240416   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240416   gcc  
loongarch             randconfig-002-20240416   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                  cavium_octeon_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           gcw0_defconfig   clang
mips                  maltasmvp_eva_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240416   gcc  
nios2                 randconfig-002-20240416   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240416   gcc  
parisc                randconfig-002-20240416   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                     mpc83xx_defconfig   clang
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240416   clang
powerpc               randconfig-002-20240416   gcc  
powerpc               randconfig-003-20240416   clang
powerpc                      tqm8xx_defconfig   clang
powerpc64             randconfig-001-20240416   gcc  
powerpc64             randconfig-002-20240416   gcc  
powerpc64             randconfig-003-20240416   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240416   gcc  
riscv                 randconfig-002-20240416   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240416   clang
s390                  randconfig-002-20240416   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240416   gcc  
sh                    randconfig-002-20240416   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240416   gcc  
sparc64               randconfig-002-20240416   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240416   gcc  
um                    randconfig-002-20240416   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240416   gcc  
x86_64       buildonly-randconfig-002-20240416   gcc  
x86_64       buildonly-randconfig-003-20240416   gcc  
x86_64       buildonly-randconfig-004-20240416   clang
x86_64       buildonly-randconfig-005-20240416   gcc  
x86_64       buildonly-randconfig-006-20240416   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240416   clang
x86_64                randconfig-002-20240416   clang
x86_64                randconfig-003-20240416   gcc  
x86_64                randconfig-004-20240416   clang
x86_64                randconfig-005-20240416   clang
x86_64                randconfig-006-20240416   gcc  
x86_64                randconfig-011-20240416   gcc  
x86_64                randconfig-012-20240416   clang
x86_64                randconfig-013-20240416   clang
x86_64                randconfig-014-20240416   clang
x86_64                randconfig-015-20240416   clang
x86_64                randconfig-016-20240416   gcc  
x86_64                randconfig-071-20240416   clang
x86_64                randconfig-072-20240416   clang
x86_64                randconfig-073-20240416   clang
x86_64                randconfig-074-20240416   clang
x86_64                randconfig-075-20240416   gcc  
x86_64                randconfig-076-20240416   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-002-20240416   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

