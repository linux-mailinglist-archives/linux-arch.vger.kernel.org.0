Return-Path: <linux-arch+bounces-4439-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469198C6CD7
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 21:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2159DB20DCF
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 19:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB4715A4B7;
	Wed, 15 May 2024 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvO/SXO8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031E3219F;
	Wed, 15 May 2024 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801295; cv=none; b=OXQku3YhYYOR3IMlLAK/27F4ekph1d9FshJJFrWUVxOr/acDeI9abVCQ8g7YNSPm+AO298+Z1zdcBhTZ20qpe06jmPps3MEfKkQSFRm0aWFr/bL80iTltS1mxCzmpZXBUqoLQysJtPB8ugqTx55BgOhtMfc4JXtG/D8QkmW7hQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801295; c=relaxed/simple;
	bh=ny/G4peRMRBFnY0gQRNDaw+uPKRudupBqUA6vorS314=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cZRx4QIbsnXC49vg8ea+pdgIhy4BchZPNmRqi0nIKqi2WoMuMHwSQjSQ79ZE9mB9DWhjjflow7k8K9bLqW+aGgoeWgi6UzH0Qwy8AzZQB5sK5ma20vGyjvNAUw79GI2Y3y1Gqcoi6z/8YD5h81g9ABfBNkX03um8JmloMLMiJ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvO/SXO8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715801287; x=1747337287;
  h=date:from:to:cc:subject:message-id;
  bh=ny/G4peRMRBFnY0gQRNDaw+uPKRudupBqUA6vorS314=;
  b=UvO/SXO8y4O0f0Vn1M0jbTX2Ddj7hKTzR5AxsZjpwq4dWy+uGH1E1XUX
   XeThzxv8GwZHiyPH0Rft74z66BybXhd6mm0kGapWNajniFnsKxRK61KI2
   eJpSMBCHzRzv6+dYInTG1Sv5I6IoA4S9KGvdOqMbLBKo92KzbsW2iMzgP
   uSI2vOvLYgPt11MQsnqfE99A/KmyZgL8Ma0p0IrHWU5u4oZHEM1siHiF3
   UdSe7+0PxJyV9y38Ra75iJwHbmgG0zJYImql6WMbD7GpaVS4SAr1wxwQN
   fBrOpn9FADnuiWzRa2ICJHVRMgb8CtRQ/YCdr93wabkyxYrh2pFbh3Tu7
   Q==;
X-CSE-ConnectionGUID: VUcwdjWMQvO4PwN6cpKGfw==
X-CSE-MsgGUID: q8pq0ozvQWeWmbpKeg26qg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="14827820"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="14827820"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 12:28:06 -0700
X-CSE-ConnectionGUID: EC3WzvVQQcyMAkIsWiMtsA==
X-CSE-MsgGUID: iQH2mgmYRXucHpeiOoqr/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="31292876"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 15 May 2024 12:28:01 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7KIA-000DBz-2r;
	Wed, 15 May 2024 19:27:58 +0000
Date: Thu, 16 May 2024 03:27:51 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
 nouveau@lists.freedesktop.org
Subject: [linux-next:master] BUILD REGRESSION
 82d92a9a1b9ea0ea52aff27cddd05009b4edad49
Message-ID: <202405160346.lU8UKigF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 82d92a9a1b9ea0ea52aff27cddd05009b4edad49  Add linux-next specific files for 20240515

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202405152211.4swEsJn5-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405160254.xCnm7yhf-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405160258.9OzdnO6y-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

