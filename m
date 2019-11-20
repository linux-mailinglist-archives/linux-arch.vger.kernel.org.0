Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CACE10401C
	for <lists+linux-arch@lfdr.de>; Wed, 20 Nov 2019 16:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfKTPy6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Nov 2019 10:54:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34396 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbfKTPy6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Nov 2019 10:54:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id j18so5460289wmk.1
        for <linux-arch@vger.kernel.org>; Wed, 20 Nov 2019 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pc/B5s8Op7DZcUpCkoozM2pKb7wkORn3PJUzQ+3VJls=;
        b=jtMhRC6Pk0HadowGTjQERXbTA9SrlkgA6uoK4GrRBBSya5IrU9FKwc5sKWuazC7hWY
         91aODgBraKSoG3+eK4B2Za6Q/SMrQiR5aWNtuyZaBsUjHqSN2Zi+JRcOllkgpeTVuzp8
         KDT853LwBilN+sUKYomYUcWf/qSSmZVkW+82quasRshDxUIO+1hR/nIVZmRvxQmr68TG
         JuuUYYKg35fGImgfsm/WZdIhy6TJt7Bd0SxC2TXYB82TjG7g7WhD7Xc4n2MJVs5c58xj
         OsGpyLKVVbGaZmacdh697dBEAEP6D0PtBat1Xcjiao3BpaFQFCZ1O7xp2tWnSqIW3UyD
         DLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pc/B5s8Op7DZcUpCkoozM2pKb7wkORn3PJUzQ+3VJls=;
        b=i1KDz7iaUuVGLbL7Xvi1sYSWZVciiBcoP6xA09uWkrXEqISRS2fIFZ7t8Xuq+OKpSl
         oJ+7CVVVG+iCIk2VPMRortUbwA16M1kKLi2ojnRQFe5ajRURt1taMzNgfwwrKAxR98sY
         6NvL2jzK2nlZfyCjw9ymMn+WFUOU7vbzPeCShYUaGWZil9tLmG8chTV0TfUnwOmAffX0
         BTQzJJJu42sOLYJL60Nb+kIcvKpy9xq1DR/Gf2LIEfQ6cPbpHZ/ADRfjlKd9xPaLokhe
         l/vjKkIV6PQqCxxocYKjtQetBVw1LS0wxGuWQw8ngxe3IgEIxI6O5N1TaMsN4tlwsaMa
         zTPg==
X-Gm-Message-State: APjAAAWyQdF9UPPC4V88uA7z4ugDXJEx2UKb9XtS3u5q52BxzLvvMH4T
        yosex4U0tDQ9QXF8/XxaobXq7w==
X-Google-Smtp-Source: APXvYqygyv2epnPyQ8ZUCWpvIvDmkk1mlhM7bZ2yAb9gUjZi3pn0UqvfOAVs0g05UGhLYqygkKm6GA==
X-Received: by 2002:a1c:38c3:: with SMTP id f186mr4147629wma.58.1574265294776;
        Wed, 20 Nov 2019 07:54:54 -0800 (PST)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id z6sm33020710wro.18.2019.11.20.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 07:54:53 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:54:48 +0100
From:   Marco Elver <elver@google.com>
To:     Qian Cai <cai@lca.pw>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v4 00/10] Add Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20191120155448.GA21320@google.com>
References: <20191114180303.66955-1-elver@google.com>
 <1574194379.9585.10.camel@lca.pw>
 <CANpmjNPynCwYc8-GKTreJ8HF81k14JAHZXLt0jQJr_d+ukL=6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPynCwYc8-GKTreJ8HF81k14JAHZXLt0jQJr_d+ukL=6A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 19 Nov 2019, Marco Elver wrote:

> On Tue, 19 Nov 2019 at 21:13, Qian Cai <cai@lca.pw> wrote:
> >
> > On Thu, 2019-11-14 at 19:02 +0100, 'Marco Elver' via kasan-dev wrote:
> > > This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
> > > KCSAN is a sampling watchpoint-based *data race detector*. More details
> > > are included in **Documentation/dev-tools/kcsan.rst**. This patch-series
> > > only enables KCSAN for x86, but we expect adding support for other
> > > architectures is relatively straightforward (we are aware of
> > > experimental ARM64 and POWER support).
> >
> > This does not allow the system to boot. Just hang forever at the end.
> >
> > https://cailca.github.io/files/dmesg.txt
> >
> > the config (dselect KASAN and select KCSAN with default options):
> >
> > https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
> 
> Thanks! That config enables lots of other debug code. I could
> reproduce the hang. It's related to CONFIG_PROVE_LOCKING etc.
> 
> The problem is definitely not the fact that kcsan_setup_watchpoint
> disables interrupts (tested by removing that code). Although lockdep
> still complains here, and looking at the code in kcsan/core.c, I just
> can't see how local_irq_restore cannot be called before returning (in
> the stacktrace you provided, there is no kcsan function), and
> interrupts should always be re-enabled. (Interrupts are only disabled
> during delay in kcsan_setup_watchpoint.)
> 
> What I also notice is that this happens when the console starts
> getting spammed with data-race reports (presumably because some extra
> debug code has lots of data races according to KCSAN).
> 
> My guess is that some of the extra debug logic enabled in that config
> is incompatible with KCSAN. However, so far I cannot tell where
> exactly the problem is. For now the work-around would be not using
> KCSAN with these extra debug options.  I will investigate more, but
> nothing obviously wrong stands out..

It seems that due to spinlock_debug.c containing data races, the console
gets spammed with reports. However, it's also possible to encounter
deadlock, e.g.  printk lock -> spinlock_debug -> KCSAN detects data race
-> kcsan_print_report() -> printk lock -> deadlock.

So the best thing is to fix the data races in spinlock_debug. I will
send a patch separately for you to test.

The issue that lockdep still reports inconsistency in IRQ flags tracing
I cannot yet say what the problem is. It seems that lockdep IRQ flags
tracing may have an issue with KCSAN for numerous reasons: let's say
lockdep and IRQ flags tracing code is instrumented, which then calls
into KCSAN, which disables/enables interrupts, but due to tracing calls
back into lockdep code. In other words, there may be some recursion
which corrupts hardirqs_enabled.

Thanks,
-- Marco
