Return-Path: <linux-arch+bounces-4461-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70AE8C8A4E
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2024 18:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3EA285267
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2024 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ADE13D8A3;
	Fri, 17 May 2024 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFFlCT4h"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE013D888;
	Fri, 17 May 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964688; cv=none; b=dUgJiYhbD7vxFyXGlr9/V74s6XE99r653N2nZ1Y+swbTlLZT7Gjw+cEURONSWDQNUiA3WEnureXKTnlzYz0Pzo8/HSALGr430dFOqQH/NcC0iAl+qESvJBx4q1EO4BH0hvaQJTyNkbgADJ9Yj8dPTmRe5WVlsGXYQP3hBnQ0/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964688; c=relaxed/simple;
	bh=Em01OArLWmTpMWKyYHn6whbhVlL0MJ1UX5RVBow09mc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=p+p9Qf9fObzZBmCqpMJ693R+zjdOyv/trz36Og+Rt3UBp5R2PAdhNsabQCpSDMJoB9Qc4n2DwDpez/bY2+Cz/X5mwIYO3X0u2ripG1yXn6+HjgDiPPLJVawmTyJIjtvi85/uTyUXKwSMmDD/2hnYJCvJGbULIu15FWhOyRhUESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFFlCT4h; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715964681; x=1747500681;
  h=date:from:to:cc:subject:message-id;
  bh=Em01OArLWmTpMWKyYHn6whbhVlL0MJ1UX5RVBow09mc=;
  b=lFFlCT4hvsYv8I9CgfCzt1ftx7FyPmUk6+IuCRbfELFxc/thguGmXEV3
   dvl6sdRRtZwf0lWRdbmYkcmJghM9jupzC6FYWIpdB+lkOBYtnZsZRPU+V
   vEogD1e+rBaZ0qJ1rfhF7csYxpwIMUk9gK02TiFQGl+EMgwZjPxx6TZBz
   5JSZ71k3ZhBWseceNdcJE7MXoABxuolIyoaTSlO2fXSQqEvmM7cBAOEZO
   YNK6i7QLK2H8yhn2fmrqBkBNiQ4dRBYJXRpbDkZOFpbs61uIYNRbjNmX+
   HgGMFI4OIR564SaO4QbGCNmaGX9mpY4kqIyuSGf+Oj1HEnP14cSngGcBn
   g==;
X-CSE-ConnectionGUID: HeWoA/RzTEK+Z2QM0ojNjA==
X-CSE-MsgGUID: 0rvKry/mTC6FlxFV5j/ubw==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="29662192"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="29662192"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 09:51:20 -0700
X-CSE-ConnectionGUID: LN/u327BRl2thkEc8Xxngw==
X-CSE-MsgGUID: SKTs2v/DQ2i/1lywOVDfAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31838973"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 17 May 2024 09:51:15 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s80nY-0000w8-23;
	Fri, 17 May 2024 16:51:12 +0000
Date: Sat, 18 May 2024 00:50:46 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
 nouveau@lists.freedesktop.org
Subject: [linux-next:master] BUILD REGRESSION
 c75962170e49f24399141276ae119e6a879f36dc
Message-ID: <202405180042.wmvlqLl0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: c75962170e49f24399141276ae119e6a879f36dc  Add linux-next specific files for 20240517

Unverified Error/Warning (likely false positive, please contact us if interested):

