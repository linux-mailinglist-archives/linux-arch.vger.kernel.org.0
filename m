Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8253C46C724
	for <lists+linux-arch@lfdr.de>; Tue,  7 Dec 2021 23:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbhLGWNM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Dec 2021 17:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242083AbhLGWNL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Dec 2021 17:13:11 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0DFC061574
        for <linux-arch@vger.kernel.org>; Tue,  7 Dec 2021 14:09:40 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id bf17-20020a17090b0b1100b001a634dbd737so2408507pjb.9
        for <linux-arch@vger.kernel.org>; Tue, 07 Dec 2021 14:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=1Pi0Ww/JDIArn3W1wYIgf5uHdNRhgt/S+n01tuDsyPY=;
        b=In97WE9WgaNvkpZysnT9Qgdnh2/B+KLWTCwnqJgfRC327/Y/UoG6U9G406ELCz3fk1
         mRYXKQG45yQWbKrftJSWQu5ETw8oZYs+uYmb8VMmN/9yBMDhFn06g/vVjZgSSd0JVd2O
         cGhLHYM6x0UiBBbDvfxwxzAfeZF32lLSRWe8TRArTdC9zKIuV77Qp85kRzlVLz9Z0o5a
         NfVza0zDXVT6g8ZC4Rohyh5YSZgyZx8fQuZ09hCeL6TTjN0b3y5PonDGIC/9xH/Apjlx
         FqkA9/GVOrLqUhB3nZ1+1LMXntfjBEG1CQzxsC4y6YWiSiPlI51a+0aFXYe52vmTIemS
         jVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=1Pi0Ww/JDIArn3W1wYIgf5uHdNRhgt/S+n01tuDsyPY=;
        b=V5b09GeF9HgZU7/LM/4rhvNTPeP7EWNPiPoQK2ZXfyl5GEpyOtU4F9U3iMG5N3gzUF
         EzNVdG7LkGoVaRbfZTFPGCn+Gz4XuGUVYi6/pD347MBOG+rIvnTXtAujw6BGV4Gtd1da
         R7EFHKHFQloScyfcu58YKfEsOU64DJGtxqDoNudk2Drm2tLxh/C51S7ws/MGfvfghU7C
         7BLd1UpqFrFbJcBwri+h74XfnXRPobwdqvF2l9xDUJRM/v/qS9taxIcqN6vx4XPRrStm
         BIOFV/Z68Tc/48I3c2FJzwuB2Z/wKMylI3Sbt0KTGQKJa0Rd0yUfmMTAr1eGvEr7SIue
         GxEg==
X-Gm-Message-State: AOAM532UuVItyP4iQ5j3G0n2y6WWmjnleFzLOx7ydNm+qE8vl2YxQ3Xv
        djQ4INV4QdcxXvKYHFUcnXWKbyp7kCE=
X-Google-Smtp-Source: ABdhPJwwKH83RAYt72XhKQ51Rk4S5hWbF9Q+wrhefy4f3/Zlt51wU6QsmnOekFuPmEfedJyZFdthXPQEjNs=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4cf:b0:141:d36c:78f6 with SMTP id
 o15-20020a170902d4cf00b00141d36c78f6mr54742141plg.56.1638914979820; Tue, 07
 Dec 2021 14:09:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Dec 2021 22:09:20 +0000
In-Reply-To: <20211207220926.718794-1-seanjc@google.com>
Message-Id: <20211207220926.718794-3-seanjc@google.com>
Mime-Version: 1.0
References: <20211207220926.718794-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 2/8] KVM: x86: Get the number of Hyper-V sparse banks from
 the VARHEAD field
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Get the number of sparse banks from the VARHEAD field, which the guest is
required to provide as "The size of a variable header, in QWORDS.", where
the variable header is:

  Variable Header Bytes = {Total Header Bytes - sizeof(Fixed Header)}
                          rounded up to nearest multiple of 8
  Variable HeaderSize = Variable Header Bytes / 8

