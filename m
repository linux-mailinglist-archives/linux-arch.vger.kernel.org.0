Return-Path: <linux-arch+bounces-13084-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C59B1C988
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 18:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86ED04E36A5
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A5E1ACEDA;
	Wed,  6 Aug 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxRbM4P3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0001235C01;
	Wed,  6 Aug 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754496064; cv=none; b=pqyzYgxJL+cdQxhb5eIgszo1EPO9y9xKfUmTE24K6seD9nu9LsiiWwu3MaPqErcOdfJJ6GPM7u/Capo/3ZTzyX2guTfuwF+61vykDQM/vb/dTWMuq4ibsLyi3bmkWMi6wfqVLYX76yaHU5lvv+2pG5BgaOS4XAhKxdkbIhBaDjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754496064; c=relaxed/simple;
	bh=QLPgPHPIllDNb8Ze6G4a3/OrQl4N79c/ovwyF8wJPXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/mItavPudvzvRfUTotMkLbU+sqP5XWxZ7kKQ3sGWlaYzHyZKytfbFrm7MaVxdgRX5LC5cxHJVQJuzKgtseJ+23V0zqzzcw3FJwY0Av27XFXCC6qzBfDl82im30xzEVz8EAwRaLLk9A7paaGvAEjO2hc6x2a9b1cIMGkodJ2RoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxRbM4P3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2402bbb4bf3so70597195ad.2;
        Wed, 06 Aug 2025 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754496062; x=1755100862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN7JC0P0tax6wbVXrnnUfj1PVmtPbYEIe/lhtOKcM44=;
        b=mxRbM4P3XtVxUq6mPvPW0jqKUJb4gA8+T9NDs2M0Mv7V0qefFPA9J89tqe5SmI2QgV
         cns9zzjB64wMkneP3L82qytn2nyTf0pXMckdnzftYHwKY09vzQ1dCR1hB3dUqPUK4VvI
         WXepy/YNr6ppW/9Ke9vu4fU1bVaDRGaOd0H7ZRItvxRYQFs1sSw+mhVsfvuE+FMv2JnO
         pGjqbCUqJtZO7uXPavQSQAxxYPMVnWfZ8y7f0+Ud/rUtrWUHT0Aus6ZJb2iDOaFQV+Yq
         N5iDsrvz0woUHBIN3KuHiYvpzLAdtNjq1gHs2GmICDZZIyj9NPQnu2OMXmpyRq8oxaD4
         W4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754496062; x=1755100862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fN7JC0P0tax6wbVXrnnUfj1PVmtPbYEIe/lhtOKcM44=;
        b=ps/hLJl2yQTxyLXemMBo0x82hj6zOEA2reYP/e5qJQDGXRuhOv/qKS/hZIRDYne+IC
         iXE/9iwod+RgT4eP86uOZwht6tI6XMWSPOqQJsopYggvdgSfAu/IBOIFWcZWeAU+tr6J
         tGju/+BKUyLlMoGoy0j9O170FIUEXuw8kEiBoOYm3Or6eCwOKZROoqG261U7KTuEtnDm
         7tmdy060EBi/CTkYkLvOxLniv27dOw8cLVw6cv0/9R2Xjz2IXyfIS66wWcIisgyw8q++
         XJaZsSn6PZunvTfJ89LdV3ZmezhUuRZbD+tzyUGUxlIIfSZvL0grP1Mfs5svjtdV6+7/
         GoUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVksQH5uqypiXEGHO+IO8kvpz5oCYchxiwV1Y/3yvuF361B/sWSNQxkTGIcYqVIESSpCU3M1AWsn4Ci@vger.kernel.org, AJvYcCWSmiymWp8Sxxd7zyeSXKSVKuAteWdUsd+fDsK3cfi0aKDkdF4q39klUGsvXJ39FsVvyHJcvdLX4MMQTJAH@vger.kernel.org, AJvYcCXBrUE5dEacvNpulEwK/w25yPCm8Ua6M678qH6WOznP/beeUJqb1oLz46GebUkUZ4HhVqauh6oEFtkVpztn@vger.kernel.org
