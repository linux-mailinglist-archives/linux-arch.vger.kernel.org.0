Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D05655D73
	for <lists+linux-arch@lfdr.de>; Sun, 25 Dec 2022 16:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLYPSX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Dec 2022 10:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiLYPSW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Dec 2022 10:18:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5694F60D9;
        Sun, 25 Dec 2022 07:18:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B767B8072F;
        Sun, 25 Dec 2022 15:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D797C433F0;
        Sun, 25 Dec 2022 15:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671981498;
        bh=VpGs+wgQvn4nopc1zVna92m+pXcpav9pdxWW3SwSjoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jh7FT5QwpZXqUGxdeuVAKyjWHlRu4LXncDmnDxCbaDPyX1b37ve16iwxcm7vaxFiD
         2jc0JH45sRXbFdmROBBxj+pCyoOAQRiNPkFEFY8jH9W16YK46aMVjwHe9qd3v0iVUW
         8D1hwAzIyjeCHNXmjqbolb9Lh5XviXOdDAH2dTfN+ppfQ08hxsRah8bHKRh7kvI5ac
         imH0UGSJF4Y6C9VqJw3Bj7rDa+bcddaoyA9tILTNYWBzPG1Uwp+W5tskgsOoyH10IQ
         4w0lpgyOR6j9PO7nSVYwX8qDCbL91D7rPzX936LOBKdFGa2Q/2ANoAKDoNbiwyABSI
         lSSEiYyaK8mhQ==
Date:   Sun, 25 Dec 2022 15:18:12 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Dennis Gilmore <dennis@ausil.us>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] arch: fix broken BuildID for arm64 and riscv
Message-ID: <Y6hptEk8FmISixLS@spud>
References: <20221224192751.810363-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K+NAhlStwZgY8Rt3"
Content-Disposition: inline
In-Reply-To: <20221224192751.810363-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--K+NAhlStwZgY8Rt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 25, 2022 at 04:27:51AM +0900, Masahiro Yamada wrote:
> Dennis Gilmore reports that the BuildID is missing in the arm64 vmlinux
> since commit 994b7ac1697b ("arm64: remove special treatment for the
> link order of head.o").
>=20
> The issue is that the type of .notes section, which contains the BuildID,
> changed from NOTES to PROGBITS.
>=20
> Ard Biesheuvel figured out that whichever object gets linked first gets
> to decide the type of a section, and the PROGBITS type is the result of
> the compiler emitting .note.GNU-stack as PROGBITS rather than NOTE.
>=20
> While Ard provided a fix for arm64, I want to fix this globally because
> the same issue is happening on riscv since commit 2348e6bf4421 ("riscv:
> remove special treatment for the link order of head.o"). This problem
> will happen in general for other architectures if they start to drop
> unneeded entries from scripts/head-object-list.txt.
>=20
> Discard .note.GNU-stack in include/asm-generic/vmlinux.lds.h.
>=20
> riscv needs to change its linker script so that DISCARDS comes before
> the .notes section.

Hey Mashiro,

No idea why I decided to look at patchwork today, but this seems to
break the build on RISC-V, there's a whole load of the following in the
output:
`.LPFE4' referenced in section `__patchable_function_entries' of kernel/tra=
ce/trace_selftest_dynamic.o: defined in discarded section `.text.exit' of k=
ernel/trace/trace_selftest_dynamic.o

I assume that's what's doing it, but given the day that's in it - I
haven't looked into this any further, nor gone and fished the logs out of
the builder.

Thanks,
Conor.

>=20
> Link: https://lore.kernel.org/lkml/CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-L=
CQc=3D74D=3DxE=3DrA@mail.gmail.com/
> Fixes: 994b7ac1697b ("arm64: remove special treatment for the link order =
of head.o")
> Fixes: 2348e6bf4421 ("riscv: remove special treatment for the link order =
of head.o")
> Reported-by: Dennis Gilmore <dennis@ausil.us>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  arch/riscv/kernel/vmlinux.lds.S   | 4 ++--
>  include/asm-generic/vmlinux.lds.h | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.=
lds.S
> index 4e6c88aa4d87..1865a258e560 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -31,6 +31,8 @@ PECOFF_FILE_ALIGNMENT =3D 0x200;
> =20
>  SECTIONS
>  {
> +	DISCARDS
> +
>  	/* Beginning of code and text segment */
>  	. =3D LOAD_OFFSET;
>  	_start =3D .;
> @@ -141,7 +143,5 @@ SECTIONS
>  	STABS_DEBUG
>  	DWARF_DEBUG
>  	ELF_DETAILS
> -
> -	DISCARDS
>  }
>  #endif /* CONFIG_XIP_KERNEL */
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index a94219e9916f..2993b790fe98 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -1007,6 +1007,7 @@
>  	*(.modinfo)							\
>  	/* ld.bfd warns about .gnu.version* even when not emitted */	\
>  	*(.gnu.version*)						\
> +	*(.note.GNU-stack)	/* emitted as PROGBITS */
> =20
>  #define DISCARDS							\
>  	/DISCARD/ : {							\
> --=20
> 2.34.1
>=20

--K+NAhlStwZgY8Rt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6hprwAKCRB4tDGHoIJi
0l9RAQDXyhrQnr6kGR3PoaIXcvTa5dsQBWOMb61JO0FkgzjwYAEAkDzn+fYdakxz
5UB/bAYVBrV22oXa0H/xak2PwjZ+AQA=
=xIjn
-----END PGP SIGNATURE-----

--K+NAhlStwZgY8Rt3--
