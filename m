Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80BA440636
	for <lists+linux-arch@lfdr.de>; Sat, 30 Oct 2021 02:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhJ3AKp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Oct 2021 20:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhJ3AKo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Oct 2021 20:10:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C833C061205
        for <linux-arch@vger.kernel.org>; Fri, 29 Oct 2021 17:08:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so16437527yba.11
        for <linux-arch@vger.kernel.org>; Fri, 29 Oct 2021 17:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ptn47+BKhy/SHg2Js9P1mPtZhgiXFDoRDpv5JEfjKjI=;
        b=NP+uIOddDk7SXyU+14tEFMuNbjQwPVQ5Pr596q3FRiq51u5lJ+RDvB9opzu7QTp3Om
         wTjLdk7znQDz5Sp2LNB+T5IYunFmqFj9yKlCfOTK3RLN+npuhKoCKnWjumz2oZJ/ld9g
         LliXUJqHWO2O34npQmegkWMajRobeZai2Mah1qkJBKP/3XfndODMZ1DlSnoC8C5uN95L
         KANTB09+Vi1KpdIjM+nLC4ZHuvWnSRuIgo3xsTvBeen7ez6Li7GlNSS9moadXxthRwVI
         8YMrrUVNe68t7nOG4wGKE5YNDp5Ljt3Jqy6c9M6+rwnDZ6Vkw7MoXh9a+abHETvfN+7M
         3z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ptn47+BKhy/SHg2Js9P1mPtZhgiXFDoRDpv5JEfjKjI=;
        b=fk8qHsWFO2j/xS3RKBmjwcfisJ1fWjMrAhVZ2lFshPmwgrrtEL/TKRPI7ytOSc0fNE
         bPub+hHEAhT6QhqwgT+y+vgFUsB52vvois/JSNF/n2p1iWgbmgJ6ibaT3FIkrZaJBTIb
         GwFT8iVI8P9tqNk5MzA/BCjQ84uy+covgIcRhCaZugqZKvC/ZP/2FsVl6FDu1wGhSaRn
         yOpmGBn4scy2ntraYQIFHxzvo9s+/hO+0fek8t3pJIiUgCQnY61n34EWZG05YLEJy/7S
         vHtX4IbEWdvlsR6HwE9IJ2DMFMkvl4E3AQpqLlS2OualDgsS2G2a/1sIQNGKLDbh96vm
         6+5Q==
X-Gm-Message-State: AOAM53204ph2OrYzYuYuWEGnOoNS5avjskviqjpC0CcIa2W+x83DCuhN
        AfCu0+Upor6y9WD6d3O3vj0M0lGvdYk=
X-Google-Smtp-Source: ABdhPJyoPtboi3LyMIegedX4hbA+ehba21GlEj/X02Y8Bdv7WtzqQvjjlfpfSGQoKTlbR1d51HcRp9vr9Mk=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:ce6:9e5f:4ab5:a0d2])
 (user=seanjc job=sendgmr) by 2002:a25:2e0a:: with SMTP id u10mr14167844ybu.484.1635552492806;
 Fri, 29 Oct 2021 17:08:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 29 Oct 2021 17:07:53 -0700
In-Reply-To: <20211030000800.3065132-1-seanjc@google.com>
Message-Id: <20211030000800.3065132-2-seanjc@google.com>
Mime-Version: 1.0
References: <20211030000800.3065132-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2 1/8] KVM: x86: Ignore sparse banks size for an "all CPUs",
 non-sparse IPI req
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

Do not bail early if there are no bits set in the sparse banks for a
non-sparse, a.k.a. "all CPUs", IPI request.  Per the Hyper-V spec, it is
legal to have a variable length of '0', e.g. VP_SET's BankContents in
this case, if the request can be serviced without the extra info.

  It is possible that for a given invocation of a hypercall that does
  accept variable sized input headers that all the header input fits
  entirely within the fixed size header. In such cases the variable sized
  input header is zero-sized and the corresponding bits in the hypercall
  input should be set to zero.

Bailing early results in KVM failing to send IPIs to all CPUs as expected
by the guest.

Fixes: 214ff83d4473 ("KVM: x86: hyperv: implement PV IPI send hypercalls")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4f15c0165c05..814d1a1f2cb8 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1922,11 +1922,13 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 
 		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
 
+		if (all_cpus)
+			goto check_and_send_ipi;
+
 		if (!sparse_banks_len)
 			goto ret_success;
 
-		if (!all_cpus &&
-		    kvm_read_guest(kvm,
+		if (kvm_read_guest(kvm,
 				   hc->ingpa + offsetof(struct hv_send_ipi_ex,
 							vp_set.bank_contents),
 				   sparse_banks,
@@ -1934,6 +1936,7 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
 
+check_and_send_ipi:
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
 		return HV_STATUS_INVALID_HYPERCALL_INPUT;
 
-- 
2.33.1.1089.g2158813163f-goog

