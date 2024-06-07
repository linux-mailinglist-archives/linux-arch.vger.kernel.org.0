Return-Path: <linux-arch+bounces-4751-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E86900966
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 17:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A1D1F238A2
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C50D1991B9;
	Fri,  7 Jun 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDW5t2NT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A0188CBB;
	Fri,  7 Jun 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774965; cv=none; b=CFYy8whEeQqn7+HRmz5hx8QzRiAzecWs0zuQ51DgN+HFEA6VZbcGJ9MBVthtzZX42bBzgOrHeSZ8lnbsAlyqXU2ZBFBxVkWRyy1AoDcpyBSZ+DR+edXDU1qV/O8jHXs+WxWmiqLAJrA9nCm+DDqzP8kLwjB7t+e4QY6IJQaJHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774965; c=relaxed/simple;
	bh=nHdWzRShRyplBXJ8eNVdSqljR8XbFZd5wgfSajt2/ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dwz5vYEOogT0RM63BcRZauqL4wdiRYm4F4X6dq+/AQ93GFITh+QmguneTlDrT7CyBKqTcrzFuF7E53m3Y9xo5TN0tqtuWvlvSd/ScroP2diODZtpLS2smR8GZatAtcWpmOiKZEPr3ueunkV8kijsNDqAvnkH8ouXIkE/LiFxHfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDW5t2NT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b93370ad0so3193137e87.2;
        Fri, 07 Jun 2024 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717774962; x=1718379762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ztEfaA9QN5DY5F1t7l1AL7LIdxxv5aD3SKdILYYcZ0=;
        b=LDW5t2NT6lZWWZFs7NaHC/D1tOuBpsruVxqATiGUwYRjMd+tyHgux7Y+2pgYBkveS0
         3iCyviEZlUAb73D7mndF7dH4VQ5auJdu6dV7nAQRbvvTAP3De5azx07r/97wTWUEwSmd
         nvlzyHhP6WutWGBG7U8KgCKiY/UtvUwLD3JqCt24FIPgriZaShcHZmXwS/Jkrbof4x6C
         UcUeUqCRq6NT/9oo3XT3VBVycFpWWLS77ZBQSNEgxe9QYnS/bbbrUKgl/UCpsoaT1r5C
         eKrnxSOks9RDIF8plixzCDe6MYDnzbqYdPeBoXKnG2+hBXIyp6qieOo6jA5Pf5KtglXS
         EnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717774962; x=1718379762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ztEfaA9QN5DY5F1t7l1AL7LIdxxv5aD3SKdILYYcZ0=;
        b=Dw03Pq2I+L7ttOHKNRquuVLzFZEcU1/LXt8v642D3RfW4yTrzXe+k7dFs0mxO3JvKP
         dCXobR9JweYPvP5kPl3uC1P/FiKwzg+inHHxMMZZzwK+ztMD4aUZhcJD2oSHPzgJf+zn
         xfQpcU+4ClkMlTslc1aBJzj35yB9ycph7oDeKm3uuwqUypXZXF2Be0bcU/FLntepbZ+b
         hHC7qMppudXWwhdMQpl1DIDIC8I2CFmqqX2+FZnCW3+BwRS3qWi7+TPFQHMnZ6IEOp81
         rM1T6G6A7ZBP6SlAk9FZdNCgD3luKnZYDmx0LX8rcUhWCygijyWgS/C8QWuMTdlTX3uO
         DmlA==
X-Forwarded-Encrypted: i=1; AJvYcCVZfWqMqGXXHaKAanuau6p2QHPLI2vngrMR48bYJ2nJg/XBKAjZYPu601QSNYnr9GME8VHYpD4R1RIVbOP27b9qYhjiFCG9uVsvTByfJp10a2B7A5EYoFhanEhYYAD648xCMtgVtJ1zsGKLkjSRuEA3blcYuhWZXRoEzPbDNq4g+CNmBQ9wxYpc519BXdj+8Bk1fVLBozU/2Ry0Qhz8/FsNQXlasN9B1l1HVykuW4aHCibKfkys79y4WMMEBHWo0Wxygdr2QdIAL2Q7bNeTTuqORIxQjKCiNYFYVEA+XnI3reNiOuX0ADCOlg4vU3bxivlHyTDwcOtpKQGq2QxHj2iH76QTcTMeue2rSLsVKcMc/W3qbYGOw7LFH+pK2pd89Mw3MkX4BV7++6W1hKNTBqRapQLgT1JjpfOMH1kijHz7ICtpnFUTCR5koajq8zvpNmuEBwdNOBWpkinln/aL5m2M6ygt1OMJQJ9BLl1wamvgJQwbIRwdQoi07Yd3G009smFIF1MGfw==
X-Gm-Message-State: AOJu0YzK+V0aec0vd9NXLHEF+71QcMqsWyQT3IbZFWYh+DF3pvEa9VTq
	qYoLFaxhX5/Vz0OlsUlxN16yy1wl4+f1H33xHnk2IOJ5x/WmQfJF
X-Google-Smtp-Source: AGHT+IEFn+6+A9/ic4XpRfGuUMADB8GJccpGu+nMUZFNqtplHU80DwYmmylA2YOXqYyEGugmrIA8hA==
X-Received: by 2002:a19:430f:0:b0:52b:7b8a:2d2f with SMTP id 2adb3069b0e04-52bb9f62745mr2133552e87.2.1717774961414;
        Fri, 07 Jun 2024 08:42:41 -0700 (PDT)
Received: from [192.168.42.206] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80582335sm264164166b.39.2024.06.07.08.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 08:42:40 -0700 (PDT)
Message-ID: <8f44ca2a-8910-418f-b4a6-ca1e051484ba@gmail.com>
Date: Fri, 7 Jun 2024 16:42:43 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/7/24 15:27, David Ahern wrote:
> On 6/7/24 7:42 AM, Pavel Begunkov wrote:
>> I haven't seen any arguments against from the (net) maintainers so
>> far. Nor I see any objection against callbacks from them (considering
>> that either option adds an if).
> 
> I have said before I do not understand why the dmabuf paradigm is not
> sufficient for both device memory and host memory. A less than ideal
> control path to put hostmem in a dmabuf wrapper vs extra checks and
> changes in the datapath. The former should always be preferred.

If we're talking about types of memory specifically, I'm not strictly
against wrapping into dmabuf in kernel, but that just doesn't give
anything.
But the main reason for allocations there is the difference in
approaches to the api. With io_uring the allocation callback is
responsible for getting buffers back from the user (via a shared
ring). No locking for the ring, and buffers are already in the
context (napi) where they would be consumed from. Removes some
headaches for the user (like batching before returning buffers),
and should go better with smaller buffers and such.

> I also do not understand why the ifq cache 

I'm not sure what you mean by ifq cache. Can you elaborate?

> and overloading xdp functions

Assuming it's about setup via xdp, it was marked for remaking in
RFCs for longer than desired but it's gone now in our tree (but
maybe not in the latest series).

> have stuck around; I always thought both were added by Jonathan to
> simplify kernel ports during early POC days.

-- 
Pavel Begunkov

