Return-Path: <linux-arch+bounces-4847-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F18790574A
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 17:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA592886CB
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBC317F4F5;
	Wed, 12 Jun 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUUDhFkB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B2A1EB2A;
	Wed, 12 Jun 2024 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207265; cv=none; b=UNsoko0/78auhNQrD8urD4Ib7rK6/elCCmCstZaFp1PutZF6iRykHAsGVCM/kJQMtnRkL2v/3QigjQduSxdqJsNJUD9xt8W3jesyFZj7Hr78F1dcg/H8i2y1ptjm4HnY3j+W9m/waF8G2xt7TyjnNuAyqQtlrBQ/F3plqa21wH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207265; c=relaxed/simple;
	bh=RcO8kJK1SPBxidMQCBZS6Nufe2pEKnWn1BExnfdFDhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5RBiW4jLym8vj659wwxhgGumRTWDTtjLtvKARwuNZ+bKSnrnMR62SQGWlXoPniqOLLkA0NaAqgFd+KLtl4fmjvhlaLmKmWq+ZrYM/Vu4/V/vBHpWsr54vdG6WxebUjBEVGUJUmSxw+koReJDsrSSwBTT0+7ilvhgYfSnwk1OTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUUDhFkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CCFC116B1;
	Wed, 12 Jun 2024 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207264;
	bh=RcO8kJK1SPBxidMQCBZS6Nufe2pEKnWn1BExnfdFDhs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tUUDhFkBvtiENrkhGjsuaqjXStFu2y4QmRyEz8Z44+BNeCUMT1FwXpmM/Z+ZWMWEt
	 xzcTbt93S5t/Z2Gjbj8/IPxqyEriOfVzDPo8HuhM4xgnSUgcbkjoEHG3d2MQTSOFzv
	 0qw54/7Zv6wsSjSdQQTHNp9M57WuCZdau/mlvGyNsjZNzhUF8fmviXzmsmm/taiwEh
	 UVHIkfWuUcjER2VhozjXME73U59vBlXDJxWYNfGXzCU6uWRy+oqe9bZwHjAo8SrVfr
	 B8TqlIFed1ii275iDSfF4yGkhIgvyJBVxzUfGA6GSAus8H08zqOCQJNpZ4tAB3Ft9h
	 9EyHQ6Et14wWw==
Message-ID: <12fd227b-5f6a-4929-baaa-7f657933cde6@kernel.org>
Date: Wed, 12 Jun 2024 09:47:40 -0600
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
To: Jason Gunthorpe <jgg@ziepe.ca>, Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
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
References: <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <20240607145247.GG791043@ziepe.ca>
 <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
 <54975459-7a5a-46ff-a9ae-dc16ceffbab4@gmail.com>
 <20240610121625.GI791043@ziepe.ca>
 <59443d14-1f1d-42bb-8be3-73e6e4a0b683@kernel.org>
 <00c67cf0-2bf3-4eaf-b200-ffe00d91593b@gmail.com>
 <20240610221500.GN791043@ziepe.ca>
 <CAHS8izNRd=f=jHgrYKKfzgcU3JzkZA1NkZnbQM+hfYd8-0NyBQ@mail.gmail.com>
 <20240612120602.GQ791043@ziepe.ca>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240612120602.GQ791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/24 6:06 AM, Jason Gunthorpe wrote:
> On Tue, Jun 11, 2024 at 11:09:15AM -0700, Mina Almasry wrote:
> 
>> Just curious: in Pavel's effort, io_uring - which is not a device - is
>> trying to share memory with the page_pool, which is also not a device.
>> And Pavel is being asked to wrap the memory in a dmabuf. Is dmabuf
>> going to be the kernel's standard for any memory sharing between any 2
>> components in the future, even when they're not devices?
> 
> dmabuf is how we are refcounting non-struct page memory, there is
> nothing about it that says it has to be MMIO memory, or even that the
> memory doesn't have struct pages.
> 
> All it says is that the memory is alive according to dmabuf
> refcounting rules. And the importer obviously don't get to touch the
> underlying folios, if any.
> 

In addition, the io_uring developers should be considering the use case
of device memory. There is no reason for this design to be limited to
host memory. io_uring should not care (it is not peeking inside the
memory buffers); it is just memory references.

One of io_uring's primary benefits is avoiding system calls. io_uring
works with TCP sockets. Let it work with any dmabuf without concern of
memory type. The performance benefits the Google crowd sees with system
call based apps should be even better with io_uring.

Focus on primitives, building blocks with solid APIs for other
subsystems to leverage and let them be wired up in ways you cannot
imagine today.


