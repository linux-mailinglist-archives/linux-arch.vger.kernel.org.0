Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2ED79BBC4
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 02:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbjIKVGK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237489AbjIKMxm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 08:53:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5167ACEB;
        Mon, 11 Sep 2023 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694436818; x=1725972818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F18RZdFWM4GMQROAAbnXFN2k3b4JLezGGc1Iq3gZ/zs=;
  b=Qof1Tn7Drz2q5pJBs19D48KXqtndp0XKgs3tlMDifP76PS338MECL1dh
   WAHlq0xoY3413x9Ban2Nz06RWbaUnazYlREVnPkuBmtj1XKmChE9bgUO/
   1qKK+RKn5M6v6RiuoxrUBr45xcjSm0pgbL5P3aoOzKMQW9X0Vc4LY5wIs
   alLHvVcJ7epXnzlDZzBDE5eowV9oDvRZx9VFc4sRm/n1U0h0ZCh0wvmKN
   AYNlxz6QqdgDcbFHFnpb7ym6k0CXbBo7aatj6c+g8BcbjrzPCiaQut6Wf
   mUyNOChpsyMtz9EqSSWL0V/8fxR2hJ87nCpUURCYcLOA4q9/UidAVnyzp
   A==;
X-CSE-ConnectionGUID: rGMnXp3/ScCh2he0ZE8W7g==
X-CSE-MsgGUID: +aT+43DkQw6jnFnRFXnEkQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="asc'?scan'208";a="3979966"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:53:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 11 Sep 2023 05:53:19 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 11 Sep 2023 05:53:14 -0700
Date:   Mon, 11 Sep 2023 13:52:59 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Guo Ren <guoren@kernel.org>
CC:     Conor Dooley <conor@kernel.org>, <paul.walmsley@sifive.com>,
        <anup@brainfault.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <will@kernel.org>, <palmer@rivosinc.com>, <longman@redhat.com>,
        <boqun.feng@gmail.com>, <tglx@linutronix.de>, <paulmck@kernel.org>,
        <rostedt@goodmis.org>, <rdunlap@infradead.org>,
        <catalin.marinas@arm.com>, <xiaoguang.xing@sophgo.com>,
        <bjorn@rivosinc.com>, <alexghiti@rivosinc.com>,
        <keescook@chromium.org>, <greentime.hu@sifive.com>,
        <ajones@ventanamicro.com>, <jszhang@kernel.org>, <wefu@redhat.com>,
        <wuwei2016@iscas.ac.cn>, <leobras@redhat.com>,
        <linux-arch@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-csky@vger.kernel.org>, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 00/17] riscv: Add Native/Paravirt qspinlock support
Message-ID: <20230911-nimbly-outcome-496efae7adc6@wendy>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910-esteemed-exodus-706aaae940b1@spud>
 <CAJF2gTRQd_dNuZHNwfg3SwD0XERaYXYUdFUFQiarym40kpxFRQ@mail.gmail.com>
 <20230910-baggage-accent-ec5331b58c8e@spud>
 <CAJF2gTS8Vh5XdMUcgLA_GJzW6Nm3JKHxuMN9jYSNe_YCEjgCXA@mail.gmail.com>
 <20230910-facsimile-answering-60d1452b8c10@spud>
 <CAJF2gTSP1rxVhuwOKyWiE2vFFijJFc2aKRU2=0rTK9nDc8AbsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GbfQjpg1lIhwJuEz"
Content-Disposition: inline
In-Reply-To: <CAJF2gTSP1rxVhuwOKyWiE2vFFijJFc2aKRU2=0rTK9nDc8AbsQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--GbfQjpg1lIhwJuEz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 11:36:27AM +0800, Guo Ren wrote:
> On Mon, Sep 11, 2023 at 3:45=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Sun, Sep 10, 2023 at 05:49:13PM +0800, Guo Ren wrote:
> > > On Sun, Sep 10, 2023 at 5:32=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> > > >
> > > > On Sun, Sep 10, 2023 at 05:16:46PM +0800, Guo Ren wrote:
> > > > > On Sun, Sep 10, 2023 at 4:58=E2=80=AFPM Conor Dooley <conor@kerne=
l.org> wrote:
> > > > > >
> > > > > > On Sun, Sep 10, 2023 at 04:28:54AM -0400, guoren@kernel.org wro=
te:
> > > > > >
> > > > > > > Changlog:
> > > > > > > V11:
> > > > > > >  - Based on Leonardo Bras's cmpxchg_small patches v5.
> > > > > > >  - Based on Guo Ren's Optimize arch_spin_value_unlocked patch=
 v3.
