Return-Path: <linux-arch+bounces-11401-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6238BA88F6C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 00:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A733D189BF40
	for <lists+linux-arch@lfdr.de>; Mon, 14 Apr 2025 22:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7754B20E003;
	Mon, 14 Apr 2025 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TiuB1MK9"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490831FAC34;
	Mon, 14 Apr 2025 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744670841; cv=none; b=aLfXrqSeClUgldD3yRJQqgdR6Mcg9/60noyfcQOBcchOk5aG70Y5FgYtzPLlbVcAYMEAYEjL6hAyX8FLaE+6OMBTC/0g83oUY3SNnEtfGkpiOIlv5FCukLcPvVfFjgBcyVm6OjUfgCH/+LDCDcaABzC7b6TG0zMQAkaSwN3q4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744670841; c=relaxed/simple;
	bh=SKdz72k2NkyXGdqtVsqW7yFxP3EnThWVkZ2UEaRCYAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPoFtWycPnfy9YEpqOA7CQXyO8mt2/Cm4jP1GHwfpsujVvczxjlfjnFyoctJMiM2Il9cwZCvatdLfIrLQ9X6HUK7oVzi2B/eL4Fs/o7XyqzFCL5qslnDIIcy2bt763Xm9O5vZs4i1y2BFd8Vx2nQfDNMSVjoXqN62JyBcgCut60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TiuB1MK9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id AF8C0210C438;
	Mon, 14 Apr 2025 15:47:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF8C0210C438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744670839;
	bh=6NhcoKa6JL1NM9sMn3gmj98XuhFiqjkn7M2jrThtdQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TiuB1MK90sfPo9waNI436CqwmAPWiLXP+x84hH+kiM5rzXy0b29AtP36OAgU31Sr5
	 MPhvjH5E1oFoA/V+hgVjR1R+OfKJF5HXU2LHbf+i0FVnRBFP7PfbifBkOGKCUBaHDR
	 nY5C0P1tm4uoWrmUtJJH/4yuBBUMMijr4K33iDWc=
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
Subject: [PATCH hyperv-next v8 10/11] ACPI: irq: Introduce acpi_get_gsi_dispatcher()
Date: Mon, 14 Apr 2025 15:47:12 -0700
Message-ID: <20250414224713.1866095-11-romank@linux.microsoft.com>
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

Using acpi_irq_create_hierarchy() in the cases where the code
also handles OF leads to code duplication as the ACPI subsystem
doesn't provide means to compute the IRQ domain parent whereas
the OF does.

Introduce acpi_get_gsi_dispatcher() so that the drivers relying
on both ACPI and OF may use irq_domain_create_hierarchy() in the
common code paths.

No functional changes.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/irq.c   | 16 ++++++++++++++--
 include/linux/acpi.h |  5 ++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 1687483ff319..76a856c32c4d 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -12,7 +12,7 @@
 
 enum acpi_irq_model_id acpi_irq_model;
 
-static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
+static acpi_gsi_domain_disp_fn acpi_get_gsi_domain_id;
 static u32 (*acpi_gsi_to_irq_fallback)(u32 gsi);
 
 /**
@@ -307,12 +307,24 @@ EXPORT_SYMBOL_GPL(acpi_irq_get);
  *	for a given GSI
  */
 void __init acpi_set_irq_model(enum acpi_irq_model_id model,
-			       struct fwnode_handle *(*fn)(u32))
+			       acpi_gsi_domain_disp_fn fn)
 {
 	acpi_irq_model = model;
 	acpi_get_gsi_domain_id = fn;
 }
 
+/*
+ * acpi_get_gsi_dispatcher() - Get the GSI dispatcher function
+ *
+ * Return the dispatcher function that computes the domain fwnode for
+ * a given GSI.
+ */
+acpi_gsi_domain_disp_fn acpi_get_gsi_dispatcher(void)
+{
+	return acpi_get_gsi_domain_id;
+}
+EXPORT_SYMBOL_GPL(acpi_get_gsi_dispatcher);
+
 /**
  * acpi_set_gsi_to_irq_fallback - Register a GSI transfer
  * callback to fallback to arch specified implementation.
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4e495b29c640..1917044dea72 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -336,8 +336,11 @@ int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 
+typedef struct fwnode_handle *(*acpi_gsi_domain_disp_fn)(u32);
+
 void acpi_set_irq_model(enum acpi_irq_model_id model,
-			struct fwnode_handle *(*)(u32));
+			acpi_gsi_domain_disp_fn fn);
+acpi_gsi_domain_disp_fn acpi_get_gsi_dispatcher(void);
 void acpi_set_gsi_to_irq_fallback(u32 (*)(u32));
 
 struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
-- 
2.43.0


