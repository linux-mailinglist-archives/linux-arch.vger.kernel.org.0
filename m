Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF4967D54D
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 20:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjAZTZ1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 14:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjAZTZ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 14:25:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D6F5C0F0;
        Thu, 26 Jan 2023 11:25:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4531AB81EE0;
        Thu, 26 Jan 2023 19:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD99C433EF;
        Thu, 26 Jan 2023 19:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674761120;
        bh=2kKRmpXmW7pSeOdhY3ltZQoZ4ekCXsd1oLHvZRkYUOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dUBy17h0+Y1S6MwZNQhyJ0P1rNelF1hq1VKWF8KFwRQ1T9wrnu5hDFb1Zh0OAvCgZ
         qMj5/7okFppd2VELvaSzIZ1ULc9rvqTg0Me/DiVGwK0+U1wnKGI9bd8H37FT1IJUjB
         gJnRfTH574jhbrPAD7xO1vknKlKMh734gbywqlVw69l8BSO/PLWY9h/5yigQt9OaKL
         z3uc8g+n7ih0YWRgxCibvWwwi0+EPRI7lgOTyJfn4qk3uWsUCEEtevkSlPW4UZJ4RQ
         qwe1Y9zJgoudBAbSpeoI/ST60u9z/PNg4nh0VjrNfDAmNN84DfmpQlrAxPs/4ywrbJ
         uraJFgpqn6rOg==
Date:   Thu, 26 Jan 2023 19:25:14 +0000
From:   Conor Dooley <conor@kernel.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH -next V15 0/7] riscv: Add GENERIC_ENTRY support
Message-ID: <Y9LTmmYuEWKNmyl2@spud>
References: <20230126172516.1580058-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JjxsvIAoWe1e1dRO"
Content-Disposition: inline
In-Reply-To: <20230126172516.1580058-1-guoren@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--JjxsvIAoWe1e1dRO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Guo Ren,

On Thu, Jan 26, 2023 at 12:25:09PM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> The patches convert riscv to use the generic entry infrastructure from
> kernel/entry/*. Some optimization for entry.S with new .macro and merge
> ret_from_kernel_thread into ret_from_fork.
>=20
> The 1,2 are the preparation of generic entry. 3~7 are the main part
> of generic entry.
>=20
> All tested with rv64, rv32, rv64 + 32rootfs, all are passed.
>=20
> You can directly try it with:
> [1] https://github.com/guoren83/linux/tree/generic_entry_v15
>=20
> Any reviews and tests are helpful.
>=20
> v15:
>  - Fixup compile error for !MMU (Thx Conor)
>  - Rebase on riscv for-next (20230127)

nommu build looks fine now, thanks for fixing it up. Hopefully you're
good to now now after 15 versions!

Thanks,
Conor.


--JjxsvIAoWe1e1dRO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9LTmgAKCRB4tDGHoIJi
0lTeAQC/KKw9bBB/ItyFtaPy1LxOnpMqgQ3niF2fYcVRG5bzvgD/VcCyMPuxOMVx
fqcpkVl4ijwDZF+pcTNNu/X3lLDHvQY=
=m20Q
-----END PGP SIGNATURE-----

--JjxsvIAoWe1e1dRO--
