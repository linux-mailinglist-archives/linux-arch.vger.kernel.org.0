Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDAD102E98
	for <lists+linux-arch@lfdr.de>; Tue, 19 Nov 2019 22:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfKSVuQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Nov 2019 16:50:16 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40683 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfKSVuQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Nov 2019 16:50:16 -0500
Received: by mail-oi1-f196.google.com with SMTP id d22so13555818oic.7
        for <linux-arch@vger.kernel.org>; Tue, 19 Nov 2019 13:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nChvbzLFSqXvxVpDffdnChqvN7oTXvHT1a3fMg3wbAY=;
        b=p5Cy99Po26kE+UyzXYPLTu1Jn3nkcb7z2Dj1EBK1McLzwW3cNilJrGCEHlm8RZAgIS
         Q++XQ2aBBj4oOMNEb5s177mWJkSbr9Vy4IIsqRRv8IwBTtKpz3Nt0C70i0glZXPUvG+z
         rv1x/lHc+4710wRxMyk+oQwG7IkB3SgXFSLlsRRrBmHAiDvPOeAVjtEd3OmCU2lGJ2o8
         R08NgLmpYCP/70TiDo56BRXT+iUajfnpx379m4+CfWQrUmlTqmBumsRfIG++OudoUflv
         gX9Kiy+Bh3aWDiXEWOCgiWlk8gm8AVNbuxGaVEaipbqus6uld3JoQG+60MvpcEapaLJY
         tH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nChvbzLFSqXvxVpDffdnChqvN7oTXvHT1a3fMg3wbAY=;
        b=KTbaGfB9hYgGlgXEw0/vuO0lNZDXg3EPPqB7HMVD9+6TCXuAAzRpQH8eMUvNTsO00g
         LhVlxXUnYDHKGqbasmKoAXU4iwaLdH2Qe97nzhNS5YkCihUyv/WDutlxC305HCTDoeuG
         a+tTBqU/PrZh6NHfjyKSgrTQ4ipLOM7FfZvEwsRnfyQeXrX2YZkcA6a2JB8aIVy1EpxI
         kjM5rU+TsQvr6bZiSbbCsp43yeTKeCNWwClwdsBe6B3yoD7cqPrCmXXRc0P3Xor+dsVQ
         SQDSUBDGTO9JY2uWnax+qdoqVE+7annH78D9W47xanj4gLuUCEv79irqaZqXz59mUAtX
         n5nQ==
X-Gm-Message-State: APjAAAWN6vDjgT1/ijXvNIVDciJqBfHh8FmabuY6JdxA5APMkOSJ9+yv
        WyOUkpRU0rk+e4RdArKDQsFQ0O1H50ce1ufx1+F8FQ==
X-Google-Smtp-Source: APXvYqwk7GX5f9KXrTBkfomV60IUjlNkqZSImNATN/Y3wyZZrnUV7+wiHWBIn6Og9vj7j9q/YXr8jWBfKyRzDXW3y+k=
X-Received: by 2002:aca:5413:: with SMTP id i19mr6343058oib.121.1574200214595;
 Tue, 19 Nov 2019 13:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20191114180303.66955-1-elver@google.com> <1574194379.9585.10.camel@lca.pw>
In-Reply-To: <1574194379.9585.10.camel@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 19 Nov 2019 22:50:02 +0100
Message-ID: <CANpmjNPynCwYc8-GKTreJ8HF81k14JAHZXLt0jQJr_d+ukL=6A@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Add Kernel Concurrency Sanitizer (KCSAN)
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
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 19 Nov 2019 at 21:13, Qian Cai <cai@lca.pw> wrote:
>
> On Thu, 2019-11-14 at 19:02 +0100, 'Marco Elver' via kasan-dev wrote:
> > This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
> > KCSAN is a sampling watchpoint-based *data race detector*. More details
> > are included in **Documentation/dev-tools/kcsan.rst**. This patch-series
> > only enables KCSAN for x86, but we expect adding support for other
> > architectures is relatively straightforward (we are aware of
> > experimental ARM64 and POWER support).
>
> This does not allow the system to boot. Just hang forever at the end.
>
> https://cailca.github.io/files/dmesg.txt
>
> the config (dselect KASAN and select KCSAN with default options):
>
> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

Thanks! That config enables lots of other debug code. I could
reproduce the hang. It's related to CONFIG_PROVE_LOCKING etc.

The problem is definitely not the fact that kcsan_setup_watchpoint
disables interrupts (tested by removing that code). Although lockdep
still complains here, and looking at the code in kcsan/core.c, I just
can't see how local_irq_restore cannot be called before returning (in
the stacktrace you provided, there is no kcsan function), and
interrupts should always be re-enabled. (Interrupts are only disabled
during delay in kcsan_setup_watchpoint.)

What I also notice is that this happens when the console starts
getting spammed with data-race reports (presumably because some extra
debug code has lots of data races according to KCSAN).

My guess is that some of the extra debug logic enabled in that config
is incompatible with KCSAN. However, so far I cannot tell where
exactly the problem is. For now the work-around would be not using
KCSAN with these extra debug options.  I will investigate more, but
nothing obviously wrong stands out..

Many thanks,
-- Marco
