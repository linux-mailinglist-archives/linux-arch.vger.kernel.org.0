Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7106146FF48
	for <lists+linux-arch@lfdr.de>; Fri, 10 Dec 2021 12:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbhLJLFS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Dec 2021 06:05:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:62189 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234606AbhLJLFS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Dec 2021 06:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639134103; x=1670670103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EBain5rvAuM0ab2ClY+MBBH0nuRkV+7ToR7QQbmwcnQ=;
  b=fyHnR0rV98IWI7DyUobpD6PzwYJuPoaXLM34NsO2K4bhRGCwI8ZrZDL+
   AVZRNWffcZ7H9Hpu4PubFDBc6+dM2CK7IYcJtJuCHvGydHpuQz8wfcquu
   1ZevKgTxVG7tkFS4RKFGk7r0hEEO8MwMSMTRY4VI5N1JCDWsUy6TSGZIH
   fHmPZHGCKN2DejZ74m6L+GYHOZtp4b31ChYM7lo/9iyNKXzv9rNoiumtj
   2kK959X7QxKOdz5FyfnfmwnD5CPFC+5Zk/H3yYIXuLeyErKhNgYpN7dWo
   Nj8AjzDuYIvV80WfEIK7FeLaL3OIdU/2IyfCki6XtxeZmy03JLMZ8EJjJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="237062193"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="237062193"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:01:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="612893140"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga004.jf.intel.com with ESMTP; 10 Dec 2021 03:01:34 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1BAB1WjI016878;
        Fri, 10 Dec 2021 11:01:32 GMT
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
        "H . J . Lu" <hjl.tools@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
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
Subject: Re: [PATCH v8 05/14] x86: conditionally place regular ASM functions into separate sections
Date:   Fri, 10 Dec 2021 12:01:02 +0100
Message-Id: <20211210110102.707759-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <Yanm6tJ2obi1aKv6@hirez.programming.kicks-ass.net>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com> <20211202223214.72888-6-alexandr.lobakin@intel.com> <Yanm6tJ2obi1aKv6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 3 Dec 2021 10:44:10 +0100

> On Thu, Dec 02, 2021 at 11:32:05PM +0100, Alexander Lobakin wrote:
> > Use the newly introduces macros to create unique separate sections
> > for (almost) every "regular" ASM function (i.e. for those which
> > aren't explicitly put into a specific one).
> > There should be no leftovers as input .text will be size-asserted
> > in the LD script generated for FG-KASLR.
> 
> *groan*...
> 
> Please, can't we do something like:
> 
> #define SYM_PUSH_SECTION(name)	\
> .if section == .text		\
> .push_section .text.##name	\
> .else				\
> .push_section .text		\
> .endif

This condition

.pushsection .text
.if section == .text
# do something
.endif
.popsection

doesn't really works. `do something` doesn't happen.
This works only when

.pushsection .text
.equ section, .text

but it's not really okayish I'd say to find all .{,push}section
occurences and replace them with a macro (which would also do .equ).

I don't really know how %S with --sectname-subst should help me as

.if %S == .text
# do something
.endif

doesn't work at all (syntax error) -- and it shouldn't, %S is
supposed to work only inside .{,push}section directives.

I could do unconditional

.pushsection %S.##name
                ^^^^^^ function name

but this would involve changing LDS scripts (and vmlinux.lds.h) to
let's say replace *(.noinstr.text) with *(.noinstr.text*).

So I hope there is a way to get current section name? If not, then
the last option is the least harmful I suppose.
At least not as harmful as current approach with alternative macros,
far from it lol.

> 
> #define SYM_POP_SECTION()	\
> .pop_section
> 
> and wrap that inside the existing SYM_FUNC_START*() SYM_FUNC_END()
> macros.

Thanks,
Al
