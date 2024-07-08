Return-Path: <linux-arch+bounces-5306-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB7C929A7F
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 03:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E7F1F211BA
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 01:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E723386;
	Mon,  8 Jul 2024 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bq45LWmi";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="T8aoiESy"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AB19B;
	Mon,  8 Jul 2024 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720401692; cv=none; b=BcR0oteR7pguc1GQw96e8gcMM/+ViU+6wKgdKpH7jQ04X/eJZiOZSe0orsPg0Y0UN7AvPgOAhVqjfTgkPlYE3CxBl/7fvwu+4CkSFi4GSRe5xct1S5/0C4jWAvPjhQjlO1fuyVETGZNfuUFeh9vJ9+YYXzh+UKaRwt/7mNL9JE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720401692; c=relaxed/simple;
	bh=SrabfQfrtwWxcdX18kQycQ2yUzzWvO8BO1Eq9DoJvks=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gle1zgkQD/m1lS+B/a8+rXtDdjKi4iQnnJfm/tPeEzkt7VKO9NHxuoM0swQ8B66Jl+Dt6GEs9bitoIIi0J5sEaydrxU3GjHaFndIj2iRJbQgJOB6uDl3jXUiIIcItgk2F1WJj40E7t0aoFBDqY6rnLWsNo/jb7e77VFtVJ1FQp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bq45LWmi; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=T8aoiESy; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BA3930592;
	Sun,  7 Jul 2024 21:21:24 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=SrabfQfrtwWxcdX18kQycQ2yUzzWvO8BO1Eq9D
	oJvks=; b=Bq45LWmilKGSvTZj6Tr0/vVsZcoO5KIAbTrbM3iz0zpMVJQhxk6UFc
	TIhz+3Zg2F1jA4O/+Go0Xh/OEPzyapgtmkoEOn58OrgyPdDuUsKXKdawPHDcp6Q5
	5yy/Kx4w4q907QfMhhTN3gxWwvYLQVhtfaDsbzeAGPknAtL3KcRzY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8428B30591;
	Sun,  7 Jul 2024 21:21:24 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=SrabfQfrtwWxcdX18kQycQ2yUzzWvO8BO1Eq9DoJvks=; b=T8aoiESyqpHPaupJZRaX0lrklDDFGgy5A/BzStsRsAG2C1i3rO5tfl8s3lVnmxUyYaE2HdE6UJHC8esWoLQ23ZYwd2y9xtew3Mk0XhWi/DTqbWeUWqXP1Sd/vokRBbb5GGJ32YseZynCIB4uZIrzKT9FqQIljidEo2REw2sIDJk=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8598C30590;
	Sun,  7 Jul 2024 21:21:20 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 59A40D3BCE2;
	Sun,  7 Jul 2024 21:21:18 -0400 (EDT)
Date: Sun, 7 Jul 2024 21:21:18 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>
cc: Russell King <linux@armlinux.org.uk>, 
    Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] __arch_xprod64(): make __always_inline when
 optimizing for performance
In-Reply-To: <3dc8f89e-4525-4084-9d4a-facb6105239c@app.fastmail.com>
Message-ID: <57srp3ps-n7p8-orqq-86rq-p04o2246pn7s@syhkavp.arg>
References: <20240707171919.1951895-1-nico@fluxnic.net> <20240707171919.1951895-5-nico@fluxnic.net> <55a8cff0-1d73-4743-9c56-2792616426c7@app.fastmail.com> <8251045r-26sn-4674-p820-4qp6s5o322qq@syhkavp.arg>
 <3dc8f89e-4525-4084-9d4a-facb6105239c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 61EA045A-3CC8-11EF-B4F2-C38742FD603B-78420484!pb-smtp20.pobox.com

On Sun, 7 Jul 2024, Arnd Bergmann wrote:

> On Sun, Jul 7, 2024, at 21:14, Nicolas Pitre wrote:
> > On Sun, 7 Jul 2024, Arnd Bergmann wrote:
> >
> >> On Sun, Jul 7, 2024, at 19:17, Nicolas Pitre wrote:
> >> > From: Nicolas Pitre <npitre@baylibre.com>
> >> >
> >> > Recent gcc versions started not systematically inline __arch_xprod64()
> >> > and that has performance implications. Give the compiler the freedom to
> >> > decide only when optimizing for size.
> >> >
> >> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> >> 
> >> Seems reasonable. Just to make sure: do you know if the non-inline
> >> version of xprod_64 ends up producing a more effecient division
> >> result than the __do_div64() code path on arch/arm?
> >
> > __arch_xprod_64() is part of the __do_div64() code path. So I'm not sure 
> > of your question.
> >
> > Obviously, having __arch_xprod_64() inlined is faster but it increases 
> > binary size.
> 
> I meant whether calling __div64_const32->__arch_xprod_64() is
> still faster for a constant base when the new __arch_xprod_64()
> is out of line, compared to the __div64_32->__do_div64()
> assembly code path we take for a non-constant base.

Oh, most likely yes. The non-constant base has to go through the whole 
one-bit-at-a-time division loop whereas the constant base with 
__div64_const32 results in 4 64-bits multiply and add. Moving 
__arch_xprod_64() out of line adds the argument shuffling overhead and 
it can't skip overflow handling, but still.

Here's some numbers. With latest patches using __always_inline:

test_div64: Starting 64bit/32bit division and modulo test
test_div64: Completed 64bit/32bit division and modulo test, 0.048285584s elapsed

Latest patches but __always_inline left out:

test_div64: Starting 64bit/32bit division and modulo test
test_div64: Completed 64bit/32bit division and modulo test, 0.053023584s elapsed

Forcing both constant and non-constant base through the same path:

test_div64: Starting 64bit/32bit division and modulo test
test_div64: Completed 64bit/32bit division and modulo test, 0.103263776s elapsed

It is worth noting that test_div64 does half the test with non constant 
divisors already so the impact is greater than what those numbers show.

And for what it is worth, those numbers were obtained using QEMU. The 
gcc version is 14.1.0.


Nicolas

