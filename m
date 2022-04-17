Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FA450461E
	for <lists+linux-arch@lfdr.de>; Sun, 17 Apr 2022 04:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiDQC3I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 16 Apr 2022 22:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiDQC3H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 16 Apr 2022 22:29:07 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB7D2ED41;
        Sat, 16 Apr 2022 19:26:33 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id z15so8159131qtj.13;
        Sat, 16 Apr 2022 19:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w8FEMTX/xuVcdhSUM8I8EwNIenSORDwi1yF5x5D0CQk=;
        b=ZBy2A4iECzemte2fKwK6r8t070Gm4ptN3hs9giRZhZcCNYPTt2iL3fOgu2FEN64Fgq
         SxftzRQMyDbl7IrsOK84dpF4S4Eah2v4o1wgwjJtg3i6/6fUt/a17xYAT3UAVssVn+6X
         nJkPc4e/ZdrvhmxQk7JwAe3g4cWqinDy6hTFIhl3I+GFQr4VAX6Qud2mC3INc/YM1tuX
         oOrBl0yOzvWMWDRMmTB8Jn9Pr2tCgJZxPJ134nit4KZJvv/k1IQ1oKidczYT4RkYBAbs
         rVzbn3AoJxyDwn0ix0HRPwMF9LNVtC8ssmRcGNvZQGFEHE1xtVSnhZX8LR6BKROYKMcb
         D1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w8FEMTX/xuVcdhSUM8I8EwNIenSORDwi1yF5x5D0CQk=;
        b=uvfCxyUI84tx8TeuJ0ssjzQWUxj82A6+mT5ZewP++ChjmaM1a+iHgOU13xwxntx/Hd
         MUqpZdFBRLbVJD2HQWFytmBaX0ElyJzkukzp7wd2gsG3lSFOZHwQn2cck5EBuDaKH7uP
         VfAg/DEAM+I6VE93LxqKcoMSV1g4b0uqqZ3yeEKgSxgWN8OWGgrhUVJPrMmPcZW3qm8s
         VcOvXzmKUU0mYw02Gb82mmp8fIuNMTUh/onIutWgnOr/8edc0X/N+pCSPPLNo9z50loW
         BS+ComIgFc9xwaj5k/mWm7+Be5oVR4MYyy07ZTjDFB1TSjn3khE7HSrKp6FqmivG0RlP
         vQJQ==
X-Gm-Message-State: AOAM530xH+I+EJq4kHyKt1Vk/nTI3rl4rucaHhmpYWXWHcDPpsCsKWht
        Em7GGkY0UDBB2YBJCgIuLs8=
X-Google-Smtp-Source: ABdhPJyw2GkpuOw1P/WLegnCnO+dbJ8IIFJT1EB7sljiwNDV5FPSblx7lE96SyGSt8vM8b118kZB/w==
X-Received: by 2002:a05:622a:1a11:b0:2f1:f173:b7cc with SMTP id f17-20020a05622a1a1100b002f1f173b7ccmr3511640qtb.318.1650162392472;
        Sat, 16 Apr 2022 19:26:32 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m9-20020a05622a118900b002f1fc51135dsm91489qtk.57.2022.04.16.19.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 19:26:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8750127C0054;
        Sat, 16 Apr 2022 22:26:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 16 Apr 2022 22:26:30 -0400
X-ME-Sender: <xms:1XpbYlKWOJCU_a_aBG3Pf3GDF3dNzb823hRtLeqQMA3lTVs6UImfhw>
    <xme:1XpbYhLJszYcMjmBEVA8ZQL0VVrZ8sSdAJ7z0cvys3GOnfGPccc9rhOiErW_MGvVX
    olAGnV34stYlYXfAQ>
