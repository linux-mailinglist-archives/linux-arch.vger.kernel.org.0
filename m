Return-Path: <linux-arch+bounces-13080-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3766EB1C5B3
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 14:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5628B562818
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 12:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C47428A735;
	Wed,  6 Aug 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj9qrj4p"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC21E26D4DA;
	Wed,  6 Aug 2025 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482742; cv=none; b=HS/3AoRa3dzKfUnciU4vtjjlnNeRQYLWxqG+Bs0JeyirIdJ0x1dddVYUID5WwD+QiA1P0ePUBAvmVN9/7es0j+EQsVoJgfCkks6Gdv0YH6vtDlU6EUbjhkMiy73cJFadKB1C4dxRpNFOfJqqdr+Uv8TvOy0hiifhnvMUN9X/DNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482742; c=relaxed/simple;
	bh=GVty5/0Ttb9VZ9XytQgM7w6VAdlwlTBNzWw1/nVPS4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AA8Jc30u32Fg/eJURsyjVIg1l9+Kj0zY5+KFpr0BtWou7ApDgLVFANBOqr25rc1IMjqEYdBQX9I+CSVPifhButtI5VAQTA3qSz+j5nDMN32atWQ4ZcwkYDTiI4U+K2NJC1+zFGJ+KzAC9nO8IUpih/Oz28g/j+iR0mB/uuu5mo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lj9qrj4p; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23dc5bcf49eso94103885ad.2;
        Wed, 06 Aug 2025 05:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754482740; x=1755087540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+Q+j3V/ByE+IaoyN+/BWXCR7kwQAnsARsv3QK+N8rc=;
        b=lj9qrj4pNeRkUsuboK/wxIN3q0fK7JHkHhWgG0wOHFFifhsnYVQbWWFwDyL31z/sbq
         7rQvWaPVMQlIWq9RxhmUgp5Ddg5KYThI6npHE3ExaZ9eHwvQCQeIMEtsXrCv2qtNDCcq
         +EqFtCy70dGqAIY8L9X4h+KSzPfWkOoXzj6vjYXBCMxWQhYDbGjEM4qzP9VH2eONoC2a
         o7Enh+8AzArun67ZuI6QcfwvLjIhr3UM5QbfcVVgUGE0V2Aqq/K2w+Z9t0MIBHe4cl8Y
         36D5bl/JZ46u2Eu93qpg1jsLw5crOE3wyTuHQSAflj7Xou1A+b5p3aeVoqZSU62GCexf
         N5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754482740; x=1755087540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+Q+j3V/ByE+IaoyN+/BWXCR7kwQAnsARsv3QK+N8rc=;
        b=U/4nkf67SQPVwtcSonFrxvfnvSzg2dgK6PezlF1o6oxlJ/sga4txjSSIwhfrJmUpAr
         +nxFp1lGbHwRjiIecyck2/zEzXCnUAdMHeZXjOivKcOdtLvJnc6jBB0POo6kHzllDX9N
         uKZ7gM8Skok+7fBglcUXwcMNKC1Ai0Yd8p4mX8ejhFtFnN9sSPllBiPI0L/VecKdaOLR
         930mTNTrYmHMDEd5+H/wpcOXDt44o0jh786PcC0tuxKjIJ1ZFEfzRLP5WDjN1hsTCgzj
         rreCTk4QsWTR/ZTlrDqx4EReMznngS/LPOgRs3/08r3Z0u1BZp5xNLgl/x6p3RK/1MxM
         US+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU594z+FdBtNkKvtqlu9OVtbQKPPu7YCXkyhNeUpvJRLgQbJNqmug0ux2E1+oP0EXaT9r4B2gq9rY/BL+2I@vger.kernel.org, AJvYcCUpejYl7RWw3/DSinFn90LvPKr9RA6m+30zqAhAPYgL7jXSFKngNDjO2ApFTWpHSrjWtDdT6cZcb+RU@vger.kernel.org, AJvYcCW16uWIWpXBRmJ8gj32Jc2zx6+/AOIN60dmjwpEcxsCeVgSB2kIIhHN51OWuck6zapTwgQPuwjx9Goh/3kD@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqhLdlCKFOzQgDStvDXZScjCG5KZ/nPjA7XG/TMUNt5pqxz2C
	wk5/53HUkPJ6MUN6FIk4EpScGEdifPHYMRgEYQXEMsaaQb18cWT32kbt
