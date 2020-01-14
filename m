Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D55F913A9B4
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 13:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgANMvP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 07:51:15 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39169 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANMvO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 07:51:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so12461651oty.6
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2020 04:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W+Q9dUTyz/K5v7vEopmSX1VV9yqJ2uEeGg7eL1QYRZQ=;
        b=H8ogLJT4KSppaj5v6wRd8cfh2U1RCnvS92Q/nL6sSdEKzYtxsF2axbVarPObfNgzHB
         KV0k8nT+ZtNnpeuC2hbj+BgpTHl8vNoEEuBgtnhWDEHEu1SKsXP4JgGNA83bXKIUdB59
         U6MboMqkQgaxVY84AdrSkvEsg1kBypKHrSFlv4QXpas64S1l9uxYKl9s0wRKtuuvoale
         I74WCTj3x2pCk479W3tLKKW3p5TfuhpDNJ8Mk0N82YX/wt8ZPwJcKIOeelgg9vihOEkx
         +YgeIrPu6icVC2A1thr//KRAx/mwDzZbANgDFTF4zW/rNZXmRtipvEziT7jz/spm41cN
         hVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W+Q9dUTyz/K5v7vEopmSX1VV9yqJ2uEeGg7eL1QYRZQ=;
        b=PbvU8FP13au+d2xb6rWs+2N8kAbE6zSNTnt+E2K42v3+uL0nRPKjHblreHT759vX6K
         ihnQcYIAXqfOw2MnqW3WavpugT8iOcKlHTOcYdG+xTg0fE7aHC8I03CdMXNGqXVxvNHA
         fwfL4KkWLXSQ8Mj1IFVv+opmz1ViV0/RpZAo5Q08ke5asns8Xv9r7jhSYnXD6inrI2Ah
         7muDYIuX3euhVnyZAyEVsD/i/J5fYK5XRBngV9/5aNzdTAT71y3o138SxDH6BXsIrcVt
         HP4beCrkH0ooq5CONEX9n2jl77V+0ON40L1sjFvjU+4DAV7DL6gGVvxrU9qX54m1v7nB
         Qoig==
X-Gm-Message-State: APjAAAVbcjxq8nIHNciA3puql2LhgXzzNc1nwh0yPl5s0VcTnGxBGeYn
        raIChBB4sOAhEHBJVnZ6uOJYaZ3vQ4DvRp0c+RsD2A==
X-Google-Smtp-Source: APXvYqylNPgxJbf6k9XLiMRwipsE+quarg452EJku62GGvY7X+XxjzhfC+1cwAX2swh6rwtuKCrMh49rOEIbTPnfTtE=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr16233506otg.2.1579006273570;
 Tue, 14 Jan 2020 04:51:13 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNOC2PYFsE_TK2SYmKcHxyG+2arWc8x_fmeWPOMi0+ot8g@mail.gmail.com>
 <53F6B915-AC53-41BB-BF32-33732515B3A0@lca.pw>
In-Reply-To: <53F6B915-AC53-41BB-BF32-33732515B3A0@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 14 Jan 2020 13:51:01 +0100
Message-ID: <CANpmjNMXD3Qzj748CXWtmenxx4cC3Q8Fr70L5PWNe6ZSARcZ9w@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer infrastructure
To:     Qian Cai <cai@lca.pw>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 14 Jan 2020 at 12:08, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Jan 6, 2020, at 7:47 AM, Marco Elver <elver@google.com> wrote:
> >
> > Thanks, I'll look into KCSAN + lockdep compatibility. It's probably
> > missing some KCSAN_SANITIZE :=3D n in some Makefile.
>
> Can I have a update on fixing this? It looks like more of a problem that =
kcsan_setup_watchpoint() will disable IRQs and then dive into the page allo=
cator where it would complain because it might sleep.

KCSAN does *not* keep IRQs disabled (we have a clear irqsave / restore
pair kcsan_setup_watchpoint).

