Return-Path: <linux-arch+bounces-4384-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 657078C48FA
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 23:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925071C20D42
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 21:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ABC83CD7;
	Mon, 13 May 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Dec8QA/9"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0383CD6;
	Mon, 13 May 2024 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715636657; cv=none; b=aM5A1S10ry9YJYnNUzJh0sotFaLb9/cZVbP0p+r3EsTdgxLVH1UpyfpoXYxvj1yfWRZpdkES4PHYqfsmn6I460dgP0UuhXcbR14HVwPd4GN18qNWDHfCkcgzJ46TXqLBz0HPC+4ihFeG/e7MnC0ib9Unupts1JbLkl17durGXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715636657; c=relaxed/simple;
	bh=DGcWynaS9JPH0MqSK4y/sgRZ71IgxrFrCdnCDClKYjg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UTsOajnBeLQTAvgGjV9aWp9JQv/0fE5HF315lwhABT1/d0cJEIKY9A7XPwJw7roS994EV/yRXYy79a+5hVq71yWBWR9blD+vrEGbJDks+OT2vXkdnVbsTmbsMLlJ1eX0gUVtAI8eUAwZiiKH8eC+bdKSDuBgTjWGtzbsfLwlI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Dec8QA/9; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+5KSMEQtWmpPZyU+Ee+dJui77AOOrsi0CRn5i+HekaY=; t=1715636655; x=1716241455; 
	b=Dec8QA/9U5uPoyY/fpdH6aIAajxCEHk7jAGnwu//K6rgmBGJ0hUiw8sRfV85ogrz2N3/8AFehfe
	eFNSNnMom2W2LJgVU+rZfdLIAnE0WUjQt/FumbXDrVzg8Rnyqfmqpik3qJzfqZLDgBHi5BWJHZ3e7
	+J+ql7YpWTlCfbGRtofSInlTb02WI1M7ZZvqJ5Jb980Je5KXHQFrXC8wVVCsbz3EULWGQ1R+J6lYM
	KvK/PPK7jAua5Xx9D1GsP9YTFhk7brBduGOV0x6RDRiI1SzWlPS675gIzwwmqH16aI7kOAc+S0HIq
	WJhf1R5IvGNYO5pqZhQGBQiJ2jUBq5pcaDSA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s6dSu-00000002UMq-0AXM; Mon, 13 May 2024 23:44:12 +0200
Received: from p5b13a15c.dip0.t-ipconnect.de ([91.19.161.92] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s6dSt-00000003xh4-3NQ9; Mon, 13 May 2024 23:44:11 +0200
Message-ID: <744fcf05a45a0863536c09c3fd3bf3057bbc8733.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ulrich Teichert <krypton@ulrich-teichert.org>, Akira Yokosawa
	 <akiyks@gmail.com>
Cc: paulmck@kernel.org, arnd@arndb.de, ink@jurassic.park.msu.ru, 
 linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mattst88@gmail.com,
 richard.henderson@linaro.org,  torvalds@linux-foundation.org,
 viro@zeniv.linux.org.uk
Date: Mon, 13 May 2024 23:44:11 +0200
In-Reply-To: <202405131652.44DGqMjs007653@valdese.nms-ulrich-teichert.org>
References: <202405131652.44DGqMjs007653@valdese.nms-ulrich-teichert.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ulrich,

On Mon, 2024-05-13 at 18:52 +0200, Ulrich Teichert wrote:
> I've probably disabled SMP in my test kernel, the jensen is a single CPU
> system. I never had the pleasure of owning an AlphaServer 2000 or 2100,
> which (according to https://en.wikipedia.org/wiki/AlphaServer and
> https://en.wikipedia.org/wiki/AlphaStation) are the only systems
> with EV4/EV45/EV5 multi-CPU setups (apart from the Cray T3{DE}), so
> the possibility of ever seeing an error concerning atomic concurrent
> updates is quite low.
>=20
> Anybody out there with an AlphaServer 2000/2100 willing to try ?-)

It has unfortunately been decided that further discussion is not wanted
and support for older Alpha hardware has now been removed. So there is
nothing more to try, unfortunately.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

