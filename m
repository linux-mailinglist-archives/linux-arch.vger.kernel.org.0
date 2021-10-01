Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23B41E6E0
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 06:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351834AbhJAEqp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 00:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhJAEqp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Oct 2021 00:46:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A85CE61A51;
        Fri,  1 Oct 2021 04:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633063501;
        bh=nOYu6VGiA3i8vYIYqOGagXBTJt6u+kei0x1A8SWhhng=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=jmqBu5BQnMy1T7zlK97rr+koPVq4uGoHFILiPGTr9K1sdc7CftdKR5keb0V7sTYwC
         3O4ZSHI1jNhm8o6KHA8q7SQKALCsq+x6XDbzgNUvLuGHnaV3CkH5vx+6vk+vbqhBrO
         qtUihZTe+MoJ4djG8DuJqKSFh+qc6Nw+SkgxQ81LxPVPGmCkiUkoQ1qD3CMgXW4PWz
         tweNnIcf1hD42U/7i2VeX8sWz7qhSlyNK4XRQ/rVztjvouiN2eoY+Cr0YntkN6m+9e
         T2292+n5NMHvRayA0gzxSRrvKCzDCeodGfZ9yebyIXHW6VCeY00V3zL0lLT1NQjrMN
         HBD4E/lXFTpdA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id B1D1527C0054;
        Fri,  1 Oct 2021 00:44:58 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Fri, 01 Oct 2021 00:44:58 -0400
X-ME-Sender: <xms:SZJWYR8Kjjy-Jc37EChIePfsO6EbfeNurBOjUPTzVaKCV8BGMqwbow>
    <xme:SZJWYVtFHOSYPEtRJQ4k5ENHFHtJLyb-I1BXTQ6c-yejclt32h52HRJk3yTh1i_B8
    vVbknEvvGSjlnmPumQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekhedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:SZJWYfChnVfW8iJ4AigG65Z-baDxhyAzZIeCxHpThJEIIxv0fcGSag>
    <xmx:SZJWYVf_vpusaHcws_PBtSYwqd6siKlGgaTESgxTGUKViliAnzRkGw>
    <xmx:SZJWYWOmMvzuYQS1yeqzJQKoJXG6hB8Ry7-5XhSK2NBGiaePk6pJZg>
    <xmx:SpJWYdP-rS-7lLxBS0kLo8aL_JIMect6t0FXTbj9zMGM95ZVk2BH6TzsyN8>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C362021E0063; Fri,  1 Oct 2021 00:44:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1322-g921842b88a-fm-20210929.001-g921842b8
Mime-Version: 1.0
Message-Id: <25ba1e1f-c05b-4b67-b547-6b5dbc958a2f@www.fastmail.com>
In-Reply-To: <87tui162am.ffs@tglx>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-12-sohil.mehta@intel.com>
 <f5a971e4-6b0d-477f-992c-89110a2ceb03@www.fastmail.com>
 <c6e83d0e-6551-4e16-0822-0abbc4d656c4@intel.com>
 <fd54f257-fa02-4ec3-a81b-b5e60f24bf94@www.fastmail.com> <877dex7tgj.ffs@tglx>
 <b537a890-4b9f-462e-8c17-5c7aa9b60138@www.fastmail.com> <87tui162am.ffs@tglx>
Date:   Thu, 30 Sep 2021 21:41:52 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Cc:     "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, "Jens Axboe" <axboe@kernel.dk>,
        "Christian Brauner" <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Shuah Khan" <shuah@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Raj Ashok" <ashok.raj@intel.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        "Gayatri Kammela" <gayatri.kammela@intel.com>,
        "Zeng Guang" <guang.zeng@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Randy E Witt" <randy.e.witt@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Ramesh Thomas" <ramesh.thomas@intel.com>,
        "Linux API" <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 11/13] x86/uintr: Introduce uintr_wait() syscall
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Thu, Sep 30, 2021, at 5:01 PM, Thomas Gleixner wrote:
> On Thu, Sep 30 2021 at 15:01, Andy Lutomirski wrote:
>> On Thu, Sep 30, 2021, at 12:29 PM, Thomas Gleixner wrote:
>>>
>>> But even with that we still need to keep track of the armed ones per=
 CPU
>>> so we can handle CPU hotunplug correctly. Sigh...
>>
>> I don=E2=80=99t think any real work is needed. We will only ever have=
 armed
