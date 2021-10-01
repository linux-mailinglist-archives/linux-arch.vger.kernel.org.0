Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEAE41EA35
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 11:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353173AbhJAJ6Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 05:58:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56174 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbhJAJ6Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 05:58:24 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633082198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CFxsodexjhfZB65FOXMytBdxSP9PKLEBNzyjMVL79H8=;
        b=DeRObmKBnI3j7XLeb6GZBVvg9Jf9cV7sNpCT6y1ACt/8tLF6OIR54qFzoZqsPInjSv1gWG
        4XxN1ugyv11xsQVpKR7ayu8i9iJPIR2wZpd92Q3/VWi+vslyHkK5ClVlGJ9R0Jf1Y8qV1W
        K+uoYbHzz6eBVpVlvD1ulx1t89R99Fzf5NOPrPAHdOgc9p9qPJKlyBPef1AxNQAgrfZJjz
        fek2JVKRXHBvQyEsHHhScGwSy2pjbiJddS2ygmVZD+rsGWxznKK0Rj3rvxCYjvtcdUoths
        W3roNtQ8w/QHP+7pF6NswU+Y9ipuA8qN333Al1PWgzMlHA2A/j9O1W6iFEgw+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633082198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CFxsodexjhfZB65FOXMytBdxSP9PKLEBNzyjMVL79H8=;
        b=fVjMtyJpVOqK6xM9RsFPYDW8zZvCXWglBcFXBfiRR3ijLs3I834nM0vhX7sAV8LocY0b1F
        kOJy+o86fNfs7aBQ==
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
In-Reply-To: <25ba1e1f-c05b-4b67-b547-6b5dbc958a2f@www.fastmail.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-12-sohil.mehta@intel.com>
 <f5a971e4-6b0d-477f-992c-89110a2ceb03@www.fastmail.com>
 <c6e83d0e-6551-4e16-0822-0abbc4d656c4@intel.com>
 <fd54f257-fa02-4ec3-a81b-b5e60f24bf94@www.fastmail.com>
 <877dex7tgj.ffs@tglx>
 <b537a890-4b9f-462e-8c17-5c7aa9b60138@www.fastmail.com>
 <87tui162am.ffs@tglx>
 <25ba1e1f-c05b-4b67-b547-6b5dbc958a2f@www.fastmail.com>
Date:   Fri, 01 Oct 2021 11:56:38 +0200
Message-ID: <87pmsp5aqx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 30 2021 at 21:41, Andy Lutomirski wrote:
> On Thu, Sep 30, 2021, at 5:01 PM, Thomas Gleixner wrote:
>> All of this is solved already otherwise CPU hot unplug would explode in
>> your face every time. The software IPI send side is carefully
>> synchronized vs. hotplug (at least in theory). May I ask you politely to
>> make yourself familiar with all that before touting "We do need..." based
>> on random assumptions?
>
> I'm aware that the software send IPI side is synchronized against
> hotplug.  But SENDUIPI is not unless we're going to have the CPU
> offline code IPI every other CPU to make sure that their SENDUIPIs
> have completed -- we don't control the SENDUIPI code.

That's correct, but on CPU hot unplug _all_ running tasks have been
migrated to an online CPU _before_ the APIC is turned off. So they all
went through schedule() which set the UPID->SN bit. That's obviously
racy, but that has to be handled in exit to user mode anyway because
that's not different from any other migration or preemption. So that's
_not_ a problem at all.

The problem only exists if we can't do the #GP trick for tasks which are
sitting in uintr_wait(). Because then we _have_ to be careful vs. a
concurrent SENDUPI. But that'd be not any different from the problem
vs. device interrupts which we have today.

If we can use #GP then there is no problem at all and we avoid all the
nasty stuff vs. hotplug and avoid the list walk etc.

> After reading the ISE docs again, I think it might be possible to use
> the ON bit to synchronize.  In the schedule-out path, if we discover
> that ON = 1, then there is an IPI in flight to us.  In theory, we
> could wait for it, although actually doing so could be a mess.  That's
> why I'm asking whether there's a way to tell the APIC to literally
> wait for all IPIs that are *already sent* to be delivered.

You could busy poll with interrupts enabled, but that does not solve
anything. What guarantees that after APIC.IRR is clear no further IPI is
sent? Nothing at all. But again, that's not any different from device
interrupts and we already handle that today:

      cpu down()
      ...
      disable interrupts();
      for_each_interrupt_affine_to_cpu(irq) {
      	change_affinity_to_online_cpu(irq, new_target_cpu);
        // Did device send to the old vector?
        if (APIC.IRR & vector_bit(old_vector))
           send_IPI(new_target_cpu, new_vector);
      }

So for uintr_wait() w/o #GP we'd need to do:

      for_each_waiter_on_cpu(w) {
           move_waiter_to_new_target_cpu_wait_list(w);
           w->ndest = new_target_cpu;
           if (w->ON)
              send_IPI(new_target_cpu, UIWAIT_VECTOR);
      }

>> The uintr_wait() syscall creates the very same problem as we have with
>> device interrupts. Which means we need to make that wait thing:
>>
>>      upid = T1->upid;
>>      upid->vector = UINTR_WAIT_VECTOR;
>
> This is exactly what I'm suggesting we *don't* do.  Instead we set a
> reserved bit, we decode SENDUIPI in the #GP handler, and we emulate,
> in-kernel, the notification process for non-running tasks.

Yes, under the assumption that we can use #GP without breaking device
delivery.

> Now that I read the docs some more, I'm seriously concerned about this
> XSAVE design.  XSAVES with UINTR is destructive -- it clears UINV.  If
> we actually use this, then the whole last_cpu "preserve the state in
> registers" optimization goes out the window.  So does anything that
> happens to assume that merely saving the state doesn't destroy it on
> respectable modern CPUs XRSTORS will #GP if you XRSTORS twice, which
> makes me nervous and would need a serious audit of our XRSTORS paths.

I have no idea what you are fantasizing about. You can XRSTORS five
times in a row as long as your XSTATE memory image is correct.

If you don't want to use XSAVES to manage UINTR then you have to manualy
fiddle with the MSRs and UIF in schedule() and return to user space.

Also keeping UINV alive when scheduling out creates a life time issue
vs. UPID:

CPU 0   CPU 1                   CPU2
        T1 -> schedule         // UPID is live in UINTR MSRs
        do_stuff_in_kernel()
        local_irq_disable();
                                SENDUIPI(T1 -> CPU1)
pull T1
T1 exits
free UPID

        local_irq_enable();
        ucode handles UINV -> UAF

Clearing UINV prevents the ucode from handling the IPI and fiddling with
UPID. The CPU will forward the IPI vector to the kernel which acks it
and does nothing else, i.e. it's a spurious interrupt.

Coming back to state preserving. All what needs to be done for a
situation where the rest of the XSTATE is live in the registers, i.e.
the T -> kthread -> T scheduling scenario, is to restore UINV on exit to
user mode and handle UPID.PIR which might contain newly set bits which
are obviously not yet in UPID.IRR. That can be done by MSR fiddling or
by issuing an self IPI on the UINV vector which will be handled in ucode
on the first user space instruction after return.

When the FPU has to be restored then the state has to be updated in the
XSAVE memory image before doing XRSTORS.

Thanks,

        tglx




