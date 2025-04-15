Return-Path: <linux-arch+bounces-11405-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EB4A8A659
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 20:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1672E7A440D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 18:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB82227E88;
	Tue, 15 Apr 2025 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho1Szp54"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EDC2253BB;
	Tue, 15 Apr 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740476; cv=none; b=YEsrxgxlm/hHQL2m6GtcMVPbFxyNYObBkrWvEcI+go2m3ZGUeMQhryuMMwR8wo6hAJaWCU6isHwiEDyq8I+NdOZDtoKrdATGYGCoWqCr/Fx/6JqTB0WgJAdhraKd6wYPdwFQO2gVg07qX3d4BI7XDJbCrFVd+exgenzCh8sHNHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740476; c=relaxed/simple;
	bh=HqP29UM9WTwkhhOVyDYPq9uHobiLRZYmeg5rOM3U9CU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bk2iEo/RfJFal6/qzye9EWfnEOn/FQeGgUcY9m9Hb5n/Qt/8VYcnDarYNkqhwyDBypgB9ZAjHpUJslpBZKfkfVOOOxN7FoUmgpQIpFhDAKCKj0sJVQywLcZke0e58Li+Fgif3F95kLQI0asglUYc3S82h/AtK2DvpZ6TgFKRpgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho1Szp54; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2241053582dso81675615ad.1;
        Tue, 15 Apr 2025 11:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740473; x=1745345273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M3jQ8j3ltfDdE83JponI6X0TRjneHIZzSPt8rmBXSPA=;
        b=ho1Szp54SiOYKR2paHzh//T2VNuoIX3gDRh0/2CueN3VYeaEvza1S20rupAxeKA0PQ
         zO/LVPFLcfRA+461FH68XBR7BOltDCKiDxE55tocc3+1GwtBy+vrePpKeudEcQU7V+Pl
         Dz+DXGkjctDVOkbDBH6hX9G+H8NV+6b+D993U0CQN48Nqvcc8H9Tz0o17STWfZNKO5hg
         ao0Ole/Q1mZj4Dogj/IZcuVASzlUeilqhiC67ZiUFptFTfS1bM7FIlyyAuK8cYKI/YcP
         Q1bU4NrSz7oVltn/7Q4oUr5jFj26zxDGdGZO78li69SeweSB08vxx629qWocvGBBhiK0
         03KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740473; x=1745345273;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M3jQ8j3ltfDdE83JponI6X0TRjneHIZzSPt8rmBXSPA=;
        b=Rimnq5hKPkoyw3Gi8Dn6TEnDAs3X7jRMuDWtKRHS/6kSJhAH8bs1KSWq8D0uw29qmU
         p9474brGS3xHwl2O03X+uIX68IaBBojVGbm79Uz3yHMk69Ec2KVtDShQIg9RoDprqh4C
         9/g9i7w1LDOKvnedRLjN7Fbi8EjRHSBM2+vvQN1lhZ6ZPnV0YXNsBRVRPkE8aV8NGbYY
         6CdHstHB2HYJ3aKOpwMxFvPi1ka4LP7FjKIMhjpZRkfdyRfEGqbIgzAF96Z9R8dgALHb
         Cvf8lpM7zlLdyDC8B2xGyUy97kyy16wY1kGqqh/cqGqdQiHpKHQJrxhZCnUy4tdt5QET
         aQZA==
X-Forwarded-Encrypted: i=1; AJvYcCUBXTOgwFwoGzWdvzVuqx/5buqQEmXFGGHeEaQyQa2qGwkpAUyMC8LbZuPog/Z3BRi70X7kOxNk3tUi@vger.kernel.org, AJvYcCWd6VnHFM+k6iP0PnLpBxs8sCy9QgNR+RQcgJH5GSIbbm4NxusAROF0Nw+Xdbvq13b+xJMF6bA0b/KA5AlO@vger.kernel.org, AJvYcCXWiSSiZwSHlt3cVQbEkc1rwPklAQgt6q1ji8HkKJxQ059fbnGU5N/FZU6qTRDl9pw0WBjf4FeNxoAQ@vger.kernel.org, AJvYcCXmI01wuAsG1MsYjh9hPMlvErMm6cW2suRHy/EWmvPI0pvYGXDwV1kkh2AnDX0xmKVKnKjRo60Lg9p1QZS0@vger.kernel.org
X-Gm-Message-State: AOJu0YwVOvrAIx1N4tZJq94oUwIQwskCEJFTTQXRzR3L6WU26YtuTuUQ
	Mz370uLbJF68vDHUy7PC6aNgqvWq5XomhP2Poi+y7PHxmPzu6iVq
X-Gm-Gg: ASbGnctQWWAuFc28nsUuFqiYlbipEmselB1spR+IoHFXvePWP9paAMYPvb9d3OJsbOF
	lHq2J98a/CF0TRe0RJtXIhst/PdT636PG39A+v3xGkkcD6c/p+0F+Z5fgYu0xqI7PuvwusTZ/xa
	6SImP7kwPHxHJ1coAppZU/pRvyEvQ3caWXZnxNOusZ5a5FSmhU56ZVIiyA/lU+gz54wj1RyHAlg
	E8AQ9Sjsq83KBG8peqX1qpe/i8i2mrhhPnqqxJ2sIAN/xLQqQtn8Dy5dn9Q+w2whQ+AQBNpzE+I
	+DaGln8q1b1LfVNJXE3x+VPzuro22PzahtxwKNFQIfgiFctfsCoGxtETFKJoLfABOsmtOZwV2im
	AF3TajXVGRyNXk7gY4U4=
X-Google-Smtp-Source: AGHT+IEMxysTi3FUHFr3RwKNcy7O705ie5TcwDsgpfUdTDjlk+dAuGCmKwDaRys95Y06UoYi6VC4xg==
X-Received: by 2002:a17:902:f710:b0:224:1ef:1e00 with SMTP id d9443c01a7336-22c318d0837mr1956765ad.19.1744740472798;
        Tue, 15 Apr 2025 11:07:52 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb52c2sm120168425ad.194.2025.04.15.11.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:07:52 -0700 (PDT)
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
Subject: [PATCH v3 2/7] x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 1
Date: Tue, 15 Apr 2025 11:07:23 -0700
Message-Id: <20250415180728.1789-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415180728.1789-1-mhklinux@outlook.com>
References: <20250415180728.1789-1-mhklinux@outlook.com>
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
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
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
index 6d91ac5f9836..cd794baaa636 100644
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
index 13242ed8ff16..ccd9c24722f9 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -125,8 +125,7 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 
 	local_irq_save(irq_flags);
 
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(input, 0, sizeof(*input));
+	hv_hvcall_in(&input, sizeof(*input));
 
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->vp_index = target_vp_index;
@@ -216,13 +215,11 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
 
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
index 31f0d29cbc5e..82c4e84541ab 100644
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


