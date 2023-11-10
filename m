Return-Path: <linux-arch+bounces-122-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8167E8658
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 00:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F355D280F0E
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 23:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4AC3D3B8;
	Fri, 10 Nov 2023 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVuzaAhc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E91B299;
	Fri, 10 Nov 2023 23:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D168C433C8;
	Fri, 10 Nov 2023 23:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699658191;
	bh=lp6MUfcnlWg0MaE5+BDw4kORckYukPsXO/JArSSKHJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iVuzaAhclFKl7LeZxL1NI8Ry5+2sm28Vs5NzEPoZdxbe3go12IaDJWLkU1qciBkSM
	 whBYgKfAUNPBSEhJE4QJ7XezrNh7jGDkV5xIkVM0WEaslaTziGDnt7EcXARHStWAV+
	 X6UvXOaaioy3gynvYEIjRXId9KFFQwsnC44K5pRX/XKXmzuJmcbveiUyk5oASlRWGl
	 kJorEGqFqwRuYuDjtmNfv3ReaToE+lgcd+/1MwmRx/qDbHlD4itRI3rUiLvAhgRsE6
	 /3K9PErcilfL1+yDjqcvhNbjPdvssNyP6Hk78Zm7WjFtgVSVlPYeMoU0i4fqtJVGeA
	 dQ6M9ylbMVj5Q==
Date: Fri, 10 Nov 2023 15:16:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David Ahern
 <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 "Christian =?UTF-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Shakeel Butt
 <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [RFC PATCH v3 03/12] net: netdev netlink api to bind dma-buf to
 a net device
Message-ID: <20231110151629.047b1389@kernel.org>
In-Reply-To: <20231106024413.2801438-4-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	<20231106024413.2801438-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Nov 2023 18:44:02 -0800 Mina Almasry wrote:
> +      -
> +        name: queues
> +        doc: receive queues to bind the dma-buf to.
> +        type: u32
> +        multi-attr: true

I think that you should throw in the queue type.
I know you made the op imply RX:

> +    -
> +      name: bind-rx

but if we decide to create a separate "type" for some magic 
queue type one day we'll have to ponder how to extend this API

IMHO queue should be identified by a <type, id> tuple, always.

