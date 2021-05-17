Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D734386BBC
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 22:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244539AbhEQUyx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 16:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244526AbhEQUyx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 May 2021 16:54:53 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCA5C061756
        for <linux-arch@vger.kernel.org>; Mon, 17 May 2021 13:53:32 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id j75so7696568oih.10
        for <linux-arch@vger.kernel.org>; Mon, 17 May 2021 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYiKNumB/sG3g6UoDTpwUaKhoLR3TJj2KrtveF22its=;
        b=E4IYESmDgLDJKTJfDF4vUoPzJf3sI7MEpeT+1/mAXEdTQsZpiuuMol/4F+vLlpLrIE
         sah8VFk6mwDiaNaEeoOzMK/Y6GiT3emWiXvBt3HP8YHmEZmkum/YGqd1Md+A1uvOpenb
         uAHx856RtWQ1SJrIHA/Cb42hLyw1yEAs1zEkG/KI9N7mAWFbOIVyKZ5V5irdXysHT9UW
         B0KlW/e/W866hpDt9/A9Rs93Aqhp8wNb73AI5+CVeIl5W51ZF4FsfNLPcj7xvUhSVLVP
         mMFLmI9uzK/wK0RHafAEZbf7zEXFb9f5nQ/5UtJlXGrumhfnXfSWF4OQIGZRyq620vbs
         6KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYiKNumB/sG3g6UoDTpwUaKhoLR3TJj2KrtveF22its=;
        b=UbQS3M05QXDJmkfgK2t1CLBjNjyvML97Fy6D/ssk5uS6izRIwhq/y/VHpb0qES8M5Q
         6zGGaZNmyKM7mIO3nuX/MekvEQOnLSxQtUIl4ndcYwB12ND9TW3IzbhQUSgLEcTBiioP
         kVQSi1OEkI0sLBjtQhfHejAdHtQpR79oDug8UhlzD2j30z0mFf7cIZZfs5FmzuSpN9h9
         EdV1iDFur8zKb5XEn7u+RdLbC2OOkQEkZLXzewJppZqESH8QznruxaOpkvSk/hrvuryf
         hmmWFmZSjMngB7ZmFZ8sAlG64o+vPD4gXz4uJTq4TA+KjFjSWS5dhvKTz08eKpQEn8hf
         pDdA==
X-Gm-Message-State: AOAM531iXol3QbcJyegKw4LHGg6Y/7xsAmAs/9ucm0RWwuVJhKJFqB8n
        N5QUYA4eAEsJNm7veiUvLKLXbcKZQYbX65yMXZZbhQ==
X-Google-Smtp-Source: ABdhPJydkSsTkVe66YjNSKFDH6L71UKujfw4XIMG1b/yqvx8GCOTa67p4xK47kkdF1AolTKy50FI6BZbal8CMHvsKAc=
X-Received: by 2002:a05:6808:f94:: with SMTP id o20mr1223000oiw.121.1621284811977;
 Mon, 17 May 2021 13:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1r1irpc5v.fsf@fess.ebiederm.org>
 <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
 <m1czuapjpx.fsf@fess.ebiederm.org> <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
 <m14kfjh8et.fsf_-_@fess.ebiederm.org> <m1tuni8ano.fsf_-_@fess.ebiederm.org> <m1a6ot5e2h.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m1a6ot5e2h.fsf_-_@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 17 May 2021 22:53:20 +0200
Message-ID: <CANpmjNM6rzyTp_+myecf8_773HLWDyJDbxFM6rWvzfKTLkXbhQ@mail.gmail.com>
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

On Mon, 17 May 2021 at 21:58, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> During the merge window an issue with si_perf and the siginfo ABI came
> up.  The alpha and sparc siginfo structure layout had changed with the
> addition of SIGTRAP TRAP_PERF and the new field si_perf.
>
> The reason only alpha and sparc were affected is that they are the
> only architectures that use si_trapno.
>
> Looking deeper it was discovered that si_trapno is used for only
> a few select signals on alpha and sparc, and that none of the
> other _sigfault fields past si_addr are used at all.  Which means
> technically no regression on alpha and sparc.
>
> While the alignment concerns might be dismissed the abuse of
> si_errno by SIGTRAP TRAP_PERF does have the potential to cause
> regressions in existing userspace.
>
> While we still have time before userspace starts using and depending on
> the new definition siginfo for SIGTRAP TRAP_PERF this set of changes
> cleans up siginfo_t.
>
> - The si_trapno field is demoted from magic alpha and sparc status and
>   made an ordinary union member of the _sigfault member of siginfo_t.
>   Without moving it of course.
>
> - si_perf is replaced with si_perf_data and si_perf_type ending the
>   abuse of si_errno.
>
> - Unnecessary additions to signalfd_siginfo are removed.
>
> v3: https://lkml.kernel.org/r/m1tuni8ano.fsf_-_@fess.ebiederm.org
> v2: https://lkml.kernel.org/r/m14kfjh8et.fsf_-_@fess.ebiederm.org
> v1: https://lkml.kernel.org/r/m1zgxfs7zq.fsf_-_@fess.ebiederm.org
>
> This version drops the tests and fine grained handling of si_trapno
> on alpha and sparc (replaced assuming si_trapno is valid for
> all but the faults that defined different data).

And just to clarify, the rest of the series (including static-asserts)
for the next merge-window will be sent once this series is all sorted,
correct?

> Eric W. Biederman (5):
>       siginfo: Move si_trapno inside the union inside _si_fault
>       signal: Implement SIL_FAULT_TRAPNO
>       signal: Factor force_sig_perf out of perf_sigtrap
>       signal: Deliver all of the siginfo perf data in _perf
>       signalfd: Remove SIL_PERF_EVENT fields from signalfd_siginfo

Looks good, thank you! I build-tested (defconfig -- x86_64, i386, arm,
arm64, m68k, sparc, alpha) this series together with a local patch to
pull in the static asserts from v3. Also re-ran perf_events kselftests
on x86_64 (native and 32bit compat).

Thanks,
-- Marco
