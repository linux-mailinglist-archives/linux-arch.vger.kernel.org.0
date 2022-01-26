Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D4E49CCBE
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jan 2022 15:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242373AbiAZOwG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jan 2022 09:52:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:52046 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242393AbiAZOwB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jan 2022 09:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643208721; x=1674744721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+C7GbNvdhhupsiddx9nyBA2kLdGmDvK2B+OFoSsBS2A=;
  b=lBIehyv5ZcqCNTcVcY22vJnTvHWgmJhgKUujnC1GIaH5SoRnbzTj5ECX
   UPyopMkTIeJ84XSizZkQ4/OmV9v5rIL0Y2MwdqqZcfaA4/9Ypehvmk8If
   0/cGAHSarb+yAok6fS9FROEo6pneH1z3T8ynRr2vySe4ydiEThmfw1Y7s
   cgEiG0d6hF2+SKXFhT6nlB+Fk5XJCw7JEbV4Jq4EfmbNRb1ObZ/zz2LDR
   3N7ckSQ7nuMngowD9Wjs+MY1WcCkdWa7PM5FzfTBf66nGMyh4TRDKng/m
   f7VduCIYkmssF0157ydMaQBoq+zITh9c5Gz/crUAomOeDA1PcZtc/IPRB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="230137337"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="230137337"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 06:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="617981478"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2022 06:51:52 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 20QEpn8P004691;
        Wed, 26 Jan 2022 14:51:49 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Borislav Petkov <bp@alien8.de>
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v9 05/15] x86: support ASM function sections
Date:   Wed, 26 Jan 2022 15:49:52 +0100
Message-Id: <20220126144952.851066-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YerMYcin4woehiL9@zn.tnic>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com> <20211223002209.1092165-6-alexandr.lobakin@intel.com> <YerMYcin4woehiL9@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Borislav Petkov <bp@alien8.de>
Date: Fri, 21 Jan 2022 16:08:17 +0100

> On Thu, Dec 23, 2021 at 01:21:59AM +0100, Alexander Lobakin wrote:
> > Address places which need special care and enable
> > CONFIG_ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS.
> > 
> > Notably:
> >  - propagate --sectname-subst to aflags in x86/boot/Makefile and
> >    x86/boot/compressed/Makefile as both override aflags;
> 
> s/aflags/KBUILD_AFLAGS/
> 
> Let's be more precise pls.
> 
> >  - symbols starting with a dot (like ".Lbad_gs") should be handled
> >    manually with SYM_*_START_SECT(.Lbad_gs, bad_gs) as "two dots"
> >    is a special (and CPP doesn't want to concatenate two dots in
> >    general);
> >  - some symbols explicitly need to reside in one section (like
> >    kexec control code, hibernation page etc.);
> >  - macros creating aliases for functions (like __memcpy() for
> >    memcpy() etc.) should go after the main declaration (as
> >    aliases should be declared in the same section and they
> >    don't have SYM_PUSH_SECTION() inside);
> >  - things like ".org", ".align" should be manually pushed to
> >    the same section the next symbol goes to;
> >  - expand indirect_thunk and .fixup wildcards in vmlinux.lds.S
> 
> $ git grep -E "\.fixup" arch/x86/*.S
> $
> 
> I guess I'll continue with your new version since a bunch of stuff
> has changed in arch/x86/ in the meantime so that that set would need
> refreshing.

Yeah, sure. .fixup usage was removed in particular.
I'll queue v10 soon.

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.

Thanks for the reviews,
Al

> 
> https://people.kernel.org/tglx/notes-about-netiquette
