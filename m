Return-Path: <linux-arch+bounces-12063-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C84FABFCCB
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 20:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B188C3969
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E36231A3B;
	Wed, 21 May 2025 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ4UWrpK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0EC433CB;
	Wed, 21 May 2025 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747851976; cv=none; b=DP7Xokjyeu1BpHFcNeqYSMgRXxTql5ss/hylrsJLGdpvNc21JFZoQ8g/XhWwRhlu2j4Z5ni8bjV0pEsZ9soG/QwX+hW/sHuW7nAOcDmkrBVYh3Yxwx9aUp9qTTlTB7lI64FAdFogwOnMc7rETPEIGLpMfg/iAXKWLSPJXkkM1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747851976; c=relaxed/simple;
	bh=BnB/ZR1oV90SsJg9Va5itKksoXu0rZ4YPUpTGgkJiWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjHgeNByNccvXFwT94V39LDNn7DTyoPVIy7dbbJ6KB06R19ZKjd3qdvDlzuJzzY1GxiLMoj8FURnblf/8gSuAISByUTT9wjNOYppjonJedeAYMrY9tmiNTUhtTST24jAuAv989owF3vgTD68nJO9Bs8Lx442BMQDDuxRla8f+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQ4UWrpK; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-601968db16bso3611535a12.3;
        Wed, 21 May 2025 11:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747851973; x=1748456773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=137GJ4GfHv//QtR0F1GuTLgJgEBX5CAPbUrQx+K92Jc=;
        b=lQ4UWrpK7i2jsw5ExLvihcv/ztol8qVw6tKkqNg8ln573VTmfsVOgtUcGNPz2N3i8G
         Pqwjc3nSoycFyyHbha7sQr5VUJBdNRgngv1xFRLZ6uTphQOjxG/p9H57VlBqa5ogtq5D
         FhuMGXDopmumwobNy51tsyZ8eGKTIdZeFoqr3QNV71xn5HI3lqP+ewSGOOQSYaA6NM7+
         Oo4GAsd0bNbsEddGJ1aTQUxQ3aR2LP30PaCnPbvC2q9U/emeLXxf79pzQEOHFbcXfW7Z
         IDVUXy3rGsVrQwABi9UwTLvXlttjIdpyWdGfstwz95K/GxMz4R+BMHg4FxDdN/pgpNtd
         UX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747851973; x=1748456773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=137GJ4GfHv//QtR0F1GuTLgJgEBX5CAPbUrQx+K92Jc=;
        b=VygeXg1rZrbzNuNVss1a48STbXeZlSy2+haa+zD2SQOeAhgDgK7qHX25BSFFuiyxGH
         yNaDhw7F7B2TTUkMq2ZPOHOaV/QWioEspmIh/+tCrD9O344YA9pkOOHMZKFcK812yVZI
         RAujBSirP1SgfmHnN9Uksbt0TvlMhFrE1dDFZ2H0utH6kNAzVnj0+geYhnlaTc4WgKaL
         eRT2RLkLvqo47YZlCBpY13q9Tr3f33kE9U6OOQcbEpokhjlpdvwL99nkZIBmwYLMGoTN
         yISErKsYZLBO1lFcxBKtsHcj1BLZ9BFcq2kMsUIIk6WYV3p8q4Ubxlf7aOtIsp8asXb0
         D5dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqY3fehcr7shD7qmXe2PTGCc3CHVIDMx16NtGat+4VNqbACaUm3Mo6ZslAZVkWu87H1DaR1xR1Fhd5WGxN@vger.kernel.org, AJvYcCXw7rxKrRuI983YzBGQrE5pFMbjzEiQuVfwXXi3jlQ6NBFslmRL+qGmbt8roAowJfKY6+bRLdTTGjk7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Tx7U5dnz8wmp1U+w5urGBRtTTJgYWwy2hB4NhY6MpBOOICmh
	05MvtmUrYYi5P/aiRxPUG6rBMXpEks/mNdBbyGr+cH7nO3vmK3XulmJsDH/aG8eY
X-Gm-Gg: ASbGnctlRvn6WTcji/ffpSAyBbYddoluIQTB+v1JC/6y5SLL29i4qBPEOMaAo0BVmWI
	RUmuxyAvr5bXZKtD/PHMGro6YDEDrQZiHFwRs/vet/pJnfUOMmrKUDFs/tbxUaNi/wlQ2uN7WAw
	UyN9dOLMBMCgMVi5KshRYm7/L9XV9NixW60WyMY2P7T5UkIw+B8GWwWBJO0Efg7rdPsXZYmQmXn
	Wi5zkZDV6db9t8rII/kLDLDkLGdzwWSAfwbHEkWF926soN8+bNzYUKPPAUMoJhBXw1Cr9ZP99gt
	DG7M4SF5AOK4BN9VwMNRPDJoPvYMq4afORJVTw56cF7OIyWwc3CwLlZ1/FwxoWeU+5UkIGHwvh2
	YpQxdBlwzgCSRNNeqqmQaHK+KOEpl1p4+Hy+tpA==
