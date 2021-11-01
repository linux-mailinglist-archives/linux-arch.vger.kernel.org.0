Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD2B44194C
	for <lists+linux-arch@lfdr.de>; Mon,  1 Nov 2021 11:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhKAKDj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Nov 2021 06:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231741AbhKAKDD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Nov 2021 06:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635760830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T3Mnk1LtljySX7eLUgrWBQMt2qpDHWFn7y46BPU88/k=;
        b=eZPVZS2TuKr8W5y1t9q/tMi+9ER30zOwyOoWHBALjQUXulK4B2jyIMwFZPF7A96lYgtJhS
        FV2onNe41IV4DKSsfskALRqlZNtihfTE1F+3v8qGv8Ptr62/ZINJTBe7inLjT6F5Trb2pI
        2b96JYIdGSdRmjAm93Zwu4BJBV0O6GI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-6SGebiDZNHOX07OMQqt_cQ-1; Mon, 01 Nov 2021 06:00:29 -0400
X-MC-Unique: 6SGebiDZNHOX07OMQqt_cQ-1
Received: by mail-ed1-f69.google.com with SMTP id x13-20020a05640226cd00b003dd4720703bso15071346edd.8
        for <linux-arch@vger.kernel.org>; Mon, 01 Nov 2021 03:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=T3Mnk1LtljySX7eLUgrWBQMt2qpDHWFn7y46BPU88/k=;
        b=7FujxcXEhYDBgR+z/yX7GvmmpkRuVFJQe/trs7GwO9hxkgqfSGnNyT/WXjCw8HUMhM
         r0wZC5P7iDhi4gNQTG/XWx5MjCk0CCg58xJCiS2OhANHpUFyq9JBj+gGaf4M0JmhkScy
         bBiy/nlB2rtOGy2NeklaL043s7d5e5PmR/9iw5Znip9Hw9bn+6SfIuznpjmb5zZdM9Dw
         QrQ3ZYhyZIA9RWCGwATSggwnDPSoID/hM453RzeSNmMv2hDjxSojLT+Di3aVCRgXfwWo
         IOexvTc2Rx1ChFDHogRLf2mJdfrVRRuBIFnfVklfGM0spQooqLFqz1wEJZsS0oxnDLkr
         5rmg==
X-Gm-Message-State: AOAM533vqi9zkV/Ty4vD+9thKzWdAKfQhHm0nfsIAkS13FlPSMacz6ky
        ohy4wwcy6EjXJQteMsdswUAqbwcxq8+inm/tIOnjj73NZu/QjeLxBmwhPB6typ7IqKifSHDdFRa
        P36vQRLdGJzccD2rBEOACLw==
X-Received: by 2002:a50:fa99:: with SMTP id w25mr36157866edr.324.1635760828172;
        Mon, 01 Nov 2021 03:00:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMekwGfgN/AH4vbH+XEERg1vOpDMn1BP5Wy2OD6Y7fQxUTVAeWxhxwf/7RsZbIIDco0fSKYg==
X-Received: by 2002:a50:fa99:: with SMTP id w25mr36157815edr.324.1635760827634;
        Mon, 01 Nov 2021 03:00:27 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m5sm6669236ejc.62.2021.11.01.03.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 03:00:27 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/8] KVM: x86: Refactor kvm_hv_flush_tlb() to reduce
 indentation
In-Reply-To: <20211030000800.3065132-4-seanjc@google.com>
References: <20211030000800.3065132-1-seanjc@google.com>
 <20211030000800.3065132-4-seanjc@google.com>
Date:   Mon, 01 Nov 2021 11:00:25 +0100
Message-ID: <877ddskxfq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Refactor the "extended" path of kvm_hv_flush_tlb() to reduce the nesting
> depth for the non-fast sparse path, and to make the code more similar to
> the extended path in kvm_hv_send_ipi().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/hyperv.c | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index cf18aa1712bf..e68931ed27f6 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1814,31 +1814,33 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  		if (hc->var_cnt != bitmap_weight((unsigned long *)&valid_bank_mask, 64))
>  			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>  
> -		if (!hc->var_cnt && !all_cpus)
> +		if (all_cpus)
> +			goto do_flush;

You could've probably done:

	if (all_cpus) {
		kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH_GUEST);
		goto ret_success;
	}

to get rid on the second 'all_cpus' check (and maybe even 'do_flush'
label with some extra work) below.

> +
> +		if (!hc->var_cnt)
>  			goto ret_success;
>  
> -		if (!all_cpus) {
> -			if (hc->fast) {
> -				if (hc->var_cnt > HV_HYPERCALL_MAX_XMM_REGISTERS - 1)
> -					return HV_STATUS_INVALID_HYPERCALL_INPUT;
> -				for (i = 0; i < hc->var_cnt; i += 2) {
> -					sparse_banks[i] = sse128_lo(hc->xmm[i / 2 + 1]);
> -					sparse_banks[i + 1] = sse128_hi(hc->xmm[i / 2 + 1]);
> -				}
> -			} else {
> -				if (hc->var_cnt > 64)
> -					return HV_STATUS_INVALID_HYPERCALL_INPUT;
> -
> -				gpa = hc->ingpa + offsetof(struct hv_tlb_flush_ex,
> -							   hv_vp_set.bank_contents);
> -				if (unlikely(kvm_read_guest(kvm, gpa, sparse_banks,
> -							    hc->var_cnt *
> -							    sizeof(sparse_banks[0]))))
> -					return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +		if (hc->fast) {
> +			if (hc->var_cnt > HV_HYPERCALL_MAX_XMM_REGISTERS - 1)
> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +			for (i = 0; i < hc->var_cnt; i += 2) {
> +				sparse_banks[i] = sse128_lo(hc->xmm[i / 2 + 1]);
> +				sparse_banks[i + 1] = sse128_hi(hc->xmm[i / 2 + 1]);
>  			}
> +			goto do_flush;
>  		}
> +
> +		if (hc->var_cnt > 64)
> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +		gpa = hc->ingpa + offsetof(struct hv_tlb_flush_ex,
> +					   hv_vp_set.bank_contents);
> +		if (unlikely(kvm_read_guest(kvm, gpa, sparse_banks,
> +					    hc->var_cnt * sizeof(sparse_banks[0]))))
> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>  	}
>  
> +do_flush:
>  	/*
>  	 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we can't
>  	 * analyze it here, flush TLB regardless of the specified address space.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

