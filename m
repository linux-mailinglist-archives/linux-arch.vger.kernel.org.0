Return-Path: <linux-arch+bounces-4285-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0058C1492
	for <lists+linux-arch@lfdr.de>; Thu,  9 May 2024 20:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5111F21B21
	for <lists+linux-arch@lfdr.de>; Thu,  9 May 2024 18:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACF677119;
	Thu,  9 May 2024 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcnwgtVC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD1770FE;
	Thu,  9 May 2024 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278482; cv=none; b=IVftg/zfhAyqaM12GenL1/z9GbFxOtlmctWk0cdvubWmjxeA8AyiHG0aqHGpc0IRD3SJEKY5iOwYHhzQCC5cJ4Be+wiRF8XXr4hgaG0s7GYtrsGrQQZbInJojn1kgaS8x3/kayYcfHKCp4e6t447pgwKbu8B57UoEB7vD86AEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278482; c=relaxed/simple;
	bh=hRafjKR2nz/ik0Ybw1Y2FxPsUTThAfB6fkIwc8yWrHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvLoyYEyQKrNJ9P0s3tZwVDnEgP1aOL8wlaU9jMIuhDgk8N8SpXqSZBVypfQjEO+R6grIIYoK+CVjYeqacpPizU8+hUmTTtHXFCLu1DEO167MiUZ1jCPvwHDjcmVhWJGh3EGZ2fmuCxYTl1+ASf2xVp8HkRZcIYmVVlVggbagcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcnwgtVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7996C116B1;
	Thu,  9 May 2024 18:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715278482;
	bh=hRafjKR2nz/ik0Ybw1Y2FxPsUTThAfB6fkIwc8yWrHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CcnwgtVCG7xfa9ZqQX9x5aPbB8jIN4eai6HbmPjX9FQGjkRwgfJVizpa671LV5kCx
	 9QcKPdInn/8JQKidSZN9Eu35JSLnJY15KbOhzGq2w8HE2bY9uZkyk0U+HBxZ7kiM+V
	 aysA3CouUg5fksg2k89YsqHNjChC1e+QIExkTm0ZKsenA/hFkA7dd0bD95DC+Uf844
	 S+V1pAlVgGoxrbl2rRuhbFPPz1m/SuYxirzNkqJDLeYRmYySS3s37N8IkpGSb7eQDm
	 BjuX/N9hoEsXnMZUjzWd0dYjjFNG4QGZO2CS7ceb+lKr8CXBBTstrnjgSa7sJEb+st
	 WQf+eKiLwhByQ==
Date: Thu, 9 May 2024 19:14:26 +0100
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
Message-ID: <20240509-cornflake-foyer-e6589c2bc364@spud>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-5-debug@rivosinc.com>
 <20240410115806.GA4044117-robh@kernel.org>
 <CAKC1njSsZ6wfvJtXkp4J4J6wXFtU92W9JGca-atKxBy8UvUwRg@mail.gmail.com>
 <20240415194105.GA94432-robh@kernel.org>
 <Zh6c0FH2OvrfDLje@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JhRnWmWpnp4za6Qf"
Content-Disposition: inline
In-Reply-To: <Zh6c0FH2OvrfDLje@debug.ba.rivosinc.com>


--JhRnWmWpnp4za6Qf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 08:44:16AM -0700, Deepak Gupta wrote:
> On Mon, Apr 15, 2024 at 02:41:05PM -0500, Rob Herring wrote:
> > On Wed, Apr 10, 2024 at 02:37:21PM -0700, Deepak Gupta wrote:
> > > On Wed, Apr 10, 2024 at 4:58=E2=80=AFAM Rob Herring <robh@kernel.org>=
 wrote:
> > > >
> > > > On Wed, Apr 03, 2024 at 04:34:52PM -0700, Deepak Gupta wrote:
> > > > > Make an entry for cfi extensions in extensions.yaml.
> > > > >
> > > > > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > > > > ---
> > > > >  .../devicetree/bindings/riscv/extensions.yaml          | 10 ++++=
++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/riscv/extensions.y=
aml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > > index 63d81dc895e5..45b87ad6cc1c 100644
> > > > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > > > @@ -317,6 +317,16 @@ properties:
> > > > >              The standard Zicboz extension for cache-block zeroin=
g as ratified
> > > > >              in commit 3dd606f ("Create cmobase-v1.0.pdf") of ris=
cv-CMOs.
> > > > >
> > > > > +        - const: zicfilp
> > > > > +          description:
> > > > > +            The standard Zicfilp extension for enforcing forward=
 edge control-flow
> > > > > +            integrity in commit 3a20dc9 of riscv-cfi and is in p=
ublic review.
> > > >
> > > > Does in public review mean the commit sha is going to change?
> > > >
> > >=20
> > > Less likely. Next step after public review is to gather comments from
> > > public review.
> > > If something is really pressing and needs to be addressed, then yes
> > > this will change.
> > > Else this gets ratified as it is.
> >=20
> > If the commit sha can change, then it is useless. What's the guarantee
> > someone is going to remember to update it if it changes?
>=20
> Sorry for late reply.
>=20
> I was following existing wordings and patterns for messaging in this file.
> You would rather have me remove sha and only mention that spec is in publ=
ic
> review?

Nope, having a commit sha is desired. None of this is mergeable until at
least the spec becomes frozen, so the sha can be updated at that point
to the freeze state - or better yet to the ratified state. Being in
public review is not sufficient.

Cheers,
Conor

--JhRnWmWpnp4za6Qf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj0SggAKCRB4tDGHoIJi
0mvjAP9d3Qz1PVGc/kOj+XdEfO1FrKoEF9VSW9XYGpnlZvSRVAEAhzTts4ymraHs
rig86vUonyRRKcngwn/ZR5KdPHqJ3ws=
=NfI8
-----END PGP SIGNATURE-----

--JhRnWmWpnp4za6Qf--

