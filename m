Return-Path: <linux-arch+bounces-1717-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3291483DB64
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 14:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFF5294B0F
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 13:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C938A1B974;
	Fri, 26 Jan 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpAJcVIz"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071FB1B961
	for <linux-arch@vger.kernel.org>; Fri, 26 Jan 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277568; cv=none; b=YmP2lJ1s5EIqMxA3ve5XpxjxRk1KSOrHc76hsKuX8DyjUpgiKD5EKArK2ifrgX7S7lU+5SJwGxeC3Kc+bEQ/JbfzmRgK+MbtDK4etFybE3A1C5wbwP8CXYShSpRzYyKLxvtc9ogctb9tDJWN2oHGNcO0o7PionbUxA/P+5ZMVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277568; c=relaxed/simple;
	bh=fJejqZYOfXgwK8F3Hxl8RSz24iyChMNUrblvezh1xxo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aIu5Ap1aCTUdmAyGjw2fqPAj8Z9lwf41r650YBo8f9ttOpJFhe9V78kC9QriNz5LKXV1xGOC2QzLKQNUfTF+gXp3AG3E+tnqf0L955xB7sb2KwbrIFDbxKZdEkT8yv/Cz+D7A4VISow+3s6ZaJ09mF9kIN0YmrqnW6YRpQkC8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpAJcVIz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706277566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0rNh/dyL0TEUa+CbzPgZ/Hn2/8Lct1V89YIfXFANJkQ=;
	b=PpAJcVIzHwFdokNrIxOChpNeTEaQoAHrZf+b39idm0IEUXQm9sXmmIyPqNR4gD5IRdEPkO
	4NfHZBQ/TU6hUgdCD+Q0Dsq0IUBb9nidgKaWYjE/8OCTUv03AC61ywOcZgrMjqrpT21QNz
	p2jwnKVP+eP0/LKtQe0twEy/CfUTZ+Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-eBALpEVVOiebzQ1pp6cqOA-1; Fri, 26 Jan 2024 08:59:24 -0500
X-MC-Unique: eBALpEVVOiebzQ1pp6cqOA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3160e7dfcbso5238766b.1
        for <linux-arch@vger.kernel.org>; Fri, 26 Jan 2024 05:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706277563; x=1706882363;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0rNh/dyL0TEUa+CbzPgZ/Hn2/8Lct1V89YIfXFANJkQ=;
        b=ck1gj6WIedMnd/2ZYbi8QiG3bE96gz1wZ5mg2245V2LQyuCCtk659sLXOuchBWJ8ia
         oFuXNQH6bnTgAIeuZur8LoqxL+Id/Rjep2kb7hQfVwm7MsYc6LGZ5+m52/wv1hn4COSx
         KU+muu8RvKdl8lisUEPYd3aUKI/XTYJn85RVXe+Qd75RKpPFgZ3PCuOBSyaAH1mRmkS3
         1YIgP5mR8QK13cs4O91vQGSXMmd3w0LRvphBf2LxWxYHn5/SnrKJu9gzxrMWWBAvxzA2
         ZE9TiPNLgb2SUVh0MVFpiBisfJlBp+m/vUic1g0oEblwflOJ6iK5O50nekOz4T8eJaUk
         8zjQ==
X-Gm-Message-State: AOJu0YySIaktouKfE2xl27A8jwS7GvOpgmKK3kBHpNI7XF1jc2Go0CEp
	WJo2lkIkGOBFFXSixE0zUeJCuWBD/Uk0KnjBIKr2zDUoHYOPrNj6OvMf1z197/Rqjik1A/OZfPq
	uLN7ohjSTE4ibDv2rE2ItBCYRWs6D1/9Q1UR5SuZxTugJEDDHEIhseYlJ0ns=
X-Received: by 2002:a17:906:4948:b0:a31:410a:18e4 with SMTP id f8-20020a170906494800b00a31410a18e4mr1687816ejt.4.1706277563114;
        Fri, 26 Jan 2024 05:59:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0BRR4OBp1G9wImLm/ETkLCDi3wAIz3dL10kd4WAqDMvqh3I6OUmDukvt2Qv+RCnofw4jcOg==
X-Received: by 2002:a17:906:4948:b0:a31:410a:18e4 with SMTP id f8-20020a170906494800b00a31410a18e4mr1687795ejt.4.1706277562739;
        Fri, 26 Jan 2024 05:59:22 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32d0:ca00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id n24-20020a170906841800b00a32abfbcd6asm661415ejx.31.2024.01.26.05.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 05:59:22 -0800 (PST)
