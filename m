Return-Path: <linux-arch+bounces-7699-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578D4990973
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 18:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876B51C20AC4
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 16:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B34A1CACD8;
	Fri,  4 Oct 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+QEy5UQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D407E1E3795;
	Fri,  4 Oct 2024 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059924; cv=none; b=WqsS/35RMxRD9EpkvD2rNA3+0YaOjnKo6X7RvHrd2N6OwUl+DFcowkslKqyO2XoSGh1B10nzI1JfvsBqAj3sSWvIykGz3heJwzVigjRQcHLGLjPb38vLJhDahSvmxVD81i5vGXpHkKGW1xas/vXa4vvkV/dNEL7PTn1fUnmoBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059924; c=relaxed/simple;
	bh=EixHNaPPAkeoDcpdBs00MRfg/QdKJO3PxpRNIrzAAoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaSDGU0Wy/eJL5mnEoZyMyGYW/gOoIYu0ACgo/F+Zrm4fpg9wB0wKfMkezSu9Z0SNJeudwWtjIM2lILP9EJHOv6SEM3Dkyrxg9UGn9FQaBjWej24xaJ1usaOTNwLgcK0T2eU/JqXCHAKNzkVPvfgI4QquflzgARCyczO67f+EGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+QEy5UQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FC1C4CEC6;
	Fri,  4 Oct 2024 16:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728059923;
	bh=EixHNaPPAkeoDcpdBs00MRfg/QdKJO3PxpRNIrzAAoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+QEy5UQZ7GlHaUwc+RkIpxbgzDi3nb6zoGk7fJWELHNOVn/a6kqYoqhwYTjjtUtA
	 HLN173WN7VQ9r/4cXKND2OaXnBiWj3isq+OvQ/2tKN+G1LbJKzzCSdPkqEARtSquq8
	 S0pbWPN7erj8u6mqJ9HQMZI6g563nX4W7ObXkwLnrq69CzLFx9QtyJQM8p/ViyHzEi
	 cKxlzoUaN0C66zzItaSS/hLhTkUhON+6Kvb4OfJvi7TFi3QL4RlsTcFEHjQV3yfZIn
	 wK4ar2G90hKokxv4b5g19gdgrWBvs+RjT57QFt3pEt4S0Vi7LGsHYQ0JngDFMUyYoT
	 u8hYo/RMJlkrg==
Date: Fri, 4 Oct 2024 19:35:10 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Rong Xu <xur@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Han Shen <shenhan@google.com>,
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
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org,
	x86@kernel.org, "Xin Li (Intel)" <xin@zytor.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/6] Add AutoFDO support for Clang build
Message-ID: <ZwAZPklXayA1gbQw@kernel.org>
References: <20241002233409.2857999-1-xur@google.com>
 <20241002233409.2857999-2-xur@google.com>
 <20241003154143.GW5594@noisy.programming.kicks-ass.net>
 <CAKwvOdnS-vyTXHaGm4XiLMtg4rsTuUTJ6ao7Ji-fUobZjdBVLw@mail.gmail.com>
 <20241003160309.GY5594@noisy.programming.kicks-ass.net>
 <CAKwvOd=CRiHitKeYtHH=tmT8yfDa2RSALbYn5uCC8nRq8ud79g@mail.gmail.com>
 <20241003161257.GZ5594@noisy.programming.kicks-ass.net>
 <CAF1bQ=RAizpP-T_sRGpE2-Kjsk_RZD3r_iz_dpn25W+uDzpWOw@mail.gmail.com>
 <Zv-Fy4hnuscnLH1k@kernel.org>
 <CAF1bQ=S8Hg0FUThaDU0snVqerVos6ztzVvN6sm1Ng3FnTpJt_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF1bQ=S8Hg0FUThaDU0snVqerVos6ztzVvN6sm1Ng3FnTpJt_A@mail.gmail.com>

On Fri, Oct 04, 2024 at 09:28:36AM -0700, Rong Xu wrote:
> On Thu, Oct 3, 2024 at 11:09 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Thu, Oct 03, 2024 at 11:20:17AM -0700, Rong Xu wrote:
> > > Writing the doc with all these code-blocks was not fun either.
> > > We are happy to change if there is a better way for this.
> > >
> > > -Rong
> > >
> > > On Thu, Oct 3, 2024 at 9:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Thu, Oct 03, 2024 at 09:11:34AM -0700, Nick Desaulniers wrote:
> > > >
> > > > > > It makes it absolute crap for all of us who 'render' text documents
> > > > > > using less or vi.
> > > > >
> > > > > "It hurts when I punch myself in the face."
> > > >
> > > > Weirdly enough I have a job that entails staring at text documents in
> > > > text editors all day every day :-) sorry for thinking that's a sane
> > > > thing to do.
> >
> > Something like this should do:
> >
> > > +- For enabling a single file (e.g. foo.o)::
> > > +
> > > +        AUTOFDO_PROFILE_foo.o := y
> 
> Do you mean we don't use ".. code-block:: " here and just use indented
> text separated with blank lines?

The double column (::) in the end of a paragraph means that the next paragraph
is a literal block:

https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#literal-blocks

You'd loose the coloring, but other than that it won't be different from
the ".. code-block::" and easier to read in a text form.
 
> -Rong

-- 
Sincerely yours,
Mike.

