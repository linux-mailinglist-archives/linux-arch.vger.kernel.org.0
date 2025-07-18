Return-Path: <linux-arch+bounces-12850-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD45B09ABA
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 06:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5613A6251
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 04:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AF41F76A8;
	Fri, 18 Jul 2025 04:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUGAmlOA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22F1E98FB;
	Fri, 18 Jul 2025 04:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814564; cv=none; b=CGbMEFxDJMtMZ3aN1D1nRuJ4VKeCI8bwvGoB4C8nxORHkEw1YAh9Eorba5DUegWQCxr1mTUgXvXE/730pIoBumF9ovmUSvebO2dgwctAGiEXtBfXpvtqe01ZEnr0zPTNKTqjOoKl71sGDy2SIcuegX6pstmvFRqVANBiMaZXjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814564; c=relaxed/simple;
	bh=OGH6Bpc/OE9X847x/L6VlIAm+mIYXNXdMu5o6YkG6RY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/+htlCXP/exsNYkR3rtcb6tOnAZ3JxxVcjytisbyLUz5F01Vty0/n1YTVQtqMLgCdyA+FHeX17BsenxPVMPBNKLPLhwxszTEGyegIPkqm5Jl6NpDR16rD5ikR42RodxPvxhE7Ue4hP24DAqZm2VYALaiLfY+9xrPbGG4lh0ukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUGAmlOA; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31329098ae8so1528764a91.1;
        Thu, 17 Jul 2025 21:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752814562; x=1753419362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z4YwSGg1tUe7fu/pS83WCt5l9SC+9AOdn2iyI4phc/4=;
        b=EUGAmlOAtzRwsa0E3CJxiyNSIZ4CirbH+jBiDzwNDbLje7REE8oFuPHfHD/qCPP20f
         f5s9rJ6xdRTJT5mOlWB8qJDE7eMSEU7D5Rh+OqRRTB5aJsQxQEtFHSSeaxpcesfRkz1l
         dOMlmjmvG+rvDE4FBwjJF+2odrCRFG7/E59x/3PTZxcduCEOUWzzFqyCOIlQefsVTiaI
         f23YwzO2EWyeX0bnjjDPL8WyyX2DttYAn9g7LK48buz7wJMgraWUXVwv0PPRUVDiUqR0
         tp8Jw0zD/NkPmWDCoceTE1avQk9hX4NWXQ568MzwH6+/S0OYN2PCJ1Z/Y9m+j9Zp5J4Z
         e2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752814562; x=1753419362;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4YwSGg1tUe7fu/pS83WCt5l9SC+9AOdn2iyI4phc/4=;
        b=oSjJcJQVRpLGP4Im0fGLw5NSYGuDZFUEIEUMsxqXe+eyFfDjmAk6uGkV9ALXMnmz2N
         JkeYtaOnb42wfPsRUgRDsiZBhzcvrxI2hFB7iQkGnG7OGM6vFLPkqXjJFXwT0aDDCDUs
         mjC3y6PC0nWi9Ryglh63tjjrJhVjSjBxkQJSylPvt3LEFaAynVAnFwyLW0zDDXh6/JxA
         oFDfwf/vIST3pXzAg2IiOEa3j4+vIxZTV9VfZ+h+Pwtp8Mq33Bd4R6Of+a6xSvOFME0b
         Wn2yRoPZKAZZVz2Wr3iagsXsF96zdeDIUvbQNs52dOnhWYtv69208dr0kXviSQUkaqza
         ThTw==
X-Forwarded-Encrypted: i=1; AJvYcCWMRwp0U1TiZS7ySEF4JJtuP2QEZulbay9TadBTkz0yTZMPm7ZAtUYyraJ2nkZo0EQzEVA30A+AaORA0B37@vger.kernel.org, AJvYcCWOpyk5x/4T4o/PqZjo3+mj7B3p4+nAGiJGRTqthwXdOSnB+KNggq7Q4jobewFCubMAam7B0x6qR3oq@vger.kernel.org, AJvYcCXH3l2C2aiam/4I4jWW+9aPC+bbAPPHuTeu7Bg2dj0Te5adxWohhaSQMw+i6trwHzNulKNUaf4DzvOtvYmL@vger.kernel.org, AJvYcCXSqRLqOK/iXbWH5yfJoP+wVhk19k4CZ/eSaCwk4U1EEZA1+GgYamFCCSA+JbXUnURo4aTj2o3zbqRc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2U/66nAARhwyOluCdiBuyQ022rd/IlSD95OgBi+brjXUKaNTZ
	MwB/N865Qeep9m9HH4nPcf2/gSYcpKEIi2q4hOL38WvSrlXMSwlItE2y
X-Gm-Gg: ASbGncts7xVae50BD8HQaSI2NKIFNjOtFQ5flO+MIjwZb0wOfoEkXlds3Y2pdbgIpvu
	nanWl6XWl1stLMt3j3krFSBLASdJaeWwFFDmR9ZV/a76pr1hvL3UEL9p3GJrcdHhdycybjXZPSu
	iPx1yR6XznzL70BBQF5UTwNbPSgIFKyPTE7p8jbKt7uoNPZq23uHQ3SWFDrDZ/ypdxt9zwt0iBh
	0f0lF3ipdecHnvWHbyoTQDwXVtrnt1vB3Ts9RSnXIU4oWgAy5Bb/GJj9jqka48FqiN1Ts5kz4Lj
	A2SEtm0Zz1adIeWU3jvUt2ZyUj5LNbJogImBWPQhmetEtvqb4j8COcImkQvkigEienpcN0vduO5
	PzaM+S4CkTh5mf7KdzyFuFgkvQYVWlxdULT9B0f+vaJH6Ffk5q7WwyWKgd1Khld6IGIOKqUd3zG
	BHzQ==
