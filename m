Return-Path: <linux-arch+bounces-7823-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624F1994457
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 11:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAEF2840A2
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 09:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F260417C9E9;
	Tue,  8 Oct 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XYRYWS+z"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869711667DA;
	Tue,  8 Oct 2024 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379945; cv=none; b=E2tjqs1lvZl7rvMwFas6/bFJ9zwAyzY265ih0XtEMrL3vftGpRSDflA60KD2L/TAtUoCWWyfneS8s4Ne0X7iyBtTYbpogBSshyApvavqtGGPIQD98oJF2siUL1oVi5rEC6EueEWaUY4q4J08GOBWIdph/ElBA/4D0axDpg3zRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379945; c=relaxed/simple;
	bh=DtNUvaG5aVRQZwY0O9ZpeWHToiPPIKHxJRMBlZXkudw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKS+pAOXzT3gEFjxtMeySaszEAofHpp5gZ/sT+H3gct8bFdbte1/zwlsZU95yLhPTfXlFZcmn3cupuj6fnVxVebxaWJgHRAvJq4u+30l0ZHPH0qe000rM576Yghu+RCZ6DIzYUEA1tEkc8fE1+6XoMKSwIAVzuNn5XCeDSfYj8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XYRYWS+z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xyGcAKqyXdq1kSPPIkmS99LVfnBS63wwbbsowm8iq4M=; b=XYRYWS+z8RIT/Be1e2fyTGrd8w
	OBh+/6Eu8oetgJeuRXO6F/qwYxKs93aV+jSBfCUQZUZJuwswFVdCV8cfUI/KPCr+hpqzu915OEm38
	tOkHhS0ZfpNycGScxB0pgnhWhUBXr1err78VRrD3tQLvcSDFYWQtqqJBzV69jpNmY/3khV+Co/aDq
	VAIA7JLYOQlPeuZkAryO/CFCwR0gDMl3wekA74MHSI/HWLqOt0qqjilQGRw9Le8RRVAnc6G4GFaDe
	TxfCMXqTAfi6s1U0TizGEdFRJSL/eLiVdQlFOPtJnNWrO9Y0b6Ay4himMovud1gGUhvuJOVQDhQDk
	z93gEE8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy6ZW-00000005Jsk-3rIF;
	Tue, 08 Oct 2024 09:32:02 +0000
Date: Tue, 8 Oct 2024 02:32:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Julian Vetter <jvetter@kalrayinc.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-sound@vger.kernel.org,
	Yann Sionneau <ysionneau@kalrayinc.com>
Subject: Re: [PATCH v8 01/14] Consolidate IO memcpy/memset into iomap_copy.c
Message-ID: <ZwT8EjvlknRYeDas@infradead.org>
References: <20241008075023.3052370-1-jvetter@kalrayinc.com>
 <20241008075023.3052370-2-jvetter@kalrayinc.com>
 <a9fa56b4-b00c-4941-8c8c-1d3b58b573e2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9fa56b4-b00c-4941-8c8c-1d3b58b573e2@app.fastmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 08, 2024 at 09:27:20AM +0000, Arnd Bergmann wrote:
> >  #endif /* CONFIG_TRACE_MMIO_ACCESS */
> > 
> > +extern void memcpy_fromio(void *to, const volatile void __iomem *from,
> > +			  size_t count);
> > +extern void memcpy_toio(volatile void __iomem *to, const void *from,
> > +			size_t count);
> > +extern void memset_io(volatile void __iomem *dst, int c, size_t count);
> > +
> 
> I think having this globally visible is the reason you are running
> into the mismatched prototypes.

Yes, especially as architectures sometimes actually implement this
as macro or inline function.

Please also drop the pointless externs while you're at it.


