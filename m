Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC6D4415D2
	for <lists+linux-arch@lfdr.de>; Mon,  1 Nov 2021 10:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhKAJIE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Nov 2021 05:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231284AbhKAJIE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Nov 2021 05:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635757530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oJkAFyRt9v715bpa/NX3/kOGqMNkyMnpxgW0861jlMc=;
        b=SqQ9eFDSS1AFQaKgBriHbQZZaawnfDa4tn9rQw+sAwQBiyT3wdddAsiNvf2pmuSMqvfJNM
        RYYmnIotH6p++zOkXD+1MnJuj1L3n/TngDIcKOSSFlnSt3oCBaKtBPspQBcgDPBNYSxkDs
        oIGcnS6W1B4ePVvjy/ZJDnB0ac4dGEA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-RQO-KV3tMJi7mapNB1wBNw-1; Mon, 01 Nov 2021 05:05:29 -0400
X-MC-Unique: RQO-KV3tMJi7mapNB1wBNw-1
Received: by mail-ed1-f72.google.com with SMTP id q6-20020a056402518600b003e28d92bb85so1568333edd.7
        for <linux-arch@vger.kernel.org>; Mon, 01 Nov 2021 02:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=oJkAFyRt9v715bpa/NX3/kOGqMNkyMnpxgW0861jlMc=;
        b=3gDQL5P/zWmsqWLyXFBK1ZceShO614sBoyjUAefhxWwQa/KtIbRdkGSGVK2h3A2+al
         /A5rjz/N4MgmtEY2O0ekVDW2tH28uObUcHH75qRpHFmxuEYsEsX72VukyPT6O0/Y+0QL
         1m0v0e3/Kja17tKrJzV9XB4iqnqnk21wiplDtADd9PoergK94IcCwwm7r0kVXomwydc1
         jq4o81RGKdLJy0DCuqQaNylLjZqpf5SN9/RMzVgZV6zJlBih94Gdnb+OBn3p+V8F6wHX
         K5PTfSOxlwekAPqt2S/oouVb6xH3d9w9oDhspiy6/Vs50iTVZkdVRAVQAE9h/HRNzbZI
         rv0A==
X-Gm-Message-State: AOAM530ovhwJqBSxQClae7XYUMamwKQeNS1FK7IcIr+6wnx29IAPiXl7
        U55DNoFT/ZjWUC0WjmfI+5T86Cbwk6+PR0f84rqETdcFjRwkJHVp0HngpIXF1/MZnHkWzarwEXu
        ZFrPiPAwNHLhz6jsMVY6l+A==
X-Received: by 2002:a17:907:608a:: with SMTP id ht10mr35693004ejc.87.1635757528766;
        Mon, 01 Nov 2021 02:05:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdkY5BIy5ecCVKvM3pPRDxiKUkcku/Q5czr9Wv9jsuPuhKroZuSkjfX+DBGbBGwLtRsiGrXw==
X-Received: by 2002:a17:907:608a:: with SMTP id ht10mr35692964ejc.87.1635757528502;
        Mon, 01 Nov 2021 02:05:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q2sm6629752eje.118.2021.11.01.02.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 02:05:27 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>
Subject: Re: [PATCH v2 1/8] KVM: x86: Ignore sparse banks size for an "all
 CPUs", non-sparse IPI req
In-Reply-To: <20211030000800.3065132-2-seanjc@google.com>
References: <20211030000800.3065132-1-seanjc@google.com>
 <20211030000800.3065132-2-seanjc@google.com>
Date:   Mon, 01 Nov 2021 10:05:26 +0100
Message-ID: <87fssgkzzd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Do not bail early if there are no bits set in the sparse banks for a
> non-sparse, a.k.a. "all CPUs", IPI request.  Per the Hyper-V spec, it is
> legal to have a variable length of '0', e.g. VP_SET's BankContents in
> this case, if the request can be serviced without the extra info.
>
>   It is possible that for a given invocation of a hypercall that does
>   accept variable sized input headers that all the header input fits
>   entirely within the fixed size header. In such cases the variable sized
>   input header is zero-sized and the corresponding bits in the hypercall
>   input should be set to zero.
>
> Bailing early results in KVM failing to send IPIs to all CPUs as expected
> by the guest.
>
> Fixes: 214ff83d4473 ("KVM: x86: hyperv: implement PV IPI send hypercalls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/hyperv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 4f15c0165c05..814d1a1f2cb8 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1922,11 +1922,13 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  
>  		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
>  
> +		if (all_cpus)
> +			goto check_and_send_ipi;
> +
>  		if (!sparse_banks_len)
>  			goto ret_success;
>  
> -		if (!all_cpus &&
> -		    kvm_read_guest(kvm,
> +		if (kvm_read_guest(kvm,
>  				   hc->ingpa + offsetof(struct hv_send_ipi_ex,
>  							vp_set.bank_contents),
>  				   sparse_banks,
> @@ -1934,6 +1936,7 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>  	}
>  
> +check_and_send_ipi:
>  	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
>  		return HV_STATUS_INVALID_HYPERCALL_INPUT;

Nice catch! It's possible that genuine Windows/Hyper-V guests never hit
the bug because they don't use 'ex' version to send IPIs to all CPUs. It
is also possible that Windows/Hyper-V guests with > 64 vCPUs are just
undertested.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

