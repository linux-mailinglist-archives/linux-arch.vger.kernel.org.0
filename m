Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765933AD10B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jun 2021 19:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhFRRU1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbhFRRU1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jun 2021 13:20:27 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B96C06175F
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 10:18:17 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m21so17786132lfg.13
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nBnuJCjQE+aAZPwJSd9bJXr2Ds6ZThaAzMpjQA51kUI=;
        b=F1P+lKociosdfPcWBId6Ys43KUatGPrylEYc2ZkgaQSaIwYVTH2vl+FTSZsWUNtS2S
         xCB0wytuIkmaIt/KIgw7pVq9/rGNTKHWukrdulsisjI9kiH2RhIFD/Maq8/t/3Zc/+yP
         OBhR+UrWjvPrDLgpXfflpIry4l57W+y+y6Jd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBnuJCjQE+aAZPwJSd9bJXr2Ds6ZThaAzMpjQA51kUI=;
        b=RoQHLwjgZmbJ0HKd9Dxwl7w7CzaQKg9SUlPLakVQ/OIHxR/HoF/6bpDNgM9+26X8T8
         DZxaBfPaQGD094sHAx81EihvMQJHWLvJ3aSVHXXu1csIUnk2ROpjBwbmXjIVeeIYKaKq
         tUjVXaKpV0bO229VCXFDR1r9l1j/Di2Upwzwyj9JprTBzTH0/QM5I+b5t6kIsVsH2der
         81LnNGvbtgQSxiA0UYXrB1qrPccpY9aaa1ZteLPjiFQdBFRRAb7PevGcB+VaP/3sbLVA
         jDqEq0bHGTg28fbGrC1z9vXa8QsiPwBJdW6iPgR8QwFGy/OZIlEn94Sf7yEv9A2+vq5v
         CmWw==
X-Gm-Message-State: AOAM531/LiYvoiMBW8cZ/wYgDXCjL3Ap6WAJbaDqUxnyOlKpsoM5Znp1
        l2EeVxJ2p2KrtK8z0nO3A1+V3IWzrOrqfYsg
X-Google-Smtp-Source: ABdhPJzy5p53WktnrubJ0sALlI8l7mT9NuA0LKTFFTJg/19jlrXe/KFJGN5pSqg1YeFgrWjkOG8dkA==
X-Received: by 2002:a19:c211:: with SMTP id l17mr3872915lfc.500.1624036694798;
        Fri, 18 Jun 2021 10:18:14 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id bi2sm1052300lfb.190.2021.06.18.10.18.14
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 10:18:14 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id k8so14897704lja.4
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 10:18:14 -0700 (PDT)
X-Received: by 2002:a2e:2ac6:: with SMTP id q189mr10211514ljq.61.1624036693648;
 Fri, 18 Jun 2021 10:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <1623979642-14983-1-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1623979642-14983-1-git-send-email-schmitzmic@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Jun 2021 10:17:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTKf6UFr6YneXsPU4=8dTs+eEX_861ugESTE3CmZtFUg@mail.gmail.com>
Message-ID: <CAHk-=whTKf6UFr6YneXsPU4=8dTs+eEX_861ugESTE3CmZtFUg@mail.gmail.com>
Subject: Re: [PATCH v2] m68k: save extra registers on more syscall entry points
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 17, 2021 at 6:27 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>
> I'd need specific test cases to exercise io_uring_setup in
> particular, to see whether stack offsets for pt_regs and the
> switch stack have been messed up.

I don't think doing this for io_uring_setup() will help any - the
problem is not in that system call thread itself, it's purely in the
kernel thread that it then starts.

And the fact that io_uring_setup() has the full stack frame won't then
help that kernel thread, for exactly the same reason that was true on
alpha: copy_thread() will actually _create_ the full stack, but when
we switch to it (through switch_to() -> resume()), the resume code in
arch/m68k/kernel/entry.S will switch to that stack, and then do
RESTORE_SWITCH_STACK which will consume it again.

So I think m68k should do the same thing as Eric's patch for alpha: do
the full stack for exit and exit_group, and for kernel thread creation
- or at least PF_IO_WORKER), do an extra stack frame on the kernel
stack, so that even after resume() we'll still have another copy of
the frame.

The alternative would be to do what x86 does: see __switch_to_asm().
Instead of doing that normal kernel entry/exit stack (with
SAVE_SWITCH_STACK and RESTORE_SWITCH_STACK), x86 has it's own very
special "only for task switching" stack frame thing, and leaves the
pt_regs etc entirely alone.

Of course, that "only for task switching" is _kind_of_ what the whole
SAVE_SWITCH_STACK is for - it's part of the name after all - but the
difference is that on alpha and m68k, it's also (and primarily) the
"full state" stack frame, used not just for task switching, but for
signal handling state and for ptrace too.

So in theory, it would be good to split this up:

 (a) have the signal handling and ptrace stack be one thing (maybe
rename the "SWITCH" part of the operations to something else, like
"EXTRA" or "SIGNAL" or whatever)

 (b) make a separate "for task switching only" stack frame, which is
used by that switch_to() -> resume() sequence, and that copy_thread()
has a "struct inactive_task_frame" thing for..

That way, the pt_regs/extra_regs stack frame that copy_thread()
creates wouldn't then be eaten up by the task switch.

But while that sounds like the right thing to do, it would be a rather
bigger change. I'm not entirely sure it's worth it.

Eric, comments?

                Linus
