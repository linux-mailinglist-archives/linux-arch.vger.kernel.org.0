Return-Path: <linux-arch+bounces-12849-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7199DB09AB4
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 06:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054DA3B33FA
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 04:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C761EE7DC;
	Fri, 18 Jul 2025 04:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwgxO+YN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20D1E3772;
	Fri, 18 Jul 2025 04:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814563; cv=none; b=BszfNBZAQUxecsjP7z5mSBoMQWRkYTH27BNk2st9tBtHmj9vLTh5a/AGwjKeO1BzaKzmjMZ1WW9O9IeUQD0hR0HLB/9mCIPxxMKyPkEr7KFWCARRc/5enaKYmOCxExNMkKUKY91qObioCOXV2sFMSOsyTejhiXF6dnYTS1t2KIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814563; c=relaxed/simple;
	bh=57en2IJxk+KdHVqMRBLLkwKBtaix6U/yRmwdbJZuI18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZdpf+fwqo13kH/MTVjNEb+TIJjeCiae6Dhx3SCDQ/5AZxhUzyuFhgwKi+FWc2CmNmuZIbPy2GnzgLxred7S5rTEusKDRobxvzh7GTAsYYbeU80cY42wR0asrz95XtiMpu0b4fbuyc4W/7dwhTy52ke8XgMHq3pFXFzGa324gEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwgxO+YN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3139027b825so1432305a91.0;
        Thu, 17 Jul 2025 21:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752814561; x=1753419361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ag+Imn96kUjagix1W68j1TuvFRsLmLRe1HdtHqE/NkE=;
        b=hwgxO+YNwFbZzcFz46md+yHcR7XsBLMEwXQrzIhwQZQFY2q+QSiY/QH4S1s8348s81
         iRyX0yuWfRbaPcSMUq2ZLQEl4eYj1QMvBIgG9XiVDLRtAjJgLBr9iqWREayzUKni+YY6
         YVZY+OeFcNpYji/sbhSmRAjXzbZPWcphBGAINYCYuoXzSZPmkjgH7zdlIiypM9SDUkTD
         HsPzr9NJTcSvm+B75+WiKlXPGuE90X4SkFaYSuf3YiRKzv0CXzBvoXhtwGH3FmACT33l
         3WNdn0PQOZ5OVSoYPJY1xTZsqTxkxxbxjlS/SWpNT2ywtO9/p7VBR3310aPD+q9gsMfk
         HjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752814561; x=1753419361;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ag+Imn96kUjagix1W68j1TuvFRsLmLRe1HdtHqE/NkE=;
        b=U86BVfm8Dk9OZqx/Ikre3pEO38Kh7vL5AtCga0U+JxA0e/6Z3wCbYOiJ8nJOV6ZyWk
         AwqQxYpUcxNMEBaqCzmXPT/1gsBwSohBhh8NhiNBj5Q5dSLko6z7CU40BLw8LRsH0LHd
         r61XNIdT6CFeeJkDPv19+z8A3FFe61u6JESLs0PfB7x06Hjg8nx61NETvKtkRaSMNofO
         pzKukpZzNM+Cy7flo3x+gShgcwYtoVkMJAt4orGJtjrxz2VaXB412LVleSRlDuDNLhxB
         28dYenGz1xnKHv0rWafgPvuXlvsO+6ZRQnMBGZNV6A1hNhi29GeEyncn0TkQpBLXrgOw
         Zwqw==
X-Forwarded-Encrypted: i=1; AJvYcCUVynyofZY7eHzQ7zFKYIqcQ72CdjUXbIhVu+cRub+d+lELWUo8af3N5cqIlG3pdEmQEcKzz2yfFOeRKVge@vger.kernel.org, AJvYcCW5anThH+293S66ErSg1RN0NLA0B2g4IcKbGl/RM9+IP/YNNiwavW6esSDY8hFmzovbz2hV3nGQIvqd@vger.kernel.org, AJvYcCWuOMmdq7jxzjVQJkGcHdcBRduBBuZQl08O+PzvYskwycKqzpXfJJZAUrH0glV5jvpvbiRVLbODMJAo@vger.kernel.org, AJvYcCXOz4FBu5FvU4876biN0PN/dXJrSZ+W8SrSUJBJ3S5QIsfnSaGj6znqKa1nhzWatEIPWQnTb7EGsqidN9wt@vger.kernel.org
X-Gm-Message-State: AOJu0YyXzp5lfpAvOZNYEWM9tTXhb4QmK++u22sis2xIRARGHEhI0xT9
	jzTC89ZAEIWzghFTnss7BeUJaNnZPbc5eInEJapbJekol187rA3lxhH9
