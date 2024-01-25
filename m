Return-Path: <linux-arch+bounces-1560-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4227383BB9A
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 09:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9092280E43
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F5117581;
	Thu, 25 Jan 2024 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EirxkGFG"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D846317588
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170631; cv=none; b=cfuaZrAd5uIJBOA3pEeyFukqZrlRXj2i5iSexeRzHzFYI4gwnBPcj9Ul3FVILC+WEbtSexT9tGpqJBtmhPkt3QpitoZ5ZxAlxjp3vWAbydwAPe24JHGQeN3A/yPtIjyDGre7mv71mBv/Wy4KSezYrzK/EUVcrPe1XUU4kRqNvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170631; c=relaxed/simple;
	bh=4yhaE1qqa9NZTdcUT/69EaMxPMmUDfecZuq6FiE7C1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EiT15T5oSCzyObumBwXdu523RzLl6qz/8GTOROStoLIwhsxncrU3zoGrz04e35T8MFBEymY6Bc1RZ5RRP4YiiXF38gnG55UfhPulwTynlSNQ0hC1zhpFQ98a4m2QcKQOC9f8BqtEdVZJy2fwKosLTjdkEJJzoUNhY69H3s4RUuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EirxkGFG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706170628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UZLvbQ/sj/IqlociRX/ySFK6it2BLTBR7c6/FUndS40=;
	b=EirxkGFG6lF8Nbs1IygF13xw0NegjRD5b5c6B3+jfIMfiMFncc9+EEMSqyf6ecloR0GcIj
	Q6zesGSLSAn1GdfV/l68DTjzVZdq1pBdY8ZH80gRkvLLkast+bWZ07InbEhM8DfX+JPI9Z
	l2QcEsw9MzbQ7mDz/zR6aPYMvMUAPQU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-iv6U6URYM-q0omJ6jMLtvA-1; Thu, 25 Jan 2024 03:17:06 -0500
X-MC-Unique: iv6U6URYM-q0omJ6jMLtvA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e53200380so55305285e9.3
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 00:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706170625; x=1706775425;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZLvbQ/sj/IqlociRX/ySFK6it2BLTBR7c6/FUndS40=;
        b=JcTbSrXXeePKZRCfhlAs0jheWAIMtP6ve46rYX5Qf3CF0CJrn9qCNrTQigVKtvNsrc
         EZhYuzhW7ssVoNceI41ARLJDnCtp+qWDF/H56wpq3DStDmHhtZPOxLrQME3bNGDdw3hH
         079Ae7wny9fysQ745qp0zaAuzaPs5tmtyAcOnj3r36VBQq8KZ2GlVmMOvtY+dhvAvY5o
         +O72pOna1o+HhobQV02b/CVrlEqY6VrkSfP7rR5vzQ3pVyHz24czGArvR9a9cf1llRsS
         UmM3oAAzz6A/gu77ccVVDbXFMVJtEEcoRQc/P1D6Cm7EMOtR0ATGB7akmdWNy5SMdxiz
         ainQ==
X-Gm-Message-State: AOJu0YyzZGEzSeIHtpMBSEJs45lE2GpnKEvSbMYaO7eNNR6FnYZg34Ml
	+GncohonmUIk7jJyihfF/LMM8qhQLkXTB4QPPbGfbtVkY9DzLf/thxSTX+rLH+zu2aTTyuzrRaW
	QbIMYRxpcTYJlSXMSSEuU6OEAIawCqf1u1DFUo2fJX3g4fYLikM7WSVTJEpU=
X-Received: by 2002:a05:600c:4f4d:b0:40e:a32c:988d with SMTP id m13-20020a05600c4f4d00b0040ea32c988dmr107884wmq.4.1706170625362;
        Thu, 25 Jan 2024 00:17:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBXG0c1n69CXCyo5Gso5jszoyqCLj5BPA212FZgRTdtFdTJYJL0uYG9mHoKZFGV423EU1+WQ==
