Return-Path: <linux-arch+bounces-14984-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3341C72EB9
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 09:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D5E24EE833
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 08:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309523115A1;
	Thu, 20 Nov 2025 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Memwof6C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ONY46/Pj"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E5030BB8F;
	Thu, 20 Nov 2025 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627223; cv=none; b=Yb4xSElZwiwJTWNzG3Yr2tGdqHIAn63fmEifjw5sFCdR9eEBcIUlErNzVXm4xI8H2s4ZGKV/uGcG4+swgNGxJzeFbUuTrnhEzUXr2SdL/g0Y+JRm9t6AICMxxuQHor6f+Z89Hii5cI9g+x52nA4muacsp/c0azVQcTWomh3NCyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627223; c=relaxed/simple;
	bh=pmFrdCTokm6rF6q8zcT7Ax+Qhq1vF0C2jO3l4U5ya74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DagBCQF10RxfowY/S1bQgNLDHohQrRxXHJQwPs2lR/i4Zv+Ms2eioRsbKYN/W+E6PR2sOY9g5TwK/fVr4oVjyUtUWK4KYJM5ahHkQWUYrLpgZuplTxTJ9b7G/SqInSePj1oEQTgMcJbfLjcnqOPROwBUttf7MjbQzTp/xhq2EUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Memwof6C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ONY46/Pj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 09:26:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763627218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3i77Uif1UYr36Q95jaP00tP6LU81YEbF4wrRUb0TMaw=;
	b=Memwof6Cx7uIkmsEIlfr4CqwLq6MMlwaxoLwD7clXeMQMpVbcEDkmSu5By+6F3UeChyUJk
	Bcdr735VadOKJ5/C2xQofvB5lh82CVgHAJohoGMdPQk9nB+ct6ob2kF1+tXIk8nc4CK1Tu
	+aLAMpkZsTYclRrpNqAGuAmnssl4GF42k9L5+h7ukqYGopIXkQTtHi545TUQljBYPUifvf
	lFqeRD9NCDAXe72+p0/sGQrG9Im6/X8HgdSNeKjMVTxQt+AuQdv7wNeE0aCagD2YO5wtTX
	0QYMavEN20x0nGZVdS0X41ccmZGZRKJm+/uF6AgOMFgcIe4G/RB8EecScpohYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763627218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3i77Uif1UYr36Q95jaP00tP6LU81YEbF4wrRUb0TMaw=;
	b=ONY46/Pjm7/CfcF6EOHKY0bF6mVPuYQxnHXdzlxdXf164CrJPpJAXCy4fRXzgRkF/G27bP
	tU8L3dIyABq5E0Bg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, 
	loongarch@lists.linux.dev, linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 13/14] LoongArch: Adjust default config files for
 32BIT/64BIT
Message-ID: <20251120091849-6ced7bf4-048f-405c-98ed-68df64816d25@linutronix.de>
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-14-chenhuacai@loongson.cn>
 <20251120090846-746f973f-e08a-46ab-a00d-87a5be759941@linutronix.de>
 <CAAhV-H52FAORNDM48nYjQUWjnDFxc7+RGUsOW+JNteJrpbF6ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H52FAORNDM48nYjQUWjnDFxc7+RGUsOW+JNteJrpbF6ww@mail.gmail.com>

On Thu, Nov 20, 2025 at 04:16:25PM +0800, Huacai Chen wrote:
> Hi, Thomas,
> 
> On Thu, Nov 20, 2025 at 4:11 PM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > On Tue, Nov 18, 2025 at 07:27:27PM +0800, Huacai Chen wrote:
> > > Add loongson32_defconfig (for 32BIT) and rename loongson3_defconfig to
> > > loongson64_defconfig (for 64BIT).
> > >
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  arch/loongarch/configs/loongson32_defconfig   | 1110 +++++++++++++++++
> > >  ...ongson3_defconfig => loongson64_defconfig} |    0
> > >  2 files changed, 1110 insertions(+)
> > >  create mode 100644 arch/loongarch/configs/loongson32_defconfig
> > >  rename arch/loongarch/configs/{loongson3_defconfig => loongson64_defconfig} (100%)
> >
> > KBUILD_DEFCONFIG also needs to be adapted to this rename.
> That is done in the last patch.

That means the 64bit 'make defconfig' is broken within this series, potentially
breaking bisects.

> > FYI the cover letter says the series is based on v6.16-rc6, but the series
> > doesn't apply to it.
> Not 6.16-rc6, but 6.18-rc6, and the next version will be on top of 6.18-rc7.

That was a mistype. It doesn't apply to v6.18-rc6.

Looking at the GitHub repo mentioned in the cover letter, there are additional
patches on top of rc6. Which I guess is fine in general, but the changelog
could be a bit clearer.

