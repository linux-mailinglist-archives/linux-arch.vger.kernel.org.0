Return-Path: <linux-arch+bounces-7164-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA959726E9
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 04:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE142855CE
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 02:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D7E13CFAB;
	Tue, 10 Sep 2024 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtXDOkDr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB221804F;
	Tue, 10 Sep 2024 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725933939; cv=none; b=eU+jwSTOAX2Bi3xEU+zXvlk1dQAEerx3o9gRJofPtC9LRGjHjlmOOJATLwzi0RGW7FvgVk+OE2A/M4TFlm+fo5fHvFFaernAv8MqlF7MP01wTsv6fF/E9OseDxits+I+P9EGuBtbKNsl/JCabuD1fW/vnNEkJaJ5W3Hrgk/q8kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725933939; c=relaxed/simple;
	bh=dYb9IcUg68I7MWLN85WuKlqFZWT/n2b1zWgUXnGNwiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMY4A5DRcVRmzvOu/MdCT+IR0ZPNQ8Nff7NJCBZlknITAne361bstHgi1muZt6Sk0PW9ctnVES7I85TPh4fpNaMSTyyKjM9fwBHXUv9quove/GID9isI6GyrW6WJrXd23c/9AhhVIdslRf7r20/BKJtyDtQKPnu5kgAsVrNkiDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtXDOkDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B71C4CEC6;
	Tue, 10 Sep 2024 02:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725933938;
	bh=dYb9IcUg68I7MWLN85WuKlqFZWT/n2b1zWgUXnGNwiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dtXDOkDrpc7TH9tMpJARjQom+m7/Q5mrWmDooMGHgVG2J725H3Zh0S1kGxK0MUNeV
	 DCUFZld+P55IPiBxXO2iKAeDMYdIp74rQfnzFuKYm0DIXnrguAGoPtmxDH6zvfxtw0
	 XJwiS1IA2N7WeP7d6Skj1Qm1y5jm979/Cfupfy2KvA1vPwdEQ0J2GNst4f5JHlM37w
	 ePESO8mp4tj9LDqAcWvJs8XizjEdrs7fl2chB/wDM1OTrSSxGxPFzZdH1/oNMXr78f
	 Yd0SZCptMXgo3Nq/CtDC1gi1eM7Es1G0/dObRwE1Q8bNgBDwbDNGbUNbFPi1Wp7Zhs
	 TrTCAN996cwKQ==
Date: Mon, 9 Sep 2024 19:05:35 -0700
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
 Taehee Yoo <ap420073@gmail.com>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v25 10/13] net: add SO_DEVMEM_DONTNEED
 setsockopt to release RX frags
Message-ID: <20240909190535.01611ae1@kernel.org>
In-Reply-To: <20240909054318.1809580-11-almasrymina@google.com>
References: <20240909054318.1809580-1-almasrymina@google.com>
	<20240909054318.1809580-11-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Sep 2024 05:43:15 +0000 Mina Almasry wrote:
> --- a/include/uapi/linux/uio.h
> +++ b/include/uapi/linux/uio.h
> @@ -33,6 +33,10 @@ struct dmabuf_cmsg {
>  				 */
>  };
>  
> +struct dmabuf_token {
> +	__u32 token_start;
> +	__u32 token_count;
> +};
>  /*

nit: missing new line

