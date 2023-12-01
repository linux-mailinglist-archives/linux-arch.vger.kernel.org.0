Return-Path: <linux-arch+bounces-606-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D7680139B
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 20:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7353B211D2
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 19:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E5051006;
	Fri,  1 Dec 2023 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bApsYd/z"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6D710F0
	for <linux-arch@vger.kernel.org>; Fri,  1 Dec 2023 11:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701459482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/l/6GujMYtdeF8lFtocp3i7GfbxtCh5Sv6fX69W1IJI=;
	b=bApsYd/zRcv3vnSsRsF9VCnII1JwLfPDm+qIX4UBwCRxRcZDH85INYYajfWJICI14Kxii0
	vjZvTKc8B4ivHzeRMkVuliJFIjuQfmKC7rGW1DQg46Pn0g+y8/I/YvESLQczkIjM0MikVA
	3QQdzpPbioUoKnUzRwvungq6cU4J5+U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-cSVK6-pkNnS75G1wEfopaw-1; Fri, 01 Dec 2023 14:38:01 -0500
X-MC-Unique: cSVK6-pkNnS75G1wEfopaw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-423f2ad71c9so6502021cf.0
        for <linux-arch@vger.kernel.org>; Fri, 01 Dec 2023 11:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701459481; x=1702064281;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/l/6GujMYtdeF8lFtocp3i7GfbxtCh5Sv6fX69W1IJI=;
        b=hoWdKVnE8Q8yMLarokELrt2XCWN9+HSEEzhR6CcYCt4nQ7NAjwvTajZ6xjF6e4mf5d
         XW+KolsySb0uPGx9j7sLF8OlOU0ZxVHOVk55ASndw7gAOwPCTMO0AT9IT96gTueDNZ9z
         7q0+YrMm7De0T5FlbRIqSngvTfaKAK92gJ0u/A6r7ouCgVnmRW9FcUtmod1CP+IK3aC4
         UJfzUsLRzV+9LSuvVX6QD73CCN1331uF0Bv8ZrRysol3lyNY/tkhbQZjsHva4QN1JUhj
         QsnXXRqppQqg5VYTV7X0jfBohWZfGcp5mn8TjSxdn7LWIQR3BGUjtXnhaCrW7XqYavsM
         3cKQ==
X-Gm-Message-State: AOJu0YzfSLj68mEx3f9HRio8WqxfvCcaQVLJZgDV4qP61K1Mf21dUgE7
	Sx7gnnerz2PAQMYdg7EELNYejjZfHi63PevUBX4r+xRebkkgIX4JkinNnHThVqCb381ljQhaoGQ
	fhZBbi55g3DOYrKrHaLz+Qg==
X-Received: by 2002:a05:622a:1e1a:b0:403:c2fa:83b with SMTP id br26-20020a05622a1e1a00b00403c2fa083bmr31754621qtb.4.1701459480776;
        Fri, 01 Dec 2023 11:38:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXM5smqFVtFSkDyfako0lqL1REl/dMKFL24sZp/a3CqSd9LT5tE3kYqB2s34OlKW2JfQLGzw==
X-Received: by 2002:a05:622a:1e1a:b0:403:c2fa:83b with SMTP id br26-20020a05622a1e1a00b00403c2fa083bmr31754605qtb.4.1701459480410;
        Fri, 01 Dec 2023 11:38:00 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e2:4e00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id v4-20020ac87484000000b00423a5ea2a0asm1746091qtq.20.2023.12.01.11.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:38:00 -0800 (PST)
Message-ID: <b54e5d57624dae0b045d8ff129ac2a41f72e182d.camel@redhat.com>
Subject: Re: [PATCH v2 4/4] lib, pci: unify generic pci_iounmap()
From: Philipp Stanner <pstanner@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dan Williams
 <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jakub Kicinski <kuba@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Uladzislau Koshchanka <koshchanka@gmail.com>, Neil Brown <neilb@suse.de>,
 Niklas Schnelle <schnelle@linux.ibm.com>, John Sanpe <sanpeqf@gmail.com>, 
 Kent Overstreet <kent.overstreet@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, David Gow
 <davidgow@google.com>, Yury Norov <yury.norov@gmail.com>, "wuqiang.matt"
 <wuqiang.matt@bytedance.com>, Jason Baron <jbaron@akamai.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Danilo
 Krummrich <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Linux-Arch
	 <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>
Date: Fri, 01 Dec 2023 20:37:55 +0100
In-Reply-To: <619ea619-29e4-42fb-9b27-1d1a32e0ee66@app.fastmail.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
	 <20231201121622.16343-5-pstanner@redhat.com>
	 <619ea619-29e4-42fb-9b27-1d1a32e0ee66@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-01 at 16:26 +0100, Arnd Bergmann wrote:
