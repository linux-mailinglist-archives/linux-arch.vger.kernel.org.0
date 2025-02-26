Return-Path: <linux-arch+bounces-10388-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75683A46BF0
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 21:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0248A18856A5
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 20:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7705A25A343;
	Wed, 26 Feb 2025 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke4Xplra"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A7B25744B;
	Wed, 26 Feb 2025 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600386; cv=none; b=Rf1qSmGEMv0aHHNKIA9bCZcKPSV0VXqjQIHeB80Q1g8FEAh6zcWj29y6emcEHw9notZi0FPmyzu6vLjytqgLpVB4KXMNDt7gZVh/2Xogaz1uDk5dY5YN0WMcPxejXR0O5DKp6PtgYHIQqMzVI1HHxzw92fcUK5qN6/XPzIArVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600386; c=relaxed/simple;
	bh=k+V5fUKBx05yHfLoL5m76aeT57n+ZeCP/vw9Wp90kpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JS9iEnhAfm9J069CJRnSJNyXzqUyZW2d+BpjRltYPpMDO1v/ez61A8mHxLqeHsHpbyH0tI4/Ic3/jyp6j4xD3x6c/fXIwWbN8C0WJa6Oy3WeiKj3Vm2mI5+8hH4Wk0A7g6MCOzUWTywGaTl1T2NjPiZFNzNOFgytgAZdwt0idIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ke4Xplra; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-219f8263ae0so2664815ad.0;
        Wed, 26 Feb 2025 12:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740600384; x=1741205184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qmlflR8I0V+Trqo6jOi+696C/+5CyLaGqLVJ7WAblLE=;
        b=Ke4Xplra4x3886jp6RmVWzCSJD7mcrPEKgFY3e3VUlaB2g5hlbX9C3qrJxcgUuIfEU
         Bt/K6vrxvbVg8RdnoOmDtgPi1zSh4FRJ1mIgphZ660p5wERTJhteRlpIwlrRZKFDzqLQ
         j2q9ygMxLLTmTpMcZR49ctoLGZ7mLFcvDcJ18XwVVZ8Dwl/6Mu81qjsuufGI6vwq29rd
         L8JbSywBxb4Heb1ZBukkwnbqMJxVmLeoSZURe45ya7PSV///e6T7zQocAvZt8gramRUN
         iYx1izyHdtbvnslbd/pvu0Tsu7le6MzQE7Kjd0mMS1kUpUSQW84+Zo/bdY5oeobMBefU
         f/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740600384; x=1741205184;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qmlflR8I0V+Trqo6jOi+696C/+5CyLaGqLVJ7WAblLE=;
        b=k7LkO3NdJsaPkWcS5hQBzZhCfv0A0UHZaRw7+LY1ruvKRapW2AqA47BgXEoxbK0ADs
         hwzx2MSo0dHB90ZRLYe5A8HyJxtv/xJOF3gEXrN7OObxV4ITEeRuK83hfPOz2LOuc2dq
         txQXrWsmKF43qJQhjcnpdl9dCh7/MylatnmjxTrbErIkQPmgj45g2FzIt/A1442lWzuZ
         oxcAC0Qf/gpthrHwny3wEbpjoQLdA6BrSpGnZ+9IJ1TcKu65hMG2X6dZV5yDMmxNGl8v
         C8fNRede5oS6GXIMjJwf+N6Juz1MKrVWS9wmDkKVIIE0wrqTYcIlYRTItjsaz6d2MK6d
         AsnA==
X-Forwarded-Encrypted: i=1; AJvYcCUs9giecivblu/1HZB8n0fGJyhAR1we4W/aY6CyC3+tstfw1UY6ElqrgXfdnCvS62HN6CaLrYvDuiZG@vger.kernel.org, AJvYcCUvTusvcDfyllBSEyI5lbEALMiP8At/C8BMVSXdgD7pA7uVsNdy20GuOkHcS+pbH4gYKX9CIOoj6vhb@vger.kernel.org, AJvYcCV/lls2Cz6M84XZsO6m4rlc5KvJErJeiGEGQjmWS5gEUR05Uy7veE2NCImcRlIxWtIK39k50BsWyxMd+Psf@vger.kernel.org, AJvYcCXdZ7einBZ+AIIHTBljOerH8d9hIse/z/Zqm+2h48YFGn81dk3yY/2BgtOiZUbkZSdipuCUvgteKZmqGU+5@vger.kernel.org
X-Gm-Message-State: AOJu0YwxcZ3M3X7auSrbrAl6Ck10OuO2QEjnEZ6hJ3/JOhRAbZ+QhObF
	GXStKps4TxYPeqbqQfTNkokh94yOX+njuXeXcuvWEX4RRwfVWcZJ
