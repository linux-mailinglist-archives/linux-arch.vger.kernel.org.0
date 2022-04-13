Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FA04FFA96
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 17:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiDMPse (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 11:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiDMPsd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 11:48:33 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD43A5EBF7;
        Wed, 13 Apr 2022 08:46:11 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b189so1712992qkf.11;
        Wed, 13 Apr 2022 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1YdLQXxMOH03x0SbnGmKpWrPU6dm2R7TxKypWUEVbgQ=;
        b=N/5+rE05+wJmxX89f5a2Dz/r6Gp205oy9BOnTqiTZF7l9Y5vVpWcvsfpxfraZ/Y7Xt
         3MROOCvvSLcekz4PRkWNLWGxUl4YCX8xD3sKvNMse3NTnPFyPa/gEaMbEUVAiSwXupJc
         dqttYsb+nzr4FRMNrBwXwd3hz4Br4LuKqgbR+L/yAg1bIvPn8FErdyW9aU/vMdds9ZX1
         Ij5xEPKixKBlkp8BqT2K641J2keHtI8bfjq9iULbWq3FzNv6MqsYN7ehORgGUzhEuFAv
         8gf8uLCNXroOVEE2gl9eMggstv2bmY0Z9By7PIrFSZChD8kiEKJ4E16YYaDYutzVVvfQ
         hJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1YdLQXxMOH03x0SbnGmKpWrPU6dm2R7TxKypWUEVbgQ=;
        b=48gcV861XK88SwmO+K1mFWbboHKzkCb8/6PPkNmn72QKvxcMc0s1cEURq2RoqeLrW6
         Oe3jPA460k/2r4XRmiiC++pU5pd1Ni45NKuGPpt5WH3IwshXOZF5sZWgwAjJypSNWW/s
         u2aetzrJ4nBD+2fshsPCDArJxYcf3OiZMzGkQhjq0QpT6jVIQFptoBky/aCnklP2c3au
         JycjoXp3QaWdquFMJgnrkDLVqIFnrIJuMsmddHR28mt6R42II5elfdQD5Nlpn73gR4U0
         kC/Hz/6BuQzXwcWg9h/TV7vfFaZFwcbjeIMGTE+EpmeTfPvkudlz0ogzIhB4RxS3r3Ll
         POPw==
X-Gm-Message-State: AOAM532MiqPAIOu2L7Ms4WnuFOIU7xWpwDe3VdK1hLJE0nGp2e5cfKiP
        /J6naVmthXi6MOk7YnwoG+d5tI5kQxA=
X-Google-Smtp-Source: ABdhPJwucGmNCNzNG5RX1VXPuLCdwMFZeNJYY+st3YU+BqtTMgL90GMQoqUyb8tpFQO3S5dXc/Bcjw==
X-Received: by 2002:a37:389:0:b0:69b:f56e:1672 with SMTP id 131-20020a370389000000b0069bf56e1672mr7463010qkd.614.1649864770825;
        Wed, 13 Apr 2022 08:46:10 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 2-20020a05620a070200b0069c231ab4a9sm5351832qkc.16.2022.04.13.08.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:46:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9B8BD27C005A;
        Wed, 13 Apr 2022 11:46:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 13 Apr 2022 11:46:08 -0400
X-ME-Sender: <xms:P_BWYiQedrJBlnrkpQdIcsCc7hFTsPI0L7yWwa4BV7HIb4YG4CIQhQ>
    <xme:P_BWYnxJhWRjCWjO6KLRlldt_tZ5c67hmLXR5DaQ5TsF3PLCQ3OWS0exShUpuWrmQ
    941FaZ6ztTOFRAhaA>
X-ME-Received: <xmr:P_BWYv0Jdsrpiy41epwEZa6weK_4rZPLqwKgaq8eWkSDRQ_nOb2Hp0entQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeluddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepheefudejueffjeelkedtgeelleelgfffhffhvdehtdekveehjeeivdejgedu
    udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:P_BWYuD6WiFuchiGBVOVEkc3jIF5jJtpq-YT7juylSfnP0EXIyeSog>
    <xmx:P_BWYrjV5bPEaPU14ER2Q6kh3yMOu3DqAf-qgL1yUdcLo4FloLDDKQ>
    <xmx:P_BWYqrrZS3ZbYKqR54cNSrrP2v528-Jxxm5MLK6Pq1cqso_liHivQ>
    <xmx:QPBWYgZGzeB2-jB3xuemWJbTtBt6WL_jAwARAn7XOLwOV3JlTL16VQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 11:46:04 -0400 (EDT)
Date:   Wed, 13 Apr 2022 23:46:00 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@dabbelt.com, mark.rutland@arm.com,
        will@kernel.org, peterz@infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH V2 0/3] riscv: atomic: Optimize AMO instructions usage
Message-ID: <YlbwOG46mCR8Q5tJ@tardis>
References: <20220412034957.1481088-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3IglbufFOlP6AShH"
Content-Disposition: inline
In-Reply-To: <20220412034957.1481088-1-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--3IglbufFOlP6AShH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc Andrea]

On Tue, Apr 12, 2022 at 11:49:54AM +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> These patch series contain one cleanup and some optimizations for
> atomic operations.
>=20

Seems to me that you are basically reverting 5ce6c1f3535f
("riscv/atomic: Strengthen implementations with fences"). That commit
fixed an memory ordering issue, could you explain why the issue no
longer needs a fix?

Regards,
Boqun

> Changes in V2:
>  - Fixup LR/SC memory barrier semantic problems which pointed by
>    Rutland
>  - Combine patches into one patchset series
>  - Separate AMO optimization & LRSC optimization for convenience
>    patch review
>=20
> Guo Ren (3):
>   riscv: atomic: Cleanup unnecessary definition
>   riscv: atomic: Optimize acquire and release for AMO operations
>   riscv: atomic: Optimize memory barrier semantics of LRSC-pairs
>=20
>  arch/riscv/include/asm/atomic.h  | 70 ++++++++++++++++++++++++++++++--
>  arch/riscv/include/asm/cmpxchg.h | 42 +++++--------------
>  2 files changed, 76 insertions(+), 36 deletions(-)
>=20
> --=20
> 2.25.1
>=20

--3IglbufFOlP6AShH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmJW8DMACgkQSXnow7UH
+rj7oQf+M4BWYub6wHMeoa6yx+iNDGo5x5qEHT1XmIZjZUrpk3Nl3YNVCrZq9oaf
6IwoRm1XKJhmlrkqUcrp0P8Bm/mq6PZ1mOTdSRtW3cp6mmjl+y6zhidet3KOJJFp
gZz8CquT+PbQaNsnUMwWoosE85hL8FG/XYTQhoiCFVKF7PeqyFix2doCw66nRzvY
Wdj458el5Yf+XrEIzEBsrBHCeSdBRiqjulU+SHBbtivfhoaIvpjKdvBOBxF9CC7+
DI0HuLWz38I6coBeHOmo64WoC8amPCi8xVUZvUgFdUGMSRT25elqoS0qSbq9Afm2
npRG/rZbHDLvSC1t4rCiN+HS1lVQYw==
=lcp2
-----END PGP SIGNATURE-----

--3IglbufFOlP6AShH--
