Return-Path: <linux-arch+bounces-6974-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1854D96AA5E
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A023B243C6
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 21:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9871922C7;
	Tue,  3 Sep 2024 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4goTdAB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011671EBFFF;
	Tue,  3 Sep 2024 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399616; cv=none; b=pnq/erd7W7DhDO/gIkWF5LaxupWGgICQF+a4+6e3HJWNYSI5+repj2eUQTsCom3BhkOTs7cPZ6p2PAdUm0ilw16wjNp/Nt5O333k8OjalmtwQ0jHLPbjrM6REB7y6yWDRafpGo7zEGhAB23eX2hi/IO/pBhojytizin4t0MAw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399616; c=relaxed/simple;
	bh=oaZPjF2Hwc2UCWScGNmiQSzXQJql29ev4HaTxsSINYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNiq848We7MieN0YGETzK0GVCOEGb4lUd8Wy11sykZMUIr57pJNtZswBhZsdN3YmvjslR0Ee3UzcjauOltUGqZPEf6WSBexrTItlq1TVk9sfnfNvVqH3q2CNk4hLRZBiwb+CAaUwmPulWfMfhT6FaMHvhP0FWVMnF4t2VvR18v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4goTdAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1E2C4CEC4;
	Tue,  3 Sep 2024 21:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725399615;
	bh=oaZPjF2Hwc2UCWScGNmiQSzXQJql29ev4HaTxsSINYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A4goTdABFpGLC7mNQ/iVNNtHVfhNY/snxGEsDUa98eLJzqulK3ihS0CVSipU96DK2
	 3agJPo5pYijI12pg058sMg5p8hCcNXCEauwckXRY7h4zVH9Jd9r/OmjcWMFSD2I4Fb
	 vhOC8d29Lh3Yq20wLvewdmOt6DL0VbQUXOC2W9xf3KIahEOFazunBtOoli4RkVFfqO
	 TbsqMbuOmAvBRN0QJFCfV4KByNO/TvecjblgEuNrC5dms7rLuD7KEwUESkL47WEeSi
	 fiZs89Uax1pO4oUVtn/yjeMvhWyk9fie28eRXWUDHTlk0Xr9w4DhQPgSP9ixXxLwcd
	 a65KUuwzWJNQQ==
Date: Tue, 3 Sep 2024 14:40:11 -0700
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
Subject: Re: [PATCH net-next v24 08/13] net: add support for skbs with
 unreadable frags
Message-ID: <20240903144011.3e7135f9@kernel.org>
In-Reply-To: <20240831004313.3713467-9-almasrymina@google.com>
References: <20240831004313.3713467-1-almasrymina@google.com>
	<20240831004313.3713467-9-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Aug 2024 00:43:08 +0000 Mina Almasry wrote:
>  static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
>  {
> -	return likely(!TCP_SKB_CB(skb)->eor);
> +	return likely(!TCP_SKB_CB(skb)->eor && skb_frags_readable(skb));

Do you remember why this is here? Both for Rx and Tx what should matter
is whether the "readability" matches, right? We can merge two unreadable
messages.

