Return-Path: <linux-arch+bounces-12282-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6F4AD11B9
	for <lists+linux-arch@lfdr.de>; Sun,  8 Jun 2025 11:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F3F47A5A42
	for <lists+linux-arch@lfdr.de>; Sun,  8 Jun 2025 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721691FDE01;
	Sun,  8 Jun 2025 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="XsF7RNTr"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3331A13C3CD;
	Sun,  8 Jun 2025 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749375890; cv=none; b=KnWhYCEbExGnPNSAv86S7/7I2t7rDc1XlHJ1taaoI59NJofyZK2X9fCO242Fww0/QNC2ma5mjCD//adVq0vo4WRcCHLcGfxW+IpzJvHmv+XG2P7jdBw6xmz/r+lXPpKtQdtUVBG7j41o7jfXt7mg155dXU58EAVjFHq2BfngyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749375890; c=relaxed/simple;
	bh=TCv1nBrubfIcsi4DlAa3/6ZRjyP5G7Lfpe6gnZZm6Ns=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwvqU5A8W7/YUI7VttXS/0qiMBvv9TGQ6rjex7dpKedWW5kdf4rltyxjuyd3kML5k+KsFyii5O7E9wLOdVjXZ+omJ2rsxkii3qTPft7+Q2OKhZvf+qmtyIgOLMmWnNeRqL/6Tv/h+InH/tfVNHsI0NyGONsAvmJwLunPbz71S9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=XsF7RNTr; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AvQSbwk0OMZgevNebkqyi44TEBQebr6htxrvwpOZR80=; t=1749375887; x=1749980687; 
	b=XsF7RNTrY6leik/CR49OltCXmZ+nmg2YeysRu2zcT3ZmKZ0KTI/9vIHQTdvHBDPZp3uOGkhnj6N
	CGsuW/loLdu/7d7QXyIejxsVUOJ5PMiCXJhGFrl+ZKN4kAlLdxfKImpeA3McLvcXXjbkOWTUY3psl
	GA36G4WhvFEdjldstuPb8CW3OC8DU7Td7nb7iNs7LTulSoumtHmMfshUxYGOpHCo99BmQHlq3dTuI
	YG+RY5Mn2MrLq5Q1ExJB8yEp+mdDxwbilTzu4iBErGwB6tFKXsUAEIwIn/+wcTtqaOWSdBrDojB54
	OgV9BQHCiSqGo9gdI3Asy0s0I8f1n20+K3Zg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uOCZv-00000000rzo-33xN; Sun, 08 Jun 2025 11:44:35 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uOCZv-00000001WdX-1muC; Sun, 08 Jun 2025 11:44:35 +0200
Message-ID: <ea09adb64428a73b84cc0199c3b1efb09b9db23c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/6] sh: remove duplicate ioread/iowrite helpers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org, Arnd
 Bergmann	 <arnd@arndb.de>, Richard Henderson
 <richard.henderson@linaro.org>, Matt Turner	 <mattst88@gmail.com>, Greg
 Ungerer <gerg@linux-m68k.org>, Thomas Bogendoerfer	
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"	
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
 Madhavan Srinivasan	 <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin	 <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker	
 <dalias@libc.org>, Julian Vetter <julian@outer-limits.org>, Bjorn Helgaas	
 <bhelgaas@google.com>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Date: Sun, 08 Jun 2025 11:44:34 +0200
In-Reply-To: <CAMuHMdXeTWSU64jQt+nybsSBOpBEu_zO0WmE5FK1PnA3YkALUQ@mail.gmail.com>
References: <20250315105907.1275012-1-arnd@kernel.org>
	 <20250315105907.1275012-3-arnd@kernel.org>
	 <6c7770dd1c216410fcff3bf0758a45d5afcb5444.camel@physik.fu-berlin.de>
	 <CAMuHMdXeTWSU64jQt+nybsSBOpBEu_zO0WmE5FK1PnA3YkALUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Geert,

On Sun, 2025-06-08 at 11:39 +0200, Geert Uytterhoeven wrote:
> Hi Adrian,
>=20
> On Sat, 7 Jun 2025 at 14:08, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Sat, 2025-03-15 at 11:59 +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >=20
> > > The ioread/iowrite functions on sh only do memory mapped I/O like the
> > > generic verion, and never map onto non-MMIO inb/outb variants, so the=
y
> > > just add complexity. In particular, the use of asm-generic/iomap.h
> > > ties the declaration to the x86 implementation.
> > >=20
> > > Remove the custom versions and use the architecture-independent fallb=
ack
> > > code instead. Some of the calling conventions on sh are different her=
e,
> > > so fix that by adding 'volatile' keywords where required by the gener=
ic
> > > implementation and change the cpg clock driver to no longer depend on
> > > the interesting choice of return types for ioread8/ioread16/ioread32.
> > >=20
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> > Those are quite a number of changes that I would like to test on real h=
ardware
> > first before merging them into the kernel.
> >=20
> > @Geert: Could you test it on your SH-7751 LANDISK board as well?
>=20
> Already done for a while, as this patch is commit 2494fce26e434071 ("sh:
> remove duplicate ioread/iowrite helpers") in v6.15-rc1 ;-)

Well, there is no Tested-By from either of us, so this isn't optimal.

I wished Arnd could have at least pinged me back regarding this. He knows I=
'm
actively maintaining arch/sh and I would like to properly test and review
such changes.

But I'm not doing this professionally, so I cannot be always there with 100=
%
capacity. Just pushing such changes in without any input from me defeats th=
e
purpose of a maintainer.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

