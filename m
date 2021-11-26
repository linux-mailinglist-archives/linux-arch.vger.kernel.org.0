Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28545F6FF
	for <lists+linux-arch@lfdr.de>; Fri, 26 Nov 2021 23:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbhKZW7Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Nov 2021 17:59:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56096 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbhKZW5Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Nov 2021 17:57:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98297B82934
        for <linux-arch@vger.kernel.org>; Fri, 26 Nov 2021 22:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C783EC004E1;
        Fri, 26 Nov 2021 22:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637967249;
        bh=wgwhl0vthk1SYT38pOOpBGqWhn49l+32PRqKIAXu8do=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=hgwtoUsgAaIdQubAGtcox5fizWr49Wxlahb8cpxW7M3PbZ3qg3gEWcuFl4fZS9KiO
         ZgkXFf38f29S2xBYJF7jlIzMuS5awdZbMxVATe37UDOPeoZ1sBQW0t6gzqqDRpFHB7
         iIXJNXHBKqkmrCXilL8svUsleT+O/uEIWgpcd1KPgP5p0b9/uRAwyAJEj1tnPEQ9gR
         Uc9ysbUIKYG6P97fBYeEGsxWN10h9Eg41XAxM5AmxJS/Z8GGIERZYgQ9QIhWiSSd4Y
         xL8CX+D3F+rnTZYyRuAKmIZCen5VidM7LKtTM5kZHP8Gdc7V1rBytQIBRpYuaSoVZn
         tfbqIt47rXQgg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8F1A527C0054;
        Fri, 26 Nov 2021 17:54:07 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Fri, 26 Nov 2021 17:54:07 -0500
X-ME-Sender: <xms:jmWhYSENwGPexJOxq3abZliNmtNm8sB3DT3cjG0D6uJmF-RSRxpbdQ>
    <xme:jmWhYTVZ8wSVNZqgj6qzpeLm3toD6zkvTfBzYcvVlz0Vh9_TtUNru2GFAIhm5JcXF
    ULXk4OBy6HksnrdftI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrheefgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieevieeu
    feevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:jmWhYcLx_ufKSwyrMjBwe_0tSFDnW5WXCvx1aDQX_d0e0qv3GrjhSA>
    <xmx:jmWhYcGnfDQmOzFnkwKhJaEqGf0TQUt1YFQsqrtYUTdS2CSWrKByCA>
    <xmx:jmWhYYWX-pf0ouyemfgxzkGVdXNAsEcdXfJSkfgO5sw10IilsD42_w>
    <xmx:j2WhYcQ6f82W28yJZ2MKqzY89DnSVy-IrW8ht3AoL2fV8AxUilB1D_Oo04k>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D5A4021E006E; Fri, 26 Nov 2021 17:54:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <9641b76e-9ae0-4c26-97b6-76ecde34f0ef@www.fastmail.com>
In-Reply-To: <87lf1ais27.fsf@oldenburg.str.redhat.com>
References: <87h7bzjaer.fsf@oldenburg.str.redhat.com>
 <4728eeae-8f1b-4541-b05a-4a0f35a459f7@www.fastmail.com>
 <87lf1ais27.fsf@oldenburg.str.redhat.com>
Date:   Fri, 26 Nov 2021 14:53:45 -0800
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



On Fri, Nov 26, 2021, at 12:24 PM, Florian Weimer wrote:
> * Andy Lutomirski:
>
>> On Fri, Nov 26, 2021, at 5:47 AM, Florian Weimer wrote:
>>> Distributions struggle with changing the default for vsyscall
>>> emulation because it is a clear break of userspace ABI, something
>>> that should not happen.
>>>
>>> The legacy vsyscall interface is supposed to be used by libcs only,
>>> not by applications.  This commit adds a new arch_prctl request,
>>> ARCH_VSYSCALL_LOCKOUT.  Newer libcs can adopt this request to signal
>>> to the kernel that the process does not need vsyscall emulation.
>>> The kernel can then disable it for the remaining lifetime of the
>>> process.  Legacy libcs do not perform this call, so vsyscall remains
>>> enabled for them.  This approach should achieves backwards
>>> compatibility (perfect compatibility if the assumption that only lib=
cs
>>> use vsyscall is accurate), and it provides full hardening for new
>>> binaries.
>>
>> Why is a lockout needed instead of just a toggle?  By the time an
>> attacker can issue prctls, an emulated vsyscall seems like a pretty
>> minor exploit technique.  And programs that load legacy modules or
>> instrument other programs might need to re-enable them.
>
> For glibc, I plan to add an environment variable to disable the lockou=
t.
> There's no ELF markup that would allow us to do this during dlopen.
> (And after this change, you can run an old distribution in a chroot
> for legacy software, something that the userspace ABI break prevents.)
>
> If it can be disabled, people will definitely say, =E2=80=9Cwe get mor=
e complete
> hardening if we break old userspace=E2=80=9D.  I want to avoid that.  =
(People
> will say that anyway because there's this fairly large window of libcs
> that don't use vsyscalls anymore, but have not been patched yet to do
> the lockout.)

I=E2=80=99m having trouble following the logic. What I mean is that I th=
ink it should be possible to do the arch_prctl again to turn vsyscalls b=
ack on.

>
> Maybe the lockout also simplifies the implementation?
>
>> Also, the interaction with emulate mode is somewhat complex. For now,
>> let=E2=80=99s support this in xonly mode only. A complete implementat=
ion will
>> require nontrivial mm work.  I had that implemented pre-KPTI, but KPTI
>> made it more complicated.
>
> I admit I only looked at the code in emulate_vsyscall.  It has code th=
at
> seems to deal with faults not due to instruction fetch, and also checks
> for vsyscall=3Demulate mode.  But it seems that we don't get to this p=
oint
> for reads in vsyscall=3Demulate mode, presumably because the page is
> already mapped?

Yes, and, with KPTI off, it=E2=80=99s nontrivial to unmap it. I have cod=
e for this, but I=E2=80=99m not sure the complexity is worthwhile.

>
>> Finally, /proc/self/maps should be wired up via the gate_area code.
>
> Should the "[vsyscall]" string change to something else if execution is
> disabled?

I think the line should disappear entirely, just like booting with vsysc=
all=3Dnone.

>
> Thanks,
> Florian
