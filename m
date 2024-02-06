Return-Path: <linux-arch+bounces-2101-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5994784BAAC
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 17:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E27283993
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DCD134CC6;
	Tue,  6 Feb 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlUHOAEn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E8E12D150;
	Tue,  6 Feb 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236023; cv=none; b=WgvtXJpotpWqbYafgSqkApBtXap+Ipeyai0cS4AYAI9cp/A8LTjjCr1+NlrhibPcave/sPRlJYCcwWa0F4R4HNTA7crCGkv07e2uy+sTBzZgr+p78FgCt9b9L+aWfdFXmg1VfvC3hbnA3eigU23lIdl+Wxmn0ho2a9wqycLCGA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236023; c=relaxed/simple;
	bh=c1sZ3YqjwLgIe/oUDK6sgpcyFQmmz43JxRT/kHAfLYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk7XLtSLzyZjmFmXWIZ+7OguW3hjWarezo6Ls1CNi+4C2lCS89fyoeAVRNA4FmbB4i4a02tvYY/YzNkYlzb7coEiFMmmthvZWdGsQWNSp+xpwDGc47BJ3ZRcgWbe41EtFK0Eo7sy24aRKTYKLJgJyEPLD6FFxsKGaVdBIoXPgew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlUHOAEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040C0C433C7;
	Tue,  6 Feb 2024 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707236022;
	bh=c1sZ3YqjwLgIe/oUDK6sgpcyFQmmz43JxRT/kHAfLYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlUHOAEnInU30oik5DPIGz6JgFHROuPeLJgpWMoanTiX/F9nJO8S6FQIWlQdpV0Jl
	 +EDIKyTlUw2s35GBSvpYxBobPHMvDS0SlVxFSuBwIkCBsugAp3Y1sJefh6tdx+iDj+
	 tieTWeVky5DPpTbCSVwM50ryLecIJm9jwCPPqQaursXXSEY7yGrP4HcFTkWBJtU3T3
	 jW3naVUxR/lmiDVmyIxj7vLdUmdr0LLkzV0Z2/kZzNvqJ3+fm8i67rUkr8dMc9363H
	 b6yV6+Swl4GpQUrVE1WOXEv91PrYQ6HbM4uAM0BNakq8Y//7aYn93KhFdff3kU5zjE
	 vPE2F67S+zRnQ==
Date: Tue, 6 Feb 2024 16:13:39 +0000
From: Mark Brown <broonie@kernel.org>
To: debug@rivosinc.com
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
Subject: Re: [RFC PATCH v1 18/28] prctl: arch-agnostic prtcl for indirect
 branch tracking
Message-ID: <ZcJas4tZNzOJv6hW@finisterre.sirena.org.uk>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-19-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IzS+gDfE7WAJn9u1"
Content-Disposition: inline
In-Reply-To: <20240125062739.1339782-19-debug@rivosinc.com>
X-Cookie: You might have mail.


--IzS+gDfE7WAJn9u1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 24, 2024 at 10:21:43PM -0800, debug@rivosinc.com wrote:

> To allow userspace to enable this feature for itself, following prtcls are
> defined:
>  - PR_GET_INDIR_BR_LP_STATUS: Gets current configured status for indirect branch
>    tracking.
>  - PR_SET_INDIR_BR_LP_STATUS: Sets a configuration for indirect branch tracking
>    Following status options are allowed
>            - PR_INDIR_BR_LP_ENABLE: Enables indirect branch tracking on user
>              thread.
>            - PR_INDIR_BR_LP_DISABLE; Disables indirect branch tracking on user
>              thread.
>  - PR_LOCK_INDIR_BR_LP_STATUS: Locks configured status for indirect branch
>    tracking for user thread.

FWIW the arm64 BTI feature is enabled per page of executable memory
rather than in CPU state so it'd be hard for us to adopt this interface.
I don't think that's a blocker, just noting it.

--IzS+gDfE7WAJn9u1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCWrIACgkQJNaLcl1U
h9CqHAf/YTvIwiIOAvwQ9XqrETCEC8PE7wl9yNsGNfr06ERBrjw436apeNtLMOPF
3FujoE4HG2IAw0iXzAKOJAQhYyLVhioOqMhsFNIxGaCCaUFExzRAABZmkiZtVeQh
GrmhU/kVDYaa/3z+egy9d4BDidA778b7Opw6GFgrwId1wg3Wl0zQG89h0VMFJMKw
/8mvyHmbjdv+5ucF8fYE30+QXu6fAniENvRjHum6N8ReGyEZ9vf2pHlmGCVtzLUz
nVsbKvjwR71Zlq2RHRmjrf6WsNCBkp/xx/1SwwTof4Y6tHkfEhBAVjQGLqwhi7w5
d2s9KQp3hvWSCNUxDEapZF+m1vGRLQ==
=UNVO
-----END PGP SIGNATURE-----

--IzS+gDfE7WAJn9u1--

