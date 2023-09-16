Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34017A2B29
	for <lists+linux-arch@lfdr.de>; Sat, 16 Sep 2023 02:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbjIPAFl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 20:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjIPAF3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 20:05:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9F42102;
        Fri, 15 Sep 2023 17:05:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E21C433C8;
        Sat, 16 Sep 2023 00:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694822724;
        bh=vctKEIVGP3jo41NodFrzo2PyPGkaneh5Qtgc7YTfVy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=upwh/GV+3JSILYkPe87ZUKghNshHvukRMJHhvQP3IbYsimJbl+S5W4OhhCGyQeYyU
         M5TPguaN6clvhbXaBW/kjlnKL4yKyu3hHMXFX1a+QihEaLPH/QWeOnIsZEMhoYaiKS
         qhvtO0wAycKQR+CP+oMhRrJpBgd9mo9zXLvhvBqDkY/44K9qyeUGBIQG0/rs4BvXEP
         Q1FSSJYYu4lqRk9jbwRNezA4BB4gkMbGAm6dT7GVMQIkHFEeSmlCeRDDMQGsQz9Jn4
         PQutUyaA0/SasBzef/ZZEFJV3ioPSANwtc5fJdPR5+zBL/zkzk9+Y6noFp/gAJdxKU
         exbgwKrV/NknA==
Date:   Sat, 16 Sep 2023 01:05:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Leonardo Bras <leobras@redhat.com>, guoren@kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, jszhang@kernel.org, wefu@redhat.com,
        wuwei2016@iscas.ac.cn, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 03/17] riscv: Use Zicbop in arch_xchg when available
Message-ID: <20230916-display-mounted-55707daeb175@spud>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-4-guoren@kernel.org>
 <20230914-1ce4f391a14e56b456d88188@orel>
 <ZQQUQjOaAIc95GXP@redhat.com>
 <20230915-85238ac7734cf543bff3ddad@orel>
 <20230915-take-virus-1245c5dfed0a@wendy>
 <20230915-1c2b122672642e2cbcbaaaef@orel>
 <20230915-banana-undusted-ec336f45bc78@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CBSVVsPBvOO/PaEY"
Content-Disposition: inline
In-Reply-To: <20230915-banana-undusted-ec336f45bc78@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--CBSVVsPBvOO/PaEY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 01:42:56PM +0100, Conor Dooley wrote:
>=20
> > > If this isn't being used in a similar manner, then the w has no reason
> > > to be in the odd lowercase form.
> >=20
> > Other than to be consistent... However, the CBO_* instructions are not
> > consistent with the rest of macros. If we don't need lowercase for any
> > reason, then my preference would be to bite the bullet and change all t=
he
> > callsites of CBO_* macros and then introduce this new instruction as
> > PREFETCH_W
>=20
> Aye, I probably should've done it to begin with. Maybe there was some
> other consideration at the time.

FWIW, I sent a patch for this earlier today. I figure you saw it Drew,
but nonetheless:
https://lore.kernel.org/all/20230915-aloe-dollar-994937477776@spud/

--CBSVVsPBvOO/PaEY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQTxOwAKCRB4tDGHoIJi
0tAgAP9WdDjbNTKMkQ31CBU3G4RL71V08fPsy4V0wDAkAgevNAEAyzP9q9ig4Ui7
PSoplGlIAPNmRiyp2N8CL+TEK26fjQ0=
=6kw4
-----END PGP SIGNATURE-----

--CBSVVsPBvOO/PaEY--
