Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F44A46040A
	for <lists+linux-arch@lfdr.de>; Sun, 28 Nov 2021 05:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345553AbhK1EvD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Nov 2021 23:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbhK1EtD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Nov 2021 23:49:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FAAC061574
        for <linux-arch@vger.kernel.org>; Sat, 27 Nov 2021 20:45:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0757A60C19
        for <linux-arch@vger.kernel.org>; Sun, 28 Nov 2021 04:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08485C004E1;
        Sun, 28 Nov 2021 04:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638074746;
        bh=ZbpWTxb1aglqpSe8DgXusNYOrzGJ91cJat6TKWD0/NE=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=NGe39pbvod0+dozPTBXxyZJPAAeNv8x7bgwkG49fg3LrNNdH/mTZ0q+U/huSYLz9s
         FsudwDjJV8S+AkHZKuQ4jrLb9PLnbMrO+z6p1nFWQ2QfBgK4NorbAfEqdXWRBRIaQT
         1PRvVPnJa5EIWdqo+w9JYLcYPfTUBwVqBpa9s7KyoXeZIPeFVm/xpl9lZeG+l0jneC
         4HfY2CSCD4/U6Jrlp0STeIKZWPxNTh9JKfQ00lGZInUs0/XOYjnv8SlYpk0UZSjr8H
         S3T6WxrRuG1CvqO6Ipjrr1N46VbJiAylX0Pjf7zOeiv1w/RzCr7PbCkICM+zGAapoc
         IvA5W60dakV9g==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id D07C227C0054;
        Sat, 27 Nov 2021 23:45:44 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Sat, 27 Nov 2021 23:45:44 -0500
X-ME-Sender: <xms:eAmjYQEdZ0-o8ofYtWheoLhWdYUeBi4cq039QwwgyP_-ZAgt1q9dTA>
    <xme:eAmjYZVb2FWUhFJgsw1zl5aj2GWzwrYDC3rAIsJuI93CIJ7ZAzK3u8n63vqMiSOyC
    g8_NAQwgMrnVjLF0S4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrheehgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpeeugfeufeevkeehvddtfffgkeelhefgkeehveetgeeikeegheeivdff
    gfejteduhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlhhuth
    hopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:eAmjYaI0I4rs5rHbyRnLI8xGlIJZtM1Jy8NGBM26prCVaHB4S3Nd7Q>
    <xmx:eAmjYSFhgrh2rmnQ0HRXd68c3SsZGgmCH9KSoaJuslBn4LNrGh7agw>
    <xmx:eAmjYWXFdhcSg2Wm4m1tOQHwgJuXERTCWl6GtFCd4J3hcfhKsln7pw>
    <xmx:eAmjYSQM5l3EmkmIFlvUYUtMCRrICQpynBAFeH3pchZosN1KSbpW08jN6Mg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2857421E006E; Sat, 27 Nov 2021 23:45:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <3b5fb404-7228-48d6-a290-9dd1d6095325@www.fastmail.com>
In-Reply-To: <878rxaik09.fsf@oldenburg.str.redhat.com>
References: <87h7bzjaer.fsf@oldenburg.str.redhat.com>
 <4728eeae-8f1b-4541-b05a-4a0f35a459f7@www.fastmail.com>
 <87lf1ais27.fsf@oldenburg.str.redhat.com>
 <9641b76e-9ae0-4c26-97b6-76ecde34f0ef@www.fastmail.com>
 <878rxaik09.fsf@oldenburg.str.redhat.com>
