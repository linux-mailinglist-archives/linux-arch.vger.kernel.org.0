Return-Path: <linux-arch+bounces-7479-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA529890DC
	for <lists+linux-arch@lfdr.de>; Sat, 28 Sep 2024 19:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD061F214EE
	for <lists+linux-arch@lfdr.de>; Sat, 28 Sep 2024 17:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0F413E40F;
	Sat, 28 Sep 2024 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJ4Msfby"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B391F4A1B;
	Sat, 28 Sep 2024 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727544935; cv=none; b=hVpk/FsRBtvLbqsLpEWeIRgMpjmihpuMB7JrMXfvl5xCw55eYmVF6vMY8hKwSNxn2ETWPkQMPXOaJJEP+RiNyoYDWz9yvfOsGpfY1Wu3uuG+gIZQieSf4MNjeo0nWspru32TwrUDEjye920wc51lZ+p7rL0Yg7cIieCI4PCi+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727544935; c=relaxed/simple;
	bh=bB2TppACa73qNvdpxzZBOI5mAq3cV8/IE4AHhZY4SiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDsElIhp0Vg6VnXhmMoQ9VHGPbfXJD2mzVpnU3+P92ETBkB70R6mJHOZIj0XhEOVzOY2sV87+aNeuKzolJWeLa/50nnVBISEsjZhcorEo3gAlucppiv6FWmmPH7l2swt9YynTtniXeEXy3Bow4TbglNE+nrC1+Kws2Y8/mxExlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJ4Msfby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CA8C4CEC3;
	Sat, 28 Sep 2024 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727544935;
	bh=bB2TppACa73qNvdpxzZBOI5mAq3cV8/IE4AHhZY4SiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJ4MsfbyKpA8Esh+QS3uAmaX1WGDmewgqfgYwVwy7C+UjMvu2+vUCvfK3vH3KMSR/
	 ZNsVAKu9T1nJjVhLY7IsxlBe87yjC3ieL7BYmwiokaxCzLA6o5co5P32q4hEwvqE+N
	 9aZr8yG+i38uIB6k0sU8RCPd80yhRw5X37G6jkQu+taG6EQP/oTL1QNlSzMl/XH/Mr
	 awJ2kDI/4d8uMekYOWPzfOIlRmhqfv5LeMrrE1KxmL87cb614xDwcFMENyJFZ0ngXA
	 aGR/AoQ2TP8GuFgSj1VSlATiM6nqScq/svAuS2jKKS+9h/AeE34k5FLpGq6rAwpq8f
	 uIgIZQvGTAliw==
Date: Sat, 28 Sep 2024 10:35:30 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Maksim Panchenko <max4bolt@gmail.com>, Rong Xu <xur@google.com>,
	Han Shen <shenhan@google.com>,
	Sriraman Tallam <tmsriram@google.com>,
	David Li <davidxl@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	llvm@lists.linux.dev, Krzysztof Pszeniczny <kpszeniczny@google.com>,
	Stephane Eranian <eranian@google.com>,
	Maksim Panchenko <maks@meta.com>
Subject: Re: [PATCH 6/6] Add Propeller configuration for kernel build.
Message-ID: <20240928173530.GC430964@thelio-3990X>
References: <20240728203001.2551083-1-xur@google.com>
 <20240728203001.2551083-7-xur@google.com>
 <c65a07ef-6436-4e04-a263-7cad9758e9be@gmail.com>
 <CAKwvOdm0iZspjpuueBV1=eFt+Bf4edWBZsDsj10kEvTGZRye2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdm0iZspjpuueBV1=eFt+Bf4edWBZsDsj10kEvTGZRye2w@mail.gmail.com>

On Fri, Sep 27, 2024 at 03:45:39PM -0700, Nick Desaulniers wrote:
> On Thu, Sep 19, 2024 at 4:52 AM Maksim Panchenko <max4bolt@gmail.com> wrote:
> >
> > On Sun, Jul 28, 2024 at 01:29:56PM -0700, Rong Xu wrote:
> > > Add the build support for using Clang's Propeller optimizer. Like
> > > AutoFDO, Propeller uses hardware sampling to gather information
> > > about the frequency of execution of different code paths within a
> > > binary. This information is then used to guide the compiler's
> > > optimization decisions, resulting in a more efficient binary.
> >
> > Thank you for submitting the patches with the latest compiler features.
> >
> > Regarding Propeller, I want to quickly mention that I plan to send a
> > patch to include BOLT as a profile-based post-link optimizer for the
> > kernel. I'd like it to be considered an alternative that is selectable
> > at build time.
> >
> > BOLT also uses sampling, and the profile can be collected on virtually
> > any kernel (with some caveats).  There are no constraints on the
> > compiler (i.e., any version of GCC or Clang is acceptable), while Linux
> > perf is the only external dependency used for profile collection and
> > conversion. BOLT works on top of AutoFDO and LTO but can be used without
> > them if the user desires. The build overhead is a few seconds.
> >
> > As you've heard from the LLVM discussion
> > (https://discourse.llvm.org/t/optimizing-the-linux-kernel-with-autofdo-including-thinlto-and-propeller)
> > and LPC talk (https://lpc.events/event/18/contributions/1921/), at Meta,
> > we've also successfully optimized the kernel and got similar results.
> >
> > Again, this is a heads-up before the patch, and I would like to hear
> > what people think about having a binary optimizer as a user-selectable
> > alternative to Propeller.
> 
> I'd imagine that folks would be interested in running Propeller, or
> BOLT, but perhaps not both.
> 
> In that sense, Kconfig has the means to express mutual exclusion.
> It's perhaps worth working together to get the kconfig selection
> working such that folks can play with enabling these newer toolchain
> related technologies.

Right, I would expect this to just be a Kconfig choice with a
description like "Post link optimization" or something of the sort, like
the RANDSTRUCT or DEBUG_INFO ones. If it does make sense to do them at
the same time, they can obviously be separate.

> The next instance of the bi-weekly public Clang Built Linux meeting is
> next Wednesday. (Links from https://clangbuiltlinux.github.io/)
> 
> Perhaps it's worth Rong (and Sriraman and Han) and Maksim to stop by and chat?

I would certainly be open to discussing the plans for upstreaming these
in the meeting. I think the sessions went well in the Toolchains Track.
There were no major objections from what I could tell.

Cheers,
Nathan

