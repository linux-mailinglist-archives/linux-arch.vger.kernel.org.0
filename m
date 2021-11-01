Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670BB441922
	for <lists+linux-arch@lfdr.de>; Mon,  1 Nov 2021 10:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhKAJ4n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Nov 2021 05:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234248AbhKAJyq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Nov 2021 05:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635760332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hTNjHa1TMEqRPhvFHuXK6XSXRxTvytm/OlBhth0P8ak=;
        b=aY103MsCGIYBOOcoX1Kq2nnlJXXCuYKl+0ldpriCphi+3hjjMPzK2sVSaLM8KyeNsjKhsk
        TE+9sadGl7mtMTLME2EqjFPqihpr7+xrarqtGsNX2w0/K0kpTP2WKd9/SQPXKanOM13Npj
        pQo2dHVhSLMIgiH47lMyxx/fXuVTW7Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-6E9uIm4cO4eyZs5jvLKYlQ-1; Mon, 01 Nov 2021 05:52:10 -0400
X-MC-Unique: 6E9uIm4cO4eyZs5jvLKYlQ-1
Received: by mail-ed1-f69.google.com with SMTP id r25-20020a05640216d900b003dca3501ab4so14979245edx.15
        for <linux-arch@vger.kernel.org>; Mon, 01 Nov 2021 02:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hTNjHa1TMEqRPhvFHuXK6XSXRxTvytm/OlBhth0P8ak=;
        b=5oN2xF+M0Djp5IH8AxEodeVH3Htae0qDWw8Jo+kpsQh/scqpdobRqX1o7OhKDRW0o6
         88hUyL8Wgp8yYalux0mGIJrKV4s7Bsxa6kqTb7XzeeK6blT7XhhputNo1h9kTqyab1Eg
         YcBsTOOF4r7zZL8PsTp2aLyXUYRwhEQRREccpPDUVrgimaMpmUrmo55YvWxRNqX5s4ow
         g/hTe0YDL1bVNAtz/aQxtIJ5R//3zSXHIq+ip6JNDRKotEmMg8sQfMWyQj5bacgldgXr
         FW0dPAySBOuTtFKwEWlkvijmhrfK1WXy9ZuFKTz34DWvBuKaZSeQl6N/rdVqvS0neCkK
         /F/Q==
X-Gm-Message-State: AOAM532Uo5fhROJLD8wG5gbYu2CqIZjCc81XeJXaW5R/Oj/jb/yTtHqD
        jZQWt3zlNTtiL9Pm3OPtCpgydDqU4ytT83mVbR/YIv7lGCWW2FaiRfLH/FryP6gW0Po88dSdeOJ
        t1mqBN347pPp+KZjBzu5qYg==
X-Received: by 2002:a05:6402:17c6:: with SMTP id s6mr23826571edy.11.1635760329650;
        Mon, 01 Nov 2021 02:52:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+4wcfkcjbb+BJKXbX8UJhqQo0tsMPIRflgFbUhB0LTkA3bEecXam4YFslJKUNisDfYWgBOQ==
X-Received: by 2002:a05:6402:17c6:: with SMTP id s6mr23826545edy.11.1635760329469;
        Mon, 01 Nov 2021 02:52:09 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j11sm6624691ejt.114.2021.11.01.02.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 02:52:08 -0700 (PDT)
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
Subject: Re: [PATCH v2 2/8] KVM: x86: Get the number of Hyper-V sparse banks
 from the VARHEAD field
In-Reply-To: <20211030000800.3065132-3-seanjc@google.com>
References: <20211030000800.3065132-1-seanjc@google.com>
 <20211030000800.3065132-3-seanjc@google.com>
