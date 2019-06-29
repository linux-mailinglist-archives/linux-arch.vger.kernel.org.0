Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FA35ADD0
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jun 2019 01:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfF2XwE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jun 2019 19:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfF2XwE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Jun 2019 19:52:04 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC4902177B
        for <linux-arch@vger.kernel.org>; Sat, 29 Jun 2019 23:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561852322;
        bh=6zNQnfiowkbQ8h6I1Y7teWbbkPJhz6He7iJKmvs4QWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LqHFV/mMj1WJ1FJYjm4dsZpET86Mk/PcxN8/9sOQw1WXWUG0Jw9kUjnmFl3GysdAD
         3HSO7T1bHPJwRE/Sbj1fNLXA027nVKrVADGQkhL1cKA3q8a0ez7Dwgxg+zfl7gVTto
         wGWlXzmhRnEbB5Zg1vV8H1Rq3yYKZdrURN7yOqMA=
Received: by mail-wm1-f53.google.com with SMTP id s15so12250388wmj.3
        for <linux-arch@vger.kernel.org>; Sat, 29 Jun 2019 16:52:02 -0700 (PDT)
X-Gm-Message-State: APjAAAX09FjNVDxrWyPOSw+p8zvJeNwEmn8Y2OsAzy4YsSOe4OuWwlF4
        Kfxq2Y0Ii6cxgqbvXo71sHCUaSsSpNKKVez7OEFPKw==
X-Google-Smtp-Source: APXvYqxhmwDqrmlkZAimba10Xv/RlD6PB4UdF/fPwsFeXRzhkaTblqCt81E36GQUxcf4afzX9qpHfKxpnuSWGrcyO2s=
X-Received: by 2002:a7b:c450:: with SMTP id l16mr12352705wmi.0.1561852321259;
 Sat, 29 Jun 2019 16:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190501211217.5039-1-yu-cheng.yu@intel.com> <20190502111003.GO3567@e103592.cambridge.arm.com>
 <CALCETrVZCzh+KFCF6ijuf4QEPn=R2gJ8FHLpyFd=n+pNOMMMjA@mail.gmail.com> <87ef3fweoq.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87ef3fweoq.fsf@oldenburg2.str.redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 29 Jun 2019 16:51:50 -0700
X-Gmail-Original-Message-ID: <CALCETrUPJXW7An9EBaRQLppB3vHEQFfYP1o8h-4PSFcZt5Pa2A@mail.gmail.com>
Message-ID: <CALCETrUPJXW7An9EBaRQLppB3vHEQFfYP1o8h-4PSFcZt5Pa2A@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: Extract .note.gnu.property from an ELF file
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 27, 2019 at 2:39 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Andy Lutomirski:
>
> > Also, I don't think there's any actual requirement that the upstream
> > kernel recognize existing CET-enabled RHEL 8 binaries as being
> > CET-enabled.  I tend to think that RHEL 8 jumped the gun here.
>
> The ABI was supposed to be finalized and everyone involved thought it
> had been reviewed by the GNU gABI community and other interested
> parties.  It had been included in binutils for several releases.
>
> From my point of view, the kernel is just a consumer of the ABI.  The
> kernel would not change an instruction encoding if it doesn't like it
> for some reason, either.

I read the only relevant gABI thing I could find easily, and it seems
to document the "gnu property" thing.  I have no problem with that.

>
> > While the upstream kernel should make some reasonble effort to make
> > sure that RHEL 8 binaries will continue to run, I don't see why we
> > need to go out of our way to keep the full set of mitigations
> > available for binaries that were developed against a non-upstream
> > kernel.
>
> They were developed against the ABI specification.
>
> I do not have a strong opinion what the kernel should do going forward.
> I just want to make clear what happened.

I admit that I'm not really clear on exactly what RHEL 8 shipped.
Some of this stuff is very much an ELF ABI that belongs to the
toolchain, but some if it is kernel API.  For example, the IBT legacy
bitmap API is very much in flux, and I don't think anything credible
has been submitted for upstream inclusion.  Does RHEL 8's glibc
attempt to cope with the case where some libraries are CET-compatible
and some are not?  If so, how does this work?  What, if any, services
does the RHEL 8 kernel provide in this direction?
