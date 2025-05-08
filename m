Return-Path: <linux-arch+bounces-11872-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A04C2AAF50B
	for <lists+linux-arch@lfdr.de>; Thu,  8 May 2025 09:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043F84E5516
	for <lists+linux-arch@lfdr.de>; Thu,  8 May 2025 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9013621D3D1;
	Thu,  8 May 2025 07:57:47 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A768F205E3E;
	Thu,  8 May 2025 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746691067; cv=none; b=VhtrXPFQppWBGfwteGytr0oPSP07QvD0phjFpxlVEibRJKWHxFZQf51A70NGmDgUz9yLfOBkI1HIQV6lL3uzSRvsl+JluBg7p2Fciye93K+FVxS2Sp02LcKVOiu5z482urxEESRW7oK1r4zxXJs4Yvw8J3lm8h0FeQCzTEHt698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746691067; c=relaxed/simple;
	bh=vHvfFeQoNuO3261AXhQ0ELQU+4a4g0bhmooGcXbPOXw=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:MIME-Version:
	 Message-Id:Content-Type; b=Hh/Wh7L1iz8ARmSC6yJvUd2tsIH0XCQPR4ZihiihEqlijn7zGq2qEKoO/7Dq4WBBqUoq8wBf2A4+N+vyScdqRK3eATvFntbicPCJKmpQTRGbLJpq9O2+uphbE4aGkeJhfBPymsrHl6wVsKIuetPGv58qkXJs30z/AoLokPoG4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3421842BEA;
	Thu,  8 May 2025 09:57:36 +0200 (CEST)
Date: Thu, 08 May 2025 09:57:31 +0200
From: Fabian =?iso-8859-1?q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [PATCH v3 0/9] module: Introduce hash-based integrity checking
To: Arnout Engelen <arnout@bzzt.net>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Thomas =?iso-8859-1?q?Wei=DFschuh?=
	<linux@weissschuh.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Heusel <christian@heusel.eu>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Jonathan Corbet
	<corbet@lwn.net>, Daniel Gomez <da.gomez@samsung.com>, Dmitry Kasatkin
	<dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>,
	James Morris <jmorris@namei.org>, kpcyrd <kpcyrd@archlinux.org>,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-security-module@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>, Masahiro Yamada
	<masahiroy@kernel.org>, Mattia Rizzolo <mattia@mapreri.org>,
	=?iso-8859-1?b?Q+JqdQ==?= Mihai-Drosi <mcaju95@gmail.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nathan Chancellor
	<nathan@kernel.org>, Naveen N Rao <naveen@kernel.org>, Nicolas Schier
	<nicolas.schier@linux.dev>, =?iso-8859-1?q?Nicholas=0A?= Piggin
	<npiggin@gmail.com>, Paul Moore <paul@paul-moore.com>, Petr Pavlu
	<petr.pavlu@suse.com>, =?iso-8859-1?q?Roberto=0A?= Sassu
	<roberto.sassu@huawei.com>, Sami Tolvanen <samitolvanen@google.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
	<f1dca9daa01d0d2432c12ecabede3fa1389b1d29.camel@HansenPartnership.com>
	<840b0334-71e4-45b1-80b0-e883586ba05c@t-8ch.de>
	<b586e946c8514cecde65f98de8e19eb276c09703.camel@HansenPartnership.com>
	<072b392f-8122-4e4f-9a94-700dadcc0529@app.fastmail.com>
	<2413d57aee6d808177024e3a88aaf61e14f9ddf4.camel@HansenPartnership.com>
	<6615efdc-3a84-4f1c-8a93-d7333bee0711@app.fastmail.com>
	<7e2d25f9abb13468e5b8bb8207149999de318725.camel@HansenPartnership.com>
