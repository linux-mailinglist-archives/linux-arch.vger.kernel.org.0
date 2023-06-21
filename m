Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E8A738BC9
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 18:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjFUQms (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 12:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjFUQmX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 12:42:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318222106;
        Wed, 21 Jun 2023 09:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8475615F7;
        Wed, 21 Jun 2023 16:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A93CC433C8;
        Wed, 21 Jun 2023 16:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687365733;
        bh=FfaBg5slDXiBIl/G9ncJYT509r6SADoRGOfo1kG0lqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcZgCWWzRxndVUInZWPJkdsIIhc2UGgGRRIAJVLbhzMzACW7z7Ux+ngAzeLh083h0
         XTURDyUDxupRXlw35akMeLi8J5+gSciHqxadUx8PLe/mtED/psnHbQx/TZBZVKAhyo
         JQXvxyiSHIt0in/JhCF6h0H61lTfCJZjkt3MFanUk9sVfA/uRKkJzeRcSTTOpEhOrG
         3M4fSDv7T/8DQlBTvYJ9HIgsS/Vmnu+K2YDpKLrhgIREV3OHApQE3RHRIF+8NEozre
         DQ1CiDczCl1vCfRUxh2zkXwbfAbHAe6JtlxxLkRfJh9Pwy+Z+IsD2uFnD2MP9YTh5c
         5wZ/e+0Z4nvhg==
Date:   Wed, 21 Jun 2023 17:42:08 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     ndesaulniers@google.com, jszhang@kernel.org, llvm@lists.linux.dev,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <20230621-hungrily-pancake-9e1ff5b0b02a@spud>
References: <mhng-8caf7779-aa9e-496a-b2ee-2e6d6d1d76ff@palmer-ri-x1c9a>
 <mhng-861ea8a6-c92c-4a78-a1a6-dfb4df554aee@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qKbzBWp+WnU9QIpu"
Content-Disposition: inline
In-Reply-To: <mhng-861ea8a6-c92c-4a78-a1a6-dfb4df554aee@palmer-ri-x1c9a>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--qKbzBWp+WnU9QIpu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 07:53:59AM -0700, Palmer Dabbelt wrote:
> On Tue, 20 Jun 2023 17:13:17 PDT (-0700), Palmer Dabbelt wrote:
> > On Tue, 20 Jun 2023 14:08:33 PDT (-0700), Palmer Dabbelt wrote:
> >> On Tue, 20 Jun 2023 13:47:07 PDT (-0700), ndesaulniers@google.com wrot=
e:
> >>> On Tue, Jun 20, 2023 at 4:41=E2=80=AFPM Palmer Dabbelt <palmer@dabbel=
t.com> wrote:
> >>>>
> >>>> On Tue, 20 Jun 2023 13:32:32 PDT (-0700), ndesaulniers@google.com wr=
ote:
> >>>> > On Tue, Jun 20, 2023 at 4:13=E2=80=AFPM Conor Dooley <conor@kernel=
=2Eorg> wrote:
> >>>> >>
> >>>> >> On Tue, Jun 20, 2023 at 04:05:55PM -0400, Nick Desaulniers wrote:
> >>>> >> > On Mon, Jun 19, 2023 at 6:06=E2=80=AFPM Palmer Dabbelt <palmer@=
dabbelt.com> wrote:
> >>>> >> > > On Thu, 15 Jun 2023 06:54:33 PDT (-0700), Palmer Dabbelt wrot=
e:
> >>>> >> > > > On Wed, 14 Jun 2023 09:25:49 PDT (-0700), jszhang@kernel.or=
g wrote:
> >>>> >> > > >> On Wed, Jun 14, 2023 at 07:49:17AM -0700, Palmer Dabbelt w=
rote:
> >>>> >> > > >>> On Tue, 23 May 2023 09:54:58 PDT (-0700), jszhang@kernel.=
org wrote:
> >>>> >>
> >>>> >> > > >> Commit 3b90b09af5be ("riscv: Fix orphan section warnings c=
aused by
> >>>> >> > > >> kernel/pi") touches vmlinux.lds.S, so to make the merge ea=
sy, this
> >>>> >> > > >> series is based on 6.4-rc2.
> >>>> >> > > >
> >>>> >> > > > Thanks.
> >>>> >> > >
> >>>> >> > > Sorry to be so slow here, but I think this is causing LLD to =
hang on
> >>>> >> > > allmodconfig.  I'm still getting to the bottom of it, there's=
 a few
> >>>> >> > > other things I have in flight still.
> >>>> >> >
> >>>> >> > Confirmed with v3 on mainline (linux-next is pretty red at the =
moment).
> >>>> >> > https://lore.kernel.org/linux-riscv/20230517082936.37563-1-falc=
on@tinylab.org/
> >>>> >>
> >>>> >> Just FYI Nick, there's been some concurrent work here from differ=
ent
> >>>> >> people working on the same thing & the v3 you linked (from Zhangj=
in) was
> >>>> >> superseded by this v2 (from Jisheng).
> >>>> >
> >>>> > Ah! I've been testing the deprecated patch set, sorry I just looke=
d on
> >>>> > lore for "dead code" on riscv-linux and grabbed the first thread,
> >>>> > without noticing the difference in authors or new version numbers =
for
> >>>> > distinct series. ok, nevermind my noise.  I'll follow up with the
> >>>> > correct patch set, sorry!
> >>>>
> >>>> Ya, I hadn't even noticed the v3 because I pretty much only look at
> >>>> patchwork these days.  Like we talked about in IRC, I'm going to go =
test
> >>>> the merge of this one and see what's up -- I've got it staged at
> >>>> <https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/co=
mmit/?h=3Dfor-next&id=3D1bd2963b21758a773206a1cb67c93e7a8ae8a195>,
> >>>> though that won't be a stable hash if it's actually broken...
> >>>
> >>> Ok, https://lore.kernel.org/linux-riscv/20230523165502.2592-1-jszhang=
@kernel.org/
> >>> built for me.  If you're seeing a hang, please let me know what
> >>> version of LLD you're using and I'll build that tag from source to see
> >>> if I can reproduce, then bisect if so.
> >>>
> >>> $ ARCH=3Driscv LLVM=3D1 /usr/bin/time -v make -j128 allmodconfig vmli=
nux
> >>> ...
> >>>         Elapsed (wall clock) time (h:mm:ss or m:ss): 2:35.68
> >>> ...
> >>>
> >>> Tested-by: Nick Desaulniers <ndesaulniers@google.com> # build
> >>
> >> OK, it triggered enough of a rebuild that it might take a bit for
> >> anything to filter out.
> >
> > I'm on LLVM 16.0.2
> >
> >     $ git describe
> >     llvmorg-16.0.2
> >     $ git log | head -n1
> >     commit 18ddebe1a1a9bde349441631365f0472e9693520
> >
> > that seems to hang for me -- or at least run for an hour without
> > completing, so I assume it's hung.  I'm not wed to 16.0.2, it just
> > happens to be the last time I bumped the toolchain.  I'm moving to
> > 16.0.5 to see if that changes anything.
>=20
> That also takes at least an hour to link.  I tried running on LLVM trunk=
=20
> from last night
>=20
>     $ git log | head -n1
>     commit 5e9173c43a9b97c8614e36d6f754317f731e71e9
>=20
> and that completed.  Just as a curiosity I tried to re-spin it to see=20
> how long it takes, and it's been running for 23 minutes so far.

After some misdirection through stupid user error, I have also
reproduced this for an LLVM=3D1 build w/ llvmorg-16.0.0

> So I'm no longer actually sure there's a hang, just something slow. =20
> That's even more of a grey area, but I think it's sane to call a 1-hour=
=20
> link time a regression -- unless it's expected that this is just very=20
> slow to link?

I dunno, if it was only a thing for allyesconfig, then whatever - but
it's gonna significantly increase build times for any large kernels if LLD
is this much slower than LD. Regression in my book.

I'm gonna go and experiment with mixed toolchain builds, I'll report
back..

Cheers,
Conor.

--qKbzBWp+WnU9QIpu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJMoYAAKCRB4tDGHoIJi
0mg6AQCXbfOkpJyN5FDZceZ0Lxa6tJ9PIM7gQzEkgSc5Th1vzQD9GZgS8XtOTMpx
cUowVAiTXyuNmzDN/wfqsaMeltMiSQA=
=1v8b
-----END PGP SIGNATURE-----

--qKbzBWp+WnU9QIpu--
