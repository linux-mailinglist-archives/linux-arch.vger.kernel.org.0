Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8623440644
	for <lists+linux-arch@lfdr.de>; Sat, 30 Oct 2021 02:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhJ3AK6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Oct 2021 20:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhJ3AKy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Oct 2021 20:10:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5B8C061210
        for <linux-arch@vger.kernel.org>; Fri, 29 Oct 2021 17:08:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t7-20020a258387000000b005b6d7220c79so16288198ybk.16
        for <linux-arch@vger.kernel.org>; Fri, 29 Oct 2021 17:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=36Bkey2v0PWNL0aPQkSylqRKmvNJMV7/MPAnO77Vmno=;
        b=eKzg2+hLagxlJW0b3C7B8e26rAVT447Pii1206iwFsh6XO9vx7eMIVK0hUiebVX8wv
         jUq2nyBjLOZI6x5rq6duGtFeLER6u8PNxtZmUxXLdFbJwkgVFL86G2fkiU/M9T0yx/H3
         uq6PjIyEPi61zGI45SLPYL3OFhnB06gTqtdqHRPuxcC+eucMomTsndUOU6RC9Mj5RpqW
         8EDec0GeYVnpskKfx7XvHIZS6sr/b+eH2kwHH8MQnnG92HwV2g2q0MqzOiszhUshXysS
         rDZjBH7LCLzWPAkwFQMY1CeExocmd8qtVKj+qemD/v5F9lS1klVM05+TsX1a/fwd8USc
         s7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=36Bkey2v0PWNL0aPQkSylqRKmvNJMV7/MPAnO77Vmno=;
        b=6HWS7TITJy+LyUrXcr/5B1TvzPH++Cb+mYaGhw6Kye7xDuwdg6cEXXD7yJA6Wux+El
         hjXmCZGH/vg1ZO3/2S1jq7R9kh2iyfr+HdNZFpKxRpf1KFOgDc9mrJmp9JuH+JMT4zef
         rg3VW8ZdoUTZKTkwcyTEmTrxLNl5Z8T+cOeQWl+02vuLZtAW28F7K/Pr5MUpUWgjCBoM
         NbHb/1MrgJCCmDlcjJwXSj6QXYgjk+KG1F2z0kaMLfkrUR/pQ/9ptc2iaQntETjNnZ4P
         og1hp3GJ+V1ITzUmdR7Ri1ZfoEchzjRzrtMs6qwn9GQEId2z7t4BpeQpLnohG67+aHWw
         eY/w==
X-Gm-Message-State: AOAM531IINn6Yq992xgs/stn4JCRp5mKJf2I+t3XRWnAT/uugASCny/o
        mxHyIrH088rT9lP9S6Rw5hOC9KFRX1E=
X-Google-Smtp-Source: ABdhPJyf2Ywr6b3oDb1kN8vqSAaBDjF6Mh1au1t9H/cCEtrbm1kU9n46S73MgtqSQ59hDXQLyRDRO2wP6UQ=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:ce6:9e5f:4ab5:a0d2])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1342:: with SMTP id
 g2mr6403552ybu.419.1635552504182; Fri, 29 Oct 2021 17:08:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 29 Oct 2021 17:07:58 -0700
In-Reply-To: <20211030000800.3065132-1-seanjc@google.com>
Message-Id: <20211030000800.3065132-7-seanjc@google.com>
Mime-Version: 1.0
References: <20211030000800.3065132-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2 6/8] KVM: x86: Shove vp_bitmap handling down into sparse_set_to_vcpu_mask()
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

Move the vp_bitmap "allocation" that's needed to handle mismatched vp_index
values down into sparse_set_to_vcpu_mask() and drop __always_inline from
said helper.  The need for an intermediate vp_bitmap is a detail that's
specific to the sparse translation with mismatched VP<=>vCPU indexes and
does not need to be exposed to the caller.

Regarding the __always_inline, prior to commit f21dd494506a ("KVM: x86:
hyperv: optimize sparse VP set processing") the helper, then named
hv_vcpu_in_sparse_set(), was a tiny bit of code that effectively boiled
down to a handful of bit ops.  The __always_inline was understandable, if
not justifiable.  Since the aforementioned change, sparse_set_to_vcpu_mask()
is a chunky 350-450+ bytes of code without KASAN=y, and balloons to 1100+
with KASAN=y.  In other words, it has no business being forcefully inlined.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 65 +++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 8832727d74d9..3d83d6a5d337 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1710,31 +1710,46 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
 		return kvm_hv_get_msr(vcpu, msr, pdata, host);
 }
 
