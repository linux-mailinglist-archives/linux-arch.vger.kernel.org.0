Return-Path: <linux-arch+bounces-10389-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA19A46C02
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 21:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FD4169760
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAAB25B693;
	Wed, 26 Feb 2025 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e25AnWkb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED8925A320;
	Wed, 26 Feb 2025 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600387; cv=none; b=Cppogz2aZha5fPECDkZ4L4oeTzggRht/Ua+FiA0MffeCMaHEnEcxkoDlM9Zqjta+VvM0H7kchISFrgNZFZzXLTiAgHg/pJ2unPYpvikyNrFX1mmIzpLhk3/E9DglaCdyFuMe2WbB9Z20vG0ry95oN4AWCkwGFGbXza1YPObQeqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600387; c=relaxed/simple;
	bh=cQHG3g1r38YJDnNG41nqfDZRX+Fhd7xpe66aiwM0lQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MAP5gJlbaZT2978I0pyIHr8B8PZKOVcLQZtb3lwAvj4nSobHIGlut7rjKSM2ZCESnqhMZ6vrmY1FHU6xhLozdfbaB06utM7GG4V2IQsKqqhH59lH9KtaKZguNRggFmwg4yNigbU4erFEChN8esy95lq9zF9+cOsmccB+pWryhhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e25AnWkb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220e989edb6so3562105ad.1;
        Wed, 26 Feb 2025 12:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740600385; x=1741205185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z/vUG3UQf9enQcfjnJw3LUMuFVnqA0Sb2HUdnSE0x+8=;
        b=e25AnWkby1BSSWTvj2KJAesszA7Z2URjJTV+edz6EZfQ3P2TR+BaX2BEqynJ6YrVD9
         GtS2Ny3EQPuSZc2w1bUWVzfP0h3wBd4lJMkdtf/lCL+z9ouBMPNUaW+mrszEMoXMGqM+
         rUzPAAqggxbUIpmBmVXrtsJtdLU/uBhQCUzFVgB90c0dq9AdJNFW1ndVSGKlxZGH7Llg
         Lb2A5s6dsWO6w+R7yjQYYijogwuo68LQMpUhPGc6lAmXHU7MYUMSYw58AC4h02lSc02m
         RIusCP2z6lAYa1I1ft/yzS4mXrTF4Xi3tqKl1RoGOBzUae29P6DxnMbFg4320ZImIf+w
         YVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740600385; x=1741205185;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/vUG3UQf9enQcfjnJw3LUMuFVnqA0Sb2HUdnSE0x+8=;
        b=ukuK7Nm9Xq46T8FKleM2v2LPUVKsSydUauI0Bc+wmiB8w2ukLa6pydroV3sB1eJCSX
         f55Uwrp1TvVKwdHNcDzXL2XxmYBQCeyEY1Aldoz+76WOodBoJ3OKBcKniOkFK+uwEomH
         cmqgjdYw4xxzwEsVdU77cUZmoK9ZlVo4+lYIWV1OTygL5bsu3jdgEU7G5RS5rqGpRVcg
         cAbX9za43Ioj9ALJtpQeUhVyqtwAJ6Ng8q2ja70ztDM4KWBRUadfz81RwLL31pTB09Cr
         GVl+wBt+kfxjBPX4gDuEoVl0DkfqOa79xrwrSGuWFi7OnmxzWA3+Baf5CifU/8/YpHMf
         PYcg==
X-Forwarded-Encrypted: i=1; AJvYcCV3TDt+awxsbLNNMi7kLS1vyFf+5iawUsscNKFbt0zUttu6sfS1/8JxeVZGtVMYjljSNXC78e8oiyGgYXeo@vger.kernel.org, AJvYcCVZXTO3/qh0GPb+ZQo6rWyICBtX2V7SE1yAy4knCWYcpP7MTVGJNin7JoZjs3SpSOljIHdiv8tZSPoW@vger.kernel.org, AJvYcCX+5coVYVBeqdhyfBW8F3A78g9muORPWX9Kmh8E/AOTyhnCkiJAaIW8zEeURkNDu+IDU8Rw+qhtJcEaw8SX@vger.kernel.org, AJvYcCXF4qy42ArLLzJ6+n2D+aQfgxjIG+0BjYdbZ6Rd1eDIrlh71MflGIno/Avt0wsqqQPmaqeRcZkR9veE@vger.kernel.org
X-Gm-Message-State: AOJu0YxiAkNEtp9Tn8D/7cRYS9U28Ads+3kRqkZAawsh8V38fHf30hwH
	Qocp4iBQiGZQINoYIfXC2k1kWJWFTFmSLgP1cpyxGLvY276dWwY6
X-Gm-Gg: ASbGnctrD3M0APRoZgGPkEtaxd0gydIG539htIHRK54xnt8Mpoxgtfqigv2dGgklG4d
	jJzy52ITrHi9GAlauPLeH7tntIAUx+8Wz1ZEWTEIVpWzEYbsO0nqEhtUuKoUmutMBBixtR27Eq1
	vZZXsf0ZUUSy5Uj23kgcaYN/aMb6nPRuh+vbQvCLNSknlwXzNxcELmOd3q/CyTfmxtRJmLBQ52C
	v54Njw5pfpUpthRdn1MKUkPFmuc3unZdDHOJfByzzClpy9PjBiG5NE00nZPdJRF5f9zo3d0+Y+P
	8V8zntTrb6MKEj1P49mT1t/Na9RG4VNH3YvhkpqA9MKYVzmcbj5glgQrtrV233uoaEAtuD26OyZ
	I3Vnx
X-Google-Smtp-Source: AGHT+IHy/rKJWflxjO2CYWjEzwlC1ugGoBV5DueR1VDTIbMe0tXx9+DJ84m4wOXWUhH3FkRLr6BgtA==
X-Received: by 2002:a17:903:1984:b0:223:4b88:77ff with SMTP id d9443c01a7336-2234b887eb6mr6111025ad.6.1740600384997;
        Wed, 26 Feb 2025 12:06:24 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81bbc7sm3959455b3a.127.2025.02.26.12.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:06:24 -0800 (PST)
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
Subject: [PATCH 4/7] x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 2
Date: Wed, 26 Feb 2025 12:06:09 -0800
Message-Id: <20250226200612.2062-5-mhklinux@outlook.com>
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
 arch/x86/hyperv/ivm.c       | 18 +++++++++---------
 arch/x86/hyperv/mmu.c       | 17 +++--------------
 arch/x86/hyperv/nested.c    | 14 +++++---------
 include/hyperv/hvgdk_mini.h |  4 ++--
 4 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index ec7880271cf9..1e4f65aef09b 100644
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
+			batch_size);
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
index 1f7c3082a36d..ab9db23247c1 100644
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
@@ -206,9 +197,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	 * We can flush not more than max_gvas with one hypercall. Flush the
 	 * whole address space if we were asked to do more.
 	 */
-	max_gvas =
-		(PAGE_SIZE - sizeof(*flush) - nr_bank *
-		 sizeof(flush->hv_vp_set.bank_contents[0])) /
+	max_gvas -= (nr_bank * sizeof(flush->hv_vp_set.bank_contents[0])) /
 		sizeof(flush->gva_list[0]);
 
 	if (info->end == TLB_FLUSH_ALL) {
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


