Return-Path: <linux-arch+bounces-10700-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDF4A5EBA6
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 07:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B30A3B7633
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 06:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97811FC10E;
	Thu, 13 Mar 2025 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbc/1frz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F21FBEA4;
	Thu, 13 Mar 2025 06:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846772; cv=none; b=msmPyMxwIc005R6Q1VDb9ECFYav246JyFA+bkAT7sC6Cx33Sy8Y0ziwjlpVU8rfL02LHNkZ+YvE7BmGJ6mPujMKkgMW5GEntWPeY59PB6Qcq+7+BjSdfCCucDF9sS7Z5kILCjNslAP7gQuFpqEQ26ND/AWk+qngzhym1nRnVTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846772; c=relaxed/simple;
	bh=BxXwt1RFwOu0MSLelU4BCKZTl9E4XVzmHyRKUsL8J1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxaBL566hcB21/OUVgrkH9f35SgAhJ2UEuVdoeDxOuc0C+6wUmsh2y/bPu/Il2EyHUaGdSGTVDNb5wIiuQ6q43WVCwrYinV8UDH1QPgy1AUgkhsSDV8KJUMbT2o80uuWy4ukZU0HfUocee7GM6MHpkpO2OEq3EQAyNjTc0w9mvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbc/1frz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225b5448519so10446555ad.0;
        Wed, 12 Mar 2025 23:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741846770; x=1742451570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yx8VsN7yGLgKybxAFVxT0ZvluwG4iDYRWCfAUwNv+m0=;
        b=kbc/1frzyjH/6C5Ux9S1I+FOBaYdsw5gpvbjQlQtC4g3cOJUk0qG44F9cOTjD1QOLg
         pipsvDDTo/wHrUSv0HMHkEhv1LwbNZPnkC0dPLT1ktil7AY3wUH3uZ32J3v5DwEzb40J
         WI5uqolkx5jg2Ske8Gvhqp/ioVfHce6Lnix8VYVC8/keTka+LslP1ecU9NC87oomVTuu
         naALlEVJ400UIwz3NM4PodnPWm0ehlAI1m+paqsHKjHBD+FOEAl36zQiOMRYL41nNyDN
         9TtjtTYyp01aQz38AIz+KZyrFYxgT9RN+BGoa00s+O8FyAG6QYEgKYMgFfZGyHRfH7RT
         fMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741846770; x=1742451570;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yx8VsN7yGLgKybxAFVxT0ZvluwG4iDYRWCfAUwNv+m0=;
        b=ZPK1XaViTalm+k9r3f0LKjd3WQyQtNqaR9DT4109lN2q9MWvD1hhoGgknSh0oso9eQ
         y+kWhKH7gJYwlHE5bPfpQaTA/HXDGMCiYkFItGDPW+KFH4lNJa+2ue0Kk+H0HYhsURrD
         nGaDYxdURqsAyRIw2zKDtOknHua/CA2z7j28nF8waNbOXZyvAwDge98Se3Hz9K9WqPHt
         b020Zu4VW+H4Kf4N/KdlUfO4Wu5AtXX6J/f8VP4e3qdL2pETP8Vm4tXGSuIHs38tqs2J
         AWQ6vqH0Meht5U4uh8jj0pxCjX6cEzVCsa3MOfco2RvUJdN62X+OxPVXcL81vkl4YGPZ
         YGtg==
X-Forwarded-Encrypted: i=1; AJvYcCUYU2XPT3zfCVbQv7y9WM8ea7Yin5ZqrwmUMO8O9AZA2Adn+2gm+rNWx2qbn3rKduPJE4/KkZpUQbifmW5r@vger.kernel.org, AJvYcCVWMPYw4fNdTm4R2gImfVSWUkeQUg8Pgs3XDgKB6aT/54sa5bAu3PdalJ12W4+TfTeM5mnlswyroFAkmytp@vger.kernel.org, AJvYcCVbmKNXmy869K3mzCGMbGwBEJe4MUpEw3VRd00rglLb5AVHngGTebuhSch5y/5gv2CDPgnhpJsW295H@vger.kernel.org, AJvYcCVjr+iJEP2zXt8yYkOD8e2UOt+gwkdrMz/Z/X9T089D9UXV6JUg2TeLXcaLVIRnx7u9QO7crtQrHkxn@vger.kernel.org
X-Gm-Message-State: AOJu0YzppZM1OwYDILW68R0VqLRY01mcd2n/BNyMmvwM6+PMizINHBSy
	YHpk0aRYlwzs/FMoRJwtlcufnEtH/5ATC+1xT+VLQhCkyeVZXMmG