X-Gm-Gg: ASbGncuuHheGnvVQ7Xj9APnXOoRznwt2SyxVVSQY+MXnnmlp0/e1Ge99WHjSvngjzlo
	uNnpQe4C4AvxfkBbw8/Oo7iRkQqBvjSzptA0dBC2/gj+QU/tXsqB1RaESw65NuhdvwSkYk8MkSi
	OPQyi9g4NcbBK2/mw9+4mZmXmnqeGOtQwoJ7yufP7/SuBnYF+ugJKAsnJl5uSSLFQ2ytjWc20fe
	J69Qm6CoT7nu0s+27/ZTDwYtJJId3jSGLrl98WCazkC7JbVcH6cVBdOMc+746FAlvp7OBuNZnZm
	FbGRfi+cWPgHhKHV8RCGkm1QIDGj3W9I0K2ivvd5GYatsJMX6IRUYvChrhZaplakM+dKdtAkvSY
	oj88jrUrvhVY1MDQCt+pu0HIT5vitwEXiGBqVCCnKGFiE8C9k3Jxrnq2RNxPJc1x7gxjvlw6qX/
	Exjg==
X-Google-Smtp-Source: AGHT+IFOkH/8qlGUUajIKL5gtflNPGsfw+mTEWcc1scJHMs/VPU0KwYm/k0splhQ+YRskYo6zlhwqQ==
X-Received: by 2002:a17:90b:1e07:b0:311:9c9a:58d7 with SMTP id 98e67ed59e1d1-31c9f42e8a1mr13006308a91.19.1752814560834;
        Thu, 17 Jul 2025 21:56:00 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc33715b2sm476907a91.24.2025.07.17.21.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 21:56:00 -0700 (PDT)
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
Subject: [PATCH v4 3/7] x86/hyperv: Use hv_setup_*() to set up hypercall arguments -- part 2
Date: Thu, 17 Jul 2025 21:55:41 -0700
Message-Id: <20250718045545.517620-4-mhklinux@outlook.com>
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
another for the gva list. The batch_size computed by hv_setup_in_array()
is adjusted to account for the number of entries in the hv_vp_set.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---

Notes:
    Changes in v4:
    * Rename hv_hvcall_*() functions to hv_setup_*() [Easwar Hariharan]
    * Rename hv_hvcall_in_batch_size() to hv_get_input_batch_size()
      [Easwar Hariharan]
    
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
index ade6c665c97e..3084ae8a3eed 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -474,30 +474,30 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
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
+	batch_size = hv_setup_in_array(&input, sizeof(*input),
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
index cfcb60468b01..f1aeb5bdb29a 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -72,7 +72,7 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 
 	local_irq_save(flags);
 
-	flush = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	max_gvas = hv_setup_in_array(&flush, sizeof(*flush), sizeof(flush->gva_list[0]));
 
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
+	max_gvas = hv_setup_in_array(&flush, sizeof(*flush), sizeof(flush->gva_list[0]));
 
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
@@ -210,10 +201,10 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	 * of flush->hv_vp_set as part of the fixed size input header.
 	 * So the variable input header size is equal to nr_bank.
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
index 8ccbb7c4fc27..8eeda2e2ad29 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -30,15 +30,13 @@ int hyperv_flush_guest_mapping(u64 as)
 
 	local_irq_save(flags);
 
-	flush = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
+	hv_setup_in(&flush, sizeof(*flush));
 	if (unlikely(!flush)) {
 		local_irq_restore(flags);
 		goto fault;
 	}
 
 	flush->address_space = as;
-	flush->flags = 0;
 
 	status = hv_do_hypercall(HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE,
 				 flush, NULL);
@@ -91,25 +89,23 @@ int hyperv_flush_guest_mapping_range(u64 as,
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
+	batch_size = hv_setup_in_array(&flush, sizeof(*flush),
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
index 1be7f6a02304..5590b5fe318c 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -557,7 +557,7 @@ union hv_gpa_page_range {
 struct hv_guest_mapping_flush_list {
 	u64 address_space;
 	u64 flags;
-	union hv_gpa_page_range gpa_list[HV_MAX_FLUSH_REP_COUNT];
+	union hv_gpa_page_range gpa_list[];
 };
 
 struct hv_tlb_flush {	 /* HV_INPUT_FLUSH_VIRTUAL_ADDRESS_LIST */
@@ -1244,7 +1244,7 @@ struct hv_gpa_range_for_visibility {
 	u32 host_visibility : 2;
 	u32 reserved0 : 30;
 	u32 reserved1;
-	u64 gpa_page_list[HV_MAX_MODIFY_GPA_REP_COUNT];
+	u64 gpa_page_list[];
 } __packed;
 
 #if defined(CONFIG_X86)
-- 
2.25.1


