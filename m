Return-Path: <linux-arch+bounces-13259-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E082CB3401F
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 14:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A39170598
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBA223D297;
	Mon, 25 Aug 2025 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhEYek19"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2F21C161
	for <linux-arch@vger.kernel.org>; Mon, 25 Aug 2025 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126513; cv=none; b=C+5dcffUZIuZ2FHjxuhoV/VtwC9AGVln4jJUDtWHM7owQF9bd3WXhIFr5CTJepigRW89JvjBWqymy9CcZMqbLAYk6LzNR6NhU8heDg8QuFOBEqN8D0szXCcaAmeEACroqqp0MKQSIcAru7FTUkWmGuJnVoLRlI/cNl4P7tvns8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126513; c=relaxed/simple;
	bh=p6Zmaj5smnWJq2PWn5FiDiA6cSwI6w5qSVM1iEtB1lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOcXaj+JRv8nBqV35CGX8sbrKB2mQlpAU0ppzDZ2XoWS7KkGOGV4cBKL3R2Nesr072nt7rdcgE56j+OJgwZPjXa0gJ2CQe/UvwRHGD4bSMuNGchEF2/M28T6a0RTJ5MKl9R82uGW2ecbT8NyuG1u3rWVHMFxDcWw2dsuluSPF0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XhEYek19; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3c79f0a604aso1006869f8f.2
        for <linux-arch@vger.kernel.org>; Mon, 25 Aug 2025 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756126510; x=1756731310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nyb7W0i1P3IjF0jcI+ICuOqZQ1VFzRLlpkO8ArSEv2U=;
        b=XhEYek19T5/sOMJKe+Xz4/zVwm71KDg/IEs2q2n0mApkAfodD9NJ7S5McLDgflqOOB
         vVeH1UUGz5sOuFNPJgLbnSSefMyh5FfHHbm9fY5KHLBt4MN2d4t9kieYx+Spt0B5Bv3G
         yyk+PJDpdnsvaYQhK2RRdvoQIEA8uFDqOLnYfIh/0nkJI6QfqL0IW4H+ayMC+kVB3mfD
         vSmeBya6U8JknaHWogW1GW3gEM6N+lpLOWSuLzsn7mZNfVbC0aGdxAMGCzdwbQGLK6PV
         iCcDaPWN0bwDNG4DqdMQWTCha0tI6rojMVmcCfgF5eX8G+ky9tXQ7KRcHFEVofARS5RK
         uSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756126510; x=1756731310;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nyb7W0i1P3IjF0jcI+ICuOqZQ1VFzRLlpkO8ArSEv2U=;
        b=DBa4v1EnUcMwc7dOSbLI9bvMZTNSbcnmt5tihREh6/9GXqTkS4di8+7A9KP6UPoieg
         pK0UJxwDWdVnIsazLqvTRIk69OmJ5jXye4wQ74457jsGMDBPOaOSOjsrjGyhqnD0AkNK
         dOmCiimge6jz784HLpT4K2KJzL6/T5zUFeLAdp8iDpbrUQIjYc7KpWoLH+NWDlhh8zUH
         Xy1bQuHrjEQ/rJMPoTtHe2SyKBDxKYaD63slJhwR6UAMmo/OoB8Cn4XqebugqlS76r9k
         G02pwmj3ySmO/KnWtKtJV6oxnkmGulk0xe//LZghxp65emNrNN6H9FeNZFNkzlU/ZD/R
         emJA==
X-Forwarded-Encrypted: i=1; AJvYcCX1VYPNQ2EnNu8ipQM3Uhi/3UgP3eQAzbFRiGFNTnUr4mc7lJX4Odmi+Iig8J5dP9nq1O3Xa6C6vBjB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3uuEovd9mIpAruCvNelAMmqmHqT1Ml+qBPhEmzShdbq3hNwhA
	FlYgKPeJSykAZIrZWihx6/b7p0sGJqBGgINq93qJlvxLXhHscRUcX0OUms1ABhCkEw8=
