Return-Path: <linux-arch+bounces-1752-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2421840311
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 11:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BF7281A17
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 10:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E15953804;
	Mon, 29 Jan 2024 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMCZsM+B"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451E56746
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525024; cv=none; b=Y8isHqVBeYt4PnfXVebedu/Pi30Z+D+gWcOq1xBg7dU3zxNQfTDtnT/WlYXkxH3BxhOtctaHoSgIyc/b3w4xall7lMT4Hq1rYIOYw1h2VMWncCS4MSQTSr/TqcPgZbF93baXf3+xbON7Lqee1WmpLP5GHecWFIXx57B7GdUTMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525024; c=relaxed/simple;
	bh=N2bxPQUC1J1vtqYsW8WScz0xwmg0bwjGhJBpZ+U5ha8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F7XrJ7gmvG6mrnuYyUCrD6R9RHlEoCP9NsC/2ahm5IzKA5Abn+rEGG9RoKJC3maAo6ocrUc9kR4KN2/m3U8aDYf9OMqcEVzZPr3WLaytkG0BdpUqbkzc5Pk6pgZ93wInX+ZC+y35z7JE5i/f2Ac4UMpjcU7xYD7Acs/iP3S6S+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMCZsM+B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706525021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2bxPQUC1J1vtqYsW8WScz0xwmg0bwjGhJBpZ+U5ha8=;
	b=IMCZsM+BIn969qcWfAeOupOb6GeaqAzqkMjSwU2Vrp/bZqg48OWb/kukGlnVjSF1gABSFn
	wiAQXaDMhNxNSSDIFfM2/9JRJcVOvmyhsPv0Is8s/eA3ZP2sUzMii9jT7kdhBW72bPVdO9
	gbexQeONFFGd3Qc9J34Yklfjc6O8hBo=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-pXxSgQ1DOg6duDm10GGkuA-1; Mon, 29 Jan 2024 05:43:40 -0500
X-MC-Unique: pXxSgQ1DOg6duDm10GGkuA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3be2fbb9fe7so172412b6e.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 02:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706525020; x=1707129820;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2bxPQUC1J1vtqYsW8WScz0xwmg0bwjGhJBpZ+U5ha8=;
        b=QCOkDI0wHroTJlQJa/q1ktyvdfI9r2Kb6zigAt2aM+CMrJ3loqpYX+iAWxg2XXVKAj
         2aozDC4k9cA6iCNsjFJXR9y4g6cZYn5ndJM7a9peH/GzI20BHb+8E7OpdDIN3fJoxwf4
         IiWCgs8bG/iGT8vrP2Dhys6/wJeAxoSDZUzQ6IiDUeDnb9gsP1gFmlvTXB9B+MQXpkAs
         fv46nZCObtZMuyYLIU/GJLxqTw79+PcdpOgzuhacosTXC7e5DphTLyv/8muPevnPVOmH
         eZPt1csdfIMHqieBG3JYAevDnIXpuXDIr7UQpdGKMr3lZZX7kUgmPafhwrIiyXnq0bHV
         wXiA==
X-Gm-Message-State: AOJu0YyjgubelYdpO+M0rFpv5lnJvbpOUOGCEaAF53krTYVV71ZW2BR5
	VsGX3AOP9XPn4M1KOYGTG0lKt2xPXfI7q2IygM8b8NTeDnQCT+jM9rw7QyW8Hj/aTIeCvOzL27h
	+TsVt8vC5EiAKSCviPPTY5fq0+JfU30334/D5Bp/nvay8pDDSlZj3lHnHwC8=
X-Received: by 2002:a05:6808:1890:b0:3be:453d:765f with SMTP id bi16-20020a056808189000b003be453d765fmr3937090oib.4.1706525019878;
        Mon, 29 Jan 2024 02:43:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO2zOKS6lAwPr6klWx/SbaYNfMO2LRTkErm5j3FcP+wZOQAycXhyUyED5d9/e/Rg97HkavqQ==
X-Received: by 2002:a05:6808:1890:b0:3be:453d:765f with SMTP id bi16-20020a056808189000b003be453d765fmr3937065oib.4.1706525019542;
        Mon, 29 Jan 2024 02:43:39 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id u7-20020a05622a17c700b00427ee66bec1sm3446499qtk.48.2024.01.29.02.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:43:39 -0800 (PST)
