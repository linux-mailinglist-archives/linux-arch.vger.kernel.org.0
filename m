Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D5636EFA1
	for <lists+linux-arch@lfdr.de>; Thu, 29 Apr 2021 20:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241055AbhD2Srs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Apr 2021 14:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241017AbhD2Srs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Apr 2021 14:47:48 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BA9C06138C
        for <linux-arch@vger.kernel.org>; Thu, 29 Apr 2021 11:47:01 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id p6-20020a4adc060000b02901f9a8fc324fso1265264oov.10
        for <linux-arch@vger.kernel.org>; Thu, 29 Apr 2021 11:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+UJwrU2MphE2H9pVBe4Va+3pVl8MrgEBW+di5Ar9x8=;
        b=YheD8PJ4vjevdlZN9xjnFDpXx4r8xj2WfocSQQ4FGrmpUl25K4XoAHracDIHAGonKN
         Jv3mQKHDRRNGM9uEqJMtY4Yp9sJ3Z6THXD+9dAm2ae5aXwuyvkAQ/SuhvQyXFZNln9i2
         akSju72aiY34YA1tJymgIHYtICD8WkUWRdIjCAjzxQr8A9Poah+p2KGQoWPwUYfMK1g7
         aLIoo8lvbq17uIsuedHL2iNKfjB94cT0cHbrYZbZxc/kkTs6hyLzneEYpH3ZydvnAXZ0
         jvxrcdJ+BRzf2j1qvZOSHDGDCPF+loGh+oihiIW+0yzNjgqWWgkE7+/VoNUsYlxK75OI
         yKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+UJwrU2MphE2H9pVBe4Va+3pVl8MrgEBW+di5Ar9x8=;
        b=L9cCQdp41SMgGmN8xFo2guFKOsaPl9b7RYCxq+zxctsmV5JJa2j18FTZ6vFtsF8sta
         IIiIMnoaZaM8PiDsHuS6YsM+V3YdNT6d6XUM51UnyfHL9edlZ0Mv7htLjZZMDxcLoaSC
         w0gI7IWhbNm/Zgn9mDSFd1VR/PLrNPd6GUiXduebbFx8phb1feZze3wrfHUHXfzZklZj
         j+Xw3ehTRqPEMiigEqbsEAB258jerE+UKeqGI6PvqTZNKxJKIRw0L+SF9THCvJ0XSPis
         /iQ4qEyfnlkXHN+jyUx3xfhQfWEAyffHpsLtVesd24+iFLKijfWjMI3/WnR2JmzJmg+U
         A/ww==
X-Gm-Message-State: AOAM533RwIqQMHzdPDzZgyprlRvY1DVQR0te2M+jtnyLadJYp9g1WLz0
        Wh5A/6N0iwWRYoqNUlnI1V1IG3fRVPjdwh32HkR//Q==
X-Google-Smtp-Source: ABdhPJxg+cX3WOkcKuWZN0i123++XM7omVXz3QzNsOO657nSkyD05K2ZNT5GkuRpNxSGCUdZmf57iALTgxI/591rfdA=
X-Received: by 2002:a4a:96e3:: with SMTP id t32mr1153302ooi.14.1619722020332;
 Thu, 29 Apr 2021 11:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
In-Reply-To: <m11rat9f85.fsf@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Thu, 29 Apr 2021 20:46:48 +0200
Message-ID: <CANpmjNNeH7+7H3y-5BCNGx+Yo11HG-F3M5TLqCAXd11Up5PTWA@mail.gmail.com>
Subject: Re: siginfo_t ABI break on sparc64 from si_addr_lsb move 3y ago
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 29 Apr 2021 at 19:24, Eric W. Biederman <ebiederm@xmission.com> wrote:
[...]
> > Granted, nobody seems to have noticed because I don't even know if these
> > fields have use on sparc64. But I don't yet see this as justification to
> > leave things as-is...
> >
> > The collateral damage of this, and the acute problem that I'm having is
> > defining si_perf in a sort-of readable and portable way in siginfo_t
> > definitions that live outside the kernel, where sparc64 does not yet
> > have broken si_addr_lsb. And the same difficulty applies to the kernel
> > if we want to unbreak sparc64, while not wanting to move si_perf for
> > other architectures.
> >
> > There are 2 options I see to solve this:
> >
> > 1. Make things simple again. We could just revert the change moving
> >    si_addr_lsb into the union, and sadly accept we'll have to live with
> >    that legacy "design" mistake. (si_perf stays in the union, but will
> >    unfortunately change its offset for all architectures... this one-off
> >    move might be ok because it's new.)
> >
> > 2. Add special cases to retain si_addr_lsb in the union on architectures
> >    that do not have __ARCH_SI_TRAPNO (the majority). I have added a
> >    draft patch that would do this below (with some refactoring so that
> >    it remains sort-of readable), as an experiment to see how complicated
> >    this gets.
> >
> > Which option do you prefer? Are there better options?
>
> Personally the most important thing to have is a single definition
> shared by all architectures so that we consolidate testing.
>
> A little piece of me cries a little whenever I see how badly we
> implemented the POSIX design.  As specified by POSIX the fields can be
> place in siginfo such that 32bit and 64bit share a common definition.
> Unfortunately we did not addpadding after si_addr on 32bit to
> accommodate a 64bit si_addr.

I think it's even worse than that, see the fun I had with siginfo last
week: https://lkml.kernel.org/r/20210422191823.79012-1-elver@google.com
... because of the 3 initial ints and no padding after them, we can't
portably add __u64 fields to siginfo, and are forever forced to have
subtly different behaviour between 32-bit and 64-bit architectures.
:-/

> I find it unfortunate that we are adding yet another definition that
> requires translation between 32bit and 64bit, but I am glad
> that at least the translation is not architecture specific.  That common
> definition is what has allowed this potential issue to be caught
> and that makes me very happy to see.
>
> Let's go with Option 3.
>
> Confirm BUS_MCEERR_AR, BUS_MCEERR_AO, SEGV_BNDERR, SEGV_PKUERR are not
> in use on any architecture that defines __ARCH_SI_TRAPNO, and then fixup
> the userspace definitions of these fields.
>
> To the kernel I would add some BUILD_BUG_ON's to whatever the best
> maintained architecture (sparc64?) that implements __ARCH_SI_TRAPNO just
> to confirm we don't create future regressions by accident.
>
> I did a quick search and the architectures that define __ARCH_SI_TRAPNO
> are sparc, mips, and alpha.  All have 64bit implementations.  A further
> quick search shows that none of those architectures have faults that
> use BUS_MCEERR_AR, BUS_MCEERR_AO, SEGV_BNDERR, SEGV_PKUERR, nor do
> they appear to use mm/memory-failure.c
>
> So it doesn't look like we have an ABI regression to fix.

That sounds fine to me -- my guess was that they're not used on these
architectures, but I just couldn't make that call.

I have patches adding compile-time asserts for sparc64, arm, arm64
ready to go. I'll send them after some more testing.

Thanks,
-- Marco
