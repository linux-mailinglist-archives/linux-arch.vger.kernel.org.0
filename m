Return-Path: <linux-arch+bounces-4572-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9623D8D2B20
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 04:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C011C22EB7
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 02:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D915B14B;
	Wed, 29 May 2024 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETKXRptG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD315B102;
	Wed, 29 May 2024 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716950568; cv=none; b=JbRPAQBjOhGTIxe57fOBnx+xXYboRh8yNJaQlJ9a4M5zRUCF+yeM5GpWBKjZlMvHosaeT8M9Fnc0uNnTm55zCXWbfRkKu1n7TQlTh3MSU+K6D4HU0xAMC0TfgpDI9UzOHhgzO81cQWQmNNglHPowHfH2z9/i5n/goPt/TF9icv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716950568; c=relaxed/simple;
	bh=Jdw6MVrlDfRwAQ4Dvlaenq+UtdPYZrI/GgT7O1G/w1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttxs8XeA4GFa4EEarJMKTAggkpU7mTtZMT+iCbGExkeEABOtDAPp3GcfaCG2LXudUwNQMUxbmO9QUIZFrLNawWKRLb7C1V1ORYrVaouSPUPmGpQFDHbnwuMYpuhLvqmro3rERO0EgUN+MpaI/4QqDpNvZbbQlZKZIsse7POL7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETKXRptG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354b722fe81so1229634f8f.3;
        Tue, 28 May 2024 19:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716950565; x=1717555365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WaUSmZ7PBffPeOQ7gcFKeRJS00p2asbGxa8dHTdLep4=;
        b=ETKXRptGUP3WRzXGWJruTx4VieKCMCMbbQflyXyagF+8I3xrMhNH8yC+ycGZbob2ho
         KBm8I8KOuo0z+ndzqqlETXDizzycjvFtL5dVIV9t+pem9DeZykIqViQxT+eVSA3/ewrg
         R6m9pc7c4LWKiR7lwJjWIlIo04t5jdBSrjfIqG0xv0UeSOlLPK+EJcDBaEJDX+GDbLW4
         FbEJMdUL2ENe1iJgMZfY5317AQdUY2rUoWkOPVIDMbs8NhivC6cHjujmM8OSsvVe5ac+
         cSyLJN+RNnW7/1fAHtl7hpGk2KVzADz8X5zcIcyTOg4wYNi1d0ucbeDZ1i+YlL9VQKby
         hKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716950565; x=1717555365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WaUSmZ7PBffPeOQ7gcFKeRJS00p2asbGxa8dHTdLep4=;
        b=DsgYxP4TrLwNJuC37uaHBHU56LdDDIcCE/k7qZUmHuS+2CcOC/oB6JUhBSLkrWAVE8
         POubmHZws1uB+kDshLOOzZhJbdRbqP1Hd+Hq1JwZPykuWfM3UA69KEhqmSHxnb+6vrUh
         3J+oIwqfGJDsRqpn32yWXQpducdT80z19czsBjoZHVtUSN5DdyKT99ddvYalLKSzTji7
         PmbywfYjaSTCPqxLBvxnd34J3IZXSgBfpYONlsqDWVCqh6ewEqn86XyL0KeROw+MNdX7
         BLbE+8foVeXtb0VVfFR9X5t0+YfvZL6odufrF5rE2yKlxKfqv02HxGqpyuKMvajM2ZhD
         zu4w==
X-Forwarded-Encrypted: i=1; AJvYcCU+xFNTt3yU2m5zHnRtwEABYtR9y5pMx2IkgB560lICrBMPoyq5IQOGmxfExGB6MxxidESn6Vto9dkaJEbPSR4TRCmWeI23ryocsF/Mdsfi67dXF9uDOSAulqIwp+zbYtHkAztn6Vp9JY7fO4tgbWZaFRQjHikFvD0gsGgRkwLOR4+pixgEMmTYFDD9eOKuKmO2TDwAT+jNgcsrTaNsL5Iw4Po9Z+dj8kNTlpuZcUwxMG7vCbU77fFY6qRxAvh3xFi3CkVpOuJHDjrczJsTCRt9SX7x6CJw32P4ZVlQ9mLNGd/3ofjc36EH22iHvZUT6lwgzvxdjZBME2IvHxVfjB3OTvinFpRNFJ4v2BMKZ7rU7Dci9Fyf40PpB8bL98Qwh0+V0/B+/KXVrKRiMTObJzoL0k61zTQ9NKfl/HJZQGZQAY3+162oTKws2w98r145NpprPcmP1PWanc1RUw8wBR0WGWu1juMwWMfdhOWkHw==
X-Gm-Message-State: AOJu0YwiAWxCGmd0ajxweAkaVndJZKQHhjyPkvemz8iQw2HoJmDaZYaB
	FXY2tTBmJyj7DR3aZw6etCz22nSa0hDujF5u/hskmOTxhSDpoOB2
