Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BA4387AE8
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 16:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349918AbhEROUX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 10:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243610AbhEROUW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 10:20:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA31661261;
        Tue, 18 May 2021 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621347544;
        bh=nrAiIQTKJqiGVWRN+fZiK7vfTpl+mh6GdbMLf8QWU6M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uO2nCdiW0NvUD3Oq2cx82BZG1aOLpwqISU2mJf1pn/41gmWeJwtJ3KwTWkPZOSffp
         qtEeD+G01WQE2a6OLg6viaogVrTcoartVG2vRtYwIcq9FSRcV1egrAvYdgmA/X3tdB
         m+P5YNb/2zoWb2ENaduSUYHTB0469Qb0Kj+2op5ABqhzmU5gjMCmQF2DbOGijvmPsZ
         xCjeQ8txdUZYsP5uPuGPMjh0ckotg/LymHT4x6ecHUAo8zYTM6uAVSt2umBf2+GizG
         +1ADzfu8zRcpU2xe1Of94E5AHIjxvrL1zbXxtiJz14yqM7TivZbQbYGDShT6WINj/N
         peuu9A0lgQRXg==
Received: by mail-wr1-f44.google.com with SMTP id j14so8694518wrq.5;
        Tue, 18 May 2021 07:19:04 -0700 (PDT)
X-Gm-Message-State: AOAM533iH7VBzIlnOuNZh8KObkGowvuqg209qCpHSe1GYY10O9Ap2071
        YIwemHu4gzeOIo+zwLND8bzHA526So8jSfafqg8=
X-Google-Smtp-Source: ABdhPJzFpyp1CPVwvL2JvI3KmHNWPOcV2naQQAKLVgR48kQxz5AWGK/oLA+ez9stiNWkfs+BeuLGyXYYTicjDNU1kEw=
X-Received: by 2002:a5d:6dc4:: with SMTP id d4mr7586717wrz.105.1621347543476;
 Tue, 18 May 2021 07:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210517203343.3941777-1-arnd@kernel.org> <20210517203343.3941777-2-arnd@kernel.org>
 <m1bl982m8c.fsf@fess.ebiederm.org> <CAK8P3a27_z8zk6j5W4n+u3g2e90v-h+3AbaTZ6YjCQ0B7AbJaA@mail.gmail.com>
In-Reply-To: <CAK8P3a27_z8zk6j5W4n+u3g2e90v-h+3AbaTZ6YjCQ0B7AbJaA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 18 May 2021 16:17:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a277VggQbBnXUzpwP7TKMj-S_z6rDMYYxfjyQmzGJdpCA@mail.gmail.com>
Message-ID: <CAK8P3a277VggQbBnXUzpwP7TKMj-S_z6rDMYYxfjyQmzGJdpCA@mail.gmail.com>
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

On Tue, May 18, 2021 at 4:05 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, May 18, 2021 at 3:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > Arnd Bergmann <arnd@kernel.org> writes:
> >
> > > From: Arnd Bergmann <arnd@arndb.de>KEXEC_ARCH_DEFAULT
> > >
> > > The compat version of sys_kexec_load() uses compat_alloc_user_space to
> > > convert the user-provided arguments into the native format.
> > >
> > > Move the conversion into the regular implementation with
> > > an in_compat_syscall() check to simplify it and avoid the
> > > compat_alloc_user_space() call.
> > >
> > > compat_sys_kexec_load() now behaves the same as sys_kexec_load().
> >
> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >KEXEC_ARCH_DEFAULT
> > The patch is wrong.
> >
> > The logic between the compat entry point and the ordinary entry point
> > are by necessity different.   This unifies the logic and breaks the compat
> > entry point.
> >
> > The fundamentally necessity is that the code being loaded needs to know
> > which mode the kernel is running in so it can safely transition to the
> > new kernel.
> >
> > Given that the two entry points fundamentally need different logic,
> > and that difference was not preserved and the goal of this patchset
> > was to unify that which fundamentally needs to be different.  I don't
> > think this patch series makes any sense for kexec.
>
> Sorry, I'm not following that explanation. Can you clarify what different
> modes of the kernel you are referring to here, and how my patch
> changes this?

I think I figured it out now myself after comparing the two functions:

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -269,7 +269,8 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry,
unsigned long, nr_segments,

        /* Verify we are on the appropriate architecture */
        if (((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH) &&
-               ((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
+               (in_compat_syscall() ||
+               ((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT)))
                return -EINVAL;

        /* Because we write directly to the reserved memory

Not sure if that's the best way of doing it, but it looks like folding this
in restores the current behavior.

        Arnd
