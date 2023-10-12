Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89157C70C4
	for <lists+linux-arch@lfdr.de>; Thu, 12 Oct 2023 16:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbjJLOyY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Oct 2023 10:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjJLOyX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Oct 2023 10:54:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF0BD7;
        Thu, 12 Oct 2023 07:54:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96553C433C7;
        Thu, 12 Oct 2023 14:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697122461;
        bh=+ojXCG56gMjVZw+vx9Pj6zEubeSQNGY9Yfj0hYNQrvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iqiaPRzY62d+KCn53LW4SeKoB5rJrf8XYH/0uzqIfa+WEd6tvkNAvImgd25Eql9wm
         z9SfRMb3GsqCHUZiyrFhNSSR9eOR9DWiBiJALphEf+A+CboBiAb8nis1weMnpwdvZa
         mQEeZBoedIqE1bXF3we+nYFkHweXsTDXK6AnC6i1vyuCJvN0UEShPSfclDBRB/zTmK
         A7Rx/IhBWKziaV8gjoOEa1V6QyZyYYFqLiaKiSGBqKRWV1hFYRvJ38h1BCceYQtOn8
         RdYbxGhpJlllcCDQYeSXQGXbiTwQS+NoB6f+ktAc8O2hFHaWBZd9V16tJZWUC01r8u
         kH7rHVW6l27mg==
Date:   Thu, 12 Oct 2023 15:54:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 2/4] riscv: Checksum header
Message-ID: <20231012-directory-drapery-fec6c7e2419d@spud>
References: <20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com>
 <20230919-optimize_checksum-v7-2-06c7d0ddd5d6@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/uRjsvow0K0+ny7V"
Content-Disposition: inline
In-Reply-To: <20230919-optimize_checksum-v7-2-06c7d0ddd5d6@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--/uRjsvow0K0+ny7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 11:44:31AM -0700, Charlie Jenkins wrote:
> Provide checksum algorithms that have been designed to leverage riscv
> instructions such as rotate. In 64-bit, can take advantage of the larger
> register to avoid some overflow checking.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Same here,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

I think there are some "issues" attributed to this patch by the
automation - but they spurious. This diff here could not cause a
drivers/block/drbd/drbd_bitmap.c:1271: warning: Function parameter or membe=
r 'peer_device' not described in 'drbd_bm_write_copy_pages'
after all.

Cheers,
Conor.

> ---
>  arch/riscv/include/asm/checksum.h | 79 +++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 79 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/c=
hecksum.h
> new file mode 100644
> index 000000000000..dc0dd89f2a13
> --- /dev/null
> +++ b/arch/riscv/include/asm/checksum.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * IP checksum routines
> + *
> + * Copyright (C) 2023 Rivos Inc.
> + */
> +#ifndef __ASM_RISCV_CHECKSUM_H
> +#define __ASM_RISCV_CHECKSUM_H
> +
> +#include <linux/in6.h>
> +#include <linux/uaccess.h>
> +
> +#define ip_fast_csum ip_fast_csum
> +
> +#include <asm-generic/checksum.h>
> +
> +/*
> + * Quickly compute an IP checksum with the assumption that IPv4 headers =
will
> + * always be in multiples of 32-bits, and have an ihl of at least 5.
> + * @ihl is the number of 32 bit segments and must be greater than or equ=
al to 5.
> + * @iph is assumed to be word aligned.
> + */
> +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> +{
> +	unsigned long csum =3D 0;
> +	int pos =3D 0;
> +
> +	do {
> +		csum +=3D ((const unsigned int *)iph)[pos];
> +		if (IS_ENABLED(CONFIG_32BIT))
> +			csum +=3D csum < ((const unsigned int *)iph)[pos];
> +	} while (++pos < ihl);
> +
> +	/*
> +	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
> +	 * worth checking if supported without Alternatives.
> +	 */
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +		unsigned long fold_temp;
> +
> +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> +					      RISCV_ISA_EXT_ZBB, 1)
> +		    :
> +		    :
> +		    :
> +		    : no_zbb);
> +
> +		if (IS_ENABLED(CONFIG_32BIT)) {
> +			asm(".option push				\n\
> +			.option arch,+zbb				\n\
> +				not	%[fold_temp], %[csum]		\n\
> +				rori	%[csum], %[csum], 16		\n\
> +				sub	%[csum], %[fold_temp], %[csum]	\n\
> +			.option pop"
> +			: [csum] "+r" (csum), [fold_temp] "=3D&r" (fold_temp));
> +		} else {
> +			asm(".option push				\n\
> +			.option arch,+zbb				\n\
> +				rori	%[fold_temp], %[csum], 32	\n\
> +				add	%[csum], %[fold_temp], %[csum]	\n\
> +				srli	%[csum], %[csum], 32		\n\
> +				not	%[fold_temp], %[csum]		\n\
> +				roriw	%[csum], %[csum], 16		\n\
> +				subw	%[csum], %[fold_temp], %[csum]	\n\
> +			.option pop"
> +			: [csum] "+r" (csum), [fold_temp] "=3D&r" (fold_temp));
> +		}
> +		return csum >> 16;
> +	}
> +no_zbb:
> +#ifndef CONFIG_32BIT
> +	csum +=3D (csum >> 32) | (csum << 32);
> +	csum >>=3D 32;
> +#endif
> +	return csum_fold((__force __wsum)csum);
> +}
> +
> +#endif // __ASM_RISCV_CHECKSUM_H
>=20
> --=20
> 2.42.0
>=20

--/uRjsvow0K0+ny7V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSgImQAKCRB4tDGHoIJi
0vbVAPwKRp4UXBThl9GOTew5j0FmY9XGj3v2k798QY2F9FGN2QEA6p0JzpE5uOBn
UP4ZzpdYbI/4Col0rf3CIiy6hz1TkA8=
=R5LB
-----END PGP SIGNATURE-----

--/uRjsvow0K0+ny7V--
