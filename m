Return-Path: <linux-arch+bounces-6027-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D92F9486FD
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 03:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C28282B7C
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 01:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798E8F6D;
	Tue,  6 Aug 2024 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEzjgHGN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A828D8F62;
	Tue,  6 Aug 2024 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722907680; cv=none; b=YHuhFpQZ1NM+NHoBpnel75/KrdwR0iMCWB5R/xmQjlL76f2JxmmgJdj3XUMm+Xq1Xj02G2YtXCihvDPARBW6e/JF3Y9OFoPT0cRyNO+WfGbCujrB5mXO5lmUy19857suSikZ4cVNrTuziwBuR/2EkykcMtLKigUNZu5GBLAKZXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722907680; c=relaxed/simple;
	bh=aIfOxL3rtOChdt3CLqv4K7JL0Tufmfdr6MR2r8LWXZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ol0LgcZSO/FuY1npU2DlTkyGyMxhSqeG3WLPB75SZGx7WVdn9uilT+uNPjNdYQ+FFLZa7ICCpGA1RqR/HGTrho7AssYBe3hEdm/o4QozsSA0ogRfaNiI1Tcj9XVhepC1xjKH8jol8o6Anfe6r23eoHvZSY4VQYCrCrqr7AeeLHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEzjgHGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AF2C32782;
	Tue,  6 Aug 2024 01:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722907680;
	bh=aIfOxL3rtOChdt3CLqv4K7JL0Tufmfdr6MR2r8LWXZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DEzjgHGNlgbqmK2mVmCz9C8IEZB2HDN2a8ja+5OLyah6qlvRrnd8pl0P7Ixfw3EEP
	 y7rDUY0KtiET+W6nUHVLdmj38iQHKpHvmOqat4kcVmocatbu8YmGfwf4zzEAFN8/DN
	 66d/dxGS7yLdybB6gOAxxqRdm9Fm8sBYuGqQpFlLzfvdtSd4PTvQB2KnvJ5UwnAaK/
	 0C8PMyQ+Jt/KHMj2U9RoCyMbRVwRFrGkTfefzdRMrNMvUiy/2VrF7b40r9C16PLYCu
	 5xMrsRfazUFhSFrZiyy+yeIJg1qgE9laFK+WIgWLL9J86XaFH93FpaMQpe5Wi5kDC6
	 dMi66ky02syCA==
Message-ID: <eacb9a3c-0d76-47d2-8b80-59d6a58fe4b4@kernel.org>
Date: Mon, 5 Aug 2024 18:27:57 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cmpxchg 2/3] ARC: Emulate one-byte cmpxchg
To: "Paul E. McKenney" <paulmck@kernel.org>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
 peterz@infradead.org, torvalds@linux-foundation.org, arnd@arndb.de,
 geert@linux-m68k.org, palmer@rivosinc.com, mhiramat@kernel.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 Vineet Gupta <vgupta@kernel.org>, Andi Shyti <andi.shyti@linux.intel.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>
References: <c1b7f3a2-da50-4dfb-af6f-a1898eaf2b79@paulmck-laptop>
 <20240805192119.56816-2-paulmck@kernel.org>
Content-Language: en-US
From: Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20240805192119.56816-2-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paul,

On 8/5/24 12:21, Paul E. McKenney wrote:
> Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on arc.
>
> [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
> [ paulmck: Apply feedback from Naresh Kamboju. ]
> [ paulmck: Apply kernel test robot feedback. ]
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: <linux-snps-arc@lists.infradead.org>
> ---
>  arch/arc/Kconfig               |  1 +
>  arch/arc/include/asm/cmpxchg.h | 33 ++++++++++++++++++++++++---------
>  2 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index fd0b0a0d4686a..163608fd49d18 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -13,6 +13,7 @@ config ARC
>  	select ARCH_HAS_SETUP_DMA_OPS
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +	select ARCH_NEED_CMPXCHG_1_EMU
>  	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
>  	select ARCH_32BIT_OFF_T
>  	select BUILDTIME_TABLE_SORT
> diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
> index e138fde067dea..2102ce076f28b 100644
> --- a/arch/arc/include/asm/cmpxchg.h
> +++ b/arch/arc/include/asm/cmpxchg.h
> @@ -8,6 +8,7 @@
>  
>  #include <linux/build_bug.h>
>  #include <linux/types.h>
> +#include <linux/cmpxchg-emu.h>
>  
>  #include <asm/barrier.h>
>  #include <asm/smp.h>
> @@ -46,6 +47,9 @@
>  	__typeof__(*(ptr)) _prev_;					\
>  									\
>  	switch(sizeof((_p_))) {						\
> +	case 1:								\
> +		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
> +		break;							\
>  	case 4:								\
>  		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
>  		break;							\
> @@ -65,16 +69,27 @@
>  	__typeof__(*(ptr)) _prev_;					\
>  	unsigned long __flags;						\
>  									\
> -	BUILD_BUG_ON(sizeof(_p_) != 4);					\

Is this alone not sufficient: i.e. for !LLSC let the atomic op happen
under a spin-lock for non 4 byte quantities as well.

> +	switch(sizeof((_p_))) {						\
> +	case 1:								\
> +		__flags = cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
> +		_prev_ = (__typeof__(*(ptr)))__flags;			\
> +		break;							\
> +		break;							\

FWIW, the 2nd break seems extraneous.

> +	case 4:								\
> +		/*							\
> +		 * spin lock/unlock provide the needed smp_mb()		\
> +		 * before/after						\
> +		 */							\
> +		atomic_ops_lock(__flags);				\
> +		_prev_ = *_p_;						\
> +		if (_prev_ == _o_)					\
> +			*_p_ = _n_;					\
> +		atomic_ops_unlock(__flags);				\
> +		break;							\
> +	default:							\
> +		BUILD_BUG();						\
> +	}								\
>  									\
> -	/*								\
> -	 * spin lock/unlock provide the needed smp_mb() before/after	\
> -	 */								\
> -	atomic_ops_lock(__flags);					\
> -	_prev_ = *_p_;							\
> -	if (_prev_ == _o_)						\
> -		*_p_ = _n_;						\
> -	atomic_ops_unlock(__flags);					\
>  	_prev_;								\
>  })

-Vineet