X-Google-Smtp-Source: AGHT+IEMhEWEmZEPqhGpJ6GpUMjFMgAHKc3+3eXHQhJ1faHyqk1AKFMu1lSvB5lOekVZAimbBZUNBA==
X-Received: by 2002:a17:90b:3d8a:b0:312:e73e:cded with SMTP id 98e67ed59e1d1-31cc045b2dcmr3314232a91.16.1752814562083;
        Thu, 17 Jul 2025 21:56:02 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc33715b2sm476907a91.24.2025.07.17.21.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 21:56:01 -0700 (PDT)
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
Subject: [PATCH v4 4/7] Drivers: hv: Use hv_setup_*() to set up hypercall arguments
Date: Thu, 17 Jul 2025 21:55:42 -0700
Message-Id: <20250718045545.517620-5-mhklinux@outlook.com>
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
fixed portion of input memory, remove now redundant zero'ing of
input fields.

In hv_post_message(), the payload area is treated as an array to
avoid wasting cycles on zero'ing it and then overwriting with
memcpy().

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---

Notes:
    Changes in v4:
    * Rename hv_hvcall_*() functions to hv_setup_*() [Easwar Hariharan]
    * Rename hv_hvcall_in_batch_size() to hv_get_input_batch_size()
      [Easwar Hariharan]
    
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
 drivers/hv/hv_common.c  |  9 +++------
 drivers/hv/hv_proc.c    | 23 ++++++++++-------------
 4 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index b14c5f9e0ef2..ad063f535f95 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -66,7 +66,9 @@ int hv_post_message(union hv_connection_id connection_id,
 	if (hv_isolation_type_tdx() && ms_hyperv.paravisor_present)
 		aligned_msg = this_cpu_ptr(hv_context.cpu_context)->post_msg_page;
 	else
-		aligned_msg = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		hv_setup_in_array(&aligned_msg,
+				   offsetof(typeof(*aligned_msg), payload),
+				   sizeof(aligned_msg->payload[0]));
 
 	aligned_msg->connectionid = connection_id;
 	aligned_msg->reserved = 0;
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 2b4080e51f97..d9b569b204d2 100644
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
+	batch_size = hv_setup_in_array(&hint, sizeof(*hint), sizeof(hint->ranges[0]));
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
index 49898d10faff..ae56397af1ed 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -267,7 +267,7 @@ void __init hv_get_partition_id(void)
 	u64 status, pt_id;
 
 	local_irq_save(flags);
-	output = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	hv_setup_inout(NULL, 0, &output, sizeof(*output));
 	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output);
 	pt_id = output->partition_id;
 	local_irq_restore(flags);
@@ -288,13 +288,10 @@ u8 __init get_vtl(void)
 	u64 ret;
 
 	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
-
-	memset(input, 0, struct_size(input, names, 1));
+	hv_setup_inout_array(&input, sizeof(*input), sizeof(input->names[0]),
+			     &output, sizeof(*output), sizeof(output->values[0]));
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->vp_index = HV_VP_INDEX_SELF;
-	input->input_vtl.as_uint8 = 0;
 	input->names[0] = HV_REGISTER_VSM_VP_STATUS;
 
 	ret = hv_do_hypercall(control, input, output);
diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index fbb4eb3901bb..bd63830b4141 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -9,12 +9,6 @@
 #include <linux/export.h>
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
@@ -25,11 +19,13 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	int order;
 	u64 status;
 	int ret;
-	u64 base_pfn;
+	u64 base_pfn, batch_size;
 	struct hv_deposit_memory *input_page;
 	unsigned long flags;
 
-	if (num_pages > HV_DEPOSIT_MAX)
+	batch_size = hv_get_input_batch_size(sizeof(*input_page),
+			   sizeof(input_page->gpa_page_list[0]));
+	if (num_pages > batch_size)
 		return -E2BIG;
 	if (!num_pages)
 		return 0;
@@ -40,7 +36,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 		return -ENOMEM;
 	pages = page_address(page);
 
-	counts = kcalloc(HV_DEPOSIT_MAX, sizeof(int), GFP_KERNEL);
+	counts = kcalloc(batch_size, sizeof(int), GFP_KERNEL);
 	if (!counts) {
 		free_page((unsigned long)pages);
 		return -ENOMEM;
@@ -74,7 +70,9 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 
 	local_irq_save(flags);
 
-	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	/* Batch size is checked at the start of function; no need to repeat */
+	hv_setup_in_array(&input_page, sizeof(*input_page),
+			   sizeof(input_page->gpa_page_list[0]));
 
 	input_page->partition_id = partition_id;
 
@@ -126,9 +124,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 	do {
 		local_irq_save(flags);
 
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
 		/* We don't do anything with the output right now */
-		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+		hv_setup_inout(&input, sizeof(*input), &output, sizeof(*output));
 
 		input->lp_index = lp_index;
 		input->apic_id = apic_id;
@@ -169,7 +166,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 	do {
 		local_irq_save(irq_flags);
 
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		hv_setup_in(&input, sizeof(*input));
 
 		input->partition_id = partition_id;
 		input->vp_index = vp_index;
-- 
2.25.1