>> UPIDs (with notification interrupts enabled) for running tasks, and
>> hot-unplugged CPUs don=E2=80=99t have running tasks.
>
> That's not the problem. The problem is the wait for uintr case where t=
he
> task is obviously not running:
>
> CPU 1
>      upid =3D T1->upid;
>      upid->vector =3D UINTR_WAIT_VECTOR;
>      upid->ndst =3D local_apic_id();
>      ...
>      do {
>          ....
>          schedule();
>      }
>
> CPU 0
>     unplug CPU 1
>
>     SENDUPI(index)
>         // Hardware does:
>         tblentry =3D &ttable[index];
>         upid =3D tblentry->upid;
>         upid->pir |=3D tblentry->uv;
>         send_IPI(upid->vector, upid->ndst);
>
> So SENDUPI will send the IPI to the APIC ID provided by T1->upid.ndst
> which points to the offlined CPU 1 and therefore is obviously going to
> /dev/null. IOW, lost wakeup...

Yes, but I don't think this is how we should structure this.

CPU 1
 upid->vector =3D UINV;
 upid->ndst =3D local_apic_id()
 exit to usermode;
 return from usermode;
 ...

 schedule();
 fpu__save_crap [see below]:
   if (this task is waiting for a uintr) {
     upid->resv0 =3D 1;  /* arm #GP */
   } else {
     upid->sn =3D 1;
   }


>
>> We do need a way to drain pending IPIs before we offline a CPU, but
>> that=E2=80=99s a separate problem and may be unsolvable for all I kno=
w. Is
>> there a magic APIC operation to wait until all initiated IPIs
>> targeting the local CPU arrive?  I guess we can also just mask the
>> notification vector so that it won=E2=80=99t crash us if we get a sta=
le IPI
>> after going offline.
>
> All of this is solved already otherwise CPU hot unplug would explode in
> your face every time. The software IPI send side is carefully
> synchronized vs. hotplug (at least in theory). May I ask you politely =
to
> make yourself familiar with all that before touting "We do need..." ba=
sed
> on random assumptions?

I'm aware that the software send IPI side is synchronized against hotplu=
g.  But SENDUIPI is not unless we're going to have the CPU offline code =
IPI every other CPU to make sure that their SENDUIPIs have completed -- =
we don't control the SENDUIPI code.

After reading the ISE docs again, I think it might be possible to use th=
e ON bit to synchronize.  In the schedule-out path, if we discover that =
ON =3D 1, then there is an IPI in flight to us.  In theory, we could wai=
t for it, although actually doing so could be a mess.  That's why I'm as=
king whether there's a way to tell the APIC to literally wait for all IP=
Is that are *already sent* to be delivered.

>
> The above SENDUIPI vs. CPU hotplug scenario is the same problem as we
> have with regular device interrupts which are targeted at an outgoing
> CPU. We have magic mechanisms in place to handle that to the extent
> possible, but due to the insanity of X86 interrupt handling mechanics
> that still leaves a very tiny hole which might cause a lost and
> subsequently stale interrupt. Nothing we can fix in software.
>
> So on CPU offline the hotplug code walks through all device interrupts
> and checks whether they are targeted at the outgoing CPU. If so they a=
re
> rerouted to an online CPU with lots of care to make the possible race
> window as small as it gets. That's nowadays only a problem on systems
> where interrupt remapping is not available or disabled via commandline.
>
> For tasks which just have the user interrupt armed there is no problem
> because SENDUPI modifies UPID->PIR which is reevaluated when the task
> which got migrated to an online CPU is going back to user space.
>
> The uintr_wait() syscall creates the very same problem as we have with
> device interrupts. Which means we need to make that wait thing:
>
>      upid =3D T1->upid;
>      upid->vector =3D UINTR_WAIT_VECTOR;

This is exactly what I'm suggesting we *don't* do.  Instead we set a res=
erved bit, we decode SENDUIPI in the #GP handler, and we emulate, in-ker=
nel, the notification process for non-running tasks.

Now that I read the docs some more, I'm seriously concerned about this X=
SAVE design.  XSAVES with UINTR is destructive -- it clears UINV.  If we=
 actually use this, then the whole last_cpu "preserve the state in regis=
ters" optimization goes out the window.  So does anything that happens t=
o assume that merely saving the state doesn't destroy it on respectable =
modern CPUs  XRSTORS will #GP if you XRSTORS twice, which makes me nervo=
us and would need a serious audit of our XRSTORS paths.

This is gross.

--Andy
