Return-Path: <linux-arch+bounces-10875-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BE9A622E4
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 01:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E51288221C
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 00:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCCD21345;
	Sat, 15 Mar 2025 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cac0nYhW"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FCB208A0;
	Sat, 15 Mar 2025 00:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997978; cv=none; b=cbpEgXHVIqchXLl0t2HEwLH2xrxNoiSPCkDnruupmKVdT7yrXpXvyFT9FcwgF+tmTQtSCJfEf6SBnUaSW9UdDb5aZAvKEgSB/w5OHakGT+acpC0dBFph8yUOAoSXRL7uy8dFyOlyaoNjW75k8pnN+TUjvhRVqF/JtjnwK6tQCCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997978; c=relaxed/simple;
	bh=cra/GNuyMQV91GFqsW8dQ9HbAggpcs6Io/tZ112UIh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kD1AS9q68oQ5ddREK3p/lVnKHoGZfhjuRwxsz7b6CboIFAQFw0LuJhQog/xiLqohv1XAxf+EJFhZDM85NEVV/2tAAe2LtiAsyjKmHm3bibMrrbiA0A/iIoa0j5Gw7cjI+UzCyYl2FwJglwV95O1UozPF1Nu5pSUhrn+iuZRK188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cac0nYhW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9B8D02038A52;
	Fri, 14 Mar 2025 17:19:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B8D02038A52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741997975;
	bh=NIRoaJMzXhRU+FEOMF0AnLyeJ+Xl1dVpfnO4TXIokQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cac0nYhWonKSodrgcm22k2UaS9TFPGH2L0yKUnuRyCzzIt1EGqE45j6m5xxZikYmV
	 +jClSCydm9Z5xvpZQhb2vydLjRj1mcNwjNPciHvS+6BCTf+fYeG1Hhm/ZQqaLCAKs8
	 LmtpfXtoSxYjfIiPMlAI1f/38L4NWn5yQ+6QcIqM=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	dan.carpenter@linaro.org,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	krzk+dt@kernel.org,
	kw@linux.com,
	kys@microsoft.com,
	lenb@kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	mingo@redhat.com,
	oliver.upton@linux.dev,
	rafael@kernel.org,
	robh@kernel.org,
	ssengar@linux.microsoft.com,
	sudeep.holla@arm.com,
	suzuki.poulose@arm.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	yuzenghui@huawei.com,
	devicetree@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v6 07/11] dt-bindings: microsoft,vmbus: Add interrupt and DMA coherence properties
Date: Fri, 14 Mar 2025 17:19:27 -0700
Message-ID: <20250315001931.631210-8-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315001931.631210-1-romank@linux.microsoft.com>
References: <20250315001931.631210-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To boot in the VTL mode, VMBus on arm64 needs interrupt description
which the binding documentation lacks. The transactions on the bus are
DMA coherent which is not mentioned as well.

Add the interrupt property and the DMA coherence property to the VMBus
binding. Update the example to match that. Fix typos.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 .../bindings/bus/microsoft,vmbus.yaml           | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
index a8d40c766dcd..ca288ea54b34 100644
--- a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
+++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
@@ -10,8 +10,8 @@ maintainers:
   - Saurabh Sengar <ssengar@linux.microsoft.com>
 
 description:
-  VMBus is a software bus that implement the protocols for communication
-  between the root or host OS and guest OSs (virtual machines).
+  VMBus is a software bus that implements the protocols for communication
+  between the root or host OS and guest OS'es (virtual machines).
 
 properties:
   compatible:
@@ -25,9 +25,17 @@ properties:
   '#size-cells':
     const: 1
 
+  dma-coherent: true
+
+  interrupts:
+    maxItems: 1
+    description: |
+      This interrupt is used to report a message from the host.
+
 required:
   - compatible
   - ranges
+  - interrupts
   - '#address-cells'
   - '#size-cells'
 
@@ -35,6 +43,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     soc {
         #address-cells = <2>;
         #size-cells = <1>;
@@ -49,6 +59,9 @@ examples:
                 #address-cells = <2>;
                 #size-cells = <1>;
                 ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
+                dma-coherent;
+                interrupt-parent = <&gic>;
+                interrupts = <GIC_PPI 2 IRQ_TYPE_EDGE_RISING>;
             };
         };
     };
-- 
2.43.0


