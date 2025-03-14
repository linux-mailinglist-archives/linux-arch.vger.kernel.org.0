Return-Path: <linux-arch+bounces-10824-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8438DA618ED
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 19:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459CD1B63890
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 18:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45978204F7C;
	Fri, 14 Mar 2025 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaVPpnln"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAB1204C3D
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975314; cv=none; b=OeZAH2AMbN6KdI5OZkWLlcumW3EBSJ7953hyeQwZoMRDM9fxIbvKtOryo7+Y/q/vt+50+cAzgGjoMRAJT40XTkDb50jXW1Mxmx02aRwJF9BNymLHp05j7dcPfk6cU+ernp1IuWvJe2+xQMJvcfKFMzTHeBeFFMZZ6vlM+WGQLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975314; c=relaxed/simple;
	bh=EEYxWwY8kCTLySnOVtwdYcS5zBb5IL6//3e/jf2TqxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atXI6K4c/4eQ0/ofwgPuIjj2Y63npc6QL7aKmSkiA6Y5p/5s4kNtllhxW7XDJDhyDFA35ROmpwXJ6AGphiMhtss9RGNjWMSYLoSqBE5cAQZqoz4vBy6LFUaVzsJdQWLM9tvuuH4ghUyFholggG8aUpwlTYzNrh1xwpkeKvcP2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaVPpnln; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741975311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sdKP65qdr3ROgUgJg8MYQwM2EODCLBcK6u+sVD8ojXA=;
	b=FaVPpnlnRBtlTBtEC+Q2DGmlB4IdX1L7im2i3eCe2e0+0Rcmkbk/UqnGAWJa0gEsz8eVNA
	PmyRFKzlZmKBEt16+VJQO4Gab7kr4heaWJNh2TldErh750ghbhrzuvIsFUrrVDThGxkOj2
	OWNhsefFDjvAj7SqTizUHvU0QX+jlWc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-vBIZOxQHMp6ItR3ZfaVzKg-1; Fri, 14 Mar 2025 14:01:50 -0400
X-MC-Unique: vBIZOxQHMp6ItR3ZfaVzKg-1
X-Mimecast-MFC-AGG-ID: vBIZOxQHMp6ItR3ZfaVzKg_1741975309
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so18136765e9.3
        for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 11:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741975309; x=1742580109;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdKP65qdr3ROgUgJg8MYQwM2EODCLBcK6u+sVD8ojXA=;
        b=K8Q7QBLQX7Zzi0r9JldKfNb1Db3uwbtOYQhvL2kLsCeywYXjUrklh7rrWeIlqAXlla
         bRDZtkR15/R//BaggmeH2AdTwqH2A7AlQveiIpr9QW1NtbrO4ejl0Fncfr7bUJZAOACG
         JimIViEAvNXu7q8Nw6x21oL1baP8HngIszwHJHqg1QG6AwMZLn0iPb4fDY4ZYMI69oUb
         015oYlSKHWGPWPG74KoqtfpaCLihrJVHokNwvpPoSMJMbVcaZeDLSsB3H6WFTZND8Z/t
         qlhzuq91BExYTyRboVNfa6uUGV8jzZZPol6CINMrwgFUf3E9eiQdIxYy59jGQw1WkCt+
         E7Og==
X-Forwarded-Encrypted: i=1; AJvYcCV5XAMgJWIzm4rbkbmCDHyPBLDHb0qIxfh1LLc0gPxOI4ttIXOPgLMFYZdK8jF7KRvJa15UkvgRImpW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5+LlfG2v4eMAdGxz0jhv8P/QQapZJy2EG/+WcqXLvBbgo/XB4
	THcaBI8cv04Qr0rCnwOY2/u3wibk7rAMlMSnAQg1sv+0eyxXjDyh4lxikh3iF5yiJmMfI1Cu9nx
	yWK0jEeP1/V3Q7mSw/ekPUZEHNKNfwpaR6AEeaOXbMstI2PD3XjLcYnX95mQ=
X-Gm-Gg: ASbGncsVQmQhU6KS32+GDq3c+7dMUEhhgs6pLvS48AR+dcj1H8FMdwEBDMzWg6nCtI+
	15kHWNa12OCU4JoizBxti1eB2GjldqtQ16dxdBJgk5pl+XiraC9qMzYcBWXO2mGuBtqbtPkeJVj
	7oLWQ/jQoY2ZSfKYI2WBvOKDsiyY2khHUTjvcLcGw93jUBOHIikw4bgiUykKKnNeF4p8zt97NHV
	8+ZM6MWI+qApBOBHX7kInbC8/aU7cZgfB4PSZOJFurj2klWQfkn4GOVmF7X7HaYHQmv2/NEBVPp
	wpnHbFZM5zB4xMQBJBhSq146SlCdiTQk99hYuLkq/imsskI=
X-Received: by 2002:a05:600c:198e:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-43d1ecd8631mr43492595e9.20.1741975308654;
        Fri, 14 Mar 2025 11:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVfqZ0VtjIa24aKX7T579NwZ9Rq/vt8mIPi/r8NwfDGe5UQOF2w13UZuRKaiVNkmwC8wV0kA==
X-Received: by 2002:a05:600c:198e:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-43d1ecd8631mr43491465e9.20.1741975307549;
        Fri, 14 Mar 2025 11:01:47 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de. [109.42.51.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbcf12sm23837335e9.12.2025.03.14.11.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 11:01:47 -0700 (PDT)
Message-ID: <71188823-2a9e-4565-8ace-03a682d8d0da@redhat.com>
Date: Fri, 14 Mar 2025 19:01:45 +0100
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
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
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

Since both, GCC and Clang, define __ASSEMBLER__ since a long time (Arnd 
checked GCC 2.95, and I checked that at least Clang 7.0 still has it), I 
think the only problem might be other compiler toolchains that might not set 
__ASSEMBLER__ automatically. I just checked Tiny-C 0.9.27, and that also 
sets __ASSEMBLER__ already. And according to 
https://github.com/IanHarvey/pcc/blob/master/cc/cc/cc.1#L405 it is also set 
in PCC.

I haven't spotted it in LCC though (which seems to be an old C89 compiler if 
I got it right). So if we are worried about such exotic old compilers, it's 
maybe better to check both, __ASSEMBLY__ and __ASSEMBLER__ in the uapi 
files? Or would it be ok to force those few people to set __ASSEMBLER__ 
manually in their Makefiles (just like they had to do before with 
__ASSEMBLY__) in case they want to compile assembler code with such exotic 
compilers and new kernel headers?

  Thomas


