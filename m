Return-Path: <linux-arch+bounces-15458-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BD9CC14CF
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 08:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8DB63020CDE
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 07:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69CB33A70A;
	Tue, 16 Dec 2025 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lm5xSb2X"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F142C026F
	for <linux-arch@vger.kernel.org>; Tue, 16 Dec 2025 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765870041; cv=none; b=HXM/fnG5aescx+FcEU6YLqzhmQ4fuDNkuNjxjJ0WzDLRs6DySNvnc8CR3G0yhYiGC63MHhJzk6uATmc+da+o/XxhuwFmrqubcYBzqnorN5mPg+X4JpkYA0sFq/xLO2nrSfdgvDVRjKxfFHHMQdx42WPrt5Tc4TyTJ5XHqP1KPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765870041; c=relaxed/simple;
	bh=0kPUYHQ/G4RfpscPzI7pr0OmdhWbcBqqBUxeWAMHLZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ai+tsPUXc/rZRcMPwZPerbhWW6j7fQKS5DqoyxM4gvuU797GoHwcwqkTVPsLNAJl+R0f82Yr97aPHbcKqYGs1+GiFSRtV39kY0tgUJxSYZ5lfL76Tx/8GnqjgFLD7RoAI3j7TrZR7D8xFOf+nn4m5Fc/RzGgoNlAimYjl1PANik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lm5xSb2X; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a12ed4d205so7866865ad.0
        for <linux-arch@vger.kernel.org>; Mon, 15 Dec 2025 23:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765870037; x=1766474837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJCA2xXmtdABe9cuOOw6HKVAFYxYWKkv6zuIQkQSiJk=;
        b=lm5xSb2XbgVJJua1CVQR22c9ySMunRfdv1obZuP3q9tqFUszoVK2AI81SnQikH6oQo
         MtZz3tXiWDkspnAJG9pRyQ4Ltm06lq4i0Y/1r6nrQ7n4NUfmCokCI9OJPNpEk+hVlTjr
         XtN9sbaOTK5KT0dqsURNXid7bpMHi3fCUu0lY49pRKjE2znj9nJwumsy+1PDrz2nnb/l
         4qpvGvPntnl1xo+o7Y4hi81Lvd+3SOYfrOEWvRsh6zm87jsFXDWgQIMlAfslkwc275NP
         L8+hfzcADz4BBx0QSc8lGEPh4F8coTr0wJC7uaehXSjP/n37CM9ALb0Izpzc84CUHXKo
         sm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765870037; x=1766474837;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJCA2xXmtdABe9cuOOw6HKVAFYxYWKkv6zuIQkQSiJk=;
        b=a5OE73YWuTAXBsyTNXkpj+u1D94M7jRooh2ZY1Pd1rOy5U/IOqWTSekBhmcst2RbtM
         R+LeRH02BvNIiSXsd7Y+ALK5LBjsS2PbFQ09gUN3tgJVybneaUyUy025hPglZchfkBqb
         XTZrKcMo3U1a3RPpMrw4jv09ucZ08zquCKuMEP4NT5MTBTyTW8du1PmklR743IQeAbqv
         5T9hw9Tr31d9p7G5DMf7KidELWYjndWBu9uwRWYxDsQjZj6mWk+BQBRHGa37MtzX7G1T
         t0mCtWM0/aD7E6/tPg7BL+fxB5Q5iK1Agqi9Ypspaaj/ICAO1JuLfApO1XfEWwzW0roD
         BF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZAG16ELs2DUfpXgfKPANGePFbwAS8A8O1yrDJ9Q/w7n+wNM0+DZwK0m6vgA32plNTcx8cXa33PPqH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1qbF6f0xBPVmSsV8JZgjY5mLglyDovn2sRfwZaG8Oojow50bh
	/2dwaI1SsEjAxrqa5dwRC7uphmS+OJiMuTD7lnem21crFLmrDN0wl+IOK00WA0K1hVI=
X-Gm-Gg: AY/fxX4UsTATeqxjvKjxoSm4AKJV4kp+DO1kHAAkDAyg5FrLGKV+bLU+wF98MdWFO9l
	rC/WZVY0Ukl8Pg4/7M0205ev5SGsYaa7SnQ1+AQwfRHwDj/AgOrE/ZKmtjNNB2m8IMgqnyaNcBr
	Ww0KTE+2j1/dR/f5Ems/HYzqcRh97vLsIjmZ3NzRY1rIAbTpc4a6aSbBYalPxiIlt1BlTto0oSF
	3yJqhUKldAX8gyy8rzBJRwv7aW3aAznQvlOH9bx0pSMG4S9KVZSSqeWcvLoVmHrxDP1UiOtRSDx
	42ZUJII1uZMqlQv5TVIKInGm6mjM49SQJh5I/4VGKgWIGmR+0ur6erwspy4Qx2qUpFuSmDZNgUZ
	3iz0kiPdkT6pi83cdcI+NrBdjlRDjfMQxonmKLBkKQ45D9k+Um7FE8wE4xX60IYI+89Yge3vHRu
	R0T+svo7ASGrWpThKDE96HlFP91S/S2xmYU8jmp5EJOKin2VVRzTIpow==
