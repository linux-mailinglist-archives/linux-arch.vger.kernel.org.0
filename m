Return-Path: <linux-arch+bounces-15706-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D862CD03750
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 15:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6024F302AFAB
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9B4500951;
	Thu,  8 Jan 2026 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg26WUex"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD09500948;
	Thu,  8 Jan 2026 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883322; cv=none; b=i5c3bdEY7CqCKLE0mKGtajMf1qsObqnceccpwlQCq51crW4Kt6zWRM6n72F9nwfO7Ew42qyX86+xRh05sZTEuO0ifG/Tik7kXfpNMwpk7ifyCSQS8SAP5oBWSL21bF61H19jxBdejfpK26gWQVsm9h2in5BnexO+BcWUY52SjhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883322; c=relaxed/simple;
	bh=OWGioFVBXgEJf9d2gvMx12tRfLFIpFIFoaLk5P0MMyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQYTB1sog4vh48iVUIV2S9114pWPZUbqC35+Z/yU90xRWW0mAVzzLIWtXUQkEhhUONSK691XCPWi+OV6aSs5R/dCPA6Nbn9szC9UW96OVN3hxaC27z2gmD92gJ3WOeVY7SLq4p233UsFLRR/lii2pRpmKeIJwMK+K2oOQm8Enyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg26WUex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F840C116C6;
	Thu,  8 Jan 2026 14:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767883322;
	bh=OWGioFVBXgEJf9d2gvMx12tRfLFIpFIFoaLk5P0MMyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pg26WUexxhpNMxI3AMNXPk3Ko/k9+IyTLkEb433lFpmJ0wUb3c2bMsSQ/0xt9MMD4
	 QLFj0RZs31o28/YwzrGvp2hl3jd7T6gV1lth+CXaOLBfAxM118Zp5j2xqtsh8NhG/Z
	 ATLatVCYDG+wB87FsRByb3Lyp3XQzkQT9noUiSj1Yfbq1y20UUHSJZWIH1p1ESl+R5
	 UO4dJzr8NHSqC2EuESdEElR6NX03LKh2j2RQuNQ6gh485nBMcEojenPnFDKbR7x3Fs
	 fdlhe26cPRVGn8JKJz+IeGxdze+Ur8KX/rjYmPXlJN52+2lNaDA46tYvjBmGnDvTFM
	 t4gYXLzhxFT9g==
Date: Thu, 8 Jan 2026 06:42:00 -0800
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
Message-ID: <20260108064200.7faf9735@kernel.org>
In-Reply-To: <aV80jCHD9PGaOr87@devvm11784.nha0.facebook.com>
References: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
	<20260107193013.0984ab97@kernel.org>
	<aV80jCHD9PGaOr87@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Jan 2026 20:37:32 -0800 Bobby Eshleman wrote:
> On Wed, Jan 07, 2026 at 07:30:13PM -0800, Jakub Kicinski wrote:
> > On Wed, 07 Jan 2026 16:57:34 -0800 Bobby Eshleman wrote: =20
> > > This series improves the CPU cost of RX token management by adding an
> > > attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> > > binding to avoid the xarray allocator and instead use a per-binding n=
iov
> > > array and a uref field in niov. =20
> >=20
> > net/ipv4/tcp.c:2600:41: error: implicit declaration of function =E2=80=
=98net_devmem_dmabuf_binding_get=E2=80=99; did you mean =E2=80=98net_devmem=
_dmabuf_binding_put=E2=80=99? [-Wimplicit-function-declaration]
> >  2600 |                                         net_devmem_dmabuf_bindi=
ng_get(binding);
> >       |                                         ^~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
> >       |                                         net_devmem_dmabuf_bindi=
ng_put
>=20
> I see that net_devmem_dmabuf_binding_get() is lacking a
> stub for CONFIG_NET_DEVMEM=3Dn ...
>=20
> Just curious how pw works... is this a randconfig catch? I ask because
> all of the build targets pass for this series (build_allmodconfig_warn,
> build_clang, etc.. locally and on patchwork.kernel.org), and if there is
> a config that pw uses that I'm missing in my local checks I'd like to
> add it.

kunit hit it on our end

