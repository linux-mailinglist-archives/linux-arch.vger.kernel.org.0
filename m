Return-Path: <linux-arch+bounces-3526-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DBB89E1C7
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 19:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CEB1C214D0
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBEA156962;
	Tue,  9 Apr 2024 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/0Nbvdk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B212155390;
	Tue,  9 Apr 2024 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712684702; cv=none; b=SBCMj+cdkVgiF6JSbhpQofT/AaVUtnhAJ2w0VLd0+PN8jpNhF075K38bTUNdKoISNnIxLuA5CckWUcXi1zulqz9Sf/utCc5Qv4FOGQc3gD/gmUtYeLq5q+F1m25j3zyx52tVmpSR17zYrUZyzaM5JxsJmSswQ+B5WDVvH6vIpvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712684702; c=relaxed/simple;
	bh=Is5RTh8OEBOIL2HGgrLEJqosN7OM8ai+uP94t5ePr40=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DomnBQXTQliLuDAWe1h/ZqKnW5Zt9/DKNvlovp4rVgPGyZxoi+axAYrhhl6nF8YemfbiO+yrvuPknDkHgwVfqi2oHwPi6Z5vrHm9IFk/yP426ZE2/cTnnepziCJQJMGsaqpTNoeJuqNKodPPvN/8TtdPqgWK29XuMSI0L2DS3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/0Nbvdk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712684699; x=1744220699;
  h=date:from:to:cc:subject:message-id;
  bh=Is5RTh8OEBOIL2HGgrLEJqosN7OM8ai+uP94t5ePr40=;
  b=P/0Nbvdkxg1SrmUy+yCOec1XwLYUSXul+8/WMKKAEbjk2T20h+awnL+q
   hp81mCl4zg6xzdYiHg6myTENoBPm4BcBYCfKzUMB6cAQHKFWn6Cu3euxa
   IlVnMx+mMK8wsgtyRrD1cuIuN4BxxmSlnjVwNFBfk6xiqdHo3T4mdIFLK
   O/R145KvHJIVkN7qWU8TLQLenJpyyIa00BpICWWAfMyfAzzTetfid/1dy
   KMYBtJ5CqxixRtC+0OttUMwOIxU8dbeTOg0J2xeTpbZxLWSh6xlQpp+6o
   MYmpZ1lRUStT/AJf+HJf78f2gkdytT12rMjsgGWDE2vAU+JA29V8iSIgB
   A==;
X-CSE-ConnectionGUID: ZESsiYmsSgueqVy5IEsQMg==
X-CSE-MsgGUID: xwx4I/z/T1mYGjiri7riRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7877113"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7877113"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 10:44:58 -0700
X-CSE-ConnectionGUID: Y5Dj3ulmTDyK7kOBk91eFA==
X-CSE-MsgGUID: NKkt3v0SSrKd8LmC/yN7XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20268020"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 Apr 2024 10:44:55 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruFWe-0006NW-0w;
	Tue, 09 Apr 2024 17:44:52 +0000
Date: Wed, 10 Apr 2024 01:44:16 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 lima@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-usb@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: [linux-next:master] BUILD REGRESSION
 a053fd3ca5d1b927a8655f239c84b0d790218fda
Message-ID: <202404100109.FTUyk0j5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: a053fd3ca5d1b927a8655f239c84b0d790218fda  Add linux-next specific files for 20240409

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202404091516.9h8IdaMM-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202404091749.ScNPJ8j4-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202404091959.he2HJvYl-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

