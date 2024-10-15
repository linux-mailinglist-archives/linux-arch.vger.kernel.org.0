Return-Path: <linux-arch+bounces-8183-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF23899F1A4
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 17:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11B01C21D6C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE361E282B;
	Tue, 15 Oct 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAuKOA0b"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B91B3945
	for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006953; cv=none; b=jOyiDLj25RCziZqctK4f4dLtkCjZ34OhhETf3+GVUewnbTog6Z0tdC77DSazYOvH40K6ZY5MyL7uzxgCKqCVeT3012DbX8NcNBGgMSE2PoFcDRq+KnK2BuFcZrZGspXLh8IoIP2UqfwAo9aSIbDzpljQM5WiI/KhLwoWgHqf250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006953; c=relaxed/simple;
	bh=5PR3L/M7rmbRke/aF9fzK+CaZLRYuzFD8o0izqT6d6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3ziXCjrzj7rCEA3utmvFAyPS6rGhDrKzuCdqEnd5YPIYxT6HtJwAuJN8xaJJaM5ABvK0IUJXol7QmxQ38tgjP34YKgFoX6HDE0SeTU1v+4EcVbD4a5cmLbDo05ddUvKb0/sp6G4eIT9JYbk6TvTJ4/DOpAskRyH8XAmZ8Cvhlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAuKOA0b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729006950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yCgrahaTrhKOIckAKrhaa+/bWy4C0fCSk2G7dPS9pHw=;
	b=dAuKOA0bNaK+uKDpcb4adxG7/4D9XwfIb3rko5JHEOrkSMl0W0cghNK4ltOhUb3aDg+rih
	JHiQ8W52IlZXnLuNC1d0/3kngjuJUlGvDu5o5coYF+7zMFGGtJ3nBXUyHZu3PmXVX9yBJ3
	8vUH0yHcpr04m1BMr6Z4pmIOhr4qg3s=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-h4JBPNBWPdaSv-G-JFKyUQ-1; Tue, 15 Oct 2024 11:42:29 -0400
X-MC-Unique: h4JBPNBWPdaSv-G-JFKyUQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539eeb63cc3so2093650e87.2
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 08:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729006948; x=1729611748;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yCgrahaTrhKOIckAKrhaa+/bWy4C0fCSk2G7dPS9pHw=;
        b=No70U8/4S3UamEVQG49y2+SzqsxGexM5bqyABKQ6kj+5mIPDzjJHg3F1XMZkWrK92p
         +/RxR15n5aPkO95Bz1ZKDZKbrZGrTdlJtGlwQorYoh4r6DPqBZKZSM5o45uQjoeomSye
         U+V9qJq3J9xGmKv3ACArdiviVBrMt8YWpU0UMOJMV3QCgahhSPjWnrmyO7FgMZHMxw4O
         vt3EqLAryH++FI7nm6wBbkykmepEMS9mcLu0Y+ynh3i9I6zWS0iT2848Jk3nMcpDB6MY
         wSF1VWTGNogRcppXf3/gltkM+8u57NyH1Tq8px8zD316gKQynSSN3x4C3IQ39gFf8Ljm
         pW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWz9mOhcOW1/57UoiSSZgF4BtpN8PtzIH2RoU0rgKDr+atQdnJbChLV6xiTxrus6iTKS3v+6H0c9xEG@vger.kernel.org
X-Gm-Message-State: AOJu0YxijrT0TXG/J/w/ruN/hCE5eyNjRLyqcT7AD1pzjxxrTbMKZOi5
	bKyjp4Cst29aP/ZXlO2VNoYsDZeJo9kucMNdc3JjrMX4Fhq+YMYE1nJvixARoZdCsnMXl1Lv904
	+ZbOyK49sq5cs/LOqRgr0G7OCyB5LhA/Q/1ghQRmnHO7Sz18UAsgYk4Ah/VI=
X-Received: by 2002:a05:6512:12d6:b0:539:93b2:1372 with SMTP id 2adb3069b0e04-539da5abc99mr8383565e87.51.1729006947789;
        Tue, 15 Oct 2024 08:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVW574cmL1pxEgo/iF86oTmZutmZL4ggDc0SlBni3S0Liv2hijpNUZb737CpeKdanAF8RWIA==