Date:   Sat, 27 Nov 2021 20:45:23 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Florian Weimer" <fweimer@redhat.com>
Cc:     linux-arch@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>,
        linux-x86_64@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, "the arch/x86 maintainers" <x86@kernel.org>,
        musl@lists.openwall.com,
        "Dave Hansen via Libc-alpha" <libc-alpha@sourceware.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH] x86: Implement arch_prctl(ARCH_VSYSCALL_LOCKOUT) to disable
 vsyscall
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 26, 2021, at 3:18 PM, Florian Weimer wrote:
> * Andy Lutomirski:
>
>> On Fri, Nov 26, 2021, at 12:24 PM, Florian Weimer wrote:
>>> * Andy Lutomirski:
>>>
>>>> On Fri, Nov 26, 2021, at 5:47 AM, Florian Weimer wrote:
>>>>> Distributions struggle with changing the default for vsyscall
>>>>> emulation because it is a clear break of userspace ABI, something
>>>>> that should not happen.
>>>>>
>>>>> The legacy vsyscall interface is supposed to be used by libcs only,
>>>>> not by applications.  This commit adds a new arch_prctl request,
>>>>> ARCH_VSYSCALL_LOCKOUT.  Newer libcs can adopt this request to sign=
al
>>>>> to the kernel that the process does not need vsyscall emulation.
>>>>> The kernel can then disable it for the remaining lifetime of the
>>>>> process.  Legacy libcs do not perform this call, so vsyscall remai=
ns
>>>>> enabled for them.  This approach should achieves backwards
>>>>> compatibility (perfect compatibility if the assumption that only l=
ibcs
>>>>> use vsyscall is accurate), and it provides full hardening for new
>>>>> binaries.
>>>>
>>>> Why is a lockout needed instead of just a toggle?  By the time an
>>>> attacker can issue prctls, an emulated vsyscall seems like a pretty
>>>> minor exploit technique.  And programs that load legacy modules or
>>>> instrument other programs might need to re-enable them.
>>>
>>> For glibc, I plan to add an environment variable to disable the lock=
out.
>>> There's no ELF markup that would allow us to do this during dlopen.
>>> (And after this change, you can run an old distribution in a chroot
>>> for legacy software, something that the userspace ABI break prevents=
.)
>>>
>>> If it can be disabled, people will definitely say, =E2=80=9Cwe get m=
ore complete
>>> hardening if we break old userspace=E2=80=9D.  I want to avoid that.=
  (People
>>> will say that anyway because there's this fairly large window of lib=
cs
>>> that don't use vsyscalls anymore, but have not been patched yet to do
>>> the lockout.)
>>
>> I=E2=80=99m having trouble following the logic. What I mean is that I=
 think it
>> should be possible to do the arch_prctl again to turn vsyscalls back
>> on.
>
> The =E2=80=9CBy the time an attacker can issue prctls=E2=80=9D argumen=
t does resonate
> with me, but I'm not the one who needs convincing.

Who else needs convincing?  It's your patch.

This could possibly be much more generic: have a mask of legacy features=
 to disable and a separate mask of lock bits.

>
> I can turn this into a toggle, and we could probably default our builds
> to vsyscalls=3Dxonly.  Given the userspace ABI impact, we'd still have=
 to
> upstream the toggle.  Do you see a chance of a patch a long these lines
> going in at all, given that it's an incomplete solution for
> vsyscall=3Demulate?

There is basically no reason for anyone to use vsyscall=3Demulate any mo=
re.  I'm aware of exactly one use case, and it's quite bizarre and invol=
ves instrumenting an outdated binary with an outdated instrumentation to=
ol.  If either one is recent (last few years), vsyscall=3Dxonly is fine.

>
>>> Maybe the lockout also simplifies the implementation?
>>>
>>>> Also, the interaction with emulate mode is somewhat complex. For no=
w,
>>>> let=E2=80=99s support this in xonly mode only. A complete implement=
ation will
>>>> require nontrivial mm work.  I had that implemented pre-KPTI, but K=
PTI
>>>> made it more complicated.
>>>
>>> I admit I only looked at the code in emulate_vsyscall.  It has code =
that
>>> seems to deal with faults not due to instruction fetch, and also che=
cks
>>> for vsyscall=3Demulate mode.  But it seems that we don't get to this=
 point
>>> for reads in vsyscall=3Demulate mode, presumably because the page is
>>> already mapped?
>>
>> Yes, and, with KPTI off, it=E2=80=99s nontrivial to unmap it. I have =
code for
>> this, but I=E2=80=99m not sure the complexity is worthwhile.
>
> Huh.  KPTI is the new thing, right?  Does it make things harder or not?
> I'm confused.
>
> If we knew at execve time that the new process image doesn't have
> vsyscall, would that be easier to set up?  vsyscall opt-out could be
> triggered by an ELF NOTE segment on the program interpreter (or main
> program if there isn't one).

Nah, it's a different issue.  The vsyscall mapping isn't a normal mappin=
g at all.  It's in the *kernel* address range, so it's not in the user p=
ortion of the page tables.  This means that, per mm, there is only the p=
gd entry that can be changed.  With kpti off, it can be fudged using the=
 U bit (hah!).  With kpti on, the same trick would work, but the whole p=
agetable arrangement is different, and the patch would need updating.

The patch looks a bit like this:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=
=3Dx86/vdso_permm&id=3D18432aa9942e8c36c3ba008d2908c246127d135c

except I screwed up and there's a bunch of irrelevant stuff in there. Bu=
t the patch would need updating for new kernels.  In any event, none of =
this is needed in xonly mode.

>
>>>> Finally, /proc/self/maps should be wired up via the gate_area code.
>>>
>>> Should the "[vsyscall]" string change to something else if execution=
 is
>>> disabled?
>>
>> I think the line should disappear entirely, just like booting with
>> vsyscall=3Dnone.
>
> Hmm.  But only for vsyscall=3Dxonly, right?  With vsyscall=3Demulate,
> reading at those addresses will still succeed.

IMO if vsyscall is disabled for a process, reads and executes should bot=
h fail.  This is trivial in xonly mode.

>
> Thanks,
> Florian
