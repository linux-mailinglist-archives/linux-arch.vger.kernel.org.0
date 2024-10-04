Return-Path: <linux-arch+bounces-7701-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B47F990AC6
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 20:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9AEAB25DD3
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 18:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7881E2831;
	Fri,  4 Oct 2024 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqNXB/lO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B3347F5F;
	Fri,  4 Oct 2024 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065408; cv=none; b=E6ZlvYmkSZcWqx+yp8jbhnz9x0VzXbnaraC/g/ROBgcrSWYuiqyggdEBW55+WCzacPOWmX9J2hFWlka5wBwmzDl193fyF1q1As20FyVQKJY2nHCGrknYgaMnlOi/WMIGIbvJLU4wpzGG0LI08LxozB0ZmAQUBNFGbSvSpcheTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065408; c=relaxed/simple;
	bh=6D0M6NhojlShPMbBJLqf1wXJNIY9zP3vx504RxRB9sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkWqC5i/B5CfnhnkBf81i9pJBJIYmgSEXBzpEFfecZav9h1i6w104M7Exx6+jHUXa6mR3f0arwQAuinbJ04TQSzYuMrzAFZFJdgO6te2AYFzpfDsFltSq+1vglVueNDAAi/2aTi3RsFP35JTA4tgF5ThEPMAHDCQLJDh4YbAjd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqNXB/lO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA92C4CEC6;
	Fri,  4 Oct 2024 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065407;
	bh=6D0M6NhojlShPMbBJLqf1wXJNIY9zP3vx504RxRB9sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqNXB/lODPEFSxQXd7qtZRUef9oRXGv+8YQZJkKGC6MMGh6S9N5fClU6CcWfTekn1
	 ubYLyo9c3f/HPE/b18eAWO2bDerUbgwA9e6nArDudBzooJ7I5oVDNfOqxq5Q/AIq5s
	 d3WLbEbvsmtw+xkQKiT+1BXkzkd6V3K6uLRMGrrZ+BzqZufVfPGzaYTtx8pUToj1Em
	 Yy2E0I+FKZX9E5H4up8mQavhax2iVvPl5xhUYzC2JlgTv8iDp1/DVMJasHElultN0Z
	 JPj5YXVzaw7boFF2+js7pqHirg6I7ztczt2wQs1arNZKEpKiCG7sFcCZjcVMbqnunY
	 S7mDL7OA4hADQ==
Date: Fri, 4 Oct 2024 11:10:04 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Rong Xu <xur@google.com>
Cc: Han Shen <shenhan@google.com>, Sriraman Tallam <tmsriram@google.com>,
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
Message-ID: <202410041106.6C1BC9BDA@keescook>
References: <20241002233409.2857999-1-xur@google.com>
 <20241002233409.2857999-2-xur@google.com>
 <20241003154143.GW5594@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003154143.GW5594@noisy.programming.kicks-ass.net>

On Thu, Oct 03, 2024 at 05:41:43PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 02, 2024 at 04:34:00PM -0700, Rong Xu wrote:
> > +Preparation
> > +===========
> > +
> > +Configure the kernel with:
> > +
> > +   .. code-block:: make
> > +
> > +      CONFIG_AUTOFDO_CLANG=y
> > +
> > +
> [...]
> > +    With a configuration that with LLVM enabled, use the following command:
> > +
> > +      .. code-block:: sh
> > +
> > +         $ scripts/config -e AUTOFDO_CLANG
> [...]
> 
> Can this be done without the endless ... code-block nonsense?

The tradition in kernel .rst is to do this with the trailing "::", e.g.:

+Configure the kernel with::
+
+     CONFIG_AUTOFDO_CLANG=y

This loses the language-specific highlighting when rendered. Perhaps the
"::" extension can be further extended?

+Configure the kernel with::(make)
+
+     CONFIG_AUTOFDO_CLANG=y

Then we could avoid the extra 2 lines but still gain the rendered language
highlights?

-- 
Kees Cook

