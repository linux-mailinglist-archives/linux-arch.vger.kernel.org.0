Return-Path: <linux-arch+bounces-12965-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE073B12AC4
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 15:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3F47AFEAF
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAA6286D79;
	Sat, 26 Jul 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm/xGPXS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B77285C82;
	Sat, 26 Jul 2025 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753537377; cv=none; b=rrWrThwZJ2uatXm2F9P0cfYGmJUPttu3hkG/7L7TJS4M81DGtLqgrDULBlt3ns3SmJGAuCwp3Ue79nbIm/LJpIv7gGalPr5veqDuaDA6rKjxkCqZtpLtbiHVD21v9ep81V1rHK4UjbCGY8MwEVeZsNUDDAb1UKDy+kCV7u49snM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753537377; c=relaxed/simple;
	bh=vpksvMKwENgrXP2h4WAbOgqNikvAOcgpozSEs0HUDlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yq88RIAmPJ30R9nuhnLcilWOadSzExnsWVHJ8JGo5EXSZW/BOvZkA0YvizJntGGe6rtfdq2diXSoRI1ymytRbAh2wrW9cg+qzjmlIdf7eWU4VS4I6AjY3twQycF66q9Hn5z9XfJKSbINVIgiW+qgQzOCS4ooRKSuJ7sKNrMT6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm/xGPXS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31329098ae8so2632211a91.1;
        Sat, 26 Jul 2025 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753537374; x=1754142174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOkcVu/npXJ4elHeqrWwDUQjjmkIstYw0/2b1J3fMr0=;
        b=lm/xGPXSk8Qtt7BxxoM1U6Gv7CIP/3fndeYlNDR73VIkiDhZessqcNw9mp1AkNRpQB
         aDs4FNgHJWf1FbxUeRY2Kko62rmDNWOX8gIZdyAmyyL5BYiKHAP5QfNj33yNnDgCspjb
         1ZBZMuSU1lMVHG2psnw6gi4YgBC/V4jtrpD80F0C/SbSvsD5r69kMwqBS4M8/T7JIUuX
         044DW7NXtATuZ6kdERyQLU1xFpD7LRDpQilmO0ZXpBZMYswUdXVi2ISiQEEqOcLgCI0G
         7AENZzUVtKWUsM3IA4P7JLA5Sr4eEzIXIC02VF2M4LpBHgy86rzYyxRdyRzhItnnVVK1
         XGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753537374; x=1754142174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOkcVu/npXJ4elHeqrWwDUQjjmkIstYw0/2b1J3fMr0=;
        b=H6rVZa1gU1MJib9OWopXV9nMqC0tHlZe+N3DU+FB1NIc6cPYKFdrQ/LZOJOHhSCCnP
         gUhcfHzWFDqREnN94bPebUxbYO5JHKv0ArfhXg/OlJZ9k3mAjeP25e5tU7/PC9rC5mq1
         C2+bG9MKfm/7xvif3bp6cFqOsgIdmxOpblTjObV0E967/fFeu2in5nl+NGMwiik21atZ
         LGWTf4U7syIYaw+Z2InRmTe/3cjxO6HQSBUPZ6aj63sY9CMKKSrWV+Fwz94ZZf9Uv893
         W0y6jzAiidE5iTKlIUNVI+zYpEB5UmHKgF7qkDndGdWe5JjxvM4T8cXdBeiytNTGw37p
         vtEw==
X-Forwarded-Encrypted: i=1; AJvYcCUXWWMKzoBc9U1lLHZNI3CftLhmYVcutmObcgCsZ+UFveen44Z+7Un2hneEEG/eNQFEBOkQkyfQpwmM@vger.kernel.org, AJvYcCUj+5pyCM+Cgy+tt+cXN5ZtgOMl2ByTJwUFxobwFbsEbHxXB5ZaVk/fNCTPoKkngzTcbn8niStb0C7vCf0d@vger.kernel.org, AJvYcCXEQck5tKFndMNVVX/FqwO2z9DDrP9wnRFUTwDWjjHhoShWpz8F/d0JiLxdbRpzDb4KIm4Q8uz0U0qdfVac@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd9sdaj2zRatmtP3qrk9pjWx69LxYwCRymgR/rCu8sOTXaPsg+
	BjL8eFc8gTtFtTU8Ds2eT1cB9qn92hZDUxJ5si2M4py/4wqMiftxZKh/
