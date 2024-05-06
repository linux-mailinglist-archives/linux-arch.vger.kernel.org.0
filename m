Return-Path: <linux-arch+bounces-4227-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3318BD633
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 22:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CA9282CE5
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 20:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7674E15B108;
	Mon,  6 May 2024 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQn2Zb2g"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC715B0EF;
	Mon,  6 May 2024 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027238; cv=none; b=YCI6pUSIzwgAZh7QPUWCQQI9lGEtfmhOJWmguywSCKi/esSuBc7tdH+s1lFbCg1FmH3M+4kXTmfEreQuPvSCPiSQ4tO2jtBKXPQybLYFgdpO7wkmy7TT1vX4m0VXYyF+qaveQuQtJ3tRkt7H5YmCDQoSeUMQ8O6AYrS6L93Q2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027238; c=relaxed/simple;
	bh=xnc4rO7MPMXCVwsJ/PyzqYsnGk8ihZ+i0/D/c/yLzZo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oK73EftgCDIFoa2L8mvRPjC5ArD3M/KC2QlWj59yVRJv8uJwVXtHBS+eAJzUwVx4K8ZCh8ujV9fLMZbRD6mq9RWsw0HiJlpMHY+sfDH2mvRWXnk54DXQdBbt7OW9ufnFCOOvPg4bY6RfblLnfwnvZCPv+pFgvw0L9sp2U1huVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQn2Zb2g; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715027230; x=1746563230;
  h=date:from:to:cc:subject:message-id;
  bh=xnc4rO7MPMXCVwsJ/PyzqYsnGk8ihZ+i0/D/c/yLzZo=;
  b=dQn2Zb2gkAdjXk3Fd2bieyD5E6TIp1VPWjdDzinnXP99H/MHrODDojUB
   /yaisgjyrEh/PjbV6BSydaU2FFGgbxBNLlE1HEmxZnuHJODVwNR+ljmQt
   z80LiegSCuJ+fy5Z/gLPULbEgfQf13wQLvZsqfoBeHjZJhC+rtsaKh2ld
   /yLYp7QBuwVE0MOjRezUQ4qNWbXtz0bM4mhJIyRVnjKc0JXybGKCo3Y/8
   EzTWTa9sJI//ZRYuOfl+T0gQX4GG9cSWKoX8zb4e8TIcKZBZrZwy1Ktom
   XedjEy/fFRNe9Sna6b4UHje+dKsS+zI/QfXxAwR+F4/J2mTJq3BZGAv5b
   g==;
X-CSE-ConnectionGUID: BPKnbfLDSu25FErgEawEPQ==
X-CSE-MsgGUID: ucjXPujRSm6uAaK0t1NYWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10956360"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="10956360"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 13:27:05 -0700
X-CSE-ConnectionGUID: 0YOJYKkhRem/7jTWS8Hzeg==
X-CSE-MsgGUID: vnkDzX4URda79OJn4KdMoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="59133011"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 May 2024 13:27:01 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s44vK-00011D-1J;
	Mon, 06 May 2024 20:26:58 +0000
Date: Tue, 07 May 2024 04:26:17 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 nouveau@lists.freedesktop.org
Subject: [linux-next:master] BUILD REGRESSION
 2b84edefcad14934796fad37b16512b6a2ca467e
