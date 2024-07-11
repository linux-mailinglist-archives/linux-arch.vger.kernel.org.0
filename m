Return-Path: <linux-arch+bounces-5366-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EACF92DDED
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2024 03:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411571F21FA7
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2024 01:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D7C79CC;
	Thu, 11 Jul 2024 01:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KObjfEuH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21231EDE;
	Thu, 11 Jul 2024 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720661005; cv=none; b=ZDjuKyJd8F/aCKl9XO5TvDU4vuPNSwdRoBvboAKwur+qrzwpjnrLnLa/sZ2BCRQnoqgHiEC2/oOXLgYLFsSg2qc7iXp2MwH3K3PaZ4dJRuj/x5oZBtjj1nliCGCQKqKzwL7Ze6WTRhceep9YOfUa9ufLbTCsrqUrL70pfXf20gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720661005; c=relaxed/simple;
	bh=BNGP4duokc8ncBE7271BuDVYIIwbBx7q1BctfwQaFqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHy64VVL8cO57wA/RXq25TiTDMmwiSTq5Pteu0mEhhcyQhXAsWVtst4PmrMjNvvU5/hJ77XbxDlxaoGGoVhkUuMypd+mQFvse7HGtsYDTg+XBYWwRTBW6lP23sJyR+JBztzx3kyf9MOPqcKYrrNnm6z3cLubbokUAw/CDKasWyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KObjfEuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0730CC32781;
	Thu, 11 Jul 2024 01:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720661004;
	bh=BNGP4duokc8ncBE7271BuDVYIIwbBx7q1BctfwQaFqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KObjfEuHg+F+/bNhywmUUTSGFn3bv/UvTtLsoLP/A8j+JrYJp2Ka3O/ezDg7IquU7
	 64ig4waKXABYjNs3vbvrYkR7ULJbLzB1fN702YTrMz0Hkxis8BMfqdvmxik/sQQ21K
	 XXeIDIYx3mYfCBeuUJq0aaQspg3EQOjFC5mPiG7btWl7kDBRHcLzhqrGBo3ghENCin
	 5wPf+YTZV7+ICl9eWbLIMvEJhTp71W9ETPYKnyot5YbyIOKw8smwAldqsdn2p/dXmj
	 xdQJd61Xv49iwsP6htPMECVZNf2v9MhwXGUeQ/ixSeS6yXvvH4jnN0ZxI/3Fhw701B
	 s1ygLn4p0sytg==
Date: Wed, 10 Jul 2024 18:23:22 -0700
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
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, linux-mm@kvack.org, Matthew Wilcox
 <willy@infradead.org>
Subject: Re: [PATCH net-next v16 05/13] page_pool: devmem support
Message-ID: <20240710182322.667f0108@kernel.org>
In-Reply-To: <CAHS8izPTqsNQnQWKpDPTxULTFL4vr4k6j9Zw8TQzJVDBMXWMaA@mail.gmail.com>
References: <20240710001749.1388631-1-almasrymina@google.com>
	<20240710001749.1388631-6-almasrymina@google.com>
	<20240710094900.0f808684@kernel.org>
	<CAHS8izPTqsNQnQWKpDPTxULTFL4vr4k6j9Zw8TQzJVDBMXWMaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 16:42:04 -0700 Mina Almasry wrote:
> > > +static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
> > > +{
> > > +     __netmem_clear_lsb(netmem)->pp = pool;
> > > +}  
> >
> > Why is all this stuff in the main header? It's really low level.
> > Please put helpers which are only used by the core in a header
> > under net/core/, like net/core/dev.h  
> 
> Sorry none of those are only used by net/core/*. Pretty much all of
> these are used by include/net/page_pool/helpers.h, and some have
> callers in net/core/devmem.c or net/core/skbuff.c
> 
> Would you like me to move these pp specific looking ones to
> include/net/page_pool/netmem.h or something similar?

That's because some things already in helpers have no real business
being there either. Why is page_pool_set_pp_info() in helpers.h?

