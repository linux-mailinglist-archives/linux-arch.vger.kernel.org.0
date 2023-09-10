Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CE6799D7E
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 11:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbjIJJcH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 05:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjIJJcG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 05:32:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F14F19E;
        Sun, 10 Sep 2023 02:32:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32285C433C7;
        Sun, 10 Sep 2023 09:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694338320;
        bh=H01H+tItBe/f1HBCTNs9RWw8RSW5Ihqr0eB54UsfjNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLUdhKDjftvjjo7I97DfdR/Y2b94DcrttCeU2mgWCfkA36iPV5RrQX27R8+zBzEco
         UdBW7niCueVDE0H3zp3Sat3xAsLficyB4Y3NC1EMmqjfnc1Ovbezs2hhsqbi9bL3/h
         /KKpLA9Iv7PGn9ObdSonVy/aeo85HrlnUZNqnShT0FuvXUwgM4RxoJcjlvKkVrllqp
         dKR74igmnnKbIBSedUXCnvUlcUdfT4Gq4rhVAAfJIi0aZsqbdK3mTmH2vVXOcJxhdz
         CurNJ6HGgQZzaZ5AuyB50k98GeaHZQEhxp9n8Ly6DjrMeWr9f9GqpvoEoXysAGInyw
         rA9HF39FXFJcA==
Date:   Sun, 10 Sep 2023 10:31:51 +0100
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
Message-ID: <20230910-baggage-accent-ec5331b58c8e@spud>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910-esteemed-exodus-706aaae940b1@spud>
 <CAJF2gTRQd_dNuZHNwfg3SwD0XERaYXYUdFUFQiarym40kpxFRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yqGJs2961AMnEwR5"
Content-Disposition: inline
In-Reply-To: <CAJF2gTRQd_dNuZHNwfg3SwD0XERaYXYUdFUFQiarym40kpxFRQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--yqGJs2961AMnEwR5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 10, 2023 at 05:16:46PM +0800, Guo Ren wrote:
> On Sun, Sep 10, 2023 at 4:58=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Sun, Sep 10, 2023 at 04:28:54AM -0400, guoren@kernel.org wrote:
> >
> > > Changlog:
> > > V11:
> > >  - Based on Leonardo Bras's cmpxchg_small patches v5.
> > >  - Based on Guo Ren's Optimize arch_spin_value_unlocked patch v3.
> > >  - Remove abusing alternative framework and use jump_label instead.
> >
> > btw, I didn't say that using alternatives was the problem, it was
> > abusing the errata framework to perform feature detection that I had
> > a problem with. That's not changed in v11.
> I've removed errata feature detection. The only related patches are:
>  - riscv: qspinlock: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
>  - riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors
>=20
> Which one is your concern? Could you reply on the exact patch thread? Thx.

riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors

Please go back and re-read the comments I left on v11 about using the
errata code for feature detection.

> > A stronger forward progress guarantee is not an erratum, AFAICT.

> Sorry, there is no erratum of "stronger forward progress guarantee" in th=
e V11.

"riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors" still
uses the errata framework to detect the presence of the stronger forward
progress guarantee in v11.

--yqGJs2961AMnEwR5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZP2NBwAKCRB4tDGHoIJi
0qdtAP45u4IT5Oy1yj6BJRwFwC1nba3CaGiLPESurC9aK1qQAAEAo61KQJ9HCnaq
YE+L9eAoD9bEJUZxgPzyucDNIHRrhQI=
=7tv3
-----END PGP SIGNATURE-----

--yqGJs2961AMnEwR5--
