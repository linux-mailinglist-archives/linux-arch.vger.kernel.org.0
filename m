Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEFD46C738
	for <lists+linux-arch@lfdr.de>; Tue,  7 Dec 2021 23:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242137AbhLGWNR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Dec 2021 17:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242124AbhLGWNN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Dec 2021 17:13:13 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893A2C061746
        for <linux-arch@vger.kernel.org>; Tue,  7 Dec 2021 14:09:42 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x14-20020a627c0e000000b0049473df362dso390635pfc.12
        for <linux-arch@vger.kernel.org>; Tue, 07 Dec 2021 14:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=LLX3U7mn58e613uUDC2pnGcOVbMh7hOH4J4J3lUPvDA=;
        b=X/v9iuxguJ0gslCcBYYHV5+6guNvSMM9qc3Nnk0gQGJfA0JCwWgJ2KO3RZMUqiPq/U
         Ya0nim4PFV2cJoOGlCdNXk2c5F4LiG2ie9EmehAYYywgGLwHmrHzjvvfcbgS/F5XHJM1
         Nto3w+PRVUqT5Shiz/3oWVoWzGO/s966w93AFj0Lp+PFzTdQXIM5B6oMioqGygH4UCdO
         zLhOm/7deP+C8XsdjveswEV5Q6GVUHH+YTIRBpU7XlUeL+WkTSUaQHACzZWbgpQNUtTp
         oq+bqS4wds/+hMpcbcyt5oBzE/DeLi7LvVNw3wKPzH5mXIz7adRoLkilNcOiLlI5RcrC
         0qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=LLX3U7mn58e613uUDC2pnGcOVbMh7hOH4J4J3lUPvDA=;
        b=GS7mkVjyFPKjgR8MzwjZ7ezzlq+zFLpuh55vuGHtnh2tIJVXGxFgE5YVYWlIcdE7Ss
         QlO94oBqV8XnBFzLwpWNxchnr3X1eeNbebBzt3iDF9khD48WJS0rUMvmcvGEnovOZyTZ
         Mg3naLn56D/sm/tW7dE8z/vWKsmfxRz0+RGYBAv0W8wPdkiK14Lr36jcRV2rbfaU5Nl0
         P7mBZTlcRYON0fxf6VTYnudL+182zn5P5605GO6lIMFy4tLr8S267JtWyPor0wuTXeEn
         Kk/F0aJX2FwYEAYGUYcAbspo56fKMK6vPa8Y/bFc+jIbtycnzi0n1JANQZsLBg6h22Fr
         6omQ==
X-Gm-Message-State: AOAM530IiyBtzzCXhoXpCyQEqo9eFN1MtP1isHqRApClkH9m/XDzbGZh
        XgC0eV7KLEMyjbXtRH0EZDUT37CB8ZM=
X-Google-Smtp-Source: ABdhPJwCfyK/gnJBKpT9rlWfbFbYvRE1/0RiMXGIbXcLt3rF69pNTU9V1/jyqVwVV9vzkAJvoHmF/PGUsBc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1486:: with SMTP id
 js6mr251632pjb.0.1638914981457; Tue, 07 Dec 2021 14:09:41 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Dec 2021 22:09:21 +0000
In-Reply-To: <20211207220926.718794-1-seanjc@google.com>
Message-Id: <20211207220926.718794-4-seanjc@google.com>
Mime-Version: 1.0
References: <20211207220926.718794-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 3/8] KVM: x86: Refactor kvm_hv_flush_tlb() to reduce indentation
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
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index d8a7b63f676f..9bc856370a2d 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1815,31 +1815,33 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
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
2.34.1.400.ga245620fadb-goog

