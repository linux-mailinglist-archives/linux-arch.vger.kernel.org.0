Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0671738CFE
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjFURXo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 13:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjFURXn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 13:23:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEF9E2;
        Wed, 21 Jun 2023 10:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E87261631;
        Wed, 21 Jun 2023 17:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA3DC433C8;
        Wed, 21 Jun 2023 17:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687368221;
        bh=yquFxCzQam6Y0drsElmHkL74h8to6Lc1Q2IiL+YJBRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VyD8mhPrmxeglu2dnz/8SmT+coOR9iR5uk8FmdNuRrxKhyL8t1ZQtB1Een+krCxgq
         S542OLkbv/0FYm+E+fjlqpQczQuH1sCIkI5ebQovYoOKtC1jV78HRMKsewYN9Ww9EP
         Oy08TLNkeBptOphsCGOcfq4h4L8ugR0MA6yltGok1ovy7LhVdkB5KWUIfqGB5ODW9W
         gY1JiGGwhbLmmugoqB3h0vUfUig1mJPL/WI+jDzO8Fo3KVqdSwqAHD3gzX1CUjYPH3
         pQlgKRJDzYStrDEfzxGQ0SNvvkkbGx7GW56CiNwks3hIXoEpqDTmeqJvD6RaHkF1oX
         lAFoCWrNjoE1w==
Date:   Wed, 21 Jun 2023 18:23:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     ndesaulniers@google.com, jszhang@kernel.org, llvm@lists.linux.dev,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <20230621-quickly-unimpeded-898caf8aeb53@spud>
References: <mhng-8caf7779-aa9e-496a-b2ee-2e6d6d1d76ff@palmer-ri-x1c9a>
 <mhng-861ea8a6-c92c-4a78-a1a6-dfb4df554aee@palmer-ri-x1c9a>
 <20230621-hungrily-pancake-9e1ff5b0b02a@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LluipYX8HrWs/U5U"
Content-Disposition: inline
In-Reply-To: <20230621-hungrily-pancake-9e1ff5b0b02a@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--LluipYX8HrWs/U5U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 05:42:08PM +0100, Conor Dooley wrote:
> On Wed, Jun 21, 2023 at 07:53:59AM -0700, Palmer Dabbelt wrote:
> > On Tue, 20 Jun 2023 17:13:17 PDT (-0700), Palmer Dabbelt wrote:
> > > On Tue, 20 Jun 2023 14:08:33 PDT (-0700), Palmer Dabbelt wrote:
> > >> On Tue, 20 Jun 2023 13:47:07 PDT (-0700), ndesaulniers@google.com wr=
ote:
> > >>> On Tue, Jun 20, 2023 at 4:41=E2=80=AFPM Palmer Dabbelt <palmer@dabb=
elt.com> wrote:
> > >>>>
> > >>>> On Tue, 20 Jun 2023 13:32:32 PDT (-0700), ndesaulniers@google.com =
wrote:
> > >>>> > On Tue, Jun 20, 2023 at 4:13=E2=80=AFPM Conor Dooley <conor@kern=
el.org> wrote:
> > >>>> >>
> > >>>> >> On Tue, Jun 20, 2023 at 04:05:55PM -0400, Nick Desaulniers wrot=
e:
> > >>>> >> > On Mon, Jun 19, 2023 at 6:06=E2=80=AFPM Palmer Dabbelt <palme=
r@dabbelt.com> wrote:
> > >>>> >> > > On Thu, 15 Jun 2023 06:54:33 PDT (-0700), Palmer Dabbelt wr=
ote:
> > >>>> >> > > > On Wed, 14 Jun 2023 09:25:49 PDT (-0700), jszhang@kernel.=
org wrote:
> > >>>> >> > > >> On Wed, Jun 14, 2023 at 07:49:17AM -0700, Palmer Dabbelt=
 wrote:
