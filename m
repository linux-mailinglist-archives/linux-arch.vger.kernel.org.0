Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43B3BE215
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jul 2021 06:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbhGGEaK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Jul 2021 00:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGGEaK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jul 2021 00:30:10 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAD1C061574
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 21:27:30 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id o10so1044806ils.6
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 21:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7tTvfqKC5/i6mduLXUeFczFs23kjYTbx304GxmNqQk=;
        b=lJTISIPHDi0wmzj5oeL13MPCQIMdPKzvuxVPzn98QrlgG6oqsKEphK3ErkZX64Qn64
         A75x5IMzagT8qcJjBMsO9y9Yhl+rA+x5NQlcwwNTfbudoE7I+2tF2MVMJtvAZCzlYE+u
         xzeQwE/Llu3SCkTJODkRxSoBDDEf48vL4xiQvQAFY1NAcDVj4jH7l4oxd2C5XYgyR4so
         m0xAjHHRcEkpYVj89nzPphLVzq0cK1YforBgOGXvS4kVqerpwYTMg9g0FWqfrb231OeB
         ccawitw9CX5WpWB/EhMz5UDniMzwuo22omSekwzJQukwl1dlKH78CGFn4uCacbM7nent
         Catg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7tTvfqKC5/i6mduLXUeFczFs23kjYTbx304GxmNqQk=;
        b=TYkanllY3Kpa1IOpha5dynmeKmj3bwxZGALUbZOAXNSFZBrkzuZaV89uvn73eWQrRZ
         IuaHjUtVVvlWgd5PQpAPUzzJM+jd+U2R7GhwmBsYbqvb61no32grHBLziGQgAJDmkE4/
         jgZNczQiEYuUZhzlfASx75X0XFyOOA+23CVeqwTmQtpxbrJTmrAL6fUSKciPUb7evVrB
         pqn/CTJ79PBqJVkfXoYN4K8C2RF5igBYk59e7RwA3X9siK4GGJf5dg8PQYgiSTVaAEDO
         8xEmHqsiQaJzjP0zYoIe6d1JThhOsUCMm+OrzM0fKwHCn2IhWIexRgtpKUBkl8RhXeuV
         MklQ==
X-Gm-Message-State: AOAM531opHLJuMDddrRQxpHzKKTiuEl09tbvcivhOurPCPqm+Qq2LKd1
        +qna7HVEV07u4aE25E1uwzzqcJpM8VrV9f/CLU4=
X-Google-Smtp-Source: ABdhPJys56E6JLu7pT51obI7IACMXo6n8hTOjOw/Ko6WHk3uxl3d2qhUzaQ8cOlY6bh+uMjDYvQ+04k7jQH663AixpE=
X-Received: by 2002:a92:6509:: with SMTP id z9mr17074621ilb.184.1625632048603;
 Tue, 06 Jul 2021 21:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-10-chenhuacai@loongson.cn> <87tul7r1nq.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87tul7r1nq.ffs@nanos.tec.linutronix.de>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 7 Jul 2021 12:27:17 +0800
Message-ID: <CAAhV-H7QNQcPNniG3BJa-fA7JkoQjAAn9GzTWU_yvtmAM82pRg@mail.gmail.com>
Subject: Re: [PATCH 09/19] LoongArch: Add system call support
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Thomas,

On Tue, Jul 6, 2021 at 9:51 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Chen!
>
> On Tue, Jul 06 2021 at 12:18, Huacai Chen wrote:
> > +     li.d    t1, _TIF_WORK_SYSCALL_ENTRY
> > +     LONG_L  t0, tp, TI_FLAGS        # syscall tracing enabled?
> > +     and     t0, t1, t0
> > +     bnez    t0, syscall_trace_entry
> > +
> > +syscall_common:
> > +     /* Check to make sure we don't jump to a bogus syscall number. */
> > +     li.w    t0, __NR_syscalls
> > +     sub.d   t2, a7, t0
> > +     bgez    t2, illegal_syscall
> > +
> > +     /* Syscall number held in a7 */
> > +     slli.d  t0, a7, 3               # offset into table
> > +     la      t2, sys_call_table
> > +     add.d   t0, t2, t0
> > +     ld.d    t2, t0, 0               #syscall routine
> > +     beqz    t2, illegal_syscall
> > +
> > +     jalr    t2                      # Do The Real Thing (TM)
> > +
> > +     ld.d    t1, sp, PT_R11          # syscall number
> > +     addi.d  t1, t1, 1               # +1 for handle_signal
> > +     st.d    t1, sp, PT_R0           # save it for syscall restarting
> > +     st.d    v0, sp, PT_R4           # result
>
> Please do not add _again_ TIF handling in ASM. Please use the generic
> entry code infrastructure for this. It handles the complete set of TIF
> bits (if enabled in config) out of the box and it does so correctly.
OK, thanks, I will improve.

Huacai
>
> Thanks,
>
>         tglx
>
>
