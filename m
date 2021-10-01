Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C468841E536
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 02:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350682AbhJAADX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 20:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350449AbhJAADX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Sep 2021 20:03:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BE7C06176A;
        Thu, 30 Sep 2021 17:01:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633046498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reZvC+zig111N++qwoyjSrxAFznptqK/cxfWTq4SNT0=;
        b=U/dRdpVWQon/JeWYc0+VOsa72YDcU1ZnK5AqryXZ4iZRr8EXD6daX2dOAAF8Ego4AbGSw3
        GrviJYYREMwY2VnsmNTuQ/QsWNRTUnqbvicKqBoczMLQoeIs9wFGEzgbck/ZO6sMUZfIUN
        lCexXJFbcOhNwZBMsIXeRhXNLGPXSj4KE/8aLyjmJzN+5xbmQ/a+DMpvLGymR7EVRQjl7X
        k//P6dhlGGdCPPkG5WSXEiiEgU4Yrqoy6eX+wUMXbJk04b+YiTOWoHkqxj5RMiApQkSXiJ
        knRL6Vr4GCvFFD4JyiuW/6zx2Gzo2OH5DJEmmcfejZa+op7gLIMD9nNR/4JgUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633046498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reZvC+zig111N++qwoyjSrxAFznptqK/cxfWTq4SNT0=;
        b=T6AqJyxcZYrf9mAgU77sHOqod6Gwwdv4ZJ20r+XC++OYD06cjTdpdNMn2llDmzacc8cq5j
        Vs6TnklH2wfbokDg==
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
In-Reply-To: <b537a890-4b9f-462e-8c17-5c7aa9b60138@www.fastmail.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-12-sohil.mehta@intel.com>
 <f5a971e4-6b0d-477f-992c-89110a2ceb03@www.fastmail.com>
 <c6e83d0e-6551-4e16-0822-0abbc4d656c4@intel.com>
 <fd54f257-fa02-4ec3-a81b-b5e60f24bf94@www.fastmail.com>
 <877dex7tgj.ffs@tglx>
 <b537a890-4b9f-462e-8c17-5c7aa9b60138@www.fastmail.com>
Date:   Fri, 01 Oct 2021 02:01:37 +0200
Message-ID: <87tui162am.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 30 2021 at 15:01, Andy Lutomirski wrote:
> On Thu, Sep 30, 2021, at 12:29 PM, Thomas Gleixner wrote:
>>
>> But even with that we still need to keep track of the armed ones per CPU
>> so we can handle CPU hotunplug correctly. Sigh...
>
> I don=E2=80=99t think any real work is needed. We will only ever have arm=
ed
> UPIDs (with notification interrupts enabled) for running tasks, and
> hot-unplugged CPUs don=E2=80=99t have running tasks.

That's not the problem. The problem is the wait for uintr case where the
task is obviously not running:

CPU 1
     upid =3D T1->upid;
     upid->vector =3D UINTR_WAIT_VECTOR;
     upid->ndst =3D local_apic_id();
     ...
     do {
         ....
         schedule();
     }

CPU 0
    unplug CPU 1

    SENDUPI(index)
        // Hardware does:
        tblentry =3D &ttable[index];
        upid =3D tblentry->upid;
        upid->pir |=3D tblentry->uv;
        send_IPI(upid->vector, upid->ndst);

So SENDUPI will send the IPI to the APIC ID provided by T1->upid.ndst
which points to the offlined CPU 1 and therefore is obviously going to
/dev/null. IOW, lost wakeup...

> We do need a way to drain pending IPIs before we offline a CPU, but
> that=E2=80=99s a separate problem and may be unsolvable for all I know. Is
> there a magic APIC operation to wait until all initiated IPIs
> targeting the local CPU arrive?  I guess we can also just mask the
> notification vector so that it won=E2=80=99t crash us if we get a stale I=
PI
> after going offline.

All of this is solved already otherwise CPU hot unplug would explode in
your face every time. The software IPI send side is carefully
synchronized vs. hotplug (at least in theory). May I ask you politely to
make yourself familiar with all that before touting "We do need..." based
on random assumptions?

The above SENDUIPI vs. CPU hotplug scenario is the same problem as we
have with regular device interrupts which are targeted at an outgoing
CPU. We have magic mechanisms in place to handle that to the extent
possible, but due to the insanity of X86 interrupt handling mechanics
that still leaves a very tiny hole which might cause a lost and
subsequently stale interrupt. Nothing we can fix in software.

So on CPU offline the hotplug code walks through all device interrupts
and checks whether they are targeted at the outgoing CPU. If so they are
rerouted to an online CPU with lots of care to make the possible race
window as small as it gets. That's nowadays only a problem on systems
where interrupt remapping is not available or disabled via commandline.

For tasks which just have the user interrupt armed there is no problem
because SENDUPI modifies UPID->PIR which is reevaluated when the task
which got migrated to an online CPU is going back to user space.

The uintr_wait() syscall creates the very same problem as we have with
device interrupts. Which means we need to make that wait thing:

     upid =3D T1->upid;
     upid->vector =3D UINTR_WAIT_VECTOR;
     upid->ndst =3D local_apic_id();
     list_add(this_cpu_ptr(pcp_uintrs), upid->pcp_uintr);
     ...
     do {
         ....
         schedule();
     }
     list_del_init(upid->pcp_uintr);

and the hotplug code do:

    for_each_entry_safe(upid, this_cpu_ptr(pcp_uintrs), ...) {
       list_del(upid->pcp_uintr);
       upid->ndst =3D apic_id_of_random_online_cpu();
       if (do_magic_checks_whether_ipi_is_pending())
         send_ipi(upid->vector, upid->ndst);
    }

See?

We could map that to the interrupt subsystem by creating a virtual
interrupt domain for this, but that would make uintr_wait() look like
this:

     irq =3D uintr_alloc_irq();
     request_irq(irq, ......);
     upid =3D T1->upid;
     upid->vector =3D UINTR_WAIT_VECTOR;
     upid->ndst =3D local_apic_id();
     list_add(this_cpu_ptr(pcp_uintrs), upid->pcp_uintr);
     ...
     do {
         ....
         schedule();
     }
     list_del_init(upid->pcp_uintr);
     free_irq(irq);

But the benefit of that is dubious as it creates overhead on both sides
of the sleep and the only real purpose of the irq request would be to
handle CPU hotunplug without the above per CPU list mechanics.

Welcome to my wonderful world!

Thanks,

        tglx
