Return-Path: <linux-arch+bounces-11407-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B39EA8A65F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 20:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9420A189EB93
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 18:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ABE22D7A6;
	Tue, 15 Apr 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8NdThnA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC860226CF0;
	Tue, 15 Apr 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740477; cv=none; b=ArPxoOb7hMr76hVGbxEDQ5IY9vOfCQnk4z1vjUJn5m+cu4O5GOPigGLxthrdactR2T6lySv9eDFbHebo8JE233iHDrdYGg3gA+pgbs5AqsyqLZz2qkk0Xq1Z0Nytv2bsJdmqXUU+r70y/pWKiuZVJyFY8hAB5ayCi3qeI9NXMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740477; c=relaxed/simple;
	bh=PVq45EJryN0baNfrDzWcCyc+ciSw5qcADqeFGudXY5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMLSCJHzh/DpnCfPNNGVCDdGqBDueYT5+vMuQ06rYefyk3aQdzbrliOCKryswidyTOkwu4TQjtZ+zmFjQnj1B4CRG+ogfUvyKxzh/EiOzAUhLczRcUme4+/nVEM25XxByOcxpB8/LToAgc7mH0+1Vs5gx4DB7fsirRe81m38RyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8NdThnA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2295d78b433so62135025ad.2;
        Tue, 15 Apr 2025 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740475; x=1745345275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CuTip/h4L4y1gLplPd0zYkyfMFr9unWCWC/uusRHlzs=;
        b=G8NdThnAhSD4iN2aMoPHR8LeSgyXHi55QmZrXb1Q/UPz+xFcaRoQIau+B4o0SWH0Qp
         7MIB/ooT0tvszMOQpe6Y8jI1znNoUDd9KKSMW3W2VmhojpSATv5o7kdZpOVnXf7HZjP0
         UEk+VcoUky/kIRrHd7CBi3m5nA2+FSOHO3cD9PrVcNRgTcfsB8F+mB1g+IvlnjFk8bEA
         tbHLce56R2gNQCO7qf9qx5hHPjqipcm3P2E/yu6sSRxSy5koFGNEEdKqL+ikFGwvDkl6
         bLqCF4m1acb6MV6EzQoY1hv2NuCnuYtiu1Al2zD+TpuzbQCbnUFsI/3/WiBx4Y6wvRH/
         c+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740475; x=1745345275;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CuTip/h4L4y1gLplPd0zYkyfMFr9unWCWC/uusRHlzs=;
        b=L0Xc7oLJqC1JGEJPHnSFzPHncXTXxLEiuVRwp0jjOMPVfW5/jV5o8rxmCLjW3PkAWO
         IZ6K59bmZcRENTwn6Fx45AzXDy8icnlB8uxwwnJ2lBmnVatnX1EqMso2prtoHSmaae5u
         KgJXug7A+RCu+6Or/zDzdAaZ+k0tjHthtNUOd/ZbCVHZgx0hqIloViRLrzc31gHpPmih
         P5dr+oja+1McAqV2usz+dpYF4U1S7sJ59msCB1Q2W5Ya1Weu0O9rLfBk/F5jNDLGxJTZ
         hNgOR5luddF29gAa8zGkEs2jOsDlbbp1G41NwP4F+JHCbjBNrX02wKsUn5B+OmOAucae
         xkWw==