Message-ID: <e655978d5f06ca58f36d531a9f789420fe959fd1.camel@redhat.com>
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
Date: Mon, 29 Jan 2024 11:43:34 +0100
In-Reply-To: <20240127223926.GA461814@bhelgaas>
References: <20240127223926.GA461814@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-01-27 at 16:39 -0600, Bjorn Helgaas wrote:
> On Fri, Jan 26, 2024 at 02:59:20PM +0100, Philipp Stanner wrote:
> > On Tue, 2024-01-23 at 15:05 -0600, Bjorn Helgaas wrote:
> > > On Thu, Jan 11, 2024 at 09:55:40AM +0100, Philipp Stanner wrote:
> > ...
>=20
> > > > -void pci_iounmap(struct pci_dev *dev, void __iomem *p)
> > > > +/**
> > > > + * pci_iounmap - Unmapp a mapping
> > > > + * @dev: PCI device the mapping belongs to
> > > > + * @addr: start address of the mapping
> > > > + *
> > > > + * Unmapp a PIO or MMIO mapping.
> > > > + */
> > > > +void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> > >=20
> > > Maybe move the "p" to "addr" rename to the patch that fixes the
> > > pci_iounmap() #ifdef problem, since that's a trivial change that
> > > already has to do with handling both PIO and MMIO?=C2=A0 Then this
> > > patch
> > > would be a little more focused.
> > >=20
> > > The kernel-doc addition could possibly also move there since it
> > > isn't
> > > related to the unification.
> >=20
> > You mean the one from my devres-patch-series? Or documentation
> > specifically about pci_iounmap()?
>=20
> I had in mind the patch that fixes the pci_iounmap() #ifdef problem,
> which (if you split it out from 1/5) would be a relatively trivial
> patch.=C2=A0 Or the kernel-doc addition could be its own separate patch.
> The point is that this unification patch is fairly complicated, so
> anything we can do to move things unrelated to unification elsewhere
> makes this one easier to review.

I think it should be a separate patch, then, as it doesn't belong by
100% to any of the patches here. If I had to pick one, I'd have
included the docu into patch #2 or #3.

Let's make it a separate one, following as a 6th patch in this series

>=20
> > > It seems like implementing iomem_is_ioport() for the other arches
> > > would be straightforward and if done first, could make this patch
> > > look
> > > tidier.
> >=20
> > That would be the cleanest solution. But the cleaner you want to
> > be,
> > the more time you have to spend ;)
> > I can take another look and see if I could do that with reasonable
> > effort.
> > Otherwise I'd go for:
> >=20
> > > Or if the TODOs can't be done now, maybe the iomem_is_ioport()
> > > addition could be done as a separate patch to make the
> > > unification
> > > more obvious.
>=20
> It looks like iomem_is_ioport() is basically the guards in
> pci_iounmap() implementations that, if true, prevent calling
> iounmap(), so it it seems like they should be trivial, e.g.,
>=20
> =C2=A0 return !__is_mmio(addr); # alpha
>=20
> =C2=A0 return (addr < VMALLOC_START || addr >=3D VMALLOC_END); # arm
>=20
> =C2=A0 return isa_vaddr_is_ioport(addr) || pcibios_vaddr_is_ioport(addr);
> # microblaze
>=20
> Unless they're significantly more complicated than that, I don't see
> the point of deferring them.

Have you seen Arnd's reply from Friday?
Cleaning up Powerpc's use of lib/iomap.c will be significantly more
complicated.

This series' purpose actually always has been to move PCI functions to
where they belong, i.e. from lib/ to drivers/pci.
I originally didn't want to touch pci_iounmap(), since I deemed it too
complicated. Arnd pushed for unifying it.

Anyways, investing much more time into this is beyond my time budget. I
only started this series to have a cleaner basis to do the devres
functions.

So my suggestions is that we either go with this cleanup here, which
improves the situation at least somewhat, or we simply drop patch #5
and leave pci_iounmap() as the last pci_ function in lib/


P.

>=20
> > > > + */
> > > > +#if defined(ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT)
> > > > +bool iomem_is_ioport(void __iomem *addr)
> > > > =C2=A0{
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IO_COND(addr, /* nothing=
 */, iounmap(addr));
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long port =3D (=
unsigned long __force)addr;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (port > PIO_OFFSET &&=
 port < PIO_RESERVED)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return true;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
> > > > =C2=A0}
> > > > -EXPORT_SYMBOL(pci_iounmap);
> > > > -#endif /* CONFIG_PCI */
> > > > +#endif /* ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT */
> > > > --=20
> > > > 2.43.0
> > > >=20
> > >=20
> >=20
>=20


