Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E5E381058
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 21:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhENTPh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 15:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhENTPf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2021 15:15:35 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4EBC06174A
        for <linux-arch@vger.kernel.org>; Fri, 14 May 2021 12:14:22 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s25so14390326ljo.11
        for <linux-arch@vger.kernel.org>; Fri, 14 May 2021 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHGE/SI1tO0CAdU9DspiMRu/IcggidAjeljmucgj+1U=;
        b=FHhNFP0HjOwmcUgJGOwZ/2fTGf6YloAj1IJt9cgCeCY5gct1ms0aePvfJ+p26Am9aT
         BgrkbekSovaMhMO5v4pdqS8eAlzBpMJLm9klgoPAMR35d4hkcz4CXmBtjJs+Fzkwi9i+
         rg2vQHNDh6q1olgYalhfdAxn+xT9pYxV7ONgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHGE/SI1tO0CAdU9DspiMRu/IcggidAjeljmucgj+1U=;
        b=J4n5XX08il7QTekLiZykxUtYWnYFL0USJLssTXxnPN9f2uGPh2n5okL5jhb5dfvI+c
         9MQ6vCKlVXeC1w+DlaMGnvfngtbe9J/pF8c2isMLkkc4QLCCI2xCQtO5RI3IOTS8SMez
         98iRaLByE9ZXzohCb0HQ3OwDy2EhzjziTuLUMxvnL+ABdwHOtOPKUsha7mf1cTyvyGZx
         gk0q/qsgrbLDk8178nxMSAKkkM32THBcrA8ISkCUZ2Zu3tt2aZhAp2WVzOa+WHSjnzSR
         5LainheExa2RzIRISC0ACBFLCwO+0YibDyW+3V62RauDxilOI/4CWGrdP833qcspdgOP
         FRLA==
X-Gm-Message-State: AOAM531RwnNNnR9N1kE3gNAQxZAzq9MqGLfx27QLM7/+Q2NiKloljKA5
        Z9AeQ6u+HvHzpYjlppnocxMP6ATRV1X2v6xNWJM=
X-Google-Smtp-Source: ABdhPJxFlFPYooVNo7RQFHrVg9O/K256fzQzAqrXH6zU09SvR+XWAafqt7i9tWNlRmOwcnHM287LXA==
X-Received: by 2002:a2e:858a:: with SMTP id b10mr22969195lji.310.1621019660579;
        Fri, 14 May 2021 12:14:20 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id b20sm893484lfp.308.2021.05.14.12.14.18
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 12:14:19 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id o8so8040822ljp.0
        for <linux-arch@vger.kernel.org>; Fri, 14 May 2021 12:14:18 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr38227020lji.465.1621019658636;
 Fri, 14 May 2021 12:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1r1irpc5v.fsf@fess.ebiederm.org>
 <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
 <m1czuapjpx.fsf@fess.ebiederm.org> <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
 <m14kfjh8et.fsf_-_@fess.ebiederm.org> <m1tuni8ano.fsf_-_@fess.ebiederm.org> <m1a6oxewym.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m1a6oxewym.fsf_-_@fess.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 May 2021 12:14:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikDD+gCUECg9NZAVSV6W_FUdyZFHzK4isfrwES_+sH-w@mail.gmail.com>
Message-ID: <CAHk-=wikDD+gCUECg9NZAVSV6W_FUdyZFHzK4isfrwES_+sH-w@mail.gmail.com>
Subject: Re: [GIT PULL] siginfo: ABI fixes for v5.13-rc2
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
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 13, 2021 at 9:55 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Please pull the for-v5.13-rc2 branch from the git tree:

I really don't like this tree.

The immediate cause for "no" is the silly

 #if IS_ENABLED(CONFIG_SPARC)

and

 #if IS_ENABLED(CONFIG_ALPHA)

code in kernel/signal.c. It has absolutely zero business being there,
when those architectures have a perfectly fine arch/*/kernel/signal.c
file where that code would make much more sense *WITHOUT* any odd
preprocessor games.

But there are other oddities too, like the new

    send_sig_fault_trapno(SIGFPE, si_code, (void __user *) regs->pc,
0, current);

in the alpha code, which fundamentally seems bogus: using
send_sig_fault_trapno() with a '0' for trapno seems entirely
incorrect, since the *ONLY* point of that function is to set si_trapno
to something non-zero.

So it would seem that a plain send_sig_fault() without that 0 would be
the right thing to do.

This also mixes in a lot of other stuff than just the fixes. Which
would have been ok during the merge window, but I'm definitely not
happy about it now.

             Linus
