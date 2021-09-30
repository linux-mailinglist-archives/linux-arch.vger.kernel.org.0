Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA4241E0AD
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353143AbhI3SKo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 14:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353049AbhI3SKn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Sep 2021 14:10:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07DE461164;
        Thu, 30 Sep 2021 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025340;
        bh=UPHwmzSJnwSsQoJLImFPmf4NodVlf1O6Qw5Hs01UYqQ=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=hC8Ng3dlwvmrP31QVc+9GLMXg7wS1lgS0k+KPnsGJPlEy+F0NYiocgYWcKJBA4ZkY
         eF3jc5FwTNBegmccHIcdJj3ENLMr4bMFvrbkQgAhdIZEwhJnGedkOOlvCOCX111lnD
         8OV/MfIKFNfzSEz8VzMv8VcdI4GZyX7RcPz5LUCvK7CpQrRfOfkHEy7GFFjPelIKdk
         Zaeo1zwltgL4+Ajcv2m7Bg0m7BpblzJwBPB662ViK2whPCkEbfL2+da5T/liGAcfh6
         XxCCgd56QqAjORyDFa4gNeiTnztdZXxnjnund73gwlfS/6O11Jjsafqhd80lrol2CB
         Ld2WqWgPh1TrQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 20DA227C0069;
        Thu, 30 Sep 2021 14:08:58 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Thu, 30 Sep 2021 14:08:58 -0400
X-ME-Sender: <xms:OP1VYZuyzp6dXkXnWR2Z2UXrOqrsB6s6wIiH8mjCxabMFbjlFTqACw>
    <xme:OP1VYSdqU6u1Kr4MEIUjgc5ejIx4YKEqqrLdtZeIydp1jG8EeCJ3hnndqC5KXmqAA
    pBj7e5bn9l3MTzpcl8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekgedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:OP1VYcyUN4l72fLEcAgjsVuN3ALE1Ra987UgARcTwQb4JPOYERUnZA>
    <xmx:OP1VYQMPTbWWilBqfNdZkecL2Z5y9dDp9LeoPfDV_PVlfDWc5j4-Yw>
    <xmx:OP1VYZ_aUxo2qNadv6a_JbcvclctcFCWXU8RfL8BCwtqJw6SFJACIg>
    <xmx:Ov1VYZ95M-qUafSQ-D-N7VbNN_YvGYuZoJhQo2ynqBXpqK-ckdbGzW2n7-g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BA6F621E0063; Thu, 30 Sep 2021 14:08:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1322-g921842b88a-fm-20210929.001-g921842b8
Mime-Version: 1.0
Message-Id: <fd54f257-fa02-4ec3-a81b-b5e60f24bf94@www.fastmail.com>
In-Reply-To: <c6e83d0e-6551-4e16-0822-0abbc4d656c4@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-12-sohil.mehta@intel.com>
 <f5a971e4-6b0d-477f-992c-89110a2ceb03@www.fastmail.com>
 <c6e83d0e-6551-4e16-0822-0abbc4d656c4@intel.com>
Date:   Thu, 30 Sep 2021 11:08:35 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Sohil Mehta" <sohil.mehta@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Cc:     "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
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

On Tue, Sep 28, 2021, at 9:56 PM, Sohil Mehta wrote:
> On 9/28/2021 8:30 PM, Andy Lutomirski wrote:
>> On Mon, Sep 13, 2021, at 1:01 PM, Sohil Mehta wrote:
>>> Add a new system call to allow applications to block in the kernel a=
nd
>>> wait for user interrupts.
>>>
>> ...
>>
>>> When the application makes this syscall the notification vector is
>>> switched to a new kernel vector. Any new SENDUIPI will invoke the ke=
rnel
>>> interrupt which is then used to wake up the process.
>> Any new SENDUIPI that happens to hit the target CPU's ucode at a time=
 when the kernel vector is enabled will deliver the interrupt.  Any new =
SENDUIPI that happens to hit the target CPU's ucode at a time when a dif=
ferent UIPI-using task is running will *not* deliver the interrupt, unle=
ss I'm missing some magic.  Which means that wakeups will be missed, whi=
ch I think makes this whole idea a nonstarter.
>>
>> Am I missing something?
>
>
> The current kernel implementation reserves 2 notification vectors (NV)=20
> for the 2 states of a thread (running vs blocked).
>
> NV-1 =E2=80=93 used only for tasks that are running. (results in a use=
r=20
> interrupt or a spurious kernel interrupt)
>
> NV-2 =E2=80=93 used only for a tasks that are blocked in the kernel. (=
always=20
> results in a kernel interrupt)
>
> The UPID.UINV bits are switched between NV-1 and NV-2 based on the sta=
te=20
> of the task.

Aha, cute.  So NV-1 is only sent if the target is directly paying attent=
ion and, assuming all the atomics are done right, NV-2 will be sent for =
tasks that are asleep.

Logically, I think these are the possible states for a receiving task:

1. Running.  SENDUIPI will actually deliver the event directly (or not i=
f uintr is masked).  If the task just stopped running and the atomics ar=
e right, then the schedule-out code can, I think, notice.

2. Not running, but either runnable or not currently waiting for uintr (=
e.g. blocked in an unrelated syscall).  This is straightforward -- no IP=
I or other action is needed other than setting the uintr-pending bit.

3. Blocked and waiting for uintr.  For this to work right, anyone trying=
 to send with SENDUIPI (or maybe a vdso or similar clever wrapper around=
 it) needs to result in either a fault or an IPI so the kernel can proce=
ss the wakeup.

(Note that, depending on how fancy we get with file descriptors and poll=
ing, we need to watch out for the running-and-also-waiting-for-kernel-no=
tification state.  That one will never work right.)

3 is the nasty case, and your patch makes it work with this NV-2 trick. =
 The trick is a bit gross for a couple reasons.  First, it conveys no us=
eful information to the kernel except that an unknown task did SENDUIPI =
and maybe that the target was most recently on a given CPU.  So a big li=
st search is needed.  Also, it hits an essentially arbitrary and possibl=
y completely innocent victim CPU and task, and people doing any sort of =
task isolation workload will strongly dislike this.  For some of those u=
sers, "strongly" may mean "treat system as completely failed, fail over =
to something else and call expensive tech support."  So we can't do that.

I think we have three choices:

Use a fancy wrapper around SENDUIPI.  This is probably a bad idea.

Treat the NV-2 as a real interrupt and honor affinity settings.  This wi=
ll be annoying and slow, I think, if it's even workable at all.

Handle this case with faults instead of interrupts.  We could set a rese=
rved bit in UPID so that SENDUIPI results in #GP, decode it, and process=
 it.  This puts the onus on the actual task causing trouble, which is ni=
ce, and it lets us find the UPID and target directly instead of walking =
all of them.  I don't know how well it would play with hypothetical futu=
re hardware-initiated uintrs, though.
