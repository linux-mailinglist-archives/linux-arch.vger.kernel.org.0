Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1DC3CBAFF
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jul 2021 19:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhGPRTH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jul 2021 13:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhGPRTG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jul 2021 13:19:06 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A983C061764
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2021 10:16:08 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id m14-20020a4a240e0000b029025e4d9b0a3dso2596284oof.6
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2021 10:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWbVndvTFPt8BOcGSAnZdQeZBgwQ39VLXMDadBgw6kk=;
        b=kycsT8OTIWrycyqND/lL5jUMQFDjltZ92oujogdg2Ndlkp+0StM8kAIg7tLjtQfeG1
         YtQp0RLCivg5nlV/zFSc1mTULVPHjZTq7Ex+9U/i2yTDKpEG7bpkN+bJ8s8tT1JaBqwM
         y2TLzY9HoTp/Uz4id24PK7R/mXY9Jq6r81ZebQ+l6yf4sVQAbW1lEdfkLQRpnnjyDDmt
         bgikzUbY3QcdoaR5eMFhAPwFnx5Vw+ejdfPoUKSNgoBP0WsPICAy2cHDBYAdl8Ac/wYr
         kP06C8cTP2tL3t0qMqlAqnL33Dxo7e9FDTC/AFaZehjspePkLl7z/2H0fI4s4//TTHjd
         wV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWbVndvTFPt8BOcGSAnZdQeZBgwQ39VLXMDadBgw6kk=;
        b=sxEpbqlDYh3wjtiJmwBv4xsSHJQy4MnMSLLaez14HcBIU8NuT3X51H8XIhVOXQAGRZ
         kOHNHK8oX20y07W+C5/DaJvPNPz5+UM/Zmd5trssj8kA9DeRt1V+J7m8IMqRwcn5YSue
         TNRwXu0t0Mf3jVUyIftpdZ2wybVSg6BrtGu16X2AW6ab7WTpJFJVDyIawGNjRL1l8fe1
         ixPmVSHGRXF9bcDX096vEdQOm4PxoWaa34LzKK107x3R5ohS29aLRIJqqrw9pBKIjd0l
         NpS8jEl8+nljh8kTX84C1F4WRepVLgbd7PN3Yp0hjKw28iuHMdapbD87JO0/S10MN1aX
         ognQ==
X-Gm-Message-State: AOAM533icQ6QPxdNxTVQ6e4D+Z0U+oLOggkNJNkBTE70d7kNILh5v18Y
        us3S1IzSTluMGiM+8quT6iQRZHyeWkRGl4RZqg0JRg==
X-Google-Smtp-Source: ABdhPJx9gk24ziK+bUUPctrm/fDAn5x21MphrWbNdm5y/1f6NtI1GUnsZkQdW2dgVWs4fHcFQbpBeYfuinN/+cxYnXU=
X-Received: by 2002:a4a:956f:: with SMTP id n44mr8396820ooi.54.1626455767094;
 Fri, 16 Jul 2021 10:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <87a6mnzbx2.fsf_-_@disp2133>
 <YPFybJQ7eviet341@elver.google.com> <87tukuw8a3.fsf@disp2133>
In-Reply-To: <87tukuw8a3.fsf@disp2133>
From:   Marco Elver <elver@google.com>
Date:   Fri, 16 Jul 2021 19:15:55 +0200
Message-ID: <CANpmjNMAxk5--iAmL3fL8XpPuDDFdufu1T=r0USnO+6Rn-A95A@mail.gmail.com>
Subject: Re: [PATCH 0/6] Final si_trapno bits
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 16 Jul 2021 at 18:09, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Marco Elver <elver@google.com> writes:
> > On Thu, Jul 15, 2021 at 01:09PM -0500, Eric W. Biederman wrote:
> >> As a part of a fix for the ABI of the newly added SIGTRAP TRAP_PERF a
> >> si_trapno was reduced to an ordinary extention of the _sigfault case
> >> of struct siginfo.
> >>
> >> When Linus saw the complete set of changes come in as a fix he requested
> >> that the set of changes be trimmed down to just what was necessary to
> >> fix the SIGTRAP TRAP_PERF ABI.
> >>
> >> I had intended to get the rest of the changes into the merge window for
> >> v5.14 but I dropped the ball.
> >>
> >> I have made the changes to stop using __ARCH_SI_TRAPNO be per
> >> architecture so they are easier to review.  In doing so I found one
> >> place on alpha where I used send_sig_fault instead of
> >> send_sig_fault_trapno(... si_trapno = 0).  That would not have changed
> >> the userspace behavior but it did make the kernel code less clear.
> >>
> >> My rule in these patches is everywhere that siginfo layout calls
> >> for SIL_FAULT_TRAPNO the code uses either force_sig_fault_trapno
> >> or send_sig_fault_trapno.
> >>
> >> And of course I have rebased and compile tested Marco's compile time
> >> assert patches.
> >>
> >> Eric
> >>
> >>
> >> Eric W. Biederman (3):
> >>       signal/sparc: si_trapno is only used with SIGILL ILL_ILLTRP
> >>       signal/alpha: si_trapno is only used with SIGFPE and SIGTRAP TRAP_UNK
> >>       signal: Remove the generic __ARCH_SI_TRAPNO support
> >>
> >> Marco Elver (3):
> >>       sparc64: Add compile-time asserts for siginfo_t offsets
> >>       arm: Add compile-time asserts for siginfo_t offsets
> >>       arm64: Add compile-time asserts for siginfo_t offsets
> >
> > Nice, thanks for the respin. If I diffed it right, I see this is almost
> > (modulo what you mentioned above) equivalent to:
> >   https://lore.kernel.org/linux-api/m1tuni8ano.fsf_-_@fess.ebiederm.org/
> > + what's already in mainline. It's only missing:
> >
> >       signal: Verify the alignment and size of siginfo_t
> >       signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency
> >
> > Would this be appropriate for this series, or rather separately, or
> > dropped completely?
>
> Appropriate I just overlooked them.

Full series with the 2 patches just sent looks good to me.

Thanks,
-- Marco
