Return-Path: <linux-arch+bounces-11886-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD21AB2C3B
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 01:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD633B71A2
	for <lists+linux-arch@lfdr.de>; Sun, 11 May 2025 23:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB99E265601;
	Sun, 11 May 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i/uIweLM"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E91262FD9;
	Sun, 11 May 2025 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747004888; cv=none; b=HFl9KbQQfcfrskRsCTCZLZmB2szVGTmOI/3SNzYvmUzgjwbTYNAJm4y78U76hhX2otXfzlza/S99lfCfiCqLVeBpeZMctyuKuUy7VXsA62sqAYsjboJGS13MIcxd+oaqn18N1XfrGoNnhf1efMtfonQ+lOaueADoNLpXoyOZa0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747004888; c=relaxed/simple;
	bh=TFgAoICDPd7+D0MXWe9Ure6mza2fxuJqgIO6/JilKiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npRliZbMw/76HBoTdGk9EUAp04lZsNpNdE8SQ4jTEboy0nwJOxxZtlOBTTNJ/RisxY9nw32yg6D4QkV2fdVRE+hvu0oMoTOd29Xskf/axjNg6v/uaBaPTosnyHjX8pxEpeSj0S4KonCpJcz+echsO2GdbZ/eeRNoQkEJbiV61EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i/uIweLM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id B2B49211D8B6;
	Sun, 11 May 2025 16:08:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2B49211D8B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747004880;
	bh=C6e1Sd2wwIBHFKi64bmr0cXUFCAbG2BTPif+GBdvk8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/uIweLM/AnCi7PqtxtdfyJTudA/+61xNiWRDAoghEYqfW7si/lWX7uVlaaVMDyX4
	 9jA91EjAJ3yihJuaC9vdYgkFDLfWxORvxvnRIEuSYhal1jDUg7Xu1XR3GOg9Em6cLH
	 npeCsKoJGHstFIFm1zrocmvdPk38BL1CW+0I/kEY=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
	catalin.marinas@arm.com,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v2 1/4] Documentation: hyperv: Confidential VMBus
Date: Sun, 11 May 2025 16:07:55 -0700
Message-ID: <20250511230758.160674-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511230758.160674-1-romank@linux.microsoft.com>
References: <20250511230758.160674-1-romank@linux.microsoft.com>
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
index 1dcef6a7fda3..ca2b948e5070 100644
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
+image via using the platform security processor to ensure trusted and
+confidential computing.
+
+To support confidential communication with the paravisor, a VMBus client
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
+  Both pages will need to be scanned when VMBus receives a channel interrupt.
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


