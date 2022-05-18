Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C7952C659
	for <lists+linux-arch@lfdr.de>; Thu, 19 May 2022 00:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiERWgf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 18:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiERWge (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 18:36:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBC64ECCB;
        Wed, 18 May 2022 15:36:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L3SWr2vmXz4xVM;
        Thu, 19 May 2022 08:36:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652913387;
        bh=caT6jEYUNwfBW50T3+33ARca6ETe9j5GqS/aXUUr1AE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qQMSfNC30Tq3ei9+dT1sAmYh0aHvuUlcvO5IOuH75E5U94d09oiaMeYu0cybtv2m0
         T1u75Dg0z9eCpdnzNEuV5NKXDTEigZeWEPVw2IQdUJV/T/Nkf1FQz0N/2KKBoauvPm
         GVfXjzaAHbJCEEj+D49SscX5u3nt0VpOL/qTgJJbP+YWT0VVjCPuYA1zfJlDbvB7JR
         ul4kzXIeE9fxBkkqQRnhflNMDiRjcKyB0Aw7ewo95189vaMpuALonAg2fZtXvjxpQr
         Dp10x8H7QhF6xe0/OqtmCxqFla5nmN1IWbh80KI6xK50rXYiZsSQCBLocYfXA5hZh9
         u05/efLpuXAcQ==
Date:   Thu, 19 May 2022 08:36:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V11 00/22] arch: Add basic LoongArch support
Message-ID: <20220519083621.4f81cac9@canb.auug.org.au>
In-Reply-To: <CAK8P3a15oQNZvST56v0AvtC1oZP4iDHy-QMLwZuDAg30gq-+4A@mail.gmail.com>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
        <CAK8P3a15oQNZvST56v0AvtC1oZP4iDHy-QMLwZuDAg30gq-+4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+ysQkiTEflTmaoBUlaX9AyU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/+ysQkiTEflTmaoBUlaX9AyU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, 18 May 2022 14:42:07 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, May 18, 2022 at 10:25 AM Huacai Chen <chenhuacai@loongson.cn> wro=
te:
> >
> > LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> > LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> > version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> > boot protocol LoongArch-specific interrupt controllers (similar to APIC)
> > are already added in the next revision of ACPI Specification (current
> > revision is 6.4).
> >
> > This patchset is adding basic LoongArch support in mainline kernel, we
> > can see a complete snapshot here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongs=
on.git/log/?h=3Dloongarch-next =20
>=20
> Stephen, can you add this branch to the linux-next tree?

Added from today.  I have called it "loongarch" and it will be merged
among the other architecture trees after the asm-generic tree.
Currently Huacai Chen is the only contact listed.

I note that there is no new entry in MAINTAINERS in this tree.

> I see there are still comments coming in, but at some point this has
> to just be considered good enough that any further changes can be address=
ed
> with patches on top rather than rebasing.

That should be fine.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--=20
Cheers,
Stephen Rothwell

--Sig_/+ysQkiTEflTmaoBUlaX9AyU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKFdOYACgkQAVBC80lX
0Gxj6AgAih0bFdl2KpBa8AsehwFxTb/5dJyOjHgyZfF8LC5pOt1Qp7KNd18c+iXk
hB8/hl0SHl3TRUb1k2YKxjYIb1pG0KDkZcPysDBNKYleOSMbhyvpHSTLAJQ2zZHb
m0x922HSgva7cX/xrEqL3XZCVzOYBsfXzVfn/Mm6+5PT+SaniI7sv5wMuVS1vs2O
yjlmyHSz9/RENRFmbjJoHvILB2WDgR4MGry4X+CrpsAe5kWB17JpyNnUid01HYib
ViKwomFBgAEL3T+GC/UTXgtWJEAJWlRlewneSoGh51aMGdQFYTM82++CBjVi5WSP
kD0cIIMLHRvJMzL2GHWHijQnuRcx2w==
=w4jJ
-----END PGP SIGNATURE-----

--Sig_/+ysQkiTEflTmaoBUlaX9AyU--
