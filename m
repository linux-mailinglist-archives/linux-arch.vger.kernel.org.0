Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0460D46747B
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 11:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379467AbhLCKHM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 05:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350895AbhLCKHM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 05:07:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762CBC06173E;
        Fri,  3 Dec 2021 02:03:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2685629F4;
        Fri,  3 Dec 2021 10:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634E2C5831C;
        Fri,  3 Dec 2021 10:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638525827;
        bh=HcsQFI/ghrlsmuk/HhzFJHGCOxuy3yHFeobr2h17U9s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IU5qXULyvMhg+VH4MemWiUQcN/UbSB/494YFo1EmGcJi5VmeeC4phaBSxcAuTQ9xm
         GzoZWX2pDdRYv5Ch1OzTgdbIwB7Z8ZJBG4DVQcFSQwvdwQarIynF8xY8spbo1m+t85
         dZXkePHw9BRbabIAmhC2rp9rzoz1vHQE78+Gd5yFscnR5wuoSoAAI9REg3MRkNxqsS
         nTh3q+dJQ3mubqu+yPtUT0MiEhKmVcS/Owr6vNIpXglHfEKFaC0t4cdZKmADFQtSiq
         okEMoWcekcimXP3J1Z56FDqKGSBQn/7XFSTgVNKH4fk4QIqGfpolYb+29ZZpaptSmP
         SPTS7fMcsBzjA==
Received: by mail-ot1-f47.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso2543219otj.1;
        Fri, 03 Dec 2021 02:03:47 -0800 (PST)
X-Gm-Message-State: AOAM533pjaTCcqKqCMT/dYZbX0cic9Q2t2/kSdQc3C9uXkZdM3iL3cNG
        RcKXoFpJJNkxrREnfEB6PQVhUIxxy0Be1SfkciU=
X-Google-Smtp-Source: ABdhPJxR9VEqm0AT4UQPc+72aVvXsObFDjS9txhyoFYIN9Rbgb5Ua9D/d7h3dSeJFtgJ9r+Pt7HZC+DraWfxddQ0EHk=
X-Received: by 2002:a05:6830:1445:: with SMTP id w5mr15871334otp.112.1638525826380;
 Fri, 03 Dec 2021 02:03:46 -0800 (PST)
MIME-Version: 1.0
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
 <20211202223214.72888-8-alexandr.lobakin@intel.com> <Yanqz7o4IH5MkDp8@hirez.programming.kicks-ass.net>
In-Reply-To: <Yanqz7o4IH5MkDp8@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 3 Dec 2021 11:03:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFLJcfUqEoz0NAb49=XJG=5LAwEPSwCQ-y7sN31C1U6AQ@mail.gmail.com>
Message-ID: <CAMj1kXFLJcfUqEoz0NAb49=XJG=5LAwEPSwCQ-y7sN31C1U6AQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/14] kallsyms: Hide layout
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, X86 ML <x86@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        live-patching@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 3 Dec 2021 at 11:01, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Dec 02, 2021 at 11:32:07PM +0100, Alexander Lobakin wrote:
> > From: Kristen Carlson Accardi <kristen@linux.intel.com>
> >
> > This patch makes /proc/kallsyms display in a random order, rather
> > than sorted by address in order to hide the newly randomized address
> > layout.
>
> Is there a reason to not always do this? That is, why are we keeping two
> copies of this code around? Less code is more better etc..

+1.

IIRC I made the exact same point when this patch was sent out by
Kristen a while ago.
