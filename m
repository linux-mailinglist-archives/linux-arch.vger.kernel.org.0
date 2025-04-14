Return-Path: <linux-arch+bounces-11398-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9CCA88F68
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 00:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368603A39CB
	for <lists+linux-arch@lfdr.de>; Mon, 14 Apr 2025 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779A0205513;
	Mon, 14 Apr 2025 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HufyQv9t"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F25F1F55FA;
	Mon, 14 Apr 2025 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744670840; cv=none; b=twlRlcsm1TiDZDGKaziS3PHKFQ4hFRvfml6CBwpRNKxayF5iY6nV0EWWWG4DuXW4pNjZBbObBvbMJp9al4Nme7+BC+C0bPoiU057kHMWfKthConc1HOgVkE9uIKlG91/oy+gy4GUvR9JOw1im+4VgdWmyd0e2QAGuvtecEVq5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744670840; c=relaxed/simple;
	bh=si2Bw5IJPROKqW+kfwLdvOeV0XJuRpoCT2Z9dvgX1pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOAgrahmSmaedZHFMzyR14HmaaC9ebI6Bm/TLFi/u1unF6boMGMw1RwRVHHhAcdtfzDfMvAaQisi1Q+akUMBy5u4eO01ooNOKi0P7+qXN1xTGmR1OlGgjZ1yruKuTVAi2PvizQXW7hj8aBnAyqoT3No3eua8O6XR3FOKD2wt3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HufyQv9t; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8AFFB210C434;
	Mon, 14 Apr 2025 15:47:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AFFB210C434
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744670837;
	bh=GR2GmT7fACAPkitPj8eTbd2Bh3lgrZjljTTbjCNGmE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HufyQv9ttcOdarL6+tlfprRYglH4+VTdbj9xTSaKOfJYd6oQp3mbjoYATtlXGPG9R
	 /20EKFyZdf679VARrKL1MuHl7S0l43AzP8UJdvCwy2C+JnfvK7688pmoke7ziowitq
	 Gbrtf5ozPZxIK5y1zSCfFQpi8pQ/mGPoI2bx2seQ=
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
	rafael.j.wysocki@intel.com,
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
Subject: [PATCH hyperv-next v8 07/11] dt-bindings: microsoft,vmbus: Add interrupt and DMA coherence properties
Date: Mon, 14 Apr 2025 15:47:09 -0700
Message-ID: <20250414224713.1866095-8-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414224713.1866095-1-romank@linux.microsoft.com>
References: <20250414224713.1866095-1-romank@linux.microsoft.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/bus/microsoft,vmbus.yaml | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
index a8d40c766dcd..0bea4f5287ce 100644
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
@@ -25,9 +25,16 @@ properties:
   '#size-cells':
     const: 1
 
+  dma-coherent: true
+
+  interrupts:
+    maxItems: 1
+    description: Interrupt is used to report a message from the host.
+
 required:
   - compatible
   - ranges
+  - interrupts
   - '#address-cells'
   - '#size-cells'
 
@@ -35,6 +42,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     soc {
         #address-cells = <2>;
         #size-cells = <1>;
@@ -49,6 +58,9 @@ examples:
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


