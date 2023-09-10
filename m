Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBC7799F88
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 21:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjIJTp6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 15:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjIJTp5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 15:45:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D2412C;
        Sun, 10 Sep 2023 12:45:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA571C433C8;
        Sun, 10 Sep 2023 19:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694375152;
        bh=y3LT/R5kddG6jRISOgX3O0b1AfwlsqmAKG5NrInJc5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4LRUq+GNjS1nxT6CjBfu+Kauv5mxEdU5FGaIxmYPwyn9l674yDbMBakGr//9qPCW
         HDsmv6ZgT92MGhi5kjsP8Q/gZldYSFC3PD6kji9VI1DLjbB7oSSZcAfOGqc3os7R5m
         NJuo/islUaX6qqopQMbVNySFN5OwLvDypjthia3kvDAg0//QiwDOaxxJCTh5ujbI+r
         r3RLRC7Etrmzh7hWVpAS/dNI9hKoAMjpwAQ0xSAm+rqCeFLXHZu6vhPLQBydVbQq12
         lmXgiiQXbjop+sPE6i0CE7xlE8U8iSP9cZXPcLsbmEBipgj1nnB5RSkO99H0wpVDUR
         +6F+d2sx4tqHw==
Date:   Sun, 10 Sep 2023 20:45:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        leobras@redhat.com, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 00/17] riscv: Add Native/Paravirt qspinlock support
Message-ID: <20230910-facsimile-answering-60d1452b8c10@spud>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910-esteemed-exodus-706aaae940b1@spud>
 <CAJF2gTRQd_dNuZHNwfg3SwD0XERaYXYUdFUFQiarym40kpxFRQ@mail.gmail.com>
 <20230910-baggage-accent-ec5331b58c8e@spud>
 <CAJF2gTS8Vh5XdMUcgLA_GJzW6Nm3JKHxuMN9jYSNe_YCEjgCXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FcTODDigvcxHiRXq"
Content-Disposition: inline
In-Reply-To: <CAJF2gTS8Vh5XdMUcgLA_GJzW6Nm3JKHxuMN9jYSNe_YCEjgCXA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--FcTODDigvcxHiRXq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 10, 2023 at 05:49:13PM +0800, Guo Ren wrote:
> On Sun, Sep 10, 2023 at 5:32=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Sun, Sep 10, 2023 at 05:16:46PM +0800, Guo Ren wrote:
> > > On Sun, Sep 10, 2023 at 4:58=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> > > >
> > > > On Sun, Sep 10, 2023 at 04:28:54AM -0400, guoren@kernel.org wrote:
> > > >
> > > > > Changlog:
> > > > > V11:
> > > > >  - Based on Leonardo Bras's cmpxchg_small patches v5.
> > > > >  - Based on Guo Ren's Optimize arch_spin_value_unlocked patch v3.
> > > > >  - Remove abusing alternative framework and use jump_label instea=
d.
> > > >
> > > > btw, I didn't say that using alternatives was the problem, it was
> > > > abusing the errata framework to perform feature detection that I had
> > > > a problem with. That's not changed in v11.
> > > I've removed errata feature detection. The only related patches are:
> > >  - riscv: qspinlock: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
> > >  - riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors
> > >
> > > Which one is your concern? Could you reply on the exact patch thread?=
 Thx.
> >
> > riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors
> >
> > Please go back and re-read the comments I left on v11 about using the
> > errata code for feature detection.
> >
> > > > A stronger forward progress guarantee is not an erratum, AFAICT.
> >
> > > Sorry, there is no erratum of "stronger forward progress guarantee" i=
n the V11.
> >
> > "riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors" still
> > uses the errata framework to detect the presence of the stronger forward
> > progress guarantee in v11.
> Oh, thx for pointing it out. I could replace it with this:
>=20
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 88690751f2ee..4be92766d3e3 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -310,7 +310,8 @@ static void __init riscv_spinlock_init(void)
>  {
>  #ifdef CONFIG_RISCV_COMBO_SPINLOCKS
>         if (!enable_qspinlock_key &&
> -           (sbi_get_firmware_id() !=3D SBI_EXT_BASE_IMPL_ID_KVM)) {
> +           (sbi_get_firmware_id() !=3D SBI_EXT_BASE_IMPL_ID_KVM) &&
> +           (sbi_get_mvendorid() !=3D THEAD_VENDOR_ID)) {
>                 static_branch_disable(&combo_qspinlock_key);
>                 pr_info("Ticket spinlock: enabled\n");
>         } else {

As I said on v11, I am opposed to feature probing using mvendorid & Co,
partially due to the exact sort of check here to see if the kernel is
running as a KVM guest. IMO, whether a platform has this stronger
guarantee needs to be communicated by firmware, using ACPI or DT.
I made some comments on v11, referring similar discussion about the
thead vector stuff. Please go take a look at that.

--FcTODDigvcxHiRXq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZP4c6AAKCRB4tDGHoIJi
0ufzAQDyDyGN2Md5XT9ACjrp5SGyIPvMbchiOqhgvTVmc7yOaQEAxRbNy/jXdJGm
2/gUe8tsoFaT3nlOeKvjVkQDjoH62gk=
=jMZv
-----END PGP SIGNATURE-----

--FcTODDigvcxHiRXq--
