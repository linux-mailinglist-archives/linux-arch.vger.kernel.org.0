Return-Path: <linux-arch+bounces-2329-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8146854000
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 00:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52008B25D3F
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 23:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DD463106;
	Tue, 13 Feb 2024 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIMjLrik"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E253863108
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866538; cv=none; b=usWxw9l8CTOnEZLPpW+djOa3fOIQgow7f/NsbHBYQ8YmSf9r0+SMzcBm/EGz2djyp7HR7wlE2WQUyx9hMAJ+dZUd01SrCSd4w2QPcKflkMWdD3P0M+BIXzjRCo2kEkFqPAvIqi60XKyo4zHbIbaI7JcMNFn3+Jr7OmD1KQaE7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866538; c=relaxed/simple;
	bh=xlg0etbC/5xOaZHu/r32HI9FTOw5nloDtZjPPjdJTGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvlO4JoqR6XT8V6H9vxW3ietJlgcTEz96d9iwQDL10yY6gJ5KXewsGXBPXRvVwwBVSly4ArxYZ8XNdQuHHYqlgfJxBC7OXU4Rr0g0gzP4kGM/TAILE6bW7irr97XQT21+BkHPLShI0oN6OrhZTh6BFMI5At2sjvEyACf6W3Sptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIMjLrik; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707866535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cZAfitLnBMjrYyoOukrJIwYyfYo9MO8Q5HzfCPeVj3g=;
	b=WIMjLrikzEZRX5qApb8JgIEp+QvmYNKWw47LVYJ8O+FPw/VGJx/7E+KvZmy/77sl0Bj1r/
	Ch3p5mRjGVqWNimO2P4OKNnRw1EVKX1jlh6p5+h1V2wO8J9b7oMqYLuBZeM3X5ed1i8ebQ
	VEL9HYMVt+2d3QweDpOcqBpmNdEZ9Sk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-E5TlnopEMlebwAiGXrUGSQ-1; Tue, 13 Feb 2024 18:22:14 -0500
X-MC-Unique: E5TlnopEMlebwAiGXrUGSQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e53200380so30138345e9.3
        for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 15:22:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866533; x=1708471333;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZAfitLnBMjrYyoOukrJIwYyfYo9MO8Q5HzfCPeVj3g=;
        b=C0M4y6A3IDEU15OZna9jF/O1OwBHaLeihXu0klrTGoBK+x1a/nwl7WeIOvZDa8G4/U
         ImKREYvCxS75EHK/8RUXfrSoHdMUvv2znxEW/CTT4w3rJnoYV9j5sn7etOJcr5tMwOS6
         +TAwaQC/VFRNw/H7YrB9VLYPPkK7MjAzgmTh6EJB/SSBfYqtJFMjcklCvAwRu0DV8BvF
         dnVzyEOMx0arfO7OD1p5X2RWlDpRNonJ76ogfZlwdF1wzFBdTkdtqkh2qkBbQ16BpYKV
         /vE7AVvp9U1q5puEQpQke4REz4Aszp9dCYTJTLYUXXHWLXhtdAwWt8rG+O6kDmKIE6CJ
         nFGA==
X-Forwarded-Encrypted: i=1; AJvYcCVHh07HezEqgsG/286VEpD5GhRkuBYvrwxlIq2yFio8TzIIYn354nl9C/O7LCxX7JyU8Ui5dC15wkhjS4ap3rbH+feDe5vgvuJTNQ==
X-Gm-Message-State: AOJu0YyzTCzIG5UMli7ehZ2Q5/wCEsPsd06KR1aeAP2/8n/eQunqhHts
	SzYo2BwRpetM6+gYF+Lx3ELWDUeoeEKQ/WfiEGTDIl2JS7pI+Wi4YgYuTcgIlq5q3p1G6Lt9l43
	RcTx/5EUBWtC/GWU5mcT6viyT7qTfg0uGiq+2i+i2Dl50Q9tKx34K5wxjNKE=
X-Received: by 2002:a05:600c:4f0e:b0:410:df8f:9ffa with SMTP id l14-20020a05600c4f0e00b00410df8f9ffamr700172wmq.25.1707866533010;
        Tue, 13 Feb 2024 15:22:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAS5Mx65G+srJD5VPeGxe4JX2T34JNIRY22xk9yh8Ny/Vb7d1CBNQzfO1PEwBDjo4xMovvMQ==
X-Received: by 2002:a05:600c:4f0e:b0:410:df8f:9ffa with SMTP id l14-20020a05600c4f0e00b00410df8f9ffamr700105wmq.25.1707866532537;
        Tue, 13 Feb 2024 15:22:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; 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
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b0040fdf5e6d40sm158264wmo.20.2024.02.13.15.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:22:11 -0800 (PST)
Message-ID: <c842347d-5794-4925-9b95-e9966795b7e1@redhat.com>
Date: Wed, 14 Feb 2024 00:22:08 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
 void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 peterx@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
References: <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
 <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
 <a9b0440b-844e-4e45-a546-315d53322aad@redhat.com>
 <xbehqbtjp5wi4z2ppzrbmlj6vfazd2w5flz3tgjbo37tlisexa@caq633gciggt>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <xbehqbtjp5wi4z2ppzrbmlj6vfazd2w5flz3tgjbo37tlisexa@caq633gciggt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.02.24 00:12, Kent Overstreet wrote:
