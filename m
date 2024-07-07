Return-Path: <linux-arch+bounces-5295-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744479298ED
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 18:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADED21C20E42
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11A746B9A;
	Sun,  7 Jul 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IQlRACtA";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="rCpNcsQd"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D891447A60;
	Sun,  7 Jul 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371222; cv=none; b=HLfE/830wa438QV6lLQRHKGRU9XFiwQrVxAuQcQhNjMhQANUtSMfo61MdQ8qdoZGcfn289CEGkIFBT66db8/lafvvohgAtLAarYAVCw/bYl9kvXjLCSfTX1GOY/F5JcJDoYwudPH33KYEF1eEdkJURAeDqd+YwvJZefMQuLCZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371222; c=relaxed/simple;
	bh=vntOzjQEI3yBL/RjMRz59P/+MLtpRD2YnC8nimZ3bu8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GbNwzpnkbHCyuDXC5FL1JatbcVz9Gmmj9RFIdDrSEQg7LvNdOATqmhA4q7ul9TRnv+13Iz83qkmXUDVlcCC4h3S1Il2Rd74uWGJcT4chyfnKUGSn7JXgvyRKEtJVX4TJB3IouMclZsfAuO5xpjssq5Pclw6AzkMivn2KisGVY5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IQlRACtA; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=rCpNcsQd; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EA292270F;
	Sun,  7 Jul 2024 12:53:39 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=vntOzjQEI3yBL/RjMRz59P/+MLtpRD2YnC8nim
	Z3bu8=; b=IQlRACtAJ5fqsi2crNtXveguHnskQhSRc8hddeYqP3LB1Vca7ZH0uG
	OXZwxvv9osG4aw+EDIpEkHx/d9LCDwsV3hyRyih8E7DVHSoA+sGeLigjnD4IDLV5
	sNq6GF/Wy9ZFTEXUfxY1vqC/S+mSdXjXdghVJ6qTlCGOXro2Gm0AM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8459F2270E;
	Sun,  7 Jul 2024 12:53:39 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=vntOzjQEI3yBL/RjMRz59P/+MLtpRD2YnC8nimZ3bu8=; b=rCpNcsQd6FgPNVNfb/fWwwge/pwhoCqoYxE7RJuDwRonS0AD3kZa2rpjq+TXj0sxm8Oe9hbMJ7oHrLZ98/GPYUqiBafzSahp+mHi0q6O/IrIeesfgMIQGB+L04LtSHtJZh8PRXEcMcwghsh1qstpshpplESJQPtD38f5hJh+SbE=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D5002270D;
	Sun,  7 Jul 2024 12:53:39 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id D8A4ED3B18E;
	Sun,  7 Jul 2024 12:53:37 -0400 (EDT)
Date: Sun, 7 Jul 2024 12:53:37 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>
cc: Russell King <linux@armlinux.org.uk>, 
    Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, 
    llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 2/2] asm-generic/div64: reimplement __arch_xprod64()
In-Reply-To: <3adf7f7b-a46e-4368-a87a-a217a8a8f9d1@app.fastmail.com>
Message-ID: <n42s335n-44n0-pq0o-78q8-s38o2ssn8p5r@syhkavp.arg>
References: <20240705022334.1378363-1-nico@fluxnic.net> <20240705022334.1378363-3-nico@fluxnic.net> <3adf7f7b-a46e-4368-a87a-a217a8a8f9d1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 75738646-3C81-11EF-A52D-5B6DE52EC81B-78420484!pb-smtp1.pobox.com

On Fri, 5 Jul 2024, Arnd Bergmann wrote:

> On Fri, Jul 5, 2024, at 04:20, Nicolas Pitre wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> >
> > Several years later I just realized that this code could be optimized
> > and more importantly simplified even further. With some reordering, it
> > is possible to dispense with overflow handling entirely and still have
> > optimal code.
> >
> > There is also no longer a reason to have the possibility for
> > architectures to override the generic version. Only ARM did it and these
> > days the compiler does a better job than the hand-crafted assembly
> > version anyway.
> >
> > Kernel binary gets slightly smaller as well. Using the ARM's
> > versatile_defconfig plus CONFIG_TEST_DIV64=y:
> >
> > Before this patch:
> >
> >    text    data     bss     dec     hex filename
> > 9644668 2743926  193424 12582018         bffc82 vmlinux
> >
> > With this patch:
> >
> >    text    data     bss     dec     hex filename
> > 9643572 2743926  193424 12580922         bff83a vmlinux
> >
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> 
> This looks really nice, thanks for the work!
> 
> I've tried reproducing your finding to see what compiler
> version started being good enough to benefit from the
> new version. Looking at just the vmlinux size as you did
> above, I can confirm that the generated code is noticeably
> smaller in gcc-11 and above, slightly smaller in gcc-10
> but larger in gcc-9 and below.

Well well... Turns out that binary size is a bad metric here. The main 
reason why the compiled code gets smaller is because gcc decides to 
_not_ inline __arch_xprod_64(). That makes the kernel smaller, but a 
bunch of conditionals in there were really meant to be resolved at 
compile time in order to generate the best code for each instance. With 
a non inlined version, those conditionals are no longer based on 
constants and the compiler emits code to determine at runtime if 2 or 3 
instructions can be saved, which completely defeats the purpose in 
addition to make performance worse.

So I've reworked it all again, this time taking into account the 
possibility for the compiler not to inline that code sometimes. Plus 
some more simplifications.


Nicolas

