Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14D44418CD
	for <lists+linux-arch@lfdr.de>; Mon,  1 Nov 2021 10:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhKAJvl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Nov 2021 05:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232988AbhKAJta (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Nov 2021 05:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635760017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GCQW+jtyc2XjG8UWnT8I+n1wYys3/xqxOYsbCwWgH3Y=;
        b=dk1DvFndzErJUCR769Yc6TvwShnR479wsxx46vNtLArpUE4O/AtBTZD6QwkfQ3AU1+Z73e
        em6fAjDtGxk0pscJZ3sTI5GAnmsOo5lHkOkv333E00V4pPw2Lt/rOouWtSQ2F7Zkm2WPQh
        iXjzDx4nI49AMYZka/rnobXW/WmBmXU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-LFvgtY_oPJyEv0l2b8lNNw-1; Mon, 01 Nov 2021 05:46:56 -0400
X-MC-Unique: LFvgtY_oPJyEv0l2b8lNNw-1
Received: by mail-ed1-f70.google.com with SMTP id m16-20020a056402431000b003dd2005af01so15022106edc.5
        for <linux-arch@vger.kernel.org>; Mon, 01 Nov 2021 02:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GCQW+jtyc2XjG8UWnT8I+n1wYys3/xqxOYsbCwWgH3Y=;
        b=ed+m6WZQUehuUSrsVXUdEE7UqErW35o66MOpp+KQM5s4zOYy+YYg6/JoOnVCWrZlW+
         79PWqwkRF4SB0TU8P9nao7klbfqgZvc70FcU7fLdM7LOhJDslZMv7RRWP2JRmHAMvcVc
         AKxnopCcPgb6wABqJd9ZuT8JHWOhVgyex9UTfPCZES0jsorEn5uc/8OTw2d+MMElfVWe
         EIznQb9zPlugw1t7rjhp+UO2LFSJNVaLwDhzPS/GxED8IEXGtrhRLB9Pl3T43tJ8fs2l
         BT6eRqp33AI4h/SzIvd0v/9CSJfcJawlWID2ekCjfBuvlqiv2kLBktg4EIcTLdrF5XZ6
         o6Tg==
X-Gm-Message-State: AOAM533h+p7eoRxYRzTDPHW5z6Jo/63Yx+U9PHF/yBzUoAnQ3eiI8U5U
        ylcLch8LAvZdx9DucjzCbv78wVIVBElEEC96qqUWgTqpSrH/mDCrjS+SbhlnEWGsQfsxFGSDXMx
        CWQmRpb9Xj+CQICnVBVvFuw==
X-Received: by 2002:a17:906:3ac6:: with SMTP id z6mr35445476ejd.196.1635760014520;
        Mon, 01 Nov 2021 02:46:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxejlhpYXWU9PII72c+LiDvOdFySsKViVbsnUuc9wubsgDsL/nqusncIRxzQXqTz90uOamjhQ==
X-Received: by 2002:a17:906:3ac6:: with SMTP id z6mr35445442ejd.196.1635760014308;
        Mon, 01 Nov 2021 02:46:54 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id me7sm3921028ejb.33.2021.11.01.02.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 02:46:53 -0700 (PDT)
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
Subject: Re: [PATCH v2 5/8] KVM: x86: Don't bother reading sparse banks that
 end up being ignored
In-Reply-To: <20211030000800.3065132-6-seanjc@google.com>
References: <20211030000800.3065132-1-seanjc@google.com>
 <20211030000800.3065132-6-seanjc@google.com>
Date:   Mon, 01 Nov 2021 10:46:52 +0100
Message-ID: <87bl34ky2b.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> When handling "sparse" VP_SET requests, don't read sparse banks that
> can't possibly contain a legal VP index instead of ignoring such banks
> later on in sparse_set_to_vcpu_mask().  This allows KVM to cap the size
> of its sparse_banks arrays for VP_SET at KVM_HV_MAX_SPARSE_VCPU_SET_BITS.
>
> Reducing the size of sparse_banks fudges around a compilation warning
> (that becomes error with KVM_WERROR=y) when CONFIG_KASAN_STACK=y, which
> is selected (and can't be unselected) by CONFIG_KASAN=y when using gcc
> (clang/LLVM is a stack hog in some cases so it's opt-in for clang).
> KASAN_STACK adds a redzone around every stack variable, which pushes the
> Hyper-V functions over the default limit of 1024.
>
> Ideally, KVM would flat out reject such impossibilities, but the TLFS
> explicitly allows providing empty banks, even if a bank can't possibly
> contain a valid VP index due to its position exceeding KVM's max.
>
>   Furthermore, for a bit 1 in ValidBankMask, it is valid state for the
>   corresponding element in BanksContents can be all 0s, meaning no
>   processors are specified in this bank.
>
> Arguably KVM should reject and not ignore the "extra" banks, but that can
> be done independently and without bloating sparse_banks, e.g. by reading
> each "extra" 8-byte chunk individually.
>
> Reported-by: Ajay Garg <ajaygargnsit@gmail.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/hyperv.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 3d0981163eed..8832727d74d9 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1753,11 +1753,16 @@ struct kvm_hv_hcall {
>  static u64 kvm_get_sparse_vp_set(struct kvm *kvm, struct kvm_hv_hcall *hc,
>  				 u64 *sparse_banks, gpa_t offset)
>  {
> +	u16 var_cnt;
> +
>  	if (hc->var_cnt > 64)
>  		return -EINVAL;
>  
> +	/* Ignore banks that cannot possibly contain a legal VP index. */
> +	var_cnt = min_t(u16, hc->var_cnt, KVM_HV_MAX_SPARSE_VCPU_SET_BITS);
> +

One may wonder why we're mixing up VP indices and VCPU ids (caped by
KVM_MAX_VCPUS) here as these don't have to match. The following commit
sheds some light:

commit 9170200ec0ebad70e5b9902bc93e2b1b11456a3b
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Wed Aug 22 12:18:28 2018 +0200

    KVM: x86: hyperv: enforce vp_index < KVM_MAX_VCPUS
    
    Hyper-V TLFS (5.0b) states:
    
    > Virtual processors are identified by using an index (VP index). The
    > maximum number of virtual processors per partition supported by the
    > current implementation of the hypervisor can be obtained through CPUID
    > leaf 0x40000005. A virtual processor index must be less than the
    > maximum number of virtual processors per partition.
    
    Forbid userspace to set VP_INDEX above KVM_MAX_VCPUS. get_vcpu_by_vpidx()
    can now be optimized to bail early when supplied vpidx is >= KVM_MAX_VCPUS.

>  	return kvm_read_guest(kvm, hc->ingpa + offset, sparse_banks,
> -			      hc->var_cnt * sizeof(*sparse_banks));
> +			      var_cnt * sizeof(*sparse_banks));
>  }
>  
>  static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool ex)
> @@ -1770,7 +1775,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
>  	unsigned long *vcpu_mask;
>  	u64 valid_bank_mask;
> -	u64 sparse_banks[64];
> +	u64 sparse_banks[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
>  	bool all_cpus;
>  
>  	if (!ex) {
> @@ -1894,7 +1899,7 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
>  	unsigned long *vcpu_mask;
>  	unsigned long valid_bank_mask;
> -	u64 sparse_banks[64];
> +	u64 sparse_banks[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
>  	u32 vector;
>  	bool all_cpus;

Saves the day until KVM_MAX_VCPUS goes above 4096 (and when it does the
problem strikes back even worse as KVM_HV_MAX_SPARSE_VCPU_SET_BITS is
not caped at '64'). As we're good for now,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

(I'd even suggest we add BUILD_BUG_ON(KVM_HV_MAX_SPARSE_VCPU_SET_BITS > 64))

Going forward, we can probably get rid of thes on-stack allocations
completely by either allocating these 512 bytes dynamically (lazily)
upon first usage or just adding a field to 'struct kvm_vcpu_hv' -- which
is being allcated dynamically nowadays so non-Windows guests won't suffer.

-- 
Vitaly

