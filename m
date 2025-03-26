Return-Path: <linux-arch+bounces-11142-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE754A72010
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 21:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D407A3B6D63
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 20:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790E71F416F;
	Wed, 26 Mar 2025 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhKJK7Mh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51175137930;
	Wed, 26 Mar 2025 20:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021572; cv=none; b=YQ+d++gGJ5YGx6IkO/bE1iNPSw8S9AbXRuOH66KB8O3ReDiaRguXW7NivZYd3wPFJ7OYdFfP4imEnnEKsaBFQOXfA5vTVXRgpy3Sd1tSdv36Z/C0+OLPeiebqfednVXJQP0gV50hkUTsBmvmBuzJ8C7FK+h+5rMjKQC34BTGn6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021572; c=relaxed/simple;
	bh=+xhFLxmEGTa5Cg2nJVUgqjUIL4XXdacwm62BcgyS+F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpPuLUMsGCOPnbpKqZ9HmJXA/CKs7IXF7t4wjgFYb7Lqsia1KNaq890uva1KDiLpOuM0OoqgjYnQAMNe3brcc9PQhdrmKRcw1aE5tHLhnyUgiYUjQN/y1qQb4NVcvevmlJLCFIkxy7rrcRPnCpFYQRfMRSlq4c8n9JMA7SS0q4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhKJK7Mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3441EC4CEE2;
	Wed, 26 Mar 2025 20:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743021570;
	bh=+xhFLxmEGTa5Cg2nJVUgqjUIL4XXdacwm62BcgyS+F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WhKJK7MhBwJvG2bla2kDcOZjyNSnttVqkKSjTxeRDrEJ8JaiS+hodKtNPcBS1A67a
	 Zk2ggluCnQ7YOAHfmy/XReWMSGGsRy6WEnr/52IJc8ZgkkcR3DQtSXVh4NqjGY5oqT
	 JgLUFb9dRX1wiYEwfaUlksjSggYm6f4bdCyK2NvhmiZmEQcG+lLW80wyqC7PUpBgZD
	 zpXoYZ5+2fAUF4gnhw5XGmbk5UG6mLRWjO+BrG3Uuro9bAzJauLhSZ4bviRwF56ZG7
	 guDtBMLj7fL8YkzMMkQxbIUUSKqEh7/Vv4ADM+Uju3a+oUYhe+zWdrWgdLN8BBiXEG
	 wSwBP6W5KvSIA==
Date: Wed, 26 Mar 2025 13:39:26 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rwonce: handle KCSAN like KASAN in read_word_at_a_time()
Message-ID: <20250326203926.GA10484@ax162>
References: <20250325-kcsan-rwonce-v1-1-36b3833a66ae@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-kcsan-rwonce-v1-1-36b3833a66ae@google.com>

Hi Jann,

On Tue, Mar 25, 2025 at 05:01:34PM +0100, Jann Horn wrote:
> Also, since this read can be racy by design, we should technically do
> READ_ONCE(), so add that.
> 
> Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrastructure")
> Signed-off-by: Jann Horn <jannh@google.com>
...
> diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
> index 8d0a6280e982..e9f2b84d2338 100644
> --- a/include/asm-generic/rwonce.h
> +++ b/include/asm-generic/rwonce.h
> @@ -79,11 +79,14 @@ unsigned long __read_once_word_nocheck(const void *addr)
>  	(typeof(x))__read_once_word_nocheck(&(x));			\
>  })
>  
> -static __no_kasan_or_inline
> +static __no_sanitize_or_inline
>  unsigned long read_word_at_a_time(const void *addr)
>  {
> +	/* open-coded instrument_read(addr, 1) */
>  	kasan_check_read(addr, 1);
> -	return *(unsigned long *)addr;
> +	kcsan_check_read(addr, 1);
> +
> +	return READ_ONCE(*(unsigned long *)addr);

I bisected a boot hang that I see on arm64 with LTO enabled to this
change as commit ece69af2ede1 ("rwonce: handle KCSAN like KASAN in
read_word_at_a_time()") in -next. With LTO, READ_ONCE() gets upgraded to
ldar / ldapr, which requires an aligned address to access, but
read_word_at_a_time() can be called with an unaligned address. I
confirmed this should be the root cause by removing the READ_ONCE()
added above or removing the selects of DCACHE_WORD_ACCESS and
HAVE_EFFICIENT_UNALIGNED_ACCESS in arch/arm64/Kconfig, which avoids
the crash.

Cheers,
Nathan

