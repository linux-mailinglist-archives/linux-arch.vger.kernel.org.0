Return-Path: <linux-arch+bounces-7715-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA0C99157D
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2024 11:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1392CB2293D
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2024 09:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF6D145341;
	Sat,  5 Oct 2024 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QEJ4ZM4d"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9482213DBBC;
	Sat,  5 Oct 2024 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728120009; cv=none; b=dvpkkGrUxeC+y+JqWnjS/+PrpqPpC2fOVxqH+fbxpQURoRpuzxqHYQP4RU75RaMe+pT8noVy/Tm3vDT1nXqijVFU7CAVvylrF3ERfmxKLz0+U0KadFA4vr+xHXu3ymk7NDYMo92a00zZvMi67CVHAheNPlaxkSex2tNtH9kk3lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728120009; c=relaxed/simple;
	bh=8veT0QNhSPCY9Nh/UKPKh526+6YL6QgmSZfnBmzx/Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGJztfaYfplcc85q34VamLCNRS4w0F9RCI0xzPYqKCYeOwbiCZa2CC+Sm/qnjUvI8Y1NeOWkmEWX1pU+bjJ8Ny3LmjjHPbHKqGXMoZbXA/KVlWSO/lHXV7CvUek85LBxYmSHaRlgiKoPkF0Rb46TP0CBiXVD+684YT6Wnc71QkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QEJ4ZM4d; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=jqf+BGdpvvy+YWR5SN7t8AeW8rPkRc4+Wr0JX3T/rfg=; b=QEJ4ZM4dWWx+5bkZO9NtSSWDHj
	CkTQW41Tl8riYYkTVwXnDd8gF1TE9+TcIOZQiO8zYNxX4CWNXRRtkCnvijVdZ5XI0aE0ASkt2m/lC
	au2srZGgaXsIPlA3cTK/ws9r3z/7wgBk4+Fq4s+CuXbgqGdmKPFrETjIPQsA4Cw18jhWbrEuOYD3L
	aKEIHrWyzzEvEMWod+ZKKF+LmWTXeGMSSmq0xVbU1mzzQB0JI+45nOMdP7KleL84/+INGss5Hm3xS
	ofw/BBI5qheIkpeYbBHjUogr7aP0Y46fmqlDb9Ag/T40rxNCvLXzqCHBldJKp/3S3Zp/z0fCte1rL
	zDU0LQ2Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sx0wn-000000041sI-4AsE;
	Sat, 05 Oct 2024 09:19:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C9CD5300777; Sat,  5 Oct 2024 11:19:32 +0200 (CEST)
Date: Sat, 5 Oct 2024 11:19:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
	Juergen Gross <jgross@suse.com>, linux-arch@vger.kernel.org,
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
Message-ID: <20241005091932.GW18071@noisy.programming.kicks-ass.net>
References: <20241002233409.2857999-1-xur@google.com>
 <20241002233409.2857999-2-xur@google.com>
 <20241003154143.GW5594@noisy.programming.kicks-ass.net>
 <202410041106.6C1BC9BDA@keescook>
 <20241004182847.GU18071@noisy.programming.kicks-ass.net>
 <CAFhGd8rPLoufNx4BMV993c+S_6psLGU6Ow49Frc9s88cStcuCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8rPLoufNx4BMV993c+S_6psLGU6Ow49Frc9s88cStcuCQ@mail.gmail.com>

On Fri, Oct 04, 2024 at 02:23:45PM -0700, Justin Stitt wrote:
> On Fri, Oct 4, 2024 at 11:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Oct 04, 2024 at 11:10:04AM -0700, Kees Cook wrote:
> >
> > > +Configure the kernel with::(make)
> > > +
> > > +     CONFIG_AUTOFDO_CLANG=y
> > >
> > > Then we could avoid the extra 2 lines but still gain the rendered language
> > > highlights?
> >
> > The whole double-colon thing is already a pain to read; you're making it
> > worse again.
> 
> Lots of people read docs on the web and having code blocks with
> monospaced fonts (+syntax highlighting) makes them easier to read
> there.
> 
> Configure the kernel with:
> 
>      CONFIG_AUTOFDO_CLANG=y
> 
> --versus--
> 
> Configure the kernel with::
> 
>      CONFIG_AUTOFDO_CLANG=y
> 
> This renders better for html through Sphinx and really can't be that
> bad to read in vim, can it?

It's weird; but I've gotten sorta used to it. I was more or less
commenting on Kees' proposal of making it:

  Configure the kernel with::(make)

Which is definitely harder to read since it insta triggers a syntax
error exception in my head.

