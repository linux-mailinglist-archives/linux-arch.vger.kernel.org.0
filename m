Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF05F468369
	for <lists+linux-arch@lfdr.de>; Sat,  4 Dec 2021 09:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384358AbhLDI7N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Dec 2021 03:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354761AbhLDI7N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Dec 2021 03:59:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02908C061751;
        Sat,  4 Dec 2021 00:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vwdl1xKa4HYu9irhFaCnjVvl+U+9xbF06W/a7qens7k=; b=vfPGu83j2gIsLgLE3DxB3r9q9/
        dbtwfJyG9lDZtbNYQGVmVKocVsH2s9u0wX0ATvcJHRY2i/ueC7uoief9HZrymphH9VddBvVkWXUt1
        XnEiRvUqWKLajju+56+0EXRIX1Gn6KmdV+QivZcC5SgysDZoqTnwaTqbDjF2o/QgKisFGSbHUrrwq
        4TkW84iHfLM1ke2YdGrB5rOc8pvI+YuYx3DgIU8nYsZFAk9oDk8YMaMvwdHJeD9mKOxOhdrVOnZIf
        w5g5jFMajbIyO1Avs7hHiBcvmQ1DKcYAx1a9IuDAejtXgGNiltk3qGyvkQcbNPhgEb6YBIX/qPMmR
        /1LPU4jQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtQov-00CL1l-IB; Sat, 04 Dec 2021 08:55:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FB8998106D; Sat,  4 Dec 2021 09:55:01 +0100 (CET)
Date:   Sat, 4 Dec 2021 09:55:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20211204085500.GL16608@worktop.programming.kicks-ass.net>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
 <20211202223214.72888-6-alexandr.lobakin@intel.com>
 <Yanm6tJ2obi1aKv6@hirez.programming.kicks-ass.net>
 <20211203141051.82467-1-alexandr.lobakin@intel.com>
 <20211203163424.GK16608@worktop.programming.kicks-ass.net>
 <28856p61-r54s-791n-q6s1-27575s62r2q9@syhkavp.arg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28856p61-r54s-791n-q6s1-27575s62r2q9@syhkavp.arg>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 03, 2021 at 02:46:39PM -0500, Nicolas Pitre wrote:

> Surely this would do it:
> 
> http://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=451133cefa839104

Ooh, yes, excellent that, thanks!
