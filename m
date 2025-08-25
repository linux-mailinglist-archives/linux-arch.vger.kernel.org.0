Return-Path: <linux-arch+bounces-13262-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BC4B3428B
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 16:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACD247A3CCD
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDA52ECE91;
	Mon, 25 Aug 2025 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUHzYo1Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CE296BD5
	for <linux-arch@vger.kernel.org>; Mon, 25 Aug 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130327; cv=none; b=QHQbh9bdbxmT/NcHRg12pcXQ4M4uEERfSxQKZQQKIFeyR1GBzNJIccA9WgkNbdavI+6PEsxPjV7WyeXlLGQC/JiBoZv8PrymIPmNy2RIojyhbYjjgqBtmDj3Spt8htj2heAym3RF11QzKgRnAxBVrRcVAUeJb5QQOPx7wP3LNm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130327; c=relaxed/simple;
	bh=WFv47/bfQC5yqb9km1UweRl+PEYRC/wK+jHpav8jPyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsSDQH69qUTL1KYDtieLala4nodJ+ki7u9xOlgiHMuGc1vsEKLZLu6/8lHwSQA0V3Ru5+Wppub4d7XPNdEUr/gtq3iilcCtSEguuXyD/36GRwbCOpEXzKE4ELh9kQuXs6sq3tJPpQlPiBkOMKpfL6FCTSc4gWJPIpLS1n59Ob7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUHzYo1Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756130322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lxZho4Y+KRx8y6j3h2szyprS6aHvfITwJX6ZtyYAuvU=;
	b=dUHzYo1QMhnIDJ70VcAfoutw09A22jcb9wtVoUdZ7+N9t7BPw1jsL3nWidRrcDgCe+QeQr
	qeY5x9si2iPQkXeb/49VwsOeVmdhjK00RW3Y2em/dst3PHM2LeU4/Y+irdRP/7sxjeJmpz
	txik81m8l8m/j8/iEM+VzxVh9cAH4kY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-FxHNSXZGOZ2jtw3ekIxfCg-1; Mon, 25 Aug 2025 09:58:41 -0400
X-MC-Unique: FxHNSXZGOZ2jtw3ekIxfCg-1
X-Mimecast-MFC-AGG-ID: FxHNSXZGOZ2jtw3ekIxfCg_1756130320
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so26714295e9.1
        for <linux-arch@vger.kernel.org>; Mon, 25 Aug 2025 06:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130319; x=1756735119;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxZho4Y+KRx8y6j3h2szyprS6aHvfITwJX6ZtyYAuvU=;
        b=vcEDZjYNm8O2R0nYFMfNaDdntgP1rL3vWZC9VWw7jPAVLo71fj1EqwgS5q0sM/w8Mq
         J0Qr9DAJqEyvfAMcUaMz2Mo11i+Y1QCkRS9V3TyaY1o6CvDD/Lxv+dGOzSwzPcJsEEi5
         ZuNMpcqOO4CQ13RlkNNCGoUBENWugOUFhBcLRWuZky92NE26Ti64HSoedb8zKPmkE7EJ
         +mzGSVoeDd/wUhrHNe5ivMiPD36JxZIWDKkW1EA+bPpp6uh5SR5eR4oK8aeb716C++wi
         WMEbIqgH2ft5rahgBCi0kwYRyaeBVaZLkAnihyt9BtOb26fQHRbawHtAixspa0Fb0H9n
         KoUw==
X-Forwarded-Encrypted: i=1; AJvYcCV5SgFGIKQJ+ruR1UrrAJhdLUDrWEtUUbDsfzu1iYtkslZlRuKCqbj7PF6yZ1CEtlhenw9c05Kh6dCD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxifu7sIrXXBSBcCMBnZ3CvezXFCYSTMYZYqkmfVWMomRpKeP/Y
	KIUXqsRg/kO27rH4R8exoNDSq0o0XWLrMxEZyS6cVxxxOi1ltQ0bKODUWnIwHKTh4HMvctIVF0s
	XfQNOxaSeATrAAAd1C+YRdT+UKFfqtVCVLrgVMd7vw2+/j45JYOOYSY6LUscZ1zU=
X-Gm-Gg: ASbGncsZi8NemRJLr3lFAAdz54rjmWf3ZJb/9YYSQMQPajYsI1yKhXPTv0+mRY71jpS
	WlhTWV2HQoJLhzi8r7rP1tsFKcb3G4sQwdsmRPGoVu+kQo2SakHNkyYXdQKPD3HL0vdxI7kGa6e
	d7M/5EvP42K/N9DtfKCO2BJx7s0O0YbZqvTEUfTqZtKyjn13XWgFEUz5sp9hD10vcBlmFgqoc+v
	k5MFdhgR5epTqZRsnZ65Oj82fcbZUwvuLly9w+/VjVsW0X2Y1CtU3+HTpRvsI4y8SvsbE9900J/
	SCcVfbPFzH09wx3IpL3dcvV+1nT9WUvoYpzJRVwDDmP3S6PYn3RGfVgrDgEMOcDsVqM+dpWuMuq
	VVwGI7aNljBZzOaFPZh+uPQAsUKJNVvhoHnd/qqL2F/+vuUlCjolAYAJmEuTGwY2BG6w=
X-Received: by 2002:a05:600c:4fcd:b0:459:db71:74d7 with SMTP id 5b1f17b1804b1-45b517d40damr96554795e9.27.1756130319420;
        Mon, 25 Aug 2025 06:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUP97mRYMAecNrJv9oVP9Z9C++b8mVPFeDAzLUacXcCy2KdCSOT3ajUA1Q373UfCMlAX2K9A==
