Return-Path: <linux-arch+bounces-11016-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF83A6B998
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 12:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BBF3AE042
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A388221D86;
	Fri, 21 Mar 2025 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iRtkMVFZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB11F17EB
	for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555465; cv=none; b=m5Nx7XVu9HvsdTCqtwxXYAN4J+2CM2kcA6loHVQ7pcuQOMqW1ZTNg6b84aqwsOEmiY2Zxh1fhS8ixKFYnsF+42Vd71ds6Eq57vXPjrqiD0GKZGQ8cnTLhHtBdkoZw2mU+DRO5d4n1tO78lrlQusDK+NqkZqbmYFHF+VAm+2VTwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555465; c=relaxed/simple;
	bh=Xl5oeEHOaLoSBAmpxOjl3jAqNjOQaFTyIpVFbbJdV6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PbkC9Jr8EmRnCD21SYlaK82lIng8yJB2/QfVD2BZksW5adxqxvKHv2XBwcnj9ilmJm08EasLYdXg8Q0HwGiu0dFSjiKwfcrnzdQeoL5uwEumE8YKnexdT/O81T2YO4EN3ob5M/jXolHnbdTMaiu4FfL81IspfYJD7xGplfBcs2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iRtkMVFZ; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85e15dc8035so38093339f.0
        for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 04:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742555462; x=1743160262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sA3xfU5eNSi4gl7Hxg/W8KumQ2nnI6nlMXWqCtTodbQ=;
        b=iRtkMVFZMTRKf+upcfDpu7YAYHNXlaVFWfUbaWIBBZOd+emomPpzL9uic9cU38jgBD
         3Sc38L8AUe0r4klVumDPED3THsG+gTffRYTV9eLzzdPZeICYdDW4LSljmPnVi1hjxiMk
         1sijCJ3baGaduYK+6IyEh/6F6bKyrJHrJzGWGVWUNmUoIbnNl8nsH0AH4hiKH2BtmHyp
         cUI139EiYXUGnTvZkNHjboSbEZwDENzbNQsBzGYHNe6zVZdhDYjECXss1eZmALHTmZe4
         CY/+uJwVyMw2qKhrUSULbg5KjJe7HC9heND+NVTJPOuBesC3bZBsO3sh5F1eWutnSQwJ
         a4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555462; x=1743160262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sA3xfU5eNSi4gl7Hxg/W8KumQ2nnI6nlMXWqCtTodbQ=;
        b=qTdJaBF3EQ3SQ+1jjybRbzogSCeAmAuX+kY7bGE4WHJSF21GQoYb1DnsEoXKVqjKqY
         BNJutFzQdHIoUc81R3YA6rbNx9/mwqVIzsLAZsO2qmiaVtSQbLOwPj+9/vSq/I0f2d5+
         Xri2/VZTXwZCVtboA4/y/8136AV+7yU3PccsWSwLRnBSBWehlXhEJwbOZefo6+BgPjD/
         zwXAgkHU9UlAMzM89lCXEVM2XUfZxz3SIU1SFLQvnt/P1v5se8qqMEN8TK7Hyl2kWL2o
         ivII8m9ynGwOVjX5WjAfMSF/fHCU/DjOgEKUQybDSkOZCsIbN5s9qtklMdB9hwJWV0fv
         p5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUvPBIRpm9Zff58UM3Fhm7a8/47RnSA0bP32QK6glZujZDhpQ4wV2JagfPTdhkrb+N7u/1Me1Jpakpd@vger.kernel.org
X-Gm-Message-State: AOJu0YwCxWtFJxDzbdS6JtGrxEtm7B0eK43FKMqeOfeCjXbpZlLjbGuO
	wQLja7MEMy0DddzvjYf0X9b0v/s44nQxEsfCHFHURhGA9CR07n8B7XDpAXDKVpQ=
X-Gm-Gg: ASbGncuTMOhkXHV8L1HVxr1fIZyaSiRcgygvbZ604jYYmqsLNXyUXEQLp4uvyRt8+Vx
	dBUvuckLQmPONyVnLgSz4HrYEk1pJrYmpIfvq0OXDjDqUetNYnMUORidl9tl7DD1+t2xwun8KJz
	Xnah9Je78o4TMGSyhG5JQgDJ71OiCAXpuyMcVV2PyTGnOapPXEYN+0PXrbJlRCOmbeO0DJqu+4B
	7NwwdqSrAiFtgT/9HgyakfHyWiITTBeV5hafUzC/d7phsh/NVErmKNmH9rXZB9Sp4LI6o40/+5z
	JXU3oU974tqs8X+zN2xU6t/MB4NrXhYoqSi3zGv9aw==
