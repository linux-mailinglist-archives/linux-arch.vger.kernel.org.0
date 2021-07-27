Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C3C3D795F
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 17:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhG0PIa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 11:08:30 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:41483 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbhG0PI3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 11:08:29 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mi2Bb-1mmQLV1s7F-00e8OD for <linux-arch@vger.kernel.org>; Tue, 27 Jul
 2021 17:08:28 +0200
Received: by mail-wr1-f49.google.com with SMTP id j2so15561318wrx.9
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 08:08:28 -0700 (PDT)
X-Gm-Message-State: AOAM532BeU+k8pPg+0ofs3q0AqbyZVWIopZ2U2+55thrO0rPT4wvslLz
        44RNCiCJL0/WksdmcTGiv0ZdFhjxDt+1VWKwsgU=
X-Google-Smtp-Source: ABdhPJzwT8T3JoluQ+evtJOnLOqMwzQ2C6EMJAz+Rjx3EpJ6fFRulio7XZ4JiJbH/xk8odtQjX+1wYy8lCFHJ3plgAY=
X-Received: by 2002:adf:f7c5:: with SMTP id a5mr6515222wrq.99.1627398507967;
 Tue, 27 Jul 2021 08:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-7-chenhuacai@loongson.cn> <YOQ5UBa0xYf7kAjg@hirez.programming.kicks-ass.net>
 <1625665981.7hbs7yesxx.astroid@bobo.none> <YQATv/MahhrKUu8Z@hirez.programming.kicks-ass.net>
In-Reply-To: <YQATv/MahhrKUu8Z@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Jul 2021 17:08:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1RduCKfRG34hf-Aia8n_2pThZ-s0D-m+qABMs2o3=bMw@mail.gmail.com>
Message-ID: <CAK8P3a1RduCKfRG34hf-Aia8n_2pThZ-s0D-m+qABMs2o3=bMw@mail.gmail.com>
Subject: Re: [PATCH 06/19] LoongArch: Add exception/interrupt handling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eUMLuHFwnEQgVB0wyQ3GRXMVH57CFQUNrpOWCwSj+2zhwDfwa3J
 rHNxMBngLo7tIU1svbPsYKgAWMwfqPRSDxKHUWmuyhGcV8x7VTuGSguztesIJUA5zC5HnyV
 DwKl46K5TNFmOhdqblj2D59CIfR+W6yJFtQ09KdOyjpHqIkRxtEM17y3RSWTgyFh/W+HJ8u
 /zX1ITjWuuKuw6fsFQkQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zJ7EtNI6UgM=:Bcoz12uqAi0kSrtElYNxqW
 fjFJT5sW4RyrI4LKjDJJG5inqFTcG52/xiyDyHR19jdUmgF6nmS1VxP7SHJ5qf+vu0wiCWaB8
 fHBODIYFYJZoh1bYXwfGGoj+CKi0tk619u4pRSuOAHlGJWJ+ZxjwxalaDotFCotx9FVcI/2Ob
 eS9ee96sPBEyAbhQAcTxdY7Vq6i3tjY2fwgOKxyQuTDpyEh+3c36Ktu+hyRCnJOKiduJYTHHx
 gg6aT/yCwk00d3RAUmQSBMAJEsOuTB8Y7l+FVCR8l6fKN25li21neHo8VL6h8RBFXFNVb1rFR
 Dy5jlsrX9oQR1hej/XgT4ChO0xyv1jFIF2VFIHLsHAa3yK6ETv1iyVCj8K+TmrJrm5PknXYZa
 9q8DvKHg6tlrFFcm2hqjVzx1Lpr+4ZNDtTBxMlsxUNUyN09K8YNMn+0JSc1oGw/loSi76Dn0/
 1dc2BD0gS8srr/8OBUf+9NU9Oo6oX6SMko4v/LjBhm1PHT20viS7FLzaFVM9/Z3VyVimcbUFc
 9bSAywSFwdLbK5/4dEtEznY/hVz4revCQL5S8bP+Pi0f+y6+0P33cl/e9Aj8rA7RnbGTRKIq0
 L3KaIpUB3+DijGVeZ1HPrMfkzXCT787fiz4GPYugI1KTPAhMYZcLo+yB8GrioPntjeiEbDhHq
 sKtnwFRHxXWdV7rAbcOF5lecGcUvoFLun/8aeNj6iCaGxfi4CqNZVn1qJYvOyNTbGb3eem7Ka
 0A9B9wiNlpkWbttPW0dI91/Qg1L5INB+JQz7vcYEHGSMfGnem3eqCeBsKWZf4geTGzEWBk5qE
 35zu7GUizPmUdr3/GAW1htXiWmtXGwdVWSGNy06PgYJU+naENajGq9TKzCJebbMUivwHj9u8+
 F0qGd0txpzqngBXOKZW8feezLT5lNbe+hlRxl4HY5mvPkPPWdAwflXpwSi9ZjGvdrgvtVtvFj
 zPjBJm7bKOpPbb66GTcZvj5ZZSlSnZzqllImAaJC96kURYBr6ua7f
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 4:10 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Jul 07, 2021 at 11:56:37PM +1000, Nicholas Piggin wrote:
> > >> +/*
> > >> + * Common Vectored Interrupt
> > >> + * Complete the register saves and invoke the do_vi() handler
> > >> + */
> > >> +SYM_FUNC_START(except_vec_vi_handler)
> > >> +  la      t1, __arch_cpu_idle
> > >> +  LONG_L  t0, sp, PT_EPC
> > >> +  /* 32 byte rollback region */
> > >> +  ori     t0, t0, 0x1f
> > >> +  xori    t0, t0, 0x1f
> > >> +  bne     t0, t1, 1f
> > >> +  LONG_S  t0, sp, PT_EPC
> > >
> > > Seriously, you're having your interrupt handler recover from the idle
> > > race? On a *new* architecture?
> >
> > It's heavily derived from MIPS (does that make the wholesale replacement
> > of arch/mips copyright headers a bit questionable?).
> >
> > I don't think it's such a bad trick though -- restartable sequences
> > before they were cool. It can let you save an irq disable in some
> > cases (depending on the arch of course).
>
> In this case you're making *every* interrupt slower. Simply adding a new
> idle instruction, one that can be called with interrupts disabled and
> will terminate on a pending interrupt, would've solved the issues much
> nicer and reclaimed the cycles spend on this restart trick.

