Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E066E69C69A
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 09:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjBTI3T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 03:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjBTI3Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 03:29:16 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAEC12F1E;
        Mon, 20 Feb 2023 00:29:11 -0800 (PST)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 167505F997;
        Mon, 20 Feb 2023 09:29:09 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Matthew Wilcox <willy@infradead.org>, linux-arch@vger.kernel.org,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: API for setting multiple PTEs at once
Date:   Mon, 20 Feb 2023 09:29:58 +0100
Message-ID: <5649318.DvuYhMxLoT@devpool47>
Organization: emlix GmbH
In-Reply-To: <0bf59207-838b-2a0b-a95e-925a6bbf1913@ghiti.fr>
References: <Y9wnr8SGfGGbi/bk@casper.infradead.org>
 <Y+K0O35jNNzxiXE6@casper.infradead.org>
 <0bf59207-838b-2a0b-a95e-925a6bbf1913@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5907765.lOV4Wx5bFT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--nextPart5907765.lOV4Wx5bFT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
Subject: Re: API for setting multiple PTEs at once
Date: Mon, 20 Feb 2023 09:29:58 +0100
Message-ID: <5649318.DvuYhMxLoT@devpool47>
Organization: emlix GmbH
In-Reply-To: <0bf59207-838b-2a0b-a95e-925a6bbf1913@ghiti.fr>
MIME-Version: 1.0

On Dienstag, 14. Februar 2023 10:55:43 CET Alexandre Ghiti wrote:
> Hi Matthew,
>=20
> On 2/7/23 21:27, Matthew Wilcox wrote:
> > On Thu, Feb 02, 2023 at 09:14:23PM +0000, Matthew Wilcox wrote:
> >> For those of you not subscribed, linux-mm is currently discussing
> >> how best to handle page faults on large folios.  I simply made it work
> >> when adding large folio support.  Now Yin Fengwei is working on
> >> making it fast.
> >=20
> > OK, here's an actual implementation:
> >=20
> > https://lore.kernel.org/linux-mm/20230207194937.122543-3-willy@infradea=
d.o
> > rg/
> >=20
> > It survives a run of xfstests.  If your architecture doesn't store its
> > PFNs at PAGE_SHIFT, you're going to want to implement your own set_ptes=
(),
> > or you'll see entirely the wrong pages mapped into userspace.  You may
> > also wish to implement set_ptes() if it can be done more efficiently
> > than __pte(pteval(pte) + PAGE_SIZE).
> >=20
> > Architectures that implement things like flush_icache_page() and
> > update_mmu_cache() may want to propose batched versions of those.
> > That's alpha, csky, m68k, mips, nios2, parisc, sh,
> > arm, loongarch, openrisc, powerpc, riscv, sparc and xtensa.
> > Maintainers BCC'd, mailing lists CC'd.
> >=20
> > I'm happy to collect implementations and submit them as part of a v6.
>=20
> Please find below the riscv implementation for set_ptes:
>=20
> diff --git a/arch/riscv/include/asm/pgtable.h
> b/arch/riscv/include/asm/pgtable.h
> index ebee56d47003..10bf812776a4 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -463,6 +463,20 @@ static inline void set_pte_at(struct mm_struct *mm,
>          __set_pte_at(mm, addr, ptep, pteval);
>   }
>=20
> +#define set_ptes set_ptes
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +                           pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +       for (;;) {
> +               set_pte_at(mm, addr, ptep, pte);
> +               if (--nr =3D=3D 0)
> +                       break;
> +               ptep++;
> +               addr +=3D PAGE_SIZE;
> +               pte =3D __pte(pte_val(pte) + (1 << _PAGE_PFN_SHIFT));
> +       }
> +}

Given that this is the same code as the original version (surprise!), what=
=20
about doing something like this in the generic code instead:

#ifndef PTE_PAGE_STEP
#define PTE_PAGE_STEP PAGE_SIZE
#endif

[=E2=80=A6]

> +               pte =3D __pte(pte_val(pte) + PTE_PAGE_STEP);

The name of the define is an obvious candidate for bike-shedding, feel free=
 to=20
name it as you want.

Or if that isn't sound enough maybe introduce something like:

static inline pte_t
set_ptes_next_pte(pte_t pte)
{
	return __pte(pte_val(pte) + (1 << _PAGE_PFN_SHIFT));
}

Greetings,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart5907765.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCY/MvhgAKCRCr5FH7Xu2t
/E96A/9/8q/Nw4RXmkex96nOqUtHteq72XctyEiwy7GrvS5dHVEeF79ebvwfpWIc
Q6IMXFvld2oH9gZNXFrKV13KlDICP8qZscK88++MqxHdNVgMw/o6sU5yAdaiaKEh
/bf9Rzx9VJTkDekQ7nP4YDLaAybLYSJ3fXX9PXr+j3HfhBsJxg==
=hoWZ
-----END PGP SIGNATURE-----

--nextPart5907765.lOV4Wx5bFT--



