Return-Path: <linux-arch+bounces-5721-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610D0940BE9
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 10:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808F61C2347D
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 08:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298EB194087;
	Tue, 30 Jul 2024 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Km9F4RaV"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D2193066;
	Tue, 30 Jul 2024 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328851; cv=none; b=jnARQbEOmTOOrsIslwRou44p9n+w6k6NhI+6KaBXs2x+g9W6l+48+kRcBIvy4jniRXHO+eN76tEFXnwEjzSkOAQf3GKkw5iejASyZjE6TrX7cgbzmmUS+McSsXzUfgtZLiThKKBqFgWlMQj41NkA+LFlyBtDK3D5QlXILYiOWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328851; c=relaxed/simple;
	bh=nZd2WFa/BFa2Wh9CCI1mPOaoBTlzNfmjCCrRhldTlNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l76n5n0d9C6e7vFBPGByjmBhtYqfuSMapOvpMTwix1ZgwADPiX4LsVHgZSXfcM+YiNAAinyWQT1oMKB542wuwTyjMZ0L4/qKsuZDRpSsCQWPRzdZuEec9uB6/h7l3ygUVtj1TlVScNd8LOIWlZGo9Gyr7/F5oAKdTKmeHXvMmx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Km9F4RaV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bo2kAWD8LuGjgNSs5tujEKf4zGPICTRSsQ2YPTNISb0=; b=Km9F4RaVi93yCBpPAUzpv+oWuh
	QwbBMEnVHC9dgTposdKBwLTlLlaO2QHGVhhQxrGkekdNmHXeBBtjl3rggLggAPy0BERtqd1MuDIFU
	CaOM6xVXrP2U8/xhob9Dups/x0/IPQBWEyDVUbPW6vbeCUyvAXBPwvyjD+YYX6Li0QdrVdA9xJ7qv
	tQvKVCM3/hdIJeq4xPTqvJwSmpDudxGrfvEtjnvwPNP5me2ksKl6jO020mzi5yX7sFukNuAGfBwip
	k65pbLJS9GQ+S9svj4fF2N9IWqlLf5/6D8fuUYHwgtJv7PNRloLCu15A8LOTIp5nH8hAYTdZhsFO9
	6Eghtplw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYiP9-0000000ETfo-26LY;
	Tue, 30 Jul 2024 08:40:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B5F303001AD; Tue, 30 Jul 2024 10:40:22 +0200 (CEST)
Date: Tue, 30 Jul 2024 10:40:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rong Xu <xur@google.com>
Cc: Han Shen <shenhan@google.com>, Sriraman Tallam <tmsriram@google.com>,
	David Li <davidxl@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	John Moon <john@jmoon.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rafael Aquini <aquini@redhat.com>, Petr Pavlu <petr.pavlu@suse.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Benjamin Segall <bsegall@google.com>,
	Breno Leitao <leitao@debian.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Krzysztof Pszeniczny <kpszeniczny@google.com>
Subject: Re: [PATCH 3/6] Change the symbols order when --ffuntion-sections is
 enabled
Message-ID: <20240730084022.GH33588@noisy.programming.kicks-ass.net>
References: <20240728203001.2551083-1-xur@google.com>
 <20240728203001.2551083-4-xur@google.com>
 <20240729093405.GC37996@noisy.programming.kicks-ass.net>
 <CAF1bQ=Ta9MyoLhUjMTx479UWbHGK-cskbTTe_OudqeZRqV6w0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1bQ=Ta9MyoLhUjMTx479UWbHGK-cskbTTe_OudqeZRqV6w0Q@mail.gmail.com>

On Mon, Jul 29, 2024 at 11:48:54AM -0700, Rong Xu wrote:

> > defined(CONFIG_LTO_CLANG)
> > > +#define TEXT_TEXT                                                    \
> > > +             *(.text.asan.* .text.tsan.*)                            \
> > > +             *(.text.unknown .text.unknown.*)                        \
> > > +             *(.text.unlikely .text.unlikely.*)                      \
> > > +             ALIGN_FUNCTION();                                       \
> >
> > Why leave the above text sections unaligned?
> >
> 
> They are considered cold text. They are not aligned before the change. But
> I have no objections to making it aligned.

At least x86 has hard assumptions about function alignment always being
respected -- see the most horrible games we play with
CONFIG_CALL_THUNKS.

Or is this only text parts and not actual functions in these sections?
In which case we can probably get away with not respecting the function
call alignment, although we should probably still respect the branch
alignment -- but I forgot if we made use of that :/


> >
> > > +             *(.text.hot .text.hot.*)                                \
> > > +             *(TEXT_MAIN .text.fixup)                                \
> > > +             NOINSTR_TEXT                                            \
> > > +             *(.ref.text)                                            \
> > > +     MEM_KEEP(init.text*)
> > > +#else
> > >  #define TEXT_TEXT                                                    \
> > >               ALIGN_FUNCTION();                                       \
> > >               *(.text.hot .text.hot.*)                                \
> > > @@ -594,7 +606,8 @@
> > >               NOINSTR_TEXT                                            \
> > >               *(.ref.text)                                            \
> > >               *(.text.asan.* .text.tsan.*)                            \
> > > -     MEM_KEEP(init.text*)                                            \
> > > +     MEM_KEEP(init.text*)
> > > +#endif
> > >
> > >
> > >  /* sched.text is aling to function alignment to secure we have same
> > > --
> > > 2.46.0.rc1.232.g9752f9e123-goog
> > >
> >

