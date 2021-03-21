Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217C03430CA
	for <lists+linux-arch@lfdr.de>; Sun, 21 Mar 2021 04:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCUDuB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Mar 2021 23:50:01 -0400
Received: from [198.145.29.99] ([198.145.29.99]:48772 "EHLO mail.kernel.org"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhCUDtp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 20 Mar 2021 23:49:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6146A61927
        for <linux-arch@vger.kernel.org>; Sun, 21 Mar 2021 03:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616298526;
        bh=+8YE7y/YSZgHrNvzwVhgChZcApXUwgfjd8Riuw6hYcc=;
        h=From:Date:Subject:To:From;
        b=s4dfSmafrPTZcb/SrOJOtZyNCSs4yCAZXoBj2nW6bkqspGV1JqFXriw0XTN1SeJTr
         hp802iq3pePrSuWUUmXZ2384aUgvHxb1WoJHE1sHGt9/FXUq7tgRsMWYF6FDvwgVCw
         j4rt82dHErNxGFcowFalI6F52g8dK1P/zWc8Kd97OMV6DXi8PztryKbmZ6VSAmiAvH
         WGBVf6PZd5sBjzBTDjuUhVjR9FLJRFHEvQUduWAgcKAeJ0AmyIGXi76Y8YQTqgqZ0u
         lAqhsuvpfCPmIsfppYyHG3LcD4x9ZUTRqZ2OuKo0Kw6Y4a1ngqfY0sST3HZQsq+Wqn
         9uB4EOAAX2YnQ==
Received: by mail-ed1-f44.google.com with SMTP id bx7so15309942edb.12
        for <linux-arch@vger.kernel.org>; Sat, 20 Mar 2021 20:48:46 -0700 (PDT)
X-Gm-Message-State: AOAM532ke9CzK1qGq2Zb2AtmXIaqLE0RYBbjvzxmUj82Rf49qKfUf2Bt
        moH6yyPEFrpVcDGLiIZ8hvm1eRrWkFVc6legkRd2lw==
X-Google-Smtp-Source: ABdhPJxdBic9TpvbjrDK9gci5p/l6RzjCDIrJZmR2Gdzn1E5tLqLPAgdkqXOqNIolK04Cx88Tz6VqT9BVO7Wv0W1y74=
X-Received: by 2002:aa7:c353:: with SMTP id j19mr18340895edr.263.1616298524972;
 Sat, 20 Mar 2021 20:48:44 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 20 Mar 2021 20:48:34 -0700
X-Gmail-Original-Message-ID: <CALCETrUx10uHeD7bckVjL9x7S3LEdH3ZfzUbCMWj9j-=nYp8Wg@mail.gmail.com>
Message-ID: <CALCETrUx10uHeD7bckVjL9x7S3LEdH3ZfzUbCMWj9j-=nYp8Wg@mail.gmail.com>
Subject: Is s390's new generic-using syscall code actually correct?
To:     Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all-

I'm working on my kentry patchset, and I encountered:

commit 56e62a73702836017564eaacd5212e4d0fa1c01d
Author: Sven Schnelle <svens@linux.ibm.com>
Date:   Sat Nov 21 11:14:56 2020 +0100

    s390: convert to generic entry

As part of this work, I was cleaning up the generic syscall helpers,
and I encountered the goodies in do_syscall() and __do_syscall().

I'm trying to wrap my head around the current code, and I'm rather confused.

1. syscall_exit_to_user_mode_work() does *all* the exit work, not just
the syscall exit work.  So a do_syscall() that gets called twice will
do the loopy part of the exit work (e.g. signal handling) twice.  Is
this intentional?  If so, why?

2. I don't understand how this PIF_SYSCALL_RESTART thing is supposed
to work.  Looking at the code in Linus' tree, if a signal is pending
and a syscall returns -ERESTARTSYS, the syscall will return back to
do_syscall().  The work (as in (1)) gets run, calling do_signal(),
which will notice -ERESTARTSYS and set PIF_SYSCALL_RESTART.
Presumably it will also push the signal frame onto the stack and aim
the return address at the svc instruction mentioned in the commit
message from "s390: convert to generic entry".  Then __do_syscall()
will turn interrupts back on and loop right back into do_syscall().
That seems incorrect.

Can you enlighten me?  My WIP tree is here:
https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/kentry

Here are my changes to s390, and I don't think they're really correct:


https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/diff/arch/s390/kernel/syscall.c?h=x86/kentry&id=58a459922be0fb8e0f17aeaebcb0ac8d0575a62c
