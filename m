Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECE344063A
	for <lists+linux-arch@lfdr.de>; Sat, 30 Oct 2021 02:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhJ3AKt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Oct 2021 20:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhJ3AKr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Oct 2021 20:10:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E99FC061714
        for <linux-arch@vger.kernel.org>; Fri, 29 Oct 2021 17:08:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f92-20020a25a465000000b005bea37bc0baso16611088ybi.5
        for <linux-arch@vger.kernel.org>; Fri, 29 Oct 2021 17:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=rdYV8Rh+gsF4LGjfEoFh/A23FiUvNBq6WymrGnbxtjg=;
        b=Zs4AL07cfDQacvrC/i4BVmIkuHvuBvzQFygWUWY5E09jM0OVr+9RN/OYCHjGC1N2ZM
         EZSoVNXdKzc4H00QN2qShYNrtv2l1fNkXvcfJrqadSXRQf7kmRZnZ/g2miBQ/EO8lsBB
         d6H48DhnCszC2j1Pu5V4Z3Ahp53bIazpcLQ+Qd8s0ounfnguLnCOGpRz2ldsAAoKYsZR
         PlsKMFB4xSS+IViiW2XPKX3DZkvkg8YskcuejlCSB7rQRPTgXIrJuQwwV0u852pUcgmX
         rHlC/ZBjIzdK528ZGVr4ncGEWpGfjFGRlYtNAjKs7TaOZ0aTN68OC/5tDIuUDxA1HvuI
         kLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=rdYV8Rh+gsF4LGjfEoFh/A23FiUvNBq6WymrGnbxtjg=;
        b=Xg9v1ABdSJw43b2A6IDReYOExZIMdJuIfAkAl/NMd2a4wCgoXneEQsFn0br93O59gf
         S5Y5oDgaalXQLtd77hBj65G/qpEpwseGSQ/LO2vsOyxSRIk/8IMS4R7kEXf0/MUPXyq5
         lD/UeNXHAb9XNzu+kOiK0bMBVrZ7xA/uUF0tcTEDfVcnEQrtYWIoeWv6rRS7C3eG+meL
         X0SXO6EBnbpf9dYt8YIGBJ/bpNr1Th1PrSdp6S2EUsROQfpaiOhP0ORqdUJ3/6nlHafO
         w6LMoQM9VsJyVdK7Nty0wqHqm/hZjki565GQLhs1pfzvU8Z3gW/oygvTkBznvoFXpSF9
         wRzg==
X-Gm-Message-State: AOAM533MJRv8S7Uc/e1rAdHm2CapREgpI59uULMxgl+EQMaf1fyY71C2
        3M7BlSZ4g2mnJ30EKRKE+ddz2BIDKr0=
X-Google-Smtp-Source: ABdhPJxekP/MU8gZ7HoA6BqHTV1/zJpwGdreWA/5Ed3tZeIBIg7lc8U/sdZblP6IiT3FG2M2rX7kU3/QmYY=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:ce6:9e5f:4ab5:a0d2])
 (user=seanjc job=sendgmr) by 2002:a25:4f89:: with SMTP id d131mr14706558ybb.397.1635552497442;
 Fri, 29 Oct 2021 17:08:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 29 Oct 2021 17:07:55 -0700
In-Reply-To: <20211030000800.3065132-1-seanjc@google.com>
Message-Id: <20211030000800.3065132-4-seanjc@google.com>
Mime-Version: 1.0
References: <20211030000800.3065132-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2 3/8] KVM: x86: Refactor kvm_hv_flush_tlb() to reduce indentation
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

Refactor the "extended" path of kvm_hv_flush_tlb() to reduce the nesting
depth for the non-fast sparse path, and to make the code more similar to
the extended path in kvm_hv_send_ipi().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index cf18aa1712bf..e68931ed27f6 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1814,31 +1814,33 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 		if (hc->var_cnt != bitmap_weight((unsigned long *)&valid_bank_mask, 64))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 
-		if (!hc->var_cnt && !all_cpus)
+		if (all_cpus)
+			goto do_flush;
+
+		if (!hc->var_cnt)
 			goto ret_success;
 
-		if (!all_cpus) {
-			if (hc->fast) {
-				if (hc->var_cnt > HV_HYPERCALL_MAX_XMM_REGISTERS - 1)
-					return HV_STATUS_INVALID_HYPERCALL_INPUT;
-				for (i = 0; i < hc->var_cnt; i += 2) {
-					sparse_banks[i] = sse128_lo(hc->xmm[i / 2 + 1]);
-					sparse_banks[i + 1] = sse128_hi(hc->xmm[i / 2 + 1]);
-				}
-			} else {
-				if (hc->var_cnt > 64)
-					return HV_STATUS_INVALID_HYPERCALL_INPUT;
-
-				gpa = hc->ingpa + offsetof(struct hv_tlb_flush_ex,
-							   hv_vp_set.bank_contents);
-				if (unlikely(kvm_read_guest(kvm, gpa, sparse_banks,
-							    hc->var_cnt *
-							    sizeof(sparse_banks[0]))))
-					return HV_STATUS_INVALID_HYPERCALL_INPUT;
+		if (hc->fast) {
+			if (hc->var_cnt > HV_HYPERCALL_MAX_XMM_REGISTERS - 1)
+				return HV_STATUS_INVALID_HYPERCALL_INPUT;
+			for (i = 0; i < hc->var_cnt; i += 2) {
+				sparse_banks[i] = sse128_lo(hc->xmm[i / 2 + 1]);
+				sparse_banks[i + 1] = sse128_hi(hc->xmm[i / 2 + 1]);
 			}
+			goto do_flush;
 		}
+
+		if (hc->var_cnt > 64)
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
+		gpa = hc->ingpa + offsetof(struct hv_tlb_flush_ex,
+					   hv_vp_set.bank_contents);
+		if (unlikely(kvm_read_guest(kvm, gpa, sparse_banks,
+					    hc->var_cnt * sizeof(sparse_banks[0]))))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
 
+do_flush:
 	/*
 	 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we can't
 	 * analyze it here, flush TLB regardless of the specified address space.
-- 
2.33.1.1089.g2158813163f-goog

