Return-Path: <linux-arch+bounces-4330-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F598C3342
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 20:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274CD1F218B3
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 18:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7C61CD2C;
	Sat, 11 May 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="O4LTdbdz"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14361C698;
	Sat, 11 May 2024 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715453354; cv=none; b=T+t/tow3FNX+HypYKX8lOhbp5MxBW9VnLm9FyUx182YGkf12B8FBQxj9DPKLTTtt9i0ooIRBrmnvWB+W+dqxV6hdB9ytl35sfcRjlYNs18xV5xZTHlg01LxCdfVfGP8XCySfkbpm63QlUf4MryrVvSYZxRnLfLiy5Kp79SqpzCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715453354; c=relaxed/simple;
	bh=BuB70vFvE1UbtXbQ9MYZpxeNrNANcHpq7by0jZ/F0dY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ccl+e+BIFpsexh6jAS+/DPadrOBVV5vMY69s7xLMix+y9VHEeu57U0M2hTPCPoiHAlNgQiRj/Q8Ib9eZ3GnhjGU87T/h9sbLCjDlMV36Yiam2qnBat82ZS3PS0a0LFvNSqnGmpWEzbtyurX1+yBBRybgPOu6NiYGr2LVe0L6yhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=O4LTdbdz; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+C5DKYAlg3cMiKtrMKxk4T7Nydf3Ps1wF3CouTFVjJw=; t=1715453351; x=1716058151; 
	b=O4LTdbdzXTb5M44NDlmzpcs19iSOZ1wtAKogBQ+Ih7YYMYZJBtFRP5GhkiDwSn/PIW820kjvvgS
	vO5Q2iItsbANz4GYiszeEMl1eUE+zjFBn0cDgWuEMQ170O+LtUGyInz80Z/y5FJRwEmpjMK++0YpO
	OFdDUq9ntSsVURym5BGdlh6G9I1/kkxWrlKToib4MBPBSNwhRn5gWXMgNV5bcWc1HEPcJ4ZV1hy7+
	dArZpRx0NK4Ijq6coQQCYVuTcv2tNXwOc9lQhvjCuZ/F39ZUgxdfL+9YIpEfwvQkoczUIt/JkS9Dd
	7/e+OJkFBNsbuMRJeO1ickYUYO3hbQXSPbgg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s5rmO-00000003WCk-3IU3; Sat, 11 May 2024 20:49:08 +0200
Received: from dynamic-078-055-008-036.78.55.pool.telefonica.de ([78.55.8.36] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s5rmO-00000002cPb-2NbP; Sat, 11 May 2024 20:49:08 +0200
Message-ID: <7432d241b538819b603194bfb3a306faf360d4b1.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: paulmck@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, linux-alpha@vger.kernel.org, Richard
 Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>,  Matt Turner <mattst88@gmail.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>
Date: Sat, 11 May 2024 20:49:08 +0200
In-Reply-To: <46543a98-4767-471a-91be-20fb60ab138b@paulmck-laptop>
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
	 <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
	 <6e6dae45ffbf7a6ab54175695a3e21207c6f5126.camel@physik.fu-berlin.de>
	 <46543a98-4767-471a-91be-20fb60ab138b@paulmck-laptop>
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

Hi Paul,

On Fri, 2024-05-10 at 15:28 -0700, Paul E. McKenney wrote:
> > I'm still against dropping pre-EV56 so quickly without a proper phaseou=
t period.
> > Why not wait for the next LTS release? AFAIK pre-EV56 support is not br=
oken, is
> > it?
>=20
> Sadly, yes, it is, and it has been broken in mainline for almost two
> years.

Could you elaborate what exactly is broken? I'm just trying to understand t=
he reasoning.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

