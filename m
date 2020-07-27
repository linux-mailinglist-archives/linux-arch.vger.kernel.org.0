Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C6A22FC44
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 00:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgG0WhQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 18:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0WhP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jul 2020 18:37:15 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65ED820838
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595889434;
        bh=ig2eFWtebb5krhRimaFOFglU/gPadPz2+D4MuQzehi0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ce9QCvm7qdVNO1DCGikjaMweLnWG0HxKHgni80DKOs0mTK2EHzPLjUsJdWsXZYvAf
         5ljqwEKHO5orfroW+PxIJcBme3rQivei9SX1NEQMyz3/w/GK+RYXqko2n0L75q8DV/
         6ZA+hUEep5QwxaRQx52Qi3nQszz1NPUsespNlJi8=
Received: by mail-wr1-f50.google.com with SMTP id r2so11301985wrs.8
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 15:37:14 -0700 (PDT)
X-Gm-Message-State: AOAM5312xrCMFy7pmIehSOGCK8ZkuTJDTyDhCxlM9n+RMc60DrfyzJmQ
        HC4XuiKUkVQDjDEK8I7bwoQpthEHBRb/hkXnPEEcLw==
X-Google-Smtp-Source: ABdhPJyQWDJOSdZGnBDNRiL/CWqe7NOM3kE1k8tBMXu40KTa4UcwEo3I1JJ3JySV2gSSFUVGD+5RXcqpzBqXsVFLNPc=
X-Received: by 2002:a5d:5712:: with SMTP id a18mr17603493wrv.184.1595889433016;
 Mon, 27 Jul 2020 15:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200721105706.030914876@linutronix.de> <20200721110808.562407874@linutronix.de>
In-Reply-To: <20200721110808.562407874@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 27 Jul 2020 15:37:01 -0700
X-Gmail-Original-Message-ID: <CALCETrVwrQ6oCxwEraxLF8ia8P8HUR2czrfqYtgQEdm8DM=RLQ@mail.gmail.com>
Message-ID: <CALCETrVwrQ6oCxwEraxLF8ia8P8HUR2czrfqYtgQEdm8DM=RLQ@mail.gmail.com>
Subject: Re: [patch V4 03/15] entry: Provide generic syscall exit function
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 4:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Like syscall entry all architectures have similar and pointlessly different
> code to handle pending work before returning from a syscall to user space.
>
>   1) One-time syscall exit work:
>       - rseq syscall exit
>       - audit
>       - syscall tracing
>       - tracehook (single stepping)
>
>   2) Preparatory work
>       - Exit to user mode loop (common TIF handling).
>       - Architecture specific one time work arch_exit_to_user_mode_prepare()
>       - Address limit and lockdep checks
>
>   3) Final transition (lockdep, tracing, context tracking, RCU). Invokes
>      arch_exit_to_user_mode() to handle e.g. speculation mitigations
>
> Provide a generic version based on the x86 code which has all the RCU and
> instrumentation protections right.
>
> Provide a variant for interrupt return to user mode as well which shares
> the above #2 and #3 work items.

I still don't love making the syscall exit path also do the
non-syscall stuff.  Do you like my suggestion of instead having a
generic function to do the syscall complete with all the entry and
exit stuff?

The singlestep handling is a mess.  I'm not convinced that x86 does
this sensibly.  Right now, I *think* we are quite likely to not send
SIGTRAP on the way out of syscalls if TF is set, and we'll actually
execute one more user instruction before sending the signal.  One
might reasonably debate whether this is a bug, but we should probably
figure it out at some point.

That latter bit is relevant to your patch because the fix might end up
being something like this:

void do_syscall_64(...)
{
  unsigned long orig_flags;
  idtentry_enter();
  instrumentation_begin();
  generic_do_syscall(regs, regs->orig_ax, AUDIT_ARCH_X86_64);
  if (unlikely(orig_flags & regs->flags & X86_EFLAGS_TF))
    raise SIGTRAP -- pretend we got #DB.
  instrumentation_end();
  idtentry_exit(); <-- signal is delivered here
}

That logic is probably all kinds of buggy, but the point is that the
special handling probably wants to be done between the generic syscall
code and the exit code.
