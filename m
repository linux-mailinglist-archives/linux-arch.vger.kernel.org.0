Return-Path: <linux-arch+bounces-6238-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEA1953E64
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 02:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2261286880
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 00:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235198C1E;
	Fri, 16 Aug 2024 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/yX59CT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C137F383;
	Fri, 16 Aug 2024 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769429; cv=none; b=XYgVCdybNxT/9ucGj0+r7xHs4oXNIE5HXfXSCuDpDwg3w6f8RQRtlqdc1IkoIWvy7EKsB/+x4gU6W0OPWy+Qo7d8c5U1/S9JkkcyMpSHax+fR/UA66cruHly3gcBhvWVeeaLGlfnac5YmrYPVaBfArDcQQi8C06eiz19hjdNtNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769429; c=relaxed/simple;
	bh=qD+gWLDqKaHuiOr76pTdf8osGmw137rkKAK9HLs+pZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSoJ9csomo8wGOFjZpXvTjG/UOer2nnzFq4c3esW/xBWT5BPwR43vaRNBZ9oePZblEbWlcmPsI7g2DUlaf3dNzcxzzHQqWX/UPiOOzBtm5jtnxfXwfodQELuCxyjHBUEYUJ8z2TtWcHkkyCfha3KysTMXkpy112In/v5dFxGIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/yX59CT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD5FC32786;
	Fri, 16 Aug 2024 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723769428;
	bh=qD+gWLDqKaHuiOr76pTdf8osGmw137rkKAK9HLs+pZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q/yX59CTbrhndkfDiANrULjY+4RS4tIYA8vdUHOs81mKmKqU3mNdo6QRNMA69qPk+
	 aa3D+D+NqeNBD4fvkJsk84cBp/lxjlCjRtNq+moCqUIqeESyH3pgIUMOsAGWFST5pR
	 /JYsbFYK7HAYmgzHTadiwuf+aBp6oCj8CTORCdWUuveeugfHiJ41Be8OlhkFV5tItG
	 3rOQMeK+jH82QItDhKEmWdvuQKvKc1n+2xUpQzamlfASf4dfWms2gBSAyIGLoJm8KN
	 s3IFrvCvvtAIRpumD3vuva00vpJjiZvhhUi8aKJRcHDiKt82lnzYB5uLD9UCKG+J+m
	 ygrT2UWki5oyg==
Date: Thu, 15 Aug 2024 17:50:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
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
 de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, Kaiyuan
 Zhang <kaiyuanz@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH net-next v19 03/13] netdev: support binding dma-buf to
 netdevice
Message-ID: <20240815175024.0a87b1ca@kernel.org>
In-Reply-To: <20240813211317.3381180-4-almasrymina@google.com>
References: <20240813211317.3381180-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 21:13:05 +0000 Mina Almasry wrote:
> +		if (NL_REQ_ATTR_CHECK(info->extack, attr, tb,
> +				      NETDEV_A_QUEUE_ID)) {
> +			err = -EINVAL;
> +			goto err_unlock;
> +		}
> +
> +		if (NL_REQ_ATTR_CHECK(info->extack, attr, tb,
> +				      NETDEV_A_QUEUE_TYPE)) {
> +			err = -EINVAL;
> +			goto err_unlock;
> +		}
> +
> +		if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) !=
> +		    NETDEV_QUEUE_TYPE_RX) {
> +			err = -EINVAL;
> +			goto err_unlock;
> +		}

nit: you can || these three into as single if statement