X-Received: by 2002:a05:600c:4fcd:b0:459:db71:74d7 with SMTP id 5b1f17b1804b1-45b517d40damr96554435e9.27.1756130318929;
        Mon, 25 Aug 2025 06:58:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76? (p200300d82f4f130042f198e5ddf83a76.dip0.t-ipconnect.de. [2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e1d77e0sm112049385e9.0.2025.08.25.06.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 06:58:38 -0700 (PDT)
Message-ID: <aab5e2af-04d6-485f-bf81-557583f2ae4b@redhat.com>
Date: Mon, 25 Aug 2025 15:58:37 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: Eugen Hristev <eugen.hristev@linaro.org>, Michal Hocko <mhocko@suse.com>
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
 <64a93c4a-5619-4208-9e9f-83848206d42b@linaro.org>
 <f1f290fc-b2f0-483b-96d5-5995362e5a8b@redhat.com>
 <01c67173-818c-48cf-8515-060751074c37@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <01c67173-818c-48cf-8515-060751074c37@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.08.25 15:36, Eugen Hristev wrote:
> 
> 
> On 8/25/25 16:20, David Hildenbrand wrote:
>>
>>>>
>>>> IIRC, kernel/vmcore_info.c is never built as a module, as it also
>>>> accesses non-exported symbols.
>>>
>>> Hello David,
>>>
>>> I am looking again into this, and there are some things which in my
>>> opinion would be difficult to achieve.
>>> For example I looked into my patch #11 , which adds the `runqueues` into
>>> kmemdump.
>>>
>>> The runqueues is a variable of `struct rq` which is defined in
>>> kernel/sched/sched.h , which is not supposed to be included outside of
>>> sched.
>>> Now moving all the struct definition outside of sched.h into another
>>> public header would be rather painful and I don't think it's a really
>>> good option (The struct would be needed to compute the sizeof inside
>>> vmcoreinfo). Secondly, it would also imply moving all the nested struct
>>> definitions outside as well. I doubt this is something that we want for
>>> the sched subsys. How the subsys is designed, out of my understanding,
>>> is to keep these internal structs opaque outside of it.
>>
>> All the kmemdump module needs is a start and a length, correct? So the
>> only tricky part is getting the length.
> 
> I also have in mind the kernel user case. How would a kernel programmer
> want to add some kernel structs/info/buffers into kmemdump such that the
> dump would contain their data ? Having "KMEMDUMP_VAR(...)" looks simple
> enough.

The other way around, why should anybody have a saying in adding their 
data to kmemdump? Why do we have that all over the kernel?

Is your mechanism really so special?

A single composer should take care of that, and it's really just start + 
len of physical memory areas.

> Otherwise maybe the programmer has to write helpers to compute lengths
> etc, and stitch them into kmemdump core.
> I am not saying it's impossible, but just tiresome perhaps.

In your patch set, how many of these instances did you encounter where 
that was a problem?

>>
>> One could just add a const variable that holds this information, or even
>> better, a simple helper function to calculate that.
>>
>> Maybe someone else reading along has a better idea.
> 
> This could work, but it requires again adding some code into the
> specific subsystem. E.g. struct_rq_get_size()
> I am open to ideas , and thank you very much for your thoughts.
> 
>>
>> Interestingly, runqueues is a percpu variable, which makes me wonder if
>> what you had would work as intended (maybe it does, not sure).
> 
> I would not really need to dump the runqueues. But the crash tool which
> I am using for testing, requires it. Without the runqueues it will not
> progress further to load the kernel dump.
> So I am not really sure what it does with the runqueues, but it works.
> Perhaps using crash/gdb more, to actually do something with this data,
> would give more insight about its utility.
> For me, it is a prerequisite to run crash, and then to be able to
> extract the log buffer from the dump.

I have the faint recollection that percpu vars might not be stored in a 
single contiguous physical memory area, but maybe my memory is just 
wrong, that's why I was raising it.

> 
>>
>>>
>>>   From my perspective it's much simpler and cleaner to just add the
>>> kmemdump annotation macro inside the sched/core.c as it's done in my
>>> patch. This macro translates to a noop if kmemdump is not selected.
>>
>> I really don't like how we are spreading kmemdump all over the kernel,
>> and adding complexity with __section when really, all we need is a place
>> to obtain a start and a length.
>>
> 
> I understand. The section idea was suggested by Thomas. Initially I was
> skeptic, but I like how it turned out.

Yeah, I don't like it. Taste differs ;)

I am in particular unhappy about custom memblock wrappers.

[...]

>>>
>>> To have this working outside of printk, it would be required to walk
>>> through all the printk structs/allocations and select the required info.
>>> Is this something that we want to do outside of printk ?
>>
>> I don't follow, please elaborate.
>>
>> How is e.g., log_buf_len_get() + log_buf_addr_get() not sufficient,
>> given that you run your initialization after setup_log_buf() ?
>>
>>
> 
> My initial thought was the same. However I got some feedback from Petr
> Mladek here :
> 
> https://lore.kernel.org/lkml/aBm5QH2p6p9Wxe_M@localhost.localdomain/
> 
> Where he explained how to register the structs correctly.
> It can be that setup_log_buf is called again at a later time perhaps.
> 

setup_log_buf() is a __init function, so there is only a certain time 
frame where it can be called.

In particular, once the buddy is up, memblock allocations are impossible 
and it would be deeply flawed to call this function again.

Let's not over-engineer this.

Peter is on CC, so hopefully he can share his thoughts.

-- 
Cheers

David / dhildenb