-static __always_inline unsigned long *sparse_set_to_vcpu_mask(
-	struct kvm *kvm, u64 *sparse_banks, u64 valid_bank_mask,
-	u64 *vp_bitmap, unsigned long *vcpu_bitmap)
+static void sparse_set_to_vcpu_mask(struct kvm *kvm, u64 *sparse_banks,
+				    u64 valid_bank_mask, unsigned long *vcpu_mask)
 {
 	struct kvm_hv *hv = to_kvm_hv(kvm);
+	bool has_mismatch = atomic_read(&hv->num_mismatched_vp_indexes);
+	u64 vp_bitmap[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
 	struct kvm_vcpu *vcpu;
 	int i, bank, sbank = 0;
+	u64 *bitmap;
 
-	memset(vp_bitmap, 0,
-	       KVM_HV_MAX_SPARSE_VCPU_SET_BITS * sizeof(*vp_bitmap));
+	BUILD_BUG_ON(sizeof(vp_bitmap) >
+		     sizeof(*vcpu_mask) * BITS_TO_LONGS(KVM_MAX_VCPUS));
+
+	/*
+	 * If vp_index == vcpu_idx for all vCPUs, fill vcpu_mask directly, else
+	 * fill a temporary buffer and manually test each vCPU's VP index.
+	 */
+	if (likely(!has_mismatch))
+		bitmap = (u64 *)vcpu_mask;
+	else
+		bitmap = vp_bitmap;
+
+	/*
+	 * Each set of 64 VPs is packed into sparse_banks, with valid_bank_amsk
+	 * having a '1' for each bank that exits in sparse_banks.  Sets must be
+	 * in ascending order, i.e. bank0..bankN.
+	 */
+	memset(bitmap, 0, sizeof(vp_bitmap));
 	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask,
 			 KVM_HV_MAX_SPARSE_VCPU_SET_BITS)
-		vp_bitmap[bank] = sparse_banks[sbank++];
+		bitmap[bank] = sparse_banks[sbank++];
 
-	if (likely(!atomic_read(&hv->num_mismatched_vp_indexes))) {
-		/* for all vcpus vp_index == vcpu_idx */
-		return (unsigned long *)vp_bitmap;
-	}
+	if (likely(!has_mismatch))
+		return;
 
-	bitmap_zero(vcpu_bitmap, KVM_MAX_VCPUS);
+	bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		if (test_bit(kvm_hv_get_vpindex(vcpu), (unsigned long *)vp_bitmap))
-			__set_bit(i, vcpu_bitmap);
+			__set_bit(i, vcpu_mask);
 	}
-	return vcpu_bitmap;
 }
 
 struct kvm_hv_hcall {
@@ -1771,9 +1786,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 	struct kvm *kvm = vcpu->kvm;
 	struct hv_tlb_flush_ex flush_ex;
 	struct hv_tlb_flush flush;
-	u64 vp_bitmap[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
-	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
-	unsigned long *vcpu_mask;
+	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
 	u64 valid_bank_mask;
 	u64 sparse_banks[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
 	bool all_cpus;
@@ -1858,11 +1871,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 	if (all_cpus) {
 		kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH_GUEST);
 	} else {
-		vcpu_mask = sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask,
-						    vp_bitmap, vcpu_bitmap);
+		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask, vcpu_mask);
 
-		kvm_make_vcpus_request_mask(kvm, KVM_REQ_TLB_FLUSH_GUEST,
-					    vcpu_mask);
+		kvm_make_vcpus_request_mask(kvm, KVM_REQ_TLB_FLUSH_GUEST, vcpu_mask);
 	}
 
 ret_success:
@@ -1895,9 +1906,7 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 	struct kvm *kvm = vcpu->kvm;
 	struct hv_send_ipi_ex send_ipi_ex;
 	struct hv_send_ipi send_ipi;
-	u64 vp_bitmap[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
-	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
-	unsigned long *vcpu_mask;
+	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
 	unsigned long valid_bank_mask;
 	u64 sparse_banks[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
 	u32 vector;
@@ -1953,11 +1962,13 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
 		return HV_STATUS_INVALID_HYPERCALL_INPUT;
 
-	vcpu_mask = all_cpus ? NULL :
-		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask,
-					vp_bitmap, vcpu_bitmap);
+	if (all_cpus) {
+		kvm_send_ipi_to_many(kvm, vector, NULL);
+	} else {
+		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask, vcpu_mask);
 
-	kvm_send_ipi_to_many(kvm, vector, vcpu_mask);
+		kvm_send_ipi_to_many(kvm, vector, vcpu_mask);
+	}
 
 ret_success:
 	return HV_STATUS_SUCCESS;
-- 
2.33.1.1089.g2158813163f-goog