X-Received: by 2002:a05:600c:4f4d:b0:40e:a32c:988d with SMTP id m13-20020a05600c4f4d00b0040ea32c988dmr107862wmq.4.1706170624814;
        Thu, 25 Jan 2024 00:17:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c70a:7600:9a0b:ceef:a304:b9a7? (p200300cbc70a76009a0bceefa304b9a7.dip0.t-ipconnect.de. [2003:cb:c70a:7600:9a0b:ceef:a304:b9a7])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b0040d30af488asm1658538wmq.40.2024.01.25.00.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 00:17:04 -0800 (PST)
Message-ID: <a6f3ccf5-26a0-45f1-adaa-56a8df569548@redhat.com>
Date: Thu, 25 Jan 2024 09:17:01 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 08/28] mm: Define VM_SHADOW_STACK for RISC-V
To: debug@rivosinc.com, rick.p.edgecombe@intel.com, broonie@kernel.org,
 Szabolcs.Nagy@arm.com, kito.cheng@sifive.com, keescook@chromium.org,
 ajones@ventanamicro.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 conor.dooley@microchip.com, cleger@rivosinc.com, atishp@atishpatra.org,
 alex@ghiti.fr, bjorn@rivosinc.com, alexghiti@rivosinc.com
Cc: corbet@lwn.net, aou@eecs.berkeley.edu, oleg@redhat.com,
 akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
 shuah@kernel.org, brauner@kernel.org, guoren@kernel.org,
 samitolvanen@google.com, evan@rivosinc.com, xiao.w.wang@intel.com,
 apatel@ventanamicro.com, mchitale@ventanamicro.com, waylingii@gmail.com,
 greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org,
 shikemeng@huaweicloud.com, charlie@rivosinc.com, panqinglin2020@iscas.ac.cn,
 willy@infradead.org, vincent.chen@sifive.com, andy.chiu@sifive.com,
 gerg@kernel.org, jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
 ancientmodern4@gmail.com, mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
 bhe@redhat.com, chenjiahao16@huawei.com, ruscur@russell.cc,
 bgray@linux.ibm.com, alx@kernel.org, baruch@tkos.co.il,
 zhangqing@loongson.cn, catalin.marinas@arm.com, revest@chromium.org,
 josh@joshtriplett.org, joey.gouly@arm.com, shr@devkernel.io,
 omosnace@redhat.com, ojeda@kernel.org, jhubbard@nvidia.com,
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-9-debug@rivosinc.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240125062739.1339782-9-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.01.24 07:21, debug@rivosinc.com wrote:
> From: Deepak Gupta <debug@rivosinc.com>
> 
> VM_SHADOW_STACK is defined by x86 as vm flag to mark a shadow stack vma.
> 
> x86 uses VM_HIGH_ARCH_5 bit but that limits shadow stack vma to 64bit only.
> arm64 follows same path
> https://lore.kernel.org/lkml/20231009-arm64-gcs-v6-12-78e55deaa4dd@kernel.org/#r
> 
> On RISC-V, write-only page table encodings are shadow stack pages. This patch
> re-defines VM_WRITE only to be VM_SHADOW_STACK.
> 
> Next set of patches will set guard rail that no other mm flow can set VM_WRITE
> only in vma except when specifically creating shadow stack.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   include/linux/mm.h | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 418d26608ece..dfe0e8118669 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -352,7 +352,19 @@ extern unsigned int kobjsize(const void *objp);
>    * for more details on the guard size.
>    */
>   # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
> -#else
> +#endif
> +
> +#ifdef CONFIG_RISCV_USER_CFI
> +/*
> + * On RISC-V pte encodings for shadow stack is R=0, W=1, X=0 and thus RISCV
> + * choosing to use similar mechanism on vm_flags where VM_WRITE only means
> + * VM_SHADOW_STACK. RISCV as well doesn't support VM_SHADOW_STACK to be set
> + * with VM_SHARED.
> + */
> +#define VM_SHADOW_STACK	VM_WRITE
> +#endif
> +
> +#ifndef VM_SHADOW_STACK
>   # define VM_SHADOW_STACK	VM_NONE
>   #endif
>   

That just screams for trouble. Can we find a less hacky way, please?

Maybe just start with 64bit support only and do it like the other archs. 
No need to be special.

When wanting to support 32bit, we'll just finally clean up this high 
flag mess and allow for more vm flags on 32bit as well.

-- 
Cheers,

David / dhildenb


