Return-Path: <linux-arch+bounces-18-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0418F7E3280
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 02:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344F21C2085A
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 01:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB3A17C2;
	Tue,  7 Nov 2023 01:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4YbRkhj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5E415A4;
	Tue,  7 Nov 2023 01:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147D2C433C8;
	Tue,  7 Nov 2023 01:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699319347;
	bh=71l20GkBOFUWOSbSR+FiTHlfmSsCI73pQkIYJSjwA1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U4YbRkhjKovNT9nbOQUSJL0HgDh16yoV1zgSGNMyDkFbe/4JG87BU2EEup/QMpgwc
	 kbRXf6SG9j3O3TNdKSYqN5dxD5+C+9ZXdxrUXd3X6cIg47/LbwJBtzrWnHEhJqhsXU
	 PjGxXa40525TjLBDK9dUhHpj3nFHe+7u2ldDn6wikhJZ3G8WoygqNBBAQGvQr7b4ik
	 /P0990SE8EkzyRrGHxTSlJPvIh60Lduh5XfLBwWNeDIqYHIJa6h7F7kVNeX005uRAK
	 u7K7FyCdA2UQVa7D98G+Tj2nKc9lZw8Pom2TlxYgWcaNE61PZV60iOgukpBP82xD2Q
	 ENZ1ONDIE1q4g==
Message-ID: <c9a08db6-7418-4684-a5bf-6e9ac0655795@kernel.org>
Date: Mon, 6 Nov 2023 18:09:05 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable
 frags
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-10-almasrymina@google.com>
 <ZUk03DhWxV-bOFJL@google.com>
 <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org>
 <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com>
 <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <ZUlvzm24SA3YjirV@google.com>
 <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
 <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
 <CAHS8izNxKHhW5uCqmfau6n3c18=hE3RXzA+ng5LEGiKj12nGcg@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAHS8izNxKHhW5uCqmfau6n3c18=hE3RXzA+ng5LEGiKj12nGcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/23 5:20 PM, Mina Almasry wrote:
> The user is free to modify or delete flow steering rules outside of the
> lifetime of the socket. Technically it's possible for the user to
> reconfigure flow steering while the socket is simultaneously receiving,
> and the result will be packets switching from devmem to non-devmem.

generically, from one page pool to another (ie., devmem piece of that
statement is not relevant).

