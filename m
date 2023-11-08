Return-Path: <linux-arch+bounces-71-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F14A17E4DA8
	for <lists+linux-arch@lfdr.de>; Wed,  8 Nov 2023 01:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C30B20CE1
	for <lists+linux-arch@lfdr.de>; Wed,  8 Nov 2023 00:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6053818A;
	Wed,  8 Nov 2023 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdR6Sn+y"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C5182;
	Wed,  8 Nov 2023 00:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F53C433C7;
	Wed,  8 Nov 2023 00:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699401693;
	bh=ZHtciTNgsUKF6h2xCcZzk1Hy/iOAMt95pG8G48nG9MQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VdR6Sn+yzn4HJkCT7ERErPRgqd0OhG/SC1iSeLCu0QG0d1cEEL45/lg/ixwH07EGU
	 Gs6AYaYh6qJi+lnZfDezSroX+je6273IKUeKlNyCAdBnjHduua4LEapel4aFqp0/OY
	 66e8RqD4PDDbexVbVMP+nYQYfwuTqE2chkq5GdhblvqvyZrm7Wov+RgdoAN7mfPLtt
	 lxFDPl3DkbmZplSeAG5p29r1sTPf8+J24E97vO3JXI9ohDz58hASz4Ucmxc2wTYf0Y
	 ZmyBoJUjFDeKA1uz8w9tOuWVpKN9dGKpBUMVhCjj8KoGthz6Mxt57uaDiW/3PWZPoy
	 sPVAiqoqRi6Mw==
Message-ID: <7ce2d027-1e02-4a63-afb7-7304fbfbdf90@kernel.org>
Date: Tue, 7 Nov 2023 17:01:31 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-11-almasrymina@google.com>
 <ZUk0FGuJ28s1d9OX@google.com>
 <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
 <CAF=yD-+MFpO5Hdqn+Q9X54SBpgcBeJvKTRD53X2oM4s8uVqnAQ@mail.gmail.com>
 <ZUlp8XutSAScKs_0@google.com>
 <CAF=yD-JZ88j+44MYgX-=oYJngz4Z0zw6Y0V3nHXisZJtNu7q6A@mail.gmail.com>
 <CAKH8qBueYgpxQTvTwngOs6RNjy9yvLF92s1p5nFrobw_UprNMQ@mail.gmail.com>
 <93eb6a2b-a991-40ca-8f26-f520c986729a@kernel.org>
 <CAF=yD-Ln4v8orUne8E7D2_eHu39PWPCrMR3Qtuh312pCu=erng@mail.gmail.com>
 <CAHS8izOU06ceKyc5oVZhdCKJqmeRdcRyJBFpjGe=u2yh=V52dQ@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAHS8izOU06ceKyc5oVZhdCKJqmeRdcRyJBFpjGe=u2yh=V52dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/7/23 4:55 PM, Mina Almasry wrote:
> On Mon, Nov 6, 2023 at 4:03 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
>>
>> On Mon, Nov 6, 2023 at 3:55 PM David Ahern <dsahern@kernel.org> wrote:
>>>
>>> On 11/6/23 4:32 PM, Stanislav Fomichev wrote:
>>>>> The concise notification API returns tokens as a range for
>>>>> compression, encoding as two 32-bit unsigned integers start + length.
>>>>> It allows for even further batching by returning multiple such ranges
>>>>> in a single call.
>>>>
>>>> Tangential: should tokens be u64? Otherwise we can't have more than
>>>> 4gb unacknowledged. Or that's a reasonable constraint?
>>>>
>>>
>>> Was thinking the same and with bits reserved for a dmabuf id to allow
>>> multiple dmabufs in a single rx queue (future extension, but build the
>>> capability in now). e.g., something like a 37b offset (128GB dmabuf
>>> size), 19b length (large GRO), 8b dmabuf id (lots of dmabufs to a queue).
>>
>> Agreed. Converting to 64b now sounds like a good forward looking revision.
> 
> The concept of IDing a dma-buf came up in a couple of different
> contexts. First, in the context of us giving the dma-buf ID to the
> user on recvmsg() to tell the user the data is in this specific
> dma-buf. The second context is here, to bind dma-bufs with multiple
> user-visible IDs to an rx queue.
> 
> My issue here is that I don't see anything in the struct dma_buf that
> can practically serve as an ID:
> 
> https://elixir.bootlin.com/linux/v6.6-rc7/source/include/linux/dma-buf.h#L302
> 
> Actually, from the userspace, only the name of the dma-buf seems
> queryable. That's only unique if the user sets it as such. The dmabuf
> FD can't serve as an ID. For our use case we need to support 1 process
> doing the dma-buf bind via netlink, sharing the dma-buf FD to another
> process, and that process receives the data.  In this case the FDs
> shown by the 2 processes may be different. Converting to 64b is a
> trivial change I can make now, but I'm not sure how to ID these
> dma-bufs. Suggestions welcome. I'm not sure the dma-buf guys will
> allow adding a new ID + APIs to query said dma-buf ID.
> 

The API can be unique to this usage: e.g., add a dmabuf id to the
netlink API. Userspace manages the ids (tells the kernel what value to
use with an instance), the kernel validates no 2 dmabufs have the same
id and then returns the value here.



