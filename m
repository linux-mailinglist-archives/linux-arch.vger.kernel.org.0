Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6B9387278
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 08:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbhERGpj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 02:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346822AbhERGpg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2021 02:45:36 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6065EC0613ED
        for <linux-arch@vger.kernel.org>; Mon, 17 May 2021 23:44:15 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id f184so8841166oig.3
        for <linux-arch@vger.kernel.org>; Mon, 17 May 2021 23:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bcn5fb5DZjb4YtyFgvoiwHqnuY6hbdNmIIbEt5dAaVo=;
        b=XDBwjWcK7W4iYUwj/u/gw3oqWIeA5hEElNrFlEm/M/WFUJONMDfGqLm0lYCC+OjVVz
         mBgaZXFe6JWlW8DEdYhnwpSSaIRw0JBMAxOW0eBVYiQFPbdWqcu54BOcbIVGfHSisc53
         0eyg+JwZ9Zva8VFoFU411tL9M2+QC38Hjni0baTANedHQf4FpzkVI0oa6ycvizeUlS3n
         5kPELVbFvsBKGkfPkPB8Sc/9Eg/h0xc520RY7bKeRNVQmlg8SXch0vnHz/n109DuhTYB
         8K9AfhJC/iujNgus17kDXKo/Uh34SKdrvrUQDCjtSEc9j/VfiBuN4vjJ0FXUFAU/LtOV
         +NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bcn5fb5DZjb4YtyFgvoiwHqnuY6hbdNmIIbEt5dAaVo=;
        b=heBPVp9fxcxt/KyXvxzK+8mpGKk22ICQCKRlaaFcTDSU+kPavZrC/cD50kbbIkqvEh
         IsVE/kgWq9SH59xVa6xgJ4AA7TB/Y/kyAbnV4QBp//p0ufGan1hvlNWutUTDQlP8jFvI
         gkb92+ZFYQ5YY8IgCI6Yrh5OtJ0br5bR0lFO1iWnXnSg+p0J75jPjSE6UBdQsb4j0qgb
         FcW7F+LEJ89rOn8rYL9Mp25uRhWSdAZQ6dGpjOwPPzaB1Uzg52wxXEmP5idU33Yl/CtJ
         +G7Uzi3idWiX/eD8N7cxQSw4qOKur0t9W/A3rGmUCZqP1dDyCZBugbrLm3nnIQWbcofl
         H9ug==
X-Gm-Message-State: AOAM531MGJDemhDt9TQFD/FnbJedr2laLc0RREkA2+48mo9D8s/CLlgd
        HmGmlrzSHOzX2c4itD6Qa2DJPUVxhjWDVVOh5SqTxA==
X-Google-Smtp-Source: ABdhPJyZJEKSXeod3K8VlVQioQOKfP1BRvVdjkXF95l+TeGhJwUZcia8n6Cqhfj41s9XfUXYiQJrlqfEJySBhCKYcEE=
X-Received: by 2002:a05:6808:144f:: with SMTP id x15mr2779174oiv.172.1621320254598;
 Mon, 17 May 2021 23:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1r1irpc5v.fsf@fess.ebiederm.org>
 <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
 <m1czuapjpx.fsf@fess.ebiederm.org> <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
 <m14kfjh8et.fsf_-_@fess.ebiederm.org> <m1tuni8ano.fsf_-_@fess.ebiederm.org>
 <m1a6ot5e2h.fsf_-_@fess.ebiederm.org> <CANpmjNM6rzyTp_+myecf8_773HLWDyJDbxFM6rWvzfKTLkXbhQ@mail.gmail.com>
 <m1lf8c4sc4.fsf@fess.ebiederm.org>
In-Reply-To: <m1lf8c4sc4.fsf@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 May 2021 08:44:03 +0200
Message-ID: <CANpmjNOcZkC3YDSK8rA7yagRNBLCxyNRcUSKNbx69sR9PSW-2w@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] siginfo: ABI fixes for TRAP_PERF
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

On Tue, 18 May 2021 at 05:47, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Marco Elver <elver@google.com> writes:
>
> > On Mon, 17 May 2021 at 21:58, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> During the merge window an issue with si_perf and the siginfo ABI came
> >> up.  The alpha and sparc siginfo structure layout had changed with the
> >> addition of SIGTRAP TRAP_PERF and the new field si_perf.
> >>
> >> The reason only alpha and sparc were affected is that they are the
> >> only architectures that use si_trapno.
> >>
> >> Looking deeper it was discovered that si_trapno is used for only
> >> a few select signals on alpha and sparc, and that none of the
> >> other _sigfault fields past si_addr are used at all.  Which means
> >> technically no regression on alpha and sparc.
> >>
> >> While the alignment concerns might be dismissed the abuse of
> >> si_errno by SIGTRAP TRAP_PERF does have the potential to cause
> >> regressions in existing userspace.
> >>
> >> While we still have time before userspace starts using and depending on
> >> the new definition siginfo for SIGTRAP TRAP_PERF this set of changes
> >> cleans up siginfo_t.
> >>
> >> - The si_trapno field is demoted from magic alpha and sparc status and
> >>   made an ordinary union member of the _sigfault member of siginfo_t.
> >>   Without moving it of course.
> >>
> >> - si_perf is replaced with si_perf_data and si_perf_type ending the
> >>   abuse of si_errno.
> >>
> >> - Unnecessary additions to signalfd_siginfo are removed.
> >>
> >> v3: https://lkml.kernel.org/r/m1tuni8ano.fsf_-_@fess.ebiederm.org
> >> v2: https://lkml.kernel.org/r/m14kfjh8et.fsf_-_@fess.ebiederm.org
> >> v1: https://lkml.kernel.org/r/m1zgxfs7zq.fsf_-_@fess.ebiederm.org
> >>
> >> This version drops the tests and fine grained handling of si_trapno
> >> on alpha and sparc (replaced assuming si_trapno is valid for
> >> all but the faults that defined different data).
> >
> > And just to clarify, the rest of the series (including static-asserts)
> > for the next merge-window will be sent once this series is all sorted,
> > correct?
>
> That is the plan.
>
> I really wonder about alphas use of si_trapno, and alphas use send_sig
> instead of force_sig.  It could be worth looking into those as it
> has the potential to simplify the code.
>
> >> Eric W. Biederman (5):
> >>       siginfo: Move si_trapno inside the union inside _si_fault
> >>       signal: Implement SIL_FAULT_TRAPNO
> >>       signal: Factor force_sig_perf out of perf_sigtrap
> >>       signal: Deliver all of the siginfo perf data in _perf
> >>       signalfd: Remove SIL_PERF_EVENT fields from signalfd_siginfo
> >
> > Looks good, thank you! I build-tested (defconfig -- x86_64, i386, arm,
> > arm64, m68k, sparc, alpha) this series together with a local patch to
> > pull in the static asserts from v3. Also re-ran perf_events kselftests
> > on x86_64 (native and 32bit compat).
>
> Thanks,
>
> Can I have your Tested-by?

Of course,

  Tested-by: Marco Elver <elver@google.com>

Thanks,
-- Marco
