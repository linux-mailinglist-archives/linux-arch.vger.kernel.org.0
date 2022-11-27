Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E4B639BD5
	for <lists+linux-arch@lfdr.de>; Sun, 27 Nov 2022 17:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiK0QzS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Nov 2022 11:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiK0QzS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Nov 2022 11:55:18 -0500
X-Greylist: delayed 1730 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Nov 2022 08:55:16 PST
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A6FDF4F;
        Sun, 27 Nov 2022 08:55:16 -0800 (PST)
Received: from 213.219.160.184.adsl.dyn.edpnet.net ([213.219.160.184] helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1ozKTU-0003A3-4R; Sun, 27 Nov 2022 17:25:48 +0100
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1ozKTT-000fZI-1S;
        Sun, 27 Nov 2022 17:25:47 +0100
Message-ID: <a28d32c965f363ce099bd0a65e1c82b75a98128a.camel@decadent.org.uk>
Subject: Re: [PATCH -next V8 06/14] riscv: convert to generic entry
From:   Ben Hutchings <ben@decadent.org.uk>
To:     guoren@kernel.org, arnd@arndb.de, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Date:   Sun, 27 Nov 2022 17:25:42 +0100
In-Reply-To: <20221103075047.1634923-7-guoren@kernel.org>
References: <20221103075047.1634923-1-guoren@kernel.org>
         <20221103075047.1634923-7-guoren@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-hBvg3hkgZJx22/D8ziHr"
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.160.184
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-hBvg3hkgZJx22/D8ziHr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-11-03 at 03:50 -0400, guoren@kernel.org wrote:
[...]
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
[...]
> +asmlinkage void do_sys_ecall_u(struct pt_regs *regs)
> +{
> +	syscall_t syscall;
> +	ulong nr =3D regs->a7;
> +
> +	regs->epc +=3D 4;
> +	regs->orig_a0 =3D regs->a0;
> +	regs->a0 =3D -ENOSYS;
> +
> +	nr =3D syscall_enter_from_user_mode(regs, nr);
> +#ifdef CONFIG_COMPAT
> +	if ((regs->status & SR_UXL) =3D=3D SR_UXL_32)
> +		syscall =3D compat_sys_call_table[nr];
> +	else
> +#endif
> +		syscall =3D sys_call_table[nr];
> +
> +	if (nr < NR_syscalls)

This bounds check needs to be done before indexing the system call
table, not after.

Ben.

> +		regs->a0 =3D syscall(regs->orig_a0, regs->a1, regs->a2,
> +				   regs->a3, regs->a4, regs->a5, regs->a6);
> +	syscall_exit_to_user_mode(regs);
> +}
[...]

--=20
Ben Hutchings
This sentence contradicts itself - no actually it doesn't.

--=-hBvg3hkgZJx22/D8ziHr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmODj4YACgkQ57/I7JWG
EQkoFw//VAo67zlrTxZHe2lYe0Ggy+uVwqPDewOAWHaBTb4oR4xyh78CqsJfE8Ul
n8FAKOkPoxofhFFiVVpRDqEcvQ+SxigzmGQHENIM1xivjO8CkxNp9Ee7HYvacl6z
zL18FpRaq5gEvy35xA3fSn8T00hxeDo/Pe1tALWylNnkgrDPYbUH9y8OiJ//BPZh
4JndT+gEhdDuV046NtDj/2RvoXffePAc1mhvdKH5qOYIkz6ibWDmvLi/ug7I84C5
fP30LeNg6WjB2M8y/2SXejdap+B/omSFCx732OohnwUu1FJqSsFET7pV08WBz+ae
mMGN83ODVuWOXY68fwRx6Pup4sCg6eux/+7WqVCFoJd4nrAcquzB80TCfOp9lNEy
q/UEypfRBKGMBOtzfIX2V3QO5R1whrB41zsHjGF43xN/ht2yMYydjO+IzuIGY04Q
pAnyBazXVz5WTZlCbojKExLMgsDbkw7B35OWEpF5xmfhe8+7pxlkM2+th6BNf0ku
Zj+FSgrVvnbfuxD+A0nQN97qbTpITdaCLe8T8inYh1CAVTSVYSi8s2cbL61kVEAC
jaGY7LAN83nzphpX2uw3Zp48K2teHN1pPXbGg56we19HVoIl5EvcS+cU7wSmfDm2
FqXp51wz4t0OFldn6mXVzbiwrwYSqeV0z/l8CyGrVtSUXzdT/h4=
=LsGl
-----END PGP SIGNATURE-----

--=-hBvg3hkgZJx22/D8ziHr--
