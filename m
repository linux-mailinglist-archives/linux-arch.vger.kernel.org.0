Return-Path: <linux-arch+bounces-13260-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC9CB3408E
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 15:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA793B97A6
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 13:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81903270EBB;
	Mon, 25 Aug 2025 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxJ8I6lN"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7A270552
	for <linux-arch@vger.kernel.org>; Mon, 25 Aug 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128023; cv=none; b=AjmWmKz/xZC42vErTal8Nc8O1S4z33mk89XFj16hWvFaAHZdqzSYIQj6mIWPox5QQIEHJChW146PPLNVXMGvhU2XjrEQGTniOKeJd5ED980Ef/WYQ8O6CKGfeSjuTZOg5ELIhTh9H4sVjODmlGYXTLjMs6vfPXj/nXHPJ/51VP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128023; c=relaxed/simple;
	bh=m6jqKINFobNIZ/79Pbgva0NJNu9TvoUNn6dTFB0S+7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r930YiRY+Qz6eBfNvPZpYgOckQkjtwvy9A9tG7D4/slUhn7KMDgTzlcnyI7LzG5+BzbqvINC3F+erMKI2fbojGmCRUzVHyuqt40VqGCQExfQ7qhKVA6xPOyaKffM/SzLjvDLhDkDqMKdJHa4672K1fFjPyoNTiPPXWpRVi5TA4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxJ8I6lN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756128019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xanPEdPEE3D5dOZlqK4VGPHY2abbjAoznKTXD9A7MGY=;
	b=bxJ8I6lNPmGSpkjQPEj5CS6FajdF41cJp3j5D0M40Vk14jQXHkm17isXk1ZBpK0Y9CC2OF
	L+uniJK+K9kqmQRVqERhvOOtDSxypmNrzTeeg7AFe1viX6X1xgMQe2GN5dWzWycI5lFbPA
	MGd0jYY1bh4s++QW7FsG0y0kXtRyBNg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-6ZBzPwWnOSWTpwbkk5Lfnw-1; Mon, 25 Aug 2025 09:20:17 -0400
X-MC-Unique: 6ZBzPwWnOSWTpwbkk5Lfnw-1
X-Mimecast-MFC-AGG-ID: 6ZBzPwWnOSWTpwbkk5Lfnw_1756128016
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b05b15eso34592425e9.1
        for <linux-arch@vger.kernel.org>; Mon, 25 Aug 2025 06:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756128016; x=1756732816;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xanPEdPEE3D5dOZlqK4VGPHY2abbjAoznKTXD9A7MGY=;
        b=RIkaWoQJDmmDZ3UK3e8aDDjKkOr2cqMt21Ucw9QrKMyXAUaOG9XhF96IN6z5he4Cn0
         UAOGxAN/WQGqjNMg96blPtw1dYskprkH18+bWAI2DtDSf7XBVEeJDPe86SVTA+BdO81d
         yPMdPe29U/uCk4j0yVacWnTif/MjBZsAZ09qKXUjX7MiNkbEfUrsZwOF9tkWU1VSQxDy
         frVRK5hxH6+C8CxnrOMDvINzpxpHVUOUek/Ic8N3wCRxwW2ErX8fVRYeezWoH8mijtCS
         ksHaWCnADTUCP6Oqxa04HrI1uy0WqFgKA2qxt/Wcfa99SiXScBw+8j/zP9IGxwxzegUW
         cD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCULkB3DiP6lG70AAMMVwRPKOX4hH2z/Bl63k2zgsTkcZOCaCfxFxxyq7oOoQ+p2xDnOK4hw/It5ayyV@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkxRUgC+6VMTG5bMUvjWcI8Y85KhtIIoA3CuSoFuNjW/I+R3H
	Z/zcNnrYDEQzg8SdLhuIHLeqVMbCspDrOKTM0o21rISGXnA+JQg2L4PWnpPwXor3wu56PBBU9FG
	AJX9gH9x1z6AigT2gYd3uKBt0TOg9frCW+APwmXwirJSgMGx3/6+inZSNKVWc+nQ=
X-Gm-Gg: ASbGnctoCtdF5kt6GkIWgd2LGnLONtxCvMm+c52wAmr9q5aQwbBSTPbXsyuy/xOiUWD
	Wzxy56RZxkiYqrj7jiwjlQsHSZmnIqmG0Z1Y0IQ4xmAmtiXdd95O7KCA2CHGOhzO+1mGtu8Hp2t
	IlJsEoC2hKAUNyO6m1BHcFI2il9qsEZbL7g/xH5L2+7pqD+7zC0tpHjJ+v/CVfL4VTDqZVEiz85
	vgJwjJ/s1UhzGSINC4wstl3SY8dB7cCIjA+AWpyVf+URk5kL1Sg1aKV1I+eONeu7QUq9tVK8v7W
	iMwp6h3sLVK4u708cGKjUfZE7sKhUNLCv+YdknJfhW5R3gZwjWoxHUvfjT2yH3yMRYJQQJNKv87
	hzk2ZRajiI6ZtmQCJ4R9CzT/eblSGRX4iIk+JIAHjv3arMPaMgFWNTo/IsnB5RTfEMrk=
