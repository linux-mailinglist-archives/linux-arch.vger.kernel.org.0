Return-Path: <linux-arch+bounces-12852-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5058B09AC2
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 06:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1455A6AFF
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 04:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADD120E718;
	Fri, 18 Jul 2025 04:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dco5QqMh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A51FDA8C;
	Fri, 18 Jul 2025 04:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814567; cv=none; b=bICDGcrrAkNAwVW8i1Az2znfRxlHcliBQ4VufaRUOHS6E8c451+FpSKMa5cH9XP/WJ22CthMmCAjqvAsYC9bq5tiqBoGvn/+2S1jSVkOMHK9dCRitwE7lywM309WieroXbAVhm+W5N0CmqjgXzPV0nVmAeieBdxxRt+l5iwWQ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814567; c=relaxed/simple;
	bh=2FW3b9hlDy2QfBlyM6L0eddthNqwJjvInvNdiM1fCpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C3upSorpd7gn8kRxAUP0ktS62cBKmtva8fwOsG50E+Ki0KasYy79cra18lHVeJOxzPk3A8d7k11K1MK2+SR8Ye7e9PlBsR8gDUaaSk0eUTRnBBT5x5DbUxscbmOq3yVSMjMwyHUW2tSj/o3KYHWvlC5AQCOtvolOFWTsUBoo7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dco5QqMh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23c703c471dso30174575ad.0;
        Thu, 17 Jul 2025 21:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752814565; x=1753419365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=um63o3hQyH8ovYbmWh8CYFrfthG6rWsgdULfDJ9kl7o=;
        b=Dco5QqMhoHOB0e4cuLLqzd7gtqm4PH7OpuCrCFxGcoMEdMbH48kPFcgDvJIvb3ctM9
         GchRl2fYP7GSJiK5WuPA7KpzkteZOCrWwyUipP7yUupp+BJ9NXW0iwH9eCEd2RdinEMM
         myC9KN6y7aMO5DiV9dW/NN0AizrvOQdCT6Odx5OYX1ZPsBhzgdkBnk57NqHLpcJZCL9Y
         uww4c1vR59U21D0dMkTkFnJkfIYlrB4xOwACML7iFA7SgPuH4xg5EMGJ47F6GT4vzh9Q
         bg9sxWh9ISvquyZW/i/lrZIBHjk+IEGhc0nkXWUckNIR0UGwT+lRzW2/lSYg12/HruiW
         fG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752814565; x=1753419365;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=um63o3hQyH8ovYbmWh8CYFrfthG6rWsgdULfDJ9kl7o=;
        b=fZX6sPDJ6VSJAx6RdpwQcFAx1UMnBaCfHxoEvypZcC0hnytp1hlozhn+fl8ZE3Ugfv
         uVxDmhzC1Y0v3o1y3cSqxMCBDWHUKJCOOcRhaNnN0drgAQDz8+WYxOBBpSpYW1ETMc4K
         RnQoYRMYv9Un5bFuKaBaXo8RCG0duec9kqVSCbtUnugBB1/77MJVtzeRwLl2gadMgOUR
         PxBayn9gR0H5khxJuAlpWRbVACAADKaY0qm98jbvD9dOJ7vVYsoyoEdkgL5zU7TYsisf
         jvGvk/v8RZbgwxPAuox1Xdi8VarLILuUrbDIEfODvzCk0XI4tzWswtvRxk6CIoBpEqzj
         zRhw==
