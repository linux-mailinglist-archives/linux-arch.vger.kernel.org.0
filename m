Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44613467536
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 11:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243937AbhLCKmQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 05:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243912AbhLCKmQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 05:42:16 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4889BC06173E;
        Fri,  3 Dec 2021 02:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vD4L77VHgLvDmRbeZaWlspxy3NbaUIb+bwMSWEqT/lw=; b=FtTFaIjd/WBYIJvTtPhJo44DrX
        RcYmE57KZwuXeuzlu7Kdkx2xflj3o+rzM3kF4sQiGjDpUKtXbp7oudu7R/EH2Tab5GanjeJdbw6eO
        GnMUQglTXZrpXUb6PqxBeqjkNPpoUjPaKxwwvHhh1HWok+iaQlCwNA2nh/Ji9od2jPr7IDgTI6h+s
        6wTTjnPgmcndc9NEzp4lrwziWOrrhbEYll78jJR7rNpVmVFBYNExHxA7qa4w7SzUbdB53/tRQAKZg
        lxNb/IKuJhLaZerPAOzxQBjzD64fZAp4KO4F2mRmatNFp0P5CS0fr1r14sr5agu+oxu7/6EI349BO
        UH2M68Pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mt5xX-001yqZ-HY; Fri, 03 Dec 2021 10:38:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4DD530001C;
        Fri,  3 Dec 2021 11:38:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8976D2B36B3C0; Fri,  3 Dec 2021 11:38:30 +0100 (CET)
Date:   Fri, 3 Dec 2021 11:38:30 +0100
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
Subject: Re: [PATCH v8 00/14] Function Granular KASLR
Message-ID: <YanzpvmaX1JWYf9t@hirez.programming.kicks-ass.net>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202223214.72888-1-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 02, 2021 at 11:32:00PM +0100, Alexander Lobakin wrote:

> feat        make -j65 boot    vmlinux.o vmlinux  bzImage  bogoops/s
> Relocatable 4m38.478s 24.440s 72014208  58579520  9396192 57640.39
> KASLR       4m39.344s 24.204s 72020624  87805776  9740352 57393.80
> FG-K 16 fps 6m16.493s 25.429s 83759856  87194160 10885632 57784.76
> FG-K 8 fps  6m20.190s 25.094s 83759856  88741328 10985248 56625.84
> FG-K 1 fps  7m09.611s 25.922s 83759856  95681128 11352192 56953.99

:sadface: so at best it makes my kernel compiles ~50% slower. Who would
ever consider doing that? It's like retpolines weren't bad enough; lets
heap on the fail?
