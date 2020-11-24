Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6ED82C3019
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 19:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390911AbgKXSmV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 13:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390935AbgKXSmU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Nov 2020 13:42:20 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6885C0617A6
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2020 10:42:14 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f18so5247585ljg.9
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2020 10:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bYxDHbnmMeqeAaCeZZRsCP/3hYPYLY12AMSLIFZUIg=;
        b=VKlK3+QLeMWZ1q3zj34Obxbm2JFZ/yNE7EaUqGdyv8+Yu+bCV6Z/PFlAyqKMwkXK8U
         J79+sAAVRwvpqkxh6lly891xvx0PSQoJ3eyq6/0uoZzOzDmuUZJ+PH/ysn/byJDernYi
         /19Lq2qs6y22Py0nYJKyE9aw1W+qCTJBHiEJg5u11ljE6vVgJguOFDp6PRiZh8KuInWw
         4OuUW90DHsKAEaiErfNGx9NGVhLLVB0yyPWFWbHSLwxpqSFuDe41XpqzvdozjnQaL4Cc
         RckVQWC58sV9mGG1MuHm4eHGG+YEhHqWH/5Uq1ZYweG2RSE+icNSDdwDCqgl1fwINGDn
         sKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bYxDHbnmMeqeAaCeZZRsCP/3hYPYLY12AMSLIFZUIg=;
        b=ASxJPNo6Xf5fwTxYYZWOx2Z6BHeavUhwYyewvzWJjru8OO0zCDEJMHHDa7CBfUhg+y
         mJwDQRvrtX8Ipe1KHSu21X88Ag2zrrfR7xb7uZDIqfjRgJ4NrHMIO0y9m4QSzCE4gNOU
         4GcPEyre43nNw3sEW1Lw1oAIhKicOWUV1kC5IcAcMd+Ob8SUAPaM6DpfWOAM6APlfZZt
         5Nj3/qBh/QvclrH2UWAXYh3cUFKAz6MsfJe/eYnuNtOE6o8t4L9w7yw+dhJ5Ftvo6Ljd
         nx4uW9ebG6uBv/cgY218ONDIU5ZEKA1zQQ7qxSrtkRMSIZsxib/u0ji6MhGF2lsdmpXG
         PzDA==
X-Gm-Message-State: AOAM532RJEuhYIeDyTJCGQRvBsOAK9PDb41/KT6Rpo2EM8qm8gfoLidl
        yGMuVfefbACwXRcgujE2gM5jVi2hSvv3AjMjmUcttQ==
X-Google-Smtp-Source: ABdhPJxeG/RWLjpouaYjw9/E6VOlHTDg7MXYwTLOec/QiAK98nvPxkCA8eImKbQOu8sM28sUqbLkIsh+P+4Qc2KLZUw=
X-Received: by 2002:a05:651c:1035:: with SMTP id w21mr209576ljm.326.1606243332802;
 Tue, 24 Nov 2020 10:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20201119190237.626-1-chang.seok.bae@intel.com>
 <20201119190237.626-4-chang.seok.bae@intel.com> <CAG48ez1aKtwYMEHfGX6_FuX9fOruwvCqEGYVL8eLdV8bg-wHCQ@mail.gmail.com>
 <B2D7D498-D118-447E-93C6-DB03D42CBA4E@intel.com>
In-Reply-To: <B2D7D498-D118-447E-93C6-DB03D42CBA4E@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 24 Nov 2020 19:41:46 +0100
Message-ID: <CAG48ez1JK6pMT2UD1v0FwiCQq48FbE5Eb0d3tK=kK4Sg0TG7OQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] x86/signal: Prevent an alternate stack overflow
 before a signal delivery
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Dave Martin <Dave.Martin@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>,
        Roland McGrath <roland@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 24, 2020 at 7:22 PM Bae, Chang Seok
<chang.seok.bae@intel.com> wrote:
> > On Nov 20, 2020, at 15:04, Jann Horn <jannh@google.com> wrote:
> > On Thu, Nov 19, 2020 at 8:40 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> >>
> >> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> >> index ee6f1ceaa7a2..cee41d684dc2 100644
> >> --- a/arch/x86/kernel/signal.c
> >> +++ b/arch/x86/kernel/signal.c
> >> @@ -251,8 +251,13 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
> >>
> >>        /* This is the X/Open sanctioned signal stack switching.  */
> >>        if (ka->sa.sa_flags & SA_ONSTACK) {
> >> -               if (sas_ss_flags(sp) == 0)
> >> +               if (sas_ss_flags(sp) == 0) {
> >> +                       /* If the altstack might overflow, die with SIGSEGV: */
> >> +                       if (!altstack_size_ok(current))
> >> +                               return (void __user *)-1L;
> >> +
> >>                        sp = current->sas_ss_sp + current->sas_ss_size;
> >> +               }
> >
> > A couple lines further down, we have this (since commit 14fc9fbc700d):
> >
> >        /*
> >         * If we are on the alternate signal stack and would overflow it, don't.
> >         * Return an always-bogus address instead so we will die with SIGSEGV.
> >         */
> >        if (onsigstack && !likely(on_sig_stack(sp)))
> >                return (void __user *)-1L;
> >
> > Is that not working?
>
> onsigstack is set at the beginning here. If a signal hits under normal stack,
> this flag is not set. Then it will miss the overflow.
>
> The added check allows to detect the sigaltstack overflow (always).

Ah, I think I understand what you're trying to do. But wouldn't the
better approach be to ensure that the existing on_sig_stack() check is
also used if we just switched to the signal stack? Something like:

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index be0d7d4152ec..2f57842fb4d6 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -237,7 +237,7 @@ get_sigframe(struct k_sigaction *ka, struct
pt_regs *regs, size_t frame_size,
        unsigned long math_size = 0;
        unsigned long sp = regs->sp;
        unsigned long buf_fx = 0;
-       int onsigstack = on_sig_stack(sp);
+       bool onsigstack = on_sig_stack(sp);
        int ret;

        /* redzone */
@@ -246,8 +246,10 @@ get_sigframe(struct k_sigaction *ka, struct
pt_regs *regs, size_t frame_size,

        /* This is the X/Open sanctioned signal stack switching.  */
        if (ka->sa.sa_flags & SA_ONSTACK) {
-               if (sas_ss_flags(sp) == 0)
+               if (sas_ss_flags(sp) == 0) {
                        sp = current->sas_ss_sp + current->sas_ss_size;
+                       onsigstack = true;
+               }
        } else if (IS_ENABLED(CONFIG_X86_32) &&
                   !onsigstack &&
                   regs->ss != __USER_DS &&
