Return-Path: <linux-arch+bounces-10698-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFD0A5EBA0
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 07:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F93B7428
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B482E1FBE89;
	Thu, 13 Mar 2025 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1DDhJHD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1290A1FBC93;
	Thu, 13 Mar 2025 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846770; cv=none; b=W+5Z1ZStVEP7uNYIUlgLKvXPC+lssuIE9ybueKB7vhS3Nj/qWrKA6bmv61y/t7619dvmrFBDWHe+mD4lrpclV4Rh/BnnIYEy4QRyPfxiGrJIE1LHR0reCitA2CRoVmxvaIvvsM/bqoxxdcT+0Bd4y8jUN2wjnZDZDcGBQKv3b4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846770; c=relaxed/simple;
	bh=sNeLHLvS125UjEyglhRWjiSngcYQFEuWWCeGSQELdfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9A+GCx3rzsUA3LlpgBUTQfoE6mgaKbqjABLQQhpivjVMyKiTgTWzTCk4elQLxFmvLgA2jyAZwSUtpgNt3B5sR4e8UP/YTCaqN2Y/nKvgAvb8cIO8I27TR9TFF1878BlECiv4fhGW5c5O+XlUKnoCcDdiLxVhnKz1bkRE2RYUek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1DDhJHD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223a7065ff8so15982775ad.0;
        Wed, 12 Mar 2025 23:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741846768; x=1742451568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lVILxdziP1NvabNMhmzXbXNckUkSyJVqto36jQ3zFgM=;
        b=Y1DDhJHD+4AwNBNT9xAvVoyOi1L+LoTJwQQXQiz9BkHqOGStWNACpAV36LY7vEvbL8
         PyGROfsnN3+DIBt2tNarTgHa1xlEcKuW1BQNfq/NUdK6ZREwBE4Yu4Z0Zh2pp1gcdSXx
         SXcd63CZHbRiI7tceNc1I5z3rYyUYPCxGJHbq3zrisJ30AGqfEKYvJKqmgmXr8cjk4Lh
         9K+osoUEcqEp9WgmEUDTa5twDTHOdFVIKGoArM6pl3DWD/k1WSyLAI+mPyNmG6Oh6B21
         eOdEQmXHfJ4dvONbMT4cEQw9V/GaHmy673vUeheu2iFfZxHOaPzo+lY02D4ewzlw5z/E
         y2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741846768; x=1742451568;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVILxdziP1NvabNMhmzXbXNckUkSyJVqto36jQ3zFgM=;
        b=vyX30qRaS334NRhQP/WPH1Rd89KKMpAiNl3FxWpv565T1mC3dIr9mSvC522i6zuuwu
         h1MuqT5VwPYTZrzEVX7FHBmz/thUcvG4gZ8Gkca7pUxiSeGQux+lqAtCizhTwC/Jmkd/
         7XI6ysRVc+W5lqVaPyiqXykadXe7p+atIeUz4c4l7vbLhdP9OXQRWJmXm7BNgTyzCEmi
         6OvrAr4DCyyeE4D8oiKovDibFllJ3+YE+nO9liF9DVI4ShR9iislre4yA/Gc1MrznS37
         yfKJ6Oe0soHi2iyK44sV9/4ep/Qf87jDH3jdbwdMTe6YLrbZmjuIV2R/7F69EpTMGHqs
         3BRg==
X-Forwarded-Encrypted: i=1; AJvYcCU2Zw98BDSQ9v9jJhKpElJRDWO7GZMrz5ZuZUXwuJn52jH22blDlrtlfJn/Sf/g+E1fSgBSfGxj8y+G@vger.kernel.org, AJvYcCUgUT1YW9AUuZ8s9l0MTZGn3gPDf/10fh4pEwvLM2R2OiaR7bph04a7VOQM2o2H5Dcu3U0dOMhFdUq+@vger.kernel.org, AJvYcCW5UhuiXhhJ+W2+sB3JlmtGRAPZqchdmiKdXvjN7JmOiaUq+BG0O/+B+6WGs2mEk6wpkJ4K+XlHbcOkHz1X@vger.kernel.org, AJvYcCXEqZz3HQn6o2OAw+qwvtA9uaraRzpirhoIrnFXIUdO8La529O2xe2IiANyVjOtO1L0Wu35GmVjycqVoV+q@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGPA7VUxOAsvtReneo/WNWk7+JM26Snr/AjybaMYsBivgdwaE
	19Ebf3rjdiBNT999mzb3myEtH6CcmuxEwT0ILwrxLjLasRXBzUzx