Message-ID: <70b8db3ec0f8730fdd23dae21edc1a93d274b048.camel@redhat.com>
Subject: Re: [PATCH v5 RESEND 5/5] lib, pci: unify generic pci_iounmap()
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Johannes Berg <johannes@sipsolutions.net>, Randy Dunlap
 <rdunlap@infradead.org>, NeilBrown <neilb@suse.de>,  John Sanpe
 <sanpeqf@gmail.com>, Kent Overstreet <kent.overstreet@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Dave Jiang <dave.jiang@intel.com>,
 Uladzislau Koshchanka <koshchanka@gmail.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, David Gow <davidgow@google.com>, Kees Cook
 <keescook@chromium.org>, Rae Moar <rmoar@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "wuqiang.matt" <wuqiang.matt@bytedance.com>, Yury
 Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>, Thomas
 Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>,
 dakr@redhat.com, linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, stable@vger.kernel.org,  Arnd Bergmann
 <arnd@kernel.org>
Date: Fri, 26 Jan 2024 14:59:20 +0100
In-Reply-To: <20240123210553.GA326783@bhelgaas>
References: <20240123210553.GA326783@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-23 at 15:05 -0600, Bjorn Helgaas wrote:
> On Thu, Jan 11, 2024 at 09:55:40AM +0100, Philipp Stanner wrote:
> > The implementation of pci_iounmap() is currently scattered over two
> > files, drivers/pci/iomap.c and lib/iomap.c. Additionally,
> > architectures can define their own version.
> >=20
> > To have only one version, it's necessary to create a helper
> > function,
> > iomem_is_ioport(), that tells pci_iounmap() whether the passed
> > address
> > points to an ioport or normal memory.
> >=20
> > iomem_is_ioport() can be provided through two different ways:
> > =C2=A0 1. The architecture itself provides it. As of today, the version
> > =C2=A0=C2=A0=C2=A0=C2=A0 coming from lib/iomap.c de facto is the x86-sp=
ecific version
> > and
> > =C2=A0=C2=A0=C2=A0=C2=A0 comes into play when CONFIG_GENERIC_IOMAP is s=
elected. This
> > rather
> > =C2=A0=C2=A0=C2=A0=C2=A0 confusing naming is an artifact left by the re=
moval of IA64.
> > =C2=A0 2. As a default version in include/asm-generic/io.h for those
> > =C2=A0=C2=A0=C2=A0=C2=A0 architectures that don't use CONFIG_GENERIC_IO=
MAP, but also
> > don't
> > =C2=A0=C2=A0=C2=A0=C2=A0 provide their own version of iomem_is_ioport()=
.
> >=20
> > Once all architectures that support ports provide
> > iomem_is_ioport(), the
> > arch-specific definitions for pci_iounmap() can be removed and the
> > archs
> > can use the generic implementation, instead.
> >=20
> > Create a unified version of pci_iounmap() in drivers/pci/iomap.c.
> > Provide the function iomem_is_ioport() in include/asm-generic/io.h
> > (generic) and lib/iomap.c ("pseudo-generic" for x86).
> >=20
> > Remove the CONFIG_GENERIC_IOMAP guard around
> > ARCH_WANTS_GENERIC_PCI_IOUNMAP so that configs that set
> > CONFIG_GENERIC_PCI_IOMAP without CONFIG_GENERIC_IOMAP still get the
> > function.
> >=20
> > Add TODOs for follow-up work on the "generic is not generic but
> > x86-specific"-Problem.
> > ...
>=20
> > +++ b/drivers/pci/iomap.c
> > @@ -135,44 +135,30 @@ void __iomem *pci_iomap_wc(struct pci_dev
> > *dev, int bar, unsigned long maxlen)
> > =C2=A0EXPORT_SYMBOL_GPL(pci_iomap_wc);
> > =C2=A0
> > =C2=A0/*
> > - * pci_iounmap() somewhat illogically comes from lib/iomap.c for
> > the
> > - * CONFIG_GENERIC_IOMAP case, because that's the code that knows
> > about
> > - * the different IOMAP ranges.
> > + * This check is still necessary due to legacy reasons.
> > =C2=A0 *
> > - * But if the architecture does not use the generic iomap code,
> > and if
> > - * it has _not_ defined it's own private pci_iounmap function, we
> > define
> > - * it here.
> > - *
> > - * NOTE! This default implementation assumes that if the
> > architecture
> > - * support ioport mapping (HAS_IOPORT_MAP), the ioport mapping
> > will
> > - * be fixed to the range [ PCI_IOBASE, PCI_IOBASE+IO_SPACE_LIMIT
> > [,
> > - * and does not need unmapping with 'ioport_unmap()'.
> > - *
> > - * If you have different rules for your architecture, you need to
> > - * implement your own pci_iounmap() that knows the rules for where
> > - * and how IO vs MEM get mapped.
> > - *
> > - * This code is odd, and the ARCH_HAS/ARCH_WANTS #define logic
> > comes
> > - * from legacy <asm-generic/io.h> header file behavior. In
> > particular,
> > - * it would seem to make sense to do the iounmap(p) for the non-
> > IO-space
> > - * case here regardless, but that's not what the old header file
> > code
> > - * did. Probably incorrectly, but this is meant to be bug-for-bug
> > - * compatible.
>=20
> Moving this comment update to the patch that adds the ioport_unmap()
> call would make that patch more consistent and simplify this patch.

The bugfix from patch #1 you mean.
I can take care of that when splitting that patch as you suggested


>=20
> > + * TODO: Have all architectures that provide their own
> > pci_iounmap() provide
> > + * iomem_is_ioport() instead. Remove this #if afterwards.
> > =C2=A0 */
> > =C2=A0#if defined(ARCH_WANTS_GENERIC_PCI_IOUNMAP)
> > =C2=A0
> > -void pci_iounmap(struct pci_dev *dev, void __iomem *p)
> > +/**
> > + * pci_iounmap - Unmapp a mapping
> > + * @dev: PCI device the mapping belongs to
> > + * @addr: start address of the mapping
> > + *
> > + * Unmapp a PIO or MMIO mapping.
>=20
> s/Unmapp/Unmap/ (twice)

OK

>=20
> > + */
> > +void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
>=20
> Maybe move the "p" to "addr" rename to the patch that fixes the
> pci_iounmap() #ifdef problem, since that's a trivial change that
> already has to do with handling both PIO and MMIO?=C2=A0 Then this patch
> would be a little more focused.

