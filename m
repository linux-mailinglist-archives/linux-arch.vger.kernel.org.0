Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84794419DB
	for <lists+linux-arch@lfdr.de>; Mon,  1 Nov 2021 11:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhKAKaQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Nov 2021 06:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232079AbhKAKaN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Nov 2021 06:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635762459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2uCAdP1QdrurNg3VYXaeroiWVBLb/WhdrZPNJcrlkas=;
        b=MQzhnsEEl4mSJQx7nykcpC1Gkaq9Sn2kse3zTfcLtk2SMeJn6j5PTz63LOTRYZFzu4svXh
        qTgFl/xEHUVefzOwvjd7r6nBq7mzopa29eMGUIviuY63kFOlz+UdJqmTqla2mqIlkC/+ow
        NLvC0mgTXgO2c3+9CXETogYxESCz1Gw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-5GdGCL0eM7SZGeszfZ5JnQ-1; Mon, 01 Nov 2021 06:27:38 -0400
X-MC-Unique: 5GdGCL0eM7SZGeszfZ5JnQ-1
Received: by mail-ed1-f72.google.com with SMTP id s18-20020a056402521200b003dd5902f4f3so15075050edd.23
        for <linux-arch@vger.kernel.org>; Mon, 01 Nov 2021 03:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2uCAdP1QdrurNg3VYXaeroiWVBLb/WhdrZPNJcrlkas=;
        b=cbQqxYvEhl5oqGZVPpPJ1lOefhC5yprYNfCVFh1SlyTZTtW7UYFiYtlgZ93igXnjBc
         tgbvNoem65ItsW5z11h5+l9XSuum42kjp9Xyap55oYBo+lPXrUD7JL3bl8UO3T/fp1ir
         s9LzWyDrTODlRs8f+kOrNQQs7MkBaEYFXAtiYl0RuERIjfqlEuk8EdiJm1L3X3GUYxYI
         yLeN4SkEf6hnNlnmfmM4PGKHR05nRsBujIvDDWFEJfvIdnjo79XA15zDLmg8sp1QHy9F
         bBq8CmV0xvaB6QlfyJ2rmfNYzUXABKYOREPu8wY1003vrxN3mYBpd/MrX9LNBcCf92LA
         TLWQ==
X-Gm-Message-State: AOAM531eltbDuR/yEKUhjJFuCCWDHRUGjoABIhYe9P5O7EwPPDT5QY8m
        XoClSET4ptpxhUMUIYGnwWx6XeUTe8wK4PMVaYPmR1Kl3fwTETXTJe5bqExrmIbzme6xmh164G0
        cDmSWTh6lWWoI4N537yzyWA==
X-Received: by 2002:a17:907:3e0a:: with SMTP id hp10mr5140859ejc.318.1635762456893;
        Mon, 01 Nov 2021 03:27:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjZIaZvRfLbelCks3Bnp4YpkcYtDKg2/JML94gJgBsswZs4QJjAUtfEbZjra2xURRbQh3eqA==
X-Received: by 2002:a17:907:3e0a:: with SMTP id hp10mr5140840ejc.318.1635762456689;
        Mon, 01 Nov 2021 03:27:36 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z9sm9254464edb.70.2021.11.01.03.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 03:27:36 -0700 (PDT)
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
Subject: Re: [PATCH v2 7/8] KVM: x86: Reject fixeds-size Hyper-V hypercalls
 with non-zero "var_cnt"
In-Reply-To: <20211030000800.3065132-8-seanjc@google.com>
References: <20211030000800.3065132-1-seanjc@google.com>
 <20211030000800.3065132-8-seanjc@google.com>
Date:   Mon, 01 Nov 2021 11:27:34 +0100
Message-ID: <87y268jhm1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Reject Hyper-V hypercalls if the guest specifies a non-zero variable size
> header (var_cnt in KVM) for a hypercall that has a fixed header size.
> Per the TLFS:
>
>   It is illegal to specify a non-zero variable header size for a
>   hypercall that is not explicitly documented as accepting variable sized
>   input headers. In such a case the hypercall will result in a return
>   code of HV_STATUS_INVALID_HYPERCALL_INPUT.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/hyperv.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 3d83d6a5d337..ad455df850c9 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2241,14 +2241,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  
>  	switch (hc.code) {
>  	case HVCALL_NOTIFY_LONG_SPIN_WAIT:
> -		if (unlikely(hc.rep)) {
> +		if (unlikely(hc.rep || hc.var_cnt)) {
>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>  			break;
>  		}
>  		kvm_vcpu_on_spin(vcpu, true);
>  		break;
>  	case HVCALL_SIGNAL_EVENT:
> -		if (unlikely(hc.rep)) {
> +		if (unlikely(hc.rep || hc.var_cnt)) {
>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>  			break;
>  		}
> @@ -2258,7 +2258,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  		fallthrough;	/* maybe userspace knows this conn_id */
>  	case HVCALL_POST_MESSAGE:
>  		/* don't bother userspace if it has no way to handle it */
> -		if (unlikely(hc.rep || !to_hv_synic(vcpu)->active)) {
> +		if (unlikely(hc.rep || hc.var_cnt || !to_hv_synic(vcpu)->active)) {
>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>  			break;
>  		}
> @@ -2271,14 +2271,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  				kvm_hv_hypercall_complete_userspace;
>  		return 0;
>  	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST:
> -		if (unlikely(!hc.rep_cnt || hc.rep_idx)) {
> +		if (unlikely(!hc.rep_cnt || hc.rep_idx || hc.var_cnt)) {
>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>  			break;
>  		}
>  		ret = kvm_hv_flush_tlb(vcpu, &hc, false);
>  		break;
>  	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE:
> -		if (unlikely(hc.rep)) {
> +		if (unlikely(hc.rep || hc.var_cnt)) {
>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>  			break;
>  		}
> @@ -2299,7 +2299,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  		ret = kvm_hv_flush_tlb(vcpu, &hc, true);
>  		break;
>  	case HVCALL_SEND_IPI:
> -		if (unlikely(hc.rep)) {
> +		if (unlikely(hc.rep || hc.var_cnt)) {
>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>  			break;
>  		}
> @@ -2331,6 +2331,11 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  			ret = HV_STATUS_OPERATION_DENIED;
>  			break;
>  		}
> +		if (unlikely(hc.var_cnt)) {
> +			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
> +			break;
> +		}
> +

Probably true for HVCALL_RESET_DEBUG_SESSION but I'm not sure about
HVCALL_POST_DEBUG_DATA/HVCALL_RETRIEVE_DEBUG_DATA (note 'fallthrough'
above) -- these are not described well in TLFS.

>  		vcpu->run->exit_reason = KVM_EXIT_HYPERV;
>  		vcpu->run->hyperv.type = KVM_EXIT_HYPERV_HCALL;
>  		vcpu->run->hyperv.u.hcall.input = hc.param;

-- 
Vitaly

