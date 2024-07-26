Return-Path: <linux-arch+bounces-5646-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2CB93DAE5
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jul 2024 00:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F3283109
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 22:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4303114F13E;
	Fri, 26 Jul 2024 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VRl6Q+mz"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFEC42AAA;
	Fri, 26 Jul 2024 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034770; cv=none; b=DEsw8Fbd5ZJhlUvAm7RaqWoCK8urHJCa+mnusuOP9DGMcEJOmLyUVU1Ce4THkkd8rp0/DR2Yq64gfDeXyDR2YCwiovM4e4S13abDkbJaJYcqWr7TBm6VCydf3+enAqL11yvHwlkaIx5euLNqq7XKlCatv8Pt1/M9hhtTFNg5ILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034770; c=relaxed/simple;
	bh=g6i4IxKrQxymu9BrVu4SitK6F7MRamuqgZorYTG+Pmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HGOk/FXmJFYoU+o6ljuf0Mi7GYwLM/HvycCYrpCNPX/bRphG9WL6DZTkRiZJ+JQ8hNfihVdBiVoBIgv+7U/QTrKrdlrLMyX1wAmJslsdXNz6IhEHOdXK/1vOX+oh/1ckDUqJRzFsKHJRKOYG8hkcScP2zMgTEW0ca7OeZD6U3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VRl6Q+mz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id C7BA020B7165;
	Fri, 26 Jul 2024 15:59:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C7BA020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722034768;
	bh=Wo4Fp8TkCmVn8yH86WMFCY2WsxtnZocfrfH2vYB+z7M=;
	h=From:To:Cc:Subject:Date:From;
	b=VRl6Q+mz2n9h+9OGx5PWEpyDLC1OWxflY56xHNQnyn+5WmwekkTVJNNi8kVco/EM6
	 DwJOCvFgdznYbNiTdIXbVD0HmIAmzYjW8C5obazj4d2I1Fb+VBfNID9SmVF7awhopk
	 XIIZnXy/HCpf4N6jXHvRENN2Wgdqh5fcgVng8qOA=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kw@linux.com,
	kys@microsoft.com,
	lenb@kernel.org,
	lpieralisi@kernel.org,
	mingo@redhat.com,
	rafael@kernel.org,
	robh@kernel.org,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v3 0/7] arm64: hyperv: Support Virtual Trust Level Boot
Date: Fri, 26 Jul 2024 15:59:03 -0700
Message-Id: <20240726225910.1912537-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch set enables the Hyper-V code to boot on ARM64 inside a Virtual Trust
Level. These levels are a part of the Virtual Secure Mode documented in the
Top-Level Functional Specification available at
https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm

[V3]
    - Employed the SMC recently implemented in the Microsoft Hyper-V hypervisor
      to detect running on Hyper-V/arm64. No dependence on ACPI/DT is needed
      anymore although the source code still falls back to ACPI as the new
      hypervisor might be available only in the Windows Insiders channel just
      yet.
    - As a part of the above, refactored detecting the hypervisor via ACPI FADT.
    - There was a suggestion to explore whether it is feasible or not to express
      that ACPI must be absent for the VTL mode and present for the regular guests
      in the Hyper-V Kconfig file.
      My current conclusion is that this will require refactoring in many places.
      That becomes especially convoluted on x86_64 due to the MSI and APIC
      dependencies. I'd ask to let us tackle that in another patch series (or chalk
      up to nice-have's rather than fires to put out) to separate concerns and
      decrease chances of breakage.
    - While refactoring `get_vtl(void)` and the related code, fixed the hypercall
      output address not to overlap with the input as the Hyper-V TLFS mandates:
      "The input and output parameter lists cannot overlap or cross page boundaries."
      See https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
      for more.
      Some might argue that should've been a topic for a separate patch series;
      I'd counter that the change is well-contained (one line), has no dependencies,
      and makes the code legal.
    - Made the VTL boot code (c)leaner as was suggested.
    - Set DMA cache coherency for the VMBus.
    - Updated DT bindings in the VMBus documentation (separated out into a new patch).
    - Fixed `vmbus_set_irq` to use the API that works both for the ACPI and OF.
    - Reworked setting up the vPCI MSI IRQ domain in the non-ACPI case. The logic
      looks a bit fiddly/ad-hoc as I couldn't find the API that would fit the bill.
      Added comments to explain myself.

[V2]
    https://lore.kernel.org/all/20240514224508.212318-1-romank@linux.microsoft.com/
    - Decreased number of #ifdef's
    - Updated the wording in the commit messages to adhere to the guidlines
    - Sending to the correct set of maintainers and mail lists

[V1]
    https://lore.kernel.org/all/20240510160602.1311352-1-romank@linux.microsoft.com/

For validation, I built kernels for the arch'es in question with the small initrd
embedded into the kernel and booted the Hyper-V VMs off of that.

Roman Kisel (7):
  arm64: hyperv: Use SMC to detect hypervisor presence
  Drivers: hv: Enable VTL mode for arm64
  Drivers: hv: Provide arch-neutral implementation of get_vtl()
  arm64: hyperv: Boot in a Virtual Trust Level
  dt-bindings: bus: Add Hyper-V VMBus cache coherency and IRQs
  Drivers: hv: vmbus: Get the IRQ number from DT
  PCI: hv: Get vPCI MSI IRQ domain from DT

 .../bindings/bus/microsoft,vmbus.yaml         | 11 +++
 arch/arm64/hyperv/Makefile                    |  1 +
 arch/arm64/hyperv/hv_vtl.c                    | 13 ++++
 arch/arm64/hyperv/mshyperv.c                  | 40 +++++++++--
 arch/arm64/include/asm/mshyperv.h             | 12 ++++
 arch/x86/hyperv/hv_init.c                     | 34 ---------
 arch/x86/include/asm/hyperv-tlfs.h            |  7 --
 drivers/hv/Kconfig                            |  6 +-
 drivers/hv/hv_common.c                        | 47 +++++++++++-
 drivers/hv/vmbus_drv.c                        | 72 ++++++++++++++++---
 drivers/pci/controller/pci-hyperv.c           | 55 +++++++++++++-
 include/asm-generic/hyperv-tlfs.h             |  7 ++
 include/asm-generic/mshyperv.h                |  6 ++
 include/linux/hyperv.h                        |  2 +
 14 files changed, 251 insertions(+), 62 deletions(-)
 create mode 100644 arch/arm64/hyperv/hv_vtl.c


base-commit: 831bcbcead6668ebf20b64fdb27518f1362ace3a
-- 
2.34.1


