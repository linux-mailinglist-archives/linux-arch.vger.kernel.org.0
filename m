Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D5243A92E
	for <lists+linux-arch@lfdr.de>; Tue, 26 Oct 2021 02:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhJZAYY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 20:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234866AbhJZAYY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Oct 2021 20:24:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9FAD60F92;
        Tue, 26 Oct 2021 00:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635207721;
        bh=aByDMtm3gGKxScX4G2tD1RLvvDygFh/kqrDSV2GhxG0=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=lF213LU0mk7Ej8/XpvzNTo7z53XPnsopWYAHXbKFnbwpvROZfLC5ALRQIHTjqyCfp
         2fs2vKSqKCVHSiTTBN+9NeiTp+v/GU97jH4UeMRJAS+vdcPNtQ7SipsutcEtG/jQfH
         vygdAsuJ8+e8ggZFgmO7lY/+TS9ww7baF+UkkMlZECvjHE4x2jxa/T7f4Cu9YeopmH
         SrGirG0vCOQglQMoOHdI/gvyBnAMQ6ZgnC/wLFcvYWwgRpquTSBBvlNbFkSssMP3oR
         zpp2ztmtOK1XX4adk2LKPJhKCkutd0//wxRoXTo5NQLbN/IEYk21DzLhjIX2gfLqPA
         oCXUh4V9N389A==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A235027C005A;
        Mon, 25 Oct 2021 20:21:58 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Mon, 25 Oct 2021 20:21:58 -0400
X-ME-Sender: <xms:JUp3YR3gmh9TzzwohdqsjZAyvKPBpFVZ7a4yDC5oyXoQOU07cyU5fg>
    <xme:JUp3YYGW_aK3uTWRhYYlqgYx0kqbzJwBqKc3yt3o8NLFhR5WpUrNXkzY7fCamYIFD
    1sCfxUYIDZBwTz-xMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefiedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:JUp3YR5Tfc8UiwfOiFxDYUe9aKRgzrnR0PFxi61pMSg97nT0At1M0g>
    <xmx:JUp3Ye3DlNlVjwGeNH6zauJb87p4t9oXByU0_hoNR8BvN-cclqVOTg>
    <xmx:JUp3YUEeHq1dSlmF7QBWazCNYZzl-Z4Jfq-D_BXA8FaJR6JLCxcp7Q>
    <xmx:Jkp3YfC5xiyn2S2VefUNdN4OI2rPslIoK3YUaWp39APxBw__KGUbby9Tr8U>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 48FCC21E0072; Mon, 25 Oct 2021 20:21:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <530952e5-27d7-40b8-ac9a-debc36bb4fdf@www.fastmail.com>
In-Reply-To: <CAHk-=wioHUhqXU3_PR82VbfS8G=+zH+z8igeG-QAuCaWm5Cgqg@mail.gmail.com>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-10-ebiederm@xmission.com> <875ytkygfj.fsf_-_@disp2133>
 <4b203254-a333-77b1-0fa9-75c11fabac36@kernel.org>
 <CAHk-=wioHUhqXU3_PR82VbfS8G=+zH+z8igeG-QAuCaWm5Cgqg@mail.gmail.com>
Date:   Mon, 25 Oct 2021 17:21:36 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Kees Cook" <keescook@chromium.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 10/32] signal/vm86_32: Properly send SIGSEGV when the vm86 state
 cannot be saved.
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Mon, Oct 25, 2021, at 4:45 PM, Linus Torvalds wrote:
> On Mon, Oct 25, 2021 at 3:25 PM Andy Lutomirski <luto@kernel.org> wrot=
e:
>>
>> I think the result would be nicer if, instead of adding an extra goto,
>> you just literally moved all the cleanup under the unsafe_put_user()s
>> above them.  Unless I missed something, none of the put_user stuff re=
ads
>> any state that is written by the cleanup code.
>
> Sure it does:
>
>         memcpy(&regs->pt, &vm86->regs32, sizeof(struct pt_regs));
>
> is very much part of the cleanup code, and overwrites that regs->pt th=
ing.
>
> Which is exactly what we're writing back to user space in that
> unsafe_put_user() thing.

D=E2=80=99oh, right.

>
> That said, thinking more about this, and looking at it again, I take
> back my statement that we could just make it a catchable SIGSEGV
> instead.
>
> If we can't write the vm86 state to user space, we will have
> fundamentally lost it, and while it's not fatal to the kernel, and
> while we've recovered the original 32-bit state, it's not something
> that user space can sanely recover from because the register state at
> the end of the vm86 work has now been irrecoverably thrown away.

There=E2=80=99s =E2=80=9Crecoverable=E2=80=9D and there=E2=80=99s =E2=80=
=9Crecoverable=E2=80=9D.  Sure, the vm86 state is gone, but the process =
is getting a signal that doesn=E2=80=99t indicate that one can freely re=
turn and carry on as if nothing happened.  But one can catch the signal =
and go on to do something else.

>
> So I think Eric's patch is fine.

Me too.

>
> Except, as mentioned as part of the other patch, the "force_sigsegv()"
> conversion to use "force_fatal_sig()" was broken, because that
> function wasn't actually fatal at all.
>
>              Linus