> On Wed, Feb 14, 2024 at 12:02:30AM +0100, David Hildenbrand wrote:
>> On 13.02.24 23:59, Suren Baghdasaryan wrote:
>>> On Tue, Feb 13, 2024 at 2:50 PM Kent Overstreet
>>> <kent.overstreet@linux.dev> wrote:
>>>>
>>>> On Tue, Feb 13, 2024 at 11:48:41PM +0100, David Hildenbrand wrote:
>>>>> On 13.02.24 23:30, Suren Baghdasaryan wrote:
>>>>>> On Tue, Feb 13, 2024 at 2:17 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>
>>>>>>> On 13.02.24 23:09, Kent Overstreet wrote:
>>>>>>>> On Tue, Feb 13, 2024 at 11:04:58PM +0100, David Hildenbrand wrote:
>>>>>>>>> On 13.02.24 22:58, Suren Baghdasaryan wrote:
>>>>>>>>>> On Tue, Feb 13, 2024 at 4:24 AM Michal Hocko <mhocko@suse.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
>>>>>>>>>>> [...]
>>>>>>>>>>>> We're aiming to get this in the next merge window, for 6.9. The feedback
>>>>>>>>>>>> we've gotten has been that even out of tree this patchset has already
>>>>>>>>>>>> been useful, and there's a significant amount of other work gated on the
>>>>>>>>>>>> code tagging functionality included in this patchset [2].
>>>>>>>>>>>
>>>>>>>>>>> I suspect it will not come as a surprise that I really dislike the
>>>>>>>>>>> implementation proposed here. I will not repeat my arguments, I have
>>>>>>>>>>> done so on several occasions already.
>>>>>>>>>>>
>>>>>>>>>>> Anyway, I didn't go as far as to nak it even though I _strongly_ believe
>>>>>>>>>>> this debugging feature will add a maintenance overhead for a very long
>>>>>>>>>>> time. I can live with all the downsides of the proposed implementation
>>>>>>>>>>> _as long as_ there is a wider agreement from the MM community as this is
>>>>>>>>>>> where the maintenance cost will be payed. So far I have not seen (m)any
>>>>>>>>>>> acks by MM developers so aiming into the next merge window is more than
>>>>>>>>>>> little rushed.
>>>>>>>>>>
>>>>>>>>>> We tried other previously proposed approaches and all have their
>>>>>>>>>> downsides without making maintenance much easier. Your position is
>>>>>>>>>> understandable and I think it's fair. Let's see if others see more
>>>>>>>>>> benefit than cost here.
>>>>>>>>>
>>>>>>>>> Would it make sense to discuss that at LSF/MM once again, especially
>>>>>>>>> covering why proposed alternatives did not work out? LSF/MM is not "too far"
>>>>>>>>> away (May).
>>>>>>>>>
>>>>>>>>> I recall that the last LSF/MM session on this topic was a bit unfortunate
>>>>>>>>> (IMHO not as productive as it could have been). Maybe we can finally reach a
>>>>>>>>> consensus on this.
>>>>>>>>
>>>>>>>> I'd rather not delay for more bikeshedding. Before agreeing to LSF I'd
>>>>>>>> need to see a serious proposl - what we had at the last LSF was people
>>>>>>>> jumping in with half baked alternative proposals that very much hadn't
>>>>>>>> been thought through, and I see no need to repeat that.
>>>>>>>>
>>>>>>>> Like I mentioned, there's other work gated on this patchset; if people
>>>>>>>> want to hold this up for more discussion they better be putting forth
>>>>>>>> something to discuss.
>>>>>>>
>>>>>>> I'm thinking of ways on how to achieve Michal's request: "as long as
>>>>>>> there is a wider agreement from the MM community". If we can achieve
>>>>>>> that without LSF, great! (a bi-weekly MM meeting might also be an option)
>>>>>>
>>>>>> There will be a maintenance burden even with the cleanest proposed
>>>>>> approach.
>>>>>
>>>>> Yes.
>>>>>
>>>>>> We worked hard to make the patchset as clean as possible and
>>>>>> if benefits still don't outweigh the maintenance cost then we should
>>>>>> probably stop trying.
>>>>>
>>>>> Indeed.
>>>>>
>>>>>> At LSF/MM I would rather discuss functonal
>>>>>> issues/requirements/improvements than alternative approaches to
>>>>>> instrument allocators.
>>>>>> I'm happy to arrange a separate meeting with MM folks if that would
>>>>>> help to progress on the cost/benefit decision.
>>>>> Note that I am only proposing ways forward.
>>>>>
>>>>> If you think you can easily achieve what Michal requested without all that,
>>>>> good.
>>>>
>>>> He requested something?
>>>
>>> Yes, a cleaner instrumentation. Unfortunately the cleanest one is not
>>> possible until the compiler feature is developed and deployed. And it
>>> still would require changes to the headers, so don't think it's worth
>>> delaying the feature for years.
>>>
>>
>> I was talking about this: "I can live with all the downsides of the proposed
>> implementationas long as there is a wider agreement from the MM community as
>> this is where the maintenance cost will be payed. So far I have not seen
>> (m)any acks by MM developers".
>>
>> I certainly cannot be motivated at this point to review and ack this,
>> unfortunately too much negative energy around here.
> 
> David, this kind of reaction is exactly why I was telling Andrew I was
> going to submit this as a direct pull request to Linus.
> 
> This is an important feature; if we can't stay focused ot the technical
> and get it done that's what I'll do.

Kent, I started this with "Would it make sense" in an attempt to help 
Suren and you to finally make progress with this, one way or the other. 
I know that there were ways in the past to get the MM community to agree 
on such things.

I tried to be helpful, finding ways *not having to* bypass the MM 
community to get MM stuff merged.

The reply I got is mostly negative energy.

So you don't need my help here, understood.

But I will fight against any attempts to bypass the MM community.

-- 
Cheers,

David / dhildenb


