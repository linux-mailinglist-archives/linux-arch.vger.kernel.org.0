Return-Path: <linux-arch+bounces-4685-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54D28FBB09
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 19:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120CE1C21898
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 17:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDEC149E03;
	Tue,  4 Jun 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="lW0XgdXM"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B9B1487DC;
	Tue,  4 Jun 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523818; cv=none; b=H77gYtss1D04XO9KqEsVME0AjkytI1QsivhyAPeeYUzG8FRUMGguXtURLeB9Orgu8RsIaf5jCE6GLee00RcpjTUlxwf2eH6rsUPoZX0vHczzRTPojADy5BO04RKcOBrVXv6c9cuGg0elgMCnRRKDaB87XdzV5zxHD41qAfIPqMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523818; c=relaxed/simple;
	bh=01/796tP5PbyAszPkhz/4rw8qfREIO3W6R5nzVRXffo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IjBG1RN6LzEFWa+V6SngDc4DNoy2+qpN0XXuJqnUCTvwV9oaqa/Jg08PL9OLtEGnGg7OLxEhJo8PuCWu905uCmfE3pthQGyLmrWp4CRAce1hpYujJQLO9FDyki+b5GsHx5EmZqpS02NpUc5Q76ZQ3cQwmOaJb9yyJgzA4lUMO24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=lW0XgdXM; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ex0/jsAU2z4rnu2Iz/lqMEV9TPAG1zSwQM+2P/IPTq4=; t=1717523814; x=1718128614; 
	b=lW0XgdXMLQkKJytNBxhoNv0/U4VaijYVljCUu5CjwuhFalTSauUenxaxcgzmiJkGE1MK/aUAXB+
	82fhBOLidNgS0kjqtTsks4enFgcMLY40gEAXrXurSPZFMESjB14tkI7ADmLKdcnwfEo8arKoOWRfR
	D1UTgoqmaKAXin8nrRkmXuYfJ9L4uYpzOo85CaSQhEPI1x+SwHu2QwrqhW1vF7uZ7oYs7RQaoNi9x
	+bTN7EzZH/4YETxMuFXUtMTFZZ3b5oQeye1i3qPNkh+BVVn1mONS056UYyO7i9mdJTDRyYkvjNEYB
	Zu/do8MQOWwHl/p+RLR9BYJIwIAQ9+2xIZmg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sEYOw-00000000cPV-3eyW; Tue, 04 Jun 2024 19:56:50 +0200
Received: from p57bd9a40.dip0.t-ipconnect.de ([87.189.154.64] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sEYOw-00000002mlm-2duq; Tue, 04 Jun 2024 19:56:50 +0200
Message-ID: <fc6bbbcd0b2a79d8fdcbde576ae3e5a52ffab02a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 cmpxchg 2/4] sh: Emulate one-byte cmpxchg
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: paulmck@kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, elver@google.com, akpm@linux-foundation.org, 
 tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org,
 pmladek@suse.com,  torvalds@linux-foundation.org, arnd@arndb.de, Andi Shyti
 <andi.shyti@linux.intel.com>, Palmer Dabbelt <palmer@rivosinc.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Date: Tue, 04 Jun 2024 19:56:49 +0200
In-Reply-To: <fcfa4d17-ea05-46f2-840d-9486923fd01d@paulmck-laptop>
References: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
	 <20240604170437.2362545-2-paulmck@kernel.org>
	 <c44890de1c3d54d93fbde09ada558e7cb4a7177c.camel@physik.fu-berlin.de>
	 <fcfa4d17-ea05-46f2-840d-9486923fd01d@paulmck-laptop>
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

Hello,

On Tue, 2024-06-04 at 10:50 -0700, Paul E. McKenney wrote:
> > Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> >=20
> > I can pick this up through my SH tree unless someone insists this to
> > go through some other tree.
>=20
> Please do take it, and thank you!  When I see it in -next, I will drop
> it from my tree.

I'll pick it up over the weekend for which I have planned my usual kernel
review and merge session.

> > Adrian
> >=20
> > PS: I'm a bit stumped that I'm not CC'ed as the SH maintainer.
>=20
> Me too, now that you mention it.  I did generate the list some time
> back, but "git blame" shows you being maintainer for more than a year.
> Yet I do have the linux-sh email list, so it is unlikely that I pasted
> the get_maintainer.pl output from the wrong commit.
>=20
> I am forced to hypothesize that I fat-fingered the output of
> get_maintainer.pl when adding the Cc lines to that commit.
>=20
> Please accept my apologies for having left you out!

No worries. I was just surprised as I assume get_maintainer.pl should have
done the right thing and spit out the names of the responsible maintainers.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

