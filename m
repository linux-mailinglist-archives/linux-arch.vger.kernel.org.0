Return-Path: <linux-arch+bounces-15702-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 944B3D00E10
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 04:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78971305DD9F
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 03:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E57E285073;
	Thu,  8 Jan 2026 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqrt1PBx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D2D281503;
	Thu,  8 Jan 2026 03:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843016; cv=none; b=EmlIoVY5nmt5d/idjV10J7QGsdyaAFqcAm7gmNsXGT6lWZwxKwVS5MEtZoMpZdPxFEPvFTJsqxoCXXVB3awdH9/enkxFuMiiJiAfzPmpf6O9rZ4VLesMoyWP7Z/VNHwE5KFRFWOzavR/uODizZtrUlXO4emfCfmH0qhFPb00apw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843016; c=relaxed/simple;
	bh=DSALUKMrHcObpEc4DihJ+nhGxXcRhoYI8ee1KKX83Es=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdTX5LdCzWppp9J8+XFQkP+rx4KWtniB2S8q7t0MxabEtipNWtMwdNxcX9Zu7biRaPuJ+SBBk2T3BO5ocmlbitwKUHhR2bAgA2xyJdOUddBCwZVpvfVG9a30pIXeCCyPvNpZzEOnG6dne5Z+qXGSYsV/Bj+CMtZRbxzAasqN3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dqrt1PBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABC6C116C6;
	Thu,  8 Jan 2026 03:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767843015;
	bh=DSALUKMrHcObpEc4DihJ+nhGxXcRhoYI8ee1KKX83Es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dqrt1PBxIzl3uvgfegE/S6bgdgUvs+Eh8XSIZ9T8tXXi2g2lZSSasduqJSWsvnRKv
	 kbblKK/vPEhq9Iu8ezZ3AQdenRqg0fwhJYKbqftem7XwTZ+sQ3oJxyJmxhQKW2kseD
	 4EbdcGroVQBWaPBSfmAXQ0g8nJc7aPyfbZZIgqraRxblKK20SJCTrxp5Ndllzxu5cC
	 jh/vvn7zZyvnYWcfzej38sHojL7Dd3LE+KYvaKQ6b0EEZvGh8K2vmwHPQY/v1E0gcB
	 gp+YBgVA3CXw+7fOK9ZKn893/1uVSBVlb2IThNIPkTeGYQq9Sf7tBi5pobHY/7/+GA
	 RxjEJRVDc4qDQ==
Date: Wed, 7 Jan 2026 19:30:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, David Ahern
 <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan
 <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Mina Almasry
 <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, Stanislav
 Fomichev <sdf@fomichev.me>, asml.silence@gmail.com, matttbe@kernel.org,
 skhawaja@google.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 0/5] net: devmem: improve cpu cost of RX
 token management
Message-ID: <20260107193013.0984ab97@kernel.org>
In-Reply-To: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
References: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 07 Jan 2026 16:57:34 -0800 Bobby Eshleman wrote:
> This series improves the CPU cost of RX token management by adding an
> attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> binding to avoid the xarray allocator and instead use a per-binding niov
> array and a uref field in niov.

net/ipv4/tcp.c:2600:41: error: implicit declaration of function =E2=80=98ne=
t_devmem_dmabuf_binding_get=E2=80=99; did you mean =E2=80=98net_devmem_dmab=
uf_binding_put=E2=80=99? [-Wimplicit-function-declaration]
 2600 |                                         net_devmem_dmabuf_binding_g=
et(binding);
      |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
      |                                         net_devmem_dmabuf_binding_p=
ut
--=20
pw-bot: cr