OK

>=20
> The kernel-doc addition could possibly also move there since it isn't
> related to the unification.

You mean the one from my devres-patch-series? Or documentation
specifically about pci_iounmap()?

>=20
> > =C2=A0{
> > -#ifdef ARCH_HAS_GENERIC_IOPORT_MAP
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uintptr_t start =3D (uintptr=
_t) PCI_IOBASE;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uintptr_t addr =3D (uintptr_=
t) p;
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (addr >=3D start && addr =
< start + IO_SPACE_LIMIT) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ioport_unmap(p);
> > +#ifdef CONFIG_HAS_IOPORT_MAP
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (iomem_is_ioport(addr)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ioport_unmap(addr);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0#endif
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iounmap(p);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iounmap(addr);
> > =C2=A0}
>=20
> > + * If CONFIG_GENERIC_IOMAP is selected and the architecture does
> > NOT provide its
> > + * own version, ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT makes sure that
> > the generic
> > + * version from asm-generic/io.h is NOT used and instead the
> > second "generic"
> > + * version from this file here is used.
> > + *
> > + * There are currently two generic versions because of a difficult
> > cleanup
> > + * process. Namely, the version in lib/iomap.c once was really
> > generic when IA64
> > + * still existed. Today, it's only really used by x86.
> > + *
> > + * TODO: Move this function to x86-specific code.
>=20
> Some of these TODOs look fairly simple.=C2=A0 Are they actually hard, or
> could they just be done now?

If they were simple from my humble POV I would have implemented them.
The information about the x86-specficity is from Arnd Bergmann, the
header-maintainer.

I myself am not that sure how much work it would be to move the entire
lib/iomap.c file to x86. At least some (possibley "dead") hooks to it
still exist, for example here:
arch/powerpc/platforms/Kconfig  # L.189

>=20
> It seems like implementing iomem_is_ioport() for the other arches
> would be straightforward and if done first, could make this patch
> look
> tidier.

That would be the cleanest solution. But the cleaner you want to be,
the more time you have to spend ;)
I can take another look and see if I could do that with reasonable
effort.
Otherwise I'd go for:

> Or if the TODOs can't be done now, maybe the iomem_is_ioport()
> addition could be done as a separate patch to make the unification
> more obvious.

sic

Thx,
P.

>=20
> > + */
> > +#if defined(ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT)
> > +bool iomem_is_ioport(void __iomem *addr)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IO_COND(addr, /* nothing */,=
 iounmap(addr));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long port =3D (unsi=
gned long __force)addr;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (port > PIO_OFFSET && por=
t < PIO_RESERVED)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return true;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
> > =C2=A0}
> > -EXPORT_SYMBOL(pci_iounmap);
> > -#endif /* CONFIG_PCI */
> > +#endif /* ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT */
> > --=20
> > 2.43.0
> >=20
>=20


