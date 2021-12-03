Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6E146791B
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 15:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352478AbhLCOMb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 09:12:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:3853 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241626AbhLCOMa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Dec 2021 09:12:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="234486196"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="234486196"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 06:09:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="460882745"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga006.jf.intel.com with ESMTP; 03 Dec 2021 06:08:51 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1B3E8nHa007780;
        Fri, 3 Dec 2021 14:08:49 GMT
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
Subject: Re: [PATCH v8 04/14] linkage: add macros for putting ASM functions into own sections
Date:   Fri,  3 Dec 2021 15:08:20 +0100
Message-Id: <20211203140820.82341-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <Yanj8qvo3Wj4ePyV@hirez.programming.kicks-ass.net>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com> <20211202223214.72888-5-alexandr.lobakin@intel.com> <Yanj8qvo3Wj4ePyV@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 3 Dec 2021 10:31:30 +0100

> On Thu, Dec 02, 2021 at 11:32:04PM +0100, Alexander Lobakin wrote:
> 
> > diff --git a/include/linux/linkage.h b/include/linux/linkage.h
> > index dbf8506decca..baaab7dece08 100644
> > --- a/include/linux/linkage.h
> > +++ b/include/linux/linkage.h
> > @@ -355,4 +355,86 @@
> >  
> >  #endif /* __ASSEMBLY__ */
> >  
> > +/*
> > + * Allow ASM symbols to have their own unique sections if they are being
> > + * generated by the compiler for C functions (DCE, FG-KASLR, LTO).
> > + */
> > +#if (defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) && !defined(MODULE)) || \
> > +    (defined(CONFIG_FG_KASLR) && !defined(MODULE)) || \
> > +    (defined(CONFIG_MODULE_FG_KASLR) && defined(MODULE)) || \
> > +    (defined(CONFIG_LTO_CLANG))
> > +
> > +#define SYM_TEXT_SECTION(name)				\
> > +	.pushsection .text.##name, "ax"
> > +
> > +#define ASM_TEXT_SECTION(name)				\
> > +	".text." #name
> > +
> > +#define ASM_PUSH_SECTION(name)				\
> > +	".pushsection .text." #name ", \"ax\""
> > +
> > +#else /* just .text */
> > +
> > +#define SYM_TEXT_SECTION(name)				\
> > +	.pushsection .text, "ax"
> > +
> > +#define ASM_TEXT_SECTION(name)				\
> > +	".text"
> > +
> > +#define ASM_PUSH_SECTION(name)				\
> > +	".pushsection .text, \"ax\""
> > +
> > +#endif /* just .text */
> 
> That's terribly inconsistent, SYM_TEXT_SECTION is in fact
> PUSH_TEXT_SECTION, ASM_PUSH_SECTION is in fact ASM_PUSH_TEXT_SECTION and
> should be stringify(PUSH_TEXT_SECTION()) or something, and they're all
> repeating that ASM_TEXT_SECTION thing :/

Right. In fact I was waiting for someone to review them to pick more
fitting names, so I'll change them for sure.

> > +
> > +#ifdef __ASSEMBLY__
> > +
> > +#define SYM_TEXT_END_SECTION				\
> > +	.popsection
> > +
> > +#define SYM_FUNC_START_LOCAL_ALIAS_SECTION(name)	\
> > +	SYM_TEXT_SECTION(name) ASM_NL			\
> > +	SYM_FUNC_START_LOCAL_ALIAS(name)
> > +
> > +#define SYM_FUNC_START_LOCAL_SECTION(name)		\
> > +	SYM_TEXT_SECTION(name) ASM_NL			\
> > +	SYM_FUNC_START_LOCAL(name)
> > +
> > +#define SYM_FUNC_START_NOALIGN_SECTION(name)		\
> > +	SYM_TEXT_SECTION(name) ASM_NL			\
> > +	SYM_FUNC_START_NOALIGN(name)
> > +
> > +#define SYM_FUNC_START_WEAK_SECTION(name)		\
> > +	SYM_TEXT_SECTION(name) ASM_NL			\
> > +	SYM_FUNC_START_WEAK(name)
> > +
> > +#define SYM_FUNC_START_SECTION(name)			\
> > +	SYM_TEXT_SECTION(name) ASM_NL			\
> > +	SYM_FUNC_START(name)
> > +
> > +#define SYM_CODE_START_LOCAL_NOALIGN_SECTION(name)	\
> > +	SYM_TEXT_SECTION(name) ASM_NL			\
> > +	SYM_CODE_START_LOCAL_NOALIGN(name)
> > +
> > +#define SYM_CODE_START_NOALIGN_SECTION(name)		\
> > +	SYM_TEXT_SECTION(name) ASM_NL			\
> > +	SYM_CODE_START_NOALIGN(name)
> > +
> > +#define SYM_CODE_START_SECTION(name)			\
> > +	SYM_TEXT_SECTION(name) ASM_NL			\
> > +	SYM_CODE_START(name)
> > +
> > +#define SYM_FUNC_END_ALIAS_SECTION(name)		\
> > +	SYM_FUNC_END_ALIAS(name) ASM_NL			\
> > +	SYM_TEXT_END_SECTION
> > +
> > +#define SYM_FUNC_END_SECTION(name)			\
> > +	SYM_FUNC_END(name) ASM_NL			\
> > +	SYM_TEXT_END_SECTION
> > +
> > +#define SYM_CODE_END_SECTION(name)			\
> > +	SYM_CODE_END(name) ASM_NL			\
> > +	SYM_TEXT_END_SECTION
> > +
> > +#endif /* __ASSEMBLY__ */
> 
> *URGH* why do we have to have new macros for this? SYM_FUNC_START*()
> already takes the name as argument.

I'm not sure whether we should have new macros for this.
I introduced them since there's plenty of code which use
SYM_FUNC_*(), but does .{push,pop}section outside of it, e.g. to
place something to .noinstr or .init. If I'd replace them, those
would be broken.
So I'm fine with the replacement, but those cases need to be
adressed somehow then. Are there any tricks to check if we're
already outside of .text to not push it into a new section?

Al
