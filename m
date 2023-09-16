Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91587A2EE1
	for <lists+linux-arch@lfdr.de>; Sat, 16 Sep 2023 10:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjIPIvM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 16 Sep 2023 04:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbjIPIuq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 16 Sep 2023 04:50:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71826CF8;
        Sat, 16 Sep 2023 01:50:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AADC433C7;
        Sat, 16 Sep 2023 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694854241;
        bh=40ylAetvH2D45aO5J/08CkEvM05rm1lwgoMuurgAuH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gC+VjBFi06GNrUV4aejNhpXtveOVkoTOJURdSDxNPs+L1wLQuki8wXleFcffnq9Xj
         X6PW2HOI5TlnVkKC591doTM7l1THmFUSQB1Jlhx+3uRq0UhlHHiZ3+p97Na0Qtfg2K
         bsD5I6szMJPGak1RUxwzIs6upcyErp1/s+Xp1mHqDjtHjnkTugyv7vANcepK86Xpa+
         aFAIMbolhjbh59Ge0hy1eVd/nWSAq2zQOF8PmqxOcN11bATns2sTU/wkdxq3y7jdaK
         kQBUNNwtA6EDXCOucwung84Z5syZ82le1aiY0yVEe+oxASsns0Wn/HTYHuajwtILlm
         l9AVHz3LY2Zhg==
Date:   Sat, 16 Sep 2023 09:50:36 +0100
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
Subject: Re: [PATCH v6 1/4] asm-generic: Improve csum_fold
Message-ID: <20230916-jackpot-guy-01c2024c6a63@spud>
References: <20230915-optimize_checksum-v6-0-14a6cf61c618@rivosinc.com>
 <20230915-optimize_checksum-v6-1-14a6cf61c618@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="60Aaxr3gdQT472cE"
Content-Disposition: inline
In-Reply-To: <20230915-optimize_checksum-v6-1-14a6cf61c618@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--60Aaxr3gdQT472cE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 10:01:17AM -0700, Charlie Jenkins wrote:
> This csum_fold implementation introduced into arch/arc by Vineet Gupta
> is better than the default implementation on at least arc, x86, and
> riscv. Using GCC trunk and compiling non-inlined version, this
> implementation has 41.6667%, 25% fewer instructions on riscv64, x86-64
> respectively with -O3 optimization. Most implmentations override this
> default in asm, but this should be more performant than all of those
> other implementations except for arm which has barrel shifting and
> sparc32 which has a carry flag.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: David Laight <david.laight@aculab.com>
> ---
>  include/asm-generic/checksum.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksu=
m.h
> index 43e18db89c14..37f5ec70ac93 100644
> --- a/include/asm-generic/checksum.h
> +++ b/include/asm-generic/checksum.h
> @@ -31,9 +31,7 @@ extern __sum16 ip_fast_csum(const void *iph, unsigned i=
nt ihl);
>  static inline __sum16 csum_fold(__wsum csum)
>  {
>  	u32 sum =3D (__force u32)csum;
> -	sum =3D (sum & 0xffff) + (sum >> 16);
> -	sum =3D (sum & 0xffff) + (sum >> 16);
> -	return (__force __sum16)~sum;
> +	return (__force __sum16)((~sum - ror32(sum, 16)) >> 16);

Breaks the build on RISC-V in a way that is repaired by later patches in
the series, so you likely did not notice:

=2E/include/asm-generic/checksum.h:34:35: error: call to undeclared functio=
n 'ror32'; ISO C99 and later do not support implicit function declarations =
[-Wimplicit-function-declaration]
=2E./include/linux/bitops.h:134:21: error: static declaration of 'ror32' fo=
llows non-static declaration

Cheers,
Conor.

--60Aaxr3gdQT472cE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQVsXAAKCRB4tDGHoIJi
0mnEAQCTLnl3iMEBVo3Tzp6o42hU6amG6PduNyUQd8smnnQAVAD/RhsXtPuthkcC
tk+v8xXjpz227mU8sGL65Usl2rfDRgk=
=GX46
-----END PGP SIGNATURE-----

--60Aaxr3gdQT472cE--
