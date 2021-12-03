Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B34467484
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 11:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379762AbhLCKJk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 05:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351346AbhLCKJk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 05:09:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F849C06173E;
        Fri,  3 Dec 2021 02:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a/ys6cskAlNWsULashfoqrEixGaH4KiNUxE+1OiguW0=; b=J0VIv2PGI2YMODNat75+3pt+oG
        /murTVznnyShQpHUdjfI7fVlowa5qhKNmHF1NCj283L/0bVE9Nd1trwDldCbTlwcaznPlMfdIKTSe
        8sHNMAMEhlMLgA4Q0kgaEbFp5exVv813ND6187LX9qdsSu/YIq93W7lExi80GQ/Lf9uyjWLusP1lS
        zwrATFYnDJRV7SN9B+EES34aX7F3M41Mnqm5Z+DkcpdAZJxEJw9N72oAZRzqt7DwneDuKoiPtbrFG
        LQbccx5+9SZgqeSkh891Jn9Ekcwwcb/2ImzdLtwGsGdUy4E3wjQCwnHTMbhszn42EiXpV3tPMyQ8g
        b7Mc3oIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mt5Rz-00884w-4M; Fri, 03 Dec 2021 10:05:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF99230001C;
        Fri,  3 Dec 2021 11:05:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 98C2B2B36B3B2; Fri,  3 Dec 2021 11:05:54 +0100 (CET)
Date:   Fri, 3 Dec 2021 11:05:54 +0100
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
        llvm@lists.linux.dev
Subject: Re: [PATCH v8 08/14] livepatch: only match unique symbols when using
 FG-KASLR
Message-ID: <YansAlTr0/MfNxWc@hirez.programming.kicks-ass.net>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
 <20211202223214.72888-9-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202223214.72888-9-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 02, 2021 at 11:32:08PM +0100, Alexander Lobakin wrote:
> If any type of function granular randomization is enabled, the sympos
> algorithm will fail, as it will be impossible to resolve symbols when
> there are duplicates using the previous symbol position.
> 
> We could override sympos to 0, but make it more clear to the user
> and bail out if the symbol is not unique.

Since we're going lots of horrendous things already, why can't we fix
this duplicate nonsense too?
