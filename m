Return-Path: <linux-arch+bounces-12295-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25415AD2969
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 00:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A017A7CAA
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 22:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F238223DC9;
	Mon,  9 Jun 2025 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi2/HbR6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784503597B;
	Mon,  9 Jun 2025 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749508613; cv=none; b=DDXzXlQvI+zc8psKYA/f4U0dAtyhXNeicFvV47+kh2wKYJsmNLgiHfPKbfH68sXMLdSkb20mgLi6XyJZx+N1WT83i5G+rOgZSRyUXC5a3kdVNL6nT4xT7xWnT1VP1sSqzHYN8lWJ5tKnD1WBgB1tTqVH7HEU8u62/ZoRHBNXJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749508613; c=relaxed/simple;
	bh=zDKYNbdF0rH3+FimkZczocsoz+9nXxDjaYj98TTwVZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xi7LItcGrdh5Q+bd9ERJdyjW4Aw0QigJZyl1BAn9N0U2/PUBYKWf/ekzgQauwQ5Om2twOcwSsXnaxdvbx0BB83Hr1PsforDTetqzdIN3vZSEGoAp/XNNU/ahdJbznTrBD+dzctbvYjFX4Rm4wvUM8ERCc5G5XYJb3MKYNIPL+2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi2/HbR6; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a43cbc1ab0so58952611cf.0;
        Mon, 09 Jun 2025 15:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749508610; x=1750113410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hq0btBK5TQK/jQfASAZ7ArH/Py2u4qhWqQQYIBxtEI=;
        b=Gi2/HbR6MYHWkFxwVMBbDFwZMjBT+aygp8CDf4Ur9uSyIGGJQZ/+mJTcP1V43cnXE5
         QCW9fPrTvKxKXEHjkoXlHrsRraUcSB2qOkkiaATh6DtzUSR2HhA5w43YQUDpPOCUj7f7
         yr8BtRncOVR1Oz0IZZv50J86+AfA/lgPGc6XCl2oU4gs+HhdcA3c0sqPlHKS1fQRZ/b/
         yufAdKbPlVEtXk8hhTXv1BqphryIEtW5PoNOKd4lEstzHVuGCiP6XfRmMbVABW+1lMym
         XOb1g1KVjin6yAPj3RM3x1Oi8zQQMyoCXpNMNWPiILCWw1EQTreCcFuFk7Z7+p05KEt2
         soZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749508610; x=1750113410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hq0btBK5TQK/jQfASAZ7ArH/Py2u4qhWqQQYIBxtEI=;
        b=G0yYnEx6R/XsM9DoXvWk9oJXOVwZFWmgy/gguMTPtDGHEMw1KX78hxTak1cqS8qrW3
         rLEYeyBxqd1mg5Ij2mxHasIRgZ8wmTstBcgXHwTU0TRFFIDtmUNEEhTwLw8yO9MqmOHf
         bct9BH8NSw/sssM9e5sGuoncrqODQFWKLCE+VUS81ePbNXNYmncjtTlx4GOLiBSHzu6B
         i1rTW4f/1PYno7rcNCpHVw4nDnnLzIqnvorkpXq4NJBi7F5WVYSKElzyMNj/vkG0tuFB
         kzAUW/pa2BIqVmZ3qeVJN6OCZgvtWNf7HmzMsbTPJ7w9vEtV1Wju2bBpFuf4UTukxvms
         RpvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmvWixXkaScPS75uRAuzOIJri9oLOWbO1hA/OvZvH9vOgmUkxdObruRtvfp5VxSG2R1OszG5exgUPuCw==@vger.kernel.org, AJvYcCVPp7Ixdr3SPSKeXN5DmnyGywp0NFr5gbHpYrFE8kDfGUHoprhl2Vlcg4XK1DakDEndmVY9W+0rP9CcOA==@vger.kernel.org, AJvYcCXJ1Bx7HTAaoUoIxuADKSr62ZW3xGxGBA/Cc/cyHukk86B4Pm2sqiphYoZOR9DA9gBu2KzltPwuYK9bfz+l@vger.kernel.org, AJvYcCXgeAHGQ2K5cldJ7bM2jCiXEDmwKxHJnGl5R/2NpADGyrzPpafMU6g8tDjm1Z1nbuD0OIRkZ4BBPZVG@vger.kernel.org, AJvYcCXkbaSfIGMjq0iEoPGzYGB4QzV6PbH7KgtYDyne0DXuIVJ98SQdOtcqSZCJK+Q17JjV/U8Z+zz8LfUooQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmbxwS+kGEt9OC8/zsAQcCU/ifqWD6BfgsbkKsgXC/QuKq17Fn
	34yX63eGSHr1bcnrIOE7ry0kAJBdY5fZsFEkHo3t7PylsoPshAVZ9KLmsfqQwtCnj1eUWFG8nju
	TEZisg5ex189ZFiK1CP4v2PEwMpZMe8ioZEpV+eU=
X-Gm-Gg: ASbGnct0UJ3xn2+D0JZuSB6PHv9VwghU/+k5nail+IPIVCKoylVRrorK57eabAU+TdG
	zVCZjllE3N9a5sQjROEsitWJEqBbn2VvftdGX7QJLuoB3eDUadJYWSBf0UBFQV6Sqgsn55Z8+6g
	foPc4ZYEiXONNiZWL6gH9z9iDAku3gVAZUXFonUnHuxSM=
