Return-Path: <linux-arch+bounces-5937-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5978E945F9D
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 16:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197B0286037
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41AD1E4F0F;
	Fri,  2 Aug 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR0WO4H3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F841F94C;
	Fri,  2 Aug 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610010; cv=none; b=EtTXSvv8T7ommbVdoPgjPlkatCSaplR7hcAButfnHJaaqbVx1pw/9aPikwA8LyD3aE/nTNT9saWBAPaKjgACzvSfXU84eBg4wUqriEZt8tnwRRcweLm7RfHNPxP+4yhPHEZZ/DHHIsf8STSpKu52PoEhy6bNNCDIA+hA6mGh5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610010; c=relaxed/simple;
	bh=0B04wVki9G0yvxf18iermuBnvEqCoQZgAVStJfZayRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuMBX58GtPX3tJZ2kRkYW2pXRayl2wzqzkL/RZuKE2rILsPf/TlV1aFNZGXnoH7MAMpmcUjVXp+igOMuhqlnh1aZwOiClNq4VwxwY1du8EmI+FioehDL6EOgIRl/7ZVq4/LWNx+Vh/LkUft+wdKWF3RCiX6m5tVUxIkZokwGihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR0WO4H3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4589C32782;
	Fri,  2 Aug 2024 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722610010;
	bh=0B04wVki9G0yvxf18iermuBnvEqCoQZgAVStJfZayRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mR0WO4H3CHo4CDRMsplIKoppPnHrrAbbdCqAJ9yH+/mgDzNuWDn5IWdExszj6TYqp
	 p3M9u/GnMdZ2hFeL+hWS2UraUs/Fr0EewdUl3/RLxFQGAt60wmqu4zP9Zghr4Ur5nk
	 lkjLyJsfLyRKJcmlWhjawFSC1d2zqlcVinW9tEmJbI14PhUo5HPQ5NiwBAKCzlTVOZ
	 1c+Z6FcCOTlmHpmNZkCjWz3zlG2csKgE6U/8bCuxp9rs84Xp02mKxA8IE9HFZ4Q3R9
	 djuEMM1yjCU3uJulkQeJb/B5YMpdtsksxLG8FJQ2F0OFw/fIXg5ehoDxbXH4ASivYk
	 8mLh9yavg4dOw==
Date: Fri, 2 Aug 2024 15:46:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 12/13] dt-bindings: riscv: Add Ziccrse ISA extension
 description
Message-ID: <20240802-frighten-flail-fddc8136b69d@spud>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-13-alexghiti@rivosinc.com>
 <20240801-unlighted-senator-cc60d021fe28@spud>
 <4b890910-ed3b-47e1-a895-48ae3d47e958@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wOGS7rCkyPiSGxrA"
Content-Disposition: inline
In-Reply-To: <4b890910-ed3b-47e1-a895-48ae3d47e958@ghiti.fr>


--wOGS7rCkyPiSGxrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 10:14:21AM +0200, Alexandre Ghiti wrote:
> Hi Cono
>=20
> On 01/08/2024 16:44, Conor Dooley wrote:
> > On Wed, Jul 31, 2024 at 09:24:04AM +0200, Alexandre Ghiti wrote:
> > > Add description for the Ziccrse ISA extension which was introduced in
> > > the riscv profiles specification v0.9.2.
> > >=20
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > Reviewed-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >   Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml =
b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > index a63578b95c4a..22824dd30175 100644
> > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > @@ -289,6 +289,12 @@ properties:
> > >               in commit 64074bc ("Update version numbers for Zfh/Zfin=
x") of
> > >               riscv-isa-manual.
> > > +        - const: ziccrse
> > > +          description:
> > > +            The standard Ziccrse extension which provides forward pr=
ogress
> > > +            guarantee on LR/SC sequences, as introduced in the riscv=
 profiles
> > > +            specification v0.9.2.
> > Do we have a commit hash for this? Also v0.9.2? The profiles spec is a
> > crock and the version depends on the specific profile - for example
> > there's new tags as of last week with 0.5 in them... The original profi=
les
> > are ratified, so if this definition is in there, please cite that
> > instead of a "random" version.
>=20
>=20
> That's not a "random" version, please refer to the existing tag v0.9.2 wh=
ere
> this was first introduced
> (https://github.com/riscv/riscv-profiles/releases/tag/v0.9.2).

That might be your intent, but the versioning in that repo sucks. If
you'd said the v0.9.2 *tag* that would be clearer than what you wrote,
as there could easily be a v0.9.2 of a new profile - there's already a
v0.4 etc.

> But I'll change that to the profiles specification v1.0.

Still vague IMO, please provide a commit hash.

--wOGS7rCkyPiSGxrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqzxQQAKCRB4tDGHoIJi
0kz2AQDjtdPseCng2S+4ONZZ0SQUpo8PNoH5fYL4FOkdI8i/XgD/UWt6cymyJp12
kVz40SPUpdTEuDlR9fA8oueX+EaJIQI=
=xbhP
-----END PGP SIGNATURE-----

--wOGS7rCkyPiSGxrA--

