Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0306D642091
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 00:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiLDXna (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Dec 2022 18:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLDXna (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Dec 2022 18:43:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8757120AC
        for <linux-arch@vger.kernel.org>; Sun,  4 Dec 2022 15:43:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2088460F2A
        for <linux-arch@vger.kernel.org>; Sun,  4 Dec 2022 23:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4E2C433C1;
        Sun,  4 Dec 2022 23:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670197406;
        bh=e8lcvA/l7oxDnrim3J5FGBNlXm6BJxcdxOGUGtxs6+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GzhgCtQPYszq1w125z1UuCDvOvAaI/DZAp+ydf+2a2ZhS+5njBm3EJ40EyaraVgY4
         FS6M8OCGVoWwQiRzL/wkWAubs23LTYT5NGheUfXIU7QBME0OAwnW3f55F3JAw0jhHX
         sLGcXhMDXMOovYY7W871stR8jdxcBrZ8G1q60YQK7cZ0mOdi58wUN5VTsnn6+7tl74
         fezsGN1ULo8XVnpdZBKX1q3JQtkAvZB+UBynXHSmDdXg529bLYMxgPBDk19Y17yyiY
         n1I0FzsmEs1FnWoDuQew9jlMO+jiIcaVluyWZ1EUN2icS6OCiMzOS1K3LGGnuHmQ8i
         BnwXlsvGTtqGw==
Date:   Sun, 4 Dec 2022 23:43:21 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Subject: Re: [PATCH RFC v2 1/3] riscv: add support for hardware
 breakpoints/watchpoints
Message-ID: <Y40wmUcqMQWQLBsI@spud>
References: <20221203215535.208948-1-geomatsi@gmail.com>
 <20221203215535.208948-2-geomatsi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uMjV2SnuoiE65GZo"
Content-Disposition: inline
In-Reply-To: <20221203215535.208948-2-geomatsi@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--uMjV2SnuoiE65GZo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 04, 2022 at 12:55:33AM +0300, Sergey Matyukevich wrote:
> From: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
>=20
> RISC-V backend for hw-breakpoint framework is built on top of SBI Debug
> Trigger extension. Architecture specific hooks are implemented as kernel
> wrappers around ecalls to SBI functions. This patch implements only a
> minimal set of hooks required to support user-space debug via ptrace.
>=20
> Signed-off-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 2a0ef738695e..ef41d60a5ed3 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -31,6 +31,9 @@ enum sbi_ext_id {
>  	SBI_EXT_SRST =3D 0x53525354,
>  	SBI_EXT_PMU =3D 0x504D55,
> =20
> +	/* Experimental: Debug Trigger Extension */
> +	SBI_EXT_DBTR =3D 0x44425452,
> +
>  	/* Experimentals extensions must lie within this range */
>  	SBI_EXT_EXPERIMENTAL_START =3D 0x08000000,
>  	SBI_EXT_EXPERIMENTAL_END =3D 0x08FFFFFF,

This is an RFC for something I know nothing about, so was just scrolling
mindlessly... This caught my eye as odd - There's an explicit comment
about the range for experimental stuff but you've not used it? I guess
there must be some reason for that?

Confused,
Conor.


--uMjV2SnuoiE65GZo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY40wmQAKCRB4tDGHoIJi
0p/FAP46KqMJj6R9BTzZwIRwNPeVc8agmyBqGWfMHkYoVNXm5QD/TwUq0t9YfU4I
r1JI/fZrDBXWkqJ8n2xUAnTvN/DgVg0=
=wQBm
-----END PGP SIGNATURE-----

--uMjV2SnuoiE65GZo--
