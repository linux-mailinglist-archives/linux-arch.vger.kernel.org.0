Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D53387AA9
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 16:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349743AbhEROIP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 10:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244785AbhEROIO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 10:08:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F83760BD3;
        Tue, 18 May 2021 14:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621346816;
        bh=EBdubQ1sGe/Bbb8YFCgOGYR3HaooPs65ywrzHVDre7k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RbV02EcJhjnPpoAgtlUffPYAFOIPf2Zfq2gUt1oVyTEiAYhzQx98Z7sJ0sTGbAXaS
         NlBJEs1szZ4F2EEkvUJ6IACrfC7cTICSOF5VcXMYLtKj6JaDd6gz1SfFGF7u8GExsK
         uzoJ/uR9JOLdzl8ubsB5wcrxikl5CIBETIRLr3nNKcFnYshed5fk6DIELvnt5Eu1t9
         0A7NljYACgUoCSxWmsc/iOaQtu+4wuvo8m6LHULmb3/fbpofv7qPg1TafF9e3/MrHK
         yVasf0WeCo6NhlMmCSCsqPhsxLkc6y1uwYZycTnNEQ8sQXnTtplHuVzt+Fk8BgyEGp
         sZIbwqrUxDA4w==
Received: by mail-wm1-f41.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso1592333wmm.3;
        Tue, 18 May 2021 07:06:56 -0700 (PDT)
X-Gm-Message-State: AOAM531JYeMrEeq0rZhAawyDNIomsaMl4otcFqx8cepu/iysyGqgbM5/
        GrkrLMeAgHlf1a04WP3JU1+Pv/QVfOm5IWKxNyo=
X-Google-Smtp-Source: ABdhPJx+yeQS6ZDHm5FRpgmqd8Rk2r80K5a8CnDcKJIH0RKrLCYMj6CuRTSlOrPLbmKbp1JI5kZJwEAnlPfvw/suG58=
X-Received: by 2002:a1c:9895:: with SMTP id a143mr5564837wme.43.1621346814762;
 Tue, 18 May 2021 07:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210517203343.3941777-1-arnd@kernel.org> <20210517203343.3941777-2-arnd@kernel.org>
 <m1bl982m8c.fsf@fess.ebiederm.org>
In-Reply-To: <m1bl982m8c.fsf@fess.ebiederm.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 18 May 2021 16:05:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a27_z8zk6j5W4n+u3g2e90v-h+3AbaTZ6YjCQ0B7AbJaA@mail.gmail.com>
Message-ID: <CAK8P3a27_z8zk6j5W4n+u3g2e90v-h+3AbaTZ6YjCQ0B7AbJaA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 3:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Arnd Bergmann <arnd@kernel.org> writes:
>
> > From: Arnd Bergmann <arnd@arndb.de>KEXEC_ARCH_DEFAULT
> >
> > The compat version of sys_kexec_load() uses compat_alloc_user_space to
> > convert the user-provided arguments into the native format.
> >
> > Move the conversion into the regular implementation with
> > an in_compat_syscall() check to simplify it and avoid the
> > compat_alloc_user_space() call.
> >
> > compat_sys_kexec_load() now behaves the same as sys_kexec_load().
>
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>KEXEC_ARCH_DEFAULT
> The patch is wrong.
>
> The logic between the compat entry point and the ordinary entry point
> are by necessity different.   This unifies the logic and breaks the compat
> entry point.
>
> The fundamentally necessity is that the code being loaded needs to know
> which mode the kernel is running in so it can safely transition to the
> new kernel.
>
> Given that the two entry points fundamentally need different logic,
> and that difference was not preserved and the goal of this patchset
> was to unify that which fundamentally needs to be different.  I don't
> think this patch series makes any sense for kexec.

Sorry, I'm not following that explanation. Can you clarify what different
modes of the kernel you are referring to here, and how my patch
changes this?

The only difference I can see between the native and compat entry
points is the layout of the kexec_segment structure, and that is
obviously preserved by my patch.

         Arnd
