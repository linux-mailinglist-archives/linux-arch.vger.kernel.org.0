Return-Path: <linux-arch+bounces-6829-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADC59651A8
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 23:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660F51C22263
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 21:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7560B18A6A4;
	Thu, 29 Aug 2024 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVTpviaR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20835156F5E;
	Thu, 29 Aug 2024 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966219; cv=none; b=Rue0tFrrturZiInxvBxkw93w7wz6MwwU79z5KSf8fNychcpCLq6Lv0k80vi+powHhE3hnV1S77Uf3aKJ25I1uZtPqs4DPL+dk/4FlT01e7qzn01nckp1E175RosaDKjLMJk0jjTL+Ynn+2vutBuqtXoV1W/8u9jc1QV2PXEl0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966219; c=relaxed/simple;
	bh=/F3zR/S6c2DjNLfD9s0Ftb1Yd+kEWjbMAqmAIctfcYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeUBgWpMxDrOTZadASkpri0Vxud8embq55bOqU7Lx0vKLFZv3sQZIp7hiV90PLgl3Xs+wHQ/qT+8bJ2OCGb9G0KNiCdapkivzzrWIF4PjE3f7b0edbyzI7mkitkCukBCDWfC7tgDJrzuW04IjSqDxX4oTRwpyT/imMBaFHBxmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVTpviaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C0BC4CEC1;
	Thu, 29 Aug 2024 21:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724966218;
	bh=/F3zR/S6c2DjNLfD9s0Ftb1Yd+kEWjbMAqmAIctfcYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KVTpviaRX5b5sG1JuaNzLtRm9KnkJJdrzPGGW+O8uspkX2SDPDuGdYT1AV2rdE3zf
	 TBiCMdFXECB8lFwEoWH+TL0/Vh0oW9q9OWoG2JfpRk2KUJ9zRBN/6Znu1baefyLLEZ
	 4/lqlAPd8aU+RT47EW5Y6XXxqeNyH+fVbwxRR9B1nP/7MehHybjrPfBZEDDfJ4yTyo
	 dpY+hvOTE3RxEdaAEbsTFkOU0XEZiogIieCZljccz2vDaGLvy0BiCENSj1CiPQwtFV
	 Z5kzLlVX2izGN4neWa8IlzLoD8tA8/n2gGHuk1lqNsXs4pplHaXGXSIi4QfqWsac+e
	 lwPxvPgy0WZvw==
Date: Thu, 29 Aug 2024 14:16:54 -0700
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
 Kaiyuan Zhang <kaiyuanz@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH net-next v23 03/13] netdev: support binding dma-buf to
 netdevice
Message-ID: <20240829141654.1e1b74f8@kernel.org>
In-Reply-To: <20240829060126.2792671-4-almasrymina@google.com>
References: <20240829060126.2792671-1-almasrymina@google.com>
	<20240829060126.2792671-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 06:01:16 +0000 Mina Almasry wrote:
> @@ -9376,6 +9376,9 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
>  	if (!dev->netdev_ops->ndo_bpf)
>  		return -EOPNOTSUPP;
>  
> +	if (dev_get_min_mp_channel_count(dev))

there's an extack inside *bpf, would be good to add a message

> +		return -EBUSY;
> +
>  	return dev->netdev_ops->ndo_bpf(dev, bpf);
>  }
>  EXPORT_SYMBOL_GPL(dev_xdp_propagate);
> @@ -9408,6 +9411,9 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
>  	struct netdev_bpf xdp;
>  	int err;
>  
> +	if (dev_get_min_mp_channel_count(dev))

ditto

