Return-Path: <linux-arch+bounces-4952-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3638690BC39
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 22:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368B21C2288C
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 20:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E867188CB8;
	Mon, 17 Jun 2024 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="cjpKOwu1"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CCC8E1;
	Mon, 17 Jun 2024 20:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656473; cv=none; b=nyTQaBbUwWBfuA7xbkTqpSpWrfLiO9LEXikCKswB8oF1GBK/boJhVMTjVcuoN2WLLQFrrSH5as3/J0mCjHW1W8UVrZ0ff+V8TUhrIRoAx/QwXIYLnBmlAfcmpaf73QigJ7lXsdunsGJpIvJDaV/ftYU7p7vExVzYhr/FN2IS/Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656473; c=relaxed/simple;
	bh=/Gc+C2UHCtOgADFB+UMA/UmcYodFik9l5bCk3r+xZ3U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/apbgDTzHAN8ukp0g2cp+lPIM+IYtvHuvMwJnCIufqNsiIkMnnDymvjstIYo+wTSZEroneDnTS/lohIX3wwaYQ+PlwwucGiL7oenqpjNusoqzKA2nUacc4amdB/G0esWnf3J4B/5qZGDvxPDVecXmQsQlf6Phd/CY0ii90bwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=cjpKOwu1; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sTO8oI11aLdYRsC1cGz0uoItKaFKpKNhGb0xWrXF7Jg=; t=1718656469; x=1719261269; 
	b=cjpKOwu1kby5ZOeJX6lF6OxNZggw5lxlrL0Uta9llgGmyu3sHaTU3Mgz49SU1/MCcj+YQUjkxcN
	qsQ3PmDfxkBltGBkllsZYs50sbI5foFDTLGUHYgbEa5oxopZwirP5q9sZ34S2Sa8JMLo9VHqkM9wP
	69qpvfPMFlnaTQ90A5QwUB21PchzYiHpnCMH7xi2XN1hr09qIsNg4QRd1gQIs6M6dMjuELt3Hi8C0
	WQk8QbKK4hwImEIcthzEXN/WsZANurd9+zC61q0UWkC1Hf723Pskpm34KfEzWIIkxKQc5Z7xidQ/3
	2PohS/Ix6Jl80bkflm7fvPLAwEGG5pKkhF1g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sJIzx-00000000mcz-0YkK; Mon, 17 Jun 2024 22:30:41 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=suse-laptop-2.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sJIzx-00000004C3g-1WiU; Mon, 17 Jun 2024 22:30:41 +0200
Message-ID: <4da8ec47366209cdb4d61045cb6e8b2f872a37a1.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 cmpxchg 2/4] sh: Emulate one-byte cmpxchg
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: paulmck@kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, elver@google.com, akpm@linux-foundation.org, 
 tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org,
 pmladek@suse.com,  torvalds@linux-foundation.org, arnd@arndb.de, Andi Shyti
 <andi.shyti@linux.intel.com>, Palmer Dabbelt <palmer@rivosinc.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Date: Mon, 17 Jun 2024 22:30:40 +0200
In-Reply-To: <add0cb7b-6ec2-4b13-b327-8ff93358993e@paulmck-laptop>
References: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
	 <20240604170437.2362545-2-paulmck@kernel.org>
	 <c44890de1c3d54d93fbde09ada558e7cb4a7177c.camel@physik.fu-berlin.de>
	 <fcfa4d17-ea05-46f2-840d-9486923fd01d@paulmck-laptop>
	 <fc6bbbcd0b2a79d8fdcbde576ae3e5a52ffab02a.camel@physik.fu-berlin.de>
	 <972d3e89-ffda-49bc-8c0c-4d23484ca964@paulmck-laptop>
	 <add0cb7b-6ec2-4b13-b327-8ff93358993e@paulmck-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Paul,

On Mon, 2024-06-17 at 09:50 -0700, Paul E. McKenney wrote:
> On Tue, Jun 04, 2024 at 02:14:54PM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 04, 2024 at 07:56:49PM +0200, John Paul Adrian Glaubitz wro=
te:
> > > Hello,
> > >=20
> > > On Tue, 2024-06-04 at 10:50 -0700, Paul E. McKenney wrote:
> > > > > Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin=
.de>
> > > > >=20
> > > > > I can pick this up through my SH tree unless someone insists this=
 to
> > > > > go through some other tree.
> > > >=20
> > > > Please do take it, and thank you!  When I see it in -next, I will d=
rop
> > > > it from my tree.
> > >=20
> > > I'll pick it up over the weekend for which I have planned my usual ke=
rnel
> > > review and merge session.
> >=20
> > Very good, and again, thank you!
>=20
> Just following up...  I don't yet see this from you in -next.  When your
> version does show up in -next, I will drop my copy from -rcu.

Sorry, I was very busy last week and didn't get around to do any kernel stu=
ff.

I will take care of it this week, I have not forgotten about it and I never=
 let
patches unanswered, and unmerged once I have reviewed them.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