X-Gm-Gg: ASbGnctSdo9dHWmknIWCTV8xTqAJRqQi3vHVaxlKZkLqxCabsEwABVJKWsgIth65fTv
	q+v1518Du6+Fnb3emp1+J4et4FtXAUqrPNAfIG5Lv6XHa/d8kCWo0GlalSVBbBrwDFYOh0oMp1V
	ONhQUYr8qT3N39zeMYdlYjq6A+/yY1pyjc5E5M1M1Zrw8WsoW1gEB8AsyyDVh7vuvL6a8zIw26P
	GYlA7c6NuzuJzdlOEo3qasgmMBCNYx/7nL6gkPi+bQrUOw3hxLNHFv6TcGHGhovHIFolDPX1xt7
	a5/oo2uIcmPHmwFTxNAWF+PGQf0NMLaCuvC6yoEuwiu9IDTsc6dqqvoNWtRdSiPJCJpoAJRya1A
	fnUpV
X-Google-Smtp-Source: AGHT+IGgCrRzE7lCUq6yJr7vMJRE38h6tXtuzzjRC6JDbh4YFPRi6UksigebGzAnF/9qTlDhBEVBeA==
X-Received: by 2002:a05:6a00:2441:b0:732:a24:734b with SMTP id d2e1a72fcca58-73426d7271emr35180911b3a.15.1740600383907;
        Wed, 26 Feb 2025 12:06:23 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81bbc7sm3959455b3a.127.2025.02.26.12.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:06:23 -0800 (PST)
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
Subject: [PATCH 3/7] x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 1
Date: Wed, 26 Feb 2025 12:06:08 -0800
Message-Id: <20250226200612.2062-4-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226200612.2062-1-mhklinux@outlook.com>
References: <20250226200612.2062-1-mhklinux@outlook.com>
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
 arch/x86/hyperv/hv_apic.c   |  6 ++----
 arch/x86/hyperv/hv_init.c   |  5 +----
 arch/x86/hyperv/hv_vtl.c    |  8 ++------
 arch/x86/hyperv/irqdomain.c | 10 ++++------
 4 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index f022d5f64fb6..c16f81dd36fc 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -115,14 +115,12 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 		return false;
 
 	local_irq_save(flags);
-	ipi_arg = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
+	hv_hvcall_in_array(&ipi_arg, sizeof(*ipi_arg),
+				sizeof(ipi_arg->vp_set.bank_contents[0]));
 	if (unlikely(!ipi_arg))
 		goto ipi_mask_ex_done;
 
 	ipi_arg->vector = vector;
-	ipi_arg->reserved = 0;
-	ipi_arg->vp_set.valid_bank_mask = 0;
 
 	/*
 	 * Use HV_GENERIC_SET_ALL and avoid converting cpumask to VP_SET
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index ddeb40930bc8..c5c9511cb7ed 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -400,13 +400,10 @@ static u8 __init get_vtl(void)
 	u64 ret;
 
 	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
 
-	memset(input, 0, struct_size(input, names, 1));
+	hv_hvcall_inout(&input, sizeof(*input), &output, sizeof(*output));
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->vp_index = HV_VP_INDEX_SELF;
-	input->input_vtl.as_uint8 = 0;
 	input->names[0] = HV_REGISTER_VSM_VP_STATUS;
 
 	ret = hv_do_hypercall(control, input, output);
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 3f4e20d7b724..3dd27d548db6 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -94,8 +94,7 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 
 	local_irq_save(irq_flags);
 
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(input, 0, sizeof(*input));
+	hv_hvcall_in(&input, sizeof(*input));
 
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->vp_index = target_vp_index;
@@ -185,13 +184,10 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
 
 	local_irq_save(irq_flags);
 
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(input, 0, sizeof(*input));
+	hv_hvcall_inout(&input, sizeof(*input), &output, sizeof(*output));
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->apic_ids[0] = apic_id;
 
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
-
 	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
 	status = hv_do_hypercall(control, input, output);
 	ret = output[0];
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 64b921360b0f..803b1a945c5c 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -24,11 +24,11 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
 
 	local_irq_save(flags);
 
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	hv_hvcall_inout_array(&input, sizeof(*input),
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
@@ -77,9 +76,8 @@ static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_entry)
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


