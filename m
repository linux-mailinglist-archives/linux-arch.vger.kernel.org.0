Return-Path: <linux-arch+bounces-11310-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAB3A7EED3
	for <lists+linux-arch@lfdr.de>; Mon,  7 Apr 2025 22:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5F318894DC
	for <lists+linux-arch@lfdr.de>; Mon,  7 Apr 2025 20:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A61C253B7D;
	Mon,  7 Apr 2025 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s0doI5BI"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6700622331C;
	Mon,  7 Apr 2025 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056830; cv=none; b=AHkQHeMTCEPxkKoCFOeBdmXQpS7UW9U2QetE1HL9Ys1uL04s2zmfKNc0ndTANs2V1UgCjzJqvQH1CsBchnLMUpLuaVQ230C/QwSWgkyReWsIfUB0KcSCszgnzFXkbDko42M0b4bp86AFqpoRlPQ6SpXkFJBolBxMT4D2WbP2gZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056830; c=relaxed/simple;
	bh=SKdz72k2NkyXGdqtVsqW7yFxP3EnThWVkZ2UEaRCYAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2kXP+XwhUIAei//Cznsvohx6R19Y8SCUKwmh/vAxjcrmQ6jl2f1KVw2K96GjxOstc5esxtZc/sR2DXVlR+fk5wfAy1saUwosZ9qbUhEwqqhg9McSPvAjbh0PbQJPwZc89pIUx7CRds1gbuas4tTFdN3eRwnoWExs2k0MU3XLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s0doI5BI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1E9C82113E7D;
	Mon,  7 Apr 2025 13:13:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E9C82113E7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744056822;
	bh=6NhcoKa6JL1NM9sMn3gmj98XuhFiqjkn7M2jrThtdQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0doI5BIqSvNh80G4PtEpPG/GcrIH+4KzmJAOUk4cNIarK7Qz7QqL7bK6hmnu9uJf
	 vUAOcF6S2Chpd1S4F+Kl31SqdwT50lHmnLDhmgf1cFJuXB+MRXi0rUY08gduq48ZrJ
	 oKPn1dnQodDme1eUILnPzUqDulODD1su5F/LKApQ=
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
Subject: [PATCH hyperv-next v7 10/11] ACPI: irq: Introduce acpi_get_gsi_dispatcher()
Date: Mon,  7 Apr 2025 13:13:35 -0700
Message-ID: <20250407201336.66913-11-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407201336.66913-1-romank@linux.microsoft.com>
References: <20250407201336.66913-1-romank@linux.microsoft.com>
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