X-Google-Smtp-Source: AGHT+IHY3mIPt+8r+bWSLhyahH3HSb2DqvQP0sw5Fzxjvwkj4ZywRulvtF7xu0QbCHkAVDUw9UJ96A==
X-Received: by 2002:a05:6000:1841:b0:354:c0a6:2815 with SMTP id ffacd0b85a97d-355245e30f8mr11028033f8f.4.1716950565027;
        Tue, 28 May 2024 19:42:45 -0700 (PDT)
Received: from [192.168.42.154] ([185.69.144.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7d963sm13608610f8f.21.2024.05.28.19.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 19:42:44 -0700 (PDT)
Message-ID: <29464e46-e196-47aa-9ff5-23173099c95e@gmail.com>
Date: Wed, 29 May 2024 03:42:44 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 11/14] tcp: RX path for devmem TCP
To: Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
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
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240510232128.1105145-1-almasrymina@google.com>
 <20240510232128.1105145-12-almasrymina@google.com>
 <9097e78d-0e7d-43bd-bafd-e53a4872a4d1@davidwei.uk>
 <CAHS8izOe-uYjm0ttQgHOFpvp_Tj4_oRHV6d1Y1sWJAZJdCdCBA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izOe-uYjm0ttQgHOFpvp_Tj4_oRHV6d1Y1sWJAZJdCdCBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/28/24 18:36, Mina Almasry wrote:
> On Wed, May 22, 2024 at 11:02 PM David Wei <dw@davidwei.uk> wrote:
...
>>> +                      */
>>> +                     if (!skb_frag_net_iov(frag)) {
>>> +                             net_err_ratelimited("Found non-dmabuf skb with net_iov");
>>> +                             err = -ENODEV;
>>> +                             goto out;
>>> +                     }
>>> +
>>> +                     niov = skb_frag_net_iov(frag);
>>
>> Sorry if we've already discussed this.
>>
>> We have this additional hunk:
>>
>> + if (niov->pp->mp_ops != &dmabuf_devmem_ops) {
>> +       err = -ENODEV;
>> +       goto out;
>> + }
>>
>> In case one of our skbs end up here, skb_frag_is_net_iov() and
>> !skb_frags_readable(). Does this even matter? And if so then is there a
>> better way to distinguish between our two types of net_iovs?
> 
> Thanks for bringing this up, yes, maybe we do need a way to
> distinguish, but it's not 100% critical, no? It's mostly for debug
> checking?

Not really. io_uring definitely wouldn't want the devmem completion path
taking an iov and basically stashing it into a socket (via refcount),
that's a lifetime problem. Nor we'd have all the binding/chunk_owner
parts you have and probably use there.

Same the other way around, you don't want io_uring grabbing your iov
and locking it up, it won't even be possible to return it back. We
also may want to have access to backing pages for different fallback
purposes, for which we need to know the iov came from this particular
ring.

It shouldn't happen for a behaving user, but most of it would likely
be exploitable one way or another.

> I would say add a helper, like net_iov_is_dmabuf() or net_iov_is_io_uring().

We're verifying that the context the iov bound to is the current
context (e.g. io_uring instance) we're executing from. If we can
agree that mp_priv should be a valid pointer, the check would look
like:

if (pp->mp_priv == io_uring_ifq)

> Checking for niov->pp->mp_ops seems a bit hacky to me, and may be
> outright broken. IIRC niov's can be disconnected from the page_pool
> via page_pool_clear_pp_info(), and niov->pp may be null. Abstractly

It's called in the release path like page_pool_return_page(),
I can't imagine someone can sanely clear it while inflight ...

> speaking the niov type maybe should be a property of the niov itself,
> and not the pp the niov is attached to.

... but I can just stash all that in niov->owner,
struct dmabuf_genpool_chunk_owner you have. That might be even
cleaner. And regardless of it I'll be making some minor changes
to the structure to make it generic.

> It is not immediately obvious to me what the best thing to do here is,
> maybe it's best to add a flag to niov or to use niov->pp_magic for
> this.
> 
> I would humbly ask that your follow up patchset takes care of this
> bit, if possible. I think mine is doing quite a bit of heavy lifting
> as is (and I think may be close to ready?), when it comes to concerns
> of devmem + io_uring coexisting if you're able to take care, awesome,
> if not, I can look into squashing some fix.

Let it be this way then. It's not a problem while there is
only one such a provider.

-- 
Pavel Begunkov

