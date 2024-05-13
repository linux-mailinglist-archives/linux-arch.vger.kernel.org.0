Return-Path: <linux-arch+bounces-4383-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CC68C48F6
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 23:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F42284AFA
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 21:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BCE83CD7;
	Mon, 13 May 2024 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="WOfNa72S"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86501175A6;
	Mon, 13 May 2024 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715636565; cv=none; b=Io0nV0zw5Qv3R0doBhMoAA9/RGx/DaOCcVMYBAkGsSTOILz3bwAdXABHbhDBdCrDlDQSsLX0PP6rT2Q8/0Do7ri3ypt6ceI6KFMd8+qklQrWkNfHA+RA9AfGFxjM9qypnyEaF79xmsnMHhE1MWFKfyt7garZQT+eNDNOq3NPgLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715636565; c=relaxed/simple;
	bh=CBBzXf2XlbvIjqTi00W41XD8zqaVqm+JP9BOU2COkbY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AsPMpmdr9g3ssFmjQ8hUvxscaxCiaXo5z0kw3A12UG5SHk8z2pB3QnRQD/pPnST4vpYY9I6ExtJZriUvuih7RBcIyxUcq54cBTHrpIpqpEtu4yWkT2M1xFRUfdQtD5hDx09wiuc3umlglIqwofo+G6cJEwmgw4zsKllm9nADyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=WOfNa72S; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QD2Hn4PiSFI1O5kOZF6pVg+j/auYbzCHkdsarZTYRnk=; t=1715636561; x=1716241361; 
	b=WOfNa72SFXMlVbeoYenGtTclCUlrxNvv3q4n0bT8DReD/eh5caS6aKkyojGctkIhk88hVqpQE8d
	U+eWJG2APWzeZhgVwldSSQjT+8awSjV6zo7lO+68Zrb0TwJbe2+4+4Mq38QSsF/n03iLkx+U/ghZe
	QMuc6Wi4UP7CRMuRhGijTLFia35GXsgT2EQtNY8hwj3O74Gr+Mbrfe7UXrSd+yzHWB+hD1O/Yxhzb
	Cwrdu+Egw6YBOn3Wyv//mHF5VMrvGAqmP80bse1WRLoRajJXPeLDbSzBaT7QNMJJzAFAEgRFsO/c3
	rDZg+aWmfnPTpsVL3WUs7M6PTvSks0tPw1sw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s6dRN-00000002UDW-48Xa; Mon, 13 May 2024 23:42:38 +0200
Received: from p5b13a15c.dip0.t-ipconnect.de ([91.19.161.92] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s6dRN-00000003xHf-3AzV; Mon, 13 May 2024 23:42:37 +0200
Message-ID: <c585d63e73453082ecbf7ddc19d5116abdcfba79.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann
	 <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
 linux-alpha@vger.kernel.org, Richard Henderson
 <richard.henderson@linaro.org>,  Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, "Paul E. McKenney" <paulmck@kernel.org>
Date: Mon, 13 May 2024 23:42:37 +0200
In-Reply-To: <CAHk-=wgZ_fCwC5iGri1KOEwdV90H-myv1gSfjHfCwt82ZXaCWQ@mail.gmail.com>
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
	 <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
	 <CAHk-=wgZ_fCwC5iGri1KOEwdV90H-myv1gSfjHfCwt82ZXaCWQ@mail.gmail.com>
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

On Mon, 2024-05-13 at 09:27 -0700, Linus Torvalds wrote:
> On Fri, 10 May 2024 at 14:20, Arnd Bergmann <arnd@arndb.de> wrote:
> >=20
> >   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git =
tags/asm-generic-alpha
>=20
> Well, despite the discussion about timing of this, I have pulled this.
> I still have a fond spot for alpha, even if it has the worst memory
> ordering ever devised, but the lack of byte operations was an
> inexcusable "we can deal with that in the compiler" senior moment in
> the design. So good riddance.

As someone who spends a lot of personal time and energy and even money into
Linux, I have to say the way this change was steamrolled into the kernel
without any real discussion actually hurts.

It's days like these when I'm starting to question my efforts.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

