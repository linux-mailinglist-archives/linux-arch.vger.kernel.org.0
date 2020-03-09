Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F1217ECFA
	for <lists+linux-arch@lfdr.de>; Tue, 10 Mar 2020 00:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgCIX7w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 19:59:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33065 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgCIX7v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 19:59:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so9729358wrd.0
        for <linux-arch@vger.kernel.org>; Mon, 09 Mar 2020 16:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PcIMvT9Ges60/RCEcv9P9n3V3wEXCUl81zN9+mizqE=;
        b=bbtke5oP3UVppLVojB1atGqhDMEwwoZMv55eTr8ZnNZrgn0YDHohNAJDV+eqnhKipa
         4aN9G0lOac5v18XPEriKg/5/D/0L6WNLOtgk+WPAkKIYHDuW4f7I6O8D05xQO9vTC/CI
         gvOE7yjLpbAqy2xs5nRCImHAI6w7kO6KCMC/FuGLSpEa/Cn8g0BDVHDycc6ierC/ThYB
         AZO4cFtCs7Q4J2LJBF7s+XfM3ycj5kw+gP7SQ2AYP7yKhuTikOByPG5P52PIBB6xvitH
         8x8bbkXarJqpP2ySfHwYKIFOqsbvw5VjToymh99dZ/T1/NHd5AjR6yR4BXjfAUqy2tR0
         52gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PcIMvT9Ges60/RCEcv9P9n3V3wEXCUl81zN9+mizqE=;
        b=X9zkqRJdsoYsqgZ7+FHbzsCWfuIKZByl9NVtzWpKtz/VvzMWK6+AciF9ZCpzYWlC7D
         k9tvviVo/rsjoE1frbFPWiJhcrXjCI/6twfL7bDGMxPeCjjFqCo5JIl2C1ZlyJkfWRlj
         sPfQ8sjzb7w7OEFiPZIxYV4ZOzkG1bIH13/G2VFaqMICKjF6iZWZB1e2ehSM0Yyi2Fd7
         F251+Kf5tSRDFXmZBAvuyx1TrMGlIOGzNUyLIcIZL7rBKNQEKr6o+OHvktXZyi7q2jSz
         dbXvxD3Jt02lqbNCSdlsOXNbzRFeciWujNtMNqswtZeevV3DCTmSk+3mTzjQrGx5UQCe
         gizg==
X-Gm-Message-State: ANhLgQ3/FsFoP0kjG6cAGWL9i4IhzRG5qxViD47aKaUpmoaaBxX5K0Wu
        DY+bNHTw9JT3MLekDe4LlpzdFWwcTRPSbMDHqkwmJg==
X-Google-Smtp-Source: ADFU+vt2iiohYPhJ2F/0p/lc9pYIMGQoNqww6lZPdFqjkGInjDqr9voSFlL20LHhzIQclFgUMk+afkKjVc/hC1ajvTA=
X-Received: by 2002:adf:b641:: with SMTP id i1mr23638629wre.18.1583798389063;
 Mon, 09 Mar 2020 16:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
 <AE81FEF5-ECC5-46AA-804D-9D64E656D16E@amacapital.net> <CAMe9rOoDMenvD9XRL1szR5yLQEwv9Q6f4O7CtwbdZ-cJqzezKA@mail.gmail.com>
 <0088001c-0b12-a7dc-ff2a-9d5c282fa36b@intel.com> <CAMe9rOqf0OHL9397Vikgb=UWhRMf+FmGq-9VAJNmfmzNMMDkCw@mail.gmail.com>
 <56ab33ac-865b-b37e-75f2-a489424566c3@intel.com> <CAMe9rOrzrXORQgcAwzGn+=PBvxCEgc5Km_TQq+P7uoqwiacJSA@mail.gmail.com>
 <c06073a2-6858-d5dc-d74b-ef2568bd9423@intel.com> <CAMe9rOrxM=RefftngNXhP906mrW1SMy7vp+O=yOj_WwcdQpGcg@mail.gmail.com>
In-Reply-To: <CAMe9rOrxM=RefftngNXhP906mrW1SMy7vp+O=yOj_WwcdQpGcg@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 9 Mar 2020 16:59:37 -0700
Message-ID: <CALCETrWF1NQeGXy0GXRwW71Bc3oSN=vsXMsBqnaqs7Us7RYebQ@mail.gmail.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 9, 2020 at 4:52 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Mon, Mar 9, 2020 at 4:21 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 3/9/20 4:11 PM, H.J. Lu wrote:
> > > A threaded application is loaded from disk.  The object file on disk is
> > > either CET enabled or not CET enabled.
> >
> > Huh.  Are you saying that all instructions executed on userspace on
> > Linux come off of object files on the disk?  That's an interesting
> > assertion.  You might want to go take a look at the processes on your
> > systems.  Here's my browser for example:
> >
> > # for p in $(ps aux | grep chromium | awk '{print $2}' ); do cat
> > /proc/$p/maps; done | grep ' r-xp 00000000 00:00 0'
> > ...
> > 202f00082000-202f000bf000 r-xp 00000000 00:00 0
> > 202f000c2000-202f000c3000 r-xp 00000000 00:00 0
> > 202f00102000-202f00103000 r-xp 00000000 00:00 0
> > 202f00142000-202f00143000 r-xp 00000000 00:00 0
> > 202f00182000-202f001bf000 r-xp 00000000 00:00 0
> >
> > Lots of funny looking memory areas which are anonymous and executable!
> > Those didn't come off the disk.  Same thing in firefox.  Weird.  Any
> > idea what those are?
> >
> > One guess: https://en.wikipedia.org/wiki/Just-in-time_compilation
>
> jitted code belongs to a process loaded from disk.  Enable CET in
> an application which uses JIT engine means to also enable CET in
> JIT engine.  Take git as an example, "git grep" crashed for me on Tiger
> Lake.   It turned out that git itself was compiled with -fcf-protection and
> git was linked against libpcre2-8.so.0 also compiled with -fcf-protection,
> which has a JIT, sljit, which was not CET enabled.  git crashed in the
> jitted codes due to missing ENDBR.  I had to enable CET in sljit to make
> git working on CET enabled Tiger Lake.  So we need to enable CET in
> JIT engine before enabling CET in applications which use JIT engine.

This could presumably have been fixed by having libpcre or sljit
disable IBT before calling into JIT code or by running the JIT code in
another thread.  In the other direction, a non-CET libpcre build could
build IBT-capable JITted code and enable JIT (by syscall if we allow
that or by creating a thread?) when calling it.  And IBT has this
fancy legacy bitmap to allow non-instrumented code to run with IBT on,
although SHSTK doesn't have hardware support for a similar feature.

So, sure, the glibc-linked ELF ecosystem needs some degree of CET
coordination, but it is absolutely not the case that a process MUST
have all CET or no CET.  Let's please support the complicated cases in
the kernel and the ABI too.  If glibc wants to make it annoying to do
complicated things, so be it.  People work behind glibc's back all the
time.

--Andy
