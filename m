Return-Path: <linux-arch+bounces-4860-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB0905F90
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2024 02:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70992B225C7
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2024 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0902399;
	Thu, 13 Jun 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz/ZQ4SN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA6137C;
	Thu, 13 Jun 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718237432; cv=none; b=hrlwPFeAog/B8XYNVTRfZz4tNgZJlsJ75L0cRtlORlEDV5Rrno6WJ1MvVSE0UtCzWFrAWLqgsrTN6pSnrlmQ4TzKQqi77eqNQ5AF+u2Uvpp8IxPE3DJWepbaOy+Y4swkMSlse1LkWq9L9TOITwXuCOA/IhuuGSr+sW4TTB/4NKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718237432; c=relaxed/simple;
	bh=ALaMOklo/D6m9out9qebU875GAFWtP61hk1J63pvt/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGTfOfycW+8XJWjm6WtyCQMTCZ4ViI1AeILaW5e40PN+BZ96FqKqUpC9aw1KjwrJsix9l9B0XgI4Qwx4axQbraEL7z8ObmIH7N4tG9gJLSvHgYp8PzL+5tF4RnQausEAeq/Fbh/WsSKoqY/0+2bqzmwXp0V1tPYK4Hjk4G16fzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz/ZQ4SN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BC8C116B1;
	Thu, 13 Jun 2024 00:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718237431;
	bh=ALaMOklo/D6m9out9qebU875GAFWtP61hk1J63pvt/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mz/ZQ4SNRhD4Slftyf1RGHhLam/Qf7W3PwDTBqymj8MrjJ2zFfcEBpzzqoIp7aIRE
	 +HNQhNVE1+IOeDAWgqZssDT0yMjs5KujxGNYD5/v0d4xLqGdW6Z4IfirrVTI0gfG77
	 pMXEtZ7kL2cG4kkEGdlkXN+sdZwbMnbryjY9PGB3jmEupZmxCvx/3ljnSDJVkMYjc3
	 aerFM5mLp0PJV3xP/U6IojVO32XHdmwSgJHAiTk7a4PvwYlAlAf0U2KtXvJacugqV3
	 /CEmWSpj8No1QubiV6AWTL6traVV8XO5JJaskmf2fawRbrkUX9ZG4c4dRG9FtdOikt
	 K1w3nC+pECkGA==
Date: Wed, 12 Jun 2024 17:10:29 -0700
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
 <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, "Christian
 =?UTF-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, linux-mm@kvack.org, Matthew Wilcox
 <willy@infradead.org>
Subject: Re: [PATCH net-next v11 05/13] page_pool: convert to use netmem
Message-ID: <20240612171029.71adc273@kernel.org>
In-Reply-To: <20240607005127.3078656-6-almasrymina@google.com>
References: <20240607005127.3078656-1-almasrymina@google.com>
	<20240607005127.3078656-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 00:51:15 +0000 Mina Almasry wrote:
> Abstrace the memory type from the page_pool so we can later add support
> for new memory types. Convert the page_pool to use the new netmem type
> abstraction, rather than use struct page directly.
> 
> As of this patch the netmem type is a no-op abstraction: it's always a
> struct page underneath. All the page pool internals are converted to
> use struct netmem instead of struct page, and the page pool now exports
> 2 APIs:
> 
> 1. The existing struct page API.
> 2. The new struct netmem API.
> 
> Keeping the existing API is transitional; we do not want to refactor all
> the current drivers using the page pool at once.
> 
> The netmem abstraction is currently a no-op. The page_pool uses
> page_to_netmem() to convert allocated pages to netmem, and uses
> netmem_to_page() to convert the netmem back to pages to pass to mm APIs,
> 
> Follow up patches to this series add non-paged netmem support to the
> page_pool. This change is factored out on its own to limit the code
> churn to this 1 patch, for ease of code review.

Sorry for lack of meaningful review, busy times, in the meantime:

drivers/net/ethernet/renesas/ravb_main.c:306:16: error: incompatible integer to pointer conversion assigning to 'struct page *' from 'netmem_ref' (aka 'unsigned long') [-Wint-conversion]
  306 |         rx_buff->page = page_pool_alloc(priv->rx_pool[q], &rx_buff->offset,
      |                       ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  307 |                                         &size, gfp_mask);
      |                                         ~~~~~~~~~~~~~~~~
-- 
pw-bot: cr

