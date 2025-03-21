Return-Path: <linux-arch+bounces-11018-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E98A6B9AD
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 12:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26717188D8BD
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9C52222CA;
	Fri, 21 Mar 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Iw2c3QWk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BB221578
	for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555704; cv=none; b=sqHzAaw5+NzRRH0eITeXMK+MLKDkd9QGb2G8thi+IqTZTWi5fFCE0aI1o6BydVLEEdPMwWn2Bl1hz71KFO3RJMn4RJCLOO10EZvjVRrvu+8ZbvnH/mrvYlCxv4BzeV+uQFCA7Xm45/u4rkL7qYpP7JxKSI1wh/ZeVakLj0TP2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555704; c=relaxed/simple;
	bh=8R6APMOXHnSGsHWxrl6UGLerFw6XUN3eqFRa7zAvg/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CIi2K1CpKDdbDVnqi/YV6rPFSSXZP/q/cFbUEOn6cseE1DiAkaiF/O2VhJxOyZU5YC0LUWpNxcpT02hZhwLSTBRu8DVGrtYH+lgqbpJuR3OabGQr46tSAxClfJCLKfPw66AtP3YLCh81C4HHBx+STJHXqAFcubjZIJcRnEr3ZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Iw2c3QWk; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85b43b60b6bso63987139f.0
        for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 04:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742555702; x=1743160502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kliUjv4+TXv1KW6sNWVHyeHcHrrjshrv681ijKNdLOI=;
        b=Iw2c3QWka8kkhnOcLtELQiQELaeqZuUMgS7kb4ZffDPthFqQU3UQDlpY8iqcb3lUCO
         GKiU26FrybIvWhJize1sjzcoBt/fFZ4EI5gmL1eYbygmKOOFOV3S05G6BqWzpEtclq3Q
         wwqF55+fYuET9ydA9yszlebqAhBovv4pEK6oIuWjAVkuhBFiY8+vzz+0u+3duQajcyTH
         vbXNd04PuBX2JNOWy0rOfPXwBbC9kqEnBufORUw/mt2FQa8SsEGFIN3268uERLv7P6wB
         Xa2DU71NwH/dwcyCjpPH7E35IEo13ZQNAAzp9urqcv+H8JoTQ3YUonE/S4YI1eXC9Xcg
         zbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555702; x=1743160502;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kliUjv4+TXv1KW6sNWVHyeHcHrrjshrv681ijKNdLOI=;
        b=SS42gLG/I4JYoFz8TMly2LZKK44zcWgvrDMKWr+k+3QIrP6FuC81lOVcYgKFgJmmba
         LVXRW93ujuPJ5NP8kyBJq8caqGC5UrIpQo5KTYiEwdU7JJYSsrFlwdWzNiT5pi3k0S2u
         AcCO9gdkSdzLgR70XLpZ60CeWJdDjIpjHWFonwMYNxmCpLozyr5K0jsemMMQwwU/63HR
         AET4QRqM/nWc/SqZ+33gyxegLMC2WK3t/MkVGMxxuKvvgouZVlQgyOxnabJCQss62v7D
         f4mItNMEvIXqyDXfBkB5YOZdMsRsNJ3Te9ooi9XCi/ev94aayjH6HkKCqZKGSmcmwIfc
         p3iw==
X-Forwarded-Encrypted: i=1; AJvYcCVp9nYzH3qfjr7bAGFG9CxIJnKVpJ1S22VMBPbcV69uYMWilG6zFue/jrR3qj/NJhvf8g6OOdtP7bwz@vger.kernel.org
X-Gm-Message-State: AOJu0YwsmXfcGwjm/MCsy0Dpy45RTaGNiRMTHwDuGenAuY3XTtx7BkaX
	J1WJt5jm75BUFU5RIO1ICnCG2YLAhLKzm/3IGqQm8grLBk/ooBuwGroej5Ioyv4=
X-Gm-Gg: ASbGncsb41io8k65/xhqlsfCZjtMWjyvCZmyAhQFJlPkih9fv2Dc1uvUTgkMCgqhpxT
	zWzCLVfBPZNUAXqvRuHb/RPwaAf2hVNFxGSmuGCcxIZTbpzEZ1nJYHOd9SbCR+0jNc4oDWm1LG+
	xkYUObBGX3K2bdL9scWK1YqO2gFetP2NEQjfJ9Fa6tPmGpbbXWZqMnJGy1YusfMQpADrX2N3kHj
	hGT7833Io9dg4KuHe+/t1WPm2UFf47aXhSlEncOBsTzQjwGpGoctY3yDWUg2KDTNk5YKEyqDLlV
	SzXe5ESkcMHbhdZ2s2JZ0yLkUXrewyfLqNDkDeIX1g==
X-Google-Smtp-Source: AGHT+IGFd8BrZDNuk5Q4tM4bK6u6ZIejPv4ztHl8dw4HSNWePmW9h5bgFFsMA3e+W8P/94Uoju3uaw==
X-Received: by 2002:a05:6602:3991:b0:85b:5869:b5f with SMTP id ca18e2360f4ac-85e2beed32fmr322406139f.5.1742555701856;
        Fri, 21 Mar 2025 04:15:01 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bdb5495sm33739439f.46.2025.03.21.04.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:15:01 -0700 (PDT)
Message-ID: <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
Date: Fri, 21 Mar 2025 05:14:59 -0600
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Christoph Hellwig <hch@infradead.org>, Joe Damato <jdamato@fastly.com>,
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
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2> <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2> <Z9z_f-kR0lBx8P_9@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <Z9z_f-kR0lBx8P_9@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/25 11:56 PM, Christoph Hellwig wrote:
>> I don't know the entire historical context, but I presume sendmsg
>> did that because there was no other mechanism at the time.
> 
> At least aio had been around for about 15 years at the point, but
> networking folks tend to be pretty insular and reinvent things.

Yep...

>> It seems like Jens suggested that plumbing this through for splice
>> was a possibility, but sounds like you disagree.
> 
> Yes, very strongly.

And that is very much not what I suggested, fwiw.

>> As mentioned above and in other messages, it seems like it is
>> possible to improve the networking parts of splice (and therefore
>> sendfile) to make them safer to use without introducing a new system
>> call.
>>
>> Are you saying that you are against doing that, even if the code is
>> network specific (but lives in fs/)?
> 
> Yes.
> 
> Please take the work and integrate it with the kiocb-based system
> we use for all other in-kernel I/O that needs completion notifications
> and which makes it trivial to integate with io_uring instead of
> spreading an imcompatible and inferior event system.

Exactly, this is how we do async IO elsewhere, not sure why networking
needs to be special here, and definitely not special in a good way.

-- 
Jens Axboe

