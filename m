Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F023A44064D
	for <lists+linux-arch@lfdr.de>; Sat, 30 Oct 2021 02:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhJ3ALO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Oct 2021 20:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhJ3AKp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Oct 2021 20:10:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C682FC061570
        for <linux-arch@vger.kernel.org>; Fri, 29 Oct 2021 17:08:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d8-20020a253608000000b005c202405f52so5239985yba.7
        for <linux-arch@vger.kernel.org>; Fri, 29 Oct 2021 17:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=nZgvEByp7NGBu6ZKjCithSTl6MGwJocQOrlXwlTztss=;
        b=SwSQxCQjFCFjO1EyF2BMRJLSkAyCsJT3bUjiKuPge9om88vrvED4780IzC/uq8vOk6
         trnN5ZgqnL9I3ylegVnZjsMiRzQEhSjGFzSgnbZ7EvyPFaTLb+AKu+RyWfz6+i1wGj3Q
         QzhJun8Tee0L6admV6BWGCS95Ul47ku7WnEo1SFA1Jm9Bh1voenugNcmRhMFxgGFzQd4
         8Bpe30KeYvraOGSGLisSWeOFiAadbmajcLcDwt1TelTK15dNwCBmVBihcnM/SGeq1Gls
         s7nHC7Vi074UUv+3Mc40aeFu9GjHf3D/8FmxminQlCY8VVUYF0DkveB86bLpfzb+c/rj
         JQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=nZgvEByp7NGBu6ZKjCithSTl6MGwJocQOrlXwlTztss=;
        b=Ub0ckINgb9zPvkBvV3NnrBydtOxL+UGWnX3WwTotU30+7wOz4qVSk0GcshIjnKaPUE
         SZAqMYA6rJWErrAKJkgniMQAuZK2stPffbH3LSXF3pG7kb2xoiSmkJJ/nZJ2TGz1OIfP
         38Gy/+C39VjzbNga9/fcfwbyiJcyxdpKXLrknL/jwJCRe7WZNqD/U1bxq3560r3udy0o
         8LlYMUEkgqj+/Rj5LbdBc+WxY61FxyYA4NfiM1Mxa/E1Rw5+rvNBNJnxnwqQi4SzIwqI
         MeDnc4n3rUxh4p+ce9wP17XxVqGogk0UO9TiES1s0UWvj/imXr/PzYs6kVQXRs2Nlwfk
         O7ZQ==
X-Gm-Message-State: AOAM5335L85Y1nt8jlWasKqfZBkAsROgjh7SQtCZtshE0krZEXABBYvI
        QmX/6GhhGpu0CvK+9t7Ryl62cgxu1Ks=
X-Google-Smtp-Source: ABdhPJzgwITvxkHjIZJNbgNeWiqj+13l8VoV4q1YgxPQlpXEd7kOmcS2UN09ZaM3Hamym5CvzyBYJBs54WA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:ce6:9e5f:4ab5:a0d2])
 (user=seanjc job=sendgmr) by 2002:a25:4008:: with SMTP id n8mr4568390yba.371.1635552495075;
 Fri, 29 Oct 2021 17:08:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 29 Oct 2021 17:07:54 -0700
In-Reply-To: <20211030000800.3065132-1-seanjc@google.com>
Message-Id: <20211030000800.3065132-3-seanjc@google.com>
Mime-Version: 1.0
References: <20211030000800.3065132-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2 2/8] KVM: x86: Get the number of Hyper-V sparse banks from
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c             | 35 ++++++++++++++++++-------------
 arch/x86/kvm/trace.h              | 14 +++++++------
 include/asm-generic/hyperv-tlfs.h |  1 +
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 814d1a1f2cb8..cf18aa1712bf 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1742,6 +1742,7 @@ struct kvm_hv_hcall {
 	u64 ingpa;
 	u64 outgpa;
 	u16 code;
+	u16 var_cnt;
 	u16 rep_cnt;
 	u16 rep_idx;
 	bool fast;
@@ -1761,7 +1762,6 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 	unsigned long *vcpu_mask;
 	u64 valid_bank_mask;
 	u64 sparse_banks[64];
-	int sparse_banks_len;
 	bool all_cpus;
 
 	if (!ex) {
@@ -1811,24 +1811,28 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
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
@@ -1884,7 +1888,6 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 	unsigned long *vcpu_mask;
 	unsigned long valid_bank_mask;
 	u64 sparse_banks[64];
-	int sparse_banks_len;
 	u32 vector;
 	bool all_cpus;
 
@@ -1917,22 +1920,25 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 
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
 
@@ -2190,13 +2196,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
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
index 953b0fcb21ee..f6625cfb686c 100644
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
+	TP_printk("code 0x%x %s var_cnt 0x%x cnt 0x%x idx 0x%x in 0x%llx out 0x%llx",
 		  __entry->code, __entry->fast ? "fast" : "slow",
-		  __entry->rep_cnt, __entry->rep_idx,  __entry->ingpa,
-		  __entry->outgpa)
+		  __entry->var_cnt, __entry->rep_cnt, __entry->rep_idx,
+		  __entry->ingpa, __entry->outgpa)
 );
 
 TRACE_EVENT(kvm_hv_hypercall_done,
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 56348a541c50..1ba8e6da4427 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -182,6 +182,7 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
 #define HV_HYPERCALL_FAST_BIT		BIT(16)
 #define HV_HYPERCALL_VARHEAD_OFFSET	17
+#define HV_HYPERCALL_VARHEAD_MASK	GENMASK_ULL(26, 17)
 #define HV_HYPERCALL_REP_COMP_OFFSET	32
 #define HV_HYPERCALL_REP_COMP_1		BIT_ULL(32)
 #define HV_HYPERCALL_REP_COMP_MASK	GENMASK_ULL(43, 32)
-- 
2.33.1.1089.g2158813163f-goog

