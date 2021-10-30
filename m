Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5A0440652
	for <lists+linux-arch@lfdr.de>; Sat, 30 Oct 2021 02:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhJ3ALk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Oct 2021 20:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhJ3ALA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Oct 2021 20:11:00 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C34C061205
        for <linux-arch@vger.kernel.org>; Fri, 29 Oct 2021 17:08:29 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 90-20020aed3163000000b002a6bd958077so8023082qtg.6
        for <linux-arch@vger.kernel.org>; Fri, 29 Oct 2021 17:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=w8+VuMJWV7fnXYQnAR/imW2dw4pBJQeF54VXUV6T0ak=;
        b=jZ/TG0DzTsxGEQDaaW10aSLugJ9r7BLSrb2cjlCT0Fjzmx2Js1P0RaP2VeEiqVIeLk
         fWkONscVCDVZyhiV8Y44SIzNTIidQZWJCNVlUjVK/vEI1L3TKVByUUvUbuKAKS2Q8DU9
         bzQQFdNSviP7KT5a4EvT5+PuY4yS7J25eWs1d0sveB58xugu2vdgAroxrKs4dwx3Cgvn
         ben2KBlIV122IPNQtU4jHuQ/VrrO7vLZSiQz46TJbDRq3vAjm5lA3/7fYuwP9wUjscBG
         R1CgMHBO0dSHm2SEq6nTdDXeVj0RxObKAH7Be/QBn1J9kSnVH50K0c0tSRJXNYVbirXe
         gCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=w8+VuMJWV7fnXYQnAR/imW2dw4pBJQeF54VXUV6T0ak=;
        b=bCXO/X6EjQK/7jI6/p8eWdPZMkkCvIHhekGmJaH72k4jg8hd36e7TIUS7JNJXR6WRl
         Kg1OdALwzKeIJnuXR/LcXBkePP/paPzGlciOGF4Cj7atuLDv7ArSyvy+ZnKfFvqf5rE9
         kc5/dJCXbw2/nN7socpqbj1fY3CEjl3daGKJk96AS05HV4EtPX0Kkw59J66A9304pTT6
         13NDm/oNjC7D1AaSNKS1BHhTs1f9DY5JsFVMugnxJSTbm1q4JnOecjahOt8VWSI8ou3f
         nTNVgRz0eDnOzecBRZyH9gwo0MhySgrLP8RXmx6lM7QVDw1sJ4EtveFZ24WZVNpS126K
         ZO5Q==
X-Gm-Message-State: AOAM532hfPTkY8dWAn6+Niv3FuUzYONN5zCFJf1mX2bJHhap5kCRfoq4
        yzE2ZIm3+JuS5QZUlxGS1/+sXrDLg/o=
X-Google-Smtp-Source: ABdhPJxmgHNZ6JEXOBjMrTnWpIj+y1lncc+aqrq0evtEVSX15K53EUAMrwqzyfCT7pCOYVxqIeXox3TdFUk=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:ce6:9e5f:4ab5:a0d2])
 (user=seanjc job=sendgmr) by 2002:ac8:5711:: with SMTP id 17mr13304311qtw.58.1635552508765;
 Fri, 29 Oct 2021 17:08:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 29 Oct 2021 17:08:00 -0700
In-Reply-To: <20211030000800.3065132-1-seanjc@google.com>
Message-Id: <20211030000800.3065132-9-seanjc@google.com>
Mime-Version: 1.0
References: <20211030000800.3065132-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2 8/8] KVM: x86: Add checks for reserved-to-zero Hyper-V
 hypercall fields
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

Add checks for the three fields in Hyper-V's hypercall params that must
be zero.  Per the TLFS, HV_STATUS_INVALID_HYPERCALL_INPUT is returned if
"A reserved bit in the specified hypercall input value is non-zero."

Note, the TLFS has an off-by-one bug for the last reserved field, which
it defines as being bits 64:60.  The same section states "The input field
64-bit value called a hypercall input value.", i.e. bit 64 doesn't exist.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c             | 5 +++++
 include/asm-generic/hyperv-tlfs.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index ad455df850c9..1cdcf3ad5684 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2228,6 +2228,11 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		goto hypercall_complete;
 	}
 
+	if (unlikely(hc.param & HV_HYPERCALL_RSVD_MASK)) {
+		ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+		goto hypercall_complete;
+	}
+
 	if (hc.fast && is_xmm_fast_hypercall(&hc)) {
 		if (unlikely(hv_vcpu->enforce_cpuid &&
 			     !(hv_vcpu->cpuid_cache.features_edx &
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 1ba8e6da4427..92b9ce5882f8 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -183,11 +183,17 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_HYPERCALL_FAST_BIT		BIT(16)
 #define HV_HYPERCALL_VARHEAD_OFFSET	17
 #define HV_HYPERCALL_VARHEAD_MASK	GENMASK_ULL(26, 17)
+#define HV_HYPERCALL_RSVD0_MASK		GENMASK_ULL(31, 27)
 #define HV_HYPERCALL_REP_COMP_OFFSET	32
 #define HV_HYPERCALL_REP_COMP_1		BIT_ULL(32)
 #define HV_HYPERCALL_REP_COMP_MASK	GENMASK_ULL(43, 32)
+#define HV_HYPERCALL_RSVD1_MASK		GENMASK_ULL(47, 44)
 #define HV_HYPERCALL_REP_START_OFFSET	48
 #define HV_HYPERCALL_REP_START_MASK	GENMASK_ULL(59, 48)
+#define HV_HYPERCALL_RSVD2_MASK		GENMASK_ULL(63, 60)
+#define HV_HYPERCALL_RSVD_MASK		(HV_HYPERCALL_RSVD0_MASK | \
+					 HV_HYPERCALL_RSVD1_MASK | \
+					 HV_HYPERCALL_RSVD2_MASK)
 
 /* hypercall status code */
 #define HV_STATUS_SUCCESS			0
-- 
2.33.1.1089.g2158813163f-goog