In other words, the VARHEAD should match the number of sparse banks.
Keep the manual count as a sanity check, but otherwise rely on the field
so as to more closely align with the logic defined in the TLFS and to
allow for future cleanups.

Tweak the tracepoint output to use "rep_cnt" instead of simply "cnt" now
that there is also "var_cnt".

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c             | 35 ++++++++++++++++++-------------
 arch/x86/kvm/trace.h              | 14 +++++++------
 include/asm-generic/hyperv-tlfs.h |  1 +
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 58f35498578f..d8a7b63f676f 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1743,6 +1743,7 @@ struct kvm_hv_hcall {
 	u64 ingpa;
 	u64 outgpa;
 	u16 code;
+	u16 var_cnt;
 	u16 rep_cnt;
 	u16 rep_idx;
 	bool fast;
@@ -1762,7 +1763,6 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 	unsigned long *vcpu_mask;
 	u64 valid_bank_mask;
 	u64 sparse_banks[64];
-	int sparse_banks_len;
 	bool all_cpus;
 
 	if (!ex) {
@@ -1812,24 +1812,28 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 		all_cpus = flush_ex.hv_vp_set.format !=
 			HV_GENERIC_SET_SPARSE_4K;
 
-		sparse_banks_len = bitmap_weight((unsigned long *)&valid_bank_mask, 64);
+		if (hc->var_cnt != bitmap_weight((unsigned long *)&valid_bank_mask, 64))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 
-		if (!sparse_banks_len && !all_cpus)
+		if (!hc->var_cnt && !all_cpus)
 			goto ret_success;
 
 		if (!all_cpus) {
 			if (hc->fast) {
-				if (sparse_banks_len > HV_HYPERCALL_MAX_XMM_REGISTERS - 1)
+				if (hc->var_cnt > HV_HYPERCALL_MAX_XMM_REGISTERS - 1)
 					return HV_STATUS_INVALID_HYPERCALL_INPUT;
-				for (i = 0; i < sparse_banks_len; i += 2) {
+				for (i = 0; i < hc->var_cnt; i += 2) {
 					sparse_banks[i] = sse128_lo(hc->xmm[i / 2 + 1]);
 					sparse_banks[i + 1] = sse128_hi(hc->xmm[i / 2 + 1]);
 				}
 			} else {
+				if (hc->var_cnt > 64)
+					return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
 				gpa = hc->ingpa + offsetof(struct hv_tlb_flush_ex,
 							   hv_vp_set.bank_contents);
 				if (unlikely(kvm_read_guest(kvm, gpa, sparse_banks,
-							    sparse_banks_len *
+							    hc->var_cnt *
 							    sizeof(sparse_banks[0]))))
 					return HV_STATUS_INVALID_HYPERCALL_INPUT;
 			}
@@ -1885,7 +1889,6 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 	unsigned long *vcpu_mask;
 	unsigned long valid_bank_mask;
 	u64 sparse_banks[64];
-	int sparse_banks_len;
 	u32 vector;
 	bool all_cpus;
 
@@ -1918,22 +1921,25 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 
 		vector = send_ipi_ex.vector;
 		valid_bank_mask = send_ipi_ex.vp_set.valid_bank_mask;
-		sparse_banks_len = bitmap_weight(&valid_bank_mask, 64) *
-			sizeof(sparse_banks[0]);
-
 		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
 
+		if (hc->var_cnt != bitmap_weight(&valid_bank_mask, 64))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
 		if (all_cpus)
 			goto check_and_send_ipi;
 
-		if (!sparse_banks_len)
+		if (!hc->var_cnt)
 			goto ret_success;
 
+		if (hc->var_cnt > 64)
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
 		if (kvm_read_guest(kvm,
 				   hc->ingpa + offsetof(struct hv_send_ipi_ex,
 							vp_set.bank_contents),
 				   sparse_banks,
-				   sparse_banks_len))
+				   hc->var_cnt * sizeof(sparse_banks[0])))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
 
@@ -2191,13 +2197,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	}
 
 	hc.code = hc.param & 0xffff;
+	hc.var_cnt = (hc.param & HV_HYPERCALL_VARHEAD_MASK) >> HV_HYPERCALL_VARHEAD_OFFSET;
 	hc.fast = !!(hc.param & HV_HYPERCALL_FAST_BIT);
 	hc.rep_cnt = (hc.param >> HV_HYPERCALL_REP_COMP_OFFSET) & 0xfff;
 	hc.rep_idx = (hc.param >> HV_HYPERCALL_REP_START_OFFSET) & 0xfff;
 	hc.rep = !!(hc.rep_cnt || hc.rep_idx);
 
-	trace_kvm_hv_hypercall(hc.code, hc.fast, hc.rep_cnt, hc.rep_idx,
-			       hc.ingpa, hc.outgpa);
+	trace_kvm_hv_hypercall(hc.code, hc.fast, hc.var_cnt, hc.rep_cnt,
+			       hc.rep_idx, hc.ingpa, hc.outgpa);
 
 	if (unlikely(!hv_check_hypercall_access(hv_vcpu, hc.code))) {
 		ret = HV_STATUS_ACCESS_DENIED;
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 953b0fcb21ee..e3d109515376 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -64,9 +64,9 @@ TRACE_EVENT(kvm_hypercall,
  * Tracepoint for hypercall.
  */
 TRACE_EVENT(kvm_hv_hypercall,
-	TP_PROTO(__u16 code, bool fast, __u16 rep_cnt, __u16 rep_idx,
-		 __u64 ingpa, __u64 outgpa),
-	TP_ARGS(code, fast, rep_cnt, rep_idx, ingpa, outgpa),
+	TP_PROTO(__u16 code, bool fast,  __u16 var_cnt, __u16 rep_cnt,
+		 __u16 rep_idx, __u64 ingpa, __u64 outgpa),
+	TP_ARGS(code, fast, var_cnt, rep_cnt, rep_idx, ingpa, outgpa),
 
 	TP_STRUCT__entry(
 		__field(	__u16,		rep_cnt		)
@@ -74,6 +74,7 @@ TRACE_EVENT(kvm_hv_hypercall,
 		__field(	__u64,		ingpa		)
 		__field(	__u64,		outgpa		)
 		__field(	__u16, 		code		)
+		__field(	__u16,		var_cnt		)
 		__field(	bool,		fast		)
 	),
 
@@ -83,13 +84,14 @@ TRACE_EVENT(kvm_hv_hypercall,
 		__entry->ingpa		= ingpa;
 		__entry->outgpa		= outgpa;
 		__entry->code		= code;
+		__entry->var_cnt	= var_cnt;
 		__entry->fast		= fast;
 	),
 
-	TP_printk("code 0x%x %s cnt 0x%x idx 0x%x in 0x%llx out 0x%llx",
+	TP_printk("code 0x%x %s var_cnt 0x%x rep_cnt 0x%x idx 0x%x in 0x%llx out 0x%llx",
 		  __entry->code, __entry->fast ? "fast" : "slow",
-		  __entry->rep_cnt, __entry->rep_idx,  __entry->ingpa,
-		  __entry->outgpa)
+		  __entry->var_cnt, __entry->rep_cnt, __entry->rep_idx,
+		  __entry->ingpa, __entry->outgpa)
 );
 
 TRACE_EVENT(kvm_hv_hypercall_done,
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 8ed6733d5146..8a04c8fba598 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -183,6 +183,7 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
 #define HV_HYPERCALL_FAST_BIT		BIT(16)
 #define HV_HYPERCALL_VARHEAD_OFFSET	17
+#define HV_HYPERCALL_VARHEAD_MASK	GENMASK_ULL(26, 17)
 #define HV_HYPERCALL_REP_COMP_OFFSET	32
 #define HV_HYPERCALL_REP_COMP_1		BIT_ULL(32)
 #define HV_HYPERCALL_REP_COMP_MASK	GENMASK_ULL(43, 32)
-- 
2.34.1.400.ga245620fadb-goog