X-Forwarded-Encrypted: i=1; AJvYcCU7YQF6SqknttWG51llgZPdO03XXURDrq70oRyb0LqnQWSV74430oDdX5VG5999Bf+htCVkkS2PTBgz@vger.kernel.org, AJvYcCV3HqeJprtNoirbO157n4jk44D6XABPFs8SzLkF79IIi2dzm87+7CbMcvvY5qSHwQiNIFOWb8bcoxdx+uFe@vger.kernel.org, AJvYcCVPVm/UlV5JAskYrM8l38fTUO1KpH/48N7d619VxjxUkuNM4R8EDfs9wV+gi1CIkm+MLdBtB2oF2lnd@vger.kernel.org, AJvYcCXZahV+HjjKS4RMQLb0kiHFkS4qrp4rFcnB8DqHuWYEbLiudALME8vxtmjbNuHJqbzD2yK90+KR54TLuGDT@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3U9cKlewvca7O5iV7EJmjWSYvFGY/NbrvPerlPJ9lknu9Xqt
	idbXZ5PhFYXIabkNNZBboRFhfrsMukjvYVsXUh2wYyflPeCVMpz1T6q1kg==
X-Gm-Gg: ASbGncsEUIp3Y8kURMLtyrr/qv6ipF82enRhKxIlUbpI3Mm4cS/pDnpCH5dOWLovJxf
	FnXt7KeaQnLDQbb/fxmDy+CWY5nxhxR5/IkZg3n9q7ZktNFy3uf5IjAplggVwhAJcEK5G38hMUl
	ZmsWiNEl9INgpQrzOFL1yztjp3sWQ8CKwZ5E9ksN4r8P3ZRF6nX/TR+ZoYmDsz45XwknBsPMxLg
	KskfivXl7gy8odAPWxz6+mu+J6ulVDDBu969HP+pKJZb70aBV337tNEWFO/RDx+uhMYSBzTcu63
	D2CyhZk5Winwu9nMGwr4FEeeuQvMY0ILQ1oE/b0BToNp6uxlESxWNDR2tWn60dsHqwImJsETaMa
	6iccMoUMk2Ri1+6WuTfo=
X-Google-Smtp-Source: AGHT+IEvXshEYRrrGB61pmgi3piIsJRkMfRvD+Osw+HeayU3VTDAQLzHVkQYYIYV/TTllO2U6s2ehQ==
X-Received: by 2002:a17:903:32d0:b0:215:8809:b3b7 with SMTP id d9443c01a7336-22c318b10d7mr1919555ad.7.1744740475201;
        Tue, 15 Apr 2025 11:07:55 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb52c2sm120168425ad.194.2025.04.15.11.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:07:54 -0700 (PDT)
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
Subject: [PATCH v3 4/7] Drivers: hv: Use hv_hvcall_*() to set up hypercall arguments
Date: Tue, 15 Apr 2025 11:07:25 -0700
Message-Id: <20250415180728.1789-5-mhklinux@outlook.com>
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
fixed portion of input memory, remove now redundant zero'ing of
input fields.

In hv_post_message(), the payload area is treated as an array to
avoid wasting cycles on zero'ing it and then overwriting with
memcpy().

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---

