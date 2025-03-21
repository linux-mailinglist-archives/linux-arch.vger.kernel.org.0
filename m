Return-Path: <linux-arch+bounces-11034-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5969A6C440
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 21:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E103B6C2A
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 20:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120822309A7;
	Fri, 21 Mar 2025 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SVtixoBt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F97230277
	for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589201; cv=none; b=kxN+0W5BS99vzXvCGE2BLqvdJQvb59bRroyo/Gzoc9lOkCxGh1Ryr7BSuNEs1hUv+KDtcZ/nNjlTMRQSUjHvIjc7JJoaeiEuhczXHUIE8Y0+en90PTC34jsjW3rVbrX//hvEMMMTyXMXuAPrtLv5SsTcDxioQMNshjNEYcOZMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589201; c=relaxed/simple;
	bh=7lhaM0CG+9tuZnrS9lZcJSlVArtevf4SVBCaDSzqoIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QBdaGbBDC//ar6vt7ZuuajBiYHg2bRcJhONelOPEqr5a7NPh1fFMPESvIdxt3JB1T5/HhS1nqEGWWk9NtRBDi8xZAFyidpoLUFT5psJ1oFd96PiizMC+T4wh9dS+QgIpmFEXfyYO5H0HbXEkiv5y0A7Y6aAoYMJZX/KZlmknq+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SVtixoBt; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso18863995ab.1
        for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742589198; x=1743193998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xuLZuFCKSKg3PxWQwRd8ETXjNuULumylP5s/6/Th/nI=;
        b=SVtixoBtotTxS6U4OZnzvnwk8oHnpE5tf1GYD3KBq3Cc0Z3z2DvJCO+isPNrKorK8a
         gjVxI8la7UKqZ74wjvpo88bH6DalQR63upAndrbxyIbIqKlVQWT9inb5LoekVITnO13M
         YXHxU9qVg1kRPZTG5B0GK1yg10GH1dhKVqrBdkYHPSfyTjnw/aiC5D1NMqYgewsIDmv7
         YZ21gTmmw4QWdO3nayryvKBK6P7rRCB9orRDJumCpp+Od3acMeBIdn2peLX8yki/z4mZ
         0BAvCrd+xVGCsC1GxXfOxWch8XxR0YwsZgw0hHYPqiJPNWGaCaIjDK6NsYOgAmrki/Xu
         tFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589198; x=1743193998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuLZuFCKSKg3PxWQwRd8ETXjNuULumylP5s/6/Th/nI=;
        b=QdI133f+0YKp7DdP2wwoqAtPwJkYllbkna/u6DFHMs2gkpiitXiEBkJIhiptn3YiPP
         afjHZTQO2JqcsYzBxI7zcN106mDMFIeSfl4cD5JtGYbPAMJToPlvsiMs0i+F5p+nW6LY
         54sl9YXSkrjdkKTK3yHCG8O50nzXqfqnMo6NzVdexSnUCExRxm39ooqVoA/7vil+E23C
         HtPNpkuE+yJmhWqovoQDXgFNNvJzhZ4/LI3a4etFrIj0NXuUiXnWVS/aYQYXH4CUbJ7u
         +iUHZ8rW2zXYGau7WWWc7g6ZvW0XAHudWQZ/eF44SC1spZJwtKTt+6N/ev6Mbir7kLCW
         vD8g==
X-Forwarded-Encrypted: i=1; AJvYcCXWRlbMH9mOX2czBMx4ySRooMZYy3CUr1s7bKxn8DT9PIcn0lWhYj+ZDbmIcxF9LQwNaKhmuK991dDY@vger.kernel.org
X-Gm-Message-State: AOJu0YyT2HH1koDJ81wOj41Vjy1nyqrgqYyY5aq2y+zaOcsKZbCajaLQ
	zbR/g+IvglRlKVK9Z1FvGP9T8qUmaQ4CkODpx29VywVqOzXCRZPtLI3u4NOjNrs=