epoll_busy_poll.c:9: warning: "_GNU_SOURCE" redefined
mseal_test.c:2: warning: "_GNU_SOURCE" redefined
seal_elf.c:2: warning: "_GNU_SOURCE" redefined

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- alpha-randconfig-r052-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arc-randconfig-002-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arm64-randconfig-r051-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- csky-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- csky-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- csky-randconfig-002-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- csky-randconfig-r061-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-buildonly-randconfig-006-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- i386-randconfig-013-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- i386-randconfig-053-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- loongarch-randconfig-001-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- loongarch-randconfig-002-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- m68k-allmodconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- m68k-allyesconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- microblaze-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- microblaze-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- nios2-allmodconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- nios2-allyesconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- nios2-randconfig-002-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- openrisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- openrisc-randconfig-r063-20240517
|   |-- ad9739a.c:(.init.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-__spi_register_driver
|   |-- ad9739a.c:(.init.text):undefined-reference-to-__spi_register_driver
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   |-- regmap-spi.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-spi_async
|   |-- regmap-spi.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-spi_sync
|   |-- regmap-spi.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-spi_write_then_read
|   |-- regmap-spi.c:(.text):undefined-reference-to-spi_async
|   |-- regmap-spi.c:(.text):undefined-reference-to-spi_sync
|   `-- regmap-spi.c:(.text):undefined-reference-to-spi_write_then_read
|-- parisc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- parisc-randconfig-001-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- parisc-randconfig-002-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- parisc-randconfig-r064-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- powerpc64-randconfig-001-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- powerpc64-randconfig-002-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- riscv-randconfig-002-20240517
|   |-- arch-riscv-errata-andes-errata.c:error:RISCV_VENDOR_EXT_ALTERNATIVES_BASE-undeclared-(first-use-in-this-function)
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- s390-randconfig-r054-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-allmodconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-allyesconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-randconfig-002-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sparc-randconfig-002-20240517
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sparc64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sparc64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- um-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- kernel-bpf-verifier.c:error:pcpu_hot-undeclared-(first-use-in-this-function)
|-- um-randconfig-002-20240517
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- kernel-bpf-verifier.c:error:pcpu_hot-undeclared-(first-use-in-this-function)
|-- x86_64-buildonly-randconfig-002-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-buildonly-randconfig-004-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-buildonly-randconfig-005-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-004-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-015-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-016-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-072-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-073-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-074-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-075-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-101-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- x86_64-randconfig-103-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- x86_64-rhel-8.3-bpf
|   |-- epoll_busy_poll.c:warning:_GNU_SOURCE-redefined
|   |-- mseal_test.c:warning:_GNU_SOURCE-redefined
|   `-- seal_elf.c:warning:_GNU_SOURCE-redefined
`-- xtensa-randconfig-002-20240517
    `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
clang_recent_errors
|-- arm-randconfig-002-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- arm-randconfig-003-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- arm-randconfig-004-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
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
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- arm64-randconfig-004-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- hexagon-allmodconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|-- hexagon-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|-- hexagon-randconfig-001-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-buildonly-randconfig-002-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- i386-randconfig-015-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- i386-randconfig-016-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- i386-randconfig-051-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- i386-randconfig-141-20240517
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- lib-fortify_kunit.c-fortify_test_strcpy()-error:strcpy()-src-too-large-for-pad.buf-(-vs-)
|   `-- net-ipv6-route.c-rt6_fill_node()-error:we-previously-assumed-dst-could-be-null-(see-line-)
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- powerpc-randconfig-001-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- powerpc-randconfig-002-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- powerpc64-randconfig-003-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- riscv-allmodconfig
|   |-- arch-riscv-errata-andes-errata.c:error:use-of-undeclared-identifier-RISCV_VENDOR_EXT_ALTERNATIVES_BASE
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
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
|   |-- drivers-irqchip-irq-riscv-imsic-early.c:error:too-many-arguments-to-function-call-expected-have
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- riscv-allyesconfig
|   |-- arch-riscv-errata-andes-errata.c:error:use-of-undeclared-identifier-RISCV_VENDOR_EXT_ALTERNATIVES_BASE
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-irqchip-irq-riscv-imsic-early.c:error:too-many-arguments-to-function-call-expected-have
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- riscv-defconfig
|   `-- drivers-irqchip-irq-riscv-imsic-early.c:error:too-many-arguments-to-function-call-expected-have
|-- riscv-nommu_k210_defconfig
|   `-- drivers-irqchip-irq-riscv-imsic-early.c:error:too-many-arguments-to-function-call-expected-have
|-- riscv-randconfig-001-20240517
|   |-- drivers-irqchip-irq-riscv-imsic-early.c:error:too-many-arguments-to-function-call-expected-have
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
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
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|-- s390-randconfig-002-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-buildonly-randconfig-001-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-buildonly-randconfig-003-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-buildonly-randconfig-006-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-001-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-002-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-003-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-006-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-011-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-012-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-014-20240517
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Excess-function-parameter-timing-description-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-last_segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-optc-dcn35-dcn35_optc.c:warning:Function-parameter-or-struct-member-segment_width-not-described-in-optc35_set_odm_combine
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-076-20240517
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
`-- x86_64-randconfig-161-20240517
    |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
    |-- lib-fortify_kunit.c-fortify_test_strcpy()-error:strcpy()-src-too-large-for-pad.buf-(-vs-)
    `-- net-ipv6-route.c-rt6_fill_node()-error:we-previously-assumed-dst-could-be-null-(see-line-)

elapsed time: 725m

configs tested: 179
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240517   gcc  
arc                   randconfig-002-20240517   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          moxart_defconfig   gcc  
arm                        mvebu_v7_defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240517   clang
arm                   randconfig-002-20240517   clang
arm                   randconfig-003-20240517   clang
arm                   randconfig-004-20240517   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240517   clang
arm64                 randconfig-002-20240517   gcc  
arm64                 randconfig-003-20240517   clang
arm64                 randconfig-004-20240517   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240517   gcc  
csky                  randconfig-002-20240517   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240517   clang
hexagon               randconfig-002-20240517   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240517   clang
i386         buildonly-randconfig-002-20240517   clang
i386         buildonly-randconfig-003-20240517   gcc  
i386         buildonly-randconfig-004-20240517   clang
i386         buildonly-randconfig-005-20240517   clang
i386         buildonly-randconfig-006-20240517   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240517   gcc  
i386                  randconfig-002-20240517   gcc  
i386                  randconfig-003-20240517   gcc  
i386                  randconfig-004-20240517   gcc  
i386                  randconfig-005-20240517   gcc  
i386                  randconfig-006-20240517   gcc  
i386                  randconfig-011-20240517   gcc  
i386                  randconfig-012-20240517   clang
i386                  randconfig-013-20240517   gcc  
i386                  randconfig-014-20240517   gcc  
i386                  randconfig-015-20240517   clang
i386                  randconfig-016-20240517   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240517   gcc  
loongarch             randconfig-002-20240517   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         rt305x_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240517   gcc  
nios2                 randconfig-002-20240517   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240517   gcc  
parisc                randconfig-002-20240517   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 linkstation_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc               randconfig-001-20240517   clang
powerpc               randconfig-002-20240517   clang
powerpc               randconfig-003-20240517   gcc  
powerpc                     stx_gp3_defconfig   clang
powerpc                     tqm8555_defconfig   clang
powerpc64             randconfig-001-20240517   gcc  
powerpc64             randconfig-002-20240517   gcc  
powerpc64             randconfig-003-20240517   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_k210_defconfig   clang
riscv                 randconfig-001-20240517   clang
riscv                 randconfig-002-20240517   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240517   clang
s390                  randconfig-002-20240517   clang
s390                       zfcpdump_defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240517   gcc  
sh                    randconfig-002-20240517   gcc  
sh                           se7619_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240517   gcc  
sparc64               randconfig-002-20240517   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240517   clang
um                    randconfig-002-20240517   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240517   clang
x86_64       buildonly-randconfig-002-20240517   gcc  
x86_64       buildonly-randconfig-003-20240517   clang
x86_64       buildonly-randconfig-004-20240517   gcc  
x86_64       buildonly-randconfig-005-20240517   gcc  
x86_64       buildonly-randconfig-006-20240517   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240517   clang
x86_64                randconfig-002-20240517   clang
x86_64                randconfig-003-20240517   clang
x86_64                randconfig-004-20240517   gcc  
x86_64                randconfig-005-20240517   gcc  
x86_64                randconfig-006-20240517   clang
x86_64                randconfig-011-20240517   clang
x86_64                randconfig-012-20240517   clang
x86_64                randconfig-013-20240517   clang
x86_64                randconfig-014-20240517   clang
x86_64                randconfig-015-20240517   gcc  
x86_64                randconfig-016-20240517   gcc  
x86_64                randconfig-071-20240517   clang
x86_64                randconfig-072-20240517   gcc  
x86_64                randconfig-073-20240517   gcc  
x86_64                randconfig-074-20240517   gcc  
x86_64                randconfig-075-20240517   gcc  
x86_64                randconfig-076-20240517   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240517   gcc  
xtensa                randconfig-002-20240517   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

