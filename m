Return-Path: <linux-arch+bounces-7002-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E9796BB86
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 14:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D831C20C03
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C1C1D6191;
	Wed,  4 Sep 2024 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On7ShQON"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D8F84A21;
	Wed,  4 Sep 2024 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451512; cv=none; b=qz2A64d7dzcdR55PJjh9WZDua4GfLqTCE2msU4GsPNaXN2+Ok9S7MIpjtSityLfmzCpFjNIo2+QwjT5AqG8JuaAoEzEw69cMz/QEId6PQenobczvIuhsoyeIspPcy+1A+EyJyLKjRP+dMM3L+0VC2syMikyqax+OdpDIfX9S3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451512; c=relaxed/simple;
	bh=Ew+Isg/8eV7d4ccQHBgEBJbQqw5N9Qx5hh27gZJqL1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcTbGAlhhwN2mK3fH09CJBh/7+cqfCk6smksKSf7gS5Jw+poHnjW8/Xii77OscXAESTG4GB7LlCPT/UxTD+gKFFeQTGPkvxLUIISJpCCilsrZYcOGAtsS2kPbcQxIhllI69KaeJrM9f3n0eVIYUEfy+VEEMqLfo66qj7lgAXg7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On7ShQON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05D7C4CEC2;
	Wed,  4 Sep 2024 12:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725451511;
	bh=Ew+Isg/8eV7d4ccQHBgEBJbQqw5N9Qx5hh27gZJqL1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=On7ShQONg3QFun4tSzq3jLuojeGW8QbyPLT47x8Gd5tzULqq4AMycrOnh7VY7nJUJ
	 TvqZNRJh6EeXUHrpvhzlDg1yq/ySSrFZQ56Gy7N66xP+k9esiHI6rC4Iedkgj5tM3y
	 5L3IRPXRqE5LyJN4+8CWCiaVU0LNxZCE+4ZFjEyKh7yZDlqKWjgHJdcE0Bw/ltyh8Y
	 4meZ6v++H4gauq8o9ZZ532RazQHHbYs2q4v0lfu/G7uAHCGR2aLe6MwaCHI0XTIHb6
	 fWb4IptbFM6T+ZLhoKb0t3D1kyB3VHPq1kI+A+Y/y1o4MTfa/a/Yfc1N5gIFA+um+D
	 7RqLN+A32XPXw==
Date: Wed, 4 Sep 2024 13:05:06 +0100
From: Will Deacon <will@kernel.org>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, ardb@kernel.org
Subject: Re: [PATCH v5 0/2] arm64: Implement getrandom() in vDSO
Message-ID: <20240904120504.GB13550@willie-the-truck>
References: <20240903120948.13743-1-adhemerval.zanella@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903120948.13743-1-adhemerval.zanella@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

+Ard as he had helpful comments on the previous version.

On Tue, Sep 03, 2024 at 12:09:15PM +0000, Adhemerval Zanella wrote:
> Implement stack-less ChaCha20 and wire it with the generic vDSO
> getrandom code.  The first patch is Mark's fix to the alternatives
> system in the vDSO, while the the second is the actual vDSO work.
> 
> Changes from v4:
> - Improve BE handling.
> 
> Changes from v3:
> - Use alternative_has_cap_likely instead of ALTERNATIVE.
> - Header/include and comment fixups.
> 
> Changes from v2:
> - Refactor Makefile to use same flags for vgettimeofday and
>   vgetrandom.
> - Removed rodata usage and fixed BE on vgetrandom-chacha.S.
> 
> Changes from v1:
> - Fixed style issues and typos.
> - Added fallback for systems without NEON support.
> - Avoid use of non-volatile vector registers in neon chacha20.
> - Use c-getrandom-y for vgetrandom.c.
> - Fixed TIMENS vdso_rnd_data access.
> 
> Adhemerval Zanella (1):
>   arm64: vdso: wire up getrandom() vDSO implementation
> 
> Mark Rutland (1):
>   arm64: alternative: make alternative_has_cap_likely() VDSO compatible
> 
>  arch/arm64/Kconfig                          |   1 +
>  arch/arm64/include/asm/alternative-macros.h |   4 +
>  arch/arm64/include/asm/mman.h               |   6 +-
>  arch/arm64/include/asm/vdso.h               |   6 +
>  arch/arm64/include/asm/vdso/getrandom.h     |  50 ++++++
>  arch/arm64/include/asm/vdso/vsyscall.h      |  10 ++
>  arch/arm64/kernel/vdso.c                    |   6 -
>  arch/arm64/kernel/vdso/Makefile             |  25 ++-
>  arch/arm64/kernel/vdso/vdso                 |   1 +
>  arch/arm64/kernel/vdso/vdso.lds.S           |   4 +
>  arch/arm64/kernel/vdso/vgetrandom-chacha.S  | 172 ++++++++++++++++++++
>  arch/arm64/kernel/vdso/vgetrandom.c         |  15 ++
>  tools/arch/arm64/vdso                       |   1 +
>  tools/include/linux/compiler.h              |   4 +
>  tools/testing/selftests/vDSO/Makefile       |   3 +-
>  15 files changed, 292 insertions(+), 16 deletions(-)
>  create mode 100644 arch/arm64/include/asm/vdso/getrandom.h
>  create mode 120000 arch/arm64/kernel/vdso/vdso
>  create mode 100644 arch/arm64/kernel/vdso/vgetrandom-chacha.S
>  create mode 100644 arch/arm64/kernel/vdso/vgetrandom.c
>  create mode 120000 tools/arch/arm64/vdso
> 
> -- 
> 2.43.0
> 

