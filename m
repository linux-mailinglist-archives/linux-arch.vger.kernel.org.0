Return-Path: <linux-arch+bounces-10124-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2862EA31B66
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 02:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387D5188B05C
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 01:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013BF1CDFCE;
	Wed, 12 Feb 2025 01:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ieXru8hh"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1E4150980;
	Wed, 12 Feb 2025 01:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324607; cv=none; b=MJ1cRSGKuCNOP7wdPcY2KteKHFV/7F0dpv154yPAvEo7LrN3mH9JS804aX75bXtEhpdOAVAwIMSKrMOmKpfBSW6D72ZFreua3fuyn0JwlALCih3HCuzfZDMlDt+P6HMgeDjMulHbNLRkPaK5ga75LksmdZmYgbgHJFT2ioOE7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324607; c=relaxed/simple;
	bh=59Z/Ow45+5UGSd987THPkskuqVVIL//sxTBlDCq+aek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBURu+0Un/dduCjFf2z5e2WL/MRA4zA/RHkVI+qPaFuAAs3CAOtITgSjoLeGIrdH8KMWk2/Zya0E3/mxokaAJo8urrEvBHoaFr4Gon8b3rxMfAnxryJnbxox7ULYB841i9FpvdJrrRzm+RLZcXjmFw4aDopo0RFVk311Bo8+8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ieXru8hh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7DBB92107AB8;
	Tue, 11 Feb 2025 17:43:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7DBB92107AB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739324606;
	bh=jrClHRqKsJhUgr2olSBXPZ258Bk/7fWr+RNJ8O+98cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ieXru8hhff4SzJYmU6EHZI/dEPSX8q2Xb7zi7YlIfIPeYzUaZUckucd34oJNV7LhY
	 3S6o6AAGzTgz2QVqenW5T941oF3Z7mbvQxu6xvBugwO7ipqm+bIrLiOiYssbEsJCK7
	 8vq13rXYxk1l8AGAW3HotWN54WjAlogOoVSNT11k=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	krzk+dt@kernel.org,
	kw@linux.com,
	kys@microsoft.com,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	mingo@redhat.com,
	robh@kernel.org,
	ssengar@linux.microsoft.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org
Cc: benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v4 4/6] dt-bindings: microsoft,vmbus: Add GIC and DMA coherence to the example
Date: Tue, 11 Feb 2025 17:43:19 -0800
Message-ID: <20250212014321.1108840-5-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212014321.1108840-1-romank@linux.microsoft.com>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing example lacks the GIC interrupt controller property
making it not possible to boot on ARM64, and it lacks the DMA
coherence property making the kernel do more work on maintaining
CPU caches on ARM64 although the VMBus trancations are cache-coherent.

Add the GIC node, specify DMA coherence, and define interrupt-parent
and interrupts properties in the example to provide a complete reference
for platforms utilizing GIC-based interrupts, and add the DMA coherence
property to not do extra work on the architectures where DMA defaults to
non cache-coherent.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 .../devicetree/bindings/bus/microsoft,vmbus.yaml      | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
index a8d40c766dcd..5ec69226ab85 100644
--- a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
+++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
@@ -44,11 +44,22 @@ examples:
             #size-cells = <1>;
             ranges;
 
+            gic: intc@fe200000 {
+              compatible = "arm,gic-v3";
+              reg = <0x0 0xfe200000 0x0 0x10000>,   /* GIC Dist */
+                    <0x0 0xfe280000 0x0 0x200000>;  /* GICR */
+              interrupt-controller;
+              #interrupt-cells = <3>;
+            }
+
             vmbus@ff0000000 {
                 compatible = "microsoft,vmbus";
                 #address-cells = <2>;
                 #size-cells = <1>;
                 ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
+                dma-coherent;
+                interrupt-parent = <&gic>;
+                interrupts = <1 2 1>;
             };
         };
     };
-- 
2.43.0