X-Gm-Gg: ASbGncvlA7p2hdFiYfPzrWPqedIO0vBuj8vj9Uam0TTJKKGVXyQL42z07CvgTFUsRhI
	81k8WW4xhF3Lwwbvw6mLgJmIqSM1KDWGx1TMx/5Kb4oArv1/cGLTXnf15HJjfJ+TdEbwRHg2n4+
	kws38J4YBEr9PnCkQ9KxpqdSey1FrR+I9wZIac4if5q49Pir1gcirQIGMDyYFegbhdXrxEqUg1a
	urHkJ5Dsn1d/gSVlhVuu7KmX9nQu9lz5Cnt0d0aVrH2a/45bv+VTBnCHDfJKTWQEX1raqDlK4Mj
	fa/z1WYUnyko6PHFoG5SvEuViYEGEAJhzPX+eDW05fDGXndM4gDvRvkG9jh1IALsKwn4T06kK+e
	CEjLvzElZBmA1ojmR1glbSGbvNQBhxQ==
X-Google-Smtp-Source: AGHT+IGiatYdBiQIlX08WDb3q8TgWhNu9cU7pZ5BZYgWH52vQcA/WE9cIPHsPYf1nJo7amAILSvRZA==
X-Received: by 2002:a05:6000:40dd:b0:3a4:d6ed:8df8 with SMTP id ffacd0b85a97d-3c5dc734927mr8857444f8f.39.1756126509927;
        Mon, 25 Aug 2025 05:55:09 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57487910sm107774225e9.15.2025.08.25.05.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 05:55:09 -0700 (PDT)
Message-ID: <64a93c4a-5619-4208-9e9f-83848206d42b@linaro.org>
Date: Mon, 25 Aug 2025 15:55:07 +0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org,
 Christoph Hellwig <hch@infradead.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-23-eugen.hristev@linaro.org>
 <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
 <e66f29c2-9f9f-4b04-b029-23383ed4aed4@linaro.org>
 <751514db-9e03-4cf3-bd3e-124b201bdb94@redhat.com>
 <aJCRgXYIjbJ01RsK@tiehlicka>
 <e2c031e8-43bd-41e5-9074-c8b1f89e04e6@linaro.org>
 <23e7ec80-622e-4d33-a766-312c1213e56b@redhat.com>
 <f43a61b4-d302-4009-96ff-88eea6651e16@linaro.org>
 <77d17dbf-1609-41b1-9244-488d2ce75b33@redhat.com>
 <ecd33fa3-8362-48f0-b3c2-d1a11d8b02e3@linaro.org>
 <9f13df6f-3b76-4d02-aa74-40b913f37a8a@redhat.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <9f13df6f-3b76-4d02-aa74-40b913f37a8a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 16:26, David Hildenbrand wrote:
