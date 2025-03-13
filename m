Return-Path: <linux-arch+bounces-10699-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AC1A5EBA4
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 07:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5ACC189A181
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 06:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4891FC0E2;
	Thu, 13 Mar 2025 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC8FbGx+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833D1FBCBD;
	Thu, 13 Mar 2025 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846772; cv=none; b=fF7xsCH+/F+boa90YFHVIfQj12X8780T3yH2zqOXys/7NHqUqUMdL3JKdQvt2Nvn+2nEzb6CSJXGW0GAf6qVqt8Q6czy2FWVLdPQoHgh2P/aI6CqBsQJURe69POLE5sASVytoBlvYQrs2HhO+jN6X1Sa87XQJk2LiiW/fuXQqt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846772; c=relaxed/simple;
	bh=4jsTUcjJjVFIMH9g9y1/okRRumLPNOpO9g9cC+yb4OU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QtY2p3KioFfgP7FKIrVCSktRFYwhP2WhvElAWUIQZtmz1W5Z2c4tE4pbfRGPy9YszWxXObo3DM4a1+c2lK7HtXyJr2VcTZ0a6m4F4a/3uI3iOCEulsLjSnhu5YykRrpESCigEuQQJBov/U6xKAYmBNZOH0TATUF/qniI5DQC+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BC8FbGx+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-301302a328bso1313701a91.2;
        Wed, 12 Mar 2025 23:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741846769; x=1742451569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vzcvg/Hf2sEphvsPXXpr9HDwxrRjFXsmG/n/jmKN/8M=;
        b=BC8FbGx+dZiJeEsDqQqsBK3F43NEv4o5fTq1QNm/8Otujwt5jCgnMaVp1POrQ8UriY
         ViahSTRkGElW7bz/1Wv97TnPdcUy170aWDgFI/rj6egH4YORWha28fINsbvZqHLAocxi
         5QAizXmR2o07gPuwfwQgH34474P1yj3iM3RAN3YMNxZVKkqggtyezIAGuXyOGi3yvEsU
         04YMINVsatyq69P+GMqXgeNABXTWN9/MuI5b76m+2nCK653ueMk0U8FubqYLF84dpZ5s
         Tvt2B8Y7BazfOvDp6wqXDWWZqfL1SMlxiUsZ6OpmSS4XJXUGQzJUxNaanCMKcCsLXlF2
         V8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741846769; x=1742451569;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vzcvg/Hf2sEphvsPXXpr9HDwxrRjFXsmG/n/jmKN/8M=;
        b=hVfQ7daF3eBgGO+ShRK23aP9pM0PRJ2+Ni+iL5A7EbxiEhySN3BFWJE6T1QVux43gN
         /aipzl7JPP4eX75rqAYk0MOyIzQSFeh0C6W9tmulOOXFA9efEbKbwN0CzzBBVBEAfkkV
         ojjtkUiHjcV9P84OYCX9JyoWpncEXe06ZZhQylVXSs1gCUt7ylZlKfWw5T3iIdGyQkC5
         aYxgRcx7ddaAsb5H2Zo/ijee/GCYsabOSeyIyV3hhFbeBlxbN6+QnC+u95TUEi5rLQJa
         yi6OqFpCwwuMD5JizEyzkEUjyuwyStcyo8cTqM/TYpfxVQvhDdw6gKXwxXjOOz6md+rU
         G9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpCuYpUDfPZXi9kNBgfDkkfzslOakilA3SvsAU+XXJRCZ2Nk1HtiZoutMU1pWKWfh9RTn7gTQH7R5y@vger.kernel.org, AJvYcCVrP5SfNg1XNyPVKyGV7pPhdYGXvVEQ5Y/GVN7/pwmOTEfDflXCiDSY20xA3kyUhvYZYWD1lFeh9tyK@vger.kernel.org, AJvYcCVs1Ob0C82RRj2tsbshGp1tO7mhqzcSD4Yb+vEuc0z/Ait7MpmMH8lx5x4Vss0vLZM8DN2IdsWOEr4xJlK8@vger.kernel.org, AJvYcCW7ETLM/ofFama+cdaDMXg5/ZFfxq+aQVPcJotodx00VZiOFX5eCLfksKDhcaF5Ge9Lb/scEhorho0kkghj@vger.kernel.org
X-Gm-Message-State: AOJu0YytZSV3dMq9W8YVji5gAXJxV5zE+bU5vSTgurT9rG3Aii/dDqRj
	i8aNWKUAtETdFs31GrJ4jc7YQECrJRFZ/xMZjhlxqqUlKeq8rApA