In-Reply-To: <7e2d25f9abb13468e5b8bb8207149999de318725.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: astroid/0.16.0 (https://github.com/astroidmail/astroid)
Message-Id: <1746688246.p9f7lm4alu.astroid@yuna.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 7, 2025 6:41 pm, James Bottomley wrote:
> On Wed, 2025-05-07 at 09:47 +0200, Arnout Engelen wrote:
>> On Tue, May 6, 2025, at 15:24, James Bottomley wrote:
>> > I'll repeat the key point again: all modern hermetic build systems
>> > come with provenance which is usually a signature.
>>=20
>> I'm not sure the 'hermetic build' parallel is so applicable here:
>> typically a hermetic build will produce an artifact and a signature,
>> and when you embed that result in a larger aggregate, you only embed
>> the artifact (not the signature) and sign the aggregate.
>=20
> That depends whether you want to demonstrate the provenance of the
> result to someone consuming your aggregate or not; Some people are OK
> with the trust my signature approach, others want tracing to point of
> origin.

Debian (and derivaties) handle it that way - build results are signed
but the aggregate (repository) has its own signature, and only that is
used as trust anchor by apt. source packages have indiviual signatures
by whoever uploaded them, so you can verify that if you (want to)
rebuild.

>>  With module signatures, the module *and* their signatures are
>> embedded in the aggregate (e.g. ISO, disk image), which is
>> where (at least in my case) the friction comes from.
>=20
> For Linux in particular, most people won't be booting any image unless
> the binary is secure boot signed, so this problem doesn't go away if
> you strip module signatures.

it is reduced in complexity though, see below.

>> > Plus, you've got to remember that a signature is a cryptographic
>> > function of the hash over the build minus the signature.=C2=A0 You can=
't
>> > verify a signature unless you know how to get the build minus the
>> > signature.=C2=A0 So the process is required to be deterministic.
>>=20
>> Right: there is no friction validating the module signatures, that is
>> fine. There is friction validating the aggregate artifact (e.g. ISO,
>> disk image), though, because of those signatures embedded into it.
>=20
> I think we understand the problem with signatures (particularly the
> ones which add entropy and can thus change every time the same object
> is signed).  However, I don't think we can accept that no signatures
> can be on the ISO ... we'll have to have at least secure boot
> signatures and if there's a way of doing that then there should be a
> way of doing other signatures.

secure boot signatures (other than for kernel modules) are added as a
separate step at least in Debian(-based distros). this means that for
every -signed package you have an unsigned counter part that is
(hopefully) reproducible, and the difference is only the signature(s)
(which might be detached or attached, depending on the package).

building such a package boils down to:
- build the unsigned package(s) + a helper package instructing the signing
  machinery which files to sign with which key
- pass the helper package to the signing infrastructure
- signing infrastructure calculates digest and generates signature
  value, and puts that into another source package for the -signed
  variant
- "build" that source package (e.g., [0]), which might mean attaching
  the signature to the corresponding binary artifact, or just storing
  the signature somewhere to be handled later

this way, the part of infrastructure that handles signing (and thus
access to the corresponding secret key material) is decoupled from the
regular build infrastructure and can have a vastly reduced attack
surface. it has the additional side-effect that the actual "build" steps
are each reproducible (modulo bugs affecting that, of course). the
signing step obviously isn't, but that isn't really a problem..

>> As you mentioned earlier, of course this is *possible* to do (for
>> example by adding the signatures as inputs to the second
>> 'independent' build or by creating a hard-to-validate 'check recipe'
>> running the build in reverse). Still, checking modules at run time by
>> hash instead of by signature would be a much simpler option for such
>> scenario's.
>=20
> Well, my objection was merely to the description saying verifying
> reproducibility with signatures was not possible (it is).

verifying reproducibility of the *unsigned* kernel package doesn't
require any special hacks or mangling if the modules themselves are not
signed using an ephemeral key. (there are currently still other issues
affecting reproducibility, but that would be the goal!)

> However, the problem with distros adopting an immutable hash list for
> module loading would be DKMS, but I think the distributions that go
> that route have all solved the reproducibility issues with signatures
> anyway, so perhaps that's not an issue.

DKMS usually uses MOK as trust anchor, and that key is not
provided/managed by the distro, all the signing happens on the user
side, DKMS packages just ship the module source code + build scripts.

so this is orthogonal - yes, if you want to support DKMS (or other
out-of-tree modules), those modules cannot be included in an in-tree
hash list and would still need to be signed somehow by a trusted key.

basically, both current solutions have downsides:

- signing modules after the build, similar to the kernel image itself,
  is rather impractical with the number of modules shipped by the usual
  distro packages, and relies on other safeguards/invariants not being
  broken to prevent downgrade attacks
- signing modules during the build using an ephemeral key requires
  stripping the signatures when verifying reproducibility (this
  discussion ;)), but also requires enough entropy and not even
  read-only access to the build environment by a potential attacker,
  since if they can read/leak the ephemeral key, they can later attack
  all systems running this particular kernel build

in practice many distros combine both approaches - ephemeral keys for
modules shipped as part of the kernel build, other trusted keys for
out-of-tree modules like DKMS, proprietary drivers, livepatching, ..

the module hash approach (provided it has an opt-in escape hatch for
trusted out-of-tree modules like DKMS) solves all those downsides, as
far as I can tell. you still need all the safeguards/invariants if you
use signed out-of-tree modules of course, if that is part of your use
case. but e.g. AFAIK for Debian (and us as downstream), the only modules
not built as part of the kernel build are built by DKMS on user systems,
and those are signed by the MOK managed by the user/admin.