X-Gm-Gg: ASbGncubW/E8qBHtAy9oAOzM+Hp9M7HyeiB5aZ3ttvVMdTHB5pVE3G2A4b8LYAfRYVY
	H6VB870pYo5ZHWsb4q2S74YpXiW/3uVzt+nnTUZF/HupGd+1RyJTKtHJYHUuqoJgGWF/POicmS0
	4IjiCoqPPcIe9CdLBoFL1IULYZOWrKKGHFhk2MpqSTotYDJq0wujmBwidV8TXrZEnUrZIKPv15b
	ByRwSR6ojYVcnIY77uOSMVt0Fc2atY05YsHkEuUzQLJX/amNkUaSQNV4/A4c15gzrJ3QbLgxS+w
	pNifeq8aSxNazUF5hOHADM7kbyQED3+NEos3OuVrHoSgJ1n6lOqQC66PwdP0GQg9UgrOhRy5k/M
	KtAIDFz/Ko78JubmnFpLr7jY=
X-Google-Smtp-Source: AGHT+IE6UKl7Uvq210+i03o+UjxWHO2oYjEqA1mXi8pFkQBgjxvNsZpyJC1+UyCmim7KTX72J52OIA==
X-Received: by 2002:a17:903:2405:b0:21b:d2b6:ca7f with SMTP id d9443c01a7336-22428be5c24mr374574255ad.32.1741846770520;
        Wed, 12 Mar 2025 23:19:30 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68880dfsm5856985ad.38.2025.03.12.23.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 23:19:30 -0700 (PDT)
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
Subject: [PATCH v2 4/6] Drivers: hv: Use hv_hvcall_*() to set up hypercall arguments
Date: Wed, 12 Mar 2025 23:19:09 -0700
Message-Id: <20250313061911.2491-5-mhklinux@outlook.com>
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
fixed portion of input memory, remove now redundant zero'ing of
input fields.

hv_post_message() requires additional updates. The payload area is
treated as an array to avoid wasting cycles on zero'ing it and
then overwriting with memcpy(). To allow treatment as an array,
the corresponding payload[] field is updated to have zero size.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv.c           | 9 ++++++---
 drivers/hv/hv_balloon.c   | 4 ++--
 drivers/hv/hv_common.c    | 2 +-
 drivers/hv/hv_proc.c      | 8 ++++----
 drivers/hv/hyperv_vmbus.h | 2 +-
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index a38f84548bc2..e2dcbc816fc5 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -66,7 +66,8 @@ int hv_post_message(union hv_connection_id connection_id,
 	if (hv_isolation_type_tdx() && ms_hyperv.paravisor_present)
 		aligned_msg = this_cpu_ptr(hv_context.cpu_context)->post_msg_page;
 	else
-		aligned_msg = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		hv_hvcall_in_array(&aligned_msg, sizeof(*aligned_msg),
+				   sizeof(aligned_msg->payload[0]));
 
 	aligned_msg->connectionid = connection_id;
 	aligned_msg->reserved = 0;
@@ -80,8 +81,10 @@ int hv_post_message(union hv_connection_id connection_id,
 						  virt_to_phys(aligned_msg), 0);
 		else if (hv_isolation_type_snp())
 			status = hv_ghcb_hypercall(HVCALL_POST_MESSAGE,
-						   aligned_msg, NULL,
-						   sizeof(*aligned_msg));
+						   aligned_msg,
+						   NULL,
+						   struct_size(aligned_msg, payload,
+							       HV_MESSAGE_PAYLOAD_QWORD_COUNT));
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
index 2fae18e4f7d2..5c580ee1c23f 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -73,7 +73,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 
 	local_irq_save(flags);
 
-	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	hv_hvcall_in_array(&input_page, sizeof(*input_page),
+			   sizeof(input_page->gpa_page_list[0]));
 
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