X-Google-Smtp-Source: AGHT+IFSJ3hxrf4+/3xiQwLVqMWpjH/GflgYxZ/+tadwi+N40CzqBAwFYJHfcNgOer76GMlKsVK58Q==
X-Received: by 2002:a05:6602:368d:b0:85b:6118:db67 with SMTP id ca18e2360f4ac-85e2ca2d202mr297241339f.2.1742555462376;
        Fri, 21 Mar 2025 04:11:02 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbe80a54sm372041173.82.2025.03.21.04.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:11:01 -0700 (PDT)
Message-ID: <d458a42e-f9b4-4075-af0d-f715c15e3566@kernel.dk>
Date: Fri, 21 Mar 2025 05:11:00 -0600
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asml.silence@gmail.com, linux-fsdevel@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com,
 arnd@arndb.de, brauner@kernel.org, akpm@linux-foundation.org,
 tglx@linutronix.de, jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <dc3ebb86-f4b2-443a-9b0d-f5470fd773f1@kernel.dk>
 <Z9sX98Y0Xy9-Vzqf@LQ3V64L9R2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9sX98Y0Xy9-Vzqf@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 1:16 PM, Joe Damato wrote:
>>> In general: it does seem a bit odd to me that there isn't a safe
>>> sendfile syscall in Linux that uses existing completion notification
>>> mechanisms.
>>
>> Pretty natural, I think. sendfile(2) predates that by quite a bit, and
>> the last real change to sendfile was using splice underneath. Which I
>> did, and that was probably almost 20 years ago at this point...
>>
>> I do think it makes sense to have a sendfile that's both fast and
>> efficient, and can be used sanely with buffer reuse without relying on
>> odd heuristics.
> 
> Just trying to tie this together in my head -- are you saying that
> you think the kernel internals of sendfile could be changed in a
> different way or that this a userland problem (and they should use
> the io_uring wrapper you suggested above) ?

I'm saying that it of course makes sense to have a way to do sendfile
where you know when reuse is safe, and that we have an API that provides
that very nicely already without needing to add syscalls. If you used
io_uring for this, then the "tx is done, reuse is fine" notification is
just another notification, not anything special that needs new plumbing.

>>>>> I would also argue that there are likely user apps out there that
>>>>> use both sendmsg MSG_ZEROCOPY for certain writes (for data in
>>>>> memory) and also use sendfile (for data on disk). One example would
>>>>> be a reverse proxy that might write HTTP headers to clients via
>>>>> sendmsg but transmit the response body with sendfile.
>>>>>
>>>>> For those apps, the code to check the error queue already exists for
>>>>> sendmsg + MSG_ZEROCOPY, so swapping in sendfile2 seems like an easy
>>>>> way to ensure safe sendfile usage.
>>>>
>>>> Sure that is certainly possible. I didn't say that wasn't the case,
>>>> rather that the error queue approach is a work-around in the first place
>>>> for not having some kind of async notification mechanism for when it's
>>>> free to reuse.
>>>
>>> Of course, I certainly agree that the error queue is a work around.
>>> But it works, app use it, and its fairly well known. I don't see any
>>> reason, other than historical context, why sendmsg can use this
>>> mechanism, splice can, but sendfile shouldn't?
>>
>> My argument would be the same as for other features - if you can do it
>> simpler this other way, why not consider that? The end result would be
>> the same, you can do fast sendfile() with sane buffer reuse. But the
>> kernel side would be simpler, which is always a kernel main goal for
>> those of us that have to maintain it.
>>
>> Just adding sendfile2() works in the sense that it's an easier drop in
>> replacement for an app, though the error queue side does mean it needs
>> to change anyway - it's not just replacing one syscall with another. And
>> if we want to be lazy, sure that's fine. I just don't think it's the
>> best way to do it when we literally have a mechanism that's designed for
>> this and works with reuse already with normal send zc (and receive side
>> too, in the next kernel).
> 
> It seems like you've answered the question I asked above and that
> you are suggesting there might be a better and simpler sendfile2
> kernel-side implementation that doesn't rely on splice internals at
> all.
> 
> Am I following you? If so, I'll drop the sendfile2 stuff from this
> series and stick with the splice changes only, if you are (at a high
> level) OK with the idea of adding a flag for this to splice.
> 
> In the meantime, I'll take a few more reads through the iouring code
> to see if I can work out how sendfile2 might be built on top of that
> instead of splice in the kernel.

Heh I don't know how you jumped to that conclusion based on my feedback,
and seems like it's solidified through other replies. No I'm not saying
that the approach makes sense for the kernel, it makes some vague amount
of sense only on the premise of "oh but this is easy for applications as
they already know how to use sendfile(2)".

-- 
Jens Axboe