X-Gm-Gg: ASbGncuVNgGtGjP7OejBhz6kL1cFKwQsHpA2OoLMdHrnM//6xCAAF90+sdutBNI5PkE
	gDLMLSeyQ6/7pJiFtiF3Z6c1tumP6TQHirwujPjL1BlbeS18bPfG+buzNi88BQ+5eP6Xdz5wzTj
	Lks5sZ0MbstT2Tj88MsxewXhPUiCKJo7Jq1qa74l0bKVFqBI1XxpEBWXqQ7G3utSHgSN3GMla6e
	G67xU0feLNnXM+WBa2rJK7xmB13YDlHBc6Q6B+vXOvFxoxlmCH7bPaVTWc4rl/1n9ct3iiuAezN
	NU/Jl4WK8QjgqNP+kJHd+u8KMDqPNPkv5gjf/cWBZ7tqLZSl+F7Ok2JAIY/6SBRkfiTd89jFk/1
	P+nLVVTwlSR+izO1cmPt+8klhfdarkAdLkg==
X-Google-Smtp-Source: AGHT+IHEh7ADj6YUcs5SkzzWI6HIZQv7Vk+Z1XYToZrip4ImNRNrlQOURmLAvEwjkVdtY6foxXTY1Q==
X-Received: by 2002:a17:902:f70c:b0:223:f408:c3e2 with SMTP id d9443c01a7336-2242888a8bbmr415883375ad.14.1741846768228;
        Wed, 12 Mar 2025 23:19:28 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68880dfsm5856985ad.38.2025.03.12.23.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 23:19:27 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v2 2/6] x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 1
Date: Wed, 12 Mar 2025 23:19:07 -0700
Message-Id: <20250313061911.2491-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250313061911.2491-1-mhklinux@outlook.com>
References: <20250313061911.2491-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Update hypercall call sites to use the new hv_hvcall_*() functions
to set up hypercall arguments. Since these functions zero the
fixed portion of input memory, remove now redundant calls to memset()
and explicit zero'ing of input fields.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---