Are we actually sure that loongarch /needs/ this version?

The code was clearly copied from the mips default r4k_wait()
function, but mips also has this one:

/*
 * This variant is preferable as it allows testing need_resched and going to
 * sleep depending on the outcome atomically.  Unfortunately the "It is
 * implementation-dependent whether the pipeline restarts when a non-enabled
 * interrupt is requested" restriction in the MIPS32/MIPS64 architecture makes
 * using this version a gamble.
 */
void __cpuidle r4k_wait_irqoff(void)
{
        if (!need_resched())
                __asm__(
                "       .set    push            \n"
                "       .set    arch=r4000      \n"
                "       wait                    \n"
                "       .set    pop             \n");
        raw_local_irq_enable();
}

        case CPU_LOONGSON64:
                if ((c->processor_id & (PRID_IMP_MASK | PRID_REV_MASK)) >=
                                (PRID_IMP_LOONGSON_64C |
PRID_REV_LOONGSON3A_R2_0) ||
                                (c->processor_id & PRID_IMP_MASK) ==
PRID_IMP_LOONGSON_64R)
                        cpu_wait = r4k_wait;
...
                cpu_wait = r4k_wait;
                if (read_c0_config7() & MIPS_CONF7_WII)
                        cpu_wait = r4k_wait_irqoff;
                if (cpu_has_mips_r6) {
                        cpu_wait = r4k_wait_irqoff;

So a lot of the newer mips variants already get the fixed
version. Maybe the hardware developers fixed it without telling
the kernel people about it?

         Arnd
