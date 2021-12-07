Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0046C739
	for <lists+linux-arch@lfdr.de>; Tue,  7 Dec 2021 23:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhLGWN2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Dec 2021 17:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242178AbhLGWNU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Dec 2021 17:13:20 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE61C061574
        for <linux-arch@vger.kernel.org>; Tue,  7 Dec 2021 14:09:48 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id s16-20020a170902ea1000b00142728c2ccaso69001plg.23
        for <linux-arch@vger.kernel.org>; Tue, 07 Dec 2021 14:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=1xUCQqaadj39qPYX5+0RhR1caCIav7GVwsY/DWLjRyI=;
        b=azApa98Yk5L4oCtYXZqGt9opUbGi5KyL1Ev8tBoecf738obg9xEjmQI22eeWcA2SjJ
         G2wXN1UyTMSh8I2Vezmoj50vYFWjTspiGsiEegxSGxpQuaypsYiqyD5VGYDLPc8W4p3o
         Us7dPEm1Jvq7vLKTo7dy2qyu7wBxwa0yW1RxZ+P4wr12NFPLPOS+PCAYS3Br1jYTOLQm
         DAfIan4RTqfm0IUP1EMyB0wrrf6ZrQ7e+EJ4A9f7LBbnREEIU9jsGD2CW5EK+w7/v34g
         iYhigvrlClSkshZyMbPIsKIMBoFJxHImsIhWQ+huUwnlO9/nm7WEebUw7BI5P6Lam0xS
         L30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=1xUCQqaadj39qPYX5+0RhR1caCIav7GVwsY/DWLjRyI=;
        b=VjVUvye1ojxG/asxulZMAQW47HBa1XnepvugQ120Pf+jcu24GnvYI9Urheg65J1naf
         Vgobw2tNsfqEtKxwQVKqRUdUBKoSJ8XxOssannNVB0Q7/obDM5iNbPPC6PnWM4PJkRIm
         8bUHETIQh0D9eqFetuwKLxbnzs/bEIQwXZF9ueiv4yvZtCUe47XmSgYLS6rAaquSNv5l
         1sJsrdbUoaktrouxAF/C9niCLWE2lSGYh4kLBazLsazZQ7acVx4i8xG+3wRrha4Hd4KW
         pLlCNNjpGlHHBWBhPHbv/hnDByL2D6EVJJ5gUq0GO0F2IqRibO2Z5FS/K75wafM08WJP
         Rcqg==
X-Gm-Message-State: AOAM532+Sjh1Uk5I0dV9hGjqU2uvO1Q5T0Vk+Vya1yaioe63vfa950WT
        L4+ob4pUcTRlnlFBSwj/7iQ4znjVf/c=
X-Google-Smtp-Source: ABdhPJyLN1IVX2Wn3Ulx5AVDpqGwUpPztEVZ12DjjyX+6/V4O5O1cCOmldXUxzRpLrTmUAu4TgkWRL+F8+A=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:6a82:: with SMTP id
 u2mr2391892pjj.105.1638914988263; Tue, 07 Dec 2021 14:09:48 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Dec 2021 22:09:25 +0000
In-Reply-To: <20211207220926.718794-1-seanjc@google.com>
Message-Id: <20211207220926.718794-8-seanjc@google.com>
Mime-Version: 1.0
References: <20211207220926.718794-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 7/8] KVM: x86: Reject fixeds-size Hyper-V hypercalls with
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

Note, at least some of the various DEBUG commands likely aren't allowed
to use variable size headers, but the TLFS documentation doesn't clearly
state what is/isn't allowed.  Omit them for now to avoid unnecessary
breakage.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index f33a5e890048..522ccd2f0db4 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2250,14 +2250,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 
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
@@ -2267,7 +2267,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		fallthrough;	/* maybe userspace knows this conn_id */
 	case HVCALL_POST_MESSAGE:
 		/* don't bother userspace if it has no way to handle it */
-		if (unlikely(hc.rep || !to_hv_synic(vcpu)->active)) {
+		if (unlikely(hc.rep || hc.var_cnt || !to_hv_synic(vcpu)->active)) {
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
@@ -2280,14 +2280,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
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
@@ -2308,7 +2308,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_hv_flush_tlb(vcpu, &hc, true);
 		break;
 	case HVCALL_SEND_IPI:
-		if (unlikely(hc.rep)) {
+		if (unlikely(hc.rep || hc.var_cnt)) {
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
-- 
2.34.1.400.ga245620fadb-goog

