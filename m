Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7775F41E399
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 00:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245636AbhI3WDv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 18:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhI3WDv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Sep 2021 18:03:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E349619F5;
        Thu, 30 Sep 2021 22:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633039328;
        bh=2lX2HS9p7h6jVhzTp+A/c8lOWnTkxK3BWpjUhjVAspk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=DoX0OvxqWP+fcmhRSZwVxN4k+1r5YBC1wRi8pniTKlxH3tACBGX4+E1i+yVjntK4b
         0iWtOlCOdWHpEAn3J3bL3IlchzExStZ5E2auAtQpd7bF8WyG8bw7F2s0CP5APPTDTo
         0m3wwZ4U+BrL5+4//yR5l1VxJDd8Ti3ELWDMrfuGilQP4e0dGIJnOGwzhlTY69oB13
         GKVmw4+PEamDDsv1AIqh0mnH4w1g+7W4XlKyD2Nhyfyj0WgzXCXQ4sPK5MOl1pEJmZ
         18m+YIc09tm+G4oVB3Sbgh3Q3juJMrICckMfzuRVUFhaCWVruZDmxzvFPgnCsmIQnl
         GvnUP3JDGUo6A==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7EFF227C0054;
        Thu, 30 Sep 2021 18:02:05 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Thu, 30 Sep 2021 18:02:05 -0400
X-ME-Sender: <xms:3DNWYaN6K1HaFgb_J05zGYyqVXqKvabwgebyr9hUC3zkxxmR5abd0A>
    <xme:3DNWYY_F60-VbYshuls7MAekehK87YHGHNlkmGeWnPnYRdEN-weebXQPy2fnBJ6Jy
    6vsNvRtJcudxCxPADI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekhedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:3DNWYRTwFfTAJpG4EY22PYhz4Ert7EDfbqqBHhP062OWBRy-DPhS7A>
    <xmx:3DNWYaucXJL1-5aX6DTXwUEX22GUFqM4kXWPATyv0eLqtlXK-NbrDA>
    <xmx:3DNWYScbGHpLO9rw9OLb4tG1UdbOtsxmmxfSlE4BVR-pq3EMMKSTCQ>
    <xmx:3TNWYQepZXGaGAmyFThUoEUwUCXJSZAnoNPDtfxLIvGgtvb2FSw7GHDGSlc>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 689F621E0062; Thu, 30 Sep 2021 18:02:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1322-g921842b88a-fm-20210929.001-g921842b8
Mime-Version: 1.0
Message-Id: <b537a890-4b9f-462e-8c17-5c7aa9b60138@www.fastmail.com>
In-Reply-To: <877dex7tgj.ffs@tglx>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-12-sohil.mehta@intel.com>
 <f5a971e4-6b0d-477f-992c-89110a2ceb03@www.fastmail.com>
 <c6e83d0e-6551-4e16-0822-0abbc4d656c4@intel.com>
 <fd54f257-fa02-4ec3-a81b-b5e60f24bf94@www.fastmail.com> <877dex7tgj.ffs@tglx>
Date:   Thu, 30 Sep 2021 15:01:44 -0700
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



On Thu, Sep 30, 2021, at 12:29 PM, Thomas Gleixner wrote:
> On Thu, Sep 30 2021 at 11:08, Andy Lutomirski wrote:
>> On Tue, Sep 28, 2021, at 9:56 PM, Sohil Mehta wrote:
>> I think we have three choices:
>>
>> Use a fancy wrapper around SENDUIPI.  This is probably a bad idea.
>>
>> Treat the NV-2 as a real interrupt and honor affinity settings.  This
>> will be annoying and slow, I think, if it's even workable at all.
>
> We can make it a real interrupt in form of a per CPU interrupt, but
> affinity settings are not really feasible because the affinity is in t=
he
> UPID.ndst field. So, yes we can target it to some CPU, but that's racy.
>
>> Handle this case with faults instead of interrupts.  We could set a
>> reserved bit in UPID so that SENDUIPI results in #GP, decode it, and
>> process it.  This puts the onus on the actual task causing trouble,
>> which is nice, and it lets us find the UPID and target directly
>> instead of walking all of them.  I don't know how well it would play
>> with hypothetical future hardware-initiated uintrs, though.
>
> I thought about that as well and dismissed it due to the hardware
> initiated ones but thinking more about it, those need some translation
> unit (e.g. irq remapping) anyway, so it might be doable to catch those
> as well. So we could just ignore them for now and go for the #GP trick
> and deal with the device initiated ones later when they come around :)

Sounds good to me. In the long run, if Intel wants device initiated fanc=
y interrupts to work well, they need a new design.

>
> But even with that we still need to keep track of the armed ones per C=
PU
> so we can handle CPU hotunplug correctly. Sigh...

I don=E2=80=99t think any real work is needed. We will only ever have ar=
med UPIDs (with notification interrupts enabled) for running tasks, and =
hot-unplugged CPUs don=E2=80=99t have running tasks.  We do need a way t=
o drain pending IPIs before we offline a CPU, but that=E2=80=99s a separ=
ate problem and may be unsolvable for all I know. Is there a magic APIC =
operation to wait until all initiated IPIs targeting the local CPU arriv=
e?  I guess we can also just mask the notification vector so that it won=
=E2=80=99t crash us if we get a stale IPI after going offline.

>
> Thanks,
>
>         tglx
