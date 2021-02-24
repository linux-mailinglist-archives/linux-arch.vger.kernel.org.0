Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542E73246DE
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 23:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbhBXWaU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 17:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbhBXWaO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Feb 2021 17:30:14 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8B3C06174A;
        Wed, 24 Feb 2021 14:29:34 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id s107so3790777otb.8;
        Wed, 24 Feb 2021 14:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u6XAvXUVnlDMggAEsXaHM4e8hEC4mF5s4JegHeSo1z4=;
        b=WXKmbDE438sr38D2CmGIsGEX4Geb9dTZqskZrMVRyU2zsH8cwKx74cPRXuOgXmiR8d
         8PGR0VhKEGeP/oyqgHyMTEWKqGvNumu5SrC6Fw81zm3356flV7AhLkrrSHLiR42VWsYQ
         SFf5x3AO6UodLZ+mOW0mT+fny5pAh3ixBP1ZAcRvq83wf64eqkR5BbVrSKcE6pUnVn1V
         zWJh+SRYExHV/t73tRL0SEr5xz9J7gykl8C+7fRWqXCYT4b1AUZ5UB61zE20WkowXWAb
         NY4DQOAnMKOMZdrrWgFgx5z7qMCuYi52PYv9ODoKdzsmDg8tgMDDSB6zqQ2B2bh7Dlnb
         G1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=u6XAvXUVnlDMggAEsXaHM4e8hEC4mF5s4JegHeSo1z4=;
        b=HEpPG9z680TX0ADY7RxknQpCHQezuxzKWhBKlPcHhl1zK2wDw3ACuva16jojXjvD6q
         cy+R7b5jMi03f8tHyhg/qzRBD0Mxcc6jsqGu9HGZPXbHJVTKqeKXIm1HzmDP6Bg0XJx3
         vndnxRqTDL/bTOeUs08Vcb0x+PnRGiIH8LU5ZhK3qNHzeFUyH5gbPRLbRJHruG0oZEDG
         lBlg4xnej65eRPhJOPAM7LGAvDwtplbrPxe3He/Rya3HYLP/VkrbrvoLDBkY1Nt0ytL8
         0ojTpo5zAJZ1u1YhQhrh56Ea71Vtv+4UfmEoyGsyXQWiKGVv9YQP54xfRYY6+TQLcAeF
         Ek/w==
X-Gm-Message-State: AOAM531B3UJUDJKMb3u5ObgLEZ6fmJLq1rR0YqZYxF9vi+db1fLF9qQ4
        O2H3RpkSNgXQ5fI/Dze2Nnk=
X-Google-Smtp-Source: ABdhPJy2cu+9ylE3pPDrNFQsj91Ax/vfHdFQuwgZeHJv5TM9WPR2gNSYiHYnpOkegPtmu+HWGG5leg==
X-Received: by 2002:a05:6830:4c9:: with SMTP id s9mr14765343otd.133.1614205773544;
        Wed, 24 Feb 2021 14:29:33 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d13sm665063otf.52.2021.02.24.14.29.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Feb 2021 14:29:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 24 Feb 2021 14:29:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, linux-parisc@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v9 01/16] tracing: move function tracer options to
 Kconfig (causing parisc build failures)
Message-ID: <20210224222931.GB74404@roeck-us.net>
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <20201211184633.3213045-2-samitolvanen@google.com>
 <20210224201723.GA69309@roeck-us.net>
 <202102241238.93BC4DCF@keescook>
 <CABCJKufph4se58eiJNSJUd3ASBgbJGmL2e3wg4Jwo4Bi2UxP=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKufph4se58eiJNSJUd3ASBgbJGmL2e3wg4Jwo4Bi2UxP=Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 24, 2021 at 12:54:15PM -0800, Sami Tolvanen wrote:
> On Wed, Feb 24, 2021 at 12:38 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Feb 24, 2021 at 12:17:23PM -0800, Guenter Roeck wrote:
> > > On Fri, Dec 11, 2020 at 10:46:18AM -0800, Sami Tolvanen wrote:
> > > > Move function tracer options to Kconfig to make it easier to add
> > > > new methods for generating __mcount_loc, and to make the options
> > > > available also when building kernel modules.
> > > >
> > > > Note that FTRACE_MCOUNT_USE_* options are updated on rebuild and
> > > > therefore, work even if the .config was generated in a different
> > > > environment.
> > > >
> > > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > >
> > > With this patch in place, parisc:allmodconfig no longer builds.
> > >
> > > Error log:
> > > Arch parisc is not supported with CONFIG_FTRACE_MCOUNT_RECORD at scripts/recordmcount.pl line 405.
> > > make[2]: *** [scripts/mod/empty.o] Error 2
> > >
> > > Due to this problem, CONFIG_FTRACE_MCOUNT_RECORD can no longer be
> > > enabled in parisc builds. Since that is auto-selected by DYNAMIC_FTRACE,
> > > DYNAMIC_FTRACE can no longer be enabled, and with it everything that
> > > depends on it.
> >
> > Ew. Any idea why this didn't show up while it was in linux-next?
> 
> Does anyone build parisc allmodconfig from -next?
> 

https://kerneltests.org/builders/next-parisc-next

Guenter

> parisc seems to always use -fpatchable-function-entry with dynamic
> ftrace, so we just need to select
> FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to stop it from defaulting
> to recordmcount:
> 
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index ecef9aff9d72..9ee806f68123 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -60,6 +60,7 @@ config PARISC
>         select HAVE_KPROBES
>         select HAVE_KRETPROBES
>         select HAVE_DYNAMIC_FTRACE if
> $(cc-option,-fpatchable-function-entry=1,1)
> +       select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if HAVE_DYNAMIC_FTRACE
>         select HAVE_FTRACE_MCOUNT_RECORD if HAVE_DYNAMIC_FTRACE
>         select HAVE_KPROBES_ON_FTRACE
>         select HAVE_DYNAMIC_FTRACE_WITH_REGS
> 
> I'll send a proper patch shortly.
> 
> Sami
