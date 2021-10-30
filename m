Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748E2440649
	for <lists+linux-arch@lfdr.de>; Sat, 30 Oct 2021 02:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhJ3ALF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Oct 2021 20:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhJ3AKv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Oct 2021 20:10:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD20C0613F5
        for <linux-arch@vger.kernel.org>; Fri, 29 Oct 2021 17:08:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y18-20020a25a092000000b005bddb39f160so16350599ybh.10
        for <linux-arch@vger.kernel.org>; Fri, 29 Oct 2021 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=g8N785LbQmqDouE8MY/4F5fLmGf1N/e6esz2VzWdSfM=;
        b=qcm6wFPgzvLZxYDw2K9g6miB0T1oWE0fD2KsDna+TLFVaGGDxoYIYEABpHu0X8OwM8
         GguCYOwzk6m3J4OPTcG7CCyaGdC4G4e1ijCvu9QFL+jJeCZLHPov+WAYp14ijjjbWMwD
         S27jXgGB8bn69bb0mS1tfUMrTw1wWxKDQZ0D4y6en7N8l+gbLFn3JPTDZqlsg3jw7rdS
         O+UIqAW13KFMNG7JZbJ5C96PbxEyn1Kg+UG6HqTpgLKT6WkdE1hUkBBHrrTj2j8wEx5l
         IUeQh11N5rSJyqU/L5rTR2jnikLCFU5Lc5O50Scl0vSv0miQ1EQfrAYNLK9nHsIKjWI/
         /kAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=g8N785LbQmqDouE8MY/4F5fLmGf1N/e6esz2VzWdSfM=;
        b=4Q6AeAtPFWk/IU2B3LtNCDc6SgQHCxv5gmaDNuHFP6YufWOLhZ1reKVRb2FSl0QK+H
         VgQrOuECf56jMN5M0+XvXYMB4MLu2dkJvxeVjRPYt6GJRdjaYI359iIo2ixMhVgO4tpg
         pXOnsAyiXeTC2xuJFV0NhFeVSm/f2mZciJVTz19aITWd9rElaFAjSLwYr3V68Bh/kW74
         xyFLVqwPnBje24/DSWJt3czL1FW2jwLMiytj8x544svyhYruIklXuSiiTG2uBpJjY/Fx
         vpePbzAAB6g4Oy4TwJLxwfV5qyVj8VQ/BXbzjZ/9u2LI5PdYa03iDOWW+huvvxL0ldNM
         id8w==
X-Gm-Message-State: AOAM530eGoeQ7+Fvasd7Oj5wApNUK2pY2NLYAFiwMkxVeKhqJJryOW8H
        NbDttNFOv4NfVB6p88oRHPu14qWu0/c=
X-Google-Smtp-Source: ABdhPJxXvbiN7UyGx3BTDe1d5uKkd3rXxLm5EE651+sK4iAj+r3+1R5nVPFMbA19jNcjXmVTR9udqvnESFE=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:ce6:9e5f:4ab5:a0d2])
 (user=seanjc job=sendgmr) by 2002:a25:5854:: with SMTP id m81mr16028158ybb.195.1635552501888;
 Fri, 29 Oct 2021 17:08:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 29 Oct 2021 17:07:57 -0700
In-Reply-To: <20211030000800.3065132-1-seanjc@google.com>
Message-Id: <20211030000800.3065132-6-seanjc@google.com>
Mime-Version: 1.0
References: <20211030000800.3065132-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2 5/8] KVM: x86: Don't bother reading sparse banks that end
 up being ignored
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

When handling "sparse" VP_SET requests, don't read sparse banks that
can't possibly contain a legal VP index instead of ignoring such banks
later on in sparse_set_to_vcpu_mask().  This allows KVM to cap the size
of its sparse_banks arrays for VP_SET at KVM_HV_MAX_SPARSE_VCPU_SET_BITS.

Reducing the size of sparse_banks fudges around a compilation warning
(that becomes error with KVM_WERROR=y) when CONFIG_KASAN_STACK=y, which
is selected (and can't be unselected) by CONFIG_KASAN=y when using gcc
(clang/LLVM is a stack hog in some cases so it's opt-in for clang).
KASAN_STACK adds a redzone around every stack variable, which pushes the
Hyper-V functions over the default limit of 1024.

Ideally, KVM would flat out reject such impossibilities, but the TLFS
explicitly allows providing empty banks, even if a bank can't possibly
contain a valid VP index due to its position exceeding KVM's max.

  Furthermore, for a bit 1 in ValidBankMask, it is valid state for the
  corresponding element in BanksContents can be all 0s, meaning no
  processors are specified in this bank.

Arguably KVM should reject and not ignore the "extra" banks, but that can
be done independently and without bloating sparse_banks, e.g. by reading
each "extra" 8-byte chunk individually.

Reported-by: Ajay Garg <ajaygargnsit@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 3d0981163eed..8832727d74d9 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1753,11 +1753,16 @@ struct kvm_hv_hcall {
 static u64 kvm_get_sparse_vp_set(struct kvm *kvm, struct kvm_hv_hcall *hc,
 				 u64 *sparse_banks, gpa_t offset)
 {
+	u16 var_cnt;
+
 	if (hc->var_cnt > 64)
 		return -EINVAL;
 
+	/* Ignore banks that cannot possibly contain a legal VP index. */
+	var_cnt = min_t(u16, hc->var_cnt, KVM_HV_MAX_SPARSE_VCPU_SET_BITS);
+
 	return kvm_read_guest(kvm, hc->ingpa + offset, sparse_banks,
-			      hc->var_cnt * sizeof(*sparse_banks));
+			      var_cnt * sizeof(*sparse_banks));
 }
 
 static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool ex)
@@ -1770,7 +1775,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
 	unsigned long *vcpu_mask;
 	u64 valid_bank_mask;
-	u64 sparse_banks[64];
+	u64 sparse_banks[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
 	bool all_cpus;
 
 	if (!ex) {
@@ -1894,7 +1899,7 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
 	unsigned long *vcpu_mask;
 	unsigned long valid_bank_mask;
-	u64 sparse_banks[64];
+	u64 sparse_banks[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
 	u32 vector;
 	bool all_cpus;
 
-- 
2.33.1.1089.g2158813163f-goog

