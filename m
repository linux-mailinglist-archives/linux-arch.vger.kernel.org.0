Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025D646E774
	for <lists+linux-arch@lfdr.de>; Thu,  9 Dec 2021 12:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbhLILXC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Dec 2021 06:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbhLILXB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Dec 2021 06:23:01 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874DBC061746;
        Thu,  9 Dec 2021 03:19:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l25so18337477eda.11;
        Thu, 09 Dec 2021 03:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RnU+rP4uCTr6P8oEgOcRXDBdIESpkJPuoCfcVUUK34M=;
        b=Xh992WFzH4MhJUZLBr9tcGDh23qfJikwz/IvzskW76tt72Ifblid2wurAorqOC8hvv
         vzKun4NdrEVvHrONF1fdgvVsy83GtFacqrrs1Yj3VAH/5upd1OV2ES9hbBOzoCqwxXcE
         yXZX5tnjkQ0qaFlRgzMKECE16T4llhZdykODllsq9/ar+p9janqaL5E/M0QE2SjyRy1s
         2EETUWO9cnYHxLMHv6z5wvpYGVNMnVBJ5UPTBi6KF4PZrrlONeThqpJkq0LVlIvBEBFw
         HhBsE04QcjYHAAxt5NFSlljMXYaKh4mzBZONmaWCM2H/IQJ60ipdVK8Jfk78I1Mo/BmG
         P86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RnU+rP4uCTr6P8oEgOcRXDBdIESpkJPuoCfcVUUK34M=;
        b=KbzlRG96Kct5PcosvbMyaHWP/FxqedcLi20N5a68Pe5Oj8+HQBal+WjL+KXP/yX/fx
         GoN3UzZZghuYolnjCY0hPo8ygRHmC0l5NJXYNBS/EAfvCvp5Uvyg2hmspKxh7LyPigHU
         o3zh8Ly8/aOJqwAnCQXE7v6EdhZSMD413jxnTWwRDas3PxegGeVFQP8Ct47Di3iSVoWi
         b1xbu44vLoU10Ilf9aYxtpXIp3jycghtzIOMCkGFar14TE3vud8ReJlV0VNECax6HzwB
         WfnqNSesCOfjQ0SzDN+iBUz7FT8JFFrxKcl4d09g/AFTUaeC/RY6TWGdz7NZDWBu5aK0
         OWuQ==
X-Gm-Message-State: AOAM530JfWfARHadoF5O14SYo3WHaxN5ecxnYrUXhp2tDXuQqetS7Fdl
        WDei1GtA71PC16tXYneQ8cc=
X-Google-Smtp-Source: ABdhPJwEU1ngcnTsLg9XxUFDRE+jTY35YTNAHUK30/3k2A7n01CrW1W7VVc4cid86TEx4q65U66VcQ==
X-Received: by 2002:a17:906:1599:: with SMTP id k25mr14866135ejd.298.1639048766964;
        Thu, 09 Dec 2021 03:19:26 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id h7sm3629139edb.89.2021.12.09.03.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 03:19:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <d1a40c83-0120-7fc7-0e9c-7e445751520c@redhat.com>
Date:   Thu, 9 Dec 2021 12:19:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 1/8] KVM: x86: Ignore sparse banks size for an "all
 CPUs", non-sparse IPI req
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>
References: <20211207220926.718794-1-seanjc@google.com>
 <20211207220926.718794-2-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211207220926.718794-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/7/21 23:09, Sean Christopherson wrote:
> Do not bail early if there are no bits set in the sparse banks for a
> non-sparse, a.k.a. "all CPUs", IPI request.  Per the Hyper-V spec, it is
> legal to have a variable length of '0', e.g. VP_SET's BankContents in
> this case, if the request can be serviced without the extra info.
> 
>    It is possible that for a given invocation of a hypercall that does
>    accept variable sized input headers that all the header input fits
>    entirely within the fixed size header. In such cases the variable sized
>    input header is zero-sized and the corresponding bits in the hypercall
>    input should be set to zero.
> 
> Bailing early results in KVM failing to send IPIs to all CPUs as expected
> by the guest.
> 
> Fixes: 214ff83d4473 ("KVM: x86: hyperv: implement PV IPI send hypercalls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   arch/x86/kvm/hyperv.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 7179fa645eda..58f35498578f 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1923,11 +1923,13 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>   
>   		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
>   
> +		if (all_cpus)
> +			goto check_and_send_ipi;
> +
>   		if (!sparse_banks_len)
>   			goto ret_success;
>   
> -		if (!all_cpus &&
> -		    kvm_read_guest(kvm,
> +		if (kvm_read_guest(kvm,
>   				   hc->ingpa + offsetof(struct hv_send_ipi_ex,
>   							vp_set.bank_contents),
>   				   sparse_banks,
> @@ -1935,6 +1937,7 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>   			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>   	}
>   
> +check_and_send_ipi:
>   	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
>   		return HV_STATUS_INVALID_HYPERCALL_INPUT;
>   
> 

Queued this one for stable, thanks.

Paolo
