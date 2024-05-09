Return-Path: <linux-arch+bounces-4290-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 716AC8C17A2
	for <lists+linux-arch@lfdr.de>; Thu,  9 May 2024 22:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF689B20D89
	for <lists+linux-arch@lfdr.de>; Thu,  9 May 2024 20:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029811BC4B;
	Thu,  9 May 2024 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy9+y+Wn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BD4376;
	Thu,  9 May 2024 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286785; cv=none; b=KvlVRcmHkVJ5z7y5uUFqS16EYgtlun4YfzBgERW6h9B/5NUDHCAG06WEAjJiF2G+lnwelYHSInnQ8GgzzbJ1a2wni4s+foG/qTR4MSAYoQQzVG5/zxZXBUfbvBjuxgm3+VwWkTxhRN0ERAFaRJLMyo5vDjTPR6mrrsOPupiGtZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286785; c=relaxed/simple;
	bh=6iQUzY8aEoDEDTDjSEFz/xHQqilN8EGwR9Ao9LR2DhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf7ATi6BTJcMOyoRyX6pT7oFzTZU7pxX5HeheoJherLy+YYxY+LQirScfOKm801dOd4RAPvQGmk9Yc6qdka/wmh+xpI+VUdZZe7bmKLX3fUOhmNduT9RwBXzMfewOpyED/HvKYftH5afLCpTqWzVq7QOu4Mrx6Ah6/u5Gybmj6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy9+y+Wn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA18C116B1;
	Thu,  9 May 2024 20:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715286785;
	bh=6iQUzY8aEoDEDTDjSEFz/xHQqilN8EGwR9Ao9LR2DhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uy9+y+Wn571zBjkcfWNxqCA9u6G+sV4BOYW+53XaleB+d+ECLFA/QUFNlclIoorDe
	 hKpRg4eDuONRLyrCriNbQ3Z62aTFZBZWxgTzR0NStKeR7yId4VXZnGyluuTkI5/q2z
	 hMlkPWtJCjeu9zGzmej+baT6iIlzr6VGyVdAtDODuM/O32Wv7Cx7Mbmh/lE/C7uGum
	 ULGcH15fuvlg+MBCHLwwmisSxYoKwfZReurwTHwj+0XILwZ1NlK2OGNPPZgXDXU/d0
	 MO0ilOdWPTjG8X5FLoKkVrm8u7yv7nmp/+qppgGBjsG76Ze7gou+bBddiPRAbwPwf7
	 2qMDIEht5/Uyg==
Date: Thu, 9 May 2024 21:32:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>, paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com, broonie@kernel.org,
	Szabolcs.Nagy@arm.com, kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	cleger@rivosinc.com, atishp@atishpatra.org, alex@ghiti.fr,
	bjorn@rivosinc.com, alexghiti@rivosinc.com,
	samuel.holland@sifive.com, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	corbet@lwn.net, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	charlie@rivosinc.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, dbarboza@ventanamicro.com,
	sameo@rivosinc.com, shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 04/29] riscv: zicfilp / zicfiss in dt-bindings
 (extensions.yaml)
Message-ID: <20240509-clatter-crewmate-9755669b9452@spud>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-5-debug@rivosinc.com>
 <20240410115806.GA4044117-robh@kernel.org>
 <CAKC1njSsZ6wfvJtXkp4J4J6wXFtU92W9JGca-atKxBy8UvUwRg@mail.gmail.com>
 <20240415194105.GA94432-robh@kernel.org>
 <Zh6c0FH2OvrfDLje@debug.ba.rivosinc.com>
 <20240509-cornflake-foyer-e6589c2bc364@spud>
 <Zj0aAiZiTrt9ACjj@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x+pjDPD7FlbQaxoS"
Content-Disposition: inline
In-Reply-To: <Zj0aAiZiTrt9ACjj@debug.ba.rivosinc.com>


--x+pjDPD7FlbQaxoS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 11:46:26AM -0700, Deepak Gupta wrote:
> On Thu, May 09, 2024 at 07:14:26PM +0100, Conor Dooley wrote:
> > On Tue, Apr 16, 2024 at 08:44:16AM -0700, Deepak Gupta wrote:
> > > On Mon, Apr 15, 2024 at 02:41:05PM -0500, Rob Herring wrote:
> > > > On Wed, Apr 10, 2024 at 02:37:21PM -0700, Deepak Gupta wrote:
> > > > > On Wed, Apr 10, 2024 at 4:58=E2=80=AFAM Rob Herring <robh@kernel.=
org> wrote:
> > > > > >
> > > > > > On Wed, Apr 03, 2024 at 04:34:52PM -0700, Deepak Gupta wrote:
> > > > > > > Make an entry for cfi extensions in extensions.yaml.
> > > > > > >
> > > > > > > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > > > > > > ---
> > > > > > >  .../devicetree/bindings/riscv/extensions.yaml          | 10 =
++++++++++
> > > > > > >  1 file changed, 10 insertions(+)
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/riscv/extensio=
ns.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > > > > index 63d81dc895e5..45b87ad6cc1c 100644
> > > > > > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > > > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > > > > @@ -317,6 +317,16 @@ properties:
> > > > > > >              The standard Zicboz extension for cache-block ze=
roing as ratified
> > > > > > >              in commit 3dd606f ("Create cmobase-v1.0.pdf") of=
 riscv-CMOs.
> > > > > > >
> > > > > > > +        - const: zicfilp
> > > > > > > +          description:
> > > > > > > +            The standard Zicfilp extension for enforcing for=
ward edge control-flow
> > > > > > > +            integrity in commit 3a20dc9 of riscv-cfi and is =
in public review.
> > > > > >
> > > > > > Does in public review mean the commit sha is going to change?
> > > > > >
> > > > >
> > > > > Less likely. Next step after public review is to gather comments =
=66rom
> > > > > public review.
> > > > > If something is really pressing and needs to be addressed, then y=
es
> > > > > this will change.
> > > > > Else this gets ratified as it is.
> > > >
> > > > If the commit sha can change, then it is useless. What's the guaran=
tee
> > > > someone is going to remember to update it if it changes?
> > >=20
> > > Sorry for late reply.
> > >=20
> > > I was following existing wordings and patterns for messaging in this =
file.
> > > You would rather have me remove sha and only mention that spec is in =
public
> > > review?
> >=20
> > Nope, having a commit sha is desired. None of this is mergeable until at
> > least the spec becomes frozen, so the sha can be updated at that point
> > to the freeze state - or better yet to the ratified state. Being in
> > public review is not sufficient.
>=20
> Spec is frozen.
> As per RVI spec lifecycle, spec freeze is a prior step to public review.
> Public review concluded on 25th April
> https://lists.riscv.org/g/tech-ss-lp-cfi/message/91
>=20
> Next step is ratification whenever board meets.

Ah, I did the "silly" thing of looking on the RVI website at extension
status (because I never know the order of things) and these two
extensions were marked on there as being in the inception phase, so I
incorrectly assumed that "public review" came before freeze.
Freeze is the standard that we have been applying so far, but if
ratification is imminent, and nothing has changed in the review period,
then it seems sane to just pick the freeze point for the definition.

Cheers,
Conor.

--x+pjDPD7FlbQaxoS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj0y8QAKCRB4tDGHoIJi
0rP8AQC02hZlGWSuSewjVON0urY69iTQamRjygDbG9NHmoS2CgD9GqLx3inCUKtB
gHw/mFivxVUjkbE0drkNkmSs+Vn4eAM=
=uiDQ
-----END PGP SIGNATURE-----

--x+pjDPD7FlbQaxoS--

