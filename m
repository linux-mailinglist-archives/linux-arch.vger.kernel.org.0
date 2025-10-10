Return-Path: <linux-arch+bounces-14000-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602BABCD059
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 15:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5360B1A66D7F
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE122EF677;
	Fri, 10 Oct 2025 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjwoXUV8"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78C928750B
	for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101543; cv=none; b=apSnuEzEpgeQt4PliOMpGQeMCXs5PISXRG+4EWwYeTww1lO39J0D2WZ32CjwIqjaDeqH9iUzGsmqCzq4gLm6dNSGuqaup9tvXgYZs4s19F9T06g298f2cLPztWrIq1e5z+MenqMt/Cv4xdaFreSOKXnJTqS2/NolCubA9Gx3jNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101543; c=relaxed/simple;
	bh=HGzsZi1vsvMyshyxacFILw/U09Wv8rG4wcljUa3zJLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEqAp29XPqZnP9sUPvKQnU0JUMkhjOPNc55OTUDFDmIyEiZ5yBYbKTH9dgVZJgDWnW3JrmA83yE8Axzg0qWA46sSqN6EYVcf2oV0Ey8nSAfFtwY/J1yDQoJ++5wCs8FuIfbIHWjt4bY2z9luq63+YEDjAR9EMphROa6LCAaM/ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjwoXUV8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760101540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2hGea7bmj/mcTVPTcwhsDoysIgtmUiEc0/u4e6XSjWY=;
	b=LjwoXUV8c63NgwsDUssz/XeM6trbJv4rKX1QB4V2PTkMB0BAfal2UM7nKuLfQWIw+WWTrt
	0a+y9QqwroXuxW+KgR/4QjnApsW39a/XQRkHWadeMIJ+MUMW4LYjwh0u5Sa82ocOQ0oOq0
	9Z18jgRjys54lSWDvSrTJRxYQxRFHcU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-zhAReeapNEukIgGg2jJGmg-1; Fri, 10 Oct 2025 09:05:37 -0400
X-MC-Unique: zhAReeapNEukIgGg2jJGmg-1
X-Mimecast-MFC-AGG-ID: zhAReeapNEukIgGg2jJGmg_1760101537
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b3fd9c9df9eso322029566b.0
        for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 06:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760101537; x=1760706337;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hGea7bmj/mcTVPTcwhsDoysIgtmUiEc0/u4e6XSjWY=;
        b=W2s6bPq9ttlj+LWtwY+oCakKE+7VHADtGnBf3N/XT5LpDBjFsos0A1eXTXaoUtKLVR
         J0swjfN6moj8Zc6Bjx/ZvylYHSRISnf45bv06jdXN+l07SlI/MXBpx0EKtolBKLdQ9KR
         XFs55Yn8ahKyfqg7bm9svxjxrSv7o9qACwAKl1KvZl2Vt7wv+9lwTFskKEihslMpzK8N
         tsxQX0R+oa6FLQKxxZo3bJ7KqlIyTQ9BnWoDlGcmEBR9FoL8bZrRUkOW5igivE8H1+AP
         jKZUD6wZNOvpbgoqeKw7ehi7ufeDcLbYgMR2Ks223sc9nAYUpcHHwb/2uPKtpQYE3SSn
         L+rg==
X-Forwarded-Encrypted: i=1; AJvYcCVu/LSWug8oFZenEGyr0loJIXt0U8J1UjoEmoppgfV2jj8HZvud/1QV+vERtiUL8oatIWSuKFIAfVR3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt9mBVBSPoSFzaoxwhcg96PdIZIJda3emmaK7Pr+JCcZRQB91Z
	tjvCR7anHORKflmOhtJL1nPJDs5k+9nJRYX0Q1isI5xByEC3u1oHcsl61jeSxRiLyyhTvHv6ix/
	fwy+SR19VXdtBQ0eb1K6pplNnFMQ6VXky+4mk815nOnBVKK2H8HsiJ9Rq4HHz72k=
