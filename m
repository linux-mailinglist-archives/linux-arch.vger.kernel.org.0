Return-Path: <linux-arch+bounces-11409-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07026A8A667
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 20:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BB1189EA8A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF404232395;
	Tue, 15 Apr 2025 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agbYBgCA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716BF221F34;
	Tue, 15 Apr 2025 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740480; cv=none; b=bQGsyr+zcDyXp0IFgr7PGRgOIpV3TWabRyRxhbKdA1v3h8iR9gsL3fC7xQT6Jr3FS+s4p+aj6p6Z3AaoW6pS/Umg+i/4I7sOxq++L/UVGrpPiHD0BS+3Q+4dtTkInkr7Nz0TtaeTv/fKg2xreC4ytVmIESf3wO16h1rqfe4HrSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740480; c=relaxed/simple;
	bh=9FqId/5/ba8YR+p0th4T7tMaodC+zyLP0BvrxVrZaqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b48kFBKg6Iwoo1FVQHWp4YuPZ5foVDZgsrpee5SgVqoXPBVhWK3msIKO0+iH0OtkacQovto3B4hTomgJWDzXChPzmNcInIIhbelcfzwOt12/zRxyFlSxsvxChHSYnj2MWbHnJTxCzoNHi3BuUerIMJZXOsvA4IR/ggiMXR684Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agbYBgCA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224191d92e4so58035145ad.3;
        Tue, 15 Apr 2025 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740477; x=1745345277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VghwjdcUo8DtpUK2nSJTdR8UnbIpOWOHtRZsZUW425Y=;
        b=agbYBgCA+4iaIYoP3rfy1iJNTNVbcIQE4xlcREwCuQv2oajfKSJSCMOW4QnBvyruNm
         wL499AcRFTP8jrgF3lE+/4jN+u+1zkBMcfH2sopmjxUiANl3vBeW+myzSl6U5iS2IOra
         LU5rgknyTLKCNQwtEBENaOIHXRyXiglTus9cZ3yo5A6FJ7YHMWmE661WC3ecw8DT0VHM
         QhnbSOTvGsaSpIB5uYbs3gJhdUTvtMd965NA730aNDAa6CDCfPnkaBi2ZfoKN8xVUDzQ
         CBvObFYvVsxjjDDLGC3kDcK9TsrWO5evSzThLVbhColzbHVjTrwJ6IvAGWVrUJT2aTPL
         hKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740477; x=1745345277;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VghwjdcUo8DtpUK2nSJTdR8UnbIpOWOHtRZsZUW425Y=;
        b=Aojb2dXicS7R/Skza2jw5oh5NPguUwGLQWFCkM45Pwkv4QmrMiROIkt+dGqNrUglEP
         EWKD09ZWUv6B4UyM8ayXxTt+noxscEeXXRuttyt5Iy2nFtaOrvBbZHNOQmago0XWW8/R
         I+Q8irBWD88ZFLBLmCt83rUpMK0jOgCotpPKwG2j1Yuzspj4KLt/aPfzvst9sSrjVoQF
         gZtdb8PXXHlrPYnK3IjgLoW5PJoKfjmx4JO7cTqYZ1G5L1Eayu1aksgw09Yzi63QWP7y
         oJxzi4xjrz533FIH4U7asgEfDWhQTdbLtX6mtpuhyt80AkiErGYS6RfCkSWfC/g9d8Jv
         ijUw==
X-Forwarded-Encrypted: i=1; AJvYcCU8a5FkhGWNgx3MI5uEAjOvyphN9S216/6rBUgMbXO+V3rJjRgQBb+t/XwI1nX+xIkEsHTeHwhE30y4@vger.kernel.org, AJvYcCVwmxoVFY1q18r8/umLftQqJYkdlWEyAJ+8Ryl3zDiooRyeFyXRuVzPYS7rF/aYX1fUDtg1pYZoXcP/cJfM@vger.kernel.org, AJvYcCX1x+8TyuNaWSl+JRkuaKLX5dgVk1Vno/v1tAD41T/PTbrMnUZy4W4KItpUE9Xu/Qu/Wx06Z9RPw45ZOaOG@vger.kernel.org, AJvYcCXrehmcvPeSZ5H1sWIBWBF5zH/dBrwV0zmEiJ3+oy88OV9t4p8HQb3x3aCy15nccIpnbbv9lLPwNZtn@vger.kernel.org
X-Gm-Message-State: AOJu0YzOsr20XSJLerfbLvPutgGY56cI5VA2JZql5GUmveQrOljPWBzV
	oPXMD3TodfMPwqx5nIZI0DX3VjClhTh1HKKf2LTAWPLVs/ZNZ9or