Notes:
    Changes in v3:
    * Removed change to definition of struct hv_input_post_message so the
      'payload' remains a fixed size array. Adjust hv_post_message() so
      that the 'payload' array is not zero'ed. [Nuno Das Neves]
    * Added check of the batch size in hv_free_page_report(). [Nuno Das Neves]
    * In hv_call_deposit_pages(), use the new hv_hvcall_in_batch_size() to
      get the batch size at the start of the function, and check the
      'num_pages' input parameter against that batch size instead of against
      a separately defined constant. Also use the batch size to compute the
      size of the memory allocation. [Nuno Das Neves]

 drivers/hv/hv.c         |  4 +++-
 drivers/hv/hv_balloon.c |  8 ++++----
 drivers/hv/hv_common.c  |  2 +-
 drivers/hv/hv_proc.c    | 23 ++++++++++-------------
 4 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 308c8f279df8..3e7d681ff2b7 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -66,7 +66,9 @@ int hv_post_message(union hv_connection_id connection_id,
 	if (hv_isolation_type_tdx() && ms_hyperv.paravisor_present)
 		aligned_msg = this_cpu_ptr(hv_context.cpu_context)->post_msg_page;
 	else
-		aligned_msg = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		hv_hvcall_in_array(&aligned_msg,
+				   offsetof(typeof(*aligned_msg), payload),
+				   sizeof(aligned_msg->payload[0]));
 
 	aligned_msg->connectionid = connection_id;
 	aligned_msg->reserved = 0;
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 2b4080e51f97..801c03fe10f8 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1577,21 +1577,21 @@ static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
 {
 	unsigned long flags;
 	struct hv_memory_hint *hint;
-	int i, order;
+	int i, order, batch_size;
 	u64 status;
 	struct scatterlist *sg;
 
-	WARN_ON_ONCE(nents > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
 	WARN_ON_ONCE(sgl->length < (HV_HYP_PAGE_SIZE << page_reporting_order));
 	local_irq_save(flags);
-	hint = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	batch_size = hv_hvcall_in_array(&hint, sizeof(*hint), sizeof(hint->ranges[0]));
 	if (!hint) {
 		local_irq_restore(flags);
 		return -ENOSPC;
 	}
+	WARN_ON_ONCE(nents > batch_size);
 
 	hint->heat_type = HV_EXTMEM_HEAT_HINT_COLD_DISCARD;
-	hint->reserved = 0;
 	for_each_sg(sgl, sg, nents, i) {
 		union hv_gpa_page_range *range;
 
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index a7d7494feaca..895448954f37 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -306,7 +306,7 @@ void __init hv_get_partition_id(void)
 	u64 status, pt_id;
 
 	local_irq_save(flags);
-	output = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	hv_hvcall_inout(NULL, 0, &output, sizeof(*output));
 	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output);
 	pt_id = output->partition_id;
 	local_irq_restore(flags);
diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 7d7ecb6f6137..e85d9dd08a9d 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -8,12 +8,6 @@
 #include <linux/minmax.h>
 #include <asm/mshyperv.h>
 
-/*
- * See struct hv_deposit_memory. The first u64 is partition ID, the rest
- * are GPAs.
- */
-#define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
-
 /* Deposits exact number of pages. Must be called with interrupts enabled.  */
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 {
@@ -24,11 +18,13 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	int order;
 	u64 status;
 	int ret;
-	u64 base_pfn;
+	u64 base_pfn, batch_size;
 	struct hv_deposit_memory *input_page;
 	unsigned long flags;
 
-	if (num_pages > HV_DEPOSIT_MAX)
+	batch_size = hv_hvcall_in_batch_size(sizeof(*input_page),
+			   sizeof(input_page->gpa_page_list[0]));
+	if (num_pages > batch_size)
 		return -E2BIG;
 	if (!num_pages)
 		return 0;
@@ -39,7 +35,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 		return -ENOMEM;
 	pages = page_address(page);
 
-	counts = kcalloc(HV_DEPOSIT_MAX, sizeof(int), GFP_KERNEL);
+	counts = kcalloc(batch_size, sizeof(int), GFP_KERNEL);
 	if (!counts) {
 		free_page((unsigned long)pages);
 		return -ENOMEM;
@@ -73,7 +69,9 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 
 	local_irq_save(flags);
 
-	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	/* Batch size is checked at the start of function; no need to repeat */
+	hv_hvcall_in_array(&input_page, sizeof(*input_page),
+			   sizeof(input_page->gpa_page_list[0]));
 
 	input_page->partition_id = partition_id;
 
@@ -125,9 +123,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 	do {
 		local_irq_save(flags);
 
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
 		/* We don't do anything with the output right now */
-		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+		hv_hvcall_inout(&input, sizeof(*input), &output, sizeof(*output));
 
 		input->lp_index = lp_index;
 		input->apic_id = apic_id;
@@ -168,7 +165,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 	do {
 		local_irq_save(irq_flags);
 
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		hv_hvcall_in(&input, sizeof(*input));
 
 		input->partition_id = partition_id;
 		input->vp_index = vp_index;
-- 
2.25.1


