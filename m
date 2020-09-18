Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A822707D4
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 23:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIRVIn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 17:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIRVIm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 17:08:42 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90297C0613CE;
        Fri, 18 Sep 2020 14:08:42 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x2so7722867ilm.0;
        Fri, 18 Sep 2020 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+JRBudUXUwvhqWVD0MYK11LyJ0UI5c0AJ1zYb0I180=;
        b=COcuUjQKCDlxz7P+q4njzvsBKQTbn10AHmBYf8JO+acP1tpubCco3zjeXuqVPZwPJh
         HVv6c4k+SRu1ZGz5olK0H/NuLJoEmr8aupTuMU2dEgwGZkUzBg/PnM4dLRpyzLF3vOFw
         F/UXet7zP/niFPvLImNwwbYsTXI4Qt8tRV37wR5IFmq5bIjuW1po8xRNKoz2zLTLdTSw
         k2QGytd4NWpYwi9O/IGV3sU0LkYz/J6Oo1ZKJ8GGLQz7yQ4Tw2v/prTxK4ulQQL/RM+e
         Cg+zpkArA+WJ+1D2KOOb4f2XDlQK+ZZaOJmmgqY77d/utgEM9990u1DP3PIcX7wVT0Rc
         At2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+JRBudUXUwvhqWVD0MYK11LyJ0UI5c0AJ1zYb0I180=;
        b=DrrRHFQrxMJaCFESPnusN8vDDHExzrtN4+GL4XYI7RNWntJPXqIN2mR4Arfq9NIHYw
         uzdp0j7l1EAcHOZsrxEdf/mKdYLgS0XR2f+3RXWTE7yjJYy0ogjLS64JBBMZ/QZdDQvL
         BjH29Ax7KKQq3CiANB9D7kblTo0B+c9i6Qoqz4IqMzHxxXZ8b6IO8wensa4DFnH/DjJ6
         J9ZIX10XPhI3Xnpe51z2i5vKqtMXH545TobofOh+4XhV4Ra9EQiHT5pUx+L2GDd+jgj1
         dBBuv7DL5IAyyXB4mqspWxjVQY7gmeYngb3rdlKDXbaAHv1FUyHvoCMl73kiyWC+JeVy
         nqlQ==
X-Gm-Message-State: AOAM5319jFXtTgJlkAzz8hEWhaloCipXuX9tIVbm9HveDWc8FelF6iFE
        uzHP6pY7m2q6cd3nXeyLSFqZPsOo3qNAvb0Eulw=
X-Google-Smtp-Source: ABdhPJxZEQXrubgajxh6S5Fs6RVJhmLJ7t/k8ApKr0k10nzDecVw17zd5aRBfJHb+XbqUoMEG9knzYtSnzOXtRQvBu4=
X-Received: by 2002:a92:6a09:: with SMTP id f9mr31765508ilc.273.1600463321963;
 Fri, 18 Sep 2020 14:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200918192312.25978-1-yu-cheng.yu@intel.com> <20200918192312.25978-2-yu-cheng.yu@intel.com>
 <ce2524cc-081b-aec9-177a-11c7431cb20d@infradead.org> <20200918205933.GB4304@duo.ucw.cz>
In-Reply-To: <20200918205933.GB4304@duo.ucw.cz>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 18 Sep 2020 14:08:06 -0700
Message-ID: <CAMe9rOo0+SBPtN7yb8_-h0dRAoOXkad8wi9d-EiWAfgFSedXjQ@mail.gmail.com>
Subject: Re: [PATCH v12 1/8] x86/cet/ibt: Add Kconfig option for user-mode
 Indirect Branch Tracking
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
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
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 1:59 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2020-09-18 13:24:13, Randy Dunlap wrote:
> > Hi,
> >
> > If you do another version of this:
> >
> > On 9/18/20 12:23 PM, Yu-cheng Yu wrote:
> > > Introduce Kconfig option X86_INTEL_BRANCH_TRACKING_USER.
> > >
> > > Indirect Branch Tracking (IBT) provides protection against CALL-/JMP-
> > > oriented programming attacks.  It is active when the kernel has this
> > > feature enabled, and the processor and the application support it.
> > > When this feature is enabled, legacy non-IBT applications continue to
> > > work, but without IBT protection.
> > >
> > > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > > ---
> > > v10:
> > > - Change build-time CET check to config depends on.
> > >
> > >  arch/x86/Kconfig | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index 6b6dad011763..b047e0a8d1c2 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -1963,6 +1963,22 @@ config X86_INTEL_SHADOW_STACK_USER
> > >
> > >       If unsure, say y.
> > >
> > > +config X86_INTEL_BRANCH_TRACKING_USER
> > > +   prompt "Intel Indirect Branch Tracking for user-mode"
> > > +   def_bool n
> > > +   depends on CPU_SUP_INTEL && X86_64
> > > +   depends on $(cc-option,-fcf-protection)
> > > +   select X86_INTEL_CET
> > > +   help
> > > +     Indirect Branch Tracking (IBT) provides protection against
> > > +     CALL-/JMP-oriented programming attacks.  It is active when
> > > +     the kernel has this feature enabled, and the processor and
> > > +     the application support it.  When this feature is enabled,
> > > +     legacy non-IBT applications continue to work, but without
> > > +     IBT protection.
> > > +
> > > +     If unsure, say y
> >
> >         If unsure, say y.
>
> Actually, it would be "If unsure, say Y.", to be consistent with the
> rest of the Kconfig.
>
> But I wonder if Yes by default is good idea. Only very new CPUs will
> support this, right? Are they even available at the market? Should the
> help text say "if your CPU is Whatever Lake or newer, ...." :-) ?
>

CET enabled kernel runs on all x86-64 processors.  All my machines
are running the same CET enabled kernel binary.

-- 
H.J.