>> > > > All current secure build processes (hermetic builds, SLSA and
>> > > > the like) are requiring output provenance (i.e. signed
>> > > > artifacts).=C2=A0 If you try to stand like Canute against this tid=
e
>> > > > saying "no signed builds", you're simply opposing progress for
>> > > > the sake of it
>> > >=20
>> > > I don't think anyone is saying 'no signed builds', but we'd enjoy
>> > > being able to keep the signatures as detached metadata instead of
>> > > having to embed them into the 'actual' artifacts.
>> >=20
>> > We had this debate about 15 years ago when Debian first started
>> > reproducible builds for the kernel.=C2=A0 Their initial approach was
>> > detached module signatures.=C2=A0 This was the original patch set:
>> >=20
>> > https://lore.kernel.org/linux-modules/20160405001611.GJ21187@decadent.=
org.uk/
>> >=20
>> > And this is the reason why Debian abandoned it:
>> >=20
>> > https://lists.debian.org/debian-kernel/2016/05/msg00384.html
>>=20
>> That is interesting history, thanks for digging that up. Of the 2
>> problems Ben mentions running into there, '1' does not seem universal
>> (I think this feature is indeed mainly interesting for systems where
>> you don't _want_ anyone to be able to load locally-built modules),
>> and '2' is a problem that detached signatures have but module hashes
>> don't have.
>=20
> I think Debian ended up going with 2, but since they also provide DKMS
> infrastructure, hash module lists won't work for them anyway.

Debian switched to using an ephemeral key 1.5 years ago for the modules
shipped with the kernel package itself (the dkms package ships MOK
integration to streamline that usecase)[1].

build artifacts in Debian are signed in a way that makes reproducing
them straightforward - the (provenance) signatures are not embedded into
the packages. it's basically just secure boot where Debian generates the
signature and *has* to store it inside a package, and there the actual
build and the signature handling are decoupled to minimize the fallout.

>> > The specific problem is why detached signatures are almost always a
>> > problem: after a period of time, particularly if the process for
>> > creating updated artifacts gets repeated often matching the output
>> > to the right signature becomes increasingly error prone.
>>=20
>> I haven't experienced that issue with the module hashes yet.
>=20
> Heh, I'll repeat this question after you've done umpteen builds of the
> same kernel for debugging purposes. The problem that will bite me is
> that I often just rebuild a single module and reinsert to try to chase
> a bug down.  With this scheme I can't simply reinsert, I'd have to
> rebuild the hash list and reboot the entire vmlinux.

or you could sign the module with a MOK - supporting that in combination
with the hash list is a requirement for pretty much every distro out
there anyway to support DKMS?

>> > Debian was, however, kind enough to attach what they currently do
>> > to get reproducible builds to the kernel documentation:
>> >=20
>> > https://docs.kernel.org/kbuild/reproducible-builds.html
>>=20
>> Cool, I was aware of that page but didn't know it was initially
>> contributed by Debian.
>>=20
>> > However, if you want to detach the module signatures for packaging,
>> > so the modules can go in a reproducible section and the signatures
>> > elsewhere, then I think we could accommodate that (the output of
>> > the build is actually unsigned modules, they just get signed on
>> > install).
>>=20
>> At least I don't really come to this from the packaging perspective,
>> but from the "building an independently verifiable ISO/disk image"
>> perspective. Separating the modules and the signatures into separate
>> packages doesn't help me there, since they'd still both need to be
>> present on the image.
>=20
> So how do you cope with secure boot?  I mean if the object is to
> produce an ISO that is demonstrably reproducible but otherwise
> unusable, we can certainly script a way to excise all the signatures
> including the secure boot one.

although I am not the one you directed this question at, I'd still like
to give an answer from my PoV:

by simply treating both the -unsigned and -signed source packages as
separate input for determining reproducibility, you can work around this
issue. the signature is part of the "source" of the latter, and as long
as the unsigned package is reproducible, the signed counterpart is as
well, even if you haven't "reproduced" the signature creation.

this is exactly the reason why ephemeral keys used for signing are
breaking reproducible builds, it's no longer possible to reproduce the
"partially-signed"[2] kernel package in the usual fashion (without
mangling).

0: https://buildd.debian.org/status/fetch.php?pkg=3Dfwupd-amd64-signed&arch=
=3Damd64&ver=3D1%3A1.7%2B1&stamp=3D1726899394&raw=3D0
1: https://tracker.debian.org/news/1482751/accepted-linux-663-1exp1-source-=
into-experimental/
2: i.e., with just the modules signed, but the image itself not


