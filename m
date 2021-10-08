Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E464268AB
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 13:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbhJHL2d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 07:28:33 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:42557 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhJHL2b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Oct 2021 07:28:31 -0400
Received: by mail-ua1-f50.google.com with SMTP id c33so6483503uae.9;
        Fri, 08 Oct 2021 04:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PjIYnfhy9JPfwuH1borR6uzGu121ZxVTnsPHIR1D60=;
        b=0VCoAG3iBRkON5TbAPG2geJUxQ6xJsJ+mT64KWyBxV9Y+k71/hYDE+cy6JqK/UmL90
         Hi2n+iI3pqaTPx0kP5Jxyg5mNdyBSO69c4qYD1wDrX38RKcrMtH8LI8oGUtQyw+YPsFN
         ZGIgGMujFmlyQDvneRs4Is0GABZUfPtfFiXkOPsh/fE27u3OWRCF3OJHXWjpCJ6ItCIE
         zxMHrvXzuJDZMeR26UAvbGjVAJ5GJuYK0DEm6tqb5HPywApXSo3zzuMoT/DaBZGbqfF0
         c2r8C335h2TH1I9QN9fK9ob5mYJr+n3SKWi1L9NWYIwaIJodB1SB2wmjiLMVX30ZxcNx
         EGig==
X-Gm-Message-State: AOAM530EhvxMg1UpOGmZiEPCI0/Et1Y+tj27dPDyCqkYke+qilwtcJM3
        5/C3GGYOLP/x73n24JnxoCV6cf6Vmd68xaPzK5k=
X-Google-Smtp-Source: ABdhPJyteRFr5h/MW+daRXU5YNDBMWkgDET9u4GPaMKgL5YkWc1aPkv1aZJdPd3DoNASP2tz/NiY7+7luWZgA8L+pQk=
X-Received: by 2002:ab0:58c1:: with SMTP id r1mr1876640uac.89.1633692395608;
 Fri, 08 Oct 2021 04:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211008111527.438276127@infradead.org> <20211008111626.332092234@infradead.org>
In-Reply-To: <20211008111626.332092234@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Oct 2021 13:26:24 +0200
Message-ID: <CAMuHMdUzQXPtfYDzytFeXNig7dQo+16+wRqud1AeF8GoLJMgNA@mail.gmail.com>
Subject: Re: [PATCH 5/7] sched: Add wrapper for get_wchan() to keep task blocked
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        vcaputo@pengaru.com, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        amistry@google.com, Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, Michal Hocko <mhocko@suse.com>,
        Helge Deller <deller@gmx.de>, zhengqi.arch@bytedance.com,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>, metze@samba.org,
        laijs@linux.alibaba.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-hardening@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Jonas Bonn <jonas@southpole.se>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 8, 2021 at 1:20 PM Peter Zijlstra <peterz@infradead.org> wrote:
> From: Kees Cook <keescook@chromium.org>
>
> Having a stable wchan means the process must be blocked and for it to
> stay that way while performing stack unwinding.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

>  arch/m68k/include/asm/processor.h       |    2 +-
>  arch/m68k/kernel/process.c              |    4 +---

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
