Return-Path: <linux-arch+bounces-6823-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C17965074
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 22:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C121F257FC
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 20:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D351B8EAE;
	Thu, 29 Aug 2024 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pgh05sZH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44DA1311B5;
	Thu, 29 Aug 2024 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961962; cv=none; b=KVop9deUsUViAhlRJNOaVUEaNx8QPe29a8lJ1snTwbpoBjbedx9U35KGVRBh3sErOD0gdQvSO02qpQbY1TD4WqYdwm2G2OJ1RDg/wjR3P0F6Upz41plX9TcHGqFldipzPdyoSNa3QGBZahFcqnmDr1hobWETA9rWzod12XhDKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961962; c=relaxed/simple;
	bh=jjY3PbslKhfXvlshQ539eQ+z8Cll4clbilq8gY8N3I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di16iONw5wb098h76VpcyGjwdmoQ4t1bF+pbjW7d34orEsTc2dNwT0O1MCZZ4OR9XAg0rBOXv8u82Ab0iCSnuxgRzkjqitmnA8wW5WF7wh16Q9hXTAyk0T5G2KBUOVkvSYuuPmaRKoWIrikqgTAyc4KdmAQTIFrS/1tZHUlgiSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pgh05sZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22A9C4CEC1;
	Thu, 29 Aug 2024 20:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724961962;
	bh=jjY3PbslKhfXvlshQ539eQ+z8Cll4clbilq8gY8N3I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pgh05sZHH1ibogv5993BrLByQD2Hc0qfcAv2NJeBS3Mftf84AbXP9FW90wTGti+Tf
	 ru32QNYkthl3hI0pSdGfQtUdsHeU1uWr6boa5WmBadB/vr4S5eY2mzVWaDVz/GH8Ks
	 JvpRPHZu38SQAmQmVTfol3Si3hAjwgijOkJkBnM/xm9lUV+WW1lQ07x1jXV6BdovV9
	 ZQLhh2jTkOWKq8dmJVXCjaUdIP0R1ph0q54o9t2g7Pi9fTt4xeg0jKN26ZYxsETwJC
	 pkVrvKZrhYyJUI3CTFCDMW/PZRtCtcwBFmOQJTvVO7vMftTj08uaE4xrP321ZNlR4R
	 cuA4wT2MNl2xw==
Date: Thu, 29 Aug 2024 21:05:48 +0100
From: Simon Horman <horms@kernel.org>
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
	Donald Hunter <donald.hunter@gmail.com>,
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
	Arnd Bergmann <arnd@arndb.de>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH net-next v23 03/13] netdev: support binding dma-buf to
 netdevice
Message-ID: <20240829200548.GX1368797@kernel.org>
References: <20240829060126.2792671-1-almasrymina@google.com>
 <20240829060126.2792671-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829060126.2792671-4-almasrymina@google.com>

On Thu, Aug 29, 2024 at 06:01:16AM +0000, Mina Almasry wrote:

...

> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index 6b7fe6035067..8b87801e8d1c 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -8,6 +8,7 @@
>  
>  #include "netdev-genl-gen.h"
>  
> +#include <linux/list.h>
>  #include <uapi/linux/netdev.h>

Hi Mina,

Strangely, when tools/net/ynl/ynl-regen.sh -f runs, it places
the includes in the opposite order.

I raise this as it may lead to churn later.

...

> diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
> index 67c34005750c..01ef29ace149 100644
> --- a/net/core/netdev-genl-gen.h
> +++ b/net/core/netdev-genl-gen.h
> @@ -9,6 +9,7 @@
>  #include <net/netlink.h>
>  #include <net/genetlink.h>
>  
> +#include <linux/list.h>
>  #include <uapi/linux/netdev.h>

Ditto.

...