X-Google-Smtp-Source: AGHT+IG0XHPlxrZ19+Thmc35PPwHSeilDW9jn34WiJoQPAtDXf3ILNz55k3pKMcPVzcVte7yg4mphg==
X-Received: by 2002:a17:902:ea0b:b0:297:dabf:9900 with SMTP id d9443c01a7336-29f23bde313mr144794935ad.0.1765870036820;
        Mon, 15 Dec 2025 23:27:16 -0800 (PST)
Received: from [192.168.10.197] (14-201-17-74.static.tpgi.com.au. [14.201.17.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9b36a80sm155735495ad.19.2025.12.15.23.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 23:27:16 -0800 (PST)
Message-ID: <93297eb0-1ad4-40ba-9438-ac02aa6b1d6b@linaro.org>
Date: Tue, 16 Dec 2025 09:27:03 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] Introduce meminspect
To: Randy Dunlap <rdunlap@infradead.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com, corbet@lwn.net, david@redhat.com,
 mhocko@suse.com, linux-debuggers@vger.kernel.org,
 "kees@kernel.org" <kees@kernel.org>
Cc: tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org,
 Trilok Soni <tsoni@quicinc.com>, Kaushal Kumar <kaushalk@qti.qualcomm.com>,
 Shiraz Hashim <shashim@qti.qualcomm.com>,
 Peter Griffin <peter.griffin@linaro.org>, stephen.s.brennan@oracle.com,
 Will McVicker <willmcvicker@google.com>,
 "stefan.schmidt@linaro.org" <stefan.schmidt@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <bf00eec5-e9fe-41df-b758-7601815b24a0@linaro.org>
 <5903a8e1-71c6-4546-ac50-35effa078dda@infradead.org>
 <c3db6ccd-dfc7-4a6a-82b7-3d615f8cab4f@linaro.org>
 <b74aef93-9138-413a-8327-36c746d67e10@infradead.org>
 <93682055-4a6d-4098-b74f-afef735d1699@infradead.org>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <93682055-4a6d-4098-b74f-afef735d1699@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/16/25 09:00, Randy Dunlap wrote:
> 
> 
> On 12/15/25 10:54 PM, Randy Dunlap wrote:
>>
>>
>> On 12/12/25 11:22 PM, Eugen Hristev wrote:
>>>
>>>
>>> On 12/13/25 08:57, Randy Dunlap wrote:
>>>> Hi,
>>>>
>>>> On 12/12/25 10:48 PM, Eugen Hristev wrote:
>>>>>
>>>>>
>>>>> On 11/19/25 17:44, Eugen Hristev wrote:
>>>>>> meminspect is a mechanism which allows the kernel to mark specific memory
>>>>>> areas for memory dumping or specific inspection, statistics, usage.
>>>>>> Once regions are marked, meminspect keeps an internal list with the regions
>>>>>> in a dedicated table.
>>>>>
>>>>> [...]
>>>>>
>>>>>
>>>>>> I will present this version at Plumbers conference in Tokyo on December 13th:
>>>>>> https://lpc.events/event/19/contributions/2080/
>>>>>> I am eager to discuss it there face to face.
>>>>>
>>>>> Summary of the discussions at LPC talk on Dec 13th:
>>>>>
>>>>> One main idea on the static variables annotation was to do some linker
>>>>> magic, to create a list of variables in the tree, that would be parsed
>>>>> by some script, the addresses and sizes would be then stored into the
>>>>> dedicated section at the script level, without having any C code change.
>>>>> Pros: no C code change, Cons: it would be hidden/masked from the code,
>>>>> easy to miss out, which might lead to people's variables being annotated
>>>>> without them knowing
>>>>>
>>>>> Another idea was to have variables directly stored in a dedicated
>>>>> section which would be added to the table.
>>>>> e.g. static int __attribute(section (...)) nr_irqs;
>>>>> Pros: no more meminspect section Cons: have to keep all interesting
>>>>> variables in a separate section, which might not be okay for everyone.
>>>>>
>>>>> On dynamic memory, the memblock flag marking did not receive any obvious
>>>>> NAKs.
>>>>>
>>>>> On dynamic memory that is bigger in size than one page, as the table
>>>>> entries are registered by virtual address, this would be non-contiguous
>>>>> in physical memory. How is this solved?
>>>>> -> At the moment it's left for the consumer drivers to handle this
>>>>> situation. If the region is a VA and the size > PAGE_SIZE, then the
>>>>> driver needs to handle the way it handles it. Maybe the driver that
>>>>> parses the entry needs to convert it into multiple contiguous entries,
>>>>> or just have virtual address is enough. The inspection table does not
>>>>> enforce or limit the entries to contiguous entries only.
>>>>>
>>>>> On the traverse/notifier system, the implementation did not receive any
>>>>> obvious NAKs
>>>>>
>>>>> General comments:
>>>>>
>>>>> Trilok Soni from Qualcomm mentioned they will be using this into their
>>>>> software deliveries in production.
>>>>>
>>>>> Someone suggested to have some mechanism to block specific data from
>>>>> being added to the inspection table as being sensitive non-inspectable
>>>>> data.
>>>>> [Eugen]: Still have to figure out how that could be done. Stuff is not
>>>>> being added to the table by default.
>>>>>
>>>>> Another comment was about what use case there is in mind, is this for
>>>>> servers, or for confidential computing, because each different use case
>>>>> might have different requirements, like ignoring some regions is an
>>>>> option in one case, but bloating the table in another case might not be
>>>>> fine.
>>>>> [Eugen]: The meminspect scenario should cover all cases and not be too
>>>>> specific. If it is generic enough and customizable enough to care for
>>>>> everyone's needs then I consider it being a success. It should not
>>>>> specialize in neither of these two different cases, but rather be
>>>>> tailored by each use case to provide the mandatory requirements for that
>>>>> case.
>>>>>
>>>>> Another comment mentioned that this usecase does not apply to many
>>>>> people due to firmware or specific hardware needed.
>>>>> [Eugen]: one interesting proposed usecase is to have a pstore
>>>>> driver/implementation that would traverse the inspection table at panic
>>>>> handler time, then gather data from there to store in the pstore
>>>>> (ramoops, mtdoops or whatever backend) and have it available to the
>>>>> userspace after reboot. This would be a nice use case that does not
>>>>> require firmware nor specific hardware, just pstore backend support.
>>>>>
>>>>> Ending note was whether this implementation is going in a good direction
>>>>> and what would be the way to having it moving upstream.
>>>>>
>>>>> Thanks everyone who attended and came up with ideas and comments.
>>>>> There are a few comments which I may have missed, so please feel free to
>>>>> reply to this email to start a discussion thread on the topic you are
>>>>> interested in.
>>>>>
>>>>> Eugen
>>>>>
>>>>
>>>> Maybe you or someone else has already mentioned this. If so, sorry I missed it.
>>>>
>>>> How does this compare or contrast to VMCOREINFO?
>>>>
>>>> thanks.
>>>
>>> This inspection table could be created in an VMCOREINFO way, the patch
>>> series here[1] is something that would fit it best .
>>>
>>> The drawbacks are :
>>> some static variables have to be registered to VMCOREINFO in their file
>>> of residence. This means including vmcoreinfo header and adding
>>> functions/code there, and everywhere that would be needed , or , the
>>> variables have to be un-static'ed , which is a no-go.
>>> This received more negative opinions on that particular patch series.
>>> The annotation idea seemed cleaner and simpler, and more generic.
>>>
>>> We could add more and more entries to the vmcoreinfo table, but that
>>> would mean expanding it a lot, which it would maybe defy its purpose,
>>> and be getting too big, especially for the cases where custom drivers
>>> would like to register data.
>>>
>>> How I see it, is that maybe the vmcoreinfo init function, could also
>>> parse the inspection table and create more entries if that is needed.
>>> So somehow memory inspection is a superset or generalization , while
>>> VMCOREINFO is a more particular use case that would fit here.
>>>
>>> Do you think of some better way to integrate the meminspect table into
>>> VMCOREINFO ?
>>
>> No, I just wanted to make sure that you or someone had looked into that.
>> Thanks for your summary.
> 
> Although you copied Stephen Brennan on this, I think it would be a good idea
> to copy the linux-debuggers@vger.kernel.org mailing list also to see if
> there are any other comments about it. [now done]

Thanks . I copied Stephen because we had a discussion at LPC at his talk
and he also attended my talk.

I also had a nice talk with Kees Cook and he was very interested in
having pstore as a backend for meminspect. (copied now as well)

> 
>>> [1]
>>> https://lore.kernel.org/all/20250912150855.2901211-1-eugen.hristev@linaro.org/
>>
> 


