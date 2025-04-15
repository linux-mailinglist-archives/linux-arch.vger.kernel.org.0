Return-Path: <linux-arch+bounces-11406-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DC1A8A65B
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 20:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605AC189DC7B
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB222CBC9;
	Tue, 15 Apr 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh2HsTcZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1CD225A3C;
	Tue, 15 Apr 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740477; cv=none; b=YAPTJiKIi6o7Fy86GhW4sg3NWpyHlFJl+Mi9SSGt+F5a/q2N+3lvUvz1NR5+JloyXg74JlYrpUfqs8vBpWQZRviRTi7KD4mNs99sKpm3lUpL69vPVTP8I1ne668B05uk0xl+93MTpoeBTtXg3rR9tmtBXLGl/7u9OKpgr0ChWzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740477; c=relaxed/simple;
	bh=27C8tIHjv58CNuFZk1TDQWetCQU5lgdT5avZ8qfxlHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pps7T08nXyQT7zdwBp8wqNCWIr91a/qtSGieiTfR9QKzRAouNpaAJz7Kkjr1m/T1sReSpTVU5PDoINfnIFZYIInqaIsB8Gcf2ThlxZTUFf+a7+xzIcFk5Q07tbd5R9SGKg8rwMpmPiaewFfYWkMbC0O4Bi6voq1i/nMHHmuyJpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh2HsTcZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225477548e1so57802785ad.0;
        Tue, 15 Apr 2025 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740475; x=1745345275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dJwyxq/vZAtGG9biUw9wns3867DjvVOyohb6sLwPjKc=;
        b=Dh2HsTcZTjmjxD1Y0h8GRQLa8mL8/HoUPGBKk4+5oMW3svoBCFum5I+BEDxw480SsJ
         Veu9rG38soZw7IumX64b1DtG93y6H4eHWITwt6lLyCwohJ4ukd8akB5wg5mnWlNuQHqL
         uOq78o9bmgppP+mAtKho2Zt7rXXemGXib8Oj+xDH6sVjHbk8Dh7xV2JgO5iNzpdMEGqQ
         3TBXzkHs2k9r/ZOajIIYS0umjxxFJqniVwPsf4qOxuLUniaWYzcddCWVTPtPyRSGG/Ar
         S4iXcVzW9eYXFxnBO1e+h2zIN0ucJzPxheGvD5AF/xXx2wVzaN1UwXZJMyAraMpqglTl
         sY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740475; x=1745345275;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJwyxq/vZAtGG9biUw9wns3867DjvVOyohb6sLwPjKc=;
        b=kWg0ITzAvuLkouEMh94luZsP0VF3V2PNZ+iWG0J178EfXWl4ZOP1jIM7maw6WR4fIB
         0nYXzvyH9U37o/Wxd/TRSXFsbhjmtHmIS8M9SEQkzA6XJhEBfo3UiCPkPDWFTEOoC98i
         1ODH7MhE0vXSqb+vTPKEsJ1mQTfX4dgrCs+dlWV5C5E8aRIBZiEJY7aFzBPUmlZqyqve
         DJE7OS5Vh7+3V01ZUalG3yrjMo4vp9HnBWml5cELLw8xsBk6UB0NzkbK06tKFhnR08Is
         oFK8lRuHoWjhOG/76kJNwlJMj9Fn02iCpekUKvBkiKekoQ+4GkFOC9+l5sb+AyUmxcp4
         FdeA==
X-Forwarded-Encrypted: i=1; AJvYcCUNnkv+uH0OLLBVAvkwdneiAcBK5QMeI4g1DxttBU0x360txBK+Ht3to0efT/bWjzoV2T4BNGsRPKm0@vger.kernel.org, AJvYcCV2Bx2T4JiC5lD7W/mMioqbUgpVP0ScqahkD6qc9nQfkujhhQJN6NCcv5CXUQviZ4jpPs/vVitMxvpr6W2A@vger.kernel.org, AJvYcCWDGMB/MrWre2CEsOhocjVf9LZcfMfApTelKGDZG6o1ZoBTtFKArRyxZXF7Qt6M9z2BAL5rauxRWja1Jt+r@vger.kernel.org, AJvYcCWOwSzD3GqeKZNTEiSu9N4zQeiI2V5WYcXAtKUI5irsYKIjAxxsziBhCcZT0xR9P+aPYiWZXdXsZoHo@vger.kernel.org
X-Gm-Message-State: AOJu0YwTHwQn42lW/x5jOx/D1LqdRscpRGXmxEeW71loV0TE2tBz4qT7
	ix3KWSEWWKCmo7rtqzmqwJI9Igdd63MWN9SWuQVUJ4n3T8SuC7ie
X-Gm-Gg: ASbGncst1BIK6/oAQFFODnhttm5MP7LFKrtSA5mO8TU++zro0aWtlj19ewN3xzfHtCM
	o29zBlyWGJtcYHxxKvMAMN93bKuthuFkhYs2J5DkCPH/HIGQUv81IgpO0+V6huSLhaCqVudx6Vs
	epZr5B8YOfX+JWCqDo9cNgBoMignG4wV+r11B9LLpxapk4jNUItOxzk4w+vlVjdZc8hDcFReaUf
	wzmp+eougWGOkoO6qCn0/sQudbVBciUG0f85XHUqo252yquicPSrpsdfpnEB88UamJvfG8O6WC1
	+6aBU80U6y3il8hmPjv9ANw0ujv8+roueUtCQrS4NrEgbfRhg47eFQnc+PqIO7tfPTOkF3F7QRP
	BUgiZh76lnVMh9hW5bUY=
X-Google-Smtp-Source: AGHT+IECvG4G9aa8G/Hhe+MiLgkTyvPU3uYXFSQvxk3QVybJ2VjR5VHrJiiEh794Fnmo1x7RdwU4jA==
X-Received: by 2002:a17:903:228e:b0:223:66a1:4503 with SMTP id d9443c01a7336-22c31a6e008mr1477975ad.30.1744740474016;
        Tue, 15 Apr 2025 11:07:54 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb52c2sm120168425ad.194.2025.04.15.11.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:07:53 -0700 (PDT)
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
Subject: [PATCH v3 3/7] x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 2
Date: Tue, 15 Apr 2025 11:07:24 -0700
Message-Id: <20250415180728.1789-4-mhklinux@outlook.com>
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
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
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
index 77bf05f06b9e..f99b7f4482d3 100644
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
index cfcb60468b01..7eaa34ce2f5f 100644
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
index abf0bd76e370..5a89120ba1a6 100644
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


