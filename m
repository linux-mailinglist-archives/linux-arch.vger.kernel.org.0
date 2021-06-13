Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732583A5A6D
	for <lists+linux-arch@lfdr.de>; Sun, 13 Jun 2021 22:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhFMUuq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Jun 2021 16:50:46 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:46884 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhFMUup (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Jun 2021 16:50:45 -0400
Received: by mail-lf1-f48.google.com with SMTP id m21so17505568lfg.13
        for <linux-arch@vger.kernel.org>; Sun, 13 Jun 2021 13:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZqs6/zzv7XumFdUpj7gOd8uMbZ0+DuSivSIZIp9AxA=;
        b=Ed483c1uODNIoPgUXug7Mxr2cByHXxr+/YdlUGOMwiaTmFcnWwKszK4C6oc8P2iIVC
         lv/+Lt7jAA+K2JKknyXVp+r+H102+o20RuACnEruopjF0Acrdt7JMIBsNitbSda9gR+X
         FgSvv0YOG9XzjmGK/gCBODTjNG9OiWPCLjvzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZqs6/zzv7XumFdUpj7gOd8uMbZ0+DuSivSIZIp9AxA=;
        b=GFe9/bAI4xDjgxhht9w1yHI5xOitcL/p58grHjxqSr+P5bgUBaAAVAcS15cY4k+SLf
         OZKKlvgK+hiCG40x9c+bc3/+OEQ78hXcT2nWnzSA0UphF1JCmHk+9IPedswVn5TJaVGf
         pGTcoPBPOzsc+zgvLDYZns1PiZ+9Bfet1pxuAqoXd5fcUko5BORKt9VxL8OhUHLlnEp4
         8+e9UNP8RDJVszM6+0MoCg7icD+7wOBG1f2Qo2E27WuTWUFgWqgkxdUEQODEpCpwpuAO
         PJUcfkNaLCqc1Z4GEwkfvigN4umyoQm5dzs4Ua+hUtjucQgaGCS7tEKS4jXuHRzJtgHW
         8IRQ==
X-Gm-Message-State: AOAM531jwLJKAFTsPlmIjJroqyM4iJZKR0XtGIamO4BJtqcw8XVFbiU8
        spuFDNVoNJnSk1P5r8aPy3SzLPAWHJVRlULa
X-Google-Smtp-Source: ABdhPJzN7GA3mWo2Q9MoJ7MH/UMQ0+KezVmuUnFmZtIDfCeLDYi8EZURos+h2vQDju8rvwCRNZIaqA==
X-Received: by 2002:ac2:4294:: with SMTP id m20mr9806164lfh.6.1623617248812;
        Sun, 13 Jun 2021 13:47:28 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id m29sm1272842lfp.203.2021.06.13.13.47.28
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jun 2021 13:47:28 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 131so17265662ljj.3
        for <linux-arch@vger.kernel.org>; Sun, 13 Jun 2021 13:47:28 -0700 (PDT)
X-Received: by 2002:a2e:2ac6:: with SMTP id q189mr11049345ljq.61.1623617248057;
 Sun, 13 Jun 2021 13:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <87sg1p30a1.fsf@disp2133> <1623541098-6532-1-git-send-email-schmitzmic@gmail.com>
 <CAHk-=wi2KnsPbv2BOKHa+hb3CmyxsWRQBmSrzqzNezZ=vxH6bg@mail.gmail.com>
 <0a96ad37-dedb-67f3-3b27-1ff521c41083@gmail.com> <CAHk-=whO6fK4xCuEYDmDMVg_WKxP8cu429x7qjEO_k5sYVoMhg@mail.gmail.com>
In-Reply-To: <CAHk-=whO6fK4xCuEYDmDMVg_WKxP8cu429x7qjEO_k5sYVoMhg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Jun 2021 13:47:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgULNXEASR5aoPK2SxHR8O7mEhuBNPrTep+agx6MxhEhg@mail.gmail.com>
Message-ID: <CAHk-=wgULNXEASR5aoPK2SxHR8O7mEhuBNPrTep+agx6MxhEhg@mail.gmail.com>
Subject: Re: [PATCH v1] m68k: save extra registers on sys_exit and
 sys_exit_group syscall entry
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

On Sun, Jun 13, 2021 at 1:26 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> They'll probably be complete garbage without the fix.

Actually, never mind. My trivial gdb script is garbage.

I think that even with the fix, it will be fine. Because this test
will just use the regular system call entry tracing point - which gets
the thing right.

It's only PTRACE_EVENT_EXIT reporting that gets it wrong, not the
generic system call tracing case.

I'm not sure if/how you can get gdb to catch that PTRACE_EVENT_EXIT case.

Sorry for my inane noise.

                 Linus
