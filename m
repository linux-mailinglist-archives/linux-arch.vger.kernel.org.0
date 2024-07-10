Return-Path: <linux-arch+bounces-5352-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1907092D579
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 17:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2241C21759
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D5194AE6;
	Wed, 10 Jul 2024 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nhh6UqTy"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44791194ACF;
	Wed, 10 Jul 2024 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627000; cv=none; b=Ubk1J8xN+AjpFPC3oyxn9cz6+lYGu7Xkd3KQzXIGpNIYRzdnUECoiNGX0uToNAn9Z80/VhSN80xaLDaUb1ZUtIXAjDhsur4akC68tVCa/IfFfk+XPIazT0xOMTauQoUKLLDsTpHnNES7rKZrG9MqL49zDc6Bz1X+bxTGbbY1+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627000; c=relaxed/simple;
	bh=LnSN3f1kBTQZBMgn9k+Kpjy3WQodTEYNn6I5AuMkXR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuEeR10RyODCEz/6odpBqwPSHdV90x2mLplpPnogrs5Yyq2V6R4cHtnzZd8+0lenBfbBz/UiAs0CFtPEg7WBmVknPX+WBtahQzv7hASpvvmD9qcnmlCCabSfj2kDuySohBJ4u0ZQlo+hmNPXX0hJI3SM7q41J2HyGGUQzamsifQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nhh6UqTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7A0C4AF0F;
	Wed, 10 Jul 2024 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720627000;
	bh=LnSN3f1kBTQZBMgn9k+Kpjy3WQodTEYNn6I5AuMkXR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nhh6UqTyrSr0wo2AywZf2hg4eQ0qQGSBsIOTv4oGyXQTX6vabooxsZHLJX1VF1c59
	 tSODVeFqtFA2V8MxwFzIpm4gp/4O29+s9eX715D6Rq36F5EKQOe6ryT2OR0gglz/UO
	 UKohM+G9agXaWRQxMn6sSbc3DQYzoRrBXaqJz1VydZ+/IN+BVAkeuET3oh+YhAxE0R
	 h9ouVOeN7urrk1jU9/IKmO48m/vG2HGtWSX6NNlntfMbLGdNMTy7dwUnWPRVqrmgpi
	 D7BDS6Sqpuuv8GoHSGy+v01VvLPT8j1t851KKG4kjk87hcVQlLRJ/CcXiE7RBN/SZj
	 F4nU4p5RcNZyw==
Date: Wed, 10 Jul 2024 08:56:37 -0700
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
 Zhang <kaiyuanz@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH net-next v16 03/13] netdev: support binding dma-buf to
 netdevice
Message-ID: <20240710085637.4284c7d7@kernel.org>
In-Reply-To: <20240710001749.1388631-4-almasrymina@google.com>
References: <20240710001749.1388631-1-almasrymina@google.com>
	<20240710001749.1388631-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 00:17:36 +0000 Mina Almasry wrote:
> +		err = gen_pool_add_owner(binding->chunk_pool, dma_addr,
> +					 dma_addr, len, dev_to_node(&dev->dev),
> +					 owner);
> +		if (err) {

	kfree(owner);

right? If the insert fails gen_pool_for_each_chunk() won't see it

> +			err = -EINVAL;
> +			goto err_free_chunks;
> +		}

