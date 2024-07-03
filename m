Return-Path: <linux-arch+bounces-5230-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59014924C85
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 02:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058F91F2307D
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 00:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F36D1DA30C;
	Wed,  3 Jul 2024 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEan8Rfk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D216F624;
	Wed,  3 Jul 2024 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964865; cv=none; b=UiAAOGem1PssVbbmSjN9GIIh+e3d2d+Vl8rVWJUSK+NwiNBV4QWiFjaKpx1EnbuauRtogJT83DJdwCMKkLkQZH3cnm9Z1qpOriQMVvetNK3QCjA411sU8OjlVkyQHA6JInYkhtMELGbEeCF+S549vcZyaSdSms3SI16Rs9Bop2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964865; c=relaxed/simple;
	bh=XKl/c87Kbh0kGQurl6iORGiYsqlKqoMj55PIg6Hhs+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSLloRbCyi0trTZ46HE/Apxiz7yo8CnoL7mUQ36GrAQ5wvdLtfHmiiIfR+afiTOjZDx5GAogRvcC3h9HveA+gYZ+h41RnrvqJKYEm7WjCw557tyveAy7d1dZu30BF2bVI7zS3xRgcJH6XSPXWzQ0OD81GhCrMfcCxaboWh+JPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEan8Rfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9DAC116B1;
	Wed,  3 Jul 2024 00:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964864;
	bh=XKl/c87Kbh0kGQurl6iORGiYsqlKqoMj55PIg6Hhs+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YEan8RfkgilOWFyp2YBV84OjOIwJGzT/QUvC9cDYBcMEDk3TkFMsLKBF9uaI3k5xL
	 VuRhqA8zfpuwTfTremn1Lfy49x1I4pn78dNiE5Uq7TWWa07iyaYQ8YvBR1dEKp7iq9
	 R8yV6YrR+Bx6zfN/DLN1ph361m7q21kuqTq2IWDYRcEx+PK8fzGBhlBa+m2Iuhwjpm
	 mwfsiW4c8qZKDNcJ5vH8oJbtiPsmoDQqn1zNuPfURkcMB754p/Mq6D5tJ259L8hyQt
	 sCs/eeFQOdzPHAvWPBmULTvr0ubVHTK0ab9EbJ4JPA4n4p+tQfgDYM78M/M/ETPmmp
	 88qK4oQsV+OkQ==
Date: Tue, 2 Jul 2024 17:01:00 -0700
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
 <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
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
 <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v15 01/14] netdev: add
 netdev_rx_queue_restart()
Message-ID: <20240702170100.66783656@kernel.org>
In-Reply-To: <20240628003253.1694510-2-almasrymina@google.com>
References: <20240628003253.1694510-1-almasrymina@google.com>
	<20240628003253.1694510-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 00:32:38 +0000 Mina Almasry wrote:
> Add netdev_rx_queue_restart() function to netdev_rx_queue.h
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

