Return-Path: <linux-arch+bounces-3830-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A23F8AB59E
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 21:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D65B1C2195C
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C566E13C90B;
	Fri, 19 Apr 2024 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4BHdjsS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A19C1E86C;
	Fri, 19 Apr 2024 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713555319; cv=none; b=RNqXSbqsmojLVHIP7/vyYvoDT201BNytAXGKo7A09Rn/+VGVNBspcJO3WoWWpJ8Ggz55Qro+BO1l9iBBt5IuyQgft/EsaXwhWkjYiS4Kzrumq4IluC1qA2FiGBS5wMYIkP7BgpU9T0E2Pz6sDnQsK64rgBpC9bicjYmRIuwEXQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713555319; c=relaxed/simple;
	bh=YHoAkwQgzzatp9ngb5LDwr05tCyqy30T/hxVYq0X+b8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nh4tdVKUrDqq+IhGUQWQLV50ccO6qAlwmqizjd/xZC8ONt/TAKlhTMv0jSQ3g28EVNEY9SfWk7Z5HoZnXN0p57jY+XSYproiWt18uZhJ10sCAQqoMryR2C6bTr1/WHO9ugpLGna+08LqjCxVfz3VR38b9ftl+J2A4bTF3fa5Gqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4BHdjsS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713555316; x=1745091316;
  h=date:from:to:cc:subject:message-id;
  bh=YHoAkwQgzzatp9ngb5LDwr05tCyqy30T/hxVYq0X+b8=;
  b=g4BHdjsSvjcPiFNZq2Wv634oJxUk+kYqbr+eUtZK77HlJMS30WSXix6U
   9TzKBU1kMORyyFGy5DwmmES4E1Dererw6H5C1NYrjS5bNUVX6qZBEaEPi
   ahptLlFQA4CX2TyjXFrD6arvEdPzXfGvBmEQ9KuqDzYE51dOB62ekgjKy
   bMpBay7dzd/BQa3vtkAC2slN87ssWZUudcxNgfI1J5zsBVuu3DmKzBvnY
   UzSf4vu6YiGM9RiImO6MewXto1XDXhHYUM8FgD0PLwt+irIqWdclKxRIA
   vhxrWHKASqYJG2unvQrYXnljGtyXlbtdJS8ue2Eobuj/7xcwmWz3JlK+M
   g==;
X-CSE-ConnectionGUID: LU7QWi+6RcqWGtRqGbwiWQ==
X-CSE-MsgGUID: nfC5xebwRSi+wj+hVdN4dQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="20595728"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="20595728"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 12:35:15 -0700
X-CSE-ConnectionGUID: /Y9RWY9DT8yFKLQCoZ08Gw==
X-CSE-MsgGUID: +6nVe7xtS2KgQ3FPsTctBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="60864471"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 19 Apr 2024 12:35:10 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxu0p-000APm-2H;
	Fri, 19 Apr 2024 19:35:07 +0000
Date: Sat, 20 Apr 2024 03:34:54 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-arch@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 nouveau@lists.freedesktop.org
Subject: [linux-next:master] BUILD REGRESSION
 a35e92ef04c07bd473404b9b73d489aea19a60a8
Message-ID: <202404200345.eGdn5uxW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: a35e92ef04c07bd473404b9b73d489aea19a60a8  Add linux-next specific files for 20240419

Error/Warning: (recently discovered and may have been fixed)