Message-ID: <202405070413.iX406m5Z-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 2b84edefcad14934796fad37b16512b6a2ca467e  Add linux-next specific files for 20240506

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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
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
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
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
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-allmodconfig
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-allyesconfig
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-randconfig-003-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arm64-defconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm64-randconfig-001-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- csky-randconfig-002-20240506
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- csky-randconfig-r053-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- csky-randconfig-r054-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- csky-randconfig-r133-20240506
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dmub-src-dmub_dcn401.c:sparse:sparse:static-assertion-failed:DMUB-command-size-mismatch
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
|   `-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- i386-allmodconfig
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
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-allyesconfig
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
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-buildonly-randconfig-001-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-buildonly-randconfig-003-20240506
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
|-- i386-buildonly-randconfig-004-20240506
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
|-- i386-buildonly-randconfig-005-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-001-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-003-20240506
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
|-- i386-randconfig-006-20240506
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
|-- i386-randconfig-011-20240506
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
|-- i386-randconfig-012-20240506
|   |-- drivers-gpu-drm-panel-panel-lg-sw43408.c:(.text):undefined-reference-to-drm_dsc_pps_payload_pack
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-051-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-063-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-141-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   `-- net-ipv6-route.c-rt6_fill_node()-error:we-previously-assumed-dst-could-be-null-(see-line-)
|-- i386-randconfig-r051-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- loongarch-allmodconfig
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- loongarch-defconfig
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
|   `-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- loongarch-randconfig-001-20240506
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- loongarch-randconfig-002-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- m68k-allmodconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- m68k-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- m68k-randconfig-r121-20240506
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- microblaze-randconfig-r122-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
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
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- mips-randconfig-r062-20240506
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- nios2-allmodconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- nios2-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- nios2-randconfig-001-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- nios2-randconfig-002-20240506
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- parisc-randconfig-001-20240506
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
|   `-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- parisc-randconfig-002-20240506
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- powerpc-allmodconfig
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- powerpc-randconfig-001-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- powerpc-randconfig-r061-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- riscv-randconfig-002-20240506
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- riscv-randconfig-r111-20240506
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- s390-randconfig-001-20240506
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sh-allmodconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-allyesconfig
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sparc-randconfig-001-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sparc-randconfig-r112-20240506
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   |-- (.init.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-symbol-leon_smp_cpu_startup-defined-in-.text-section-in-arch-sparc-kernel-trampoline_32.o
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sparc64-randconfig-001-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sparc64-randconfig-002-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- um-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-buildonly-randconfig-001-20240506
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-buildonly-randconfig-002-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-buildonly-randconfig-003-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-011-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-012-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-013-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-014-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-015-20240506
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-071-20240506
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-073-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-075-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-102-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-103-20240506
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-104-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-161-20240506
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
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- lib-fortify_kunit.c-fortify_test_strcpy()-error:strcpy()-src-too-large-for-pad.buf-(-vs-)
|-- xtensa-randconfig-001-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
`-- xtensa-randconfig-002-20240506
    `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
clang_recent_errors
|-- arm-defconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-randconfig-001-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- arm-randconfig-004-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- arm64-randconfig-003-20240506
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
|-- arm64-randconfig-004-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- hexagon-allmodconfig
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|-- hexagon-allyesconfig
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|-- hexagon-randconfig-001-20240506
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- hexagon-randconfig-002-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-buildonly-randconfig-006-20240506
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
|-- i386-randconfig-002-20240506
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
|-- i386-randconfig-004-20240506
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-005-20240506
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
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-014-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-015-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-016-20240506
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   `-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|-- i386-randconfig-053-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-054-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-061-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-062-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- powerpc64-randconfig-001-20240506
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
|-- powerpc64-randconfig-002-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- powerpc64-randconfig-003-20240506
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- riscv-randconfig-001-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   |-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-node_stat_item-and-enum-lru_list-)-Werror-Wenum-enum-conversion
|   `-- include-linux-vmstat.h:error:arithmetic-between-different-enumeration-types-(-enum-zone_stat_item-and-enum-numa_stat_item-)-Werror-Wenum-enum-conversion
|-- x86_64-allnoconfig
|   |-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-display-exynos
|   |-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-reserved-memory-qcom
|   `-- net-ipv6-udp.c:trace-events-udp.h-is-included-more-than-once.
|-- x86_64-allyesconfig
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
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_insert-Werror-Wunused-function
|   |-- drivers-gpu-drm-drm_mm.c:error:unused-function-drm_mm_interval_tree_iter_next-Werror-Wunused-function
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-buildonly-randconfig-004-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-buildonly-randconfig-005-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-001-20240506
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
|-- x86_64-randconfig-003-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-005-20240506
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
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-006-20240506
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
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-076-20240506
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
|-- x86_64-randconfig-121-20240506
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_dcn4_calcs.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_core-dml2_core_shared.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_dpmm-dml2_dpmm_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_mcg-dml2_mcg_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_dcn4.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_pmo-dml2_pmo_factory.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dml2-dml21-src-dml2_top-dml_top_mcache.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dmub-src-dmub_dcn401.c:sparse:sparse:static-assertion-failed:DMUB-command-size-mismatch
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
|-- x86_64-randconfig-122-20240506
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-123-20240506
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
`-- x86_64-randconfig-r063-20240506
    |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
    |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
    |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
    |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
    |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
    |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
    |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
    `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used

elapsed time: 729m

configs tested: 180
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240506   gcc  
arc                   randconfig-002-20240506   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                         nhk8815_defconfig   clang
arm                   randconfig-001-20240506   clang
arm                   randconfig-002-20240506   clang
arm                   randconfig-003-20240506   gcc  
arm                   randconfig-004-20240506   clang
arm                         s3c6400_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240506   gcc  
arm64                 randconfig-002-20240506   gcc  
arm64                 randconfig-003-20240506   clang
arm64                 randconfig-004-20240506   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240506   gcc  
csky                  randconfig-002-20240506   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240506   clang
hexagon               randconfig-002-20240506   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240506   gcc  
i386         buildonly-randconfig-002-20240506   clang
i386         buildonly-randconfig-003-20240506   gcc  
i386         buildonly-randconfig-004-20240506   gcc  
i386         buildonly-randconfig-005-20240506   gcc  
i386         buildonly-randconfig-006-20240506   clang
i386                                defconfig   clang
i386                  randconfig-001-20240506   gcc  
i386                  randconfig-002-20240506   clang
i386                  randconfig-003-20240506   gcc  
i386                  randconfig-004-20240506   clang
i386                  randconfig-005-20240506   clang
i386                  randconfig-006-20240506   gcc  
i386                  randconfig-011-20240506   gcc  
i386                  randconfig-012-20240506   gcc  
i386                  randconfig-013-20240506   gcc  
i386                  randconfig-014-20240506   clang
i386                  randconfig-015-20240506   clang
i386                  randconfig-016-20240506   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240506   gcc  
loongarch             randconfig-002-20240506   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   clang
mips                           ip32_defconfig   clang
mips                           xway_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240506   gcc  
nios2                 randconfig-002-20240506   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240506   gcc  
parisc                randconfig-002-20240506   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 linkstation_defconfig   clang
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240506   gcc  
powerpc               randconfig-002-20240506   clang
powerpc               randconfig-003-20240506   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc64             randconfig-001-20240506   clang
powerpc64             randconfig-002-20240506   clang
powerpc64             randconfig-003-20240506   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240506   clang
riscv                 randconfig-002-20240506   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240506   gcc  
s390                  randconfig-002-20240506   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240506   gcc  
sh                    randconfig-002-20240506   gcc  
sh                           se7724_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240506   gcc  
sparc64               randconfig-002-20240506   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240506   clang
um                    randconfig-002-20240506   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240506   gcc  
x86_64       buildonly-randconfig-002-20240506   gcc  
x86_64       buildonly-randconfig-003-20240506   gcc  
x86_64       buildonly-randconfig-004-20240506   clang
x86_64       buildonly-randconfig-005-20240506   clang
x86_64       buildonly-randconfig-006-20240506   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240506   clang
x86_64                randconfig-002-20240506   clang
x86_64                randconfig-003-20240506   clang
x86_64                randconfig-004-20240506   clang
x86_64                randconfig-005-20240506   clang
x86_64                randconfig-006-20240506   clang
x86_64                randconfig-011-20240506   gcc  
x86_64                randconfig-012-20240506   gcc  
x86_64                randconfig-013-20240506   gcc  
x86_64                randconfig-014-20240506   gcc  
x86_64                randconfig-015-20240506   gcc  
x86_64                randconfig-016-20240506   gcc  
x86_64                randconfig-071-20240506   gcc  
x86_64                randconfig-072-20240506   clang
x86_64                randconfig-073-20240506   gcc  
x86_64                randconfig-074-20240506   clang
x86_64                randconfig-075-20240506   gcc  
x86_64                randconfig-076-20240506   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240506   gcc  
xtensa                randconfig-002-20240506   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