X-Gm-Gg: ASbGncu1gj/3wUQvllFXW+CAnJ3o+kMUsw/iXf5axkOX0A3T4NllPyY7rrxqreR5028
	miE59UrVIgI9SHzjrZmmsEDQ+dv5Ui+s1Ioxo2ZGSijvJTNLabNBojScRNYCdQ4hD6fN4/SMwyW
	bD7OWVBwD1UFeuoJq59fOauWP2sFaYasga7nbwEXCRgCCK8e8V7CYnFPRVzrrnuwMaqw2psRaO1
	1va928bnItDiqXamZJXU8QpTMd9lQwh+8m2534tFGbpiSmrhQbfifqfLsvlNxCJKWcCZ92ikxdI
	hhkSnwLRsyr33pAggVgT3GxALidorg3YxGyfIlOKEj/d5CTFlGfUneNO0tS2//ykcm2Jz+j2IkB
	5PrU6KaXoR9+eHyFJcgdWJNgFxtJix+rvthTOi71OZhSK5X3WfXhQsRy9XZMvEA==
X-Google-Smtp-Source: AGHT+IEumo1XidKxZecIYdAmSbLXM9CW7e/wMctilSAzBY+gyptmtizmnRHrd+5HmioySzpXTEBVrw==
X-Received: by 2002:a17:90b:2513:b0:31e:a8c4:c188 with SMTP id 98e67ed59e1d1-31ea8c4cb23mr726855a91.14.1753537374489;
        Sat, 26 Jul 2025 06:42:54 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:77:9619:11b0:a73:e5a6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e83508500sm1869190a91.22.2025.07.26.06.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:42:53 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	Neeraj.Upadhyay@amd.com,
	kvijayab@amd.com
Cc: Tianyu Lan <tiala@microsoft.com>,
	linux-arch@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH V4 2/4] drivers/hv: Allow vmbus message synic interrupt injected from Hyper-V
Date: Sat, 26 Jul 2025 09:42:48 -0400
Message-Id: <20250726134250.4414-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250726134250.4414-1-ltykernel@gmail.com>
References: <20250726134250.4414-1-ltykernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

When Secure AVIC is enabled, VMBus driver should
call x2apic Secure AVIC interface to allow Hyper-V
to inject VMBus message interrupt.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC V3:
       - Disable VMBus Message interrupt via hv_enable_
       	 coco_interrupt() in the hv_synic_disable_regs().
---
 arch/x86/hyperv/hv_apic.c      | 5 +++++
 drivers/hv/hv.c                | 2 ++
 drivers/hv/hv_common.c         | 5 +++++
 include/asm-generic/mshyperv.h | 1 +
 4 files changed, 13 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index e669053b637d..a8de503def37 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -53,6 +53,11 @@ static void hv_apic_icr_write(u32 low, u32 id)
 	wrmsrq(HV_X64_MSR_ICR, reg_val);
 }
 
+void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set)
+{
+	apic_update_vector(cpu, vector, set);
+}
+
 static u32 hv_apic_read(u32 reg)
 {
 	u32 reg_val, hi;
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 308c8f279df8..aa384dbf38ac 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -310,6 +310,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	if (vmbus_irq != -1)
 		enable_percpu_irq(vmbus_irq, 0);
 	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
+	hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
 
 	shared_sint.vector = vmbus_interrupt;
 	shared_sint.masked = false;
@@ -342,6 +343,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	union hv_synic_scontrol sctrl;
 
 	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
+	hv_enable_coco_interrupt(cpu, vmbus_interrupt, false);
 
 	shared_sint.masked = 1;
 
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 49898d10faff..0f024ab3d360 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -716,6 +716,11 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 }
 EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
 
+void __weak hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set)
+{
+}
+EXPORT_SYMBOL_GPL(hv_enable_coco_interrupt);
+
 void hv_identify_partition_type(void)
 {
 	/* Assume guest role */
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index a729b77983fa..7907c9878369 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -333,6 +333,7 @@ bool hv_is_isolation_supported(void);
 bool hv_isolation_type_snp(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
-- 
2.25.1


