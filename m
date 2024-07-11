Return-Path: <linux-arch+bounces-5367-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C892DE08
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2024 03:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F94E1C21817
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2024 01:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D3C29A2;
	Thu, 11 Jul 2024 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZ+GOJjB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6B5101E4;
	Thu, 11 Jul 2024 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720661762; cv=none; b=B9R9OXe9g0dV02ttm6LG4dfmO4GAjo4YY16sf86dogVBnyf1ivL4xAQJlXHlUDI+TebYFhLNoAc4yCNXZPlClrx3QSjq8IPNgw1uGsepOqm2ZygYcK6eakn1yFiDGu3lONYVuPPobT8BczLLpiucSK0/NEUp/nO7cK9ADPsfnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720661762; c=relaxed/simple;
	bh=Hqr9mmbkEJ+SKI+sb4EdVGkA9dVoZOX7yW+I50QePp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJa1AAbj7Bnf0520iErKBWewyxfK6lpnv+bVKKNm9N2jbuO89Pi9EtAmU/n4H6VHXkA3elDXpKHmYJ9Ohy4dWsG+D9MF717ySfMLnsWG4TP05XzquezfOK5MWAi7uAjjCyw7NNIEa/Vw/MLeh4ajH4ZRxWQws/YxzZczoDWt5pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZ+GOJjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F41FC32781;
	Thu, 11 Jul 2024 01:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720661762;
	bh=Hqr9mmbkEJ+SKI+sb4EdVGkA9dVoZOX7yW+I50QePp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rZ+GOJjB93xoU6UJ2PdTrOFqj6GaZIkE9XcK6GAgChSeAygix+EySdQXQ0WR5Kz+H
	 WCjNqakxEQLT6/Af+MwzHg1x4tCzR5hPjqsoOlVcL/1rcSJr6S9AeA4ZN0I0HittDJ
	 bUGA3V+8b3i7ULWXkwvf6D//5Kzlg+/oUCcYIVgmnTeKxMRKg41EwjPD3SBCwBSYov
	 ZTEFlT3e4YHM2jDotLjffFrrNk34zKJndcvFAfee3/1+SOhBbUPU7HaStIvkVPR6dW
	 dYaO9ltHOHaCeXYK60ww88Q9AHqSlwIEYVIfGHWIGsPp/F1t2GYOu4fF58ce+oWeZp
	 iBrKtAm718JUA==
Date: Wed, 10 Jul 2024 18:35:59 -0700
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
 <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v16 13/13] netdev: add dmabuf introspection
Message-ID: <20240710183559.64c9071f@kernel.org>
In-Reply-To: <20240710001749.1388631-14-almasrymina@google.com>
References: <20240710001749.1388631-1-almasrymina@google.com>
	<20240710001749.1388631-14-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 00:17:46 +0000 Mina Almasry wrote:
> Add dmabuf information to page_pool stats:
> 
> $ ./cli.py --spec ../netlink/specs/netdev.yaml --dump page-pool-get

Aha, thanks!

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