> On Fri, Dec 1, 2023, at 13:16, Philipp Stanner wrote:
> > The implementation of pci_iounmap() is currently scattered over two
> > files, drivers/pci/iounmap.c and lib/iomap.c. Additionally,
> > architectures can define their own version.
> >=20
> > Besides one unified version being desirable in the first place, the
> > old
> > version in drivers/pci/iounmap.c contained a bug and could leak
> > memory
> > mappings. The bug was that #ifdef ARCH_HAS_GENERIC_IOPORT_MAP
> > should not
> > have guarded iounmap(p); in addition to the preceding code.
> >=20
> > To have only one version, it's necessary to create a helper
> > function,
> > iomem_is_ioport(), that tells pci_iounmap() whether the passed
> > address
> > points to an ioport or normal memory.
> >=20
> > iomem_is_ioport() can be provided through three different ways:
> > =C2=A0 1. The architecture itself provides it.
> > =C2=A0 2. As a default version in include/asm-generic/io.h for those
> > =C2=A0=C2=A0=C2=A0=C2=A0 architectures that don't use CONFIG_GENERIC_IO=
MAP, but also
> > don't
> > =C2=A0=C2=A0=C2=A0=C2=A0 provide their own version of iomem_is_ioport()=
.
> > =C2=A0 3. As a default version in lib/iomap.c for those architectures
> > that
> > =C2=A0=C2=A0=C2=A0=C2=A0 define and use CONFIG_GENERIC_IOMAP (currently=
, only x86
> > really
> > =C2=A0=C2=A0=C2=A0=C2=A0 uses the functions in lib/iomap.c)
>=20
> I would count 3 as a special case of 1 here.

ACK

>=20
> > Create a unified version of pci_iounmap() in drivers/pci/iomap.c.
> > Provide the function iomem_is_ioport() in include/asm-generic/io.h
> > and
> > lib/iomap.c.
> >=20
> > Remove the CONFIG_GENERIC_IOMAP guard around
> > ARCH_WANTS_GENERIC_PCI_IOUNMAP so that configs that set
> > CONFIG_GENERIC_PCI_IOMAP without CONFIG_GENERIC_IOMAP still get the
> > function.
> >=20
> > Fixes: 316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make
> > sense of it all")
> > Suggested-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>=20
> Looks good overall. It would be nice to go further than this
> and replace all the custom pci_iounmap() variants with custom
> iomem_is_ioport() implementations, but that can be a follow-up
> along with removing the incorrect or useless 'select GENERIC_IOMAP'
> parts.

Yes, let's schedule that for a follow up. The way my project plans
sound currently, it's likely that I'll stay close to PCI for the next
months anyways, so it's likely we'll get an opportunity to pick this up
on the run

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iounmap(p);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0#endif
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iounmap(addr);
> > =C2=A0}
>=20
> I think the bugfix should be a separate patch so we can backport
> it to stable kernels.

ACK, good idea

>=20
> > +#ifndef CONFIG_GENERIC_IOMAP
> > +static inline bool iomem_is_ioport(void __iomem *addr)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long port =3D (unsi=
gned long __force)addr;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// TODO: do we have to take =
IO_SPACE_LIMIT and PCI_IOBASE
> > into account
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// similar as in ioport_map(=
) ?
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (port > MMIO_UPPER_LIMIT)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return false;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return true;
> > +}
>=20
> This has to have the exact logic that was present in the
> old pci_iounmap(). For the default version that is currently
> in lib/pci_iomap.c, this means something along the linens of

OK, I see, so iomem_is_ioport() takes the form derived from
lib/pci_iomap.c for asm-generic/io.h, and the form of lib/iomap.c for
the one in lib/iomap.c (obviously)

>=20
> static inline bool struct iomem_is_ioport(void __iomem *p)
> {
> #ifdef CONFIG_HAS_IOPORT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t start =3D (uintptr_t=
) PCI_IOBASE;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t addr =3D (uintptr_t)=
 p;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (addr >=3D start && addr < =
start + IO_SPACE_LIMIT)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return true;
> #endif
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> }
>=20
> > +#else /* CONFIG_GENERIC_IOMAP. Version from lib/iomap.c will be
> > used.=20
> > */
> > +bool iomem_is_ioport(void __iomem *addr);
> > +#define ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT
>=20
> I'm not sure what this macro is for, since it appears to
> do the opposite of what its name suggests: rather than
> provide the generic version of iomem_is_ioport(), it
> skips that and provides a custom one to go with lib/iomap.c

Hmmm well now it's getting tricky.

This else-branch is the one where CONFIG_GENERIC_IOMAP is actually set.

I think we're running into the "generic not being generic now that IA64
has died" problem you were hinting at.

If we build for x86 and have CONFIG_GENERIC set, only then do we want
iomem_is_ioport() from lib/iomap.c. So the macro serves avoiding a
collision between symbols. Because lib/iomap.c might be compiled even
if someone else already has defined iomem_is_ioport().
I also don't like it, but it was the least bad solution I could come up
with
Suggestions?


P.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20