> > >>>> >> > > >>> On Tue, 23 May 2023 09:54:58 PDT (-0700), jszhang@kerne=
l.org wrote:
> > >>>> >>
> > >>>> >> > > >> Commit 3b90b09af5be ("riscv: Fix orphan section warnings=
 caused by
> > >>>> >> > > >> kernel/pi") touches vmlinux.lds.S, so to make the merge =
easy, this
> > >>>> >> > > >> series is based on 6.4-rc2.
> > >>>> >> > > >
> > >>>> >> > > > Thanks.
> > >>>> >> > >
> > >>>> >> > > Sorry to be so slow here, but I think this is causing LLD t=
o hang on
> > >>>> >> > > allmodconfig.  I'm still getting to the bottom of it, there=
's a few
> > >>>> >> > > other things I have in flight still.
> > >>>> >> >
> > >>>> >> > Confirmed with v3 on mainline (linux-next is pretty red at th=
e moment).
> > >>>> >> > https://lore.kernel.org/linux-riscv/20230517082936.37563-1-fa=
lcon@tinylab.org/
> > >>>> >>
> > >>>> >> Just FYI Nick, there's been some concurrent work here from diff=
erent
> > >>>> >> people working on the same thing & the v3 you linked (from Zhan=
gjin) was
> > >>>> >> superseded by this v2 (from Jisheng).
> > >>>> >
> > >>>> > Ah! I've been testing the deprecated patch set, sorry I just loo=
ked on
> > >>>> > lore for "dead code" on riscv-linux and grabbed the first thread,
> > >>>> > without noticing the difference in authors or new version number=
s for
> > >>>> > distinct series. ok, nevermind my noise.  I'll follow up with the
> > >>>> > correct patch set, sorry!
> > >>>>
> > >>>> Ya, I hadn't even noticed the v3 because I pretty much only look at
> > >>>> patchwork these days.  Like we talked about in IRC, I'm going to g=
o test
> > >>>> the merge of this one and see what's up -- I've got it staged at
> > >>>> <https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/=
commit/?h=3Dfor-next&id=3D1bd2963b21758a773206a1cb67c93e7a8ae8a195>,
> > >>>> though that won't be a stable hash if it's actually broken...
> > >>>
> > >>> Ok, https://lore.kernel.org/linux-riscv/20230523165502.2592-1-jszha=
ng@kernel.org/
> > >>> built for me.  If you're seeing a hang, please let me know what
> > >>> version of LLD you're using and I'll build that tag from source to =
see
> > >>> if I can reproduce, then bisect if so.
> > >>>
> > >>> $ ARCH=3Driscv LLVM=3D1 /usr/bin/time -v make -j128 allmodconfig vm=
linux
> > >>> ...
> > >>>         Elapsed (wall clock) time (h:mm:ss or m:ss): 2:35.68
> > >>> ...
> > >>>
> > >>> Tested-by: Nick Desaulniers <ndesaulniers@google.com> # build
> > >>
> > >> OK, it triggered enough of a rebuild that it might take a bit for
> > >> anything to filter out.
> > >
> > > I'm on LLVM 16.0.2
> > >
> > >     $ git describe
> > >     llvmorg-16.0.2
> > >     $ git log | head -n1
> > >     commit 18ddebe1a1a9bde349441631365f0472e9693520
> > >
> > > that seems to hang for me -- or at least run for an hour without
> > > completing, so I assume it's hung.  I'm not wed to 16.0.2, it just
> > > happens to be the last time I bumped the toolchain.  I'm moving to
> > > 16.0.5 to see if that changes anything.
> >=20
> > That also takes at least an hour to link.  I tried running on LLVM trun=
k=20
> > from last night
> >=20
> >     $ git log | head -n1
> >     commit 5e9173c43a9b97c8614e36d6f754317f731e71e9
> >=20
> > and that completed.  Just as a curiosity I tried to re-spin it to see=
=20
> > how long it takes, and it's been running for 23 minutes so far.
>=20
> After some misdirection through stupid user error, I have also
> reproduced this for an LLVM=3D1 build w/ llvmorg-16.0.0
>=20
> > So I'm no longer actually sure there's a hang, just something slow. =20
> > That's even more of a grey area, but I think it's sane to call a 1-hour=
=20
> > link time a regression -- unless it's expected that this is just very=
=20
> > slow to link?
>=20
> I dunno, if it was only a thing for allyesconfig, then whatever - but
> it's gonna significantly increase build times for any large kernels if LLD
> is this much slower than LD. Regression in my book.
>=20
> I'm gonna go and experiment with mixed toolchain builds, I'll report
> back..

Probably as expected, swapping out LLD for LD linked normally & using
gcc-13.1 + LLD hit the same problems with linking.

Cheers,
Conor.

--LluipYX8HrWs/U5U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJMyGAAKCRB4tDGHoIJi
0kNtAQCUK3HR+LPtaX0t0fhwjTV6Iy1hq0wHj2ZSniC9zB8LqQEA1+QCkN4UMDxo
xey8uu74KLBByxak6tlmOfRttzCSJwY=
=60qR
-----END PGP SIGNATURE-----

--LluipYX8HrWs/U5U--
