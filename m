Return-Path: <linux-arch+bounces-3017-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AA987E1FF
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 03:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 547F9B23AAF
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 02:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1017C1D530;
	Mon, 18 Mar 2024 02:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cl4LJpQb"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5701E87E;
	Mon, 18 Mar 2024 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710727384; cv=none; b=Mt8QUMmDUCeuERpl31klCv8Z3z2MpGXziKj32es2c4DvLZAd8aAXPYRsk7P/ZWh7SVTzG9IYzZ7sQtM+bdCGGYJN/BacN5XkLcdvhCyN9wszOZMEwH8ZDxBQ11yI/X90tfgMVIEs5gN2MTjehDZ02WXz1tUJA7ACkbeq75r9sfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710727384; c=relaxed/simple;
	bh=s2DTcYQv5t1E/AgG3AGAU+YYi9lLQeVvZlKV3Acyq9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3bmTEdiAyqp1q3XaGdbWkeJM3kHW5qwF7yN9BjkHqVGg/t7dHtsrpD7+yTCqM9P3FPHRtNpJJKCASiuEem/IqH6KTWcozmje7etvBacyIyaxpwI8sdKcQt1LKVivU/UqrsNMCCI0NgkVVXhO1bL1wlWJvt5T2JwbZCQ5+bh41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cl4LJpQb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nzZSUZc1IlLbKe81oj0XpOImEHMN1QwfDar40WlDId8=; b=Cl4LJpQbj38gTTSZEQUZ+1vpu3
	kfvxEgbVIrASKys6zjX6NXQRWu09Lgn3IV65yLbtH4dUG8GB1Yqrznlf5YYQk37UR4dpnqVOEhv1o
	w2K5FOiZ3xKMvsyJFyxhLSnZwjPs1HCtxbr+tuF9JhbtLngwAWn7usG/oNe+6woPNU7cNjWJxlJqD
	ln0QmERP5F9CIT9MIbbXqzH0GBZ4M10aRQSSRBzUQIDZ7/9+/IL2GfU9AJDXFI35koQIIJJU8jO3B
	QMSHsOqDU3V3fvm5V+tc15IIGsSZnzBfpqlpQEctTDCEj3pPcRujHYO3Wr1dAgj7vx/NrDvJcf1hE
	buU9lkcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm2Ky-00000006zOo-2Ad2;
	Mon, 18 Mar 2024 02:02:53 +0000
Date: Sun, 17 Mar 2024 19:02:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeelb@google.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for
 custom page providers
Message-ID: <ZfegzB341oNc_Ocz@infradead.org>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305020153.2787423-3-almasrymina@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 04, 2024 at 06:01:37PM -0800, Mina Almasry wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> The page providers which try to reuse the same pages will
> need to hold onto the ref, even if page gets released from
> the pool - as in releasing the page from the pp just transfers
> the "ownership" reference from pp to the provider, and provider
> will wait for other references to be gone before feeding this
> page back into the pool.

The word hook always rings a giant warning bell for me, and looking into
this series I am concerned indeed.

The only provider provided here is the dma-buf one, and that basically
is the only sensible one for the documented design.  So instead of
adding hooks that random proprietary crap can hook into, why not hard
code the dma buf provide and just use a flag?  That'll also avoid
expensive indirect calls.


