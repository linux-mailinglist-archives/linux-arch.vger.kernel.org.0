Return-Path: <linux-arch+bounces-9157-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0689D8F06
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 00:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2ED0287B5F
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2024 23:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABA81CEE83;
	Mon, 25 Nov 2024 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I/c1RYN4"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655831CD2C;
	Mon, 25 Nov 2024 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732577091; cv=none; b=gdR+LuluhPQvBdlCHbjN/tX2KumMybZKWz4mEzAenXXStSX1a7usufCqkuLqFrj1J905kuc4E0qvf2tlfVXccrQBObzR3kwrH1hWeYaC7LfsBDmqrcKrM/TQkiZN1wLN9+N+FNGbPxXl9bM0t0UPCQS0BkL29za6UfiqAITrW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732577091; c=relaxed/simple;
	bh=8ET40aUJBPF8KJ8l/GdaeBQwZGILcXnZdbZXTC2/+wo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WyM6z7TbGSGmhOAr1EJTNjJ95tejQxMuAGaGTQH0t1tG5ZeEPxEqgkSfARqXXb1n3UmQR8GiYt/97gnqZJV8oeVxMvdBbGAMm5rHFnW75ONgCgno4KgWU0P+Hqv1FQcdVHz2+eEXXrxX2i4xkicDQDKYhsZRPtQsYuzVEWfIdq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I/c1RYN4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id BC82A2054597;
	Mon, 25 Nov 2024 15:24:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC82A2054597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1732577087;
	bh=KKxzMh07QCmMgY5ntlRx+0kcO0k3u6+fBgf1JWSRuQE=;
	h=From:To:Cc:Subject:Date:From;
	b=I/c1RYN4dA+qUthGeQv6gh+TFPvdHoVYWtoz34qRQbODr8muisW07fzsKSq76FBqv
	 1BCkJQS3BlZ9hGDfV01s1HkGv7AmIwADtJFS/+xlNHCCr8+Wp4Mlu9ORXlWtyOGYtw
	 mTe9Uqf7okrDn8wYD+oN2pLQubME821KC1+zxfm8=
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
	mhklinux@outlook.com,
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
	mukeshrathor@microsoft.com,
	vkuznets@redhat.com,
	ssengar@linux.microsoft.com,
	apais@linux.microsoft.com,
	eahariha@linux.microsoft.com,
	horms@kernel.org
Subject: [PATCH v3 0/5] Introduce new headers for Hyper-V
Date: Mon, 25 Nov 2024 15:24:39 -0800
Message-Id: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

To support Linux as root partition[1] on Hyper-V many new definitions
are required.

The plan going forward is to directly import definitions from
Hyper-V code without waiting for them to land in the TLFS document.
This is a quicker and more maintainable way to import definitions,
and is a step toward the eventual goal of exporting the headers
directly from Hyper-V for use in Linux.

This patch series introduces new headers (hvhdk.h, hvgdk.h, etc,
see patch #3) derived directly from Hyper-V code. hyperv-tlfs.h is
replaced with hvhdk.h (which includes the other new headers)
everywhere.

No functional change is expected.

Summary:
Patch 1-2: Minor cleanup patches
Patch 3: Add the new headers (hvhdk.h, etc..) in include/hyperv/
Patch 4: Switch to the new headers
Patch 5: Delete hyperv-tlfs.h files

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
Changelog:
v3:
- Add patch (#5) to delete the hyperv-tlfs.h files, suggested by
  Michael Kelley and Easwar Hariharan
- Reword commit message on patch #3 to improve clarity, suggested
  by Michael Kelley
- Clarify "Dom0" terminology, suggested by Michael Kelley
v2:
- Rework the series to simply use the new headers everywhere,
  instead of fiddling around to keep hyperv-tlfs.h in some areas,
  suggested by Michael Kelley and Easwar Hariharan
- Fix compilation issues with some configs by adding missing
  definitions and changing some names, thanks to Simon Horman for
  catching those
- Add additional definitions to the new headers due to them now being
  used everywhere
- Don't remove indirect includes in patch #2, only remove those which
  truly aren't used, suggested by Michael Kelley

---
Footnotes:
[1] Linux as root partition on Hyper-V is sometimes referred to as
    "Dom0", borrowing the terminology from Xen. Although they are
    conceptually similar, note that "Hyper-V Dom0" has nothing to do
    with Xen.

Nuno Das Neves (5):
  hyperv: Move hv_connection_id to hyperv-tlfs.h
  hyperv: Clean up unnecessary #includes
  hyperv: Add new Hyper-V headers in include/hyperv
  hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h
  hyperv: Remove the now unused hyperv-tlfs.h files

 MAINTAINERS                          |    8 +-
 arch/arm64/hyperv/hv_core.c          |    3 +-
 arch/arm64/hyperv/mshyperv.c         |    4 +-
 arch/arm64/include/asm/hyperv-tlfs.h |   71 --
 arch/arm64/include/asm/mshyperv.h    |    7 +-
 arch/x86/hyperv/hv_apic.c            |    1 -
 arch/x86/hyperv/hv_init.c            |   21 +-
 arch/x86/hyperv/hv_proc.c            |    3 +-
 arch/x86/hyperv/ivm.c                |    1 -
 arch/x86/hyperv/mmu.c                |    1 -
 arch/x86/hyperv/nested.c             |    2 +-
 arch/x86/include/asm/hyperv-tlfs.h   |  811 ----------------
 arch/x86/include/asm/kvm_host.h      |    3 +-
 arch/x86/include/asm/mshyperv.h      |    3 +-
 arch/x86/include/asm/svm.h           |    2 +-
 arch/x86/kernel/cpu/mshyperv.c       |    2 +-
 arch/x86/kvm/vmx/hyperv_evmcs.h      |    2 +-
 arch/x86/kvm/vmx/vmx_onhyperv.h      |    2 +-
 arch/x86/mm/pat/set_memory.c         |    2 -
 drivers/clocksource/hyperv_timer.c   |    2 +-
 drivers/hv/hv_balloon.c              |    4 +-
 drivers/hv/hv_common.c               |    2 +-
 drivers/hv/hv_kvp.c                  |    2 +-
 drivers/hv/hv_snapshot.c             |    2 +-
 drivers/hv/hyperv_vmbus.h            |    2 +-
 include/asm-generic/hyperv-tlfs.h    |  874 -----------------
 include/asm-generic/mshyperv.h       |    7 +-
 include/clocksource/hyperv_timer.h   |    2 +-
 include/hyperv/hvgdk.h               |  308 ++++++
 include/hyperv/hvgdk_ext.h           |   46 +
 include/hyperv/hvgdk_mini.h          | 1306 ++++++++++++++++++++++++++
 include/hyperv/hvhdk.h               |  733 +++++++++++++++
 include/hyperv/hvhdk_mini.h          |  311 ++++++
 include/linux/hyperv.h               |   11 +-
 net/vmw_vsock/hyperv_transport.c     |    6 +-
 35 files changed, 2748 insertions(+), 1819 deletions(-)
 delete mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 delete mode 100644 arch/x86/include/asm/hyperv-tlfs.h
 delete mode 100644 include/asm-generic/hyperv-tlfs.h
 create mode 100644 include/hyperv/hvgdk.h
 create mode 100644 include/hyperv/hvgdk_ext.h
 create mode 100644 include/hyperv/hvgdk_mini.h
 create mode 100644 include/hyperv/hvhdk.h
 create mode 100644 include/hyperv/hvhdk_mini.h

-- 
2.34.1


