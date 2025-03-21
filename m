Return-Path: <linux-arch+bounces-11035-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEFBA6C44B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 21:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA813B842E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A611230985;
	Fri, 21 Mar 2025 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MZQKcIkO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C11EF09C
	for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589357; cv=none; b=u03VQWvrA9iI0kwT+PmO4z3A2mdO2nZhZ09KjYHWwW1vc/l5yleBbNSR6br6yrhzbWuOo4whvgdZB2v6ISJx0Yo0kzr/yQGuGXDJyUmV6PPx1qA+N3of6a+qv27k8hd7MQ7Nsjzt8ZD2mTh36k8Qq+sbPZymJUDFwWqJSfbRz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589357; c=relaxed/simple;
	bh=Q4yJA3jsyp0Q05YHLWgkGPj0BYZnr/626JQJoRaup9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uexQbz4aAgkA2NV4FV6RTs0nfn2BI2vLRBXVoOG74ARt9rpu/h7CqBd1vR6we+TqwY2BYO/EMPdCfcK8p8CTYmTjIxhHsWTOkS2QLQU78eawPJ1t6aspDWHOmIZ88dGlUNKwQlCYVaB034r55+HO7NC61Rap/JrXhY0K9DHb+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MZQKcIkO; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85db3475637so114205139f.1
        for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742589355; x=1743194155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qvMwDu0BMSrh7CaSCaQYm2+c+HftuBgbOun19NXMMCQ=;
        b=MZQKcIkODtlB8IzsiOOakT6x76IB4Yq1lgJYIKJSTEfoaBWSl+wJL0k7IvBWJnDZ/C
         sRMiO2aGs0q36yGgrmHcpDsyuol45b/Ixhfn+eePULsLQdR7fznLuGjBvz+rBjB2iTSR
         WomG4LprAGXddDy2JYJ46fcToSzGFiyeSw/NtomiMHWW9jBES0LQdHRbC+JZLluB5P3a
         JPQREz4U8K1fJcmFBnSttbB2QZE+/eCdUX48UmYC/uE11GT0ieI9pSOi5alU/a243cmA
         YJp5ZuKC+PmiS4NXhoLZiPMvz5ysXo3aUc5vqqv8jU8DpqxVGBS0DwctRuIWU/RsVSds
         9RaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589355; x=1743194155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvMwDu0BMSrh7CaSCaQYm2+c+HftuBgbOun19NXMMCQ=;
        b=ek82QRJCdqk4pkBs7ISh5rNuyu+/I9tLrSqZ8RAtyWEbuwPtBnDhDzGc6w3RA6N23i
         idZAEcYQfN6zcKvguduOr/BxEXMdZR0J9Vv7LFVsFkGts+UnomRFpk76g9AVDwY+kPel
         cBC22lakEZqMn33j3CshX+/K7nT+2F6rN//eRxcdgnv1tEQo/iAR5Fc/44zIqjT4/YgO
         VpEAEKIGQDGECwDL0AetF4augohRh7U3UijBRt3OSbq2a9cC2NWmAQ6VofDM/yLfMxmY
         2v+XzFOvrILOR0pVLalQdaoInOSvi9SJ6NFSGp244Hd4d74Qqc3VolcAy9SdKMrqz6CC
         vXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5yt8lic7vayirWUO9FTnvDgCc9zbKP79vfQWEaSEmo/NlAQt7mn0tQS2V1hn5A8crk8IiOs3fEaJh@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+wYrRmsSWQ1WP5Iw9pl/hApGAs3a5dj9BfHN26mEsrHhl92B
	BT43Go8F772zY26TytDry4ZbmMR9poAGpILAxUQ7iXN+54QekwNjYAxSEbpWSJg=
X-Gm-Gg: ASbGnctuijAhOoCq35QANGbgngpDJ/0rz1MM60uVGa3rgcfFZvbVSt3WMeI4UUy2Rfa
	fuHiquKq9q01MqRvt970WvaLAhUdzeXwAoJF4JwHXkhyDLYYwsuc2LLNyyZ28u2npYyj8bYqXn/
	UZcAhNk8zPYxOgqFQw+Bk3FVzRk+YswnBKuG/6VoXWQQZXmB8odJa8HokpRlcQ7kEnWQTuAmDGB
	x/O/P1hfYYAvQ2GfRYitqjr4J54tP5sEjt9l2aMZ4AFZsfOVBtUn1ombYmyVsZPjIPd8arlnvJ/
	rOKauqrEx5E303ddZuSgaDOr6bLt4PG32kbWdUM89Q==
X-Google-Smtp-Source: AGHT+IEPWzk5ry4zHWNFdi8KTg5KcDVgbTXsCl1DzYqeTt8WkJX5AIeUX7DfgyW/W2CDL0vQ6sVZlg==
X-Received: by 2002:a05:6e02:1f01:b0:3d3:d1a8:8e82 with SMTP id e9e14a558f8ab-3d595f91c7emr52500135ab.9.1742589354635;
        Fri, 21 Mar 2025 13:35:54 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d59607ea6fsm6112915ab.24.2025.03.21.13.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 13:35:53 -0700 (PDT)
Message-ID: <4e582b92-2f4d-4a0d-b479-3cf4f054bb5f@kernel.dk>
Date: Fri, 21 Mar 2025 14:35:51 -0600
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
References: <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2> <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2> <Z9z_f-kR0lBx8P_9@infradead.org>
 <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
 <Z92VkgwS1SAaad2Q@LQ3V64L9R2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z92VkgwS1SAaad2Q@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/25 10:36 AM, Joe Damato wrote:
> On Fri, Mar 21, 2025 at 05:14:59AM -0600, Jens Axboe wrote:
>> On 3/20/25 11:56 PM, Christoph Hellwig wrote:
>>>> I don't know the entire historical context, but I presume sendmsg
>>>> did that because there was no other mechanism at the time.
>>>
>>> At least aio had been around for about 15 years at the point, but
>>> networking folks tend to be pretty insular and reinvent things.
>>
>> Yep...
>>
>>>> It seems like Jens suggested that plumbing this through for splice
>>>> was a possibility, but sounds like you disagree.
>>>
>>> Yes, very strongly.
>>
>> And that is very much not what I suggested, fwiw.
> 
> Your earlier message said:
> 
>   If the answer is "because splice", then it would seem saner to
>   plumb up those bits only. Would be much simpler too...
> 
> wherein I interpreted "plumb those bits" to mean plumbing the error
> queue notifications on TX completions.
> 
> My sincere apologies that I misunderstood your prior message and/or
> misconstrued what you said -- it was not clear to me what you meant.
> 
> It is clear to me now, though, that adding a flag to splice as
> previously proposed and extending sendfile based on the SO_ZEROCOPY
> sock flag being set are both unacceptable solutions.
> 
> If you happen to have a suggestion of some piece of code that I
> should read (other than the iouring implementation) to inform how I
> might build an RFCv2, I would appreciate the pointer.

I don't know what to point you at - you need an API that can deliver
notifications, and I'm obviously going to say that io_uring would be one
way to do that. Nothing else exists on the networking side, as far as
I'm aware.

Like Christoph said, struct kiocb is generally how the kernel passes
around async or sync IO, which comes with a completion callback for IO
that initially returns -EIOCBQUEUED, meaning the operation is started
but not yet complete. Outside of that, yeah need some delivery
mechanism, as you're generating two events per zero copy send here. You
could obviously roll your own, good luck with that, or use the existing
one.

-- 
Jens Axboe

