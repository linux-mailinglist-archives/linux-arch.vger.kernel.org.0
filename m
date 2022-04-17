Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5EA5046D3
	for <lists+linux-arch@lfdr.de>; Sun, 17 Apr 2022 08:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiDQGdi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Apr 2022 02:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiDQGdh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Apr 2022 02:33:37 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AFF21E37;
        Sat, 16 Apr 2022 23:31:00 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id y19so9089739qvk.5;
        Sat, 16 Apr 2022 23:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vfmh10AIjKhxbv0qitn8kLvuk+Cu75U8u1UgKPRnj9Y=;
        b=PZXa7U1As9//OVTHp6l3Oy8K28hLO82xDGAtXw8wM5HfB+XFJ7jThau3k40bb5Sr16
         gjTzXJKLzp4B53OdD04OofHerzOxRXw18S7unz3EBkY0x2EfeMy0LEyi5+TIgXDH/qiG
         45AYfEgPAHAtFp4lCVqnmM67lVrF2ydoAZB6wCnLZUaGSpcrJ725eymTorimq2x/3JUX
         ss5G4xchV2sNS+1NG58DDDK+jr02md8Z9/OC9XEvOiVOGWoN3Cf5jsq2/YiR+PM5sG62
         4lg1KB4a9X84fdEobAAWIenuz8+qWyReWIRXXt2b+jufl4NJW0ajQ67qYH/baw0y5k7a
         heAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vfmh10AIjKhxbv0qitn8kLvuk+Cu75U8u1UgKPRnj9Y=;
        b=sCrucXKDtbOmKVAy0cPAmNOZEKKt/HGL3UjKP7CnoC2NdQdKTpIrRvwvDzqx0PUxfp
         PgzeoAOJB3kJLytwTO8qHq2aFg/aSZKSe+GL0FWOmVjqaU5+XPpf25doEos9892RKQFB
         JBHmKYJH0LMef9CFtP0sSFUHPaOdwd1IhaZj4bnfXBkHyCrbbHZ6hvbALSMZV0ZVJnfG
         AEsoAlrPIlRKX/2qnSB38wKR2wml9wXc3mcPLGH5TE+4741zBkCpWAnow0nWiojo+VUa
         ZYe4AFOHYM3qnBlcDKGqbDX7D5UbskR3uXcukf/y01tfi5MKmBtv4AxYYiIIQ4ibvoPB
         NjEg==
X-Gm-Message-State: AOAM533RUiPWV8iMDEb+Hqk0loBniVJFVN7bHL5G07xPIpte0ZY/KVQt
        akClKHF2Hx1vEaiD0yq7EWxmNNYgZOk=
X-Google-Smtp-Source: ABdhPJw5kru0ZzWwBoz0EiP7bnB0qBsfZYqWwUQ20W1IwiFlov9NAQNt7XqQ/Us3KbHNjzsg3OKpeA==
X-Received: by 2002:a05:6214:260e:b0:446:4518:7445 with SMTP id gu14-20020a056214260e00b0044645187445mr4059905qvb.101.1650177059720;
        Sat, 16 Apr 2022 23:30:59 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t198-20020a3746cf000000b0069c51337badsm4857876qka.45.2022.04.16.23.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 23:30:58 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0106827C0054;
        Sun, 17 Apr 2022 02:30:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 17 Apr 2022 02:30:58 -0400
X-ME-Sender: <xms:ILRbYtSo2K2vhL94n_CFsnqBGYxWOIOMJ73__0Cd6GQbIIisObVQpg>
    <xme:ILRbYmx2VHAMuEje92BJ7g15alNTmZDSUaqNQJctEmkrZouFRTaAF2RJjbOmod8MK
    Ovmd-cPQiyNEcBAaA>
X-ME-Received: <xmr:ILRbYi3MS4HpDJgoUIPpiKUC20-sf8UgVSShU82FyHWLqtbC19R3p9SKXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelkedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeuveegvdfgleegjeefjeevuddtjeehtddvgfdthfdtkeevledvuedtfefh
    fedugeenucffohhmrghinhepthhhvgdrrghqpdhkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhe
    dvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ILRbYlDJFauU92YO2D0vX1XpXk-mTdMMOQUg7mcKOnY9dVLrj17mZw>
    <xmx:ILRbYmhbKJ2O6kVdiTBQ7D0eCImMLtf3llmmEfi577VMFWApztXkwg>
    <xmx:ILRbYpr3FCG2I6gRVZumAoFSMUnA1zPY_oMCEvBuAZa8tl-GGDiqSg>
    <xmx:IbRbYnYQDtNAYtxXM6ugRPBGXAPsEOkQ5vZ6fXusiZqcONgNMYfW6w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Apr 2022 02:30:54 -0400 (EDT)
Date:   Sun, 17 Apr 2022 14:30:50 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 0/3] riscv: atomic: Optimize AMO instructions usage
Message-ID: <Ylu0GqNmYmCnpv9Z@tardis>
References: <20220412034957.1481088-1-guoren@kernel.org>
 <YlbwOG46mCR8Q5tJ@tardis>
 <CAJF2gTRws6RqKmJHBdKsycWSkFgYna_MocJ+qp3Z9r1v7mQzsg@mail.gmail.com>
 <Ylt6zqPgimmKpJzg@tardis>
 <CAJF2gTTZnBh_z31VK81cYiBrTt5NRVpSahoPh35Zo4Ns5hCv7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eKl0vpmQLAWLx6Dq"
