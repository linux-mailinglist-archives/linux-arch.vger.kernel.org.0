Return-Path: <linux-arch+bounces-7162-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01FE9726C5
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 03:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3E4285076
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 01:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F7813B2B8;
	Tue, 10 Sep 2024 01:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsjAGTQM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369A80631;
	Tue, 10 Sep 2024 01:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725933380; cv=none; b=j+GmlGUUR/Wtbu+1mnfVYRI+TfoZA9WsMalanRMD6yipFjZUW9b104u99ukZn6If6bMkQInZQ/4B4lm+zChkHry7v0iMKbtajEy43PqCkssepNvsIwnGNkbHBtc97xixJwSfrW5/RsU/ucIRClIRgv/HD6QBnHJ/WZOWyd8Ns6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725933380; c=relaxed/simple;
	bh=hQIohTpGoGCWnimJ1WTILi++IMB0fJOotB8xmPurEMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMBWHGyDo5n0FCzFJ4PGCr4W1F+xNXXtakeJIOHhNG3bhueEbx1WJbCamSYEN7NEOYcg6/AUbVSbswMtji1wS9tkS70WXZAR6apkOHWThd8h8Bf4yZsAPjQbXC8Z3qlfQycEIMI+HF+ALNTvkKjwYgApvDHbbnPmaqb2ASHFdpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsjAGTQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09B3C4CEC5;
	Tue, 10 Sep 2024 01:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725933379;
	bh=hQIohTpGoGCWnimJ1WTILi++IMB0fJOotB8xmPurEMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LsjAGTQMGnJ6P2MG1V7Cg14/mW7M47zCU3SUxtCsppTwztGealCF8izjpQT2zu61A
	 wYHXnyY4N0r09fOMnUWI5YC3b4HmKxm+Ay0HQTYrk+Dm1IEMe0T8CAGnDfTpmaTgdb
	 WBrDLGImIhSrlix8oxBiFCHVhhDVCkXVX3PGTjURUIgLMdPDjJ3b7BwdShJQ4BfDaj
	 GnnwTU0+HMb7C05k51WOPUbMUik7MLxyhB5Buwf1hXG0dLn9zUHLsMTQJsQ/D3cb/i
	 h+uqGxW9xZ5PAiQLKeH5dZLeHwdme2LgmmdAPBg0rfO8+OcOXh7k+PNEZcNV0ansmm
	 /T+2TYSXw2xIw==
Date: Mon, 9 Sep 2024 18:56:17 -0700
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
Subject: Re: [PATCH net-next v25 06/13] memory-provider: dmabuf devmem
 memory provider
Message-ID: <20240909185617.79b0d3fa@kernel.org>
In-Reply-To: <20240909054318.1809580-7-almasrymina@google.com>
References: <20240909054318.1809580-1-almasrymina@google.com>
	<20240909054318.1809580-7-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Sep 2024 05:43:11 +0000 Mina Almasry wrote:
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 5eccc40df92d..8a6e20be4b9d 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -8,6 +8,7 @@
>  #ifndef _NET_NETMEM_H
>  #define _NET_NETMEM_H
>  
> +#include <linux/mm.h>
>  #include <net/net_debug.h>

This should be in the previous patch, I think. page_address() etc.

> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 52659db2d765..c737200f4fac 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -11,6 +11,7 @@
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  
> +#include <net/netdev_rx_queue.h>
>  #include <net/page_pool/helpers.h>
>  #include <net/xdp.h>
>  
> @@ -24,8 +25,10 @@
>  
>  #include <trace/events/page_pool.h>
>  
> +#include "mp_dmabuf_devmem.h"
>  #include "netmem_priv.h"
>  #include "page_pool_priv.h"
> +#include "mp_dmabuf_devmem.h"

nit: duplicate include

With that:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
-- 
pw-bot: cr

