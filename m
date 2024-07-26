Return-Path: <linux-arch+bounces-5651-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA4093DAFE
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jul 2024 01:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0848E1C22662
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 23:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AC1155391;
	Fri, 26 Jul 2024 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J5prU8uA"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605F51514F8;
	Fri, 26 Jul 2024 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034771; cv=none; b=Vc3oJwaLkf6IQhZ7JQdm6JFfkNE1lOMwfBM0av6Ux6CDA2ccdflZMs0ThT+7cMOCFt4L6hw6ahct5iGWUG7w/qVAui5wIagIYkUsJaqheDqaRZY45OIRYLZvkdsmjDaLU0npw1mN94/dNP6qzyDTIYdV1VTbZ57wHgiyBwCQiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034771; c=relaxed/simple;
	bh=vk1//007f6efUv3tZXdBFYeje256Rq4JLZSViWp0k7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z8rN+Jab31EWKNU7e5dmSdaBVk21920bKxp0kGtIwk/jzdJn/hbYSUVnZOpP3g5ganTBtl5H2tALBCrFpx7iGVdNJjbpbo7mWR71eRQLX4m3PbA7AovHzrr9zQG+pr5IX5OOnPRFFingJB+4QUS7U3lWs/JiO47/uwlcWAyzd1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J5prU8uA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7DBB320B712E;
	Fri, 26 Jul 2024 15:59:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7DBB320B712E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722034769;
	bh=3Zon5hZ0mew9TRjycUlDXro0yNveA6eiZCkGV3Hxyd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5prU8uA8W9Fh/XGljE+RdoZ2/4cUP5LuHI94mtaUlgcOIIdnAiocnovfe1FK5uU6
	 mNe/0gXVIoDEDdG2dgwK3xyct8+ItfE8fOU4DJwm0E4fZoGFQcChlz9TtXW3OSZGaH
	 yEonssCXnQ2peGTMzD4I3nK5oegU73q1kLATcB3U=
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
Subject: [PATCH v3 5/7] dt-bindings: bus: Add Hyper-V VMBus cache coherency and IRQs
Date: Fri, 26 Jul 2024 15:59:08 -0700
Message-Id: <20240726225910.1912537-6-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726225910.1912537-1-romank@linux.microsoft.com>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for the Hyper-V VMBus DMA cache coherency
and interrupt specification.

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
2.34.1


