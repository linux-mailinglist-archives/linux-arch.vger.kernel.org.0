Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54EA25C392
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 16:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgICOyV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 10:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729408AbgICOyT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Sep 2020 10:54:19 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A8202151B
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 14:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599144858;
        bh=mriIatmtdubimfxx6F+KYhhAQsXMp4Zfj9n/rnqEnYg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MfmZFBjT64s2kj82dccACMNfccL3q/EDxxTceknRnn5UC3AImrGOzEffZCZJBQLHb
         xsY0ha/O5YBHgCotpGQ0WDdqXQ8tT675l0QXQ1Xgz+E+lw7gbhM7WmZIOITJodOcZN
         IMv6xVYpajk0/OrPonK7qnFLO3OuTIBZUFe3Lv/M=
Received: by mail-wm1-f50.google.com with SMTP id u18so3199580wmc.3
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 07:54:18 -0700 (PDT)
X-Gm-Message-State: AOAM532ehGZ8j7eSVLcljimeXNsIOVr4UXKDOHne5clkGe5nAJQsR1bR
        //OGlbsIylf76aLmJr5lyJhBXgqj+bU+9v3EByzguA==
X-Google-Smtp-Source: ABdhPJwZWPiuPxsfeWv1J/1dfx0Phx0Z+CR6jZc6Vth7ClO5Nnnsw9BnQ2BG0ronnM+rSbGLQcOzQkjyBYwFKrdO6uM=
X-Received: by 2002:a1c:740c:: with SMTP id p12mr2909254wmc.176.1599144856798;
 Thu, 03 Sep 2020 07:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <46e42e5e-0bca-5f3f-efc9-5ab15827cc0b@intel.com>
 <40BC093A-F430-4DCC-8DC0-2BA90A6FC3FA@amacapital.net> <b3809dd7-8566-0517-2389-8089475135b7@intel.com>
In-Reply-To: <b3809dd7-8566-0517-2389-8089475135b7@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 3 Sep 2020 07:54:05 -0700
X-Gmail-Original-Message-ID: <CALCETrVY6XXUkePL0D0gmGEkq_oB2Ly_uXo6QQUz1v0H7sf_-g@mail.gmail.com>
Message-ID: <CALCETrVY6XXUkePL0D0gmGEkq_oB2Ly_uXo6QQUz1v0H7sf_-g@mail.gmail.com>
Subject: Re: [PATCH v11 6/9] x86/cet: Add PTRACE interface for CET
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Jann Horn <jannh@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 3, 2020 at 7:27 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 9/2/20 9:35 PM, Andy Lutomirski wrote:
> >>>>>> +       fpu__prepare_read(fpu);
> >>>>>> +       cetregs =3D get_xsave_addr(&fpu->state.xsave, XFEATURE_CET=
_USER);
> >>>>>> +       if (!cetregs)
> >>>>>> +               return -EFAULT;
> >>>>> Can this branch ever be hit without a kernel bug? If yes, I think
> >>>>> -EFAULT is probably a weird error code to choose here. If no, this
> >>>>> should probably use WARN_ON(). Same thing in cetregs_set().
> >>>> When a thread is not CET-enabled, its CET state does not exist.  I l=
ooked at EFAULT, and it means "Bad address".  Maybe this can be ENODEV, whi=
ch means "No such device"?
> > Having read the code, I=E2=80=99m unconvinced. It looks like a get_xsav=
e_addr() failure means =E2=80=9Cstate not saved; task sees INIT state=E2=80=
=9D.  So *maybe* it=E2=80=99s reasonable -ENODEV this, but I=E2=80=99m not =
really convinced. I tend to think we should return the actual INIT state an=
d that we should permit writes and handle them correctly.
>
> PTRACE is asking for access to the values in the *registers*, not for
> the value in the kernel XSAVE buffer.  We just happen to only have the
> kernel XSAVE buffer around.
>
> If we want to really support PTRACE we have to allow the registers to be
> get/set, regardless of what state they are in, INIT state or not.  So,
> yeah I agree with Andy.

I think the core dump code gets here, too, so the values might be in
registers as well.  I hope that fpu__prepare_read() does the right
thing in this case.

--Andy
