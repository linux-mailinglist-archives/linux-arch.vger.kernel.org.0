Return-Path: <linux-arch+bounces-2679-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC44085F9DD
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 14:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61561C2511B
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEA612FF90;
	Thu, 22 Feb 2024 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3e5etia"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBDC1426D;
	Thu, 22 Feb 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608808; cv=none; b=WrCxZ2m+e1Oheswy85AVXDcoCa9ylQx2e8m0TQ+1y2e915WOnJdpqdFSfP+K9OB+tD2k+QPePMLtJ7Pc1m6rbKDF1jveSTqx/BNj1BvyOXQNV9W+NMi0C8XSxpfXjEB3eVTLRj0nu2SFmKaMcEIDkZT5lV3g0WSbnezDnAlKmRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608808; c=relaxed/simple;
	bh=ek76lcOHd6638oPTS6Co2oHesqGce0rC+wixg+GWnxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjBc5O2NaDRcOqSMC6WvHzlLA67qmzprXc20Xtp47tUhg8dLCxRQ0Aeveqasng8aAeh+Rupaq95zuVU6MCdJMiLaxpZ1f+xMkXHOQoyNh3MmklQo8BilLaUpP8Ojf7/y1bEvRKhUwXpiL0bg6MIlG8QTcuNRS/2v1BlJEW2bbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3e5etia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62395C433F1;
	Thu, 22 Feb 2024 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708608807;
	bh=ek76lcOHd6638oPTS6Co2oHesqGce0rC+wixg+GWnxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a3e5etiaCTIf6mj5LJfPayGGRPCkqpzgVIw1FeLdsLBfQNoMAL/qYtEtGJibhp3oU
	 XvqjYzMm14iBcabQH9ixoP1adKlIOXGttkEhHZ12Rn+NE7gvkO0FpJV0Zyj8nQwHej
	 MjS2muDzwVxCuK7DRdg1nW1guor/t1KJ5KFDRVtVQGCSbEzRP9ZExfSI7/m4gQY7lu
	 IH2ENW1K8nf3rbsVt1oRT1ORFvOCs/E01MBBu4hQdhIY6WX6HFJELx88n+Vg8H2giH
	 DQ7AfczuUA1Y5ZtqJLYSw5zzQXVd8T4Ihv2M8i5skO8VC6v+6w6nuxJvbPeOJJ9KVr
	 TwOSG7d+bkkgA==
Date: Thu, 22 Feb 2024 13:33:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: rick.p.edgecombe@intel.com, Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, corbet@lwn.net, aou@eecs.berkeley.edu,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, shuah@kernel.org, brauner@kernel.org,
	guoren@kernel.org, samitolvanen@google.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org,
	shikemeng@huaweicloud.com, david@redhat.com, charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	vincent.chen@sifive.com, andy.chiu@sifive.com, gerg@kernel.org,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, chenjiahao16@huawei.com,
	ruscur@russell.cc, bgray@linux.ibm.com, alx@kernel.org,
	baruch@tkos.co.il, zhangqing@loongson.cn, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, joey.gouly@arm.com,
	shr@devkernel.io, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 15/28] riscv/mm: Implement map_shadow_stack()
 syscall
Message-ID: <6ad3e87a-25ab-4938-8d81-c5c609619586@sirena.org.uk>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-16-debug@rivosinc.com>
 <ZcJX2IJb0hOM5RF5@finisterre.sirena.org.uk>
 <ZdaZj0pqaVJiNOUg@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LxmbY0AjUg4WDPUw"
Content-Disposition: inline
In-Reply-To: <ZdaZj0pqaVJiNOUg@debug.ba.rivosinc.com>
X-Cookie: I have accepted Provolone into my life!


--LxmbY0AjUg4WDPUw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2024 at 04:47:11PM -0800, Deepak Gupta wrote:
> On Tue, Feb 06, 2024 at 04:01:28PM +0000, Mark Brown wrote:

> > > +#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */

> > For arm64 I also added a SHADOW_STACK_SET_MARKER for adding a top of
> > stack marker, did you have any thoughts on that for RISC-V?  I think x86
> > were considering adding it too, it'd be good if we could get things
> > consistent.

> Please correct me on this. A token at the top which can't be consumed to restore
> but *just* purely as marker, right?

Yes, for arm64 we just leave a zero word (which can't be a valid token)
above the stack switch token, that does mean you can't exactly tell that
the top of stack marker is there unless there's also a stack switch
token below it.

> It's a good design basic with not a lot of cost.

> I think risc-v should be able to converge on that.

Great.

--LxmbY0AjUg4WDPUw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXXTRUACgkQJNaLcl1U
h9ChLQf/TR/+XFN8k0dkmk90JLlGHu3WaTQM0wqbCtUC2FExSxw4JGFIeRSKnUum
10loLkMwAaklC1on36bhQcqVQ+qMOoVN0k9k+YJpi4iXFDo6LH95Z4Qwq37xUQOg
EI+FqbA6BiCGk1OVOHibZO51nBBmQuwO4c/MYT24AYyoR2/uk6OPE+G1Mm7K4/M6
zukeMbRS4LPn++luduEqROdMpJNdEBjeSELUQL8AjyUFemzG6ZlpojuJAvVNbVsN
COBlGD75skhCaSfor7bhAv3iKrr+htaWDZ3zwkPMjlufoZjwYBUb+h3A7eE2G2YF
wLkwHJN21WNLbqxqHXvjCFibtxling==
=mXRS
-----END PGP SIGNATURE-----

--LxmbY0AjUg4WDPUw--

