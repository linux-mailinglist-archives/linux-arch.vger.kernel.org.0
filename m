Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BCA44064C
	for <lists+linux-arch@lfdr.de>; Sat, 30 Oct 2021 02:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhJ3ALN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Oct 2021 20:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbhJ3AK5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Oct 2021 20:10:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E94EC0613F5
        for <linux-arch@vger.kernel.org>; Fri, 29 Oct 2021 17:08:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b5-20020a25a205000000b005c2150fc181so1336971ybi.6
        for <linux-arch@vger.kernel.org>; Fri, 29 Oct 2021 17:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7YTOHGbXRx0pd53EDlA19/QLrIOrDD/OrONYgkhDNaY=;
        b=mJIRSnmWMZ3K5bJb2gYumed0yA8AwHNuP1wn9fwKVtmf73DoT4rBb3mK7Nuuo8b5dt
         4UD1yRhEBvJBzLlBS0caGMxENHeQlMZiPVT9Ynrn56n2+c4uLYa6VVp7yA/bkouRIiMf
         DdbJ7JNykV5fZ4efNbCw4VXcIqboOCbHBdHcPoCw7M50vJdw20kq3KGvBycY4+WIdFaU
         lpZfKf3rB9qj3klLdWNaql1M5yHLWQsDQ7XyaLZvbqM3h6rIc9Q/hcJmOllXKAm2QMbf
         l6YXu2FCJkUqGM/ASlp1JizyPSQAyMv1P2FWXEPC7vDsLaESucFmXnh7SPENssI8I15l
         CqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7YTOHGbXRx0pd53EDlA19/QLrIOrDD/OrONYgkhDNaY=;
        b=NSQnG8gTgL6WcOtsr/V1oaBVq7DsyBQkLG1oBRHLR61TWTU4AidTzSiwYU7mo04hdK
         i6rgBMHlOLtPwcVzxmva9N6vz7S9MkThQD6nOzs38U9cI51uSdDl6FQjqJTV5+io3KnU
         nxSfBrF59y7ocUmYfK7qbcJs9+A4dnes/pIicbN4RimAKGKAgGg25Cu/xHKeEtDdjFBj
         Ce/y/QB4LtKgnPI6zmTSF3fGwYC8B7GxZVXjrnsPMBDEgXTauItUsbZW+OMAcFjlQyFa
         x+M/F5cVBDMWDshMTMbW09NVb5UsaXojFz89q3M+xq3/gwTy2y1OAbwHZs0E3Sm0r8AY
         Jn7w==
X-Gm-Message-State: AOAM533AoX5jNQI8bDDrhpf4ZcpIOWuCchwLcuLR85dQsRLP3I1yapS3
        VXpiIVTNr15UOIU3NPlLkEsljj1+nK4=
X-Google-Smtp-Source: ABdhPJwOge/x4WwUAfBe4uN0yFwOjxJZLofxDVUmWKRExOA5YnXto3HDG50mi7m3czLysSnezaPvfu89U6I=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:ce6:9e5f:4ab5:a0d2])
 (user=seanjc job=sendgmr) by 2002:a25:abe3:: with SMTP id v90mr2400647ybi.315.1635552506473;
 Fri, 29 Oct 2021 17:08:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 29 Oct 2021 17:07:59 -0700
In-Reply-To: <20211030000800.3065132-1-seanjc@google.com>
Message-Id: <20211030000800.3065132-8-seanjc@google.com>
Mime-Version: 1.0
References: <20211030000800.3065132-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2 7/8] KVM: x86: Reject fixeds-size Hyper-V hypercalls with
 non-zero "var_cnt"
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

Reject Hyper-V hypercalls if the guest specifies a non-zero variable size
header (var_cnt in KVM) for a hypercall that has a fixed header size.
Per the TLFS:

  It is illegal to specify a non-zero variable header size for a
  hypercall that is not explicitly documented as accepting variable sized
  input headers. In such a case the hypercall will result in a return
  code of HV_STATUS_INVALID_HYPERCALL_INPUT.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 3d83d6a5d337..ad455df850c9 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2241,14 +2241,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 
 	switch (hc.code) {
 	case HVCALL_NOTIFY_LONG_SPIN_WAIT:
-		if (unlikely(hc.rep)) {
+		if (unlikely(hc.rep || hc.var_cnt)) {
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
 		kvm_vcpu_on_spin(vcpu, true);
 		break;
 	case HVCALL_SIGNAL_EVENT:
-		if (unlikely(hc.rep)) {
+		if (unlikely(hc.rep || hc.var_cnt)) {
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
@@ -2258,7 +2258,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		fallthrough;	/* maybe userspace knows this conn_id */
 	case HVCALL_POST_MESSAGE:
 		/* don't bother userspace if it has no way to handle it */
-		if (unlikely(hc.rep || !to_hv_synic(vcpu)->active)) {
+		if (unlikely(hc.rep || hc.var_cnt || !to_hv_synic(vcpu)->active)) {
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
@@ -2271,14 +2271,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 				kvm_hv_hypercall_complete_userspace;
 		return 0;
 	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST:
-		if (unlikely(!hc.rep_cnt || hc.rep_idx)) {
+		if (unlikely(!hc.rep_cnt || hc.rep_idx || hc.var_cnt)) {
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
 		ret = kvm_hv_flush_tlb(vcpu, &hc, false);
 		break;
 	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE:
-		if (unlikely(hc.rep)) {
+		if (unlikely(hc.rep || hc.var_cnt)) {
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
@@ -2299,7 +2299,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_hv_flush_tlb(vcpu, &hc, true);
 		break;
 	case HVCALL_SEND_IPI:
-		if (unlikely(hc.rep)) {
+		if (unlikely(hc.rep || hc.var_cnt)) {
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
@@ -2331,6 +2331,11 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			ret = HV_STATUS_OPERATION_DENIED;
 			break;
 		}
+		if (unlikely(hc.var_cnt)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+			break;
+		}
+
 		vcpu->run->exit_reason = KVM_EXIT_HYPERV;
 		vcpu->run->hyperv.type = KVM_EXIT_HYPERV_HCALL;
 		vcpu->run->hyperv.u.hcall.input = hc.param;
-- 
2.33.1.1089.g2158813163f-goog

