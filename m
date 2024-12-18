Return-Path: <linux-arch+bounces-9424-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D11319F62D6
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 11:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE5516D57B
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7FA192598;
	Wed, 18 Dec 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2SSWoTmi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AoKeNEyu"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C796C198E75;
	Wed, 18 Dec 2024 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517548; cv=none; b=tjxjqWoSesRpjEv1PFVwaUtd0O8nvQ74qK319oqiNVvUXkNMCwqz0HCPMeCUVCzEzXFYzM8SoQFEkYlj9e3+JBMPKSmnJ2z03KKC8sN/poEXBlKPNc0hboYM1jBEp+/DOIm65LwH6EeveUayj4QsQPpz4BlCMdWYLKGfgSBLyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517548; c=relaxed/simple;
	bh=/VgkqBQeVlIOAs2uYQLNDJXkep5HLD235lAaSkgEzsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHP7aR/STk4iJP9EPvoNBYrx56PunXWZexPrZR9Tl3jmtgUmHDb7QyVm1z9oJZpmKu3cDxjPfKf3JIBigOGIdHe8+49yQX0WCGy4xriIjTAdfblS/UqHh9/vt9oZeqmchu7GqfldFj96iQtdtTTd/qeOW4e66OVTWJRICztMM/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2SSWoTmi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AoKeNEyu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 11:25:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734517545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wc3y2MMAV4l4fXGHcieZbsIyWfTg/ozhFPhFb4lifrk=;
	b=2SSWoTmikqml+QyzziVj/m4Yg45xAoP4dNtwTBlJig2p14toOtHozKw5Bxfjy4L/DvACGV
	OMNT4R2Rekm2Ck8CCOW0XGD1j8FoyZrt3Z7jazkfGB6Zv+KWrHTMOhmUum+sr+mgUm1e61
	TM1KWhbGQXbTlvxJf51hlLY47fK7pZY7y05qey8SsXBH0Nkg9uMgzFSWUJ30b/nxZp2S3N
	Hy4DtDnFlOUNAID7T8cQaJtlrwqn059Y+FAOYDMu2CWWxXTn5NsAeABAkO/WY90H+pP48R
	uMCgaoU5KLrPl82I7qw8SvgoxROfvTSXg9ibM/gPkLEPvpm/oD+JPk198PVRXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734517545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wc3y2MMAV4l4fXGHcieZbsIyWfTg/ozhFPhFb4lifrk=;
	b=AoKeNEyuPrW2z0f+0sR+kxNpoFiiPy1/gq9ak22q5IqO1FLos7EO/vgThimKc+44ktm5ZR
	tRGCj/jF+KFa4yBw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 03/17] vdso: Add generic time data storage
Message-ID: <20241218111724-41f5e3c6-f41d-41ec-beed-bd05cca05016@linutronix.de>
References: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
 <20241216-vdso-store-rng-v1-3-f7aed1bdb3b2@linutronix.de>
 <3b44defd-cd2a-4a3c-b72d-bcc0530336da@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b44defd-cd2a-4a3c-b72d-bcc0530336da@csgroup.eu>

Hi Christophe,

On Wed, Dec 18, 2024 at 08:32:14AM +0100, Christophe Leroy wrote:
> Le 16/12/2024 ‡ 15:09, Thomas Weiﬂschuh a Ècrit†:
> > Historically each architecture defined their own way to store the vDSO
> > data page. Add a generic mechanism to provide storage for that page.
> > 
> > Furthermore this generic storage will be extended to also provide
> > uniform storage for *non*-time-related data, like the random state or
> > architecture-specific data. These will have their own pages and data
> > structures, so rename 'vdso_data' into 'vdso_time_data' to make that
> > split clear from the name.
> > 
> > Also introduce a new consistent naming scheme for the symbols related to
> > the vDSO, which makes it clear if the symbol is accessible from
> > userspace or kernel space and the type of data behind the symbol.
> > 
> > The generic fault handler contains an optimization to prefault the vvar
> > page when the timens page is accessed. This was lifted from s390 and x86.
> > 
> > Co-developed-by: Nam Cao <namcao@linutronix.de>
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >   MAINTAINERS                    |  1 +
> >   include/linux/time_namespace.h |  1 +
> >   include/linux/vdso_datastore.h | 10 +++++
> >   include/vdso/datapage.h        | 69 +++++++++++++++++++++++++----
> >   lib/Kconfig                    |  1 +
> >   lib/Makefile                   |  2 +
> >   lib/vdso_kernel/Kconfig        |  7 +++
> >   lib/vdso_kernel/Makefile       |  3 ++
> >   lib/vdso_kernel/datastore.c    | 99 ++++++++++++++++++++++++++++++++++++++++++
> 
> There is only one single file, namely datastore.c. You don't need a new
> directory for that, I should go in lib/vdso/

lib/vdso/ currently only contains userspace code.
I don't have a strong opinion on that.
The lib/vdso_kernel location was suggested by tglx, maybe he has some
feedback. (Originally I put it into kernel/vdso_storage.c)

[..]

> > +enum vdso_pages {
> > +	VDSO_TIME_PAGE_OFFSET,
> > +	VDSO_TIMENS_PAGE_OFFSET,
> > +	VDSO_NR_PAGES
> > +};
> 
> Naming that VDSO_ is confusing. Most macros called VDSO_ are related to the
> VDSO Code. VDSO data related macros should be prefixed with VVAR_

Also a request from tglx.

[..]


Thanks!
Thomas

