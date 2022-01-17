Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE3F49117A
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jan 2022 22:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbiAQVzx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jan 2022 16:55:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45214 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238246AbiAQVzv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Jan 2022 16:55:51 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FB521EC0535;
        Mon, 17 Jan 2022 22:55:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642456543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rlAKVglu1iQl9gKMOXnGKYgVbZ1OvWrfPtGJgp9ATfQ=;
        b=okZdM0249RhydtvgMuemFW7JEyVvNAMy3mH+qqtJT5Q/91DdlfnttD9rfBDMqdsw2Lplhd
        LxZxaxbRKkptkR+1dphk5LaCGk6wug6wIF49Mo1j/lvJYhNzZISXScXMPiIUcp9uCL88El
        BudB6p5faL5jzQupmvg4TLbu6CRi19A=
Date:   Mon, 17 Jan 2022 22:55:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nicolas Pitre <nico@fluxnic.net>
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
        "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        live-patching@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v9 04/15] arch: introduce ASM function sections
Message-ID: <YeXl4hideuWxQCfu@zn.tnic>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
 <20211223002209.1092165-5-alexandr.lobakin@intel.com>
 <YeXasIO5ArXxtw1J@zn.tnic>
 <8n284257-9665-s3q1-6833-rn966p87qoqs@syhkavp.arg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8n284257-9665-s3q1-6833-rn966p87qoqs@syhkavp.arg>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 17, 2022 at 04:38:33PM -0500, Nicolas Pitre wrote:
> On Mon, 17 Jan 2022, Borislav Petkov wrote:
> 
> > Thanks for explaining this. The gas manpage is very, hm, verbose
> > <sarcarstic eyeroll> ;-\:
> 
> GNU tools tend to be far better documented in their info pages.

Good point, the corresponding text in the info page explains this option
properly.

Now I need to remember that about GNU tools.

There are a couple of redirects in that manpage to the info pages "See
the info pages for documentation of ..." but I guess they should slap
something along those lines at the end too:

SEE ALSO
       gcc(1), ld(1), and the Info entries for binutils and ld. Also, for
       more info on gas options, see the corresponding info pages.

Or so. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
