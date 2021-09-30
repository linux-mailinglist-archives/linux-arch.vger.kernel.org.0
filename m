Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A73441E23F
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 21:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhI3TbU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 15:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhI3TbS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Sep 2021 15:31:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78994C06176A;
        Thu, 30 Sep 2021 12:29:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633030173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AIdCSYbm8ik7U+N6WK8d0kVM6bR1OsN7ZyYesBKBQCM=;
        b=LZSN5dm7wppSXaxVXLB/LjNGJetLP/IT5oWLaUEObCWihxjRDlRB9NJPIWatWaMwqQPx7W
        jw3rD5dj736d4lWN3WDUDiWguPq5kEfQUJIA3z8i+vUs+KkalFhtATH8fB+e7s1RCll0ZW
        KGuRUrl4h+GHw1eszR99Vihp01mPzvQuuyYaU/NJWoc6tv9sq8tibPBmrFKXTF20EXWSB3
        3cfUmk1RwpApIHHRclMAz+6gPLcRF0jit8LOn6QZLcnmBYZ17bXcwtIdI7DaGIXd9NQSpF
        m/yLUIV5hDHoWLvh7rEpd8env6CUg5v6LPHDYUbKEJPqF1c4flLqUYyRIaTA2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633030173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AIdCSYbm8ik7U+N6WK8d0kVM6bR1OsN7ZyYesBKBQCM=;
        b=rJPlIqbkUDGzGH6aIb23aL/mCDYZZ7u09DaDe2jY8HBzsD/KRAYer52sgY3urDo5GHIpt/
        axkXkL5JtfpUXjDA==
To:     Andy Lutomirski <luto@kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 11/13] x86/uintr: Introduce uintr_wait() syscall
In-Reply-To: <fd54f257-fa02-4ec3-a81b-b5e60f24bf94@www.fastmail.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-12-sohil.mehta@intel.com>
 <f5a971e4-6b0d-477f-992c-89110a2ceb03@www.fastmail.com>
 <c6e83d0e-6551-4e16-0822-0abbc4d656c4@intel.com>
 <fd54f257-fa02-4ec3-a81b-b5e60f24bf94@www.fastmail.com>
Date:   Thu, 30 Sep 2021 21:29:32 +0200
Message-ID: <877dex7tgj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 30 2021 at 11:08, Andy Lutomirski wrote:
> On Tue, Sep 28, 2021, at 9:56 PM, Sohil Mehta wrote:
> I think we have three choices:
>
> Use a fancy wrapper around SENDUIPI.  This is probably a bad idea.
>
> Treat the NV-2 as a real interrupt and honor affinity settings.  This
> will be annoying and slow, I think, if it's even workable at all.

We can make it a real interrupt in form of a per CPU interrupt, but
affinity settings are not really feasible because the affinity is in the
UPID.ndst field. So, yes we can target it to some CPU, but that's racy.

> Handle this case with faults instead of interrupts.  We could set a
> reserved bit in UPID so that SENDUIPI results in #GP, decode it, and
> process it.  This puts the onus on the actual task causing trouble,
> which is nice, and it lets us find the UPID and target directly
> instead of walking all of them.  I don't know how well it would play
> with hypothetical future hardware-initiated uintrs, though.

I thought about that as well and dismissed it due to the hardware
initiated ones but thinking more about it, those need some translation
unit (e.g. irq remapping) anyway, so it might be doable to catch those
as well. So we could just ignore them for now and go for the #GP trick
and deal with the device initiated ones later when they come around :)

But even with that we still need to keep track of the armed ones per CPU
so we can handle CPU hotunplug correctly. Sigh...

Thanks,

        tglx