X-Gm-Gg: ASbGncsunEUoth/7HKVq/XVej5ygHoaOUJgC8934Uzea9YdKCogNj0zvTy6hXBUYbK3
	dh0PxtbslgernNuUkx3hBjDqZYbZqxqn73eTED562Y5Gq2vWtEsjxqHpECEDOesF+Uhta8m4dyB
	SEoO9tGMdNQ5FxqEhMw8zJKBShJaJYPmYuNmcGV0ohWujv+iAgn8pQ6CKrar4bLKunMpkeqk720
	pvrU7Iv0IK/cyvqTdYAyWGK5+JIFwUEIrhiq9TMBnrjLKDwsc6at2p+cabd63N8q93V5IvWzswX
	DGC0MG2+/Rp+0AivmEcJZldhdu+lRoqJnFpIc3ll+5shBWRaiBO5bBKk4cOwvluYQcqbZaYlk1k
	bRvL5YbQIIS3vFAwV7OVcbqk=
X-Google-Smtp-Source: AGHT+IHr0vatWAvabq/sI3Lc64UdX6DFlgVugn5vr4pfUctiAylSgqQEAqUI4p/yVlJP0ier3Rfk0A==
X-Received: by 2002:a17:90b:1a86:b0:2ee:53b3:3f1c with SMTP id 98e67ed59e1d1-2ff7ce59755mr33687899a91.5.1741846769393;
        Wed, 12 Mar 2025 23:19:29 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68880dfsm5856985ad.38.2025.03.12.23.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 23:19:29 -0700 (PDT)
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
Subject: [PATCH v2 3/6] x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 2
Date: Wed, 12 Mar 2025 23:19:08 -0700
Message-Id: <20250313061911.2491-4-mhklinux@outlook.com>
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

For hv_mark_gpa_visibility(), use the computed batch_size instead
of HV_MAX_MODIFY_GPA_REP_COUNT. Also update the associated gpa_page_list[]
field to have zero size, which is more consistent with other array
arguments to hypercalls. Due to the interaction with the calling
hv_vtom_set_host_visibility(), HV_MAX_MODIFY_GPA_REP_COUNT cannot be
completely eliminated without some further restructuring, but that's
for another patch set.

Similarly, for the nested flush functions, update the gpa_list[] to
have zero size. Again, separate restructuring would be required to
completely eliminate the need for HV_MAX_FLUSH_REP_COUNT.

Finally, hyperv_flush_tlb_others_ex() requires special handling
because the input consists of two arrays -- one for the hv_vp_set and
another for the gva list. The batch_size computed by hv_hvcall_in_array()
is adjusted to account for the number of entries in the hv_vp_set.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---