X-Gm-Gg: ASbGncvp1njce8xRTO2JeT4/bOyx5KILVqI5Ge354GFvYxfCYfWRwD5hQWkHMwXu+up
	uuikzomOb78w42ddBbYL9dLNa8EWZZGKHdP/A2o7B4xl4wwZloFSXKyWhC9wlyjqqRUERkx/sUx
	ZZd0ziW53EsYBQIX2wm0t8nwdl5uz1DSAjXN69mUzey59mVCoLVNltkp8+caHh1Ro57HtSlA43j
	giwzdxWLuMB6fU4OJ9er0Ir5EqmK+MKYmsa14xaFserF3oTRcBA+fw3dAkVSfXol/RybpA3TrZ5
	r8e6JcYqPEDPrRclYN2sOJNm7d73aerzuatJXDD6rNgwW6wrpR2ZAX8lcRjgZKfGrOMlPOiNfcU
	heUkt+OUhzDagwcIDuuhnR2N+xDL26g8slhpWmu9gAMigmvT9CDZH6LP3fQ==
X-Google-Smtp-Source: AGHT+IF6lsxtDwzX1BSb1lHqE+QCccLHBnKirR91sAXikkQfcoY6C8Bv9nfyDMenjWLIHzbAexHZnA==
X-Received: by 2002:a17:902:f546:b0:235:f459:69c7 with SMTP id d9443c01a7336-2429f5a5472mr34897555ad.52.1754482739976;
        Wed, 06 Aug 2025 05:18:59 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e81dsm157512705ad.46.2025.08.06.05.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:18:59 -0700 (PDT)
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
Subject: [RFC PATCH V6 2/4 Resend] Drivers: hv: Allow vmbus message synic interrupt injected from Hyper-V
Date: Wed,  6 Aug 2025 20:18:53 +0800
Message-Id: <20250806121855.442103-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250806121855.442103-1-ltykernel@gmail.com>
References: <20250806121855.442103-1-ltykernel@gmail.com>
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
 drivers/hv/hv.c                | 7 ++++++-
 drivers/hv/hv_common.c         | 5 +++++
 include/asm-generic/mshyperv.h | 1 +
 4 files changed, 17 insertions(+), 1 deletion(-)

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
index 308c8f279df8..d68a96de1626 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -312,10 +312,13 @@ void hv_synic_enable_regs(unsigned int cpu)
 	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
 
 	shared_sint.vector = vmbus_interrupt;
+
 	shared_sint.masked = false;
 	shared_sint.auto_eoi = hv_recommend_using_aeoi();
 	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
+	hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
+
 	/* Enable the global synic bit */
 	sctrl.as_uint64 = hv_get_msr(HV_MSR_SCONTROL);
 	sctrl.enable = 1;
@@ -342,7 +345,6 @@ void hv_synic_disable_regs(unsigned int cpu)
 	union hv_synic_scontrol sctrl;
 
 	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
-
 	shared_sint.masked = 1;
 
 	/* Need to correctly cleanup in the case of SMP!!! */
@@ -350,6 +352,9 @@ void hv_synic_disable_regs(unsigned int cpu)
 	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
+
+	hv_enable_coco_interrupt(cpu, vmbus_interrupt, false);
+
 	/*
 	 * In Isolation VM, sim and sief pages are allocated by
 	 * paravisor. These pages also will be used by kdump
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


