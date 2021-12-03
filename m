Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFDB467B7C
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 17:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352783AbhLCQiL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 11:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbhLCQiJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 11:38:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60110C061751;
        Fri,  3 Dec 2021 08:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mssU0G/cXzs1xJenEusQw6HC5DMSHqKWJ4UVhHrgEwc=; b=pCYe9RfzBZe7t3b1I2jJLkuuWw
        YJ/2D+8XG3yafWSbVxsoa4cuaPpSNW3yRaMq2r/QTcoCtNsGbzYnj8J8f5qjGA8Q2V/pXKfwO5Kl4
        k+56WsTiE8v5nSkxjDzB8mYzdZwlwayGbV0S/XDI/SQScXxNeEZ3u76Zfu7RMn3sbz2fP91hmok6j
        urZYeHgDnYURlSyzZWxnfhRDmNjcgxpQ8WKSsRlbeWnRvfyMY7DqTT4BZ+jBkaw/4LRusumTvZ11V
        n2jt8oTpXsB8gMKCvnQdygj7+E+qFaIl2K3TYWPTp4zB7hpoUu3z9PZ4CkXn2EmJVjnwxyPY3wYlL
        8xbev1uA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtBVv-009Oew-TO; Fri, 03 Dec 2021 16:34:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B2979810D4; Fri,  3 Dec 2021 17:34:24 +0100 (CET)
Date:   Fri, 3 Dec 2021 17:34:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-hardening@vger.kernel.org, x86@kernel.org,
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
        llvm@lists.linux.dev, hjl.tools@gmail.com
Subject: Re: [PATCH v8 05/14] x86: conditionally place regular ASM functions
 into separate sections
Message-ID: <20211203163424.GK16608@worktop.programming.kicks-ass.net>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
 <20211202223214.72888-6-alexandr.lobakin@intel.com>
 <Yanm6tJ2obi1aKv6@hirez.programming.kicks-ass.net>
 <20211203141051.82467-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203141051.82467-1-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 03, 2021 at 03:10:51PM +0100, Alexander Lobakin wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri, 3 Dec 2021 10:44:10 +0100
> 
> > On Thu, Dec 02, 2021 at 11:32:05PM +0100, Alexander Lobakin wrote:
> > > Use the newly introduces macros to create unique separate sections
> > > for (almost) every "regular" ASM function (i.e. for those which
> > > aren't explicitly put into a specific one).
> > > There should be no leftovers as input .text will be size-asserted
> > > in the LD script generated for FG-KASLR.
> > 
> > *groan*...
> > 
> > Please, can't we do something like:
> > 
> > #define SYM_PUSH_SECTION(name)	\
> > .if section == .text		\
> > .push_section .text.##name	\
> > .else				\
> > .push_section .text		\
> > .endif
> > 
> > #define SYM_POP_SECTION()	\
> > .pop_section
> > 
> > and wrap that inside the existing SYM_FUNC_START*() SYM_FUNC_END()
> > macros.
> 
> Ah I see. I asked about this in my previous mail and you replied
> already (: Cool stuff, I'll use it, it simplifies things a lot.

Note, I've no idea if it works. GAS and me aren't really on speaking
terms. It would be my luck for that to be totally impossible, hjl?
