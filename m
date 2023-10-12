Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21D87C70BC
	for <lists+linux-arch@lfdr.de>; Thu, 12 Oct 2023 16:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjJLOvI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Oct 2023 10:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjJLOvH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Oct 2023 10:51:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31BEC0;
        Thu, 12 Oct 2023 07:51:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762A7C433CA;
        Thu, 12 Oct 2023 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697122265;
        bh=5AiZVeDGvVMMzOjXejlLspSrRouelQDKxA7XAhxJnas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dB8tl3Z6BJ+PO1/HesfFNW+WQJk5CCvdZmDK6a2BOTBbPcKkooxLRLOqzZj0h07pV
         LmpoAwv9uaWH6OwmYrvCz39FTMZSlYnXsWJwynCLLVy2S8UXKGgNvDmbDA905OnI/w
         s7rtEUeeNAt06tIoAVgUu7ZdFwCvcWJ8TItK6AW+l83pQ2vtJJFG+7JGhr9P0218o3
         2iH3AXTpIzuFbbNnhtp8kSIvyKFutihIX+ar5/5ErBUC5ZKk9EMAEgAQRLWUYYTd4F
         k3gOp5cm4ne+ZbFIs3XbMPUeoZkZdEKm/2eXtrapRmbfqS0mHigk1FCgSJRiOpkoe+
         X92Hlk1B2PrTg==
Date:   Thu, 12 Oct 2023 15:51:01 +0100
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
Subject: Re: [PATCH v7 3/4] riscv: Add checksum library
Message-ID: <20231012-extradite-charbroil-32c0808c6669@spud>
References: <20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com>
 <20230919-optimize_checksum-v7-3-06c7d0ddd5d6@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VacEKFf8B2xXnVnJ"
Content-Disposition: inline
In-Reply-To: <20230919-optimize_checksum-v7-3-06c7d0ddd5d6@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--VacEKFf8B2xXnVnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Sep 19, 2023 at 11:44:32AM -0700, Charlie Jenkins wrote:
> Provide a 32 and 64 bit version of do_csum. When compiled for 32-bit
> will load from the buffer in groups of 32 bits, and when compiled for
> 64-bit will load in groups of 64 bits.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/checksum.h |  12 +++
>  arch/riscv/lib/Makefile           |   1 +
>  arch/riscv/lib/csum.c             | 217 ++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 230 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/c=
hecksum.h
> index dc0dd89f2a13..7fcd07edb8b3 100644
> --- a/arch/riscv/include/asm/checksum.h
> +++ b/arch/riscv/include/asm/checksum.h
> @@ -12,6 +12,18 @@
> =20
>  #define ip_fast_csum ip_fast_csum
> =20
> +extern unsigned int do_csum(const unsigned char *buff, int len);
> +#define do_csum do_csum
> +
> +/* Default version is sufficient for 32 bit */
> +#ifdef CONFIG_64BIT
> +#define _HAVE_ARCH_IPV6_CSUM
> +__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
> +			const struct in6_addr *daddr,
> +			__u32 len, __u8 proto, __wsum sum);
> +#endif
> +
> +// Define riscv versions of functions before importing asm-generic/check=
sum.h

As a nit item, you're using two different one-line comment styles in
this hunk. Otherwise, looks like you've addressed the things I didn't
like, as much as was possible. You get an a-b, not an r-b since I've not
reviewed the actual algorithm here.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--VacEKFf8B2xXnVnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSgH1QAKCRB4tDGHoIJi
0h4WAQDwylCfzxPDoqr8tU1izNvd8jH06hOEnbBlIXVTGp5uoAEAkT0Xj8ctwWNV
Ach6DncKx4c7MkjcvHe8OfU1sEoIdQA=
=QVL8
-----END PGP SIGNATURE-----

--VacEKFf8B2xXnVnJ--
