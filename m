Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75D94961B5
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jan 2022 16:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381465AbiAUPIg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jan 2022 10:08:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44830 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238192AbiAUPIg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Jan 2022 10:08:36 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3496F1EC054E;
        Fri, 21 Jan 2022 16:08:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642777710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GFj7pSt3cRzl5y+b79elj5aGBrpZoaFIs8Y+/JGYyW8=;
        b=UjAJO0bd7nBpuV/579xwg7V3vVJbyhwJU+5HtPPNxlwfYiu+yMaMYuLdmzjEwnPA0X1F/r
        PJvRuXevaRA9P97hZRg7ydVqDq+rbps3/xYbxrOUfYcPEs/QZUR5vRAYz55VayS5DqPn4X
        n3khUusN+iYIeWihx6H1s7Rw1a/2mig=
Date:   Fri, 21 Jan 2022 16:08:17 +0100
From:   Borislav Petkov <bp@alien8.de>
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
Message-ID: <YerMYcin4woehiL9@zn.tnic>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
 <20211223002209.1092165-6-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211223002209.1092165-6-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 23, 2021 at 01:21:59AM +0100, Alexander Lobakin wrote:
> Address places which need special care and enable
> CONFIG_ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS.
> 
> Notably:
>  - propagate --sectname-subst to aflags in x86/boot/Makefile and
>    x86/boot/compressed/Makefile as both override aflags;

s/aflags/KBUILD_AFLAGS/

Let's be more precise pls.

>  - symbols starting with a dot (like ".Lbad_gs") should be handled
>    manually with SYM_*_START_SECT(.Lbad_gs, bad_gs) as "two dots"
>    is a special (and CPP doesn't want to concatenate two dots in
>    general);
>  - some symbols explicitly need to reside in one section (like
>    kexec control code, hibernation page etc.);
>  - macros creating aliases for functions (like __memcpy() for
>    memcpy() etc.) should go after the main declaration (as
>    aliases should be declared in the same section and they
>    don't have SYM_PUSH_SECTION() inside);
>  - things like ".org", ".align" should be manually pushed to
>    the same section the next symbol goes to;
>  - expand indirect_thunk and .fixup wildcards in vmlinux.lds.S

$ git grep -E "\.fixup" arch/x86/*.S
$

I guess I'll continue with your new version since a bunch of stuff
has changed in arch/x86/ in the meantime so that that set would need
refreshing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
