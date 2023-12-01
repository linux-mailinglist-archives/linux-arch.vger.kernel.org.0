Return-Path: <linux-arch+bounces-605-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C14801367
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 20:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 155BDB211B7
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 19:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB994E615;
	Fri,  1 Dec 2023 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPH7xy98"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93E810DA
	for <linux-arch@vger.kernel.org>; Fri,  1 Dec 2023 11:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701457798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPgX2vuUcASoWFoD2/jgg/jyDeKYMt7bHlJcifpLFYM=;
	b=hPH7xy98UQe/Z1zvWTpfPMcVbTtBwE90Mi29JBJbujwx+I0yhPeYO7YQ5J9C3Va5UqzWDw
	KUgkK6oQSZ3Ad9lDW8JWGTeNs3NFLhdKS/+edJqVyqHhomyD34TGba0YKugdnqTz0LO63Q
	3adxBtCrI08vUjyGBL9pKkVkbA0431E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-aw8uPH-5MDGSTNuqkzo5mg-1; Fri, 01 Dec 2023 14:09:56 -0500
X-MC-Unique: aw8uPH-5MDGSTNuqkzo5mg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50aa1d582e5so640531e87.1
        for <linux-arch@vger.kernel.org>; Fri, 01 Dec 2023 11:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701457795; x=1702062595;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPgX2vuUcASoWFoD2/jgg/jyDeKYMt7bHlJcifpLFYM=;
        b=ehvvJH88XY2223hK5KKau8sGqpA+5xho/vpnRz6MFUJAe4y1lTGzoj68xmaZK3hWeR
         gQaDL1/hZ4J2ncT42YCtavmrFXm5dF+GX7wKoAFjg0eyzd8UhI7wGsdsYSGe3Yge7US5
         c/W9qPL/FAqGapCHyPNwnu8WAbhsfCFwI2ZHdO0G3tHuEqAFJSCWjLxqWdAcXFKOOl/v
         11GTDYZxi817iHByNrx+YpR74z4tBkCvFB5sMrMYbanVYLJ9S6542aWfJulyOR8Tl6r2
         O11Rd3mXjq6ge/qMMn2i7n2ouw1T9BfXcJoZRZmWUF2BIwcDyDQUOi0hQVY+jiMxE4cI
         L5Zw==
X-Gm-Message-State: AOJu0Yzf5HvDPnDBe0CzPSij4aIH0Tw6A5S1bGEuTcevnSgCR89ZnJB0
	6oW9T23L+yD5Jt/1vlonP9NSE52roONpxBBcL/gROYJ/6W8ZyjUhzzqvQNVvtfXL0cK9y7BkHiI
	iR4GnK9SfSRVcfTH7l9azqg==
X-Received: by 2002:ac2:4e08:0:b0:50b:d0e3:c965 with SMTP id e8-20020ac24e08000000b0050bd0e3c965mr4242449lfr.5.1701457794775;
        Fri, 01 Dec 2023 11:09:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+pFXhJJ2U8EV+mvP9hBFsmKL2W6+GEdgWEYBMyR0sJ00sdylPYR3zzG7P9Uoj9MXt+F0MYA==
X-Received: by 2002:ac2:4e08:0:b0:50b:d0e3:c965 with SMTP id e8-20020ac24e08000000b0050bd0e3c965mr4242416lfr.5.1701457794394;
        Fri, 01 Dec 2023 11:09:54 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e2:4e00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b004083a105f27sm9785776wmo.26.2023.12.01.11.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:09:54 -0800 (PST)
Message-ID: <65079f6d5f512f9aff003bdfea127b214a9f9290.camel@redhat.com>
Subject: Re: [PATCH v2 0/4] Regather scattered PCI-Code
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
	 <linux-arch@vger.kernel.org>, pstanner@redhat.com
Date: Fri, 01 Dec 2023 20:09:51 +0100
In-Reply-To: <3871b83a-0e80-402e-bbe6-359c17127842@app.fastmail.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
	 <3871b83a-0e80-402e-bbe6-359c17127842@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-01 at 17:27 +0100, Arnd Bergmann wrote:
> On Fri, Dec 1, 2023, at 13:16, Philipp Stanner wrote:
> >=20
> > Arnd has suggested that architectures defining a custom inb() need
> > their
> > own iomem_is_ioport(), as well. I've grepped for inb() and found
> > the
> > following list of archs that define their own:
> > =C2=A0 - alpha
> > =C2=A0 - arm
> > =C2=A0 - m68k <--
> > =C2=A0 - parisc
> > =C2=A0 - powerpc
> > =C2=A0 - sh
> > =C2=A0 - sparc
> > =C2=A0 - x86 <--
> >=20
> > All of those have their own definitons of pci_iounmap(). Therefore,
> > they
> > don't need our generic version in the first place and, thus, also
> > need
> > no iomem_is_ioport().
>=20
> What I meant of course is that they should define iomem_is_ioport()
> in order to drop the custom pci_iounmap() and have only one remaining
> definition of that function left.

Ah, gotcha!
Yes, that would be neat. Would also allow for droping
ARCH_WANTS_GENERIC_PCI_IOUNMAP.

>=20
> The one special case that I missed the last time is s390, which
> does not use GENERIC_PCI_IOMAP and will just require a separate
> copy of pci_iounmap() to go along with the is custom pci_iomap().
>=20
> > The two exceptions are x86 and m68k. The former uses lib/iomap.c
> > through
> > CONFIG_GENERIC_IOMAP, as Arnd pointed out in the previous
> > discussion
> > (thus, CONFIG_GENERIC_IOMAP is not really generic in this regard).
> >=20
> > So as I see it, only m68k WOULD need its own custom definition of
> > iomem_is_ioport(). But as I understand it it doesn't because it
> > uses the
> > one from asm-generic/pci_iomap.h ??
>=20
> At the moment, m68k gets the pci_iounmap() from lib/iomap.c
> if PCI is enabled for coldfire, but that incorrectly calls
> iounmap() on PCI_IO_PA if it gets passed a PIO address.
>=20
> The version from asm-generic/io.h should fix this.

So, to be sure: m68k will use the generic iomem_is_ioport() despite
defining its own inb()?

>=20
> For classic m68k, there is no PCI, so nothing calls pci_iounmap().
>=20
> > I wasn't entirely sure how to deal with the address ranges for the
> > generic implementation in asm-generic/io.h. It's marked with a
> > TODO.
> > Input appreciated.
>=20
> I commented on the function directly. To clarify, I think we should
> be able to directly turn each pci_iounmap() definition into
> a iomem_is_ioport() definition by keeping the logic unchanged
> and just return 'true' for the PIO variant or 'false' for the MMIO
> version.
>=20
> > I removed the guard around define pci_iounmap in asm-generic/io.h.
> > An
> > alternative would be to have it be guarded by CONFIG_GENERIC_IOMAP
> > and
> > CONFIG_GENERIC_PCI_IOMAP, both. Without such a guard, there is no
> > collision however, because generic pci_iounmap() from
> > drivers/pci/iomap.c will only get pulled in when
> > CONFIG_GENERIC_PCI_IOMAP is actually set.
>=20
> The "#define pci_iomap" can be removed entirely I think.

I also think it can, because first arch/asm/io.h includes asm-
generic/io.h.
I was just wondering why many other functions in asm-generic/io.h
always define their own names..

It's obviously very hard to test which config will break, so I thought
it's better safe than sorry here

P.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20