X-Gm-Gg: ASbGncum/wI6aDwnn0CSSpmdZKZ/v2qmiCFZigmDX1np57PkWjh9ZfieB2I/e+KBIvf
	Kf+NksipVYbL1acbCR9Qf7kXLus4cZ484sa0PIb40YutS06ea+ysOTZEdr9+PoQEvYglAIFDaFf
	K0aZ+YhRmIJ/otaWHb2uTBZZchCGhTNavCicCEf90myLIqV64er44bfYmxgcudaU7rxifNKY6Sz
	0XYHEh2DSo6p38Bd44bfckZctVdn88943gQ4+B3Od75ty99gudN8cZCVUY5tvZl95yAoL3a108r
	vARUUNjSTNh4rU+P3TOiLoTi3uIl77horidAJUpkVUSyKX0axjQnw/tLcZXaVwaXfPcstubL4NT
	8iF7M
X-Received: by 2002:a17:907:26c5:b0:b50:9f92:fde0 with SMTP id a640c23a62f3a-b50bf7eb3c4mr1114054666b.29.1760101536624;
        Fri, 10 Oct 2025 06:05:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJXCIqjoTCFwkJnbp63FjW7H91+lwbbxIWtE1s3Rk5OT6bmAOGxvAf+/ZtuBgUNz9xpBiMGA==
X-Received: by 2002:a17:907:26c5:b0:b50:9f92:fde0 with SMTP id a640c23a62f3a-b50bf7eb3c4mr1114050866b.29.1760101536085;
        Fri, 10 Oct 2025 06:05:36 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net. [47.64.112.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900ccf1sm225383366b.63.2025.10.10.06.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 06:05:35 -0700 (PDT)
Message-ID: <e00e64ad-f1ff-4469-8a20-9c44ebc2f32a@redhat.com>
Date: Fri, 10 Oct 2025 15:05:33 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/41] arm64: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 uapi headers
To: Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-9-thuth@redhat.com>
 <20250314115554.GA8986@willie-the-truck>
 <df30d093-c173-495a-8ed9-874857df7dee@app.fastmail.com>
 <20250314134215.GA9171@willie-the-truck>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250314134215.GA9171@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/2025 14.42, Will Deacon wrote:
> On Fri, Mar 14, 2025 at 01:05:15PM +0100, Arnd Bergmann wrote:
>> On Fri, Mar 14, 2025, at 12:55, Will Deacon wrote:
>>> On Fri, Mar 14, 2025 at 08:09:39AM +0100, Thomas Huth wrote:
>>>> __ASSEMBLY__ is only defined by the Makefile of the kernel, so
>>>> this is not really useful for uapi headers (unless the userspace
>>>> Makefile defines it, too). Let's switch to __ASSEMBLER__ which
>>>> gets set automatically by the compiler when compiling assembly
>>>> code.
>>>>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   arch/arm64/include/uapi/asm/kvm.h        | 2 +-
>>>>   arch/arm64/include/uapi/asm/ptrace.h     | 4 ++--
>>>>   arch/arm64/include/uapi/asm/sigcontext.h | 4 ++--
>>>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> Is there a risk of breaking userspace with this? I wonder if it would
>>> be more conservative to do something like:
>>>
>>> #if !defined(__ASSEMBLY__) && !defined(__ASSEMBLER__)
>>>
>>> so that if somebody is doing '#define __ASSEMBLY__' then they get the
>>> same behaviour as today.
>>>
>>> Or maybe we don't care?
>>
>> I think the main risk we would have is user applications relying
>> on the __ASSEMBLER__ checks in new kernel headers and not defining
>> __ASSEMBLY__. This would result in the application not building
>> against old kernel headers that only check against __ASSEMBLY__.
> 
> Hmm. I hadn't thought about the case of old headers :/
> 
> A quick Debian codesearch shows that glibc might #define __ASSEMBLY__
> for some arch-specific headers:
> 
> https://codesearch.debian.net/search?q=%23define+__ASSEMBLY__&literal=1
> 
> which is what I was more worried about.

  Hi!

FWIW, the x86 patches have been merged since kernel v6.15, and as far as I 
know, there haven't been any complaints about the change there yet. Thus I 
assume the changes should be ok.

So I rebased the arm64 patch now, too, and resend them separately as a v2:

  https://lore.kernel.org/lkml/20251010130116.828465-1-thuth@redhat.com/

  Thomas


