Return-Path: <linux-arch+bounces-4799-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C2D902550
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 17:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F4B1C234D4
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7643B14E2E4;
	Mon, 10 Jun 2024 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETS5HpY/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1758D14372B;
	Mon, 10 Jun 2024 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032608; cv=none; b=ZhYILebKFCMEgzSN4EGBu+fvUU5Pw6mpMCH2wztUqfRDD+DM5kxAl4Stq6eg+jkffrA6eC7VnVoj0e2lqEuV9MPPxurzMfxcXRT7MNQKfkW4sgz348FIFW26ZLlbykX1I5iDcp9wf9THCKVWRl5eRCHgHW0mAwOncAZHrKGjdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032608; c=relaxed/simple;
	bh=O4K2WVyffh0yFu7MqI9zVOz6iOMDjKw5eu0ZI4dIaVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUvcn3DdELyY03D87REYHx1VY9vm+OUjg+iJsv8rYbaod2/+9Gdqt7xWt/A0+cZiZOOvSKB2wGQbjqc3c8cgdIzBKmFbKcnhjoeAG9Q+swGp7HDTQw7C8J8IME/9ne9nrJW9x6l8JWLAJJIfM96tA9lauerGIrl6OHn4OF1pdJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETS5HpY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17272C32786;
	Mon, 10 Jun 2024 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718032607;
	bh=O4K2WVyffh0yFu7MqI9zVOz6iOMDjKw5eu0ZI4dIaVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ETS5HpY/0Kf6xf4RQ1EeQ5ezwwa3Hu3a2SFdCj67odD7KI2UYD7Fs2d1r5g7y6wIf
	 vTIqROSJQNRXs1n9kJDCdzxcS7+nLskAscR53y6Tg+D3s6zi6S/mSwJ7junGgMfPGz
	 cFVN88hW7TnVgKXnCw7asGpLrZreR7IS4oFRMy+H9qtpSq3cfrL6cdUOlH8XQCjevL
	 VdpqhB/9QWwIUedEYRuh4MevTomxzXE6ulQ6FOvNli9X5RdARoFkmIdzyPoMwtaZ2o
	 jqiLoW+RrYZ9fTS86/FAROafJwR54RozEVCGgmVDPux00UDvaj3N87ZaAfFbOkWXsm
	 4oYGUGuuH8ZZQ==
Message-ID: <59443d14-1f1d-42bb-8be3-73e6e4a0b683@kernel.org>
Date: Mon, 10 Jun 2024 09:16:43 -0600
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>, Mina Almasry <almasrymina@google.com>,
 Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
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
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <20240607145247.GG791043@ziepe.ca>
 <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
 <54975459-7a5a-46ff-a9ae-dc16ceffbab4@gmail.com>
 <20240610121625.GI791043@ziepe.ca>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240610121625.GI791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/24 6:16 AM, Jason Gunthorpe wrote:
> On Mon, Jun 10, 2024 at 02:07:01AM +0100, Pavel Begunkov wrote:
>> On 6/10/24 01:37, David Wei wrote:
>>> On 2024-06-07 17:52, Jason Gunthorpe wrote:
>>>> IMHO it seems to compose poorly if you can only use the io_uring
>>>> lifecycle model with io_uring registered memory, and not with DMABUF
>>>> memory registered through Mina's mechanism.
>>>
>>> By this, do you mean io_uring must be exclusively used to use this
>>> feature?
>>>
>>> And you'd rather see the two decoupled, so userspace can register w/ say
>>> dmabuf then pass it to io_uring?
>>
>> Personally, I have no clue what Jason means. You can just as
>> well say that it's poorly composable that write(2) to a disk
>> cannot post a completion into a XDP ring, or a netlink socket,
>> or io_uring's main completion queue, or name any other API.
> 
> There is no reason you shouldn't be able to use your fast io_uring
> completion and lifecycle flow with DMABUF backed memory. Those are not
> widly different things and there is good reason they should work
> together.
> 
> Pretending they are totally different just because two different
> people wrote them is a very siloed view.
> 
>> The devmem TCP callback can implement it in a way feasible to
>> the project, but it cannot directly post events to an unrelated
>> API like io_uring. And devmem attaches buffers to a socket,
>> for which a ring for returning buffers might even be a nuisance.
> 
> If you can't compose your io_uring completion mechanism with a DMABUF
> provided backing store then I think it needs more work.
> 

exactly. io_uring, page_pool, dmabuf - all kernel building blocks for
solutions. This why I was pushing for Mina's set not to be using the
name `devmem` - it is but one type of memory and with dmabuf it should
not matter if it is gpu or host (or something else later on - cxl?).


