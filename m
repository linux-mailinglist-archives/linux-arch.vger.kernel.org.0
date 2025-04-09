Return-Path: <linux-arch+bounces-11342-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB42DA819A1
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 02:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70CC190100C
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 00:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2F6A945;
	Wed,  9 Apr 2025 00:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fQm9USqT"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1851C32;
	Wed,  9 Apr 2025 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157326; cv=none; b=upVM4jy8GBeQxOwxQTwH6Bv8WTDbFUJR9D6uXj+UGRYCciUF4UjjZ4OcFV16lJiCs6+CdqSk/Y2DngKwPbA9jJDxyCvWTvUt5lgmNVGcSZcG9pt/ekWvg962CD7IPcZu62AE5dRd7xUeNW0gs45NeEpXyBDl9kq9KKPXCSGirk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157326; c=relaxed/simple;
	bh=FeY7FUjVyZnX86xAQafH+ENKHx7xrhl+RJwwvbDtetA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQhozN1r3+7IGYG+gc9vDSwvbEhLDCAz2LPEDOL7xp3RBc7Yo/GyQJnX2NbXf1rC2gaxeECMyINQhPsAw9zpdkyTq4QX7MlWZkpMLk+p3tqofe3hfVbpizHec0Q29MwKOtq8XWSvzVeUBulaMM/wP1Cx/GtXfcgCS7FzItB33oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fQm9USqT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 278202113E98;
	Tue,  8 Apr 2025 17:08:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 278202113E98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744157318;
	bh=ASGce+NyaGbEoSjdawfaStxr+cxlfQcFzJFI1lv07Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQm9USqTIK36LAB4mqAvsqseTTmnZCrw+zHCmm9m+yyGhhqzi6bXCY9O+iMchHVrc
	 W/4PTasl5/WaavJ0SoPdl1fdv1jRtRpnQKf1WJexVHnoVXObTXQQ81K3Kvi5IlTmoC
	 YH2yCK8gsKTJc/v1dacCQvG3lBGHWH/xZ2RaG9j0=
From: Roman Kisel <romank@linux.microsoft.com>
To: aleksander.lobakin@intel.com,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	bp@alien8.de,
	catalin.marinas@arm.com,
	corbet@lwn.net,
	dakr@kernel.org,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	haiyangz@microsoft.com,
	hch@lst.de,
	hpa@zytor.com,
	James.Bottomley@HansenPartnership.com,
	Jonathan.Cameron@huawei.com,
	kys@microsoft.com,
	leon@kernel.org,
	lukas@wunner.de,
	luto@kernel.org,
	m.szyprowski@samsung.com,
	martin.petersen@oracle.com,
	mingo@redhat.com,
	peterz@infradead.org,
	quic_zijuhu@quicinc.com,
	robin.murphy@arm.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next 1/6] Documentation: hyperv: Confidential VMBus
Date: Tue,  8 Apr 2025 17:08:30 -0700
Message-ID: <20250409000835.285105-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409000835.285105-1-romank@linux.microsoft.com>
References: <20250409000835.285105-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define what the confidential VMBus is and describe what advantages
it offers on the capable hardware.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 Documentation/virt/hyperv/vmbus.rst | 41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/virt/hyperv/vmbus.rst b/Documentation/virt/hyperv/vmbus.rst
index 1dcef6a7fda3..f600e3d09800 100644
--- a/Documentation/virt/hyperv/vmbus.rst
+++ b/Documentation/virt/hyperv/vmbus.rst
@@ -324,3 +324,44 @@ rescinded, neither Hyper-V nor Linux retains any state about
 its previous existence. Such a device might be re-added later,
 in which case it is treated as an entirely new device. See
 vmbus_onoffer_rescind().
+
+Confidential VMBus
+------------------
+
+The confidential VMBus provides the control and data planes where
+the guest doesn't talk to either the hypervisor or the host. Instead,
+it relies on the trusted paravisor. The hardware (SNP or TDX) encrypts
+the guest memory and the register state also measuring the paravisor
+image via using the platform security processor to ensure trsuted and
+confidential computing.
+
+To support confidential communication with the paravisor, a VmBus client
+will first attempt to use regular, non-isolated mechanisms for communication.
+To do this, it must:
+
+* Configure the paravisor SIMP with an encrypted page. The paravisor SIMP is
+  configured by setting the relevant MSR directly, without using GHCB or tdcall.
+
+* Enable SINT 2 on both the paravisor and hypervisor, without setting the proxy
+  flag on the paravisor SINT. Enable interrupts on the paravisor SynIC.
+
+* Configure both the paravisor and hypervisor event flags page.
+  Both pages will need to be scanned when VmBus receives a channel interrupt.
+
+* Send messages to the paravisor by calling HvPostMessage directly, without using
+  GHCB or tdcall.
+
+* Set the EOM MSR directly in the paravisor, without using GHCB or tdcall.
+
+If sending the InitiateContact message using non-isolated HvPostMessage fails,
+the client must fall back to using the hypervisor synic, by using the GHCB/tdcall
+as appropriate.
+
+To fall back, the client will have to reconfigure the following:
+
+* Configure the hypervisor SIMP with a host-visible page.
+  Since the hypervisor SIMP is not used when in confidential mode,
+  this can be done up front, or only when needed, whichever makes sense for
+  the particular implementation.
+
+* Set the proxy flag on SINT 2 for the paravisor.
-- 
2.43.0