X-Received: by 2002:a05:600c:4f03:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-45b5ec68358mr40532185e9.11.1756128015759;
        Mon, 25 Aug 2025 06:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvrXUbP05G5QAqAXL/0e5bs4AE6awYxmrv92zt0i3Fp8EOJw//DKRQZAygSokTsHc8FeRx2w==
X-Received: by 2002:a05:600c:4f03:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-45b5ec68358mr40531705e9.11.1756128015277;
        Mon, 25 Aug 2025 06:20:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76? (p200300d82f4f130042f198e5ddf83a76.dip0.t-ipconnect.de. [2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b506bdd9csm92855095e9.3.2025.08.25.06.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 06:20:14 -0700 (PDT)
Message-ID: <f1f290fc-b2f0-483b-96d5-5995362e5a8b@redhat.com>
Date: Mon, 25 Aug 2025 15:20:13 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <64a93c4a-5619-4208-9e9f-83848206d42b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>> IIRC, kernel/vmcore_info.c is never built as a module, as it also
>> accesses non-exported symbols.
> 
> Hello David,
> 
> I am looking again into this, and there are some things which in my
> opinion would be difficult to achieve.
> For example I looked into my patch #11 , which adds the `runqueues` into
> kmemdump.
> 
> The runqueues is a variable of `struct rq` which is defined in
> kernel/sched/sched.h , which is not supposed to be included outside of
> sched.
> Now moving all the struct definition outside of sched.h into another
> public header would be rather painful and I don't think it's a really
> good option (The struct would be needed to compute the sizeof inside
> vmcoreinfo). Secondly, it would also imply moving all the nested struct
> definitions outside as well. I doubt this is something that we want for
> the sched subsys. How the subsys is designed, out of my understanding,
> is to keep these internal structs opaque outside of it.

All the kmemdump module needs is a start and a length, correct? So the 
only tricky part is getting the length.

One could just add a const variable that holds this information, or even 
better, a simple helper function to calculate that.

Maybe someone else reading along has a better idea.

Interestingly, runqueues is a percpu variable, which makes me wonder if 
what you had would work as intended (maybe it does, not sure).

> 
>  From my perspective it's much simpler and cleaner to just add the
> kmemdump annotation macro inside the sched/core.c as it's done in my
> patch. This macro translates to a noop if kmemdump is not selected.

I really don't like how we are spreading kmemdump all over the kernel, 
and adding complexity with __section when really, all we need is a place 
to obtain a start and a length.

So we should explore if there is anything easier possible.

>>
>>>
>>> So I am unsure whether just removing the static and adding them into
>>> header files would be more acceptable.
>>>
>>> Added in CC Cristoph Hellwig and Sergey Senozhatsky maybe they could
>>> tell us directly whether they like or dislike this approach, as kmemdump
>>> would be builtin and would not require exports.
>>>
>>> One other thing to mention is the fact that the printk code dynamically
>>> allocates memory that would need to be registered. There is no mechanism
>>> for kmemdump to know when this process has been completed (or even if it
>>> was at all, because it happens on demand in certain conditions).
>>
>> If we are talking about memblock allocations, they sure are finished at
>> the time ... the buddy is up.
>>
>> So it's just a matter of placing yourself late in the init stage where
>> the buddy is already up and running.
>>
>> I assume dumping any dynamically allocated stuff through the buddy is
>> out of the picture for now.
>>
> 
> The dumping mechanism needs to work for dynamically allocated stuff, and
> right now, it works for e.g. printk, if the buffer is dynamically
> allocated later on in the boot process.

You are talking about the memblock_alloc() result, correct? Like

new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);

The current version is always stored in

static char *log_buf = __log_buf;


Once early boot is done and memblock gets torn down, you can just use 
log_buf and be sure that it will not change anymore.

> 
> To have this working outside of printk, it would be required to walk
> through all the printk structs/allocations and select the required info.
> Is this something that we want to do outside of printk ?

I don't follow, please elaborate.

How is e.g., log_buf_len_get() + log_buf_addr_get() not sufficient, 
given that you run your initialization after setup_log_buf() ?


-- 
Cheers

David / dhildenb


