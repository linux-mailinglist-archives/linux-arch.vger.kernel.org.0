Return-Path: <linux-arch+bounces-4301-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1E8C2C01
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 23:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020BE2832BF
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 21:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25013C3EC;
	Fri, 10 May 2024 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Tvv+EtWH"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8713C835;
	Fri, 10 May 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377219; cv=none; b=EIda4YonpbjNSFRtlsNqUi5m2rzx69fyBfYWqFcVxW/CQQYHu7oA3pB3o/2KRnHLQuyiIxpzUMkk5q3X4GZZF2jXUdkRl1KnqwrqzIVJU/FgFsObFSuZWxiOcXRu5VWFcsMti41xJIJoK4GOlk4cCU8xLByKiDcOTkhd2u6/XrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377219; c=relaxed/simple;
	bh=RN2RLnSPUFXzW3xUJJZQDApAf3jTnTsIoO+w2b3IB10=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Or5b+l0M9pytD3vM12UxqrIKPEDQIuXQobgO0u4bUOySAv8vGDwG+HUw8MkEuBttOzMn8jEUNuJvbzCWe9NNkW46rQ2lSr19EdE6S7AkZQDa6i/7QoJD6rEqIRASkOHwZyr2RzhlXlOc52sWsJ7PLibNO9DTW/0oYTgjgWJGGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Tvv+EtWH; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TzU2SbNt+iXCBZhtBGRIE1m2A+NSaMq0YWH+J4e8lbQ=; t=1715377214; x=1715982014; 
	b=Tvv+EtWHOm7Gm8vPP+4JLnJezhhQjFV6QZ1RvpTPEYUGDJfvIv2sIkG6g3hv0poqzkEDMpFai8q
	d8U9EqnZwNmIFIdS7P2e4dobw9Biw4osU7IqALLlP/rGW4hKL5MSzOuSZcDJ7/QtVac1ABawZkO8W
	jbRYsEherrG2heHQdlEEiselAPZ/4EE09WkVIrlNJ8Yf2qdorlMQA5WgiewbMkl1jtoHRDDSPx31j
	pIXxt96bzRsn9EDLcNCc7wwvuoVkroXLyG6mnpPKIS/yI/bR11Q6CNqFbh8mnty5aPWepXlnUu9bX
	DDUzyvWNaRJo8hz5V39ADtt9AjABuxOpTfIg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s5XyH-00000000cLs-1xwd; Fri, 10 May 2024 23:40:05 +0200
Received: from dynamic-077-011-138-145.77.11.pool.telefonica.de ([77.11.138.145] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s5XyH-00000002dgQ-12bt; Fri, 10 May 2024 23:40:05 +0200
Message-ID: <6e6dae45ffbf7a6ab54175695a3e21207c6f5126.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@arndb.de>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
 linux-alpha@vger.kernel.org, Richard Henderson
 <richard.henderson@linaro.org>,  Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, "Paul E. McKenney" <paulmck@kernel.org>
Date: Fri, 10 May 2024 23:40:04 +0200
In-Reply-To: <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
	 <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
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

On Fri, 2024-05-10 at 23:19 +0200, Arnd Bergmann wrote:
> The following changes since commit fec50db7033ea478773b159e0e2efb135270e3=
b7:
>=20
>   Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git ta=
gs/asm-generic-alpha
>=20
> for you to fetch changes up to a4184174be36369c3af8d937e165f28a43ef1e02:
>=20
>   alpha: drop pre-EV56 support (2024-05-06 12:05:00 +0200)

I'm still against dropping pre-EV56 so quickly without a proper phaseout pe=
riod.
Why not wait for the next LTS release? AFAIK pre-EV56 support is not broken=
, is
it?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

