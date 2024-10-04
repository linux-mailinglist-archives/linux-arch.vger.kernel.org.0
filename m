Return-Path: <linux-arch+bounces-7704-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C84990E7D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 21:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DFBEB2F97B
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 19:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD6B21D179;
	Fri,  4 Oct 2024 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cnnSoO+x"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF1B21CAD5;
	Fri,  4 Oct 2024 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066555; cv=none; b=CYFT8xnSAm9fSN7QATCLrzOm04oKsxFjGcXLKX3+QkHA2iEdTrPvYrdEz67KR1vSl2Kz48nzzxwQhh4EdN+bC2Mxw9YZEPgqQaRBWQoj84cvEGA2AH/HQFc9iAQhmaUojMW6NYK1pWVIaZRUXFs/ZX5cCngREw5n3b8X5mGg9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066555; c=relaxed/simple;
	bh=6lBCjiRF4B46nhbZCs3k/e4Z0301LBosumkSAIOX6LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EarPHt+fL0R3x/3UtggcW6zIqjMSUdXaClxx94kkrF1a1iwsjZdt9+4rbYX5D7eRMt/BxIjpHqe0/6uzhDKgOaBPjY8Hcll5eQSHDzFau3YXV9K6UfPzKH6VFRk9jYcuEJkX5PMhNmcJIBXOGvW9ASzW0ABfM+hUxttyyE617sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cnnSoO+x; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fOb9M6ZRjRfvVCqDlasosWrUHjFjp7Hur2fhf3PBfgg=; b=cnnSoO+x6ifbk2XZl8GRTZm8Kf
	Co4+zcisD6SR3lxix0PIP9Jh4m4Pv+xHhyh7i2N1aWvSENqf735ZdKFu3jV/Op1hKu+/Amc1ebVpQ
	jzzYwasH3PDPVdgZCCQih6N9/3qgQOsoEPOyQUPkwg8MBeG3NG6FoWaZg7GOEnzU8ASije6iYVn0g
	QKj1o/K7Cbv1VL5d4ApJkG4PMbtD+Br/8f2CgUZJMzqUnkSSngEuptT7K4ADE3JVoUFSkEUADU0bB
	++C4Mvx4vGExNnCMtNMO2zc0LYl7AMLUxTHioVqT8B7lqCBpqBrLdFdRgsXe7z6FX7Sp7Wav/lN3c
	mMDTiZbA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swn2l-0000000B26f-1O0A;
	Fri, 04 Oct 2024 18:28:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 94FA230083E; Fri,  4 Oct 2024 20:28:47 +0200 (CEST)
Date: Fri, 4 Oct 2024 20:28:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>,
	Sriraman Tallam <tmsriram@google.com>,
	David Li <davidxl@google.com>,
	Krzysztof Pszeniczny <kpszeniczny@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Brian Gerst <brgerst@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Justin Stitt <justinstitt@google.com>, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org,
	x86@kernel.org, "Xin Li (Intel)" <xin@zytor.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/6] Add AutoFDO support for Clang build
Message-ID: <20241004182847.GU18071@noisy.programming.kicks-ass.net>
References: <20241002233409.2857999-1-xur@google.com>
 <20241002233409.2857999-2-xur@google.com>
 <20241003154143.GW5594@noisy.programming.kicks-ass.net>
 <202410041106.6C1BC9BDA@keescook>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410041106.6C1BC9BDA@keescook>

On Fri, Oct 04, 2024 at 11:10:04AM -0700, Kees Cook wrote:

> +Configure the kernel with::(make)
> +
> +     CONFIG_AUTOFDO_CLANG=y
> 
> Then we could avoid the extra 2 lines but still gain the rendered language
> highlights?

The whole double-colon thing is already a pain to read; you're making it
worse again.

