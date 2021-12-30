Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29E84820A9
	for <lists+linux-arch@lfdr.de>; Thu, 30 Dec 2021 23:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242275AbhL3WgF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Dec 2021 17:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbhL3WgE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Dec 2021 17:36:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFF3C061574;
        Thu, 30 Dec 2021 14:36:04 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F75A1EC047E;
        Thu, 30 Dec 2021 23:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640903758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+KKK4IGlu+3zrarQbibZbQT1tUBU7oUm6HKnQkbdmKE=;
        b=oPfknaqMGvn+62MYRbhhvqwCuLoSX5p58SSeK+N4oF9aZ7sLgUjP1n1DDIVFgf4UX6SjD4
        BtjJXy4Yp4keYM2xcOguHwNaMZcxUdIa08dtUo7yvrKUQnGgdp8B3NQYFmeSY4AG9kn321
        5gYDtf918vXXIlR8BZolIn+c0jp1L1w=
Date:   Thu, 30 Dec 2021 23:36:00 +0100
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
Subject: Re: [PATCH v9 03/15] kallsyms: Hide layout
Message-ID: <Yc40UKmylVh38vl5@zn.tnic>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
 <20211223002209.1092165-4-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211223002209.1092165-4-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 23, 2021 at 01:21:57AM +0100, Alexander Lobakin wrote:
> Subject: Re: [PATCH v9 03/15] kallsyms: Hide layout

That title is kinda laconic...

> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> 
> This patch makes /proc/kallsyms display in a random order, rather

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> than sorted by address in order to hide the newly randomized address
> layout.

Sorted by address?

My /proc/kallsyms says

$ awk '{ print $1 }' /proc/kallsyms | uniq -c
 119086 0000000000000000

so all the addresses are 0. Aha, and when I list them as root, only then
I see non-null addresses.

So why do we that patch at all?

> alobakin:
> Don't depend FG-KASLR and always do that for unpriviledged accesses

Unknown word [unpriviledged] in commit message, suggestions:
        ['unprivileged', 'underprivileged', 'privileged']

> as suggested by several folks.
> Also, introduce and use a shuffle_array() macro which shuffles an
> array using Fisher-Yates.

Fisher-Yates what?

/me goes and looks at the wikipedia article.

Aha, a Fisher-Yates shuffle algoithm.

Don't be afraid to explain more in your commit messages and make them
more reader-friendly.

> We'll make use of it several more times
> later on.

Not important for this commit.

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
