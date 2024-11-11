Return-Path: <linux-arch+bounces-8970-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 497B59C42E5
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 17:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50CC5B263E0
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 16:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701F71A302E;
	Mon, 11 Nov 2024 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsUWRn5p"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383A61A2567;
	Mon, 11 Nov 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343389; cv=none; b=ed6dB909f0FH7ywWTvg2YwjQkyuyEbKqHC+zMA55RV8lIfT60I6e1hFIY3tgFWyjTOqPfeS/dmJs7KENDegVLFdtQxZ1m8vX+6U6JUNtVHF7dhIiTt9o0JEcp7hTei3TPjuAkdYnm8lN2opBCHW23EGUJumHdDLLYDd++mW7s3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343389; c=relaxed/simple;
	bh=8LcuKBa4qQ//6vbLQtCbLIDn7Tu0SEyNaNQfDlz9+W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTlf2GIoIxPsStGzVTnWP3EREK6FX9vrGOBwXOqTiSQxfw1HoBRTRz2X+X/rtBWjaQJWJinwROOi2w7B9pYLHAMd1l0VU9VRtTNexgi+QToBqDXQyNi4SbeCXm3o4j3EBN9hkmgFKypFqWq91lgTLCbgWtXd9lKBphtOrF4sQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsUWRn5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4B0C4CED5;
	Mon, 11 Nov 2024 16:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731343388;
	bh=8LcuKBa4qQ//6vbLQtCbLIDn7Tu0SEyNaNQfDlz9+W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nsUWRn5pQ9zAC+vEhSOk2nBLpS4RtWPGeYp58OoprG91H/lXfGr8fsrwrWCooDlHH
	 lt/Xm59Tj1q/Ulh309ingSrN0Ss6wiMuJnllOp9K9mMH7RsEorG5bz1bB4tIXZOivt
	 +mgoJyNBIKihujDaq0aQS0sDS89kOm4sHb9PxwWg1WZuK65C85ya+QtwqxSCFd3+SO
	 VLXSxq7SnJpAbc4JyYoGWbiMitxQW0PAxG54qACqB2jnl/jXw3PEU8yoqxQ+fTJ7/a
	 Tvk6sUDJSM4ss+TKDp0yD0NVXRRzojCU/z/5z0+iKjBmOb7KkHkgXV+ODF3NVGD773
	 pM2jefdJJcPKQ==
Date: Mon, 11 Nov 2024 16:43:00 +0000
From: Will Deacon <will@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
Message-ID: <20241111164259.GA20042@willie-the-truck>
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
 <20241103145153.105097-14-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103145153.105097-14-alexghiti@rivosinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Nov 03, 2024 at 03:51:53PM +0100, Alexandre Ghiti wrote:
> In order to produce a generic kernel, a user can select
> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> spinlock implementation if Zabha or Ziccrse are not present.
> 
> Note that we can't use alternatives here because the discovery of
> extensions is done too late and we need to start with the qspinlock
> implementation because the ticket spinlock implementation would pollute
> the spinlock value, so let's use static keys.

I think the static key toggling takes a mutex (jump_label_lock()) which
can take a spinlock (lock->wait_lock) internally, so I don't grok how
this works:

> +static void __init riscv_spinlock_init(void)
> +{
> +	char *using_ext = NULL;
> +
> +	if (IS_ENABLED(CONFIG_RISCV_TICKET_SPINLOCKS)) {
> +		pr_info("Ticket spinlock: enabled\n");
> +		return;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&
> +	    IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&
> +	    riscv_isa_extension_available(NULL, ZABHA) &&
> +	    riscv_isa_extension_available(NULL, ZACAS)) {
> +		using_ext = "using Zabha";
> +	} else if (riscv_isa_extension_available(NULL, ZICCRSE)) {
> +		using_ext = "using Ziccrse";
> +	}
> +#if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
> +	else {
> +		static_branch_disable(&qspinlock_key);
> +		pr_info("Ticket spinlock: enabled\n");
> +		return;
> +	}
> +#endif

i.e. we've potentially already used the qspinlock at this point.

Will

