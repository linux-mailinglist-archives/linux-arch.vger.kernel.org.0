Return-Path: <linux-arch+bounces-6857-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DFF96653B
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 17:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B4A1C21266
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 15:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7081B1D42;
	Fri, 30 Aug 2024 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eEYgiiqf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB0E16DED8;
	Fri, 30 Aug 2024 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031298; cv=none; b=DNZlfm5qedtUlcKowKm0kdkb7rqSRJXL5bPJ69jezzVtAym8cyzoCOF1SvcAEJewOn7u2j0MTS03oITKkCDlbrtriCq2JRKnNWYuywxp349EnBWMZxMosz7yyyHFAvQYHxZLLuqechE1PAU74m52IbMod1EmkNF0qSshfdHnac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031298; c=relaxed/simple;
	bh=NPHb1X5mvAmM/UOzIq5CW4BF7g/FxlKgXQpTcQ49VzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irZkEz8FhADw7/8U8XUaq6v37qxikjFWoK1fjgJ1dpFSi24K/trYs0GDXXrLoez3S8AsvEl2Y/loR6bPODkCU/aU8QubhLjRrLT8Q5UqEsPuPqty35/OcFIA1fIU0ubLhrSKfYf9sQLQyulBiUP5SyioTjgzdJXId/MoA+83rUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=eEYgiiqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02EBC4CEC2;
	Fri, 30 Aug 2024 15:21:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eEYgiiqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725031295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X1cTv+lYw8/8Q6iQHCqwdq5s0k+/by1/yW/gA+2Lxkg=;
	b=eEYgiiqfyw8CCuoBmCL75e3aRSYkjJb1Uk5wjw4gAoshoawBAwQqZaslD5DU8O6WbXPhCu
	s178hvLAIkgldGZsqwPW/mylHwj+uUleNVWF0bG5r0zosshR5SMs/SJGlf5GXT/Cx1B+k1
	kIKgBtC8WpUjSrW/aNcLHu+lEicqoj8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 895fbd8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 15:21:33 +0000 (UTC)
Date: Fri, 30 Aug 2024 17:21:30 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Mark Brown <broonie@kernel.org>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <ZtHjejGdhZnZu4WQ@zx2c4.com>
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
 <9dd8fee0-008f-42f5-b1e1-d4de3270ccdd@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9dd8fee0-008f-42f5-b1e1-d4de3270ccdd@sirena.org.uk>

On Fri, Aug 30, 2024 at 04:19:00PM +0100, Mark Brown wrote:
> On Thu, Aug 29, 2024 at 08:17:14PM +0000, Adhemerval Zanella wrote:
> > Hook up the generic vDSO implementation to the aarch64 vDSO data page.
> > The _vdso_rng_data required data is placed within the _vdso_data vvar
> > page, by using a offset larger than the vdso_data.
> 
> This exposes some preexisting compiler warnings in the getrandom test
> when built with clang:
> 
> vdso_test_getrandom.c:145:40: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
>   145 | static void *test_vdso_getrandom(void *)
>       |                                        ^
> vdso_test_getrandom.c:155:40: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
>   155 | static void *test_libc_getrandom(void *)
>       |                                        ^
> vdso_test_getrandom.c:165:43: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
>   165 | static void *test_syscall_getrandom(void *)
>       |                                           ^
> 
> which it'd be good to get fixed before merging.

That's my bug. I'll fix that up in the tree and CC you on it. Thanks for
pointing it out.

Jason