X-Gm-Gg: ASbGnctGYmeuogXxYGxozidscF7vWc3aY6kqG9MBKEqdrHuFGAZ0KiF3AG7VdTtxUdd
	3wXzZ6j+h/S39JGMsxywMc5al5bZ2C+yb9HjLuphAKjBgscurwidupWGxFrzJiTwFobRS34Fvmp
	hu+8S8k49/EKfBlFgqAEBunyAg3fkVswvSJPOmwr0/KemlLKwlJTc8c+EMbAYeJtaHna7DeOD3m
	L5fjVKWBDt3srtHks6nRuAG5cVQDfTsM31BSmWiwN5YRraemgma3qVF1wMy0/2wS+2ZHoQqC8dn
	i2OQhW1EP7xkiuRYIAd3Br/UfZKwK8HR0FcafTlNgQ==
X-Google-Smtp-Source: AGHT+IFI91THLm3qVJtECcXxa5n7V2R1Cftu+sQP4tmofv//BmWK9VIunVWN3AluV2sQCeMt2KYACw==
X-Received: by 2002:a05:6e02:170d:b0:3d5:8908:92d0 with SMTP id e9e14a558f8ab-3d5960d22fbmr49781055ab.3.1742589198084;
        Fri, 21 Mar 2025 13:33:18 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdea05dsm582166173.63.2025.03.21.13.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 13:33:17 -0700 (PDT)
Message-ID: <67a82595-0e2a-4218-92d4-a704ccb57125@kernel.dk>
Date: Fri, 21 Mar 2025 14:33:16 -0600
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
References: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2> <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2> <Z9z_f-kR0lBx8P_9@infradead.org>
 <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
 <Z92VkgwS1SAaad2Q@LQ3V64L9R2> <Z93Mc27xaz5sAo5m@LQ3V64L9R2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z93Mc27xaz5sAo5m@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/25 2:30 PM, Joe Damato wrote:
> On Fri, Mar 21, 2025 at 09:36:34AM -0700, Joe Damato wrote:
>> On Fri, Mar 21, 2025 at 05:14:59AM -0600, Jens Axboe wrote:
>>> On 3/20/25 11:56 PM, Christoph Hellwig wrote:
>>>>> I don't know the entire historical context, but I presume sendmsg
>>>>> did that because there was no other mechanism at the time.
>>>>
>>>> At least aio had been around for about 15 years at the point, but
>>>> networking folks tend to be pretty insular and reinvent things.
>>>
>>> Yep...
>>>
>>>>> It seems like Jens suggested that plumbing this through for splice
>>>>> was a possibility, but sounds like you disagree.
>>>>
>>>> Yes, very strongly.
>>>
>>> And that is very much not what I suggested, fwiw.
>>
>> Your earlier message said:
>>
>>   If the answer is "because splice", then it would seem saner to
>>   plumb up those bits only. Would be much simpler too...
>>
>> wherein I interpreted "plumb those bits" to mean plumbing the error
>> queue notifications on TX completions.
>>
>> My sincere apologies that I misunderstood your prior message and/or
>> misconstrued what you said -- it was not clear to me what you meant.
> 
> I think what added to my confusion here was this bit, Jens:
> 
>   > > As far as the bit about plumbing only the splice bits, sorry if I'm
>   > > being dense here, do you mean plumbing the error queue through to
>   > > splice only and dropping sendfile2?
>   > >
>   > > That is an option. Then the apps currently using sendfile could use
>   > > splice instead and get completion notifications on the error queue.
>   > > That would probably work and be less work than rewriting to use
>   > > iouring, but probably a bit more work than using a new syscall.
>   > 
>   > Yep
> 
> I thought I was explicitly asking if adding SPLICE_F_ZC and plumbing
> through the error queue notifications was OK and your response here
> ("Yep") suggested to me that it would be a suitable path to
> consider.
> 
> I take it from your other responses, though, that I was mistaken.

I guess I missed your error queue thing here, I was definitely pretty
clear in other ones that I consider that part a hack and something that
only exists because networking never looked into doing a proper async
API for anything.

-- 
Jens Axboe