Date:   Mon, 01 Nov 2021 10:52:07 +0100
Message-ID: <87a6iokxtk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Get the number of sparse banks from the VARHEAD field, which the guest is
> required to provide as "The size of a variable header, in QWORDS.", where
> the variable header is:
>
>   Variable Header Bytes = {Total Header Bytes - sizeof(Fixed Header)}
>                           rounded up to nearest multiple of 8
>   Variable HeaderSize = Variable Header Bytes / 8
>
> In other words, the VARHEAD should match the number of sparse banks.
> Keep the manual count as a sanity check, but otherwise rely on the field
> so as to more closely align with the logic defined in the TLFS and to
> allow for future cleanups.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/hyperv.c             | 35 ++++++++++++++++++-------------
>  arch/x86/kvm/trace.h              | 14 +++++++------
>  include/asm-generic/hyperv-tlfs.h |  1 +
>  3 files changed, 30 insertions(+), 20 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 814d1a1f2cb8..cf18aa1712bf 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1742,6 +1742,7 @@ struct kvm_hv_hcall {
>  	u64 ingpa;
>  	u64 outgpa;
>  	u16 code;
> +	u16 var_cnt;
>  	u16 rep_cnt;
>  	u16 rep_idx;
>  	bool fast;
> @@ -1761,7 +1762,6 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  	unsigned long *vcpu_mask;
>  	u64 valid_bank_mask;
>  	u64 sparse_banks[64];
> -	int sparse_banks_len;
>  	bool all_cpus;
>  
>  	if (!ex) {
> @@ -1811,24 +1811,28 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  		all_cpus = flush_ex.hv_vp_set.format !=
>  			HV_GENERIC_SET_SPARSE_4K;
>  
> -		sparse_banks_len = bitmap_weight((unsigned long *)&valid_bank_mask, 64);
> +		if (hc->var_cnt != bitmap_weight((unsigned long *)&valid_bank_mask, 64))
> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;

Let's hope Windows doesn't break this ruls when vp_set.format != HV_GENERIC_SET_SPARSE_4K

>  
> -		if (!sparse_banks_len && !all_cpus)
> +		if (!hc->var_cnt && !all_cpus)
>  			goto ret_success;
>  
>  		if (!all_cpus) {
>  			if (hc->fast) {
> -				if (sparse_banks_len > HV_HYPERCALL_MAX_XMM_REGISTERS - 1)
> +				if (hc->var_cnt > HV_HYPERCALL_MAX_XMM_REGISTERS - 1)
>  					return HV_STATUS_INVALID_HYPERCALL_INPUT;
> -				for (i = 0; i < sparse_banks_len; i += 2) {
> +				for (i = 0; i < hc->var_cnt; i += 2) {
>  					sparse_banks[i] = sse128_lo(hc->xmm[i / 2 + 1]);
>  					sparse_banks[i + 1] = sse128_hi(hc->xmm[i / 2 + 1]);
>  				}
>  			} else {
> +				if (hc->var_cnt > 64)
> +					return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
>  				gpa = hc->ingpa + offsetof(struct hv_tlb_flush_ex,
>  							   hv_vp_set.bank_contents);
>  				if (unlikely(kvm_read_guest(kvm, gpa, sparse_banks,
> -							    sparse_banks_len *
> +							    hc->var_cnt *
>  							    sizeof(sparse_banks[0]))))
>  					return HV_STATUS_INVALID_HYPERCALL_INPUT;
>  			}
> @@ -1884,7 +1888,6 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  	unsigned long *vcpu_mask;
>  	unsigned long valid_bank_mask;
>  	u64 sparse_banks[64];
> -	int sparse_banks_len;
>  	u32 vector;
>  	bool all_cpus;
>  
> @@ -1917,22 +1920,25 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>  
>  		vector = send_ipi_ex.vector;
>  		valid_bank_mask = send_ipi_ex.vp_set.valid_bank_mask;
> -		sparse_banks_len = bitmap_weight(&valid_bank_mask, 64) *
> -			sizeof(sparse_banks[0]);
> -
>  		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
>  
> +		if (hc->var_cnt != bitmap_weight(&valid_bank_mask, 64))
> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
>  		if (all_cpus)
>  			goto check_and_send_ipi;
>  
> -		if (!sparse_banks_len)
> +		if (!hc->var_cnt)
>  			goto ret_success;
>  
> +		if (hc->var_cnt > 64)
> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
>  		if (kvm_read_guest(kvm,
>  				   hc->ingpa + offsetof(struct hv_send_ipi_ex,
>  							vp_set.bank_contents),
>  				   sparse_banks,
> -				   sparse_banks_len))
> +				   hc->var_cnt * sizeof(sparse_banks[0])))
>  			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>  	}
>  
> @@ -2190,13 +2196,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  	}
>  
>  	hc.code = hc.param & 0xffff;
> +	hc.var_cnt = (hc.param & HV_HYPERCALL_VARHEAD_MASK) >> HV_HYPERCALL_VARHEAD_OFFSET;
>  	hc.fast = !!(hc.param & HV_HYPERCALL_FAST_BIT);
>  	hc.rep_cnt = (hc.param >> HV_HYPERCALL_REP_COMP_OFFSET) & 0xfff;
>  	hc.rep_idx = (hc.param >> HV_HYPERCALL_REP_START_OFFSET) & 0xfff;
>  	hc.rep = !!(hc.rep_cnt || hc.rep_idx);
>  
> -	trace_kvm_hv_hypercall(hc.code, hc.fast, hc.rep_cnt, hc.rep_idx,
> -			       hc.ingpa, hc.outgpa);
> +	trace_kvm_hv_hypercall(hc.code, hc.fast, hc.var_cnt, hc.rep_cnt,
> +			       hc.rep_idx, hc.ingpa, hc.outgpa);
>  
>  	if (unlikely(!hv_check_hypercall_access(hv_vcpu, hc.code))) {
>  		ret = HV_STATUS_ACCESS_DENIED;
> diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> index 953b0fcb21ee..f6625cfb686c 100644
> --- a/arch/x86/kvm/trace.h
> +++ b/arch/x86/kvm/trace.h
> @@ -64,9 +64,9 @@ TRACE_EVENT(kvm_hypercall,
>   * Tracepoint for hypercall.
>   */
>  TRACE_EVENT(kvm_hv_hypercall,
> -	TP_PROTO(__u16 code, bool fast, __u16 rep_cnt, __u16 rep_idx,
> -		 __u64 ingpa, __u64 outgpa),
> -	TP_ARGS(code, fast, rep_cnt, rep_idx, ingpa, outgpa),
> +	TP_PROTO(__u16 code, bool fast,  __u16 var_cnt, __u16 rep_cnt,
> +		 __u16 rep_idx, __u64 ingpa, __u64 outgpa),
> +	TP_ARGS(code, fast, var_cnt, rep_cnt, rep_idx, ingpa, outgpa),
>  
>  	TP_STRUCT__entry(
>  		__field(	__u16,		rep_cnt		)
> @@ -74,6 +74,7 @@ TRACE_EVENT(kvm_hv_hypercall,
>  		__field(	__u64,		ingpa		)
>  		__field(	__u64,		outgpa		)
>  		__field(	__u16, 		code		)
> +		__field(	__u16,		var_cnt		)
>  		__field(	bool,		fast		)
>  	),
>  
> @@ -83,13 +84,14 @@ TRACE_EVENT(kvm_hv_hypercall,
>  		__entry->ingpa		= ingpa;
>  		__entry->outgpa		= outgpa;
>  		__entry->code		= code;
> +		__entry->var_cnt	= var_cnt;
>  		__entry->fast		= fast;
>  	),
>  
> -	TP_printk("code 0x%x %s cnt 0x%x idx 0x%x in 0x%llx out 0x%llx",
> +	TP_printk("code 0x%x %s var_cnt 0x%x cnt 0x%x idx 0x%x in 0x%llx out 0x%llx",

Nit: 'cnt' is (and was) a bit ambiguous, I'd suggest to explicitly say
'rep_cnt' (and probably 'rep_idx') instead.

>  		  __entry->code, __entry->fast ? "fast" : "slow",
> -		  __entry->rep_cnt, __entry->rep_idx,  __entry->ingpa,
> -		  __entry->outgpa)
> +		  __entry->var_cnt, __entry->rep_cnt, __entry->rep_idx,
> +		  __entry->ingpa, __entry->outgpa)
>  );
>  
>  TRACE_EVENT(kvm_hv_hypercall_done,
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 56348a541c50..1ba8e6da4427 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -182,6 +182,7 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
>  #define HV_HYPERCALL_FAST_BIT		BIT(16)
>  #define HV_HYPERCALL_VARHEAD_OFFSET	17
> +#define HV_HYPERCALL_VARHEAD_MASK	GENMASK_ULL(26, 17)
>  #define HV_HYPERCALL_REP_COMP_OFFSET	32
>  #define HV_HYPERCALL_REP_COMP_1		BIT_ULL(32)
>  #define HV_HYPERCALL_REP_COMP_MASK	GENMASK_ULL(43, 32)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

