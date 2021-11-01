Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8844196E
	for <lists+linux-arch@lfdr.de>; Mon,  1 Nov 2021 11:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhKAKI6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Nov 2021 06:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231485AbhKAKIw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Nov 2021 06:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635761179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=18QPYxfT1WT9tgdoVj5TAKWgZjx+KE5glP+g0+mRzAM=;
        b=Foh1hA8rEfRjF1tx+n9ECiINo5cOgFV9frhZIEpIC6FLZqVOYapVuGIUX3zfdj+Wg+q78M
        CqViWP/W+3OAezRwcWEeA5muce2wv8sMcZk+B8Bg12kAhlEag6jGOjgxNhnva7muJ/4Qu+
        JzUZRsEWgwyxrSL0ScU7eRqGN74Q4xA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-V--e-EUaPA6MUdI-RjDa1w-1; Mon, 01 Nov 2021 06:06:17 -0400
X-MC-Unique: V--e-EUaPA6MUdI-RjDa1w-1
Received: by mail-ed1-f71.google.com with SMTP id f4-20020a50e084000000b003db585bc274so15029640edl.17
        for <linux-arch@vger.kernel.org>; Mon, 01 Nov 2021 03:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=18QPYxfT1WT9tgdoVj5TAKWgZjx+KE5glP+g0+mRzAM=;
        b=xRqMrLnpJcWKkt4U6nTv2Hvcmj7aUN7XPbt+6QG6XxUbYpmAP6l5Oj1/NHtjvV4XLo
         shp0M5zVt5VO3kId+YrP5MKKhmCmWBiduEuvZFsgmCh/csYSzu66bxvPq7+C8JhWRt35
         1iwpIMnBNEmXwzYZ7oO8ueCHPkW/dffmAE26p6zH03QW3nbDsrYLNoEeHYXri5C/CJWb
         PDF2br1wYTlHwZwY1tNZulkR4ZDg5hQpvDO+lS8FZofH06+HKP64uNka9BD9nLiaYIkh
         xANOkh7ehulEZv1OpsQWQLtpWCqXnLPurj4G/I4PXu6i9VepmHQy5++iISNfA3aJhQlv
         9kfg==
X-Gm-Message-State: AOAM531f7skrKg37n6vmGA8sv/REf8ovdVmX/l3KNky/4kQ6/3U05lY6
        Q5tlp/Rwhf00PtMew7uZjK+VWXpFe5hT63z2DVuM3uooenWr1V9xIKO65yo5NCe7ykbOC0lob3U
        MioATsguvsfb+Wtjiqb2eyQ==
X-Received: by 2002:a17:906:dc94:: with SMTP id cs20mr33549416ejc.367.1635761176699;
        Mon, 01 Nov 2021 03:06:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfN2G8/Ae5z/aTn7JJ5WbBJnJbURvnf+kEMvCoI+qwOW7Aq4eOHk1iVqP0JVsYDT7DUBHS1g==
X-Received: by 2002:a17:906:dc94:: with SMTP id cs20mr33549397ejc.367.1635761176541;
        Mon, 01 Nov 2021 03:06:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t18sm9057560edd.18.2021.11.01.03.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 03:06:16 -0700 (PDT)
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
Subject: Re: [PATCH v2 4/8] KVM: x86: Add a helper to get the sparse VP_SET
 for IPIs and TLB flushes
In-Reply-To: <20211030000800.3065132-5-seanjc@google.com>
References: <20211030000800.3065132-1-seanjc@google.com>
 <20211030000800.3065132-5-seanjc@google.com>
Date:   Mon, 01 Nov 2021 11:06:14 +0100
Message-ID: <874k8wkx61.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Add a helper, kvm_get_sparse_vp_set(), to handle sanity checks related to
> the VARHEAD field and reading the sparse banks of a VP_SET.  A future
> commit to reduce the memory footprint of sparse_banks will introduce more
> common code to the sparse bank retrieval.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/hyperv.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index e68931ed27f6..3d0981163eed 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1750,10 +1750,19 @@ struct kvm_hv_hcall {
>  	sse128_t xmm[HV_HYPERCALL_MAX_XMM_REGISTERS];
>  };
>  
> +static u64 kvm_get_sparse_vp_set(struct kvm *kvm, struct kvm_hv_hcall *hc,
> +				 u64 *sparse_banks, gpa_t offset)
> +{
> +	if (hc->var_cnt > 64)
> +		return -EINVAL;
> +
> +	return kvm_read_guest(kvm, hc->ingpa + offset, sparse_banks,
> +			      hc->var_cnt * sizeof(*sparse_banks));
> +}
> +
>  static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool ex)
>  {
>  	int i;
> -	gpa_t gpa;
>  	struct kvm *kvm = vcpu->kvm;
>  	struct hv_tlb_flush_ex flush_ex;
>  	struct hv_tlb_flush flush;
> @@ -1830,13 +1839,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  			goto do_flush;
>  		}
>  
> -		if (hc->var_cnt > 64)
> -			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> -
> -		gpa = hc->ingpa + offsetof(struct hv_tlb_flush_ex,
> -					   hv_vp_set.bank_contents);
> -		if (unlikely(kvm_read_guest(kvm, gpa, sparse_banks,
> -					    hc->var_cnt * sizeof(sparse_banks[0]))))
> +		if (kvm_get_sparse_vp_set(kvm, hc, sparse_banks,
> +					  offsetof(struct hv_tlb_flush_ex,
> +						   hv_vp_set.bank_contents)))
>  			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>  	}
>  
> @@ -1933,14 +1938,9 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  		if (!hc->var_cnt)
>  			goto ret_success;
>  
> -		if (hc->var_cnt > 64)
> -			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> -
> -		if (kvm_read_guest(kvm,
> -				   hc->ingpa + offsetof(struct hv_send_ipi_ex,
> -							vp_set.bank_contents),
> -				   sparse_banks,
> -				   hc->var_cnt * sizeof(sparse_banks[0])))
> +		if (kvm_get_sparse_vp_set(kvm, hc, sparse_banks,
> +					  offsetof(struct hv_send_ipi_ex,
> +						   vp_set.bank_contents)))
>  			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>  	}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

