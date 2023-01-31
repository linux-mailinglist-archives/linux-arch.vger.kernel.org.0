Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469AD683635
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 20:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjAaTNS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 14:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjAaTNR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 14:13:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98002903A
        for <linux-arch@vger.kernel.org>; Tue, 31 Jan 2023 11:13:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32A45616C0
        for <linux-arch@vger.kernel.org>; Tue, 31 Jan 2023 19:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A42C433D2;
        Tue, 31 Jan 2023 19:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675192395;
        bh=VltjbW6T1jEQWZxEoukktOIp4ozkal5er2F1ZV/I10w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZ5SPQOaVVpouPzKQqVwQZy/L3vNnkGyl7nnCebULohecmQzteyFdWQSggnK6jRVs
         OhyBNUF6gCIyEmTOCRCFOYp348qEsKYWgaRN0Cu+Tp5c2zBssl2X82P9x7ZiDxHINY
         kVKzIhmDKnzefeXX97qMky9JKuzCw7xRBsoEFxqBudXlgTe1FaQbsnewme5FJC/ifJ
         Z+3VBeZlO3ELVs7Vvl/x+k3ed81dBHGNAqTAQ7EwQrS5CQKWx0SHbjGf1Ptxz4Tl+O
         ZIJ/Pd6PaZl+F9URLXhrpgX7h03XAiauwxAjxVOt81gsxGSclWdJKRYuXAMYxVcHqP
         RVb+P7bL6AZtQ==
Date:   Tue, 31 Jan 2023 19:13:11 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Guo Ren <guoren@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Subject: Re: [PATCH] riscv: mm: fix regression due to update_mmu_cache change
Message-ID: <Y9loR3kuEXqDGVZE@spud>
References: <20230129211818.686557-1-geomatsi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lQIwXAPTN2m/wo/K"
Content-Disposition: inline
In-Reply-To: <20230129211818.686557-1-geomatsi@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--lQIwXAPTN2m/wo/K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 12:18:18AM +0300, Sergey Matyukevich wrote:
> From: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
>=20
> This is a partial revert of the commit 4bd1d80efb5a ("riscv: mm: notify
> remote harts about mmu cache updates"). Original commit included two
> loosely related changes serving the same purpose of fixing stale TLB
> entries causing user-space application crash:
> - introduce deferred per-ASID TLB flush for CPUs not running the task
> - switch to per-ASID TLB flush on all CPUs running the task in update_mmu=
_cache
>=20
> According to report and discussion in [1], the second part caused a
> regression on Renesas RZ/Five SoC. For now restore the old behavior
> of the update_mmu_cache.
>=20
> [1] https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@=
gmail.com/

If you respin for another reason, can you convert this into a "regular"
Link: trailer, so that it can be parsed with git's trailer functionality?
IOW, like so:
Link: https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@=
gmail.com/ [1]

Otherwise, glad to see you two get this sorted out, even if it is just a
revert.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> Fixes: 4bd1d80efb5a ("riscv: mm: notify remote harts about mmu cache upda=
tes")
> Reported-by: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> Signed-off-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 4eba9a98d0e3..4c3c130ee328 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -415,7 +415,7 @@ static inline void update_mmu_cache(struct vm_area_st=
ruct *vma,
>  	 * Relying on flush_tlb_fix_spurious_fault would suffice, but
>  	 * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
>  	 */
> -	flush_tlb_page(vma, address);
> +	local_flush_tlb_page(address);
>  }
> =20
>  #define __HAVE_ARCH_UPDATE_MMU_TLB
> --=20
> 2.39.0
>=20

--lQIwXAPTN2m/wo/K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9loRgAKCRB4tDGHoIJi
0li+AQDsZDMhzesiFuErZStkmObCxbQrXZHaqScmaZF2cmAgDAEAttSBiuuRH1MV
P8htcf6ognDO5SmB9yMC1Ub/7luIGgE=
=DgRf
-----END PGP SIGNATURE-----

--lQIwXAPTN2m/wo/K--
