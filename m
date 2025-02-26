Return-Path: <linux-arch+bounces-10390-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252A4A46C04
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 21:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E5016E09F
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 20:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC6C25D522;
	Wed, 26 Feb 2025 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1O6Bxek"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E758625B663;
	Wed, 26 Feb 2025 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600388; cv=none; b=kaV5DfvBcAGfxEYxCogldWA8kr1ELTpfZo+159dAwi+Pw808wFmb6OrUbPRtx6i0PRnYbkPIefrLYAtbzHxgJIfIQHzOYE5gjKux71GHzIFq0+Oa2xPi/iT1TR1EZMiFvH2w0fWHbBYceTNsA/MBFtSk/pfHHe57yF0gD5A+4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600388; c=relaxed/simple;
	bh=UTc/zIxMZzlnepV3eF829gkrOKS/3bcc1+fy1YyKaRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mMIX+L1TjTfNj7q2iYkMJpPEjMLvbKV9c9YfQwwQ8cY8eWQA9+0GLr4Gq+ce1aDwnRyEIk5/JwqzjKFkTAGH1hfqyuRRd5enJJlKBVJG1m+1paSneFJjBUpKuBbaeBfEU898HguhmIlWKIyVaeXHoWunHSHmrDjV3hdcrGDxMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1O6Bxek; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2233622fdffso2546445ad.2;
        Wed, 26 Feb 2025 12:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740600386; x=1741205186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mH64ves2q9+0JDxQKA5wFB9C86aVirya4owjszWIQYM=;
        b=h1O6BxekuYXimLJZs13M1OAW0ptceKxL5Dze3LDXSzkLNBQltpEqoDEzHIZp5gpWR1
         mMRo03gS1zVGjeJWbS7e+PTjKADFU/5NyD+Mi+BrUfYA0pE9CGRrwwAnUfpbJaq9ju+M
         fKQYOwsgZTYoxtFNPYpMqn9KE2gRQMJ14gNpBIledNRF1FS3DIx8UwAZJAE+niJHSj5s
         VyhdfJKskQTY9xwTTuh8hI+C8Dp/XRM99ps8yv7QL7sNdPHxH/dEqEb1ZKm+Il0ki60U
         GnCAcAhHer8/1WljdlKlldgPJ9yj7vQkhG62IHAGx0HnN3VM+L+vi1IGbpAOW1PORST0
         aHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740600386; x=1741205186;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mH64ves2q9+0JDxQKA5wFB9C86aVirya4owjszWIQYM=;
        b=RsUgJmbusO9jcG5bb47dCYZ50jt83JZs3AFZRph95jdYxrO9GimC7vOerYRsAS/ZWX
         Tnpk1TuZGgu5azRiqnyjJocJqta8JYpbLtYC2ZV2mMuScxz3XGa2V4zWy7O+XRKoK6G/
         oIMQ/WmRQgbHafOX3zgRu9s/h9SEyY9X8pK0qEKvBN8p71YcBN1F99iuX7TS7pcxcdn+
         LAuVIn7WIGOyIbJtYLjIyzSjnn875jzefN0CE+GuA5L0MQPKvaxxt0flBZg7zSrFQMEX
         gituhQM1v2Jes22sw+ubLlU7RJ5KB6gtXwqh2qBiE5DVZNOFSehHLO5Y8JbSlQp3SeEc
         Fdmg==
X-Forwarded-Encrypted: i=1; AJvYcCU8RP5TXiGR5Mgk0+Y/LqOaffSHnF1bnH53cAVLT2CFJjpawU88ISVNCuBBOMM75W9tNXvHKSNDMAvn@vger.kernel.org, AJvYcCUAuEi94yMobvarAJPherjqLVjRUjef43gc7FbFc9pyjOwY2RTCXsespQ+mEPrdlEOuIxejWDsmXGzaA4QY@vger.kernel.org, AJvYcCVora5bKRoMuPeM2lvDekyE5vayPbkQ/h5VbJC7fWzfWMkZTIwe37li0otNVz8yBbbufdZ06nkBo7B1u5Rc@vger.kernel.org, AJvYcCW6/oUQ8PFcqQA8Yw9TuiMTjnhUiwp4PvGwvZdyvzTYRLoctzzg7YmHnohgfJNG5fSbzoS9JzDciSuk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ByJ5na7fgieEs4dk+JkM+dwxS2kAnqgNlA0CK+Q3hK0RfLpp
	hw0eutwcR3Chj1uh8Zwty42clv3uJO4kg2hxGmbWn4Yd5BuIapi8qXlV/Q==
X-Gm-Gg: ASbGnctTSDxpr3CFq6fa2gvbcictE4sPq5fpFEyLP4571g7Wg9t/S1m1T+daoEI0t7D
	y2F+mYcmzX6g0qujrpVnL0iGjaYQs4i2R1YL0Vp2t8sD8D8we/DIN6+0TqUFfEtSff+dfvJw1qF
	8UkHMQIiDeA+frK/JU320bfi5x9b4x+7VqYulLZHCnYURof0C8dXbR89rT8OLWiXPCWfOaFsFYs
	6vsjURHRhBbzdhIOaB0xaQLCKlmQAOANUogNBcn/c+kjwVXIi5OsMzYkfozao5DVdKoM6wXyMtp
	M8DmTQ2PaHGEHMgONK06+tNgLRNFDQsuKBmX+ObmdulICnJGCYXxp9bZ+BsxeD6pwXrYEZNyuPz
	252iO
