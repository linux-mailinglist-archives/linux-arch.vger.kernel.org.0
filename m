Return-Path: <linux-arch+bounces-10582-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF03A57479
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 23:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA3B189AD02
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 22:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DB325A62D;
	Fri,  7 Mar 2025 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dP08kpaQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4E6258CF5;
	Fri,  7 Mar 2025 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384990; cv=none; b=KisCL9vcTa6SiMUF5ZB2NfIJwi+6BwDmW/uI6BuQAjCcQ54ooIpxecF6r5HZ/yzAhtkKda+jZ0I1VtmRXIxR3qLmxMq6lHUL2m18OxF+usCahiXnD7slRQ7+0Az4IP4IE6b5KMi50OxiDmnKEOXJ4ku1evpfWYk725jrYmw+ic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384990; c=relaxed/simple;
	bh=OcRFfxdTjWsf6DOk0cwFXdBVoN5459lRKzBvVynoTQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XD/HJ/Qrm3CXY8ehjkBF0dms3u6MTOfA6J4WbQ5IESziU7u8011JsLldVFnr2OpNfnLAwLv4tKkKsUl/9g+smGGdy+0XgRSyLlw3uKPqMzkjpxBDolPfL1uuRa9CLJw5fZUxS36dpzn5TQNGalMt0rV2fk65uWPi2zZYEVV2UF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dP08kpaQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2CDDA2038F47;
	Fri,  7 Mar 2025 14:03:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2CDDA2038F47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741384988;
	bh=iGuHmE2gbtDvOko+hzXt49EHmrzYrq8xqM8VYRFGXqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dP08kpaQ0+FluYjvhFx+l39uxftz+ykdKaCySFFfbst7F4t8LYKRKXhmhyDLM9c4U
	 vV69jsYfc36IetKlG21KRoK0S4xRD3I8jHvNPPosiJqdz4TfyBbfcfZ+4dreINnf5C
	 SS1ztKs4C+kM3RlAitAn+HrbVOiWFbr3tPjumNf4=
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
Subject: [PATCH hyperv-next v5 07/11] dt-bindings: microsoft,vmbus: Add interrupts and DMA coherence
Date: Fri,  7 Mar 2025 14:02:59 -0800
Message-ID: <20250307220304.247725-8-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307220304.247725-1-romank@linux.microsoft.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To boot on ARM64, VMBus requires configuring interrupts. Missing
DMA coherence property is sub-optimal as the VMBus transations are
cache-coherent.

Add interrupts to be able to boot on ARM64. Add DMA coherence to
avoid doing extra work on maintaining caches on ARM64.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 .../devicetree/bindings/bus/microsoft,vmbus.yaml          | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
index a8d40c766dcd..3ab7d0116626 100644
--- a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
+++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
@@ -28,13 +28,16 @@ properties:
 required:
   - compatible
   - ranges
+  - interrupts
   - '#address-cells'
   - '#size-cells'
 
-additionalProperties: false
+additionalProperties: true
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     soc {
         #address-cells = <2>;
         #size-cells = <1>;
@@ -49,6 +52,9 @@ examples:
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