WARNING: modpost: vmlinux: section mismatch in reference: __io_uring_register+0x4e (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: add_master_key+0xcc (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: address_val+0x172 (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: affine_move_task+0x7c (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: bcma_pmu_init+0x11c (section: .text) -> .LBE2162 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: bitmap_list_string.isra.0+0x176 (section: .text) -> .L498 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: bpf_cgroup_link_fill_link_info+0x18 (section: .text) -> .LBE2191 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: bpf_map_meta_alloc+0x68 (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: bstr_printf+0x4c (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cgroup1_reconfigure+0x6a (section: .text) -> .LBE2191 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cgroup_bpf_replace+0x18 (section: .text) -> .LBE2191 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: class_srcu_destructor.isra.0+0x44 (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cpu_cluster_pm_enter+0x36 (section: .text) -> .LBB2191 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dma_direct_mmap+0xf2 (section: .text) -> .LVL129 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: drm_atomic_helper_check_plane_state+0x80 (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x228 (section: .text) -> .LBE1217 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: drm_of_component_probe+0xec (section: .text) -> .LVL1112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: drm_test_rect_rotate_inv+0x3c (section: .text) -> .LVL1139 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dw_hdmi_bridge_atomic_get_output_bus_fmts+0x80 (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gpiod_direction_input.part.0+0x2a (section: .text) -> .LVL1117 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gpiod_direction_output_raw_commit+0x40 (section: .text) -> .LVL1117 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gpiod_find_and_request+0x4e (section: .text) -> .LVL1117 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gpiod_get_direction+0x4e (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gpiod_to_irq+0x48 (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gpiolib_seq_start+0x32 (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gpiolib_seq_stop+0x4e (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: handle_new_recv_msgs+0x23a (section: .text) -> .LVL1117 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iio_compute_scan_bytes+0x5e (section: .text) -> .LVL1049 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iio_dev_attr_in_accel_scale_available+0x14 (section: .data) -> .LVL793 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipmi_get_maintenance_mode+0x8a (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipmi_get_my_LUN+0x82 (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipmi_get_smi_info+0x32 (section: .text) -> .LVL1117 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipmi_set_my_address+0x82 (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipmi_timeout+0x6c (section: .text) -> .LVL1117 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: lm3533_ctrlbank_get_brightness+0x26 (section: .text) -> .LVL1041 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mipi_dbi_pipe_reset_plane+0x18 (section: .text) -> .LVL1081 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mipi_dbi_spi1e_transfer+0xb0 (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: nr_msgs_show+0x2a (section: .text) -> .LVL1117 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pcmcia_bus_early_resume+0x66 (section: .text) -> .LVL1074 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: perf_init_event+0x26 (section: .text) -> .LVL1117 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: show_als_attr+0x36 (section: .text) -> .LBE2162 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: show_als_en+0x2c (section: .text) -> .LVL1041 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: show_thresh_either_en+0x82 (section: .text) -> .LVL1041 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: srcu_ref_scale_read_section+0x4c (section: .text) -> .LVL1117 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: srcu_torture_read_lock+0x2c (section: .text) -> .LVL1117 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: stack_depot_save+0xa (section: .text) -> .LVL1037 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tda18271c2_rf_tracking_filters_correction.isra.0+0x78 (section: .text) -> .LVL1055 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: thermal_of_zone_register+0xdc (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vsnprintf+0x4c (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xas_store+0x66 (section: .text) -> .L443 (section: .init.text)

Unverified Error/Warning (likely false positive, please contact us if interested):

init/initramfs.c:578:31: error: use of undeclared identifier 'sysfs_bin_attr_simple_read'

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
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- csky-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
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
|   `-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- powerpc-randconfig-002-20240419
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
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-display_mode_lib.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-display_mode_vba.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
|   |-- powerpc-linux-ld:drivers-gpu-drm-amd-amdgpu-..-display-dc-dml-display_rq_dlg_helpers.o-uses-hard-float-drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm_helpers.o-uses-soft-float
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
|-- riscv-buildonly-randconfig-r003-20220906
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:___drm_dbg-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:__dquot_alloc_space-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:__dquot_free_space-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:__dquot_transfer-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:__drm_dev_dbg-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:__drm_printfn_dbg-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:__io_uring_register-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:__v4l2_fwnode_endpoint_parse-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:_genpd_power_off-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:_genpd_power_on-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:acquire_ipmi_user-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:add_master_key-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:add_new_master_key-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:address_val-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:affine_move_task-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:balance_push-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:bcma_pmu_init-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:bitmap_list_string-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:bpf_cgroup_link_fill_link_info-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:bpf_cgroup_link_release-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:bpf_cgroup_link_show_fdinfo-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:bpf_map_fd_get_ptr-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:bpf_map_meta_alloc-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:bstr_printf-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cgroup1_get_tree-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cgroup1_reconfigure-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cgroup_bpf_link_attach-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cgroup_bpf_prog_attach-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cgroup_bpf_prog_detach-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cgroup_bpf_prog_query-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cgroup_bpf_release-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cgroup_bpf_replace-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cgroup_iter_seq_stop-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cgroup_mutex-(section:.data)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cgroup_storage_map_free-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:check_pointer-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:class_srcu_destructor-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:clock-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:connector_bad_edid-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:console_device-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:console_flush_all-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:console_flush_on_panic-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:console_srcu_read_lock-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:console_srcu_read_unlock-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:console_unblank-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cpu_cluster_pm_enter-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cpu_pm_enter-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cpu_pm_suspend-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:cpuhp_hp_states-(section:.data)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:default_pointer-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:deliver_response-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:device_links_read_lock-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:device_links_read_unlock-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:device_node_string-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:device_pm_move_to_tail-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:device_wakeup_arm_wake_irqs-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:device_wakeup_disarm_wake_irqs-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:devm_thermal_of_zone_release-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:dma_direct_mmap-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:do_fcntl-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:do_remove_key-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:dquot_alloc_inode-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:dquot_claim_space_nodirty-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:dquot_free_inode-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:dquot_reclaim_space_nodirty-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:drm_atomic_commit-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:drm_atomic_helper_check_plane_state-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:drm_crtc_accurate_vblank_count-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:drm_crtc_vblank_helper_get_vblank_timestamp_internal-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:drm_dev_enter-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:drm_dev_exit-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:drm_dp_i2c_do_msg-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:drm_gem_simple_kms_reset_shadow_plane-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:drm_minor_acquire-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:drm_mode_is_420-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:drm_of_component_match_add-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:drm_of_component_probe-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:drm_test_rect_rotate_inv-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:drm_vblank_restore-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:dw_hdmi_bridge_atomic_get_output_bus_fmts-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:escaped_string-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:etnaviv_buffer_queue-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:etnaviv_pdev_probe-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:event_gb_operation_create_core-(section:.data)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:event_xdp_exception-(section:.data)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:file_dentry_name-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:flags_string-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:format_decode-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:fscrypt_ioctl_get_key_status-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:fscrypt_put_master_key_activeref-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:fscrypt_setup_encryption_info-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:fscrypt_verify_key_added-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:fsnotify-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:fsnotify_destroy_group-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:fsnotify_finish_user_wait-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:fsnotify_grab_connector-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:fsnotify_prepare_user_wait-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:fwnode_graph_devcon_matches-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:fwnode_graph_get_endpoint_by_id-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:fwnode_graph_get_endpoint_count-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:fwnode_graph_get_next_endpoint-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:fwnode_graph_get_remote_port_parent-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gb_operation_create_core-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpio_device_chip_cmp-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpio_device_find-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpio_name_to_desc-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpio_set_config_with_argument-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpio_set_open_drain_value_commit-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpio_set_open_source_value_commit-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpio_to_desc-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiochip_dup_line_label-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiochip_machine_hog-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_configure_flags-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_direction_input-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_direction_output-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_direction_output_raw_commit-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_disable_hw_timestamp_ns-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_enable_hw_timestamp_ns-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_find_and_request-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_free_commit-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_get_array_value_complex-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_get_direction-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_get_raw_value_commit-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_hog-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_request-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_request_commit-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_set_array_value_complex-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_set_config-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_set_raw_value_commit-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiod_to_irq-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiolib_dbg_show-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiolib_seq_show-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiolib_seq_start-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:gpiolib_seq_stop-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:handle_new_recv_msgs-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:handle_read_event_rsp-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:iio_buffer_update_demux-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:iio_compute_scan_bytes-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:iio_dev_attr_in_accel_scale_available-(section:.data)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:iio_dev_attr_in_magn_scale_available-(section:.data)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ip4_addr_string_sa-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ip4_string-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ip6_addr_string_sa-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ip_addr_string-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ipmi_create_user-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ipmi_get_maintenance_mode-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ipmi_get_my_LUN-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ipmi_get_my_address-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ipmi_get_smi_info-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ipmi_get_version-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ipmi_request_settime-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ipmi_request_supply_msgs-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ipmi_set_gets_events-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ipmi_set_maintenance_mode-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ipmi_set_my_LUN-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ipmi_set_my_address-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ipmi_timeout-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:lease_setup-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:lm3533_als_get_zone-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:lm3533_als_isr-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:lm3533_als_read_raw-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:lm3533_als_set_threshold-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:lm3533_ctrlbank_get_brightness-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:lm3533_ctrlbank_get_pwm-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:mac_address_string-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:match_fwnode-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:media_entity_get_fwnode_pad-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:migration_cpu_stop-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:mipi_dbi_pipe_reset_plane-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:mipi_dbi_spi1_transfer-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:mipi_dbi_spi1e_transfer-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:mmap_vmcore-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:nr_msgs_show-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:pcmcia_bus_early_resume-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:pcmcia_bus_remove-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:perf_init_event-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:pinconf_generic_dump_one-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:pm_print_active_wakeup_sources-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:pm_qos_resume_latency_us_store-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:pointer-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:process_single_tx_qlock-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:pull_dl_task-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:push_rt_task-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:rcu_early_boot_tests-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:read_from_oldmem-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:resolve_pseudo_ldimm64-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:restricted_pointer-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:rtc_str-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:sched_balance_rq-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:should_fail-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:show_als_attr-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:show_als_en-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:show_linear-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:show_thresh_either_en-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:show_zone-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:sil164_encoder_init-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:sil164_probe-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:srcu_notifier_call_chain-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:srcu_read_lock-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:srcu_read_unlock-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:srcu_ref_scale_delay_section-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:srcu_ref_scale_read_section-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:srcu_scale_read_lock-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:srcu_scale_read_unlock-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:srcu_torture_read_lock-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:srcu_torture_read_unlock-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:stack_depot_save-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:stm_source_link_show-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:stm_source_write-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:tda18271_rf_tracking_filters_init-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:tda18271c2_rf_tracking_filters_correction-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:thermal_of_zone_register-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:time_and_date-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:traceoff_count_trigger-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:traceoff_trigger-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:traceon_count_trigger-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:traceon_trigger-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:ubi_notify_add-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:uts_sem-(section:.data)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:uuid_string-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:v4l2_fwnode_parse_link-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:va_format-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:vbin_printf-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:vscnprintf-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:vsnprintf-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:wakeup_sources_read_lock-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:wakeup_sources_read_unlock-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:wakeup_sources_stats_seq_start-(section:.text)-.-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:wakeup_sources_stats_seq_stop-(section:.text)-.-(section:.init.text)
|   `-- WARNING:modpost:vmlinux:section-mismatch-in-reference:xas_store-(section:.text)-.-(section:.init.text)
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
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
|-- hexagon-randconfig-r034-20230220
|   `-- init-initramfs.c:error:use-of-undeclared-identifier-sysfs_bin_attr_simple_read
|-- i386-randconfig-141-20240419
|   |-- drivers-pwm-core.c-pwm_cdev_ioctl()-warn:possible-spectre-second-half.-pwm
|   `-- drivers-pwm-core.c-pwm_cdev_ioctl()-warn:potential-spectre-issue-cdata-pwm-r
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
|   `-- net-ipv6-udp.c:trace-events-udp.h-is-included-more-than-once.
`-- x86_64-allyesconfig
    |-- drivers-gpu-drm-bridge-synopsys-dw-hdmi-i2s-audio.c:error:unused-function-hdmi_read-Werror-Wunused-function
    |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
    |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
    |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_hi_bits-Werror-Wunused-function
    |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_low_bits-Werror-Wunused-function
    `-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast

elapsed time: 723m

configs tested: 180
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240419   gcc  
arc                   randconfig-002-20240419   gcc  
arc                        vdk_hs38_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                      footbridge_defconfig   clang
arm                            mmp2_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240419   gcc  
arm                   randconfig-002-20240419   clang
arm                   randconfig-003-20240419   gcc  
arm                   randconfig-004-20240419   clang
arm                        realview_defconfig   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240419   clang
arm64                 randconfig-002-20240419   clang
arm64                 randconfig-003-20240419   clang
arm64                 randconfig-004-20240419   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240419   gcc  
csky                  randconfig-002-20240419   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240419   clang
hexagon               randconfig-002-20240419   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240419   clang
i386         buildonly-randconfig-002-20240419   gcc  
i386         buildonly-randconfig-003-20240419   gcc  
i386         buildonly-randconfig-004-20240419   gcc  
i386         buildonly-randconfig-005-20240419   gcc  
i386         buildonly-randconfig-006-20240419   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240419   clang
i386                  randconfig-002-20240419   clang
i386                  randconfig-003-20240419   clang
i386                  randconfig-004-20240419   gcc  
i386                  randconfig-005-20240419   clang
i386                  randconfig-006-20240419   clang
i386                  randconfig-011-20240419   gcc  
i386                  randconfig-012-20240419   clang
i386                  randconfig-013-20240419   gcc  
i386                  randconfig-014-20240419   clang
i386                  randconfig-015-20240419   gcc  
i386                  randconfig-016-20240419   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240419   gcc  
loongarch             randconfig-002-20240419   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          multi_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240419   gcc  
nios2                 randconfig-002-20240419   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240419   gcc  
parisc                randconfig-002-20240419   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      cm5200_defconfig   clang
powerpc                      makalu_defconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc                    mvme5100_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc               randconfig-001-20240419   gcc  
powerpc               randconfig-002-20240419   gcc  
powerpc               randconfig-003-20240419   gcc  
powerpc64             randconfig-001-20240419   gcc  
powerpc64             randconfig-002-20240419   gcc  
powerpc64             randconfig-003-20240419   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240419   clang
riscv                 randconfig-002-20240419   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240419   clang
s390                  randconfig-002-20240419   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240419   gcc  
sh                    randconfig-002-20240419   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240419   gcc  
sparc64               randconfig-002-20240419   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240419   gcc  
um                    randconfig-002-20240419   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240419   clang
x86_64       buildonly-randconfig-002-20240419   gcc  
x86_64       buildonly-randconfig-003-20240419   clang
x86_64       buildonly-randconfig-004-20240419   clang
x86_64       buildonly-randconfig-005-20240419   clang
x86_64       buildonly-randconfig-006-20240419   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240419   gcc  
x86_64                randconfig-002-20240419   clang
x86_64                randconfig-003-20240419   gcc  
x86_64                randconfig-004-20240419   gcc  
x86_64                randconfig-005-20240419   clang
x86_64                randconfig-006-20240419   gcc  
x86_64                randconfig-011-20240419   clang
x86_64                randconfig-012-20240419   clang
x86_64                randconfig-013-20240419   clang
x86_64                randconfig-014-20240419   clang
x86_64                randconfig-015-20240419   gcc  
x86_64                randconfig-016-20240419   gcc  
x86_64                randconfig-071-20240419   clang
x86_64                randconfig-072-20240419   gcc  
x86_64                randconfig-073-20240419   clang
x86_64                randconfig-074-20240419   clang
x86_64                randconfig-075-20240419   gcc  
x86_64                randconfig-076-20240419   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240419   gcc  
xtensa                randconfig-002-20240419   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

