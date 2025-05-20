Return-Path: <linux-arch+bounces-12036-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9A3ABE3E8
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 21:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FE51BA7A06
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 19:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3564525A645;
	Tue, 20 May 2025 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL7l4Ypt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2B6211710;
	Tue, 20 May 2025 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770177; cv=none; b=uW/2V4NjqcZxggQQ8B+62zgcz+csy8SV4DIsK6ryqdGX0GJYfEriAHWXqJfQEow0i0MlmoP5X2VRGStWBuXiqgZtve/P1zzXlszW6U48nxF/QR4Lc97/gW/aetxJJ5zs42HM1umUeuvp2TJQ59U/qUl13IqlfANpwg+F7jHbsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770177; c=relaxed/simple;
	bh=rSaHqlEa0/9KBk7nQwllsDEbh4ekAwKhim2xZa3MMtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EusUL2sW2IzKykg08WVv3sTbHaFNI+QiPAFAkziTG8YeerPyBT3dbYDfbQ2adUZAw+t1E/qJNeFZzT8OMcvFaccFZWUOU3SujzPHCR97mtAQYAa6SPwH72sdk3dpYxcnqwacf1+eNOW6kZT9JIvw/7e3aN1+glhWnLuPuMARiEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL7l4Ypt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a3798794d3so1012591f8f.1;
        Tue, 20 May 2025 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747770173; x=1748374973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8/ebf0A9j6CCoFjBYvrihW4UNty1QDXWjnaJPkkgD4=;
        b=NL7l4YptOdQUHmDca3WBoadFCjAh32CcZ6JS72lIVs6umQ4BOHW8tALwSx2fSLOBCK
         hUZh9pn52Yb99PR9vikpYSNx/ljg7IFZ317gBxx2Ur4+xOWmJ2UxcduLAD5OUQpyrg3g
         azR2CAYQcB2bnvZ40K8SobRA7riQk9AADuvEaQs3JXMCbpYg/BtooGy108iCVNPZGUZI
         M2MlH5Se7TuBHdP6UoqMUT2Z8vMhNMQ0dhBDYVco5kwdOW6ats/2+/ZI7MBzpe5y6AMH
         yMoSo9xGg8IWjmO+NxkJb/6ke8GFy/BL+mxwjy/9GOvlMcWBXeQWfyne2vcz51zt7a2m
         hjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747770173; x=1748374973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8/ebf0A9j6CCoFjBYvrihW4UNty1QDXWjnaJPkkgD4=;
        b=ar2anc7FdcQtnI5a7febudlWWKN6U93wCodL3+ffNyGzJx4jm78pws24OryvbQNvXu
         2KEOllxBHpAm+85GfQe3kfgV1VAHJ0Eef2tzJQ0PgOV43ART4eTAaelDEhJbBi/Lzhu5
         LlIIl7Tr7QtpCFR2PEYUI2n8Ee73C4vLf1TiRebJEwWFTPMHNpL/7QPsXuacFXJTAALQ
         iygU5lPYuzIWw84RYx1/XqCgbSq2l9bkar+5IZBzFuNjiwYdulmGQxcLq3FIiixjCjnD
         6wGJ7I4Wf05vKfbdPqBdz91+bMlCIuCwJHPKAnyOHsfdZfv9IdZuVyTMsnmjSOp5CphQ
         2Kbw==
X-Forwarded-Encrypted: i=1; AJvYcCVKTIh/HDPKkm5Gm7HKpsr99v4uCPNX0i69Ju6GlpjRpJuoHCc0Ythxi2JX2FNq1dIa9GndKhBV8Pbs@vger.kernel.org, AJvYcCX7/tvXBehbxYDWwTZEt00g1mr5sdI4m/OkP6/wRcRb/rRG7K4fI3zgSqHZqnmQETYJ7P4oyF1JX6J0t8Qs@vger.kernel.org
X-Gm-Message-State: AOJu0YxQf69nTLYTYH2kGcqRj28wQm+s49Ykvqp6MPLHJabdCoNYu8Rv
	681BrYLXpZfYAeBeXuxfd1T8MyuloPZB1bdUO1yhWB9a2Ml0/BsbLFE7
