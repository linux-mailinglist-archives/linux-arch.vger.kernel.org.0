Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B5441F6EB
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 23:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhJAVaz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 17:30:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59858 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhJAVay (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 17:30:54 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633123748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xVh65H2Fp5ijtkJEhRPg4UVo19RUyKFUjPzFX2ov0uk=;
        b=y8YhK2p3xqDnbz3PXfLBx/isyD7z2c/RlgGuOoLzyg077RwbT+p6IINOBUH4bI+nh9tnfx
        vD1dWiFGoxqhYpBO12KbpPRVUJIvEwj9hfy7lUksnqd3HNIGYkTUbbxr1D+40jpdBL8Wdt
        ek6MpA1lv5vfxCGJHqjMVjreYEDQO55GDlO5q0cf62L1/uR03gILXZkFj/Rb/0mhUePTVC
        alts5PtCmS4ZGs1GMqXwynAQc0ZeQ8uNCPvh0Kx9cwU44ySemsmre0aPij/A4ZJrcRHUD/
        a13iBnIpLXaVWRXOZB6Ob4pVlB5iCBRUDTq8QzHbE7HNb/IzXNwhbuoNyOYCfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633123748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xVh65H2Fp5ijtkJEhRPg4UVo19RUyKFUjPzFX2ov0uk=;
        b=XO7TyMsBSh50qLM3BMaabrrwikLWLxoZtkPtuva7JEVZ4/1LK5CdQaUFP/YT1bQ7ZpN6zN
        GWbMV8jfecxCoeBQ==
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
In-Reply-To: <0364c572-4bc2-4538-8d65-485dbfa81f0d@www.fastmail.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-12-sohil.mehta@intel.com>
 <f5a971e4-6b0d-477f-992c-89110a2ceb03@www.fastmail.com>
 <c6e83d0e-6551-4e16-0822-0abbc4d656c4@intel.com>
 <fd54f257-fa02-4ec3-a81b-b5e60f24bf94@www.fastmail.com>
 <877dex7tgj.ffs@tglx>
 <b537a890-4b9f-462e-8c17-5c7aa9b60138@www.fastmail.com>
 <87tui162am.ffs@tglx>
 <25ba1e1f-c05b-4b67-b547-6b5dbc958a2f@www.fastmail.com>
 <87pmsp5aqx.ffs@tglx>
 <0364c572-4bc2-4538-8d65-485dbfa81f0d@www.fastmail.com>
Date:   Fri, 01 Oct 2021 23:29:07 +0200
Message-ID: <875yug4eos.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 01 2021 at 08:13, Andy Lutomirski wrote:

> On Fri, Oct 1, 2021, at 2:56 AM, Thomas Gleixner wrote:
>> On Thu, Sep 30 2021 at 21:41, Andy Lutomirski wrote:
>>> On Thu, Sep 30, 2021, at 5:01 PM, Thomas Gleixner wrote:
>>
>>> Now that I read the docs some more, I'm seriously concerned about this
>>> XSAVE design.  XSAVES with UINTR is destructive -- it clears UINV.  If
>>> we actually use this, then the whole last_cpu "preserve the state in
>>> registers" optimization goes out the window.  So does anything that
>>> happens to assume that merely saving the state doesn't destroy it on
>>> respectable modern CPUs XRSTORS will #GP if you XRSTORS twice, which
>>> makes me nervous and would need a serious audit of our XRSTORS paths.
>>
>> I have no idea what you are fantasizing about. You can XRSTORS five
>> times in a row as long as your XSTATE memory image is correct.
>
> I'm just reading TFM, which is some kind of dystopian fantasy.
>
> 11.8.2.4 XRSTORS
>
> Before restoring the user-interrupt state component, XRSTORS verifies
> that UINV is 0. If it is not, XRSTORS causes a general-protection
> fault (#GP) before loading any part of the user-interrupt state
> component. (UINV is IA32_UINTR_MISC[39:32]; XRSTORS does not check the
> contents of the remainder of that MSR.)

Duh. I was staring at the SDM and searching for a hint. Stupid me!

> So if UINV is set in the memory image and you XRSTORS five times in a
> row, the first one will work assuming UINV was zero.  The second one
> will #GP.

Yes. I can see what you mean now :)

> 11.8.2.3 XSAVES
> After saving the user-interrupt state component, XSAVES clears UINV. (UINV is IA32_UINTR_MISC[39:32];
> XSAVES does not modify the remainder of that MSR.)
>
> So if we're running a UPID-enabled user task and we switch to a kernel
> thread, we do XSAVES and UINV is cleared.  Then we switch back to the
> same task and don't do XRSTORS (or otherwise write IA32_UINTR_MISC)
> and UINV is still clear.

Yes, that has to be mopped up on the way to user space.

> And we had better clear UINV when running a kernel thread because the
> UPID might get freed or the kernel thread might do some CPL3
> shenanigans (via EFI, perhaps? I don't know if any firmwares actually
> do this).

Right. That's what happens already with the current pile.

> So all this seems to put UINV into the "independent" category of
> feature along with LBR.  And the 512-byte wastes from extra copies of
> the legacy area and the loss of the XMODIFIED optimization will just
> be collateral damage.

So we'd end up with two XSAVES on context switch. We can simply do:

        XSAVES();
        fpu.state.xtsate.uintr.uinv = 0;

which allows to do as many XRSTORS in a row as we want. Only the final
one on the way to user space will have to restore the real vector if the
register state is not valid:

       if (fpu_state_valid()) {
            if (needs_uinv(current)
               wrmsrl(UINV, vector);
       } else {
            if (needs_uinv(current)
               fpu.state.xtsate.uintr.uinv = vector;
            XRSTORS();
       }

Hmm?

Thanks,

        tglx