X-Google-Smtp-Source: AGHT+IGzBwtzQDRDAs0JclxfPDV4nz4s+N8wLmnCj+U3UG0rX0BVn//fyDyApXzDXvU2Te59jwDqzQ==
X-Received: by 2002:a05:6a00:929d:b0:730:9752:d02a with SMTP id d2e1a72fcca58-734790a81bcmr14110219b3a.4.1740600386108;
        Wed, 26 Feb 2025 12:06:26 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81bbc7sm3959455b3a.127.2025.02.26.12.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:06:25 -0800 (PST)
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
Subject: [PATCH 5/7] Drivers: hv: Use hv_hvcall_*() to set up hypercall arguments
Date: Wed, 26 Feb 2025 12:06:10 -0800
Message-Id: <20250226200612.2062-6-mhklinux@outlook.com>
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
fixed portion of input memory, remove now redundant zero'ing of
input fields.

hv_post_message() requires additional updates. The payload area is
treated as an array to avoid wasting cycles on zero'ing it and
then overwriting with memcpy(). To allow treatment as an array,
the corresponding payload[] field is updated to have zero size.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv.c           | 8 +++++---
 drivers/hv/hv_balloon.c   | 4 ++--
 drivers/hv/hv_common.c    | 2 +-
 drivers/hv/hv_proc.c      | 8 ++++----
 drivers/hv/hyperv_vmbus.h | 2 +-
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index a38f84548bc2..d98e83b4a6fd 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -66,7 +66,8 @@ int hv_post_message(union hv_connection_id connection_id,
 	if (hv_isolation_type_tdx() && ms_hyperv.paravisor_present)
 		aligned_msg = this_cpu_ptr(hv_context.cpu_context)->post_msg_page;
 	else
-		aligned_msg = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		hv_hvcall_in_array(&aligned_msg, sizeof(*aligned_msg),
+					sizeof(aligned_msg->payload[0]));
 
 	aligned_msg->connectionid = connection_id;
 	aligned_msg->reserved = 0;
@@ -80,8 +81,9 @@ int hv_post_message(union hv_connection_id connection_id,
 						  virt_to_phys(aligned_msg), 0);
 		else if (hv_isolation_type_snp())
 			status = hv_ghcb_hypercall(HVCALL_POST_MESSAGE,
-						   aligned_msg, NULL,
-						   sizeof(*aligned_msg));
+					aligned_msg, NULL,
+					struct_size(aligned_msg, payload,
+					      HV_MESSAGE_PAYLOAD_QWORD_COUNT));
 		else
 			status = HV_STATUS_INVALID_PARAMETER;
 	} else {
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index fec2f18679e3..2def8b8794ee 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1582,14 +1582,14 @@ static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
 	WARN_ON_ONCE(nents > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
 	WARN_ON_ONCE(sgl->length < (HV_HYP_PAGE_SIZE << page_reporting_order));
 	local_irq_save(flags);
-	hint = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	hv_hvcall_in_array(&hint, sizeof(*hint), sizeof(hint->ranges[0]));
 	if (!hint) {
 		local_irq_restore(flags);
 		return -ENOSPC;
 	}
 
 	hint->heat_type = HV_EXTMEM_HEAT_HINT_COLD_DISCARD;
-	hint->reserved = 0;
 	for_each_sg(sgl, sg, nents, i) {
 		union hv_gpa_page_range *range;
 
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 9804adb4cc56..a6b1cdfbc8d4 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -293,7 +293,7 @@ void __init hv_get_partition_id(void)
 	u64 status, pt_id;
 
 	local_irq_save(flags);
-	output = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	hv_hvcall_inout(NULL, 0, &output, sizeof(*output));
 	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, &output);
 	pt_id = output->partition_id;
 	local_irq_restore(flags);
diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 2fae18e4f7d2..d8f3b74d5306 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -73,7 +73,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 
 	local_irq_save(flags);
 
-	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	hv_hvcall_in_array(&input_page, sizeof(*input_page),
+			sizeof(input_page->gpa_page_list[0]));
 
 	input_page->partition_id = partition_id;
 
@@ -124,9 +125,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 	do {
 		local_irq_save(flags);
 
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
 		/* We don't do anything with the output right now */
-		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+		hv_hvcall_inout(&input, sizeof(*input), &output, sizeof(*output));
 
 		input->lp_index = lp_index;
 		input->apic_id = apic_id;
@@ -167,7 +167,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 	do {
 		local_irq_save(irq_flags);
 
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		hv_hvcall_in(&input, sizeof(*input));
 
 		input->partition_id = partition_id;
 		input->vp_index = vp_index;
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 29780f3a7478..44b5e8330d9d 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -101,7 +101,7 @@ struct hv_input_post_message {
 	u32 reserved;
 	u32 message_type;
 	u32 payload_size;
-	u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
+	u64 payload[];
 };
 
 
-- 
2.25.1


