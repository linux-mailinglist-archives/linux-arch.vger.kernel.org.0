Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51419255FDA
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 19:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgH1RjW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 13:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgH1RjT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 13:39:19 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E8821531
        for <linux-arch@vger.kernel.org>; Fri, 28 Aug 2020 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598636358;
        bh=nds4FCanqTVJv34u/NxVJCyvtJsI4h+1rVN+aRFYiGg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TyRrjGkegJtc5NUYxIc2CRRvLWWkqf3QVI21p9DZd3r+zXtNHhiTBFd3UlkrkLutM
         m2gdFyeVpnX0PkMaqL510A5pXF7hkUeHvcLoBDY0+OUjfZznfyPRQlCtxAFsXLhhnV
         xMSL/cxiwuYQZXZgTbn4Xr4D7RH+IXBRyvCTlYAE=
Received: by mail-wm1-f45.google.com with SMTP id b79so146738wmb.4
        for <linux-arch@vger.kernel.org>; Fri, 28 Aug 2020 10:39:18 -0700 (PDT)
X-Gm-Message-State: AOAM532aZLVassEnOwOuyyj30Jh3qSKQzJS1QhUj9Wb/S9qX2/z82+R0
        CnlJDGZ0HTOTs2VN2GjNJ81dJcFBxEQwQIHQaHShMw==
X-Google-Smtp-Source: ABdhPJyhwm17L0OXGgBqLsRtUxnb+FTpBy4Z2839DwNgsYJBjPegOYm2k1/SJF+gcG8rpzzWXr5f2DuOidvrokSrcrI=
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr214706wmc.138.1598636356748;
 Fri, 28 Aug 2020 10:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <a770d45d-b147-a8c5-b7f8-30d668cbed84@intel.com>
 <4BDFD364-798C-4537-A88E-F94F101F524B@amacapital.net> <CAMe9rOoTjSwRSPuqP6RKkDzPA_VPh5gVYRVFJ-ezAD4Et-FUng@mail.gmail.com>
 <CALCETrW=-ahC7GUCCyX7nPjCHfG3tiyDespud2Z7UbB6yWWWAA@mail.gmail.com>
 <CAMe9rOrt5hz6qsNAxPgdKCOhRcKKESv-D3rxdSfraeJ-LFHM4w@mail.gmail.com>
 <87v9h3thj9.fsf@oldenburg2.str.redhat.com> <CAMe9rOr=BZw3GyXf0g6tAZnfa8NbamoyBoU9KqoxtHg9c2yZhw@mail.gmail.com>
In-Reply-To: <CAMe9rOr=BZw3GyXf0g6tAZnfa8NbamoyBoU9KqoxtHg9c2yZhw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 28 Aug 2020 10:39:05 -0700
X-Gmail-Original-Message-ID: <CALCETrUUKb6oyBmB3CSeVy1xT7mcnV=BD2eipAnKUhma7K3qKw@mail.gmail.com>
Message-ID: <CALCETrUUKb6oyBmB3CSeVy1xT7mcnV=BD2eipAnKUhma7K3qKw@mail.gmail.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
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
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 4:38 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Thu, Aug 27, 2020 at 11:24 PM Florian Weimer <fweimer@redhat.com> wrote:
> >
> > * H. J. Lu:
> >
> > > Can you think of ANY issues of passing more arguments to arch_prctl?
> >
> > On x32, the glibc arch_prctl system call wrapper only passes two
> > arguments to the kernel, and applications have no way of detecting that.
> > musl only passes two arguments on all architectures.  It happens to work
> > anyway with default compiler flags, but that's an accident.
>
> In the current glibc, there is no arch_prctl wrapper for i386.  There are
> arch_prctl wrappers with 2 arguments for x86-64 and x32.  But this isn't an
> issue for glibc since glibc is both the provider and the user of the new
> arch_prctl extension.  Besides,
>
> long syscall(long number, ...);
>
> is always available.

Userspace is probably full of tools and libraries that contain tables
of system calls and their signatures.  Think tracing, audit, container
management, etc.  I don't know how they will react to the addition of
new arguments.
