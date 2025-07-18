Return-Path: <linux-arch+bounces-12848-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8552B09AB2
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 06:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A835A7ADBE6
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 04:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056801E5718;
	Fri, 18 Jul 2025 04:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDp0qMZO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D211DF261;
	Fri, 18 Jul 2025 04:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814561; cv=none; b=Gu27BfkHmcuR06XfrJ0egMk9Micg4LrXrnZdNxm1S/ruOtyTAR45Vn8ItliYxVq/ivS8136nzIw2zwiOjnDgohw6DJ1kdcmEDUZDxpWZ6HPPAePyTj+b490nJXkKS8Kzbe5ENakHyLlBTAowgNW32Z2aQKA/1gKZ0U9ceHWhjzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814561; c=relaxed/simple;
	bh=xPesFCUozidUZ3QZc767Lb5uZZJrIdrIuqrKnh3yL3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G8OGGCf73PvlKHS4RbE+4Ock5LPzCM3rhviVmFoN6OZP9LLoroWmLoOQGxe2ofhg6BV4q3D1Ts7grZU62+0zTfHSvXCUU1kv8Ga65q8xLsuEMgwZsrIwBCW/cIkdJdjOI1UOj6dNOVUys82AGhhxevUDclCLAaRltGEYzjqrPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDp0qMZO; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b31c978688dso823575a12.1;
        Thu, 17 Jul 2025 21:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752814560; x=1753419360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3SOSm0yfOejyCAi5SQeXb76AJ/w/XqxC5rGprpKDvac=;
        b=YDp0qMZOjYdmfE1KyiTWKCj7B3MGsBBOZFINLa2wpm/SXqepFi1+cpxEjGa6XVfOm8
         QPrRIN365s2wCtQ4gty/DCV8J8uS1AM5Zvld0gI8pKTKUPCXuq8UCsiQvmhx8H95FDIb
         Cid+zSUkFUFbajiC5ySvOi4JMf23dpJjsqMgRbkpz//FHzHEXR7bDoE99P+hRNTrYh7W
         pIPOgdE0nVQuH53Rzb7G7ErXUM1AUccQAXXwrgQgxtkqpyFr4dDHyyf++txJqxtpn4hB
         13o/VL5Qb8WYCxIx+auVzyiM17VEw0p3vxGr9qN7XgVNGoHzkFIzKRP5OjlcT2juSgXL
         wLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752814560; x=1753419360;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SOSm0yfOejyCAi5SQeXb76AJ/w/XqxC5rGprpKDvac=;
        b=gtf75pXTrxJgzjFp/nz/fAWgHScQlyi/quW8REx1x22exHl9F18s7n7xyPzAUUw69J
         mE3dRuhliDsyDE1WCEF2QlBuwFfVpGgq/anQYKqfufAhxi+KaNJ+CWJD+oEzpNf77mSS
         EwMjMfhir/JO3BUze3pZKLIs8V5Dncke8L3UYbKBPUR19AJlM8BnVvt7UcbLGLrozgRJ
         pEcZmxDsSXFv86m6IwvbsO3W9iCvUsZuj5B22DaEMWEVgRusphEUvU/iXjNxuZ4Fn5iY
         +c7RsC+PKhoFVEO/Fxk3VrgiLbM+WdP1FbHG4eDwNT29ONVs4D/RrRZaTA/Kb+nkQSsI
         EdRg==
X-Forwarded-Encrypted: i=1; AJvYcCX82YPAXvjsQpjARX8WvCSWSFWkVCB5gldbaDR8qzoXg/fLt3zVide64qqPjsZ22MkLSSy976+k8MZZcfD0@vger.kernel.org, AJvYcCXAsMPS1cTFfBt1K5CMMNH73Wmhffinfi8ilrhiYtSiHdBOXv0SCeDWeNiVOIwyWhTjUN+FXLcvOasy+hxP@vger.kernel.org, AJvYcCXOD9K6OOWmjNSZD1I/QCUICdvC/u/L4Halaah39tAefzae5ge337ZxIxcc8ZxvPQUzDIhdmvwgmWUp@vger.kernel.org, AJvYcCXPf0KdZTChaTTzSImllkOjkCZZFIspwqrf1cpikfzeZdNt2fS73UH7eGd0KfSXoajYux8JoYvHiPYi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/EU5/c/hE7GtCqYZCa+ewwxSQHJiVFiuLcAYwiBf4sP6gJTSC
	ichblgDH8OWI5l3tNNQgHAV6BJAkHhH+Gr3d4zVWbTN/eHuWU3W1/HGh
X-Gm-Gg: ASbGncvXwUTChXKmp3h9Kvyfj/kg3LQyMkgrihg692dwcCAI27LVAzA5bLL+BEXZSr8
	bm6I9Gov/zlqzlQXF3LqBsBw/x9eZ3T7TnelrWZa8LahANwKzsE0cqtmlBvpnvEF+3oZTUyMjvO
	rkrzBXTsrdH9MKpZoLnaSW1UFQwXL8LvUi+/YyjxM2FG18BUGacKq7HuUnKg4M2/Akoi+RiB96J
	97NPMLcP+nUgEwb4y45H63Yx02OwEjoydzN0bonrrtPJcO3PLLeuAXAt09y2TkFDjQwmgZmK1sy
	v17LF61M5+gb7fi8k+QhRPnOnlM/eZ5+ApTfX/41S9W37/Z6R9QeOXNimuNDg7V2Rgn27CRzVMm
	D1ExygfEO34IeeALIWzzzoHc8RKzqyFkMYD8D1asuK9MGTrRaN2Rkw480KyUD6KuInH3fRW6/1A
	pIykZTN74NdJB5