(.text+0x249c): undefined reference to `pci_epc_deinit_notify'
ERROR: modpost: "pci_epc_deinit_notify" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
alpha-linux-ld: (.text+0x24a0): undefined reference to `pci_epc_deinit_notify'
drivers/gpu/drm/drm_mm.c:614:20: error: function 'drm_mm_node_scanned_block' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
drivers/gpu/drm/imx/ipuv3/imx-ldb.c:658:57: error: '_sel' directive output may be truncated writing 4 bytes into a region of size between 3 and 13 [-Werror=format-truncation=]
drivers/gpu/drm/nouveau/nouveau_backlight.c:56:69: error: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 3 [-Werror=format-truncation=]
drivers/gpu/drm/panel/panel-lg-sw43408.c:106:(.text+0x375): undefined reference to `drm_dsc_pps_payload_pack'
drivers/irqchip/irq-riscv-imsic-early.c:52:47: error: too many arguments to function call, expected 2, have 3
include/asm-generic/io.h:548:31: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]

Unverified Error/Warning (likely false positive, please contact us if interested):

{standard input}:1075: Warning: overflow in branch to .L161; converted into longer instruction sequence

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
|-- alpha-randconfig-r052-20230726
|   |-- (.text):undefined-reference-to-pci_epc_deinit_notify
|   `-- alpha-linux-ld:(.text):undefined-reference-to-pci_epc_deinit_notify
|-- alpha-randconfig-r133-20240515
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
|-- arm64-randconfig-r062-20240515
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
|-- csky-randconfig-001-20240515
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
|-- i386-buildonly-randconfig-002-20240515
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
|-- i386-buildonly-randconfig-003-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-buildonly-randconfig-005-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-002-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-003-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-004-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-012-20240515
|   |-- drivers-gpu-drm-panel-panel-lg-sw43408.c:(.text):undefined-reference-to-drm_dsc_pps_payload_pack
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-014-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-053-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-054-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-061-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-141-20240515
|   |-- drivers-dma-fsl-edma-common.c-fsl_edma_fill_tcd()-warn:statement-has-no-effect
|   |-- drivers-dma-fsl-edma-common.c-fsl_edma_set_tcd_regs()-warn:statement-has-no-effect
|   |-- drivers-dma-fsl-edma-main.c-fsl_edma_probe()-warn:statement-has-no-effect
|   |-- drivers-dma-fsl-edma-main.c-fsl_edma_resume_early()-warn:statement-has-no-effect
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   |-- lib-fortify_kunit.c-fortify_test_strcpy()-error:strcpy()-src-too-large-for-pad.buf-(-vs-)
|   `-- net-ipv6-route.c-rt6_fill_node()-error:we-previously-assumed-dst-could-be-null-(see-line-)
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
|-- loongarch-loongson3_defconfig
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
|-- loongarch-randconfig-001-20240515
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
|-- loongarch-randconfig-002-20240515
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
|-- loongarch-randconfig-r052-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- m68k-allmodconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- m68k-allyesconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- m68k-randconfig-r131-20240515
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
|-- nios2-randconfig-r053-20240515
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
|-- openrisc-randconfig-r054-20240515
|   |-- drivers-gpu-drm-arm-display-komeda-komeda_dev.c:error:implicit-declaration-of-function-seq_puts
|   |-- drivers-gpu-drm-arm-display-komeda-komeda_dev.c:error:invalid-use-of-undefined-type-struct-seq_file
|   |-- drivers-gpu-drm-arm-display-komeda-komeda_dev.c:error:type-defaults-to-int-in-declaration-of-DEFINE_SHOW_ATTRIBUTE
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
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
|-- parisc-randconfig-001-20240515
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
|-- parisc-randconfig-r051-20240515
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
|-- powerpc-randconfig-003-20240515
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
|-- powerpc64-randconfig-001-20240515
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
|-- powerpc64-randconfig-003-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- powerpc64-randconfig-r061-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- riscv-randconfig-002-20240515
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
|-- s390-randconfig-r082-20230821
|   `-- ERROR:pci_epc_deinit_notify-drivers-pci-controller-dwc-pcie-tegra194.ko-undefined
|-- sh-allmodconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-allyesconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-randconfig-002-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-randconfig-r132-20240223
|   `-- standard-input:Warning:overflow-in-branch-to-.L161-converted-into-longer-instruction-sequence
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
|-- sparc-randconfig-001-20240515
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   |-- (.init.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-symbol-leon_smp_cpu_startup-defined-in-.text-section-in-arch-sparc-kernel-trampoline_32.o
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sparc-randconfig-002-20240515
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
|-- sparc64-randconfig-001-20240515
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
|-- sparc64-randconfig-002-20240515
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
|-- um-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- kernel-bpf-verifier.c:error:pcpu_hot-undeclared-(first-use-in-this-function)
|-- um-randconfig-001-20240515
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- kernel-bpf-verifier.c:error:pcpu_hot-undeclared-(first-use-in-this-function)
|-- um-randconfig-002-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-buildonly-randconfig-006-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-014-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-071-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-072-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-073-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-076-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-121-20240515
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
|-- x86_64-randconfig-123-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- xtensa-randconfig-001-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
`-- xtensa-randconfig-002-20240515
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
    `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
clang_recent_errors
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
|-- hexagon-allmodconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|-- hexagon-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|-- hexagon-randconfig-001-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- hexagon-randconfig-002-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- hexagon-randconfig-r064-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-buildonly-randconfig-006-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-001-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-011-20240515
|   |-- drivers-gpu-drm-drm_mm.c:error:function-drm_mm_node_scanned_block-is-not-needed-and-will-not-be-emitted-Werror-Wunneeded-internal-declaration
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-013-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-051-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-052-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- powerpc-randconfig-001-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- powerpc-randconfig-r132-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- powerpc64-randconfig-002-20240515
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
|-- powerpc64-randconfig-r121-20240515
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
|-- riscv-allmodconfig
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
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- riscv-defconfig
|   `-- drivers-irqchip-irq-riscv-imsic-early.c:error:too-many-arguments-to-function-call-expected-have
|-- riscv-randconfig-001-20240515
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
|-- s390-randconfig-001-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- s390-randconfig-002-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-allnoconfig
|   `-- net-ipv6-udp.c:trace-events-udp.h-is-included-more-than-once.
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
|-- x86_64-buildonly-randconfig-004-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-003-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-004-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-005-20240515
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
|-- x86_64-randconfig-006-20240515
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
|-- x86_64-randconfig-011-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-012-20240515
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
|-- x86_64-randconfig-015-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-016-20240515
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-075-20240515
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
|-- x86_64-randconfig-103-20240515
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
|-- x86_64-randconfig-161-20240515
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- net-ipv6-route.c-rt6_fill_node()-error:we-previously-assumed-dst-could-be-null-(see-line-)
`-- x86_64-randconfig-r063-20240515
    `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops

elapsed time: 730m

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
arc                   randconfig-001-20240515   gcc  
arc                   randconfig-002-20240515   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20240515   clang
arm                   randconfig-002-20240515   gcc  
arm                   randconfig-003-20240515   clang
arm                   randconfig-004-20240515   gcc  
arm                        spear6xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240515   gcc  
arm64                 randconfig-002-20240515   clang
arm64                 randconfig-003-20240515   clang
arm64                 randconfig-004-20240515   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240515   gcc  
csky                  randconfig-002-20240515   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240515   clang
hexagon               randconfig-002-20240515   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240515   gcc  
i386         buildonly-randconfig-002-20240515   gcc  
i386         buildonly-randconfig-003-20240515   gcc  
i386         buildonly-randconfig-004-20240515   gcc  
i386         buildonly-randconfig-005-20240515   gcc  
i386         buildonly-randconfig-006-20240515   clang
i386                                defconfig   clang
i386                  randconfig-001-20240515   clang
i386                  randconfig-002-20240515   gcc  
i386                  randconfig-003-20240515   gcc  
i386                  randconfig-004-20240515   gcc  
i386                  randconfig-005-20240515   clang
i386                  randconfig-006-20240515   gcc  
i386                  randconfig-011-20240515   clang
i386                  randconfig-012-20240515   gcc  
i386                  randconfig-013-20240515   clang
i386                  randconfig-014-20240515   gcc  
i386                  randconfig-015-20240515   gcc  
i386                  randconfig-016-20240515   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240515   gcc  
loongarch             randconfig-002-20240515   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                          ath79_defconfig   gcc  
mips                         db1xxx_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240515   gcc  
nios2                 randconfig-002-20240515   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240515   gcc  
parisc                randconfig-002-20240515   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       holly_defconfig   clang
powerpc                   motionpro_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc               randconfig-001-20240515   clang
powerpc               randconfig-002-20240515   clang
powerpc               randconfig-003-20240515   gcc  
powerpc64             randconfig-001-20240515   gcc  
powerpc64             randconfig-002-20240515   clang
powerpc64             randconfig-003-20240515   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20240515   clang
riscv                 randconfig-002-20240515   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240515   clang
s390                  randconfig-002-20240515   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20240515   gcc  
sh                    randconfig-002-20240515   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240515   gcc  
sparc64               randconfig-002-20240515   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240515   gcc  
um                    randconfig-002-20240515   gcc  
um                           x86_64_defconfig   clang
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240515   gcc  
x86_64       buildonly-randconfig-002-20240515   gcc  
x86_64       buildonly-randconfig-003-20240515   clang
x86_64       buildonly-randconfig-004-20240515   clang
x86_64       buildonly-randconfig-005-20240515   clang
x86_64       buildonly-randconfig-006-20240515   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240515   gcc  
x86_64                randconfig-002-20240515   clang
x86_64                randconfig-003-20240515   clang
x86_64                randconfig-004-20240515   clang
x86_64                randconfig-005-20240515   clang
x86_64                randconfig-006-20240515   clang
x86_64                randconfig-011-20240515   clang
x86_64                randconfig-012-20240515   clang
x86_64                randconfig-013-20240515   gcc  
x86_64                randconfig-014-20240515   gcc  
x86_64                randconfig-015-20240515   clang
x86_64                randconfig-016-20240515   clang
x86_64                randconfig-071-20240515   gcc  
x86_64                randconfig-072-20240515   gcc  
x86_64                randconfig-073-20240515   gcc  
x86_64                randconfig-074-20240515   clang
x86_64                randconfig-075-20240515   clang
x86_64                randconfig-076-20240515   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20240515   gcc  
xtensa                randconfig-002-20240515   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

