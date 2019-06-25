Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F14055874
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 22:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfFYULj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 16:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfFYULj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jun 2019 16:11:39 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 010F5214DA
        for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2019 20:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561493498;
        bh=EEgDTn2acFAmQZQO3MkPdApy27ciI+GVpCKZTuXCYvA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PVsMHvQg4NzwVAfuGHGplLn7MJyzkh7ctvV73YnV2d7IA+QGtzN2aEIpbQT9GIC17
         asPWX7Za4Zrr/ag8CHqGiLCokLdB1oNdQKiK/jCbstl3Fg4HqbAl6VhdJdsyeM5SoR
         5Irc0BxRb1H4AmkR/kPNxhQCInVE+0u3FjXfgpFk=
Received: by mail-wm1-f45.google.com with SMTP id v19so124138wmj.5
        for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2019 13:11:37 -0700 (PDT)
X-Gm-Message-State: APjAAAUh3apnpjDHC1ryYhdD6uFWfKmNqnpUvclxxAdRRZEDr6zArxv/
        j57anypBAnmLfP+v24T7SS1hVacf0CwVkXkXxr1dpw==
X-Google-Smtp-Source: APXvYqyW7C9F4Fp13kmilM/0Tp6IXxWEIJxs/+rVeUuVpitLsYIvQ9gyfb71LuqgyjAuj4bqiYpGGQz85a/sf6WmEco=
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr128356wme.173.1561493496503;
 Tue, 25 Jun 2019 13:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <87v9wty9v4.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1906251824500.32342@nanos.tec.linutronix.de>
 <87lfxpy614.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87lfxpy614.fsf@oldenburg2.str.redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Jun 2019 13:11:25 -0700
X-Gmail-Original-Message-ID: <CALCETrVh1f5wJNMbMoVqY=bq-7G=uQ84BUkepf5RksA3vUopNQ@mail.gmail.com>
Message-ID: <CALCETrVh1f5wJNMbMoVqY=bq-7G=uQ84BUkepf5RksA3vUopNQ@mail.gmail.com>
Subject: Re: Detecting the availability of VSYSCALL
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-x86_64@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Carlos O'Donell" <carlos@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 25, 2019 at 9:39 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Thomas Gleixner:
>
> > On Tue, 25 Jun 2019, Florian Weimer wrote:
> >> We're trying to create portable binaries which use VSYSCALL on older
> >> kernels (to avoid performance regressions), but gracefully degrade to
> >> full system calls on kernels which do not have VSYSCALL support compiled
> >> in (or disabled at boot).
> >>
> >> For technical reasons, we cannot use vDSO fallback.  Trying vDSO first
> >> and only then use VSYSCALL is the way this has been tackled in the past,
> >> which is why this userspace ABI breakage goes generally unnoticed.  But
> >> we don't have a dynamic linker in our scenario.
> >
> > I'm not following. On newer kernels which usually have vsyscall disabled
> > you need to use real syscalls anyway, so why are you so worried about
> > performance on older kernels. That doesn't make sense.
>
> We want binaries that run fast on VSYSCALL kernels, but can fall back to
> full system calls on kernels that do not have them (instead of
> crashing).

Define "VSYSCALL kernels."  On any remotely recent kernel (*all* new
kernels and all kernels for the last several years that haven't
specifically requested vsyscall=native), using vsyscalls is much, much
slower than just doing syscalls.  I know a way you can tell whether
vsyscalls are fast, but it's unreliable, and I'm disinclined to
suggest it.  There are also at least two pending patch series that
will interfere.

>
> We could parse the vDSO and prefer the functions found there, but this
> is for the statically linked case.  We currently do not have a (minimal)
> dynamic loader there in that version of the code base, so that doesn't
> really work for us.

Is anything preventing you from adding a vDSO parser?  I wrote one
just for this type of use:

$ wc -l tools/testing/selftests/vDSO/parse_vdso.c
269 tools/testing/selftests/vDSO/parse_vdso.c

(289 lines includes quite a bit of comment.)


$ head -n8 tools/testing/selftests/vDSO/parse_vdso.c
/*
 * parse_vdso.c: Linux reference vDSO parser
 * Written by Andrew Lutomirski, 2011-2014.
 *
 * This code is meant to be linked in to various programs that run on Linux.
 * As such, it is available with as few restrictions as possible.  This file
 * is licensed under the Creative Commons Zero License, version 1.0,
 * available at http://creativecommons.org/publicdomain/zero/1.0/legalcode

If this license is too restrictive for you, I could probably be
convinced to relicense it, I'd be surprised :)  In hindsight, I kind
of wish I'd used MIT instead, since the Go runtime took advantage of
the CC0 license to import it without attribution *and* break it quite
badly in the process.

IMO the correct solution is to parse the vDSO and, if that fails, to
use plain syscalls as a fallback.  You should not ship anything that
uses a vsyscall under any circumstances, unless you need the last
ounce of performance on that one ancient version of OpenSuSE that
crashes if the vDSO is enabled.