Notes:
    Changes in v2:
    * In hyperv_flush_tlb_others_ex(), added check of the adjusted
      max_gvas to make sure it doesn't go to zero or negative, which would
      happen if there is insufficient space to hold the hv_vpset and have
      at least one entry in the gva list. Since an hv_vpset currently
      represents a maximum of 4096 CPUs, the hv_vpset size does not exceed
      512 bytes and there should always be sufficent space. But do the
      check just in case something changes. [Nuno Das Neves]

 arch/x86/hyperv/ivm.c       | 18 +++++++++---------
 arch/x86/hyperv/mmu.c       | 19 +++++--------------
 arch/x86/hyperv/nested.c    | 14 +++++---------
 include/hyperv/hvgdk_mini.h |  4 ++--
 4 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index ec7880271cf9..de983aae0cbe 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -465,30 +465,30 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 {
 	struct hv_gpa_range_for_visibility *input;
 	u64 hv_status;
+	int batch_size;
 	unsigned long flags;
 
 	/* no-op if partition isolation is not enabled */
 	if (!hv_is_isolation_supported())
 		return 0;
 
-	if (count > HV_MAX_MODIFY_GPA_REP_COUNT) {
-		pr_err("Hyper-V: GPA count:%d exceeds supported:%lu\n", count,
-			HV_MAX_MODIFY_GPA_REP_COUNT);
+	local_irq_save(flags);
+	batch_size = hv_hvcall_in_array(&input, sizeof(*input),
+					sizeof(input->gpa_page_list[0]));
+	if (unlikely(!input)) {
+		local_irq_restore(flags);
 		return -EINVAL;
 	}
 
-	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
-	if (unlikely(!input)) {
+	if (count > batch_size) {
+		pr_err("Hyper-V: GPA count:%d exceeds supported:%u\n", count,
+		       batch_size);
 		local_irq_restore(flags);
 		return -EINVAL;
 	}
 
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->host_visibility = visibility;
-	input->reserved0 = 0;
-	input->reserved1 = 0;
 	memcpy((void *)input->gpa_page_list, pfn, count * sizeof(*pfn));
 	hv_status = hv_do_rep_hypercall(
 			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 1f7c3082a36d..7d143826e5dc 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -72,7 +72,7 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 
 	local_irq_save(flags);
 
-	flush = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	max_gvas = hv_hvcall_in_array(&flush, sizeof(*flush), sizeof(flush->gva_list[0]));
 
 	if (unlikely(!flush)) {
 		local_irq_restore(flags);
@@ -86,13 +86,10 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 		 */
 		flush->address_space = virt_to_phys(info->mm->pgd);
 		flush->address_space &= CR3_ADDR_MASK;
-		flush->flags = 0;
 	} else {
-		flush->address_space = 0;
 		flush->flags = HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES;
 	}
 
-	flush->processor_mask = 0;
 	if (cpumask_equal(cpus, cpu_present_mask)) {
 		flush->flags |= HV_FLUSH_ALL_PROCESSORS;
 	} else {
@@ -139,8 +136,6 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 	 * We can flush not more than max_gvas with one hypercall. Flush the
 	 * whole address space if we were asked to do more.
 	 */
-	max_gvas = (PAGE_SIZE - sizeof(*flush)) / sizeof(flush->gva_list[0]);
-
 	if (info->end == TLB_FLUSH_ALL) {
 		flush->flags |= HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY;
 		status = hv_do_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE,
@@ -179,7 +174,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
 		return HV_STATUS_INVALID_PARAMETER;
 
-	flush = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	max_gvas = hv_hvcall_in_array(&flush, sizeof(*flush), sizeof(flush->gva_list[0]));
 
 	if (info->mm) {
 		/*
@@ -188,14 +183,10 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 		 */
 		flush->address_space = virt_to_phys(info->mm->pgd);
 		flush->address_space &= CR3_ADDR_MASK;
-		flush->flags = 0;
 	} else {
-		flush->address_space = 0;
 		flush->flags = HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES;
 	}
 
-	flush->hv_vp_set.valid_bank_mask = 0;
-
 	flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 	nr_bank = cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
 			info->freed_tables ? NULL : cpu_is_lazy);
@@ -206,10 +197,10 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	 * We can flush not more than max_gvas with one hypercall. Flush the
 	 * whole address space if we were asked to do more.
 	 */
-	max_gvas =
-		(PAGE_SIZE - sizeof(*flush) - nr_bank *
-		 sizeof(flush->hv_vp_set.bank_contents[0])) /
+	max_gvas -= (nr_bank * sizeof(flush->hv_vp_set.bank_contents[0])) /
 		sizeof(flush->gva_list[0]);
+	if (max_gvas <= 0)
+		return HV_STATUS_INVALID_PARAMETER;
 
 	if (info->end == TLB_FLUSH_ALL) {
 		flush->flags |= HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY;
diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index 1083dc8646f9..88c39ac8d0aa 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -29,15 +29,13 @@ int hyperv_flush_guest_mapping(u64 as)
 
 	local_irq_save(flags);
 
-	flush = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
+	hv_hvcall_in(&flush, sizeof(*flush));
 	if (unlikely(!flush)) {
 		local_irq_restore(flags);
 		goto fault;
 	}
 
 	flush->address_space = as;
-	flush->flags = 0;
 
 	status = hv_do_hypercall(HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE,
 				 flush, NULL);
@@ -90,25 +88,23 @@ int hyperv_flush_guest_mapping_range(u64 as,
 	u64 status;
 	unsigned long flags;
 	int ret = -ENOTSUPP;
-	int gpa_n = 0;
+	int batch_size, gpa_n = 0;
 
 	if (!hv_hypercall_pg || !fill_flush_list_func)
 		goto fault;
 
 	local_irq_save(flags);
 
-	flush = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
+	batch_size = hv_hvcall_in_array(&flush, sizeof(*flush),
+					sizeof(flush->gpa_list[0]));
 	if (unlikely(!flush)) {
 		local_irq_restore(flags);
 		goto fault;
 	}
 
 	flush->address_space = as;
-	flush->flags = 0;
-
 	gpa_n = fill_flush_list_func(flush, data);
-	if (gpa_n < 0) {
+	if (gpa_n < 0 || gpa_n > batch_size) {
 		local_irq_restore(flags);
 		goto fault;
 	}
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 58895883f636..70e5d7ee40c8 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -533,7 +533,7 @@ union hv_gpa_page_range {
 struct hv_guest_mapping_flush_list {
 	u64 address_space;
 	u64 flags;
-	union hv_gpa_page_range gpa_list[HV_MAX_FLUSH_REP_COUNT];
+	union hv_gpa_page_range gpa_list[];
 };
 
 struct hv_tlb_flush {	 /* HV_INPUT_FLUSH_VIRTUAL_ADDRESS_LIST */
@@ -1218,7 +1218,7 @@ struct hv_gpa_range_for_visibility {
 	u32 host_visibility : 2;
 	u32 reserved0 : 30;
 	u32 reserved1;
-	u64 gpa_page_list[HV_MAX_MODIFY_GPA_REP_COUNT];
+	u64 gpa_page_list[];
 } __packed;
 
 #if defined(CONFIG_X86)
-- 
2.25.1