WARNING: modpost: vmlinux: section mismatch in reference: (unknown)+0x14d0 (section: __ex_table) -> .LASF112 (section: .debug_str)
WARNING: modpost: vmlinux: section mismatch in reference: (unknown)+0x14d4 (section: __ex_table) -> .LASF114 (section: .debug_str)
WARNING: modpost: vmlinux: section mismatch in reference: (unknown)+0x14dc (section: __ex_table) -> .LASF116 (section: .debug_str)
WARNING: modpost: vmlinux: section mismatch in reference: (unknown)+0x14e0 (section: __ex_table) -> .LASF118 (section: .debug_str)
WARNING: modpost: vmlinux: section mismatch in reference: ___se_sys_chroot+0xd0 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ___se_sys_inotify_add_watch+0x12a (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ___se_sys_landlock_add_rule+0x1b0 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ___se_sys_open_by_handle_at+0x1ea (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __dev_queue_xmit+0x1d4 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __do_sys_fsmount+0xf2 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __do_sys_pivot_root+0x28a (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __hw_addr_del_entry+0x44 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __hw_addr_flush+0x48 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __u64_stats_update_begin+0x16 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ahci_platform_get_resources+0x84 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: altera_msi_probe+0x80 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: armada8k_pcie_probe+0x144 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: atmel_sha_probe+0x36a (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: btrfs_init_new_device+0x14e (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cqhci_pltfm_init+0x1a (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: default_device_exit_net+0x128 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: do_coredump+0x454 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: do_utimes+0xea (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dpm_suspend+0xa2 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dpm_suspend_late+0x86 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dpm_suspend_noirq+0xa2 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: edma_probe+0xf2 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: free_filters_list+0x3c (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: img_hash_probe+0x3a0 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipv6_icmp_error+0x20 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: kernel_read_file_from_path_initns+0xe6 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: kmb_ocs_aes_probe+0x1c2 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: kmb_ocs_ecc_probe+0x172 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ks_pcie_probe+0xb0 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: lpc18xx_eeprom_probe+0x3e (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mntns_install+0xd4 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mobiveil_pcie_host_probe+0x36 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mptcp_pm_nl_get_addr+0x112 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mtk_iommu_probe+0x30c (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mv_xor_probe+0x272 (section: .text.unlikely) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: omap8250_probe+0xec (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: sbi_cpuidle_probe+0x346 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: skcipher_walk_complete+0x46 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tcp_retrans_try_collapse+0x1a8 (section: .text) -> .L0  (section: .init.text)
lib/../mm/internal.h:206:70: warning: suggest parentheses around '+' in operand of '&' [-Wparentheses]
lib/../mm/internal.h:206:70: warning: suggest parentheses around '+' inside '>>' [-Wparentheses]
mm/damon/../internal.h:206:70: warning: suggest parentheses around '+' in operand of '&' [-Wparentheses]
mm/damon/../internal.h:206:70: warning: suggest parentheses around '+' inside '>>' [-Wparentheses]
mm/internal.h:206:70: warning: suggest parentheses around '+' in operand of '&' [-Wparentheses]
mm/internal.h:206:70: warning: suggest parentheses around '+' inside '>>' [-Wparentheses]
powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data516' from `fs/overlayfs/copy_up.o' being placed in section `.bss..Lubsan_data516'
powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data531' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data531'

Unverified Error/Warning (likely false positive, please contact us if interested):

{standard input}:1018: Error: unknown pseudo-op: `.l162'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- csky-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-damon-..-internal.h:warning:suggest-parentheses-around-in-operand-of
|   `-- mm-internal.h:warning:suggest-parentheses-around-in-operand-of
|-- csky-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- mm-internal.h:warning:suggest-parentheses-around-in-operand-of
|-- csky-randconfig-001-20240409
|   `-- mm-internal.h:warning:suggest-parentheses-around-in-operand-of
|-- csky-randconfig-002-20240409
|   `-- mm-internal.h:warning:suggest-parentheses-around-in-operand-of
|-- i386-randconfig-141-20240409
|   |-- drivers-pwm-core.c-pwm_cdev_ioctl()-warn:possible-spectre-second-half.-pwm
|   |-- drivers-pwm-core.c-pwm_cdev_ioctl()-warn:potential-spectre-issue-cdata-pwm-r
|   |-- drivers-usb-dwc2-hcd_ddma.c-dwc2_cmpl_host_isoc_dma_desc()-warn:variable-dereferenced-before-check-qtd-urb-(see-line-)
|   `-- drivers-usb-typec-ucsi-ucsi.c-ucsi_get_pd_caps()-warn:passing-zero-to-ERR_PTR
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- microblaze-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- microblaze-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- openrisc-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- parisc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|   |-- mm-damon-..-internal.h:warning:suggest-parentheses-around-inside
|   |-- mm-internal.h:warning:suggest-parentheses-around-in-operand-of
|   `-- mm-internal.h:warning:suggest-parentheses-around-inside
|-- parisc-allnoconfig
|   |-- lib-..-mm-internal.h:warning:suggest-parentheses-around-in-operand-of
|   |-- lib-..-mm-internal.h:warning:suggest-parentheses-around-inside
|   |-- mm-internal.h:warning:suggest-parentheses-around-in-operand-of
|   `-- mm-internal.h:warning:suggest-parentheses-around-inside
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|   |-- mm-internal.h:warning:suggest-parentheses-around-in-operand-of
|   `-- mm-internal.h:warning:suggest-parentheses-around-inside
|-- parisc-randconfig-001-20240409
|   |-- mm-internal.h:warning:suggest-parentheses-around-in-operand-of
|   `-- mm-internal.h:warning:suggest-parentheses-around-inside
|-- parisc-randconfig-002-20240409
|   |-- mm-internal.h:warning:suggest-parentheses-around-in-operand-of
|   `-- mm-internal.h:warning:suggest-parentheses-around-inside
|-- parisc-randconfig-r051-20240409
|   |-- lib-..-mm-internal.h:warning:suggest-parentheses-around-in-operand-of
|   |-- lib-..-mm-internal.h:warning:suggest-parentheses-around-inside
|   |-- mm-internal.h:warning:suggest-parentheses-around-in-operand-of
|   `-- mm-internal.h:warning:suggest-parentheses-around-inside
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- powerpc-randconfig-r015-20220318
|   |-- powerpc-linux-ld:warning:orphan-section-bss..Lubsan_data516-from-fs-overlayfs-copy_up.o-being-placed-in-section-.bss..Lubsan_data516
|   `-- powerpc-linux-ld:warning:orphan-section-bss..Lubsan_data531-from-kernel-ptrace.o-being-placed-in-section-.bss..Lubsan_data531
|-- riscv-buildonly-randconfig-r005-20221114
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:(unknown)-(section:__ex_table)-.LASF112-(section:.debug_str)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:(unknown)-(section:__ex_table)-.LASF114-(section:.debug_str)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:(unknown)-(section:__ex_table)-.LASF116-(section:.debug_str)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:(unknown)-(section:__ex_table)-.LASF118-(section:.debug_str)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:___se_sys_chroot-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:___se_sys_inotify_add_watch-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:___se_sys_landlock_add_rule-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:___se_sys_open_by_handle_at-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:__dev_queue_xmit-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:__do_sys_fsmount-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:__do_sys_pivot_root-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:__hw_addr_del_entry-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:__hw_addr_flush-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:__u64_stats_update_begin-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ahci_platform_get_resources-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:altera_msi_probe-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:armada8k_pcie_probe-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:atmel_sha_probe-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:btrfs_init_new_device-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cqhci_pltfm_init-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:default_device_exit_net-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:do_coredump-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:do_utimes-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:dpm_suspend-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:dpm_suspend_late-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:dpm_suspend_noirq-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:edma_probe-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:free_filters_list-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:img_hash_probe-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ipv6_icmp_error-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:kernel_read_file_from_path_initns-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:kmb_ocs_aes_probe-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:kmb_ocs_ecc_probe-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ks_pcie_probe-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:lpc18xx_eeprom_probe-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:mntns_install-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:mobiveil_pcie_host_probe-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:mptcp_pm_nl_get_addr-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:mtk_iommu_probe-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:mv_xor_probe-(section:.text.unlikely)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:omap8250_probe-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:sbi_cpuidle_probe-(section:.text)-.L0-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:skcipher_walk_complete-(section:.text)-.L0-(section:.init.text)
|   `-- WARNING:modpost:vmlinux:section-mismatch-in-reference:tcp_retrans_try_collapse-(section:.text)-.L0-(section:.init.text)
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- sh-randconfig-r014-20220226
|   `-- standard-input:Error:unknown-pseudo-op:l162
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- sparc-randconfig-001-20240409
|   `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|-- sparc-randconfig-002-20240409
|   `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|-- sparc64-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
`-- sparc64-allyesconfig
    |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
    `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
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
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-renesas-rcar-du-rcar_cmm.c:error:unused-function-rcar_cmm_read-Werror-Wunused-function
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
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
|-- i386-randconfig-013-20240409
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   `-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
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
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
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
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
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
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- x86_64-allmodconfig
|   |-- drivers-gpu-drm-bridge-synopsys-dw-hdmi-i2s-audio.c:error:unused-function-hdmi_read-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_hi_bits-Werror-Wunused-function
|   |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_low_bits-Werror-Wunused-function
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   `-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-bridge-synopsys-dw-hdmi-i2s-audio.c:error:unused-function-hdmi_read-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_hi_bits-Werror-Wunused-function
|   |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_low_bits-Werror-Wunused-function
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   `-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
`-- x86_64-randconfig-161-20240409
    |-- drivers-pwm-core.c-pwm_cdev_ioctl()-warn:possible-spectre-second-half.-pwm
    |-- drivers-pwm-core.c-pwm_cdev_ioctl()-warn:potential-spectre-issue-cdata-pwm-r
    `-- drivers-usb-typec-ucsi-ucsi.c-ucsi_get_pd_caps()-warn:passing-zero-to-ERR_PTR

elapsed time: 725m

configs tested: 180
configs skipped: 3

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240409   gcc  
arc                   randconfig-002-20240409   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   clang
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                      footbridge_defconfig   clang
arm                          moxart_defconfig   gcc  
arm                       multi_v4t_defconfig   clang
arm                   randconfig-001-20240409   gcc  
arm                   randconfig-002-20240409   clang
arm                   randconfig-003-20240409   clang
arm                   randconfig-004-20240409   gcc  
arm                             rpc_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240409   gcc  
arm64                 randconfig-002-20240409   gcc  
arm64                 randconfig-003-20240409   clang
arm64                 randconfig-004-20240409   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240409   gcc  
csky                  randconfig-002-20240409   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240409   clang
hexagon               randconfig-002-20240409   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240409   clang
i386         buildonly-randconfig-002-20240409   clang
i386         buildonly-randconfig-003-20240409   gcc  
i386         buildonly-randconfig-004-20240409   clang
i386         buildonly-randconfig-005-20240409   gcc  
i386         buildonly-randconfig-006-20240409   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240409   clang
i386                  randconfig-002-20240409   gcc  
i386                  randconfig-003-20240409   clang
i386                  randconfig-004-20240409   gcc  
i386                  randconfig-005-20240409   gcc  
i386                  randconfig-006-20240409   clang
i386                  randconfig-011-20240409   gcc  
i386                  randconfig-012-20240409   clang
i386                  randconfig-013-20240409   clang
i386                  randconfig-014-20240409   clang
i386                  randconfig-015-20240409   gcc  
i386                  randconfig-016-20240409   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240409   gcc  
loongarch             randconfig-002-20240409   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                           ip22_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240409   gcc  
nios2                 randconfig-002-20240409   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240409   gcc  
parisc                randconfig-002-20240409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc                      pasemi_defconfig   clang
powerpc               randconfig-001-20240409   clang
powerpc               randconfig-002-20240409   gcc  
powerpc               randconfig-003-20240409   clang
powerpc64             randconfig-001-20240409   gcc  
powerpc64             randconfig-002-20240409   clang
powerpc64             randconfig-003-20240409   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240409   clang
riscv                 randconfig-002-20240409   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240409   gcc  
s390                  randconfig-002-20240409   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240409   gcc  
sh                    randconfig-002-20240409   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240409   gcc  
sparc64               randconfig-002-20240409   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240409   clang
um                    randconfig-002-20240409   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240409   clang
x86_64       buildonly-randconfig-002-20240409   clang
x86_64       buildonly-randconfig-003-20240409   gcc  
x86_64       buildonly-randconfig-004-20240409   gcc  
x86_64       buildonly-randconfig-005-20240409   clang
x86_64       buildonly-randconfig-006-20240409   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240409   clang
x86_64                randconfig-002-20240409   clang
x86_64                randconfig-003-20240409   gcc  
x86_64                randconfig-004-20240409   gcc  
x86_64                randconfig-005-20240409   clang
x86_64                randconfig-006-20240409   clang
x86_64                randconfig-011-20240409   gcc  
x86_64                randconfig-012-20240409   clang
x86_64                randconfig-013-20240409   gcc  
x86_64                randconfig-014-20240409   clang
x86_64                randconfig-015-20240409   gcc  
x86_64                randconfig-016-20240409   gcc  
x86_64                randconfig-071-20240409   gcc  
x86_64                randconfig-072-20240409   clang
x86_64                randconfig-073-20240409   clang
x86_64                randconfig-074-20240409   clang
x86_64                randconfig-075-20240409   clang
x86_64                randconfig-076-20240409   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240409   gcc  
xtensa                randconfig-002-20240409   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

