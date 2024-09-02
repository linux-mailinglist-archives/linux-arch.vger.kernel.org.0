Return-Path: <linux-arch+bounces-6919-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D3968A9D
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 17:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26AF1F22380
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE9F1A262C;
	Mon,  2 Sep 2024 15:05:31 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5661CB536;
	Mon,  2 Sep 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289531; cv=none; b=KP3vp12GhsprmQ90g3Gh6le2Vq84kTMSPMFOjaYzliX3iM0UZxcVFiXslcDe0R+PvUoh5gH9u9LLcH7i3o58vLCSDRKW8U2Smlo+KBGuXiA2TmnEOmXZSEb1Dxio+OOpEGV6rG5/HdmPowCpJOZLrMsygYaPeW3zO2hl1ugPRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289531; c=relaxed/simple;
	bh=lh4i7x6OsIZucLaJL4+DS8p0w2I5Hc6KMl1DNRTSOk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6IW99XVSFFp9gkMxOXJGrhRUXr70mHZwj5EL7dIp19yoFbe6RzdvZyCWvOLUErupPMcHZRQM5U2Wq5j89/5w1gnsAusWFXIv2by5k/oLkhdlltuWo0hLUx+OdY+SllcXBAWD+R1Qdd1gtZY3jKu2IFurQD9URd8jvNYBNV+f6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62F171063;
	Mon,  2 Sep 2024 08:05:54 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 541483F66E;
	Mon,  2 Sep 2024 08:05:26 -0700 (PDT)
Date: Mon, 2 Sep 2024 16:05:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <ZtXUM8Isg0012BLs@J2N7QTR9R3>
References: <20240902125312.3934-1-adhemerval.zanella@linaro.org>
 <ZtXMT3qSFgneeZb9@J2N7QTR9R3>
 <ZtXOmHYuTI9DQGij@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtXOmHYuTI9DQGij@zx2c4.com>

On Mon, Sep 02, 2024 at 04:41:28PM +0200, Jason A. Donenfeld wrote:
> On Mon, Sep 02, 2024 at 03:31:43PM +0100, Mark Rutland wrote:
> > ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags,
> > 			   void *opaque_state, size_t opaque_len)
> > {
> > 	if (alternative_has_cap_likely(ARM64_HAS_FPSIMD)) {
> > 		return __cvdso_getrandom(buffer, len, flags,
> > 					 opaque_state, opaque_len);
> > 	}
> > 
> > 	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags))
> > 		return -ENOSYS;
> > 	
> > 	return getrandom_syscall(buffer, len, flags);
> > }
> > 
> > ... though the conditions for returning -ENOSYS look very odd to me; why
> > do we care about fast-pathing that specific case rather than forwarding
> > that to the kernel, and does __cvdso_getrandom() handle that correctly?
> 
> Adhemerval's code here is fine and correct. The opaque_len==~0UL thing
> is a special vDSO case for getting the param struct back, not something
> related to the kernel. See __cvdso_getrandom_data() for details.

Ok, so this is to say "we cannot provide a vgetrandom_opaque_params".

Is the syscall fallback just for the CRIU case mentioned in
__cvdso_getrandom_data()? The comment above __cvdso_getrandom_data()
says:

  If @buffer, @len, and @flags are 0, and @opaque_len is ~0UL, then
  @opaque_state is populated with a struct vgetrandom_opaque_params and the
  function returns 0; if it does not return 0, this function should not be
  used.

... so presumably the caller shouldn't bother to call again if it got
-ENOSYS above.

Mark.