X-Received: by 2002:a05:6512:12d6:b0:539:93b2:1372 with SMTP id 2adb3069b0e04-539da5abc99mr8383548e87.51.1729006947295;
        Tue, 15 Oct 2024 08:42:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c730:9700:d653:fb19:75e5:ab5c? (p200300cbc7309700d653fb1975e5ab5c.dip0.t-ipconnect.de. [2003:cb:c730:9700:d653:fb19:75e5:ab5c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314209688dsm18864365e9.14.2024.10.15.08.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 08:42:26 -0700 (PDT)
Message-ID: <9c81a8bb-18e5-4851-9925-769bf8535e46@redhat.com>
Date: Tue, 15 Oct 2024 17:42:24 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: Suren Baghdasaryan <surenb@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Yosry Ahmed <yosryahmed@google.com>,
 akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net,
 arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org,
 thuth@redhat.com, tglx@linutronix.de, bp@alien8.de,
 xiongwei.song@windriver.com, ardb@kernel.org, vbabka@suse.cz,
 mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org,
 dennis@kernel.org, yuzhao@google.com, vvvvvv@google.com,
 rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org, kernel-team@android.com
References: <20241014203646.1952505-1-surenb@google.com>
 <20241014203646.1952505-6-surenb@google.com>
 <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com>
 <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com>
 <6a2a84f5-8474-432f-b97e-18552a9d993c@redhat.com>
 <CAJuCfpGkuaCh+PxKbzMbu-81oeEdzcfjFThoRk+-Cezf0oJWZg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJuCfpGkuaCh+PxKbzMbu-81oeEdzcfjFThoRk+-Cezf0oJWZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.10.24 16:59, Suren Baghdasaryan wrote:
> On Tue, Oct 15, 2024 at 12:32 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 15.10.24 01:53, John Hubbard wrote:
>>> On 10/14/24 4:48 PM, Yosry Ahmed wrote:
>>>> On Mon, Oct 14, 2024 at 1:37 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>>>>
>>>>> Add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to store allocation tag
>>>>> references directly in the page flags. This eliminates memory
>>>>> overhead caused by page_ext and results in better performance
>>>>> for page allocations.
>>>>> If the number of available page flag bits is insufficient to
>>>>> address all kernel allocations, profiling falls back to using
>>>>> page extensions with an appropriate warning to disable this
>>>>> config.
>>>>> If dynamically loaded modules add enough tags that they can't
>>>>> be addressed anymore with available page flag bits, memory
>>>>> profiling gets disabled and a warning is issued.
>>>>
>>>> Just curious, why do we need a config option? If there are enough bits
>>>> in page flags, why not use them automatically or fallback to page_ext
>>>> otherwise?
>>>
>>> Or better yet, *always* fall back to page_ext, thus leaving the
>>> scarce and valuable page flags available for other features?
>>>
>>> Sorry Suren, to keep coming back to this suggestion, I know
>>> I'm driving you crazy here! But I just keep thinking it through
>>> and failing to see why this feature deserves to consume so
>>> many page flags.
>>
>> My 2 cents: there is nothing wrong about consuming unused page flags in
>> a configuration. No need to let them stay unused in a configuration :)
>>
>> The real issue starts once another feature wants to make use of some of
>> them ... in such configuration there would be less available for
>> allocation tags and the performance of allocations tags might
>> consequently get worse again.
> 
> Thanks for the input and indeed this is the case. If this happens, we
> will get a warning telling us that page flags could not be used and
> page_ext will be used instead. I think that's the best I can do given
> that page flag bits is a limited resource.

Right, I think what John is concerned about (and me as well) is that 
once a new feature really needs a page flag, there will be objection 
like "no you can't, we need them for allocation tags otherwise that 
feature will be degraded".

So a "The Lord has given, and the Lord has taken away!" mentality might 
be required when consuming that many scarce resources, meaning, as long 
as they are actually unused, use them, but it should not block other 
features that really need them.

Does that make sense?

-- 
Cheers,

David / dhildenb