X-Gm-Message-State: AOJu0YyAP+vXFZdp3HSX1iOKKnN5bjt5R1yCUY/NjBy5Ou+XEdnGGlsA
	sfG9SYemxSjZ9LTVs9CseqX5d0iNwNuCIGn6Iak5cQsHd8RLfSGNsQB8
X-Gm-Gg: ASbGncvWu1K9XMdNI+aOPGd1byOxHHUmqGi9y+3GnWoQZEQ6HRREIzXRZKC9Gca0uGs
	NaREW59bQmK9zamNrA+AaWNdTlVatFUHCR6rCYRMF4YyIktm4xLTcmuK+UQ2O918Pd8djbuLcDZ
	GnXctDr/E9ZlKQp4wW5jrBI7sTAgIClZKnpO46LlLXOYChEgF5Mx5Qe01xUzCSZ9faSdJ1qHabP
	3O4Xc37U8HtAKE1LNUYHiHYeo8rH3KZx4DybrqIPnXXpM3v7cVogdWwQA1gs8m0EITs5giTnyc9
	po2A1S1/ToILue2L3wExeQt01juqgFusRSzq8lMEQwjpQ17OQpEx5gTkOIHe1jgliRNzoOlB8d9
	QP3EUZlTO8etZEI4wt38C7/L71lsH1ciNfU+jCVnDZE66N/8kXo5Sc2XfSw==
X-Google-Smtp-Source: AGHT+IFk9hft4VZWvhM12Px9RnFBC2Bjqq6z1SbSuTR/CWvyj6STBsjAK+OnWDi2tfLR207RA4xLpQ==
X-Received: by 2002:a17:902:fc4d:b0:240:2bb6:d4ae with SMTP id d9443c01a7336-242a0b6fc72mr38411005ad.30.1754496061900;
        Wed, 06 Aug 2025 09:01:01 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef65d2sm162673975ad.31.2025.08.06.09.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:01:01 -0700 (PDT)
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
Subject: [Update RFC PATCH V6 2/4] Drivers: hv: Allow vmbus message synic interrupt injected from Hyper-V
Date: Thu,  7 Aug 2025 00:00:59 +0800
Message-Id: <20250806160059.6244-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <SN6PR02MB41577D7BFC7FA078880979A5D42DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <SN6PR02MB41577D7BFC7FA078880979A5D42DA@SN6PR02MB4157.namprd02.prod.outlook.com>
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

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC V5:
       - Rmove extra line and move hv_enable_coco_interrupt()
         just after hv_set_msr() in the hv_synic_disable_regs().

Change since RFC V4:
        - Change the order to call hv_enable_coco_interrupt()
	  in the hv_synic_enable/disable_regs().
	- Update commit title "Drivers/hv:" to "Drivers: hv:"

Change since RFC V3:
       - Disable VMBus Message interrupt via hv_enable_
       	 coco_interrupt() in the hv_synic_disable_regs().
---
 arch/x86/hyperv/hv_apic.c      | 5 +++++
 drivers/hv/hv.c                | 4 ++++
 drivers/hv/hv_common.c         | 5 +++++
 include/asm-generic/mshyperv.h | 1 +
 4 files changed, 15 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 01bc02cc0590..c9808a51fa37 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -54,6 +54,11 @@ static void hv_apic_icr_write(u32 low, u32 id)
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
index 308c8f279df8..355663a6e3b8 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -316,6 +316,8 @@ void hv_synic_enable_regs(unsigned int cpu)
 	shared_sint.auto_eoi = hv_recommend_using_aeoi();
 	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
+	hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
+
 	/* Enable the global synic bit */
 	sctrl.as_uint64 = hv_get_msr(HV_MSR_SCONTROL);
 	sctrl.enable = 1;
@@ -349,6 +351,8 @@ void hv_synic_disable_regs(unsigned int cpu)
 	/* Disable the interrupt */
 	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
+	hv_enable_coco_interrupt(cpu, vmbus_interrupt, false);
+
 	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
 	/*
 	 * In Isolation VM, sim and sief pages are allocated by
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