X-Forwarded-Encrypted: i=1; AJvYcCUwIQOg5emexfG8TP8QtVe5K5+oBfHJ38ZP0LBct7sXLoCcK+jTjPuWrKttnw29lGxXtbnt8+YDBBWch5/R@vger.kernel.org, AJvYcCVWt0TnJgMJMeanCDMdMDZJmLdqesBe5zvk1XZONDcpy/3zJRz9BZ8zhzzhMh/AqXqsXoEghlDO/fOe@vger.kernel.org, AJvYcCW0USi/cWcWDj7REQfvVSjpoamnARAUUUl2uuTG+ahBGSedG6nZCKHel3PTPXrdytTlIAvv91ul6nNHG5jk@vger.kernel.org, AJvYcCXOyRqX2ncuxHIyfrpYw+WBVLqbVsxPbOLDsIReZ4Lr6Ymk6r6AV59lRqv7lwswoZcB7qgsxnvQdLFU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa1QE7cFZMp0pl52/+drgDXEAtGzmVYmCPc3Q2LBbF0qtU6ar/
	vi+sEevPPjCFve5rnnfsUne2m33vibBB/3ZUp2VvIqOA2XxBpQPeJDpc
X-Gm-Gg: ASbGncuwdUOR8tzgmEl1sgGU0rSgoeoUkUWLYHQh6uHx0l3WcYpaJjdMsMF/OOqx6hc
	HpzW/GEr2ov5wL1dYd4B112nqhce4rOC5r24xQFFgYFFDn1+2ykgDtxUbywQ98Yy6Bm0LaETAFE
	gQG+u17CSxmmCPAesfdeOjN1Sd4v0jJyN2rRQ0IsY6HCtiyWSKWvU545wCacZ2Osu5mLrcuoCMx
	ULQ7lNDHHpDB2kQlzU6zY30BWwdBAZBwNx7OgfzI70SuIQMFbMbSxDWFhn4K4Pvp/ql/84oeDEC
	9/afJfnzUFZdI3Nx4+1gYGxRZecYjaWMfOANW/gFaYH+3/kXv9GYAMwHrtyFGZGVzSsjtZ7m7Kt
	8q8Qmcc8Ol+bIyLa5qf7eGemS/5Th+XxEX38T/XUX42wOlY3DzqWje022tIJnO43jRxnD0VH/OA
	R3fw==
X-Google-Smtp-Source: AGHT+IEv8vxyq+Vqm9GE2JQvjGRhBxcA9Y9DKTDvqZ5aTZDDy0mu7oqw7p73s43/a/E/vIvAkVt9bw==
X-Received: by 2002:a17:902:d4c1:b0:234:595d:a58e with SMTP id d9443c01a7336-23e38fb11efmr35671815ad.25.1752814564606;
        Thu, 17 Jul 2025 21:56:04 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc33715b2sm476907a91.24.2025.07.17.21.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 21:56:04 -0700 (PDT)
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
Subject: [PATCH v4 6/7] Drivers: hv: Use hv_setup_*() to set up hypercall arguments for mshv code
Date: Thu, 17 Jul 2025 21:55:44 -0700
Message-Id: <20250718045545.517620-7-mhklinux@outlook.com>
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
and explicit zero'ing of input fields. Where feasible use batch size
returned by hv_setup_inout_array() instead of separate #define value.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---

Notes:
    Changes in v4:
    * Rename hv_hvcall_*() functions to hv_setup_*() [Easwar Hariharan]
    * Rename hv_hvcall_in_batch_size() to hv_get_input_batch_size()
      [Easwar Hariharan]
    
    Changes in v3:
    * This patch is new in v3 due to rebasing on 6.15-rc1, which has new
      mshv-related hypercalls.

 drivers/hv/mshv_common.c       |  31 +++------
 drivers/hv/mshv_root_hv_call.c | 121 +++++++++++++--------------------
 drivers/hv/mshv_root_main.c    |   5 +-
 3 files changed, 60 insertions(+), 97 deletions(-)

diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
index 6f227a8a5af7..94f8de66c096 100644
--- a/drivers/hv/mshv_common.c
+++ b/drivers/hv/mshv_common.c
@@ -17,12 +17,6 @@
 
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
@@ -30,24 +24,23 @@ int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
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
+	batch_size = hv_setup_inout_array(&input_page, sizeof(*input_page),
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
 
@@ -76,21 +69,19 @@ int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
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
+	batch_size = hv_setup_in_array(&input_page, sizeof(*input_page),
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
 
@@ -120,9 +111,7 @@ int hv_call_get_partition_property(u64 partition_id,
 	struct hv_output_get_partition_property *output;
 
 	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
-	memset(input, 0, sizeof(*input));
+	hv_setup_inout(&input, sizeof(*input), &output, sizeof(*output));
 	input->partition_id = partition_id;
 	input->property_code = property_code;
 	status = hv_do_hypercall(HVCALL_GET_PARTITION_PROPERTY, input, output);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index c9c274f29c3c..7217310b8fc3 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -22,22 +22,6 @@
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
@@ -58,9 +42,7 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 	while (remaining) {
 		local_irq_save(flags);
 
-		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
-		memset(input_page, 0, sizeof(*input_page));
+		hv_setup_in(&input_page, sizeof(*input_page));
 		input_page->partition_id = partition_id;
 		status = hv_do_rep_hypercall(HVCALL_WITHDRAW_MEMORY,
 					     min(remaining, HV_WITHDRAW_BATCH_SIZE),
@@ -99,10 +81,7 @@ int hv_call_create_partition(u64 flags,
 
 	do {
 		local_irq_save(irq_flags);
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
-
-		memset(input, 0, sizeof(*input));
+		hv_setup_inout(&input, sizeof(*input), &output, sizeof(*output));
 		input->flags = flags;
 		input->compatibility_version = HV_COMPATIBILITY_21_H2;
 
@@ -206,11 +185,12 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 
 	while (done < page_count) {
 		ulong i, completed, remain = page_count - done;
-		int rep_count = min(remain, HV_MAP_GPA_BATCH_SIZE);
+		ulong rep_count, batch_size;
 
 		local_irq_save(irq_flags);
-		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
+		batch_size = hv_setup_in_array(&input_page, sizeof(*input_page),
+				   sizeof(input_page->source_gpa_page_list[0]));
+		rep_count = min(remain, batch_size);
 		input_page->target_partition_id = partition_id;
 		input_page->target_gpa_base = gfn + (done << large_shift);
 		input_page->map_flags = flags;
@@ -311,7 +291,7 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
 		int rep_count = min(remain, HV_UMAP_GPA_PAGES);
 
 		local_irq_save(irq_flags);
-		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		hv_setup_in(&input_page, sizeof(*input_page));
 
 		input_page->target_partition_id = partition_id;
 		input_page->target_gpa_base = gfn + (done << large_shift);
@@ -340,7 +320,7 @@ int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
 	struct hv_input_get_gpa_pages_access_state *input_page;
 	union hv_gpa_page_access_state *output_page;
 	int completed = 0;
-	unsigned long remaining = count;
+	unsigned long batch_size, remaining = count;
 	int rep_count, i;
 	u64 status = 0;
 	unsigned long flags;
@@ -348,13 +328,13 @@ int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
 	*written_total = 0;
 	while (remaining) {
 		local_irq_save(flags);
-		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
+		batch_size = hv_setup_inout_array(&input_page, sizeof(*input_page),
+					0, &output_page, 0, sizeof(*output_page));
 
 		input_page->partition_id = partition_id;
 		input_page->hv_gpa_page_number = gpa_base_pfn + *written_total;
 		input_page->flags = state_flags;
-		rep_count = min(remaining, HV_GET_GPA_ACCESS_STATES_BATCH_SIZE);
+		rep_count = min(remaining, batch_size);
 
 		status = hv_do_rep_hypercall(HVCALL_GET_GPA_PAGES_ACCESS_STATES, rep_count,
 					     0, input_page, output_page);
@@ -384,8 +364,7 @@ int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector,
 	u64 status;
 
 	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(input, 0, sizeof(*input));
+	hv_setup_in(&input, sizeof(*input));
 	input->partition_id = partition_id;
 	input->vector = vector;
 	input->dest_addr = dest_addr;
@@ -422,21 +401,21 @@ int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
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
+		batch_size = hv_setup_inout_array(&input, sizeof(*input),
+				sizeof(input->output_data_pfns[0]),
+				&output, sizeof(*output), 0);
+		if (page_count > batch_size) {
+			local_irq_restore(flags);
+			return -EINVAL;
+		}
 
 		input->partition_id = partition_id;
 		input->vp_index = vp_index;
@@ -478,11 +457,7 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
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
@@ -494,18 +469,26 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
 
 	do {
 		local_irq_save(flags);
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		memset(input, 0, sizeof(*input));
 
-		input->partition_id = partition_id;
-		input->vp_index = vp_index;
-		input->state_data = state_data;
 		if (num_bytes) {
+			batch_size = hv_setup_in_array(&input, sizeof(*input),
+						sizeof(input->data[0].bytes));
+			if (num_bytes > batch_size)
+				goto size_error;
+
 			memcpy((u8 *)input->data, bytes, num_bytes);
 		} else {
+			batch_size = hv_setup_in_array(&input, sizeof(*input),
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
@@ -524,6 +507,10 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
 	} while (!ret);
 
 	return ret;
+
+size_error:
+	local_irq_restore(flags);
+	return -EINVAL;
 }
 
 int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
@@ -539,8 +526,7 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 	do {
 		local_irq_save(flags);
 
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+		hv_setup_inout(&input, sizeof(*input), &output, sizeof(*output));
 
 		input->partition_id = partition_id;
 		input->vp_index = vp_index;
@@ -574,9 +560,7 @@ int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 
 	local_irq_save(flags);
 
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
-	memset(input, 0, sizeof(*input));
+	hv_setup_in(&input, sizeof(*input));
 
 	input->partition_id = partition_id;
 	input->vp_index = vp_index;
@@ -614,8 +598,7 @@ hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
 
 	do {
 		local_irq_save(flags);
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		memset(input, 0, sizeof(*input));
+		hv_setup_in(&input, sizeof(*input));
 
 		input->port_partition_id = port_partition_id;
 		input->port_id = port_id;
@@ -668,8 +651,7 @@ hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
 
 	do {
 		local_irq_save(flags);
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		memset(input, 0, sizeof(*input));
+		hv_setup_in(&input, sizeof(*input));
 		input->port_partition_id = port_partition_id;
 		input->port_id = port_id;
 		input->connection_partition_id = connection_partition_id;
@@ -736,10 +718,7 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
 
 	do {
 		local_irq_save(flags);
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
-
-		memset(input, 0, sizeof(*input));
+		hv_setup_inout(&input, sizeof(*input), &output, sizeof(*output));
 		input->type = type;
 		input->identity = *identity;
 
@@ -773,9 +752,7 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type type,
 	u64 status;
 
 	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
-	memset(input, 0, sizeof(*input));
+	hv_setup_in(&input, sizeof(*input));
 	input->type = type;
 	input->identity = *identity;
 
@@ -808,14 +785,14 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 	}
 
 	while (done < page_count) {
-		ulong i, completed, remain = page_count - done;
-		int rep_count = min(remain,
-				    HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT);
+		ulong i, batch_size, completed, remain = page_count - done;
+		ulong rep_count;
 
 		local_irq_save(irq_flags);
-		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		batch_size = hv_setup_in_array(&input_page, sizeof(*input_page),
+						sizeof(input_page->spa_page_list[0]));
+		rep_count = min(remain, batch_size);
 
-		memset(input_page, 0, sizeof(*input_page));
 		/* Only set the partition id if you are making the pages
 		 * exclusive
 		 */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 72df774e410a..aca3331ad516 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2051,11 +2051,8 @@ static int __init hv_retrieve_scheduler_type(enum hv_scheduler_type *out)
 	u64 status;
 
 	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
 
-	memset(input, 0, sizeof(*input));
-	memset(output, 0, sizeof(*output));
+	hv_setup_inout(&input, sizeof(*input), &output, sizeof(*output));
 	input->property_id = HV_SYSTEM_PROPERTY_SCHEDULER_TYPE;
 
 	status = hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
-- 
2.25.1


