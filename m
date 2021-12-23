Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633AD47E5D7
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 16:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349348AbhLWPnK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Dec 2021 10:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349212AbhLWPlx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Dec 2021 10:41:53 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EC1C061394;
        Thu, 23 Dec 2021 07:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/tyAvhoyg1hQEH2SYEuGFD0l8CiSoOd6tqxbhV2JRnI=; b=NNjVio1DVMhWyDn6xUSgP1zglG
        O0tafy2qc3LdNtt2vLhXe2B37ILp2eEVlum7DfDn2MdHLawS9OrfX/hPtEVtLOY1XnI3zRemoNgEw
        iI/vMYlqImaqdaYTLQ3xDM/q3Hb/CIz8NfD8azxF72VmmF9HnCiMEnwjIWDa0zgYLEwAx/RkjoA/v
        B4jqEA73t7b3c2xz/uOY6Wm5fxnsCjLe/NqVXxLzB7JM3iNhdexvJGa5bQGTTtiZsTE4JE0TVoyYV
        BVEtz7jYhobveE92sgyPApjjdjbxIm+j0bBAs9qnf5iA2EHVzTWaZf7Sbhzyy/eKhI9/DXD0A7pdj
        p+sINhPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0QCs-0038Ey-VT; Thu, 23 Dec 2021 15:40:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 812A5300347;
        Thu, 23 Dec 2021 16:40:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54C0E20CF2F9E; Thu, 23 Dec 2021 16:40:36 +0100 (CET)
Date:   Thu, 23 Dec 2021 16:40:36 +0100
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
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        Andy Lavr <andy.lavr@gmail.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        live-patching@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v9 00/15] Function Granular KASLR
Message-ID: <YcSYdJowLyutM/7m@hirez.programming.kicks-ass.net>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
 <20211223151504.1409203-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223151504.1409203-1-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 23, 2021 at 04:15:04PM +0100, Alexander Lobakin wrote:
> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Thu, 23 Dec 2021 01:21:54 +0100
> 
> > This is a massive rework and a respin of Kristen Accardi's marvellous
> > FG-KASLR series (v5).
> 
> [ snip ]
> 
> > The series is also available here: [3]
> 
> As per request, I've published a version rebased ontop of
> linux-next-20211223 here: [4].
> 
> During the rebasing, I saw that some ASM code conflicts with, I
> guess, Peter's "execute past ret" mitigation.
> So I would also like to ask you to give me a branch which I should
> pick to base my series on top of. There's a bunch of different x86
> branches, like several in peterz-queue, x86/core etc., so I got lost
> a little.
> The one posted yesterday was based on the mainline 5.16-rc6.

For anything tip related, tip/master isn't a bad target. I did two asm
related x86 series, both are in tip/x86/core I think (/me checks, yep).

Never base anything of my queue.git, that's all throw-away/staging
stuff. Either it lives and goes on into tip or not :-)