X-Gm-Gg: ASbGnctg7Et1isBQSLUTtzkNWvHkO1C/1mN/02HihnX580dZDz9gpzzRaFvECtFqNKc
	eiH2jwm436sIH5uDuetbWBAY5mwslXHCBbCzdBsqsVPjAJn9PVAET5IflY6ItU1WbGV6qZ0cHR1
	pHwYZEIavk0xAZupbK0M25ley8MTmeCcMnU0HAA73fPjj8u5XHHZwgDbJoWuOgTJgiTeBFgM94L
	HkIXaCf3J814S9NBB6wL65I0Q+qPDJgyoJkieNcCIlWXAZWloeafIO0rXDtJjyID9ASbryGe+OL
	uenxOiwqXMr3pJjiEXRGHv9XRs4FcWCTyDL7ke/VB7s9bRDMp9v0RIyMGOWnjDekilUJxJZhxn6
	gVxKcbBJFwNthS4trK+thLqVjallJ2Q==
X-Google-Smtp-Source: AGHT+IHiB/GQ8z/6fWgkQGagdEJTT0Owmgec+4AiveHrxLyNipS0r0YnRkLF/BvL25ftslAooeiNJA==
X-Received: by 2002:a17:902:d4c5:b0:224:10b9:357a with SMTP id d9443c01a7336-22c31a7ef34mr1309685ad.32.1744740477592;
        Tue, 15 Apr 2025 11:07:57 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb52c2sm120168425ad.194.2025.04.15.11.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:07:57 -0700 (PDT)
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
Subject: [PATCH v3 6/7] Drivers: hv: Use hv_hvcall_*() to set up hypercall arguments for mshv code
Date: Tue, 15 Apr 2025 11:07:27 -0700
Message-Id: <20250415180728.1789-7-mhklinux@outlook.com>
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
and explicit zero'ing of input fields. Where feasible use batch size
returned by hv_hvcall_inout_array() instead of separate #define value.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---

Notes:
    Changes in v3:
    * This patch is new in v3 due to rebasing on 6.15-rc1, which has new
      mshv-related hypercalls.

 drivers/hv/mshv_common.c       |  31 +++------
 drivers/hv/mshv_root_hv_call.c | 121 +++++++++++++--------------------
 drivers/hv/mshv_root_main.c    |   5 +-
 3 files changed, 60 insertions(+), 97 deletions(-)

diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
index 2575e6d7a71f..2ad36cc7a329 100644
--- a/drivers/hv/mshv_common.c
+++ b/drivers/hv/mshv_common.c
@@ -16,12 +16,6 @@
 
 #include "mshv.h"
 
-#define HV_GET_REGISTER_BATCH_SIZE	\
-	(HV_HYP_PAGE_SIZE / sizeof(union hv_register_value))
-#define HV_SET_REGISTER_BATCH_SIZE	\
-	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_set_vp_registers)) \
-		/ sizeof(struct hv_register_assoc))
-
 int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
 			     union hv_input_vtl input_vtl,
 			     struct hv_register_assoc *registers)
@@ -29,24 +23,23 @@ int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
 	struct hv_input_get_vp_registers *input_page;
 	union hv_register_value *output_page;
 	u16 completed = 0;
-	unsigned long remaining = count;
+	unsigned long batch_size, remaining = count;
 	int rep_count, i;
 	u64 status = HV_STATUS_SUCCESS;
 	unsigned long flags;
 
 	local_irq_save(flags);
 