X-ME-Received: <xmr:1XpbYtsgK8HbIntoGKhdM016Lp6MHZYQBkXrN6nJ9mwc9mSWIk4LBLiVIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelkedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepheefudejueffjeelkedtgeelleelgfffhffhvdehtdekveehjeeivdejgedu
    udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:1XpbYmYrqXckwhSnNLxDmoPmJs5N7lNITGceY8VWMh6qC3uaP-YCrg>
    <xmx:1XpbYsbiUKK8_jir1dsX-EBRS4PdiaVIb7oIgSgfHhjZc0-rXwUmoQ>
    <xmx:1XpbYqAOnQv0upnmUu0gRsSUhwtyywMYTzO_4fusVDMmRfq8HNc0pg>
    <xmx:1npbYoTBPvLdyCOGvo143JTe1woY3JfYh04h1ntD-uXopNmHsC21vg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Apr 2022 22:26:28 -0400 (EDT)
Date:   Sun, 17 Apr 2022 10:26:22 +0800
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
Message-ID: <Ylt6zqPgimmKpJzg@tardis>
References: <20220412034957.1481088-1-guoren@kernel.org>
 <YlbwOG46mCR8Q5tJ@tardis>
 <CAJF2gTRws6RqKmJHBdKsycWSkFgYna_MocJ+qp3Z9r1v7mQzsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gsEGlVkScL5MXyzb"
Content-Disposition: inline
In-Reply-To: <CAJF2gTRws6RqKmJHBdKsycWSkFgYna_MocJ+qp3Z9r1v7mQzsg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--gsEGlVkScL5MXyzb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 17, 2022 at 12:49:44AM +0800, Guo Ren wrote:
[...]
>=20
> If both the aq and rl bits are set, the atomic memory operation is
> sequentially consistent and cannot be observed to happen before any
> earlier memory operations or after any later memory operations in the
> same RISC-V hart and to the same address domain.
>                 "0:     lr.w     %[p],  %[c]\n"
>                 "       sub      %[rc], %[p], %[o]\n"
>                 "       bltz     %[rc], 1f\n".
> -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> +               "       sc.w.aqrl %[rc], %[rc], %[c]\n"
>                 "       bnez     %[rc], 0b\n"
> -               "       fence    rw, rw\n"
>                 "1:\n"
> So .rl + fence rw, rw is over constraints, only using sc.w.aqrl is more p=
roper.
>=20

Can .aqrl order memory accesses before and after it (not against itself,
against each other), i.e. act as a full memory barrier? For example, can
we end up with u =3D=3D 1, v =3D=3D 1, r1 on P0 is 0 and r1 on P1 is 0, for=
 the
following litmus test?

    C lr-sc-aqrl-pair-vs-full-barrier
   =20
    {}
   =20
    P0(int *x, int *y, atomic_t *u)
    {
            int r0;
            int r1;
   =20
            WRITE_ONCE(*x, 1);
            r0 =3D atomic_cmpxchg(u, 0, 1);
            r1 =3D READ_ONCE(*y);
    }
   =20
    P1(int *x, int *y, atomic_t *v)
    {
            int r0;
            int r1;
   =20
            WRITE_ONCE(*y, 1);
            r0 =3D atomic_cmpxchg(v, 0, 1);
            r1 =3D READ_ONCE(*x);
    }
   =20
    exists (u=3D1 /\ v=3D1 /\ 0:r1=3D0 /\ 1:r1=3D0)

Regards,
Boqun

--gsEGlVkScL5MXyzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmJbesoACgkQSXnow7UH
+rie9Af/UTwzwnSrsPDa9Dt5IvnF9QCWblr10PoMYKlA7wHaAC7xRVicoRsmLAXF
zIlFIQEcZdxH3/o7cVOtaFDRaNoY6q667AxcTP+vzwcTBoWIAvSo7kip2ZtTAtbE
8sj/bm+AiMfAet+sJ/I0gQNm3wPC3Q0MH5XcuGTpDZQlGny+/mB5s42Ii8vpt+UJ
fgHdn8TqJ4m+PURvx8Rzumv9Uz6y6X8C4/VgZTNOVA3de1tcGw6kinIvOAML8F+v
mAyg5MBo3DJ2Egh4aE1bzNvcfH97MbUJIAECztxhTKcgd77I16hBhhdtZoHRkZYR
6vmBhnqkQm8683s2qqt2HOUZlmrfJQ==
=Fcy2
-----END PGP SIGNATURE-----

--gsEGlVkScL5MXyzb--
