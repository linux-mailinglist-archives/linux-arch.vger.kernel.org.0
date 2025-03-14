Return-Path: <linux-arch+bounces-10820-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7836AA61073
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 12:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6BC461D93
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 11:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030EF1FCFFC;
	Fri, 14 Mar 2025 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stxdG8mU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC38635A;
	Fri, 14 Mar 2025 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953360; cv=none; b=Bn+/gbDjcpo+dCKzknfVCEJGOmmfJjZ2r/ncoCnQw+0z0lvDVScGIWe5Q8RIfIGVMVyPDJrV2uET1Fv407o262t26pFpZc/rbEI4doK5Wv333yJunRvBnfryYIsO1jK3OgWpiKyhEU3Iev+V0uGNUhtydXsoGArnd3H9SHUudLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953360; c=relaxed/simple;
	bh=7Hx6Q9lC2DgdGt5P1YXcQpLbuvxU/kOlzCk1p2eLrbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W13g/r40+/2+n0epaqcxdY7BzXqjcLGfke/eZvO3HsXihQViHVdNaQgcffFIPGFE8GOFy+sImlOLTDin+8KDCH+lICuh/w1t7pp8VZqBzzCtdShRAbgwuqxiochFXYwPsdHNpiHVbiS5wOH06CAQJWyIEhchufOzzdsOdghQWps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stxdG8mU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC4AC4CEE9;
	Fri, 14 Mar 2025 11:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741953360;
	bh=7Hx6Q9lC2DgdGt5P1YXcQpLbuvxU/kOlzCk1p2eLrbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stxdG8mU4g020nWvNrre/5eu7WrtFVA/R54Fm4ssOU9wK5zqhQK/Pexraw3aiMQml
	 18vKDhy2sGSD/TQFeT8RV3/xXgP0AXl7Bln42uuNqsYrh5DadUzexD7rx1XbvidYfx
	 6Dr2q73RpT5Drju6YYHJjP68pLS3oRSKhdpVm9FMl75iGaGyb3D1EYIiFZ8Yb8XJnj
	 OVbpQCly7/plRE9G24RZujweR53javdoOoUS+uSIbqn95rvxs6hBlkQJVYwiaXqQwG
	 /kSHDb7GZ/kQSoJdYWkQV+CqIHRItdPcrtgWn5+pqExzoSd9x5DAaLF+iKtJ3P/diZ
	 nTnjBTaCoSoHQ==
Date: Fri, 14 Mar 2025 11:55:55 +0000
From: Will Deacon <will@kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 08/41] arm64: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 uapi headers
Message-ID: <20250314115554.GA8986@willie-the-truck>
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-9-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314071013.1575167-9-thuth@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Mar 14, 2025 at 08:09:39AM +0100, Thomas Huth wrote:
> __ASSEMBLY__ is only defined by the Makefile of the kernel, so
> this is not really useful for uapi headers (unless the userspace
> Makefile defines it, too). Let's switch to __ASSEMBLER__ which
> gets set automatically by the compiler when compiling assembly
> code.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/arm64/include/uapi/asm/kvm.h        | 2 +-
>  arch/arm64/include/uapi/asm/ptrace.h     | 4 ++--
>  arch/arm64/include/uapi/asm/sigcontext.h | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

Is there a risk of breaking userspace with this? I wonder if it would
be more conservative to do something like:

#if !defined(__ASSEMBLY__) && !defined(__ASSEMBLER__)

so that if somebody is doing '#define __ASSEMBLY__' then they get the
same behaviour as today.

Or maybe we don't care?

Will

