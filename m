Return-Path: <linux-arch+bounces-5351-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D32692D536
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 17:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310C01F216ED
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7881946BA;
	Wed, 10 Jul 2024 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7pET244"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF67910A09;
	Wed, 10 Jul 2024 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626238; cv=none; b=AXQGLOvgw98c5ogqQk+6ARkCT81lhtRfV9bXV6MByAHnDGHC8j/1bi11D5MlDeVk0QdSxM1bl+9MgCSyTAeu0bGC9F38zFkLSOgyf6iVBN5dBIdI6pKtPYWnaRHbnglXK0wkegurg9I9G4NdccrQonwksLMQKNVRF60MIjmNYYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626238; c=relaxed/simple;
	bh=2VjxCw7/pEHU/0bidI2feuCnA4pDBlOvPp0FjhiWL90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/Ezx4GXrmGnUguz6ZdtVutFFiD5k/YWc5CqL9dpXkC7K8GTaaHBQ+A/FS+idmgy16tLQB9/GHm83jQRXio2pnMPbSQTP68wpofkyDTYSyu4ReQh3ovPMqD0ZiJt9MyWcU47ESpTMuPufS7EWBzWZfeeQbOsmjfAnB5PGcfbkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7pET244; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA029C32781;
	Wed, 10 Jul 2024 15:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720626237;
	bh=2VjxCw7/pEHU/0bidI2feuCnA4pDBlOvPp0FjhiWL90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k7pET244b2dzX8onmYuhgmH3WJXcAwvN3WXPP4XeMUeQyE8FDEUm49zqkn4eoykSd
	 6WcJPG77ORaxSNqspszVTBD3dwOgPPDj7eONQkHJYs9xZ2Pvscclw8yOyT9UMsMedU
	 0UxZQt5Bpdl8rJy0rEG4jedX/gaLPZITnkl2V/u8Jp5ksFSyaL5DzIz1PEqPZUGCRB
	 JFHJGY6DnzgIbC/L16cXcvDlLIYBYJqvMwFQedBXtKZ0UjNypbaemqd1K156K2aA35
	 3D5titODmrtCxIEekIiE/sJCNG6z8VwkhqJwIydyJHBNwtkwHJAKe5MGzWfKRqJuPr
	 YWiA3J10YxxIg==
Date: Wed, 10 Jul 2024 08:43:54 -0700
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
 <pkaligineedi@google.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net-next v16 02/13] net: netdev netlink api to bind
 dma-buf to a net device
Message-ID: <20240710084354.279873ca@kernel.org>
In-Reply-To: <20240710001749.1388631-3-almasrymina@google.com>
References: <20240710001749.1388631-1-almasrymina@google.com>
	<20240710001749.1388631-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 00:17:35 +0000 Mina Almasry wrote:
> API takes the dma-buf fd as input, and binds it to the netdevice. The
> user can specify the rx queues to bind the dma-buf to.
> 
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

