Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A08418984
	for <lists+linux-arch@lfdr.de>; Sun, 26 Sep 2021 16:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhIZOmq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Sep 2021 10:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhIZOmq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Sep 2021 10:42:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF5BC061570;
        Sun, 26 Sep 2021 07:41:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632667266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hvxujl/WR9NE4z9yR3CG2NsuD0b1CscqQ9FonpyX/t8=;
        b=tO78wZ3Oimkqfmo32SdwkVOF2u/4YvsMWW2EXJfAPODt9bSIgiRTcNErsZUgyFLIGVv/Cg
        Di1LV7baxeht89PKwwHXAbFVgWi5S4IPzVbrk5Z2i7HfxZJlm2ell/1R1y06Q+zSHs1T6m
        uE4gD1ECNgKECGHjZCQ8ip1ZtAnJLeEvg2bxcTIYTlgBMfjTQDg9fdZ49GPfsbCYaYUlOW
        xAs6yJth3Jvgt6Sqbfoap6j5qnvc1nHDaQmYbuUemVtsSqNsEXWUW8RoB0kRC4VAPNZJmp
        C4F+dcTMCSSeijZMlO4+mBM7HnIxNocVovtnxQAQByV9gLl7DVH+0x4Jc/NpDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632667266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hvxujl/WR9NE4z9yR3CG2NsuD0b1CscqQ9FonpyX/t8=;
        b=tdgMfNN+QcT4fi/5uor+BX9eFf6MqMfFfSFACxG9tQhS5/lYAY9zYIxJTeRg9vtexB8PPb
        F2lwNbzM65TLgfDQ==
To:     Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 11/13] x86/uintr: Introduce uintr_wait() syscall
In-Reply-To: <20210913200132.3396598-12-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-12-sohil.mehta@intel.com>
Date:   Sun, 26 Sep 2021 16:41:05 +0200
Message-ID: <874ka7csce.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
> Add a new system call to allow applications to block in the kernel and
> wait for user interrupts.
>
> <The current implementation doesn't support waking up from other
> blocking system calls like sleep(), read(), epoll(), etc.
>
> uintr_wait() is a placeholder syscall while we decide on that
> behaviour.>

Which behaviour? You cannot integrate this into [clock_]nanosleep() by
any means or wakeup something which is blocked in read(somefd) via
SENDUIPI.

What you can do is implement read() and poll() support for the
uintrfd. Anything else is just not going to fly.

Adding support for read/poll is pretty much a straight forward variant
of a correctly implemented wait()/wakeup() mechanism.

While poll()/read() support might be useful and poll() also provides a
timeout, having an explicit (timed) wait mechanism might be interesting.

But that brings me to an interesting question. There are two cases:

 1) The task installed a user space interrupt handler. Now it
    want's to play nice and yield the CPU while waiting.

    So it needs to reinstall the UINV vector on return to user and
    update UIRR, but that'd be covered by the existing mechanism. Fine.

 2) Task has no user space interrupt handler installed and just want's
    to use that wait mechanism.

    What is consuming the pending bit(s)? 

    If that's not a valid use case, then the wait has to check for that
    and reject the syscall with EINVAL.

    If it is valid, then how are the pending bits consumed and relayed to
    user space?

The same questions arise when you think about implementing poll/read
support simply because the regular poll/read semantics are:

  poll waits for the event and read consumes the event

which would be similar to #2 above, but with an installed user space
interrupt handler the return from the poll system call would consume the
event immediately (assumed that UIF is set).

Thanks,

        tglx
