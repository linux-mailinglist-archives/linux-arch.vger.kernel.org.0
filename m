Return-Path: <linux-arch+bounces-6066-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D909499B8
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 22:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB091F21F41
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 20:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B145D15E5CE;
	Tue,  6 Aug 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD3DuZ2+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50179158DDC;
	Tue,  6 Aug 2024 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977968; cv=none; b=jnyKKzJB86LyfIogb9FV3tp2NilDiN6apXGRofxGwLftFU0rLww3QykJbxNu/JGQmaBXg0KEzfkxM5cOZBmzS/wEyYYJzwpEln4RjpW/ZdTox2/8OBjSSlZERp4+YRXLFA1NiQ04kGzUh1y6vLmec0lyI0FxDbuWMyYiYqB6Bek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977968; c=relaxed/simple;
	bh=oQ7qityzvDiPJTZS3Szpb70s0aIQdtnagYi0Qj0kT00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEEW477lcgjBGq7yGuKF5TgqGMVBoWFAcobVzlRbN7vhgmmESrDqCfXXAb9DqAlc2Ij2Bei5pW/M8Tayz+OIzBDetdw526ZFhNlJCleNjqROiheIb20yDLN4vhBV1/3snfrIWF+65LbhW/O1DeLVQHFTSmLsgTz7bBVkvwHV75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD3DuZ2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82C3C32786;
	Tue,  6 Aug 2024 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722977967;
	bh=oQ7qityzvDiPJTZS3Szpb70s0aIQdtnagYi0Qj0kT00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bD3DuZ2+SxmgaCgzJWHtZH/BYbg66l2gd+LZppP8V0SjvcVqsJKtaaiDssO1v+eTr
	 DepGkqmJxITFe54Lre2tS/vEGrc22Vu63ljH1RRMC3HUSH2BP59CbVsybYRx5BroxY
	 QzqlaSzYfm+jheMBLL1UJu7QHVFmgQmRAU9zimWldMZ8D1XFiUqchTvoNAaiXS7hzH
	 URysUscNMnVRS9xQk9PTPdzDrWF0jmd8XP7i5YGixpWl4NoGrnzp/dD/HTEvG8s/13
	 HUuL28HXkNnUqRHm0Cu4xB/2+bNxvDDDYP/Iqrw7CXRtllgNPubXkFhZKGOucEcp/W
	 CHGsOnZxxgIOw==
Date: Tue, 6 Aug 2024 13:59:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, Ivan
 Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, Kaiyuan
 Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v18 07/14] memory-provider: dmabuf devmem
 memory provider
Message-ID: <20240806135924.5bb65ec7@kernel.org>
In-Reply-To: <20240805212536.2172174-8-almasrymina@google.com>
References: <20240805212536.2172174-1-almasrymina@google.com>
	<20240805212536.2172174-8-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 21:25:20 +0000 Mina Almasry wrote:
> +	if (pool->p.queue) {
> +		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
> +		 * configuration doesn't change while we're initializing the
> +		 * page_pool.
> +		 */
> +		ASSERT_RTNL();
> +		pool->mp_priv = pool->p.queue->mp_params.mp_priv;

How do you know that the driver:
 - supports net_iov at all (let's not make implicit assumptions based
   on presence of queue API);
 - supports net_iov in current configuration (eg header-data split is
   enabled)
 - supports net_iov for _this_ pool (all drivers must have separate
   buffer pools for headers and data for this to work, some will use
   page pool for both)

What comes to mind is adding an "I can gobble up net_iovs from this
pool" flag in page pool params (the struct that comes from the driver),
and then on the installation path we can check if after queue reset
the refcount of the binding has increased. If it did - driver has
created a pool as we expected, otherwise - fail, something must be off.
Maybe that's a bit hacky?

