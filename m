Return-Path: <linux-arch+bounces-6833-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057B99651F5
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 23:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B714A285002
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 21:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9221B5820;
	Thu, 29 Aug 2024 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax9B3K99"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31FF18950B;
	Thu, 29 Aug 2024 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966923; cv=none; b=MyX+lK5Wv0PmTRA0wYjCXnSAnZ5tfCaOdUruvkl8Nm26kLrvfMn+540XswD4GT/mHdAouJ6WbJeAbmXFeispkHnPaPB/DGqLW3RavIOcppboUVqiQ5n3C9QkaH4Z68p4taGyXhegrIJ5B9DjNkP9wcSUt3bQBmjIdwnlJPdu1x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966923; c=relaxed/simple;
	bh=eLbNQ6G9fAtikDeusW+cHvDy3CVuzcI4mzdMls/Dda8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPli1IdQ7lUIIKUmBMH+yVaOiPnjsKC7WLiaY0Io5fd+zdQqioU+Fs5PyWHqIU7MG5dppBjMeVBkqmz+ylRmLpMBi/YtVnoznYfUdLSXdi7WcQwmCx/eDcEsP+6VgoCDQVLs5+I/zN+VABbvklsjX1irC+X7C5kzikD8jf2G0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax9B3K99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F341EC4CEC1;
	Thu, 29 Aug 2024 21:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724966922;
	bh=eLbNQ6G9fAtikDeusW+cHvDy3CVuzcI4mzdMls/Dda8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ax9B3K99aMwINgqedd1GcT2dh/xdXD8pelnJFa0YCRuR/soamnOCjmO8Q7rJ4Fv6Q
	 sEwbQInsjU1BtifOjEMXuzvy8/mh2sgE4y7ixp5ihzT99ZxVNrOYbXHac0LE26BZqQ
	 CDSAE8Ak/F9AIweL+4PLXkKI80OiLotLrQWXEdHBtv1WWoo5JDPV0nnC+U0g8E6eAE
	 kUQy9LribXMePHEEkB3FlLKdE9p4QFhr5jM8nv80dQ9ZJW5lx2PuyftHJGMGvhq9G1
	 yl/Yax3vmf6U7MAaxruFfaqjoDdufjyTrqszjtXIbsHkWAx/FV87xBCq1ChdTckR3V
	 fVNP4KW9ZS8+Q==
Date: Thu, 29 Aug 2024 14:28:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Richard
 Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
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
 Taehee Yoo <ap420073@gmail.com>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v23 06/13] memory-provider: dmabuf devmem
 memory provider
Message-ID: <20240829142839.7f09715b@kernel.org>
In-Reply-To: <20240829060126.2792671-7-almasrymina@google.com>
References: <20240829060126.2792671-1-almasrymina@google.com>
	<20240829060126.2792671-7-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 06:01:19 +0000 Mina Almasry wrote:
> +	if (WARN_ON_ONCE(atomic_long_read(netmem_get_pp_ref_count_ref(netmem)) !=
> +		     1))

nit: temporary variable for this refcount, please

