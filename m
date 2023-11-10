Return-Path: <linux-arch+bounces-120-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8427E864C
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 00:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309E7281149
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 23:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E6F3D398;
	Fri, 10 Nov 2023 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKGnaQ8a"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E23A278;
	Fri, 10 Nov 2023 23:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BE0C433C7;
	Fri, 10 Nov 2023 23:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699658174;
	bh=fIaDoeAJ5wEfd3OqiFmAviiP1M+nZrBz6caAN+IfwHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uKGnaQ8aeJx2XbhW1g+57sxckv/co5/lbVNdOgEwSz1N4reK/MBR/a2xSiC3RWOqB
	 JUf8rwg+LznxWD/D05rUgWqp79yZ5J24OYnBeNQ80xF1NgW8XnRrZ49vpYgv0B5fhn
	 YPwumFdi6/7Yx+B6iaK9vYj/3KWLgB4Yrui79+OAZxGfS6HTp6VojG8O1lUksc4NUE
	 B+lBm+9udQDqEM5gJ2Kc4WhGDwrZ+sVjwJ3+Jdvi5wAnmHXha2L0ZRVfLgR5Mt6/F7
	 NjlU/YhswwRu9H6tlY2W8scb81qY1j0UQ6J8URn3XvrJgCr2QAdIjXF11rw+yvn/B8
	 E4z+bIfKpc6Ww==
Date: Fri, 10 Nov 2023 15:16:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Stanislav Fomichev 
 <sdf@google.com>, Mina Almasry <almasrymina@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd
 Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Shakeel Butt
 <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn
 <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
Message-ID: <20231110151612.3dcca11d@kernel.org>
In-Reply-To: <3a1b5412bee202affc6a7cc74cd939e182b9a18e.camel@redhat.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	<20231106024413.2801438-11-almasrymina@google.com>
	<ZUk0FGuJ28s1d9OX@google.com>
	<CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
	<CAF=yD-+MFpO5Hdqn+Q9X54SBpgcBeJvKTRD53X2oM4s8uVqnAQ@mail.gmail.com>
	<ZUlp8XutSAScKs_0@google.com>
	<CAF=yD-JZ88j+44MYgX-=oYJngz4Z0zw6Y0V3nHXisZJtNu7q6A@mail.gmail.com>
	<3a1b5412bee202affc6a7cc74cd939e182b9a18e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 09 Nov 2023 12:05:37 +0100 Paolo Abeni wrote:
> > I suppose we just disagree on the elegance of the API.
> 
> FWIW, I think sockopt +cmsg is the right API.

FWIW it's fine by me as well.