X-Google-Smtp-Source: AGHT+IEs8tHro3Bqg7q8bk+joLEpnvyUJ+PSWmsKZZ858+7uklxqykPVE6FCaw1PpU8qCZAfdipBs10XMfJUvah5VmA=
X-Received: by 2002:a05:6214:f2a:b0:6fa:f94e:6e75 with SMTP id
 6a1803df08f44-6fb08f5f7c4mr277251346d6.25.1749508610272; Mon, 09 Jun 2025
 15:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607200454.73587-1-ebiggers@kernel.org> <CAGRGNgV_4X3O-qo3XFGexi9_JqJXK9Mf82=p8CQ4BoD3o-Hypw@mail.gmail.com>
 <20250609194845.GC1255@sol>
In-Reply-To: <20250609194845.GC1255@sol>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 10 Jun 2025 08:36:39 +1000
X-Gm-Features: AX0GCFuUtzPWjE_fUMffnG3t-eGyXruP1OclUqP-Gat86eROO8R2ly8lc5p3jN0
Message-ID: <CAGRGNgXw5LcykjiRS3yteb0K8FmYtb9wp1CJPM+GCKAw7j4ktQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] lib/crc: improve how arch-optimized code is integrated
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, Jun 10, 2025 at 5:49=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Mon, Jun 09, 2025 at 06:15:24PM +1000, Julian Calaby wrote:
> > Hi Eric,
> >
> > On Sun, Jun 8, 2025 at 6:07=E2=80=AFAM Eric Biggers <ebiggers@kernel.or=
g> wrote:
> > >
> > > This series is also available at:
> > >
> > >     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebigger=
s/linux.git lib-crc-arch-v2
> > >
> > > This series improves how lib/crc supports arch-optimized code.  First=
,
> > > instead of the arch-optimized CRC code being in arch/$(SRCARCH)/lib/,=
 it
> > > will now be in lib/crc/$(SRCARCH)/.  Second, the API functions (e.g.
> > > crc32c()), arch-optimized functions (e.g. crc32c_arch()), and generic
> > > functions (e.g. crc32c_base()) will now be part of a single module fo=
r
> > > each CRC type, allowing better inlining and dead code elimination.  T=
he
> > > second change is made possible by the first.
> > >
> > > As an example, consider CONFIG_CRC32=3Dm on x86.  We'll now have just
> > > crc32.ko instead of both crc32-x86.ko and crc32.ko.  The two modules
> > > were already coupled together and always both got loaded together via
> > > direct symbol dependency, so the separation provided no benefit.
> > >
> > > Note: later I'd like to apply the same design to lib/crypto/ too, whe=
re
> > > often the API functions are out-of-line so this will work even better=
.
> > > In those cases, for each algorithm we currently have 3 modules all
> > > coupled together, e.g. libsha256.ko, libsha256-generic.ko, and
> > > sha256-x86.ko.  We should have just one, inline things properly, and
> > > rely on the compiler's dead code elimination to decide the inclusion =
of
> > > the generic code instead of manually setting it via kconfig.
> > >
> > > Having arch-specific code outside arch/ was somewhat controversial wh=
en
> > > Zinc proposed it back in 2018.  But I don't think the concerns are
> > > warranted.  It's better from a technical perspective, as it enables t=
he
> > > improvements mentioned above.  This model is already successfully use=
d
> > > in other places in the kernel such as lib/raid6/.  The community of e=
ach
> > > architecture still remains free to work on the code, even if it's not=
 in
> > > arch/.  At the time there was also a desire to put the library code i=
n
> > > the same files as the old-school crypto API, but that was a mistake; =
now
> > > that the library is separate, that's no longer a constraint either.
> >
> > Quick question, and apologies if this has been covered elsewhere.
> >
> > Why not just use choice blocks in Kconfig to choose the compiled-in
> > crc32 variant instead of this somewhat indirect scheme?
> >
> > This would keep the dependencies grouped by arch and provide a single p=
lace to
> > choose whether the generic or arch-specific method is used.
>
> It's not clear exactly what you're suggesting, but it sounds like you're
> complaining about this:
>
>     config CRC32_ARCH
>             bool
>             depends on CRC32 && CRC_OPTIMIZATIONS
>             default y if ARM && KERNEL_MODE_NEON
>             default y if ARM64
>             default y if LOONGARCH
>             default y if MIPS && CPU_MIPSR6
>             default y if PPC64 && ALTIVEC
>             default y if RISCV && RISCV_ISA_ZBC
>             default y if S390
>             default y if SPARC64
>             default y if X86

I was suggesting something roughly like:

choice
    prompt "CRC32 Variant"
    depends on CRC32 && CRC_OPTIMIZATIONS

config CRC32_ARCH_ARM_NEON
    bool "ARM NEON"
    default y
    depends ARM && KERNEL_MODE_NEON

...

config CRC32_GENERIC
    bool "Generic"

endchoice

> This patchset strikes a balance where the vast majority of the arch-speci=
fic CRC
> code is isolated in lib/crc/$(SRCARCH), and the exceptions are just
> lib/crc/Makefile and lib/crc/Kconfig.  I think these exceptions make sens=
e,
> given that we're building a single module per CRC variant.  We'd have to =
go
> through some hoops to isolate the arch-specific Kconfig and Makefile snip=
pets
> into per-arch files, which don't seem worth it here IMO.

I was only really concerned with the Kconfig structure, I was
expecting Kbuild to look roughly like this: (filenames are wrong)

crc32-y +=3D crc32-base.o
crc32-$(CRC32_ARCH_ARM_NEON) +=3D arch/arm/crc32-neon.o
...
crc32-$(CRC32_GENERIC) +=3D crc32-generic.o

but yeah, your proposal here has grown on me now that I think about it
and the only real "benefit" mine has is that architectures can display
choices for variants that have Kconfig-visible requirements, which
probably isn't that many so it wouldn't be useful in practice.

Thanks for answering my question,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

