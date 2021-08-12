Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17163EA4C9
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 14:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbhHLMkz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 08:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbhHLMkz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 08:40:55 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DB2C061765
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 05:40:30 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id u7so6702918ilk.7
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 05:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4tFnmDotfjiugGBjHwlih+eCvFTo9osTBGTSMhZZSjM=;
        b=e8mnyfHB00C+2lPqhHfhe+xviUpvlLYBMpLxzjDsRRAt6Y9Js5I2vl5w4uNMNizdCU
         nmUDh2hzhZkko+FcJFz9H4WmIOxXjhRx1SGot+hF3CeeA64x/E1ERRx+hMwf1uqsxQIV
         cHlwc7DJ+iQhpbfnSThBSDh3211AiPnqacIWB+fBhSL/gODghtv8EPZQXrxzGQ1XqmcJ
         dO9DHSmMCOS0UW/Kj2vhIl8Hz87ZNA8dw4nxkVNc1Pp8AEN8bspwXCBtsicONTLXoc67
         6TdTXFLNjKHcsPcw/2SNIGhzJw405czYd6C8L5FL17BPSAzdW8m1pQNXtzCqNRRYiohj
         vzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4tFnmDotfjiugGBjHwlih+eCvFTo9osTBGTSMhZZSjM=;
        b=f8DPL20hbQL2dFTIXCU66qA892EJgMOpGBK81cLMXGfHqz0eTlQTp3YxjdrNY1HLNH
         aZMZMZl6oDegxe46ga1MdOfVAEw/NsiWKKULzf93M1QCi+H0k68z443v1Oi6F3lbwX+l
         dbIgObO3I0yw6dZI4UPZMANzCdJIz9JpITSdcgCnMY8HSgolNsfQuPxz8yVCp6oIUJOF
         01z9AsmgImUFTRRChQrebP5SOEsx2emGmkPaY+EXcFhk5eEyglYgLfYax4NyiRSuGbXa
         2RhmaOzd7wSpp1gxKu9/YjNbWuYqEa51eix6Y7FL37TcjwHqUV+749HDnj5hgeGvZof/
         FmMA==
X-Gm-Message-State: AOAM530DQud83ex5O3qyaPKa+DLj4Ppjnd1AZRHjhy9opAG1/uvd7eTh
        1OvgGM9zuu8bjzr7XkJo9gr6XHgY+YY43ooB0PI=
X-Google-Smtp-Source: ABdhPJyp1NIjEf84E2I/udUMRlgB6za29jqE912FulVYyeQxK/fsPWX7NqOPUZ+JQAwBKjMJOYOqnF8wVvj4pjiKYCk=
X-Received: by 2002:a92:d5d0:: with SMTP id d16mr2656274ilq.137.1628772029754;
 Thu, 12 Aug 2021 05:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-10-chenhuacai@loongson.cn> <87tul7r1nq.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87tul7r1nq.ffs@nanos.tec.linutronix.de>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 12 Aug 2021 20:40:18 +0800
Message-ID: <CAAhV-H6WC0s75pRuWRDfh=fn20jpy5+9qHzQosSFTmUAyaPYPg@mail.gmail.com>
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
Thanks, we are refactoring to use generic entry code.

Huacai
>
> Thanks,
>
>         tglx
>
>
