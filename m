Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0A44B2951
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 16:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiBKPpy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 10:45:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiBKPpy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 10:45:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE48D83;
        Fri, 11 Feb 2022 07:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D4ssCnbjOmNx384cUCrIrcB0A0RSUiH80NWH2bqiycM=; b=fWCZewgQBtczZ5rQ18W9dGavBq
        WsPEEA/EumPa5pCR08AiIjkpkUkAZxC72NFzZ0YpEzqv1lSCm5DJzhLPql8GKpProhdkTIRMlEOJB
        W9trXGDv0a1Pm877onXAxSun4yukfD0kQccuY09LBWaHZQT5gCvPVgSYDoYYtGb2QRUD+moxXuLtQ
        SmYmYiEGsczGASUBctESrAVeejE2JiV9TkeR5OwkJf4dtG3XygJEZ/m4h+o8aldGWhTARDjLKtzwL
        GLdQSC5qL6HKX1mtdEEFdTTadVDQvEPqb1HPyc93cPdaqB8L+iSMt7ZM+Hz8VGK9Anu+uvBhXZ6uX
        fi8sFVJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIY6u-0093nF-P9; Fri, 11 Feb 2022 15:45:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6075C98630A; Fri, 11 Feb 2022 16:45:24 +0100 (CET)
Date:   Fri, 11 Feb 2022 16:45:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-hardening@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
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
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [PATCH v10 05/15] x86: support asm function sections
Message-ID: <20220211154524.GX23216@worktop.programming.kicks-ass.net>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
 <20220209185752.1226407-6-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209185752.1226407-6-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 09, 2022 at 07:57:42PM +0100, Alexander Lobakin wrote:
> Address places which need special care and enable
> CONFIG_ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS.
> 
> Notably:
>  - propagate `--sectname-subst` to KBUILD_AFLAGS in
>    x86/boot/Makefile and x86/boot/compressed/Makefile as both
>    override them;
>  - symbols starting with a dot (like ".Lrelocated") should be
>    handled manually with SYM_*_START_SECT(.Lrelocated, relocated)
>    as "two dots" is a special (and CPP doesn't want to concatenate
>    two dots in general);
>  - some symbols explicitly need to reside in one section (like
>    kexec control code, hibernation page etc.);
>  - macros creating aliases for functions (like __memcpy() for
>    memcpy() etc.) should go after the main declaration (as
>    aliases should be declared in the same section and they
>    don't have SYM_PUSH_SECTION() inside);
>  - things like ".org", ".align" should be manually pushed to
>    the same section the next symbol goes to;
>  - expand indirect_thunk wildcards in vmlinux.lds.S to catch
>    symbols back into the "main" section;
>  - inline ASM functions like __raw_callee*() should be pushed
>    manually as well.
> 
> With these changes and `-ffunction-sections` enabled, "plain"
> ".text" section is empty which means that everything works
> right as expected.
> 
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  arch/x86/Kconfig                              |  1 +
>  arch/x86/boot/Makefile                        |  1 +
>  arch/x86/boot/compressed/Makefile             |  1 +
>  arch/x86/boot/compressed/head_32.S            |  2 +-
>  arch/x86/boot/compressed/head_64.S            | 32 ++++++++++++-------
>  arch/x86/boot/pmjump.S                        |  2 +-
>  arch/x86/crypto/aesni-intel_asm.S             |  4 +--
>  arch/x86/crypto/poly1305-x86_64-cryptogams.pl |  4 +++
>  arch/x86/include/asm/paravirt.h               |  2 ++
>  arch/x86/include/asm/qspinlock_paravirt.h     |  2 ++
>  arch/x86/kernel/head_32.S                     |  4 +--
>  arch/x86/kernel/head_64.S                     |  4 +--
>  arch/x86/kernel/kprobes/core.c                |  2 ++
>  arch/x86/kernel/kvm.c                         |  2 ++
>  arch/x86/kernel/relocate_kernel_32.S          | 10 +++---
>  arch/x86/kernel/relocate_kernel_64.S          | 12 ++++---
>  arch/x86/kernel/vmlinux.lds.S                 |  2 +-
>  arch/x86/kvm/emulate.c                        |  7 +++-
>  arch/x86/lib/copy_user_64.S                   |  2 +-
>  arch/x86/lib/error-inject.c                   |  2 ++
>  arch/x86/lib/getuser.S                        |  5 ++-
>  arch/x86/lib/memcpy_64.S                      |  4 +--
>  arch/x86/lib/memmove_64.S                     |  5 ++-
>  arch/x86/lib/memset_64.S                      |  5 +--
>  arch/x86/lib/putuser.S                        |  2 +-
>  arch/x86/power/hibernate_asm_32.S             | 10 +++---
>  arch/x86/power/hibernate_asm_64.S             | 10 +++---
>  27 files changed, 89 insertions(+), 50 deletions(-)

Urgh, how much of that can you avoid by (ab)using __DISABLE_EXPORTS
like:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=x86/wip.ibt&id=ab74f54f2b1f6cfeaf2b3ba6999bde7cabada9ca

