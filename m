Return-Path: <linux-arch+bounces-7670-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1553E98F742
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 21:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F36282E27
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 19:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9A71B85CA;
	Thu,  3 Oct 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iaCjs6Wo"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A6F1AC8B9;
	Thu,  3 Oct 2024 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727985078; cv=none; b=ewVvQeQKviZOsQ4Ex9NBQOXt+1hcpkJyiLS+CBLU04Ykp1uCq5AZPo2vNMI3j55KYP2OsHTYzMApVK1WkT2goWy+bnjrKney2ZJoQ3B8gCjy5PEBuptuZ0avedRR1tId2z7h3MT67AiJAshb4wPsgwSX3GN0GbeLzpVLSk0+b7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727985078; c=relaxed/simple;
	bh=LvXuW07DElmphyGOeOxZTYcc5I17BlWgMBispM9Tm0w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FVxH7YzJs+ZvUNrgabBhGhvOhApLzQzWtjoYSLIsNFwNRajk6KBnhDxfxuMJyl149y4CDA4mogrxWXhwZtOUYrFZ2rcc1/NbFCnQkN0ALdIeiaD/5cd6d0XcrnI9JidAF3Olle+Dp7s3hQBYANOUXfflhSGcqu6tLYEbvWn/GKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iaCjs6Wo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D046520DB35D;
	Thu,  3 Oct 2024 12:51:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D046520DB35D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727985069;
	bh=nHGX8zwwOomC34dyU6ixeYDufe9vxK5rO4mA9Rus51s=;
	h=From:To:Cc:Subject:Date:From;
	b=iaCjs6WodUbua+uhfLTMTGJP+jo8u/Ibyom3MPqrld6rOPAcIq3clyN04GFNZxD7o
	 F4+idAjqql3s/AtcZibCieqsrWZnfMrJuFDoVS423rFzlmEeEiKcqiOibiDmoiNPXF
	 l+KBC+uTKON85PgSs1bs0u1xWYYmhsJOVKSYjthI=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	peterz@infradead.org,
	daniel.lezcano@linaro.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	sgarzare@redhat.com,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com
Subject: [PATCH 0/5] Add new headers for Hyper-V Dom0
Date: Thu,  3 Oct 2024 12:50:59 -0700
Message-Id: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

To support Hyper-V Dom0 (aka Linux as root partition), many new
definitions are required.

The plan going forward is to directly import headers from
Hyper-V. This is a more maintainable way to import definitions
rather than via the TLFS doc. This patch series introduces
new headers (hvhdk.h, hvgdk.h, etc, see patch #3) directly
derived from Hyper-V code.

This patch series replaces hyperv-tlfs.h with hvhdk.h, but only
in Microsoft-maintained Hyper-V code where they are needed. This
leaves the existing hyperv-tlfs.h in use elsewhere - notably for
Hyper-V enlightenments on KVM guests.

An intermediary header "hv_defs.h" is introduced to conditionally
include either hyperv-tlfs.h or hvhdk.h. This is required because
several headers which today include hyperv-tlfs.h, are shared
between Hyper-V and KVM code (e.g. mshyperv.h).

Summary:
Patch 1-2: Cleanup patches
Patch 3: Add the new headers (hvhdk.h, etc..) in include/hyperv/
Patch 4: Add hv_defs.h and use it in mshyperv.h, svm.h,
         hyperv_timer.h
Patch 5: Switch to the new headers, only in Hyper-V code

Nuno Das Neves (5):
  hyperv: Move hv_connection_id to hyperv-tlfs.h
  hyperv: Remove unnecessary #includes
  hyperv: Add new Hyper-V headers
  hyperv: Add hv_defs.h to conditionally include hyperv-tlfs.h or
    hvhdk.h
  hyperv: Use hvhdk.h instead of hyperv-tlfs.h in Hyper-V code

 arch/arm64/hyperv/hv_core.c              |    3 +-
 arch/arm64/hyperv/mshyperv.c             |    1 +
 arch/arm64/include/asm/mshyperv.h        |    2 +-
 arch/x86/entry/vdso/vma.c                |    1 +
 arch/x86/hyperv/hv_apic.c                |    2 +-
 arch/x86/hyperv/hv_init.c                |    3 +-
 arch/x86/hyperv/hv_proc.c                |    4 +-
 arch/x86/hyperv/hv_spinlock.c            |    1 +
 arch/x86/hyperv/hv_vtl.c                 |    1 +
 arch/x86/hyperv/irqdomain.c              |    1 +
 arch/x86/hyperv/ivm.c                    |    2 +-
 arch/x86/hyperv/mmu.c                    |    2 +-
 arch/x86/hyperv/nested.c                 |    2 +-
 arch/x86/include/asm/kvm_host.h          |    1 -
 arch/x86/include/asm/mshyperv.h          |    3 +-
 arch/x86/include/asm/svm.h               |    2 +-
 arch/x86/include/asm/vdso/gettimeofday.h |    1 +
 arch/x86/kernel/cpu/mshyperv.c           |    2 +-
 arch/x86/kernel/cpu/mtrr/generic.c       |    1 +
 arch/x86/kvm/vmx/vmx_onhyperv.h          |    1 -
 arch/x86/mm/pat/set_memory.c             |    2 -
 drivers/clocksource/hyperv_timer.c       |    2 +-
 drivers/hv/channel.c                     |    1 +
 drivers/hv/channel_mgmt.c                |    1 +
 drivers/hv/connection.c                  |    1 +
 drivers/hv/hv.c                          |    1 +
 drivers/hv/hv_balloon.c                  |    5 +-
 drivers/hv/hv_common.c                   |    2 +-
 drivers/hv/hv_kvp.c                      |    1 -
 drivers/hv/hv_snapshot.c                 |    1 -
 drivers/hv/hv_util.c                     |    1 +
 drivers/hv/hyperv_vmbus.h                |    1 -
 drivers/hv/ring_buffer.c                 |    1 +
 drivers/hv/vmbus_drv.c                   |    1 +
 drivers/iommu/hyperv-iommu.c             |    1 +
 drivers/net/hyperv/netvsc.c              |    1 +
 drivers/pci/controller/pci-hyperv.c      |    1 +
 include/asm-generic/hyperv-tlfs.h        |    9 +
 include/asm-generic/mshyperv.h           |    2 +-
 include/clocksource/hyperv_timer.h       |    2 +-
 include/hyperv/hv_defs.h                 |   29 +
 include/hyperv/hvgdk.h                   |   66 ++
 include/hyperv/hvgdk_ext.h               |   46 +
 include/hyperv/hvgdk_mini.h              | 1212 ++++++++++++++++++++++
 include/hyperv/hvhdk.h                   |  733 +++++++++++++
 include/hyperv/hvhdk_mini.h              |  310 ++++++
 include/linux/hyperv.h                   |   12 +-
 net/vmw_vsock/hyperv_transport.c         |    1 -
 48 files changed, 2442 insertions(+), 40 deletions(-)
 create mode 100644 include/hyperv/hv_defs.h
 create mode 100644 include/hyperv/hvgdk.h
 create mode 100644 include/hyperv/hvgdk_ext.h
 create mode 100644 include/hyperv/hvgdk_mini.h
 create mode 100644 include/hyperv/hvhdk.h
 create mode 100644 include/hyperv/hvhdk_mini.h

-- 
2.34.1