-	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	batch_size = hv_hvcall_inout_array(&input_page, sizeof(*input_page),
+			      sizeof(input_page->names[0]),
+			      &output_page, 0, sizeof(*output_page));
 
 	input_page->partition_id = partition_id;
 	input_page->vp_index = vp_index;
 	input_page->input_vtl.as_uint8 = input_vtl.as_uint8;
-	input_page->rsvd_z8 = 0;
-	input_page->rsvd_z16 = 0;
 
 	while (remaining) {
-		rep_count = min(remaining, HV_GET_REGISTER_BATCH_SIZE);
+		rep_count = min(remaining, batch_size);
 		for (i = 0; i < rep_count; ++i)
 			input_page->names[i] = registers[i].name;
 
@@ -75,21 +68,19 @@ int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
 	struct hv_input_set_vp_registers *input_page;
 	u16 completed = 0;
 	unsigned long remaining = count;
-	int rep_count;
+	unsigned long rep_count, batch_size;
 	u64 status = HV_STATUS_SUCCESS;
 	unsigned long flags;
 
 	local_irq_save(flags);
-	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
+	batch_size = hv_hvcall_in_array(&input_page, sizeof(*input_page),
+			sizeof(input_page->elements[0]));
 	input_page->partition_id = partition_id;
 	input_page->vp_index = vp_index;
 	input_page->input_vtl.as_uint8 = input_vtl.as_uint8;
-	input_page->rsvd_z8 = 0;
-	input_page->rsvd_z16 = 0;
 
 	while (remaining) {
-		rep_count = min(remaining, HV_SET_REGISTER_BATCH_SIZE);
+		rep_count = min(remaining, batch_size);
 		memcpy(input_page->elements, registers,
 		       sizeof(struct hv_register_assoc) * rep_count);
 
@@ -119,9 +110,7 @@ int hv_call_get_partition_property(u64 partition_id,
 	struct hv_output_get_partition_property *output;
 
 	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
-	memset(input, 0, sizeof(*input));
+	hv_hvcall_inout(&input, sizeof(*input), &output, sizeof(*output));
 	input->partition_id = partition_id;
 	input->property_code = property_code;
 	status = hv_do_hypercall(HVCALL_GET_PARTITION_PROPERTY, input, output);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index a222a16107f6..f14720de3248 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -21,22 +21,6 @@
 #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
 
 #define HV_WITHDRAW_BATCH_SIZE	(HV_HYP_PAGE_SIZE / sizeof(u64))
-#define HV_MAP_GPA_BATCH_SIZE	\
-	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_map_gpa_pages)) \
-		/ sizeof(u64))
-#define HV_GET_VP_STATE_BATCH_SIZE	\
-	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_get_vp_state)) \
-		/ sizeof(u64))
-#define HV_SET_VP_STATE_BATCH_SIZE	\
-	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_set_vp_state)) \
-		/ sizeof(u64))
-#define HV_GET_GPA_ACCESS_STATES_BATCH_SIZE	\
-	((HV_HYP_PAGE_SIZE - sizeof(union hv_gpa_page_access_state)) \
-		/ sizeof(union hv_gpa_page_access_state))
-#define HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT		       \
-	((HV_HYP_PAGE_SIZE -						       \
-	  sizeof(struct hv_input_modify_sparse_spa_page_host_access)) /        \
-	 sizeof(u64))
 
 int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 {
@@ -57,9 +41,7 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 	while (remaining) {
 		local_irq_save(flags);
 
-		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
-		memset(input_page, 0, sizeof(*input_page));
+		hv_hvcall_in(&input_page, sizeof(*input_page));
 		input_page->partition_id = partition_id;
 		status = hv_do_rep_hypercall(HVCALL_WITHDRAW_MEMORY,
 					     min(remaining, HV_WITHDRAW_BATCH_SIZE),
@@ -98,10 +80,7 @@ int hv_call_create_partition(u64 flags,
 
 	do {
 		local_irq_save(irq_flags);
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
-
-		memset(input, 0, sizeof(*input));
+		hv_hvcall_inout(&input, sizeof(*input), &output, sizeof(*output));
 		input->flags = flags;
 		input->compatibility_version = HV_COMPATIBILITY_21_H2;
 
@@ -205,11 +184,12 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 
 	while (done < page_count) {
 		ulong i, completed, remain = page_count - done;
-		int rep_count = min(remain, HV_MAP_GPA_BATCH_SIZE);
+		ulong rep_count, batch_size;
 
 		local_irq_save(irq_flags);
-		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
+		batch_size = hv_hvcall_in_array(&input_page, sizeof(*input_page),
+				   sizeof(input_page->source_gpa_page_list[0]));
+		rep_count = min(remain, batch_size);
 		input_page->target_partition_id = partition_id;
 		input_page->target_gpa_base = gfn + (done << large_shift);
 		input_page->map_flags = flags;
@@ -310,7 +290,7 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
 		int rep_count = min(remain, HV_UMAP_GPA_PAGES);
 
 		local_irq_save(irq_flags);
-		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		hv_hvcall_in(&input_page, sizeof(*input_page));
 
 		input_page->target_partition_id = partition_id;
 		input_page->target_gpa_base = gfn + (done << large_shift);
@@ -339,7 +319,7 @@ int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
 	struct hv_input_get_gpa_pages_access_state *input_page;
 	union hv_gpa_page_access_state *output_page;
 	int completed = 0;
-	unsigned long remaining = count;
+	unsigned long batch_size, remaining = count;
 	int rep_count, i;
 	u64 status = 0;
 	unsigned long flags;
@@ -347,13 +327,13 @@ int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
 	*written_total = 0;
 	while (remaining) {
 		local_irq_save(flags);
-		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
+		batch_size = hv_hvcall_inout_array(&input_page, sizeof(*input_page),
+					0, &output_page, 0, sizeof(*output_page));
 
 		input_page->partition_id = partition_id;
 		input_page->hv_gpa_page_number = gpa_base_pfn + *written_total;
 		input_page->flags = state_flags;
-		rep_count = min(remaining, HV_GET_GPA_ACCESS_STATES_BATCH_SIZE);
+		rep_count = min(remaining, batch_size);
 
 		status = hv_do_rep_hypercall(HVCALL_GET_GPA_PAGES_ACCESS_STATES, rep_count,
 					     0, input_page, output_page);
@@ -383,8 +363,7 @@ int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector,
 	u64 status;
 
 	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(input, 0, sizeof(*input));
+	hv_hvcall_in(&input, sizeof(*input));
 	input->partition_id = partition_id;
 	input->vector = vector;
 	input->dest_addr = dest_addr;
@@ -421,21 +400,21 @@ int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
 	u64 status;
 	int i;
 	u64 control;
-	unsigned long flags;
+	unsigned long flags, batch_size;
 	int ret = 0;
 
-	if (page_count > HV_GET_VP_STATE_BATCH_SIZE)
-		return -EINVAL;
-
 	if (!page_count && !ret_output)
 		return -EINVAL;
 
 	do {
 		local_irq_save(flags);
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
-		memset(input, 0, sizeof(*input));
-		memset(output, 0, sizeof(*output));
+		batch_size = hv_hvcall_inout_array(&input, sizeof(*input),
+				sizeof(input->output_data_pfns[0]),
+				&output, sizeof(*output), 0);
+		if (page_count > batch_size) {
+			local_irq_restore(flags);
+			return -EINVAL;
+		}
 
 		input->partition_id = partition_id;
 		input->vp_index = vp_index;
@@ -477,11 +456,7 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
 	unsigned long flags;
 	int ret = 0;
 	u16 varhead_sz;
-
-	if (page_count > HV_SET_VP_STATE_BATCH_SIZE)
-		return -EINVAL;
-	if (sizeof(*input) + num_bytes > HV_HYP_PAGE_SIZE)
-		return -EINVAL;
+	u64 batch_size;
 
 	if (num_bytes)
 		/* round up to 8 and divide by 8 */
@@ -493,18 +468,26 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
 
 	do {
 		local_irq_save(flags);
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		memset(input, 0, sizeof(*input));
 
-		input->partition_id = partition_id;
-		input->vp_index = vp_index;
-		input->state_data = state_data;
 		if (num_bytes) {
+			batch_size = hv_hvcall_in_array(&input, sizeof(*input),
+						sizeof(input->data[0].bytes));
+			if (num_bytes > batch_size)
+				goto size_error;
+
 			memcpy((u8 *)input->data, bytes, num_bytes);
 		} else {
+			batch_size = hv_hvcall_in_array(&input, sizeof(*input),
+						sizeof(input->data[0].pfns));
+			if (page_count > batch_size)
+				goto size_error;
+
 			for (i = 0; i < page_count; i++)
 				input->data[i].pfns = page_to_pfn(pages[i]);
 		}
+		input->partition_id = partition_id;
+		input->vp_index = vp_index;
+		input->state_data = state_data;
 
 		control = (HVCALL_SET_VP_STATE) |
 			  (varhead_sz << HV_HYPERCALL_VARHEAD_OFFSET);
@@ -523,6 +506,10 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
 	} while (!ret);
 
 	return ret;
+
+size_error:
+	local_irq_restore(flags);
+	return -EINVAL;
 }
 
 int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
@@ -538,8 +525,7 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 	do {
 		local_irq_save(flags);
 
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+		hv_hvcall_inout(&input, sizeof(*input), &output, sizeof(*output));
 
 		input->partition_id = partition_id;
 		input->vp_index = vp_index;
@@ -573,9 +559,7 @@ int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 
 	local_irq_save(flags);
 
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
-	memset(input, 0, sizeof(*input));
+	hv_hvcall_in(&input, sizeof(*input));
 
 	input->partition_id = partition_id;
 	input->vp_index = vp_index;
@@ -613,8 +597,7 @@ hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
 
 	do {
 		local_irq_save(flags);
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		memset(input, 0, sizeof(*input));
+		hv_hvcall_in(&input, sizeof(*input));
 
 		input->port_partition_id = port_partition_id;
 		input->port_id = port_id;
@@ -667,8 +650,7 @@ hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
 
 	do {
 		local_irq_save(flags);
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		memset(input, 0, sizeof(*input));
+		hv_hvcall_in(&input, sizeof(*input));
 		input->port_partition_id = port_partition_id;
 		input->port_id = port_id;
 		input->connection_partition_id = connection_partition_id;
@@ -735,10 +717,7 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
 
 	do {
 		local_irq_save(flags);
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
-
-		memset(input, 0, sizeof(*input));
+		hv_hvcall_inout(&input, sizeof(*input), &output, sizeof(*output));
 		input->type = type;
 		input->identity = *identity;
 
@@ -772,9 +751,7 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type type,
 	u64 status;
 
 	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
-	memset(input, 0, sizeof(*input));
+	hv_hvcall_in(&input, sizeof(*input));
 	input->type = type;
 	input->identity = *identity;
 
@@ -807,14 +784,14 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 	}
 
 	while (done < page_count) {
-		ulong i, completed, remain = page_count - done;
-		int rep_count = min(remain,
-				    HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT);
+		ulong i, batch_size, completed, remain = page_count - done;
+		ulong rep_count;
 
 		local_irq_save(irq_flags);
-		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		batch_size = hv_hvcall_in_array(&input_page, sizeof(*input_page),
+						sizeof(input_page->spa_page_list[0]));
+		rep_count = min(remain, batch_size);
 
-		memset(input_page, 0, sizeof(*input_page));
 		/* Only set the partition id if you are making the pages
 		 * exclusive
 		 */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 72df774e410a..df6b0da4a9a8 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2051,11 +2051,8 @@ static int __init hv_retrieve_scheduler_type(enum hv_scheduler_type *out)
 	u64 status;
 
 	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
 
-	memset(input, 0, sizeof(*input));
-	memset(output, 0, sizeof(*output));
+	hv_hvcall_inout(&input, sizeof(*input), &output, sizeof(*output));
 	input->property_id = HV_SYSTEM_PROPERTY_SCHEDULER_TYPE;
 
 	status = hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
-- 
2.25.1