X-Gm-Gg: ASbGncty7gJNY/y2X/eu5W0+38aTUvnbYfKi6X0wLteiCa9eku94YKIpgBm2uwkpJ/E
	LCgPsfjKHKQptGTyT3+vCupWUQBwXkac4oW2IxBVeL6hMhZ0Uvqs5AKNUm3NCdWyShIXgtuyspf
	1ykjwCrk0MeM1DUy7Im7TGlnZ3Vu7NQsghRiX1cEoWn+Y1vBPTo3lZZTTVy6v0xN3iu94Ic3/RD
	hme8ShUUUYkjb8tjouPCs4VdHCsXgrgPJtV94SSz+IlY3+JCdJ6S68h1jpGhmB76kEHVuV7kiTV
	r7KQnsmh10WfPJHY3uf2TnBFXs2H34QBaUFM4VzDhF6sZWXAFsKnoVY1l/62graoG8cKrXptvsT
	vQkxrvggLYsYl9r2XESN+2CqBAu4kk/UMS6eaWJ3AXyx+Ez8=
X-Google-Smtp-Source: AGHT+IHwub0ANp1PAyWu1WETxaMWydTvoEugbVklserPnEC3aohGFhjp77Ajn7kVv2Vzm4zrO2KNbw==
X-Received: by 2002:a05:6000:2509:b0:3a3:7bbc:d957 with SMTP id ffacd0b85a97d-3a37bbcdaa6mr2895761f8f.33.1747770173020;
        Tue, 20 May 2025 12:42:53 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:f900:146f:2c4f:d96e:4241? ([2a02:6b6f:e750:f900:146f:2c4f:d96e:4241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a36749f622sm13545142f8f.93.2025.05.20.12.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 12:42:51 -0700 (PDT)
Message-ID: <b45657a7-27e2-45a1-8f4d-0941216482cf@gmail.com>
Date: Tue, 20 May 2025 20:42:50 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Zi Yan <ziy@nvidia.com>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <dd062c92-faa9-46a6-99a8-bcc46209e102@redhat.com>
 <c54d2c5b-e061-4e77-ac10-3c29d5ccf419@lucifer.local>
 <ae53fa82-d8de-4c02-95f7-7650a03ea8e7@gmail.com>
 <8417a42c-102c-4f35-8461-842343d7df23@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <8417a42c-102c-4f35-8461-842343d7df23@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/05/2025 20:21, Lorenzo Stoakes wrote:
> On Tue, May 20, 2025 at 07:24:04PM +0100, Usama Arif wrote:
>>
>>
>> On 20/05/2025 18:47, Lorenzo Stoakes wrote:
>>> On Tue, May 20, 2025 at 05:28:35PM +0200, David Hildenbrand wrote:
>>>> On 19.05.25 22:52, Lorenzo Stoakes wrote:
>>>>> REVIEWERS NOTES:
>>>>> ================
>>>>>
>>>>> This is a VERY EARLY version of the idea, it's relatively untested, and I'm
>>>>> 'putting it out there' for feedback. Any serious version of this will add a
>>>>> bunch of self-tests to assert correct behaviour and I will more carefully
>>>>> confirm everything's working.
>>>>>
>>>>> This is based on discussion arising from Usama's series [0], SJ's input on
>>>>> the thread around process_madvise() behaviour [1] (and a subsequent
>>>>> response by me [2]) and prior discussion about a new madvise() interface
>>>>> [3].
>>>>>
>>>>> [0]: https://lore.kernel.org/linux-mm/20250515133519.2779639-1-usamaarif642@gmail.com/
>>>>> [1]: https://lore.kernel.org/linux-mm/20250517162048.36347-1-sj@kernel.org/
>>>>> [2]: https://lore.kernel.org/linux-mm/e3ba284c-3cb1-42c1-a0ba-9c59374d0541@lucifer.local/
>>>>> [3]: https://lore.kernel.org/linux-mm/c390dd7e-0770-4d29-bb0e-f410ff6678e3@lucifer.local/
>>>>>
>>>>> ================
>>>>>
>>>>> Currently, we are rather restricted in how madvise() operations
>>>>> proceed. While effort has been put in to expanding what process_madvise()
>>>>> can do (that is - unrestricted application of advice to the local process
>>>>> alongside recent improvements on the efficiency of TLB operations over
>>>>> these batvches), we are still constrained by existing madvise() limitations
>>>>> and default behaviours.
>>>>>
>>>>> This series makes use of the currently unused flags field in
>>>>> process_madvise() to provide more flexiblity.
>>>>>
>>>>
>>>> In general, sounds like an interesting approach.
>>>
>>> Thanks!
>>>
>>> If you agree this is workable, then I'll go ahead and put some more effort
>>> into writing tests etc. on the next respin.
>>>
>>
>> So the prctl and process_madvise patches both are trying to accomplish a
>> similar end goal.
>>
>> Would it make sense to discuss what would be the best way forward before we
>> continue developing the solutions? If we are not at that stage and a clear
>> picture has not formed yet, happy to continue refining the solutions.
>> But just thought I would check.
> 
> As stated in the thread (I went out of my way to link everything above),
> and stated with you cc'd in every discussion (I think!), this idea arose as
> a concept that came out of my brainstorming whether we could better align
> this concept with madvise().
> 
> This arose because of discussions had in-thread where we agreed it made
> most sense to have this feature in effect perform a 'default madvise()'.
> 
> At this point, we are essentially _duplicating what madvise does_ in the
> prctl() with your approach, only now all of the code that does that is
> bitrotting in kernel/sys.c.
> 
> This approach was an attempt to avoid that.
> 
> It started as a 'crazy idea' I was throwing out there, as an RFC. The idea
> was we could compare and contrast with the prctl() RFC.
> 
> Obviously this is gaining some traction now as a concept and your respin
> was a little rushed out so needs rework.
> 
> So, apologies if it seems this is an attempt to supercede your series or
> such, it truly wasn't intended that way, rather I have been working 12 hour
> days trying to find the best way possible to _make what you want happen_
> while also doing what's best for mm and madvise (among many other tasks of
> course :)

Please don't burn out spending 12 hour days on this! Your feedback is very
amazing! (Thanks again!) It will take time to come up with a solution right
for the kernel!

> 
> So the idea is we can:
> 
> a. solve long-standing problems with madvise() that prevent it being used
>    for certain things (e.g. the error on gaps which breaks
>    process_madvise() and hides real errors)
> 
> b. Also provide this functionality in a way that the absolute most minimal
>    delta from existing logic...
> 
> c. ...While keeping all this logic in mm and avoiding bitrot in
>    kernel/sys.c.
> 
> So obviously my view is that this approach is superior to the prctl() one.
> 
> However the intent was that you would probably take a little longer in
> spinning up an RFC, and then we could compare the two approaches, if people
> didn't reject my 'crazy idea' :)
> 
> Obviously you respan your (kinda ;) RFC way quicker than expected, and then
> there were a ton of bugs, which added workload and made it perhaps a little
> more pressing as to deciding which should be pursued.
> 

I feel like a ton (i.e. a thousand) sounds like a lot, there are a couple of bugs
in a series I meant to send as an RFC (mistakes happen :)). I will wait a couple
of days to see how things develop and send a prctl RFC (will remember the tag this
time) and we can have a better comparison of what this would look like.

