Return-Path: <linux-arch+bounces-6684-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0549961C0B
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 04:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDD11C232F6
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 02:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8536B59B71;
	Wed, 28 Aug 2024 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9Bmt1JR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF74481B3;
	Wed, 28 Aug 2024 02:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811875; cv=none; b=U8N+6m44nYBDymuCksiX2gGrS/veRxwo+sIsFI+w34CAr7NoOm6HGtwJQMLnx85/n4lEMykJy4081/jTgez4R5FQuyYfij+YlSNg3bWMszRzMFN3m9Ovqbwr7Eje9LK6ndEzkn9GbW4dkRItM7tqcfMfCUqR79Amn1C15KJeEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811875; c=relaxed/simple;
	bh=tbhzQ1da3mBVV060Og29QANn1s4vz5Vd4ovZ/NNJcUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5aEUoWvDmUqMs0c9BmJSCKrEw+/wJAr7ybcv8sT+gvqIQKl9lsaDWM9uv5QiqmW0ZIm/DuwNNPw3IBHY+5s4uggJx4wNcUdkHrCVgIa2ITWA7PiQ6E5lg+bpWScRzmL2nWCUogKSgh2eZKnjnnKRlXxYc+CcIfyphh1JrstlV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9Bmt1JR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E784C4FEE9;
	Wed, 28 Aug 2024 02:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724811874;
	bh=tbhzQ1da3mBVV060Og29QANn1s4vz5Vd4ovZ/NNJcUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b9Bmt1JRKFBCrnIFqkRTsrtV2UxALLlwq9vjsa8mb6ADifsmdWpQkF6hV/RYp8vQA
	 KnlrsUZWHHrZTtadELynyygYzNgxIL5XjiYXqvsDF4WjDbVNdoVWcjeJP/CMV5jE+5
	 zHY1WzE7dhEgfg1nYdKdE+Kss/9anIAQAvEtqTsmXn5d1UFI9SFv6kPJc99SCMRNQM
	 e5zmbEEJvj2B7cIjhKHtljG3nSZ00UtlbSdrVtBkmpzbQotM4l2h2mL+SWEBBmpQt7
	 JSmguwlN4ydS894ghDp569iFgNhfAjPbkNp3FHOMAwrnt4gmuwMvVn9FUd04rX88Ko
	 f0IMC8yARB4lw==
Date: Tue, 27 Aug 2024 19:24:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
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
 de Bruijn <willemdebruijn.kernel@gmail.com>, "=?UTF-8?B?QmrDtnJuIFTDtnBl?=
 =?UTF-8?B?bA==?=" <bjorn@kernel.org>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, David
 Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, linux-mm@kvack.org, Matthew Wilcox
 <willy@infradead.org>
Subject: Re: [PATCH net-next v22 05/13] page_pool: devmem support
Message-ID: <20240827192431.7145b06e@kernel.org>
In-Reply-To: <20240825041511.324452-6-almasrymina@google.com>
References: <20240825041511.324452-1-almasrymina@google.com>
	<20240825041511.324452-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Aug 2024 04:15:03 +0000 Mina Almasry wrote:
> +	/* Assume net_iov are on the preferred node without actually
> +	 * checking...
> +	 *
> +	 * This check is only used to check for recycling memory in the page
> +	 * pool's fast paths. Currently the only implementation of net_iov
> +	 * is dmabuf device memory. It's a deliberate decision by the user to
> +	 * bind a certain dmabuf to a certain netdev, and the netdev rx queue
> +	 * would not be able to reallocate memory from another dmabuf that
> +	 * exists on the preferred node, so, this check doesn't make much sense
> +	 * in this case. Assume all net_iovs can be recycled for now.
> +	 */

This is probably a bit too verbose, and we shouldn't talk about dmabuf
specifically:

	/* NUMA node preference only makes sense if we're allocating
	 * system memory. Memory providers (which give us net_iovs)
	 * choose for us.
	 */

Some of the code moves could be a separate patch, but either way:

Acked-by: Jakub Kicinski <kuba@kernel.org>