If you look closer at the warning you sent in this thread, the warning
is not generated because IRQs are off when it wants to sleep, but
rather because IRQs are enabled but IRQ tracing state is inconsistent:
"DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)" in lockdep checks
that if IRQs are enabled, the trace state matches. These are only
checked with LOCKDEP_DEBUG and TRACE_IRQFLAGS.

In other words, IRQ trace flags got corrupted somewhere. AFAIK, this
problem here is only relevant with TRACE_IRQFLAGS -- again, it is
clear that IRQs are enabled but the IRQ tracing logic somehow ended up
corrupting hardirqs_enabled (TRACE_IRQFLAGS).

I believe this patch will take care of this issue:
http://lkml.kernel.org/r/20200114124919.11891-1-elver@google.com

Thanks,
-- Marco

> BTW, I saw Paul sent a pull request for 5.6 but it is ugly to have everyb=
ody could trigger a deadlock (sleep function called in atomic context) like=
 this during boot once this hits the mainline not to mention about only rec=
ently it is possible to test this feature (thanks to warning ratelimit) wit=
h the existing debugging options because it was unable to boot due to the b=
rokenness with debug_pagealloc as mentioned in this thread, so this does so=
unds like it needs more soak time for the mainline to me.
>
> 0000000000000400
> [   13.416814][    T1] Call Trace:
> [   13.416814][    T1]  lock_is_held_type+0x66/0x160
> [   13.416814][    T1]  ___might_sleep+0xc1/0x1d0
> [   13.416814][    T1]  __might_sleep+0x5b/0xa0
> [   13.416814][    T1]  slab_pre_alloc_hook+0x7b/0xa0
> [   13.416814][    T1]  __kmalloc_node+0x60/0x300
> [   13.416814   T1]  ? alloc_cpumask_var_node+0x44/0x70
> [   13.416814][    T1]  ? topology_phys_to_logical_die+0x7e/0x180
> [   13.416814][    T1]  alloc_cpumask_var_node+0x44/0x70
> [   13.416814][    T1]  zalloc_cpumask_var+0x2a/0x40
> [   13.416814][    T1]  native_smp_prepare_cpus+0x246/0x425
> [   13.416814][    T1]  kernel_init_freeable+0x1b8/0x496
> [   13.416814][    T1]  ? rest_init+0x381/0x381
> [   13.416814][    T1]  kernel_init+0x18/0x17f
> [   13.416814][    T1]  ? rest_init+0x381/0x381
> [   13.416814][    T1]  ret_from_fork+0x3a/0x50
> [   13.416814][    T1] irq event stamp: 910
> [   13.416814][    T1] hardirqs last  enabled at (909): [<ffffffff8d1240f=
3>] _raw_write_unlock_irqrestore+0x53/0x57
> [   13.416814][    T1] hardirqs last disabled at (910): [<ffffffff8c8bba7=
6>] kcsan_setup_watchpoint+0x96/0x460
> [   13.416814][    T1] softirqs last  enabled at (0): [<ffffffff8c6b697a>=
] copy_process+0x11fa/0x34f0
> [   13.416814][    T1] softirqs last disabled at (0): [<0000000000000000>=
] 0x0
> [   13.416814][    T1] ---[ end trace 7d1df66da055aa92 ]---
> [   13.416814][    T1] possible reason: unannotated irqs-on.
> [   13.416814][ent stamp: 910
> [   13.416814][    T1] hardirqs last  enabled at (909): [<ffffffff8d1240f=
3>] _raw_write_unlock_irqrestore+0x53/0x57
> [   13.416814][    T1] hardirqs last disabled at (910): [<ffffffff8c8bba7=
6>] kcsan_setup_watchpoint+0x96/0x460
> [   13.416814][    T1] softirqs last  enabled at (0): [<ffffffff8c6b697a>=
] copy_process+0x11fa/0x34f0
> [   13.416814][    T1] softirqs last disabled at (0): [<0000000000000000>=
] 0x0
