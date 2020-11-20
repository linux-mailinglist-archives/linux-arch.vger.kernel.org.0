Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C29B2BB9AA
	for <lists+linux-arch@lfdr.de>; Sat, 21 Nov 2020 00:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgKTXFH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 18:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgKTXFG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2020 18:05:06 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45050C061A47
        for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2020 15:05:06 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id s9so11699097ljo.11
        for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2020 15:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsItiRlY2ZsY1kLHaN9bW+mg6xUUzDuK1HmeXy3qoOM=;
        b=LULwD43R9K6cuWxcFQ3hXHCXYhiJN+3GbIfFgwF3U+9D4uK3QRYGXhUNIUm/phAvgJ
         O1+dQBQPdrOTkni7W+oLdBOBc2AuCnoiRAW66303aXkiViycOcEDheImdEnAvuTIjXzp
         eLP5Sjq1o7lBd24nmSshBGwl7Y0U5t7ogW/mH3gP2dUJ1nM4usf4NwpQS82BRv6K9Yap
         EMrQjrG/eD9JrD4ypfMMHEas9+4anxoeUxQJeMNfyj46BkBpdcwCf7RtWmInwVepP2GK
         gV24+8jJQZTCASDuFsakteAbIMTSJCXGpatnCUddjQGQYa13xtA2KiDV3arQoVCzVSqZ
         QhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsItiRlY2ZsY1kLHaN9bW+mg6xUUzDuK1HmeXy3qoOM=;
        b=h3fJURp/YskRXKmPQStZnjYbJrM0c8vktMqUQfgBBVcG287j9wKZD2rAEydISUxbTM
         GyORqmoaht1VJEhWl2jjZEyE7cX8i6Jx9H6aN1w6PwsGjHcnK3qYxEfDC64JShnJdlXR
         8hCodQFC+W2ZzlVZLylV0/Xeih7ji6Ild4PcJcGA2Y017ttx1fR5Zj9ZAcTj7aTwPfW0
         Vh0nZB4hUcyaipexrn09aTfg5l2tEk/DOTv1c4okylFnBLYJ4ukqiFq08XzyoG8YNB+g
         xJdlAtdXxBuJpKgvKWzIAJG/IkxTbIlsig0xyHxI5D7J2lMuicrvrWO5Yl6N/ZgzQocx
         XEKQ==
X-Gm-Message-State: AOAM5311x9JGQvYtWFMR9fzFfIWq2ACOPbEAfzUC8xintJoLh3TXs5LT
        hPtIiq66GAkpNCim0/8B+pnKJzonhgq4eF6ePU45NA==
X-Google-Smtp-Source: ABdhPJymlpDCBYMRse6yxmhBac3FkYvw4MIKvsrIx7Zv7EbYRWZkOmL5ixX8POB9rfwViL1vOrupv+a/zLsoSj3iJio=
X-Received: by 2002:a2e:8891:: with SMTP id k17mr8457473lji.326.1605913504291;
 Fri, 20 Nov 2020 15:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20201119190237.626-1-chang.seok.bae@intel.com> <20201119190237.626-4-chang.seok.bae@intel.com>
In-Reply-To: <20201119190237.626-4-chang.seok.bae@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 21 Nov 2020 00:04:38 +0100
Message-ID: <CAG48ez1aKtwYMEHfGX6_FuX9fOruwvCqEGYVL8eLdV8bg-wHCQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] x86/signal: Prevent an alternate stack overflow
 before a signal delivery
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Dave Martin <Dave.Martin@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        libc-alpha@sourceware.org, linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>,
        Roland McGrath <roland@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 8:40 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> The kernel pushes data on the userspace stack when entering a signal. If
> using a sigaltstack(), the kernel precisely knows the user stack size.
>
> When the kernel knows that the user stack is too small, avoid the overflow
> and do an immediate SIGSEGV instead.
>
> This overflow is known to occur on systems with large XSAVE state. The
> effort to increase the size typically used for altstacks reduces the
> frequency of these overflows, but this approach is still useful for legacy
> binaries.
>
> Here the kernel expects a bit conservative stack size (for 64-bit apps).
> Legacy binaries used a too-small sigaltstack would be already overflowed
> before this change, if they run on modern hardware.
[...]
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index ee6f1ceaa7a2..cee41d684dc2 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -251,8 +251,13 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
>
>         /* This is the X/Open sanctioned signal stack switching.  */
>         if (ka->sa.sa_flags & SA_ONSTACK) {
> -               if (sas_ss_flags(sp) == 0)
> +               if (sas_ss_flags(sp) == 0) {
> +                       /* If the altstack might overflow, die with SIGSEGV: */
> +                       if (!altstack_size_ok(current))
> +                               return (void __user *)-1L;
> +
>                         sp = current->sas_ss_sp + current->sas_ss_size;
> +               }

A couple lines further down, we have this (since commit 14fc9fbc700d):

        /*
         * If we are on the alternate signal stack and would overflow it, don't.
         * Return an always-bogus address instead so we will die with SIGSEGV.
         */
        if (onsigstack && !likely(on_sig_stack(sp)))
                return (void __user *)-1L;

Is that not working?


(It won't handle the case where the kernel fills up almost all of the
alternate stack, and the userspace signal handler then overflows out
of the alternate signal stack. But there isn't much the kernel can do
about that...)
