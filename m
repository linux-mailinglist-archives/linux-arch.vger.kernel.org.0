Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1174188AC
	for <lists+linux-arch@lfdr.de>; Sun, 26 Sep 2021 14:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhIZMlE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Sep 2021 08:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhIZMlD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Sep 2021 08:41:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31518C061570;
        Sun, 26 Sep 2021 05:39:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632659964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U74WvCkkjAYn1Lqyj3MdmStl8ZJ3w7VQiPNn2eEwgCk=;
        b=B6ENbnHHrOGNDqrUqttxTvR1RRnxMj2PdTWBp+UJLYr0KZZlp77MPoTznUWkW4psQ/vrRV
        HlDl3CJ+wv5aAAktUatkPjANE90bM52uVmAON/9XeW9G439W9zKONtaazZaDkJmnL0TiR6
        1NY4/Ej1ty4Q/gnj8w+LS/Cvtokir5i7Znk66DTD+1ev7KvHDISbFxUnAcjYrBgbQfvpV4
        MuhRbvmrr3rvoovhOtLAucfhac/3eHkHiILz6Qr1F6e86BgdFJ799qaRYWjZ5TNh69LqWd
        uGIwI0OwGGT9YnK+vcQ/EPQ0HZixT2W23z/WBuVQVHs+g08TsyopY7J9RrHDwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632659964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U74WvCkkjAYn1Lqyj3MdmStl8ZJ3w7VQiPNn2eEwgCk=;
        b=B0bQ8F0X/Ip7qIjEtWtHReu+oqcMgcYeyrBg51UpkYOdX3QWD2erAKcAxtizTbXi6+z33o
        gT5mbiMFxfK0C9AQ==
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
Subject: Re: [RFC PATCH 05/13] x86/irq: Reserve a user IPI notification vector
In-Reply-To: <878rzkeq9f.ffs@tglx>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-6-sohil.mehta@intel.com> <87fstugabg.ffs@tglx>
 <878rzkeq9f.ffs@tglx>
Date:   Sun, 26 Sep 2021 14:39:23 +0200
Message-ID: <87bl4fcxz8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 25 2021 at 15:30, Thomas Gleixner wrote:
> On Fri, Sep 24 2021 at 01:07, Thomas Gleixner wrote:
> The obvious question is: What is the value of clearing UINV?
>
> Absolutely none. That notification vector cannot be used for anything
> else, so why would the OS be interested to see it ever? This is about
> user space interupts, right?
>
> UINV should be set _ONCE_ when CR4.UINTR is enabled and not be touched
> by XSAVES/XRSTORS at all. Any delivery of this vector to the OS should
> be considered a hardware bug.

After decoding the documentation (sigh) and staring at the implications of
keeping UINV armed, I can see the point vs. the UPID lifetime issue when
a task gets scheduled out and migrated to a different CPU.

Not the most pretty solution, but as there needs to be some invalidation
which needs to be undone on return to user space it probably does not
matter much. 

As the whole thing is tightly coupled to XSAVES/RSTORS we need to
integrate it into that machinery and not pretend that it's something
half independent.

That means we have to handle the setting of the SN bit in UPID whenever
XSTATE is saved either during context switch, when the kernel uses the
FPU or in other places (signals, fpu_clone ...). They all end up in
save_fpregs_to_fpstate() so that might be the place to look at.

While talking about that: fpu_clone() has to invalidate the UINTR state
in the clone's xstate after the memcpy() or xsaves() operation.

Also the restore portion on the way back to user space has to be coupled
more tightly:

arch_exit_to_user_mode_prepare()
{
        ...
        if (unlikely(ti_work & _TIF_UPID))
        	uintr_restore_upid(ti_work & _TIF_NEED_FPU_LOAD);
        if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
        	switch_fpu_return();
}

upid_set_ndst(upid)
{
	apicid = __this_cpu_read(x86_cpu_to_apicid);

        if (x2apic_enabled())
            upid->ndst.x2apic = apicid;
        else
            upid->ndst.apic = apicid;
}

uintr_restore_upid(bool xrstors_pending)
{
        clear_thread_flag(TIF_UPID);
        
	// Update destination
        upid_set_ndst(upid);

        // Do we need something stronger here?
        barrier();

        clear_bit(SN, upid->status);

        // Any SENDUIPI after this point sends to this CPU
           
        // Any bit which was set in upid->pir after SN was set
        // and/or UINV was cleared by XSAVES up to the point
        // where SN was cleared above is not reflected in UIRR.

	// As this runs with interrupts disabled the current state
        // of upid->pir can be read and used for restore. A SENDUIPI
        // which sets a bit in upid->pir after that read will send
        // the notification vector which is going to be handled once
        // the task reenables interrupts on return to user space.
        // If the SENDUIPI set the bit before the read then the
        // notification vector handling will just observe the same
        // PIR state.

        // Needs to be a locked access as there might be a
        // concurrent SENDUIPI modiying it.
        pir = read_locked(upid->pir);

        if (xrstors_pending)) {
        	// Update the saved xstate for xrstors
           	current->xstate.uintr.uinv = UINTR_NOTIFICATION_VECTOR;
                current->xstate.uintr.uirr = pir;
        } else {
                // Manually restore UIRR and UINV
                wrmsrl(IA32_UINTR_RR, pir);

	        misc.val64 = 0;
                misc.uittsz = current->uintr->uittsz;
                misc.uinv = UINTR_NOTIFICATION_VECTOR;
                wrmsrl(IA32_UINTR_MISC, misc.val64);
        }
}

That's how I deciphered the documentation and I don't think this is far
from reality, but I might be wrong as usual.

Hmm?

Thanks,

        tglx