Notes:
    Changes in v2:
    * Fixed get_vtl() and hv_vtl_apicid_to_vp_id() to properly treat the input
      and output arguments as arrays [Nuno Das Neves]
    * Enhanced __send_ipi_mask_ex() and hv_map_interrupt() to check the number
      of computed banks in the hv_vpset against the batch_size. Since an
      hv_vpset currently represents a maximum of 4096 CPUs, the hv_vpset size
      does not exceed 512 bytes and there should always be sufficent space. But
      do the check just in case something changes. [Nuno Das Neves]

 arch/x86/hyperv/hv_apic.c   | 10 ++++------
 arch/x86/hyperv/hv_init.c   |  6 ++----
 arch/x86/hyperv/hv_vtl.c    |  9 +++------
 arch/x86/hyperv/irqdomain.c | 17 ++++++++++-------
 4 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index f022d5f64fb6..b5d6a9b2e17a 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -108,21 +108,19 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 {
 	struct hv_send_ipi_ex *ipi_arg;
 	unsigned long flags;
-	int nr_bank = 0;
+	int batch_size, nr_bank = 0;
 	u64 status = HV_STATUS_INVALID_PARAMETER;
 
 	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
 		return false;
 
 	local_irq_save(flags);
-	ipi_arg = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
+	batch_size = hv_hvcall_in_array(&ipi_arg, sizeof(*ipi_arg),
+					sizeof(ipi_arg->vp_set.bank_contents[0]));
 	if (unlikely(!ipi_arg))
 		goto ipi_mask_ex_done;
 
 	ipi_arg->vector = vector;
-	ipi_arg->reserved = 0;
-	ipi_arg->vp_set.valid_bank_mask = 0;
 
 	/*
 	 * Use HV_GENERIC_SET_ALL and avoid converting cpumask to VP_SET
@@ -139,7 +137,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 		 * represented in VP_SET. Return an error and fall back to
 		 * native (architectural) method of sending IPIs.
 		 */
-		if (nr_bank <= 0)
+		if (nr_bank <= 0 || nr_bank > batch_size)
 			goto ipi_mask_ex_done;
 	} else {
 		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index ddeb40930bc8..cc843905c23a 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -400,13 +400,11 @@ static u8 __init get_vtl(void)
 	u64 ret;
 
 	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
 
-	memset(input, 0, struct_size(input, names, 1));
+	hv_hvcall_inout_array(&input, sizeof(*input), sizeof(input->names[0]),
+			      &output, sizeof(*output), sizeof(output->values[0]));
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->vp_index = HV_VP_INDEX_SELF;
-	input->input_vtl.as_uint8 = 0;
 	input->names[0] = HV_REGISTER_VSM_VP_STATUS;
 
 	ret = hv_do_hypercall(control, input, output);
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 3f4e20d7b724..5d9aaebe5709 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -94,8 +94,7 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 
 	local_irq_save(irq_flags);
 
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(input, 0, sizeof(*input));
+	hv_hvcall_in(&input, sizeof(*input));
 
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->vp_index = target_vp_index;
@@ -185,13 +184,11 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
 
 	local_irq_save(irq_flags);
 
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(input, 0, sizeof(*input));
+	hv_hvcall_inout_array(&input, sizeof(*input), sizeof(input->apic_ids[0]),
+			      &output, 0, sizeof(*output));
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->apic_ids[0] = apic_id;
 
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
-
 	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
 	status = hv_do_hypercall(control, input, output);
 	ret = output[0];
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 64b921360b0f..1f78b2ea7489 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -20,15 +20,15 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
 	struct hv_device_interrupt_descriptor *intr_desc;
 	unsigned long flags;
 	u64 status;
-	int nr_bank, var_size;
+	int batch_size, nr_bank, var_size;
 
 	local_irq_save(flags);
 
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	batch_size = hv_hvcall_inout_array(&input, sizeof(*input),
+			sizeof(input->interrupt_descriptor.target.vp_set.bank_contents[0]),
+			&output, sizeof(*output), 0);
 
 	intr_desc = &input->interrupt_descriptor;
-	memset(input, 0, sizeof(*input));
 	input->partition_id = hv_current_partition_id;
 	input->device_id = device_id.as_uint64;
 	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
@@ -40,7 +40,6 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
 	else
 		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
 
-	intr_desc->target.vp_set.valid_bank_mask = 0;
 	intr_desc->target.vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 	nr_bank = cpumask_to_vpset(&(intr_desc->target.vp_set), cpumask_of(cpu));
 	if (nr_bank < 0) {
@@ -48,6 +47,11 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
 		pr_err("%s: unable to generate VP set\n", __func__);
 		return EINVAL;
 	}
+	if (nr_bank > batch_size) {
+		local_irq_restore(flags);
+		pr_err("%s: nr_bank too large\n", __func__);
+		return EINVAL;
+	}
 	intr_desc->target.flags = HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
 
 	/*
@@ -77,9 +81,8 @@ static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_entry)
 	u64 status;
 
 	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
 
-	memset(input, 0, sizeof(*input));
+	hv_hvcall_in(&input, sizeof(*input));
 	intr_entry = &input->interrupt_entry;
 	input->partition_id = hv_current_partition_id;
 	input->device_id = id;
-- 
2.25.1