X-Google-Smtp-Source: AGHT+IHoe9x5uTof8QDzxezIFS33hnbeXPYR7thO6gnxlwgvMM2NRy7MwFCxNEosmf+hf7J45ly4nQ==
X-Received: by 2002:a17:90b:4acf:b0:31c:c434:dec8 with SMTP id 98e67ed59e1d1-31cc434decemr1447635a91.20.1752814559370;
        Thu, 17 Jul 2025 21:55:59 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc33715b2sm476907a91.24.2025.07.17.21.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 21:55:59 -0700 (PDT)
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
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v4 2/7] x86/hyperv: Use hv_setup_*() to set up hypercall arguments -- part 1
Date: Thu, 17 Jul 2025 21:55:40 -0700
Message-Id: <20250718045545.517620-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250718045545.517620-1-mhklinux@outlook.com>
References: <20250718045545.517620-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Update hypercall call sites to use the new hv_setup_*() functions
to set up hypercall arguments. Since these functions zero the
fixed portion of input memory, remove now redundant calls to memset()
and explicit zero'ing of input fields.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---

Notes:
    Changes in v4:
    * Rename hv_hvcall_*() functions to hv_setup_*() [Easwar Hariharan]
    * Rename hv_hvcall_in_batch_size() to hv_get_input_batch_size()
      [Easwar Hariharan]
    
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
 arch/x86/hyperv/hv_vtl.c    |  3 +--
 arch/x86/hyperv/irqdomain.c | 17 ++++++++++-------
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index bfde0a3498b9..bafb5dceb5d6 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -109,21 +109,19 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
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
+	batch_size = hv_setup_in_array(&ipi_arg, sizeof(*ipi_arg),
+					sizeof(ipi_arg->vp_set.bank_contents[0]));
 	if (unlikely(!ipi_arg))
 		goto ipi_mask_ex_done;
 
 	ipi_arg->vector = vector;
-	ipi_arg->reserved = 0;
-	ipi_arg->vp_set.valid_bank_mask = 0;
 
 	/*
 	 * Use HV_GENERIC_SET_ALL and avoid converting cpumask to VP_SET
@@ -140,7 +138,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 		 * represented in VP_SET. Return an error and fall back to
 		 * native (architectural) method of sending IPIs.
 		 */
-		if (nr_bank <= 0)
+		if (nr_bank <= 0 || nr_bank > batch_size)
 			goto ipi_mask_ex_done;
 	} else {
 		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index afdbda2dd7b7..b7a2877c2a92 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -685,13 +685,11 @@ int hv_apicid_to_vp_index(u32 apic_id)
 
 	local_irq_save(irq_flags);
 
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(input, 0, sizeof(*input));
+	hv_setup_inout_array(&input, sizeof(*input), sizeof(input->apic_ids[0]),
+			     &output, 0, sizeof(*output));
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->apic_ids[0] = apic_id;
 
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
-
 	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_INDEX_FROM_APIC_ID;
 	status = hv_do_hypercall(control, input, output);
 	ret = output[0];
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 042e8712d8de..fc523a5096f4 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -131,8 +131,7 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 
 	local_irq_save(irq_flags);
 
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(input, 0, sizeof(*input));
+	hv_setup_in(&input, sizeof(*input));
 
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->vp_index = target_vp_index;
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 090f5ac9f492..87ebe43f58cf 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -21,15 +21,15 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
 	struct hv_device_interrupt_descriptor *intr_desc;
 	unsigned long flags;
 	u64 status;
-	int nr_bank, var_size;
+	int batch_size, nr_bank, var_size;
 
 	local_irq_save(flags);
 
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	batch_size = hv_setup_inout_array(&input, sizeof(*input),
+			sizeof(input->interrupt_descriptor.target.vp_set.bank_contents[0]),
+			&output, sizeof(*output), 0);
 
 	intr_desc = &input->interrupt_descriptor;
-	memset(input, 0, sizeof(*input));
 	input->partition_id = hv_current_partition_id;
 	input->device_id = device_id.as_uint64;
 	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
@@ -41,7 +41,6 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
 	else
 		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
 
-	intr_desc->target.vp_set.valid_bank_mask = 0;
 	intr_desc->target.vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 	nr_bank = cpumask_to_vpset(&(intr_desc->target.vp_set), cpumask_of(cpu));
 	if (nr_bank < 0) {
@@ -49,6 +48,11 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
 		pr_err("%s: unable to generate VP set\n", __func__);
 		return -EINVAL;
 	}
+	if (nr_bank > batch_size) {
+		local_irq_restore(flags);
+		pr_err("%s: nr_bank too large\n", __func__);
+		return -EINVAL;
+	}
 	intr_desc->target.flags = HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
 
 	/*
@@ -78,9 +82,8 @@ static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_entry)
 	u64 status;
 
 	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
 
-	memset(input, 0, sizeof(*input));
+	hv_setup_in(&input, sizeof(*input));
 	intr_entry = &input->interrupt_entry;
 	input->partition_id = hv_current_partition_id;
 	input->device_id = id;
-- 
2.25.1