> I would suggest holding off on your series until we see whether this one
> works on this basis. But obviously this is simply my point of view.
> 
> To be clear however, this was not a planned series of events...
> 
> I mean equally, we are seeing several other series from Yafang, Nico and
> Dev in relation to [m]THP and even a obliquely-related series from Barry,
> so it seems we are in contention across many planes here :)
> 
>>
>> I feel like changing process_madvise which was designed to work on an array
>> of iovec structures to have flags to skip errors and ignore the iovec
>> makes it function similar to a prctl call is not the right approach.
>> IMHO, prctl is a more direct solution to this.
> 
> I don't know what you mean by 'function similar to a prctl call', or what
> you mean by it being a more direct solution.

So I thought I was going a bit crazy, but I am glad someone else raised this as well.

If we look at the man page for prctl it says it manipulates various aspects
of the behavior of the calling thread or process.

If we look at the man page for prcocess_madvise, it was for providing advice for the
address ranges described by iovec and n

What I mean (and I assume Shakeel meant as well) is this is changing what
process_madvise was designed for into changing  the behaviour of a process (i.e. prctl).
This is what I mean by 'function similar to a prctl call'.


> 
> The problem with prctl() is there is no pattern, it's a dumping ground for
> arbitrary stuff and a prime place for bitrot. It also means we give up
> maintainership of mm-specific code.
> 
> It encourages misalignment with other interfaces and APIs.
> 
> What is being discussed here is an effort to _better align what you want
> with an existing interface_ - if we treat this as a 'default madvise()'
> plus having additional madvise functionality (apply to all, ignoring errors
> e.g.) - and put all this code _alongside existing madvise code_ - this
> makes this vastly more maintainable, futureproof and robust.
> 
> And keep in mind the proposed flags are _flags_ not default behaviours,
> ones which we will carefully restrict to known flags, starting with the
> flags you guys need.
> 
>>
>> I know that Lonenzo doesn't like prctl and wants to unify this in process_madvise.
>> But if in the end, we want to have a THP auto way which is truly transparent,
>> would it not be better to just have this as prctl and not change the madvise
>> structure? Maybe in a few years we wont need any of this, and it will be lost
>> in prctl and madvise wouldn't have changed for this?
> 
> This really sounds a lot like your colleague Shakeel's objection, so I
> don't want to duplicate my response too much, but as I said to him, at this
> stage we would set THP mode to 'auto', but still have to support
> MADV_[NO]HUGEPAGE.
> 
> We may then wish to set these as no-ops in auto mode right? But they'd
> still have to exist for uAPI reasons.
> 
> So would it be better to do this in mm/madvise.c alongside literally all
> other madvise() code and the existing handling for MADV_[NO]HUGEPAGE, or
> would it be better to throw it in kernel/sys.c and hope people remember to
> update it?
> 
> I think it's pretty clear what the answer to that is.
> 
>>
>> Again, this is just to have a discussion (and not an aggressive argument :)),
>> and would love to get feedback from everyone in the community.
>> If its too early to have this discussion, its completely fine and we can
>> still keep developing the RFCs :)
> 
> I try hard never to be aggressive, I am firm when I feel it is appropriate
> to be so (it's important to push back when necessarily I feel), but I
> always try to maintain civility as well as I can.
> 
> Of course I am imperfect, so apologies if it comes across any other way, I
> really do try very hard to maintain a high standard of professionalism
> on-list.
> 
> Again as I said, I really did not intend to supercede or interfere with
> your series, this was just unfortunate timing and throwing out ideas to
> reach the best solution.
> 
> My objection to prctl() is due to bit-rot, mm code in inappropriate places,
> the fact it by nature lends itself to violating conventions and practices
> that exist in other mm APIs, not some subjective sense of evil.
> 
> It is historically a place where 'things that people don't really care
> about but don't quite want to NACK' go also, and to me suggests that the
> problem hasn't necessarily been thought through to see how it might be
> implemented by extending existing APIs or finding ways to achieve the same
> thing that better align with existing intefaces.
> 
> To be clear - this concept is _all_ ultimately a product of your series and
> your ideas leading the discussion within the community to this point where
> a potential alternative has arisen - without which this would not have
> occurred.
> 
> So the idea here is to simply explore what the best solution is that aligns
> with what best serves the community.
> 
>>
>> Thanks!
>> Usama
> 
> Thanks, Lorenzo


