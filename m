Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B37F700B26
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 17:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbjELPQj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 11:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjELPQi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 11:16:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2F05B83;
        Fri, 12 May 2023 08:16:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F38BB619E8;
        Fri, 12 May 2023 15:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D97C433D2;
        Fri, 12 May 2023 15:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683904596;
        bh=ItBiuuoHk339tQKWgm8j5U2FpP7r7TgrlJGgcZEAbvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ndHJVMMFETLe4lDExw6SIPL4nw6NLJcGJJx1VGPch4V+IeIlg4iU7wCQj/jq2u91C
         ejH7bJNnnC0Mli8l16zNL8JdbwzRdsZepRinXMNYliQIPfwM7LzErYv+IgxaPF81xd
         ifh3YRh+xbqVDoqsDHp6cYIcV+L5b8t39x6U55hY7gZYGCHnFQIYSce5UsgWFgZGya
         LfZeDk5WDtj2QQTZQKJY+guBXsLxBNPWUdcn3/m6dzWrEe3Pg7IN9x33UUfdJytdVh
         N7w7OwHu7UxHEE665vCtHighM3z125RfaHlkg8XrPV29UXV02lFkytwCmpfkBURRSo
         bMkqlaye2SY/g==
Date:   Fri, 12 May 2023 16:16:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <20230512-garage-slacked-d16268c0726e@spud>
References: <20230511141211.2418-1-jszhang@kernel.org>
 <20230511141211.2418-5-jszhang@kernel.org>
 <20230512-spouse-pang-87f2e579baa2@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kv6NHahiFFm1mD9D"
Content-Disposition: inline
In-Reply-To: <20230512-spouse-pang-87f2e579baa2@wendy>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--Kv6NHahiFFm1mD9D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 02:58:49PM +0100, Conor Dooley wrote:
> On Thu, May 11, 2023 at 10:12:11PM +0800, Jisheng Zhang wrote:
>=20
> > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinu=
x.lds.S
> > index e5f9f4677bbf..492dd4b8f3d6 100644
> > --- a/arch/riscv/kernel/vmlinux.lds.S
> > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > @@ -85,11 +85,11 @@ SECTIONS
> >  	INIT_DATA_SECTION(16)
> > =20
> >  	.init.pi : {
> > -		*(.init.pi*)
> > +		KEEP(*(.init.pi*))
> >  	}
>=20
> This section no longer exists in v6.4-rc1, it is now:
> 	/* Those sections result from the compilation of kernel/pi/string.c */
> 	.init.pidata : {
> 		*(.init.srodata.cst8*)
> 		*(.init__bug_table*)
> 		*(.init.sdata*)
> 	}

Ahh, I see what has happened. This series was made on top of
riscv/fixes, but none of the patches are marked as a fix, leading to the
automation testing this as new content.

Sorry for the noise on this patch.

--Kv6NHahiFFm1mD9D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF5YTwAKCRB4tDGHoIJi
0gywAQDm4p8mpPMSf/YkFLVJPL1Yi98TnShIx2mbVU6fteJ8bQEAzVE38AtBXSBu
Jffr2efCJuttkQXrA/O97rbQmBfzJwk=
=rZde
-----END PGP SIGNATURE-----

--Kv6NHahiFFm1mD9D--
