Return-Path: <linux-arch+bounces-11007-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E90AA6B35F
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 04:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E95757A7776
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 03:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C571E7C25;
	Fri, 21 Mar 2025 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6XuhqVy"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C21E7C19;
	Fri, 21 Mar 2025 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742528243; cv=none; b=RFvKmw42eOFy82+42tvTuKxwNEk+7BMsoRTsC+lxl5683c0cCWLK7JbVp6Eqzh1ltnynPMxLeN9fhWnX4VsnXWJO3uwRbsio7+xe84k5Pu6Oo3KDRV/zwxpmpxMhyAi8wdM023xSLnZ+LBigmKIhY6hOocxljAun/4tU4B17EFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742528243; c=relaxed/simple;
	bh=aL28XEpJktFyzSrtGRAjtcrEGubi+gEbKi8XefWZizM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRc+iStLGfvgjHj1KnU4cOnAB9fHF1rZVLlkE3FpRNDD6BBZtOxthqGFBiREuAlwhHmiEheqSTzbOXdvNYbsDUew/2hhW4ibsYHLmipZmks5fNyg5knWxj1A9zq//HLut8iBxFMJptA0dbzHfJHra21OpW8+D4yLNQZa91DosTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6XuhqVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C3EC4CEDD;
	Fri, 21 Mar 2025 03:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742528242;
	bh=aL28XEpJktFyzSrtGRAjtcrEGubi+gEbKi8XefWZizM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6XuhqVyWbogmwwm749xUsJgPCnAqqSeCGZTosFqhBb1Xe/PFfgZLonAAxLGXYM2h
	 H5Rjl+jZ+/nUhpAcyb+NZ3oZa+MJTxsW9iUFlD1i+O9EsR5L+oU0GujSqvdi5uPkrH
	 NR5NNeo7jJmgJyvlx+SP0oVtTV3I4MXd52BPL0GeYVJC4yST0Ie41FpzM8R9TM50UP
	 6R0RliihTl36P+7U+ey9yJeNLMJSgXvTkqGnQFHTSzVzTxurGNRx2Vx1Ei5SBQ3zV6
	 HfkpAUO/Iox/kqVD+SqJQdCciahcO9jLLNHKy8PNLdy25hshCxVkg0yldLmNOb2Ub9
	 neF2SocRn9Dvw==
Date: Thu, 20 Mar 2025 20:37:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: introduce asm/swab.h
Message-ID: <20250321033718.GA98513@sol.localdomain>
References: <20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com>
 <20250319-riscv-swab-v2-2-d53b6d6ab915@iencinas.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-riscv-swab-v2-2-d53b6d6ab915@iencinas.com>

On Wed, Mar 19, 2025 at 10:09:46PM +0100, Ignacio Encinas wrote:
> +#define ARCH_SWAB(size) \
> +static __always_inline unsigned long __arch_swab##size(__u##size value) \
> +{									\
> +	unsigned long x = value;					\
> +									\
> +	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,			\
> +			     RISCV_ISA_EXT_ZBB, 1)			\
> +			     :::: legacy);				\

Is there a reason to use this instead of
riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) which seems to do the same thing,
including using a static branch?

- Eric