Content-Disposition: inline
In-Reply-To: <CAJF2gTTZnBh_z31VK81cYiBrTt5NRVpSahoPh35Zo4Ns5hCv7A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--eKl0vpmQLAWLx6Dq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 17, 2022 at 12:51:38PM +0800, Guo Ren wrote:
> Hi Boqun & Andrea,
>=20
> On Sun, Apr 17, 2022 at 10:26 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Sun, Apr 17, 2022 at 12:49:44AM +0800, Guo Ren wrote:
> > [...]
> > >
> > > If both the aq and rl bits are set, the atomic memory operation is
> > > sequentially consistent and cannot be observed to happen before any
> > > earlier memory operations or after any later memory operations in the
> > > same RISC-V hart and to the same address domain.
> > >                 "0:     lr.w     %[p],  %[c]\n"
> > >                 "       sub      %[rc], %[p], %[o]\n"
> > >                 "       bltz     %[rc], 1f\n".
> > > -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > > +               "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> > >                 "       bnez     %[rc], 0b\n"
> > > -               "       fence    rw, rw\n"
> > >                 "1:\n"
> > > So .rl + fence rw, rw is over constraints, only using sc.w.aqrl is mo=
re proper.
> > >
> >
> > Can .aqrl order memory accesses before and after it (not against itself,
> > against each other), i.e. act as a full memory barrier? For example, can
> From the RVWMO spec description, the .aqrl annotation appends the same
> effect with "fence rw, rw" to the AMO instruction, so it's RCsc.
>=20

Thanks for the confirmation, btw, where can I find the RVWMO spec?

> Not only .aqrl, and I think the below also could be an RCsc when
> sc.w.aq is executed:
> A: Pre-Access
> B: lr.w.rl ADDR-0
> ...
> C: sc.w.aq ADDR-0
> D: Post-Acess
> Because sc.w.aq has overlap address & data dependency on lr.w.rl, the
> global memory order should be A->B->C->D when sc.w.aq is executed. For
> the amoswap
>=20
> The purpose of the whole patchset is to reduce the usage of
> independent fence rw, rw instructions, and maximize the usage of the
> .aq/.rl/.aqrl aonntation of RISC-V.
>=20
>                 __asm__ __volatile__ (                                  \
>                         "0:     lr.w %0, %2\n"                          \
>                         "       bne  %0, %z3, 1f\n"                     \
>                         "       sc.w.rl %1, %z4, %2\n"                  \
>                         "       bnez %1, 0b\n"                          \
>                         "       fence rw, rw\n"                         \
>                         "1:\n"                                          \
>=20
> > we end up with u =3D=3D 1, v =3D=3D 1, r1 on P0 is 0 and r1 on P1 is 0,=
 for the
> > following litmus test?
> >
> >     C lr-sc-aqrl-pair-vs-full-barrier
> >
> >     {}
> >
> >     P0(int *x, int *y, atomic_t *u)
> >     {
> >             int r0;
> >             int r1;
> >
> >             WRITE_ONCE(*x, 1);
> >             r0 =3D atomic_cmpxchg(u, 0, 1);
> >             r1 =3D READ_ONCE(*y);
> >     }
> >
> >     P1(int *x, int *y, atomic_t *v)
> >     {
> >             int r0;
> >             int r1;
> >
> >             WRITE_ONCE(*y, 1);
> >             r0 =3D atomic_cmpxchg(v, 0, 1);
> >             r1 =3D READ_ONCE(*x);
> >     }
> >
> >     exists (u=3D1 /\ v=3D1 /\ 0:r1=3D0 /\ 1:r1=3D0)
> I think my patchset won't affect the above sequence guarantee. Current
> RISC-V implementation only gives RCsc when the original value is the
> same at least once. So I prefer RISC-V cmpxchg should be:
>=20
>=20
> -                       "0:     lr.w %0, %2\n"                          \
> +                      "0:     lr.w.rl %0, %2\n"                         =
 \
>                         "       bne  %0, %z3, 1f\n"                     \
>                         "       sc.w.rl %1, %z4, %2\n"                  \
>                         "       bnez %1, 0b\n"                          \
> -                       "       fence rw, rw\n"                         \
>                         "1:\n"                                          \
> +                        "       fence w, rw\n"                    \
>=20
> To give an unconditional RSsc for atomic_cmpxchg.
>=20

Note that Linux kernel doesn't require cmpxchg() to provide any order if
cmpxchg() fails to update the memory location. So you won't need to
strengthen the atomic_cmpxchg().

Regards,
Boqun

> >
> > Regards,
> > Boqun
>=20
>=20
>=20
> --=20
> Best Regards
>  Guo Ren
>=20
> ML: https://lore.kernel.org/linux-csky/

--eKl0vpmQLAWLx6Dq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmJbtBcACgkQSXnow7UH
+rhsSgf/Yes71uP9q+qTNbrCUmjS5/wiBJPUbWlgx7JKTXgawyX72Raimw4rjlFo
9UT8KiZPQ76BEEd74fq8paTgy4GHu8XzAdtOQBPJ/CbAkfuDc0Z9/4e4ZwsXDaBc
/a6krWcGbouzS+2RVi/k0G6+EXbz8cBY6ORQ//7nseylrzaDcZtA7oAEx09PpVUq
7C8p/O+JLlCRj+W/CgOew3j1yK10HZ6BGkohfIM92r6GA3ArlHvuGmgYMrO0xuzZ
PZTx3HDwZbh98wiwBc3/xL+CnH8R7ffS9eTHvNO2GWebwIAiP7a/iQPbvGvyhwrf
xGcVLQRVB3NzKuTCASxcpR91L+r9FA==
=pKCs
-----END PGP SIGNATURE-----

--eKl0vpmQLAWLx6Dq--
