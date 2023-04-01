Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B8F6D2F66
	for <lists+linux-arch@lfdr.de>; Sat,  1 Apr 2023 11:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDAJcT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Apr 2023 05:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDAJcT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Apr 2023 05:32:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8F2CC19;
        Sat,  1 Apr 2023 02:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AC35B80760;
        Sat,  1 Apr 2023 09:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3059C433EF;
        Sat,  1 Apr 2023 09:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680341535;
        bh=A5HEcH0POC1LQ0vBBzRHCMIcClN+LFwasAfQrlGntQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZr15WEFQvk2JjTe5rDaNJERa72I1D5N3iTbwZYVZhm3A8FHrQVJ/zIoyjci9cpTn
         rIckJFN3fk9BuZ6SAJQmwWV7zcH+ENysMgdjkjUHauEbIkWoy1ns+aqXFElH/+ATju
         1wGzr7lLqcsKA5/iA7/9FoJBKfaIH3HqDp34hP5Kn/APT1IKUVvBH1CP0OO2p4n0QL
         UMQa1eKUhagaALNCtxGNDmPSqYf7pUtVa8IqF/g1t++7IqvHYX39SE/r8jEkpyO+E1
         zFtSk3gGP68oPd9Q9kUMbaqCQBmoI28yl19pP2wDgoZgnWMCh3VBLe9khZJ3HpGk9M
         35HuN/nleBrXA==
Date:   Sat, 1 Apr 2023 10:32:08 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, palmer@dabbelt.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>
Subject: Re: [PATCH -next V17 4/7] riscv: entry: Convert to generic entry
Message-ID: <0d07b570-07ac-4a36-a988-b2ffa2a4d433@spud>
References: <20230222033021.983168-1-guoren@kernel.org>
 <20230222033021.983168-5-guoren@kernel.org>
 <60ee7c26-1a70-427d-beaf-92e2989fc479@spud>
 <CAJF2gTQJB3f=80sOsgXpYn7JqfGmq+FSaCwCJ-Er=d7fKhwJcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="N697bhe7hq7YhlHp"
Content-Disposition: inline
In-Reply-To: <CAJF2gTQJB3f=80sOsgXpYn7JqfGmq+FSaCwCJ-Er=d7fKhwJcA@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--N697bhe7hq7YhlHp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2023 at 09:39:32PM -0400, Guo Ren wrote:
> On Fri, Mar 31, 2023 at 2:34=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:

> > [   72.337818] systemd[1]: Failed to start Load Kernel Modules.
> > [FAILED] Failed to start Load Kernel Modules.

> Are you sure, you've compiled all kernel modules? This patch needs all
> kernel stuff re-compiled.

It does this with CONFIG_MODULES=3Dn kernels too FWIW.

--N697bhe7hq7YhlHp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCf6GAAKCRB4tDGHoIJi
0ty8AP4pLw9M1SQ8agp95E8v0ZshSN4g/vspxvoTn3ZBCm1TfgD9FPZ4yEkwdAj/
ar7NYJ22grdRYVRIMczJ3M7lD9nLMgE=
=pMx5
-----END PGP SIGNATURE-----

--N697bhe7hq7YhlHp--
