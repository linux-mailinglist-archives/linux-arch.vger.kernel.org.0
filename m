Return-Path: <linux-arch+bounces-10401-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA0AA46F20
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216DA7A6F88
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16DF25F7B9;
	Wed, 26 Feb 2025 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jnIwE4+i"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C661B25DAF8;
	Wed, 26 Feb 2025 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611342; cv=none; b=Za/KHkGQOEhNhx4nPDuH+1qJ69Y6EiigrebNQj2LqHdhf9+IF2uU2QxSLMO36WvZCntJlXDLJJc08I8p2ogBOYfAQeSK1+BHVV9LWLjMvjXQ4EcBg+d4HdD6PJBuPaFwmqllu23qNNZHwM+Ppc6eq3sjyCUjRIRpAZfmd4D/HwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611342; c=relaxed/simple;
	bh=tHNf3o07yocQ/o/3naYbkpavNlBEbnRHWB84s/Ouaec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VIMXOj/M12AQQaj9EGzbpwRUeunT3cViznz1Qxg0dPzkU0FqNQluXLlsZqoKlAjjRZjcglegIzMVaHkHt6EoOQVluVO8vzOm0L/68rORAH3mri2YPZwDXfpZxjHnvUU0VuHnb+qA6wkSIwj44CZcYwRtym+Q7XYkWmvw/H4yGAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jnIwE4+i; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 68385210EAD0;
	Wed, 26 Feb 2025 15:08:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68385210EAD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740611339;
	bh=D8zKP2hcDp7gg5TGoAjEuRkXHEuh7Rq/cw2eQj8sL+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnIwE4+ikDrarKkipwcw+0csfp/M/FetsQIzxMPtogFCK1p1AF0Hm2zvT/3br57k6
	 A2XLT4j7ii/XpT6MGPkeXLJOkzp61rOGODm0R/hkkhAsRkOv6CuhTqij8ZFgj8R9fy
	 /GpaJGzjiw4xEyM/CH+Ld7sJxdgPz6AlI4q8zPZg=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@linaro.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com,
	stanislav.kinsburskiy@gmail.com,
	gregkh@linuxfoundation.org,
	vkuznets@redhat.com,
	prapal@linux.microsoft.com,
	muislam@microsoft.com,
	anrayabh@linux.microsoft.com,
	rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net
Subject: [PATCH v5 08/10] x86: hyperv: Add mshv_handler irq handler and setup function
Date: Wed, 26 Feb 2025 15:08:02 -0800
Message-Id: <1740611284-27506-9-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This will handle SYNIC interrupts such as intercepts, doorbells, and
scheduling messages intended for the mshv driver.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 9 +++++++++
 drivers/hv/hv_common.c         | 5 +++++
 include/asm-generic/mshyperv.h | 1 +
 3 files changed, 15 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 0116d0e96ef9..616e9a5d77b4 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -107,6 +107,7 @@ void hv_set_msr(unsigned int reg, u64 value)
 }
 EXPORT_SYMBOL_GPL(hv_set_msr);
 
+static void (*mshv_handler)(void);
 static void (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
@@ -117,6 +118,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	inc_irq_stat(irq_hv_callback_count);
+	if (mshv_handler)
+		mshv_handler();
+
 	if (vmbus_handler)
 		vmbus_handler();
 
@@ -126,6 +130,11 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 	set_irq_regs(old_regs);
 }
 
+void hv_setup_mshv_handler(void (*handler)(void))
+{
+	mshv_handler = handler;
+}
+
 void hv_setup_vmbus_handler(void (*handler)(void))
 {
 	vmbus_handler = handler;
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 2763cb6d3678..f5a07fd9a03b 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -677,6 +677,11 @@ void __weak hv_remove_vmbus_handler(void)
 }
 EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);
 
+void __weak hv_setup_mshv_handler(void (*handler)(void))
+{
+}
+EXPORT_SYMBOL_GPL(hv_setup_mshv_handler);
+
 void __weak hv_setup_kexec_handler(void (*handler)(void))
 {
 }
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 1f46d19a16aa..a05f12e63ccd 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -208,6 +208,7 @@ void hv_setup_kexec_handler(void (*handler)(void));
 void hv_remove_kexec_handler(void);
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
 void hv_remove_crash_handler(void);
+void hv_setup_mshv_handler(void (*handler)(void));
 
 extern int vmbus_interrupt;
 extern int vmbus_irq;
-- 
2.34.1