> On 04.08.25 15:03, Eugen Hristev wrote:
>>
>>
>> On 8/4/25 15:49, David Hildenbrand wrote:
>>> On 04.08.25 14:29, Eugen Hristev wrote:
>>>>
>>>>
>>>> On 8/4/25 15:18, David Hildenbrand wrote:
>>>>> On 04.08.25 13:06, Eugen Hristev wrote:
>>>>>>
>>>>>>
>>>>>> On 8/4/25 13:54, Michal Hocko wrote:
>>>>>>> On Wed 30-07-25 16:04:28, David Hildenbrand wrote:
>>>>>>>> On 30.07.25 15:57, Eugen Hristev wrote:
>>>>>>> [...]
>>>>>>>>> Yes, registering after is also an option. Initially this is how I
>>>>>>>>> designed the kmemdump API, I also had in mind to add a flag, but, after
>>>>>>>>> discussing with Thomas Gleixner, he came up with the macro wrapper idea
>>>>>>>>> here:
>>>>>>>>> https://lore.kernel.org/lkml/87ikkzpcup.ffs@tglx/
>>>>>>>>> Do you think we can continue that discussion , or maybe start it here ?
>>>>>>>>
>>>>>>>> Yeah, I don't like that, but I can see how we ended up here.
>>>>>>>>
>>>>>>>> I also don't quite like the idea that we must encode here what to include in
>>>>>>>> a dump and what not ...
>>>>>>>>
>>>>>>>> For the vmcore we construct it at runtime in crash_save_vmcoreinfo_init(),
>>>>>>>> where we e.g., have
>>>>>>>>
>>>>>>>> VMCOREINFO_STRUCT_SIZE(pglist_data);
>>>>>>>>
>>>>>>>> Could we similar have some place where we construct what to dump similarly,
>>>>>>>> just not using the current values, but the memory ranges?
>>>>>>>
>>>>>>> All those symbols are part of kallsyms, right? Can we just use kallsyms
>>>>>>> infrastructure and a list of symbols to get what we need from there?
>>>>>>>
>>>>>>> In other words the list of symbols to be completely external to the code
>>>>>>> that is defining them?
>>>>>>
>>>>>> Some static symbols are indeed part of kallsyms. But some symbols are
>>>>>> not exported, for example patch 20/29, where printk related symbols are
>>>>>> not to be exported. Another example is with static variables, like in
>>>>>> patch 17/29 , not exported as symbols, but required for the dump.
>>>>>> Dynamic memory regions are not have to also be considered, have a look
>>>>>> for example at patch 23/29 , where dynamically allocated memory needs to
>>>>>> be registered.
>>>>>>
>>>>>> Do you think that I should move all kallsyms related symbols annotation
>>>>>> into a separate place and keep it for the static/dynamic regions in place ?
>>>>>
>>>>> If you want to use a symbol from kmemdump, then make that symbol
>>>>> available to kmemdump.
>>>>
>>>> That's what I am doing, registering symbols with kmemdump.
>>>> Maybe I do not understand what you mean, do you have any suggestion for
>>>> the static variables case (symbols not exported) ?
>>>
>>> Let's use patch #20 as example:
>>>
>>> What I am thinking is that you would not include "linux/kmemdump.h" and
>>> not leak all of that KMEMDUMP_ stuff in all these files/subsystems that
>>> couldn't less about kmemdump.
>>>
>>> Instead of doing
>>>
>>> static struct printk_ringbuffer printk_rb_dynamic;
>>>
>>> You'd do
>>>
>>> struct printk_ringbuffer printk_rb_dynamic;
>>>
>>> and have it in some header file, from where kmemdump could lookup the
>>> address.
>>>
>>> So you move the logic of what goes into a dump from the subsystems to
>>> the kmemdump core.
>>>
>>
>> That works if the people maintaining these systems agree with it.
>> Attempts to export symbols from printk e.g. have been nacked :
>>
>>   https://lore.kernel.org/all/20250218-175733-neomutt-senozhatsky@chromium.org/
> 
> Do you really need the EXPORT_SYMBOL?
> 
> Can't you just not export symbols, building the relevant kmemdump part 
> into the core not as a module.
> 
> IIRC, kernel/vmcore_info.c is never built as a module, as it also 
> accesses non-exported symbols.

Hello David,

I am looking again into this, and there are some things which in my
opinion would be difficult to achieve.
For example I looked into my patch #11 , which adds the `runqueues` into
kmemdump.

The runqueues is a variable of `struct rq` which is defined in
kernel/sched/sched.h , which is not supposed to be included outside of
sched.
Now moving all the struct definition outside of sched.h into another
public header would be rather painful and I don't think it's a really
good option (The struct would be needed to compute the sizeof inside
vmcoreinfo). Secondly, it would also imply moving all the nested struct
definitions outside as well. I doubt this is something that we want for
the sched subsys. How the subsys is designed, out of my understanding,
is to keep these internal structs opaque outside of it.

From my perspective it's much simpler and cleaner to just add the
kmemdump annotation macro inside the sched/core.c as it's done in my
patch. This macro translates to a noop if kmemdump is not selected.

How do you see this done another way ?

> 
>>
>> So I am unsure whether just removing the static and adding them into
>> header files would be more acceptable.
>>
>> Added in CC Cristoph Hellwig and Sergey Senozhatsky maybe they could
>> tell us directly whether they like or dislike this approach, as kmemdump
>> would be builtin and would not require exports.
>>
>> One other thing to mention is the fact that the printk code dynamically
>> allocates memory that would need to be registered. There is no mechanism
>> for kmemdump to know when this process has been completed (or even if it
>> was at all, because it happens on demand in certain conditions).
> 
> If we are talking about memblock allocations, they sure are finished at 
> the time ... the buddy is up.
> 
> So it's just a matter of placing yourself late in the init stage where 
> the buddy is already up and running.
> 
> I assume dumping any dynamically allocated stuff through the buddy is 
> out of the picture for now.
> 

The dumping mechanism needs to work for dynamically allocated stuff, and
right now, it works for e.g. printk, if the buffer is dynamically
allocated later on in the boot process.

To have this working outside of printk, it would be required to walk
through all the printk structs/allocations and select the required info.
Is this something that we want to do outside of printk ? E.g. for the
printk panic-dump case, the whole dumping is done by registering a
dumper that does the job inside printk. There is no mechanism walking
through printk data in another subsystem (in my example, pstore).
So for me it is logical to register the data inside the printk.

Does this make sense ?