> > > > > > >  - Remove abusing alternative framework and use jump_label in=
stead.
> > > > > >
> > > > > > btw, I didn't say that using alternatives was the problem, it w=
as
> > > > > > abusing the errata framework to perform feature detection that =
I had
> > > > > > a problem with. That's not changed in v11.
> > > > > I've removed errata feature detection. The only related patches a=
re:
> > > > >  - riscv: qspinlock: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
> > > > >  - riscv: qspinlock: errata: Enable qspinlock for T-HEAD processo=
rs
> > > > >
> > > > > Which one is your concern? Could you reply on the exact patch thr=
ead? Thx.
> > > >
> > > > riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors
> > > >
> > > > Please go back and re-read the comments I left on v11 about using t=
he
> > > > errata code for feature detection.
> > > >
> > > > > > A stronger forward progress guarantee is not an erratum, AFAICT.
> > > >
> > > > > Sorry, there is no erratum of "stronger forward progress guarante=
e" in the V11.
> > > >
> > > > "riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors" =
still
> > > > uses the errata framework to detect the presence of the stronger fo=
rward
> > > > progress guarantee in v11.
> > > Oh, thx for pointing it out. I could replace it with this:
> > >
> > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > index 88690751f2ee..4be92766d3e3 100644
> > > --- a/arch/riscv/kernel/setup.c
> > > +++ b/arch/riscv/kernel/setup.c
> > > @@ -310,7 +310,8 @@ static void __init riscv_spinlock_init(void)
> > >  {
> > >  #ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > >         if (!enable_qspinlock_key &&
> > > -           (sbi_get_firmware_id() !=3D SBI_EXT_BASE_IMPL_ID_KVM)) {
> > > +           (sbi_get_firmware_id() !=3D SBI_EXT_BASE_IMPL_ID_KVM) &&
> > > +           (sbi_get_mvendorid() !=3D THEAD_VENDOR_ID)) {
> > >                 static_branch_disable(&combo_qspinlock_key);
> > >                 pr_info("Ticket spinlock: enabled\n");
> > >         } else {
> >
> > As I said on v11, I am opposed to feature probing using mvendorid & Co,
> > partially due to the exact sort of check here to see if the kernel is
> > running as a KVM guest. IMO, whether a platform has this stronger

> KVM can't use any fairness lock, so forcing it using a Test-Set lock
> or paravirt qspinlock is the right way. KVM is not a vendor platform.

My point is that KVM should be telling the guest what additional features
it is capable of using, rather than the kernel making some assumptions
based on$vendorid etc that are invalid when the kernel is running as a
KVM guest.
If the mvendorid etc related assumptions were dropped, the kernel would
then default away from your qspinlock & there'd not be a need to
special-case KVM AFAICT.

> > guarantee needs to be communicated by firmware, using ACPI or DT.
> > I made some comments on v11, referring similar discussion about the
> > thead vector stuff. Please go take a look at that.
> I prefer forcing T-HEAD processors using qspinlock, but if all people
> thought it must be in the ACPI or DT, I would compromise. Then, I
> would delete the qspinlock cmdline param patch and move it into DT.
>=20
> By the way, what's the kind of DT format? How about:

I added the new "riscv,isa-extensions" property in part to make
communicating vendor extensions like this easier. Please try to use
that. "qspinlock" is software configuration though, the vendor extension
should focus on the guarantee of strong forward progress, since that is
the non-standard aspect of your IP.

A commandline property may still be desirable, to control the locking
method used, since the DT should be a description of the hardware, not
for configuring software policy in your operating system.

Thanks,
Conor.

>         cpus {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
> +              qspinlock;
>                 cpu0: cpu@0 {
>                         compatible =3D "sifive,bullet0", "riscv";
>                         device_type =3D "cpu";
>                         i-cache-block-size =3D <64>;
>                         i-cache-sets =3D <128>;
>=20
> --
> Best Regards
>  Guo Ren

--GbfQjpg1lIhwJuEz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZP8NqwAKCRB4tDGHoIJi
0ldAAP9GGcetHG7gYZ4HG1QKhxMohQaaxgboYx7iHBroM1TWOQD/ZjZA5Wijf1OK
1IInfX9naDCgcUU+DJfxo1FhU6ifVAA=
=zWg1
-----END PGP SIGNATURE-----

--GbfQjpg1lIhwJuEz--