X-Google-Smtp-Source: AGHT+IGVO4cvKitoUzSJ7KeNwWEBPkBnDvhVrfdBR1/AYHjERdFT484mGqFALdLlEMk6PEQ6CBZQxQ==
X-Received: by 2002:a17:907:8e97:b0:ad4:d335:d35d with SMTP id a640c23a62f3a-ad52d45ae47mr2035316166b.4.1747851972839;
        Wed, 21 May 2025 11:26:12 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:8d0:f08c:4e6a:b32f? ([2620:10d:c092:600::8a7e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4cc5dbsm934634266b.169.2025.05.21.11.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 11:26:03 -0700 (PDT)
Message-ID: <9ca3f5eb-e76f-4135-91d8-363851f5c3ea@gmail.com>
Date: Wed, 21 May 2025 19:25:59 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 SeongJae Park <sj@kernel.org>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
 <djdcvn3flljlbl7pwyurpdplqxikxy6j2obj6cwcjd4znr6hwj@w3lzlvdibi2i>
 <b78e0fd8-e6b9-47c6-bec8-a44a8be242f1@gmail.com>
 <1a7be28f-c805-4092-a7dc-d71759920714@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <1a7be28f-c805-4092-a7dc-d71759920714@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/05/2025 18:39, Lorenzo Stoakes wrote:
> On Wed, May 21, 2025 at 05:57:48PM +0100, Usama Arif wrote:
>>
>>
>> On 21/05/2025 17:28, Shakeel Butt wrote:
>>> On Wed, May 21, 2025 at 05:21:19AM +0100, Lorenzo Stoakes wrote:
>>>> On Tue, May 20, 2025 at 03:02:09PM -0700, Shakeel Butt wrote:
>>>>
>>> [...]
>>>>
>>>> So, something Liam mentioned off-list was the beautifully named
>>>> 'mmadvise()'. Idea being that we have a system call _explicitly for_
>>>> mm-wide modifications.
>>>>
>>>> With Barry's series doing a prctl() for something similar, and a whole host
>>>> of mm->flags existing for modifying behaviour, it would seem a natural fit.
>>>>
>>>> I could do a respin that does something like this instead.
>>>>
>>>
>>> Please let's first get consensus on this before starting the work.
>>>
>>> Usama, David, Johannes and others, WDYT?
>>>
>>
>> I would like that. Introducing another method might make the conversation a
>> lot more complex than it already is?
> 
> The argument is about prctl() vs. another method.
> 

So there are a few things that have been on the mailing list prctl, process_madvise, 
bpf, cgroup based (although that was shot down). I meant adding another one to all
of them. But please see below.

> Another method was proposed, arguments were made that it didn't seem
> suitable, so an alternative was proposed.
> 
> I'm really not sure what complexity this adds?
> 
> And what better means of comparing approaches than actual code? Isn't an
> entirely theoretical discussion less helpful?

Sounds good!

> This feels a little like dismissing my input (and I note, Liam's points
> remain unanswered), and I have to admit, that is a little upsetting.
> 

The current prctl version is a lot lot better only because of your input.
The previous version had flags2, MMF flags, was breaking vm merge.
All of it was fixed only because of your valuable input.

So I have never dismissed your input, and try my best to reply quickly
to your and everyone elses reviews. We disagree on the best way forward
(whether prctl is appropriate) and I think disagreeing is definitely part
of good engineering. Please always assume I am acting in good faith.

As to not replying to Liams review, if its
https://lore.kernel.org/all/ass5hz6l26jc6xhbtybmgdjf55hmb3v4vvhrxhqampv6ohl67u@qi6iacwzwfk5/
I had already done it several hours ago.
If there was a email bashing prctl on how it is a bitrot and where everything
goes to die, I really dont know how to reply to that anymore.
Otherwise I might have missed it. I really hope one thing is
clear from our interactions over the past week, that I always try
and address feedback.

And for the upsetting part, from all the WTF reactions on my v2,
and all the rest of discussions we have had, I feel you have always
been upset with whatever I have sent (patches/replies), which I really
really don't understand.
We will have disagreements, its part of the dev process. The current version
wasnt going to get any acks, and was not going to get merged in any form,
so I really dont get it. Again, please always assume I am acting in good faith.

> But I suppose one has to have a thick skin in the kernel.
> 
>>
>> I have addressed the feedback from Lorenzo for the prctl series, but am
>> holding back sending it as RFC v4.
>> The v3 has a NACK on it so I would imagine it would discourage people
>> from reviewing it. If we are still progressing with sending patches, would it
>> make sense for me to wait a couple of days to see if there are any more comments
>> on it and send the RFC v4?
> 
> I've no problem with you respinning RFC"s, as I've said more than once. The
> NACK has been explained to you, it's regrettable, but necessary I feel when
> explicit agreed-upon review has not been actioned (obviously I realise it
> was a mistake - but this doesn't make it less important to be clear like
> this).
> 
> As to stopping and having a conversation about which way forward makes most
> sense - I feel like that's what I've been trying to do the whole time? I
> would like to think my input is of value, it is a pity that it seems that
> it apparently is not.
> 
> I am obviously happy to hear other people's input. This is what I've been
> working very hard to try to establish, partly by providing _actual code_ so
> we can see how things compare.
> 
> It seems generally people don't have much of a strong opinion about the
> interface, other than Liam (forgive me if I am misinterpreting you Liam and
> please correct if so) and myself very strongly disliking prctl() for
> numerous aforementioned reasons.
> 
> I would suggest that in that case, and since we maintain madvise()
> interfaces, it would make sense for us therefore to pursue an alternative
> approach.
> 
> But for the absolute best means of determining a way forward I'd suggest an
> RFC is best.

Sounds good to me.
> 
> Thanks.


