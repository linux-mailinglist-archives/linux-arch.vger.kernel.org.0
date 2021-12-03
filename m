Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E726467992
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 15:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244354AbhLCOpe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 09:45:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:57674 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232079AbhLCOpd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Dec 2021 09:45:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="323236323"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="323236323"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 06:42:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="501211753"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga007.jf.intel.com with ESMTP; 03 Dec 2021 06:41:59 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1B3EfuSp016541;
        Fri, 3 Dec 2021 14:41:56 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v8 00/14] Function Granular KASLR
Date:   Fri,  3 Dec 2021 15:41:36 +0100
Message-Id: <20211203144136.82915-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <YanzpvmaX1JWYf9t@hirez.programming.kicks-ass.net>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com> <YanzpvmaX1JWYf9t@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 3 Dec 2021 11:38:30 +0100

> On Thu, Dec 02, 2021 at 11:32:00PM +0100, Alexander Lobakin wrote:
> 
> > feat        make -j65 boot    vmlinux.o vmlinux  bzImage  bogoops/s
> > Relocatable 4m38.478s 24.440s 72014208  58579520  9396192 57640.39
> > KASLR       4m39.344s 24.204s 72020624  87805776  9740352 57393.80
> > FG-K 16 fps 6m16.493s 25.429s 83759856  87194160 10885632 57784.76
> > FG-K 8 fps  6m20.190s 25.094s 83759856  88741328 10985248 56625.84
> > FG-K 1 fps  7m09.611s 25.922s 83759856  95681128 11352192 56953.99
> 
> :sadface: so at best it makes my kernel compiles ~50% slower. Who would
> ever consider doing that? It's like retpolines weren't bad enough; lets
> heap on the fail?

I was waiting for that :D

I know it's horrible for now, but there are some points to consider:
 - folks who are placing hardening over everything don't mind
   compile times most likely;
 - linkers choking on huge LD scripts is actually a bug in their
   code. They process 40k sections as orphans (without a generated
   LD script) for a split second, so they're likely able to do the
   same with it. Our position here is that after FG-KASLR landing
   we'll report it and probably look into linkers' code to see if
   that can be addressed (Kees et al are on this AFAIU);
 - ClangLTO (at least "Fat", not sure about Thin as I didn't used
   it) thinks on vmlinux.o for ~5 minutes on 8-core Skylake. Still,
   it is here in mainline and is widely (relatively) used.
   I know FG-KASLR stuff is way more exotic, but anyways.
 - And the last one: I wouldn't consider FG-KASLR production ready
   as Kees would like to see it. Apart from compilation time, you
   get random performance {in,de}creases here-and-there all over
   the kernel and modules you can't predict at all.
   I guess it would become better later on when/if we introduce
   profiling-based function placement (there are some discussions
   around that and one related article is referred in the orig
   cover letter), but dunno for now.
   There's one issue in the current code as well -- PTI switching
   code is in .entry.text which doesn't currently get randomized.
   So it can probably be hunted using gadget collectors I guess?

Ok, so here's a summary of TODOs (not including sadfaces
unfortunately):
 * generate vmlinux.symbols and the corresponding variables
   on-the-go;
 * unify comparison and adjustment functions, probably reuse
   some of the already existing ones;
 * don't introduce new macros in linkage.h, just use fancy
   'section == .text' to decide in-place;
 * change new macros' names (those which shouldn' be wiped out)
   to make them more consistent;
 * look over for several code dups.

Am I missing anything else?

One more quest, what could I do with this infinitely long regexp
in gen_text_sections.pl script? Just try to wrap over or it can
be simplified somehow?

Al
