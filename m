Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F33F27095A
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 02:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgISAME (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 20:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgISAME (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Sep 2020 20:12:04 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5674D22208
        for <linux-arch@vger.kernel.org>; Sat, 19 Sep 2020 00:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600474323;
        bh=etjZlYYd1IIPDO1NfKNkztbf4goZGkm6DYQVvva74MI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L7h6oG+UCIlVAj7i6PyxRQf7m9hC/1jmn3wsGAiTRhuPMAOQbzjvfwU1eUsohup7x
         nsEMlDfmILL1Qv9F7HCx4sxrvxUj9AqhKo2z0RWVDQolq2dDHte4dIn/vts80Gz3rj
         iLjVZ1Ydk2VK8jPEt1IyztAW9dwtHXaJ1tj9YxRE=
Received: by mail-wm1-f43.google.com with SMTP id q9so6795863wmj.2
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 17:12:03 -0700 (PDT)
X-Gm-Message-State: AOAM531HEYQLEUcJ1tdQLSlE7REe0BcJr+Sd7oSWbSlav9JFQkMotMWd
        KrL9KloTHS302BCTapNocbLgjea81Rz+Ax3J4wpxjQ==
X-Google-Smtp-Source: ABdhPJxmOMUD3oJeWUBWSi+Yvq5YFeJEC+DLVGlDfJl03Mlbg5VJuyOxaSuU065pkOCJwFJ0EmxFOn3UVUdyN4X8nu8=
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr17372943wmi.36.1600474321906;
 Fri, 18 Sep 2020 17:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200918192312.25978-1-yu-cheng.yu@intel.com> <20200918192312.25978-9-yu-cheng.yu@intel.com>
In-Reply-To: <20200918192312.25978-9-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 18 Sep 2020 17:11:50 -0700
X-Gmail-Original-Message-ID: <CALCETrXfixDGJhf0yPw-OckjEdeF2SbYjWFm8VbLriiP0Krhrg@mail.gmail.com>
Message-ID: <CALCETrXfixDGJhf0yPw-OckjEdeF2SbYjWFm8VbLriiP0Krhrg@mail.gmail.com>
Subject: Re: [PATCH v12 8/8] x86: Disallow vsyscall emulation when CET is enabled
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 12:23 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Emulation of the legacy vsyscall page is required by some programs
> built before 2013.  Newer programs after 2013 don't use it.
> Disable vsyscall emulation when Control-flow Enforcement (CET) is
> enabled to enhance security.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
> v12:
> - Disable vsyscall emulation only when it is attempted (vs. at compile time).
>
>  arch/x86/entry/vsyscall/vsyscall_64.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 44c33103a955..3196e963e365 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -150,6 +150,15 @@ bool emulate_vsyscall(unsigned long error_code,
>
>         WARN_ON_ONCE(address != regs->ip);
>
> +#ifdef CONFIG_X86_INTEL_CET
> +       if (current->thread.cet.shstk_size ||
> +           current->thread.cet.ibt_enabled) {
> +               warn_bad_vsyscall(KERN_INFO, regs,
> +                                 "vsyscall attempted with cet enabled");
> +               return false;
> +       }

Nope, try again.  Having IBT on does *not* mean that every library in
the process knows that we have indirect branch tracking.  The legacy
bitmap exists for a reason.  Also, I want a way to flag programs as
not using the vsyscall page, but that flag should not be called CET.
And a process with vsyscalls off should not be able to read the
vsyscall page, and /proc/self/maps should be correct.

So you have some choices:

1. Drop this patch and make it work.

2. Add a real per-process vsyscall control.  Either make it depend on
vsyscall=xonly and wire it up correctly or actually make it work
correctly with vsyscall=emulate.

NAK to any hacks in this space.  Do it right or don't do it at all.
