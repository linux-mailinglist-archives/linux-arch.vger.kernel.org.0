Return-Path: <linux-arch+bounces-8910-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317CB9C11B8
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 23:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85CC2846D4
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 22:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2D4219C96;
	Thu,  7 Nov 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E85Vpx1X"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B832194A6;
	Thu,  7 Nov 2024 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018759; cv=none; b=HlLt9PNEcNkanV/ObtH5eiDtOtB8jt58aJkOof/Ohc1AoqIc6URtKUnM0UpIGzz5JOZOj7Y1HfeYbmwu49R0SJ5T/cKbfKYNrH7rwSvEpEctBqYUTyrS61zfC+g62WvuVN+R+KMN3/xl1t1SZyshsL0qqIkjyd8OiTfZKYHXnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018759; c=relaxed/simple;
	bh=3axHTgWvPaJXU6x/HwYNyCImPTdzE7DJqPuDZ6F6AzE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fXJr0IiAV0cpTIlsanSD2sh+/NW+SL9MLqf3Y+HxDssH74J2LWCiaq0vv7TojBwx3z0ZawPrjiuNjvxtEvd82K+HYPkDiPwETQ3tnfKnllAvu67wmRbpaiHjfH2t5CJLHbGnGo0rLKgQddLgYpdkT5hme3bowV+UjoX/8L64+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E85Vpx1X; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id A7369212C4BF;
	Thu,  7 Nov 2024 14:32:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A7369212C4BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731018750;
	bh=dXEOtZcKhs1OyrLOGbwwuM7yb0GGsFy0HJU2nlATJVM=;
	h=From:To:Cc:Subject:Date:From;
	b=E85Vpx1XKF/7gIXBsoZOI6XnWD4pHDLIv62Hmm0sqgJpnOf8/Cgg8V/QCKee3Vppr
	 ry4FPI40feJ1miQYl+Dx+/AvjsAcrxqUrJygt4jVjT3OJnYKE30CU4CoZ3KZny5GG9
	 XD4lpSNQQEk/X8UUGLdqFqJ/fa8hg8d9V2jWrOLw=
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
	apais@linux.microsoft.com
Subject: [PATCH v2 0/4] Add new headers for Hyper-V Dom0
Date: Thu,  7 Nov 2024 14:32:22 -0800
Message-Id: <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

To support Hyper-V Dom0 (aka Linux as root partition), many new
definitions are required.

The plan going forward is to directly import definitions from
Hyper-V code without waiting for them to land in the TLFS document.
This is a quicker and more maintainable way to import definitions,
and is a step toward the eventual goal of exporting headers directly
from Hyper-V for use in Linux.

This patch series introduces new headers (hvhdk.h, hvgdk.h, etc,
see patch #3) derived directly from Hyper-V code. hyperv-tlfs.h is
replaced with hvhdk.h (which includes the other new headers)
everywhere.

No functional change is expected.

Summary:
Patch 1-2: Minor cleanup patches
Patch 3: Add the new headers (hvhdk.h, etc..) in include/hyperv/
Patch 4: Switch to the new headers

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
Changelog:
v2:
- Rework the series to simply use the new headers everywhere
  instead of fiddling around to keep hyperv-tlfs.h used in some
  places, suggested by Michael Kelley and Easwar Hariharan
- Fix compilation errors with some configs by adding missing
  definitions and changing some names, thanks to Simon Horman for
  catching those
- Add additional definitions to the new headers to support them now
  replacing hyperv-tlfs.h everywhere
- Add additional context in the commit messages for patches #3 and #4
- In patch #2, don't remove indirect includes. Only remove includes
  which truly aren't used, suggested by Michael Kelley

---
Nuno Das Neves (4):
  hyperv: Move hv_connection_id to hyperv-tlfs.h
  hyperv: Clean up unnecessary #includes
  hyperv: Add new Hyper-V headers in include/hyperv
  hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h

 arch/arm64/hyperv/hv_core.c        |    3 +-
 arch/arm64/hyperv/mshyperv.c       |    4 +-
 arch/arm64/include/asm/mshyperv.h  |    2 +-
 arch/x86/hyperv/hv_apic.c          |    1 -
 arch/x86/hyperv/hv_init.c          |   21 +-
 arch/x86/hyperv/hv_proc.c          |    3 +-
 arch/x86/hyperv/ivm.c              |    1 -
 arch/x86/hyperv/mmu.c              |    1 -
 arch/x86/hyperv/nested.c           |    2 +-
 arch/x86/include/asm/kvm_host.h    |    3 +-
 arch/x86/include/asm/mshyperv.h    |    3 +-
 arch/x86/include/asm/svm.h         |    2 +-
 arch/x86/kernel/cpu/mshyperv.c     |    2 +-
 arch/x86/kvm/vmx/hyperv_evmcs.h    |    2 +-
 arch/x86/kvm/vmx/vmx_onhyperv.h    |    2 +-
 arch/x86/mm/pat/set_memory.c       |    2 -
 drivers/clocksource/hyperv_timer.c |    2 +-
 drivers/hv/hv_balloon.c            |    4 +-
 drivers/hv/hv_common.c             |    2 +-
 drivers/hv/hv_kvp.c                |    2 +-
 drivers/hv/hv_snapshot.c           |    2 +-
 drivers/hv/hyperv_vmbus.h          |    2 +-
 include/asm-generic/hyperv-tlfs.h  |    9 +
 include/asm-generic/mshyperv.h     |    2 +-
 include/clocksource/hyperv_timer.h |    2 +-
 include/hyperv/hvgdk.h             |  303 +++++++
 include/hyperv/hvgdk_ext.h         |   46 +
 include/hyperv/hvgdk_mini.h        | 1295 ++++++++++++++++++++++++++++
 include/hyperv/hvhdk.h             |  733 ++++++++++++++++
 include/hyperv/hvhdk_mini.h        |  310 +++++++
 include/linux/hyperv.h             |   11 +-
 net/vmw_vsock/hyperv_transport.c   |    2 +-
 32 files changed, 2729 insertions(+), 52 deletions(-)
 create mode 100644 include/hyperv/hvgdk.h
 create mode 100644 include/hyperv/hvgdk_ext.h
 create mode 100644 include/hyperv/hvgdk_mini.h
 create mode 100644 include/hyperv/hvhdk.h
 create mode 100644 include/hyperv/hvhdk_mini.h

-- 
2.34.1


