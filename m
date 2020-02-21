Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C20B168733
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 20:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgBUTFu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 14:05:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgBUTFu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 14:05:50 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A964E2467A
        for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2020 19:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582311949;
        bh=EUk3R/gMyLl1hXD5SfHRYQkTbuwsqyEOIo+TCyS6K9E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PU44+Eewl03OV5iiIV+9G/6+vfWvg1k28krJW1mHlv8q2DjPbe/mEz97KR8pFb9Ub
         h/qVJNVcIypuRDNAKp2CuvDkhoGRdE6Ys939cnPtsT9L1MlYNuWWg4Kn7FQslZIOaP
         9kBCOBGpA6+2rBuWMjFhmn4dZqk+di7JsFyEEYzE=
Received: by mail-wr1-f42.google.com with SMTP id z7so3192477wrl.13
        for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2020 11:05:49 -0800 (PST)
X-Gm-Message-State: APjAAAUVtD9M6+p4L3bMbQyb+4tz7WHcghrPiXEubDyT2hRVL0P6Tskk
        PFcNscLAeMnvNaQ4XlANfBRg0zc4Mm7mDJYwSSmc4Q==
X-Google-Smtp-Source: APXvYqwMoYkvcRLnGjPgfcSeF411c9uXNu2ry9pwq5gixLImSPcIGRSJov5Ai+0nwEhxIwUNn27Gxuh/motCSmpg8IQ=
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr22620055wrw.184.1582311948012;
 Fri, 21 Feb 2020 11:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20200221133416.777099322@infradead.org> <20200221134215.328642621@infradead.org>
In-Reply-To: <20200221134215.328642621@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 21 Feb 2020 11:05:36 -0800
X-Gmail-Original-Message-ID: <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
Message-ID: <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
Subject: Re: [PATCH v4 05/27] x86: Replace ist_enter() with nmi_enter()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 21, 2020 at 5:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> A few exceptions (like #DB and #BP) can happen at any location in the
> code, this then means that tracers should treat events from these
> exceptions as NMI-like. We could be holding locks with interrupts
> disabled for instance.
>
> Similarly, #MC is an actual NMI-like exception.
>

> -dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
> +dotraplinkage notrace void do_int3(struct pt_regs *regs, long error_code)
>  {
>         if (poke_int3_handler(regs))
>                 return;
>
> -       /*
> -        * Use ist_enter despite the fact that we don't use an IST stack.
> -        * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
> -        * mode or even during context tracking state changes.
> -        *
> -        * This means that we can't schedule.  That's okay.
> -        */
> -       ist_enter(regs);
> +       nmi_enter();

I agree with the change, but some commentary might be nice.  Maybe
copy from here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/idtentry&id=061eaa900b4f63601ab6381ab431fcef8dfd84be
