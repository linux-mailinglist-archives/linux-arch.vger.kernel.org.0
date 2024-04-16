Return-Path: <linux-arch+bounces-3724-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 413EA8A6CD2
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 15:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09B5DB21A81
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49237129A72;
	Tue, 16 Apr 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKVfmw6P"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BEE12C558
	for <linux-arch@vger.kernel.org>; Tue, 16 Apr 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275497; cv=none; b=S5vccI/ZKGSetCaZ2Fz1ncelDZjhRJHX/HFGcNCOB8ME4w3Eq+QSBUAzH6S7X0nu7dEV7wxabUlEutF0hgp1wGOYispG21fGiMe6iQqzLsrAb99LB6tWM7vmdG+pfkeLlB9qP8hKerod2mskN8VA0FCp2a7wDP1V/cAFRChwo8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275497; c=relaxed/simple;
	bh=QTAfbFgev3L2ptUAejaAhMPjhDL+4HSJM2/BMHHV6F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYJQkjSuw/egQ9EHbq30gp4fut9dXATGRTazVbrdP/ICao93ajVRfyZiH5+kd1VKetEB57Fvru6kBm4QeF2Fvhu2g/Jq/pVYBU9bUawhorPq8vi8cZwNkBEvZb+WQvBqLxXZrS7iInjcRcBEEIOOPHE13Xu/x4zP1Jo3BGWIxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKVfmw6P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713275494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KzEshGm05jYMH47Ft2QC8UnffG1g9JyMRcoOm48fEmc=;
	b=CKVfmw6PPQFkZFTZR8HhivYviatqacNFAdIL+7N8WqQPJz2Ksuq9/VIjvxDcjc1lKkuCQ5
	4Xj0XzuySMhxJto/GCSSudm+chIJD3cE4EK38ZyH1L75oqhQv8q7ToldqDJmoOOqgRmA6/
	jD1G6Peu0t7MhnXoJmbx6SVDNNRTLbM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-lBLpKb5VO46JXdfP6ePS0Q-1; Tue, 16 Apr 2024 09:51:33 -0400
X-MC-Unique: lBLpKb5VO46JXdfP6ePS0Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-347ddb973dcso1280446f8f.2
        for <linux-arch@vger.kernel.org>; Tue, 16 Apr 2024 06:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713275492; x=1713880292;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzEshGm05jYMH47Ft2QC8UnffG1g9JyMRcoOm48fEmc=;
        b=e0M/jvC+CUdHKOA/rdEjG2xUkErcoe4apyTrPhEB/y677+Px5pjMLhTWnbsBTY+7od
         RWPXWOLBfCBAI20cFhm7nZIzGhbiuoy34ClshqnLNfln32Q0inpBZZcsOcxU1kn1ADnQ
         sv7EN0PZekSB1i6UXvTATHr8c1K9n6AJ9g2PEK5Cd0Ct9I3dQ4mZ0WOVn7mGe716k8fX
         jEdo++OHNfZIW9zKwaUpimGC5GgPU52tmpI1gx253UXOS82nkON11VTgajLeisEXNx7m
         5VbW1PXeYr7dB4UWGnyW7hb4QMvbnZLmNEFa7d8XLmgHmbMMetrtgxRqx4lK/Pamp3Ak
         YgVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzebip+2k6H4Mnh/vpHA8+mABfdsBniuBcIkvCFnmDyDXUeBTmf/7JLYE4ZuJpgLNqkUE50wuu+ze0dlgwZ3AymAgOjivprUECyA==
X-Gm-Message-State: AOJu0YwNBFo2b1xzDtKPHzZlmt4q2I0jAv5WchCMw7AxW8c5iDjSt5yZ
	16NjgOPl/Bt436Gl21k2wXD5P7UlTzam2lH2kquqRHtWd2j+Cs9LHX70R+DMtW+F3hbG90wbDzM
	H9v+OAaoRJgVLQuaixST4va3FHXptwOZrnW2m/9grQazksvAfi/kgDiJS4mc=
X-Received: by 2002:a5d:4589:0:b0:33e:c316:2a51 with SMTP id p9-20020a5d4589000000b0033ec3162a51mr7672083wrq.27.1713275492286;
        Tue, 16 Apr 2024 06:51:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCjzlADbwFv44JQkrB/ikEE61jxFMn3dfaESPXQ+nqH0EMS1bqqdCY2S0qlAv8mMtQKQ6YEg==
X-Received: by 2002:a5d:4589:0:b0:33e:c316:2a51 with SMTP id p9-20020a5d4589000000b0033ec3162a51mr7672063wrq.27.1713275491857;
        Tue, 16 Apr 2024 06:51:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:6400:7621:b88a:e99e:2fa8? (p200300cbc71864007621b88ae99e2fa8.dip0.t-ipconnect.de. [2003:cb:c718:6400:7621:b88a:e99e:2fa8])
        by smtp.gmail.com with ESMTPSA id s4-20020a5d5104000000b00346f9071405sm12624395wrt.21.2024.04.16.06.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 06:51:31 -0700 (PDT)
Message-ID: <c82af143-b620-44d9-8647-f52096b851ab@redhat.com>
Date: Tue, 16 Apr 2024 15:51:30 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ./include/asm-generic/tlb.h:629:10: error: parameter 'ptep' set
 but not used
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-arch
 <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
 clang-built-linux <llvm@lists.linux.dev>
References: <CANiq72mQh3O9S4umbvrKBgMMorty48UMwS01U22FR0mRyd3cyQ@mail.gmail.com>
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
In-Reply-To: <CANiq72mQh3O9S4umbvrKBgMMorty48UMwS01U22FR0mRyd3cyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.04.24 12:26, Miguel Ojeda wrote:
> Hi David, Arnd, LoongArch,
> 
> In a linux-next defconfig LLVM=1 build today I got:
> 
>      ./include/asm-generic/tlb.h:629:10: error: parameter 'ptep' set
> but not used [-Werror,-Wunused-but-set-parameter]
>        629 |                 pte_t *ptep, unsigned int nr, unsigned long address)
>            |                        ^
> 
> Indeed, in loongarch, `__tlb_remove_tlb_entry` does not do anything.
> This seems the same that Arnd reported for arm64:
> 
>      https://lore.kernel.org/all/20240221154549.2026073-1-arnd@kernel.org/
> 
> So perhaps the loongarch's one should also be changed into an static inline?

4d5bf0b6183f79ea361dd506365d2a471270735c is already part of v6.9-rc1. How come
we see that only now on linux-next?

I assume we should see the same on upstream Linux with LLVM=1, correct?

If so, we should likely just drop that completely and rely on the asm-generic one:

diff --git a/arch/loongarch/include/asm/tlb.h b/arch/loongarch/include/asm/tlb.h
index da7a3b5b9374a..e071f5e9e8580 100644
--- a/arch/loongarch/include/asm/tlb.h
+++ b/arch/loongarch/include/asm/tlb.h
@@ -132,8 +132,6 @@ static __always_inline void invtlb_all(u32 op, u32 info, u64 addr)
                 );
  }
  
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
-
  static void tlb_flush(struct mmu_gather *tlb);
  
  #define tlb_flush tlb_flush



Thanks!

-- 
Cheers,

David / dhildenb


