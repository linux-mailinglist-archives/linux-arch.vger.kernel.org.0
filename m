Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C1A7768FC
	for <lists+linux-arch@lfdr.de>; Wed,  9 Aug 2023 21:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjHITnJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Aug 2023 15:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjHITnJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Aug 2023 15:43:09 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2747E10DA;
        Wed,  9 Aug 2023 12:43:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 087FA5C0162;
        Wed,  9 Aug 2023 15:43:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 09 Aug 2023 15:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691610185; x=1691696585; bh=YE
        cqCFxUYGUWqz2IlUXTkb/oxp7H5kGX1NNGYfEDwAs=; b=p7liFpTRJPzvF2BL27
        OlPSzhK21VYRzNUOB0VVBTrnKUZhBazHP52H57yOOQd/W+3FdD3JS8bIHuxsDWbg
        CF+L1lkaHCEORvwW5LUnEGWXoymXM4OMPCHjKrZS6wuOMHibomIrRWgzzXEv2Wzm
        krVJVAEnL1SERZgeBJDXMmu+otenrkvdee8s1Rb+lBxS3CGsrQS0VOdHD7htb6gZ
        Iq1azx08g+Y/lLywwt5xD4fiDxkT5fCXjparzlXkWhx5zLUOSoKrymZ62e+N8Eer
        tu17nWp7GGnTdz0r9SoL0Cpa54frxDLqGIFZM+iOro9t1eZ6H4y2jwgqG9iq80em
        pAHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691610185; x=1691696585; bh=YEcqCFxUYGUWq
        z2IlUXTkb/oxp7H5kGX1NNGYfEDwAs=; b=m5Yc5lz4i6fwIMRmI5ZnP6GYL5Ysn
        LkcO8LVeq+K96zVRDH493c0uZ7bKbWFhfU4yfpqashCrSJ3L33sYjdek6MVtI729
        obyxAiqu6kd5DLMs4JIlJC2LCSSNLSZUPJ8aRnIWduzIMZ0Yo6vFs2cKpDcmjJcb
        2ow4fZPidM0mUXH8LjN1pPv02dXAL+Y22J7TdolASeDD1Q//Hgj71qE3fuNGf5yi
        MmDbzy2MZkVvARtlq8psjR96yxoOEEb+lRyAvFxgHB/zS4a6wt4ZhUAOkCMA/Plw
        vsYGxh3NjNpirAIdfxrEdafzZ0HKjw+fASOY+USpGoLJUD4lwl5MV/xew==
X-ME-Sender: <xms:SOzTZKc6uFlLfvp1ADRFGg4asBYDtGuCjvrB7GNGjGWENC0isHdSQg>
    <xme:SOzTZEMfDeQccRxW5z8IRvyNB1R-SmM4hkFky05k4yKaajBmRgTe8dLFCvi6NZAqh
    PevEozcJ4GS_xsAba8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeggddufeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepkeelfeefvddtkeffudegffffjeffjeeugefftddtteevffdvueetgfejjeel
    tdfhnecuffhomhgrihhnpehkvghrnhgvlhgtihdrohhrghdpkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgu
    segrrhhnuggsrdguvg
X-ME-Proxy: <xmx:SOzTZLjZ0MZ6unn_rsVS2kRYZPJ9RHW_4tAxiljoqlN-9gH1ewxncg>
    <xmx:SOzTZH9vC9WJS6a0Uc4dHsEks1mEpCMl1Fv-9BzlioEHO-zTNj1KWA>
    <xmx:SOzTZGtXYiPyi3nGVg7xQ2Bs2SkRCPUVCA6uL88Qh2zh3dOB-WVePA>
    <xmx:SezTZAJuZ3FACDh2GQioWN8yudaMQJOrWDT-R5nEI8qxf_t0PzMtWA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3C093B6008D; Wed,  9 Aug 2023 15:43:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <b0871ecb-a26b-4223-a4f5-28e1c8d468e4@app.fastmail.com>
In-Reply-To: <202308031551.034F346@keescook>
References: <20210726141141.2839385-1-arnd@kernel.org>
 <20210726141141.2839385-5-arnd@kernel.org> <202308031551.034F346@keescook>
Date:   Wed, 09 Aug 2023 21:42:43 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kees Cook" <keescook@chromium.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Lecopzer Chen" <lecopzer.chen@mediatek.com>
Cc:     "Russell King" <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Linus Walleij" <linus.walleij@linaro.org>, yj.chiang@mediatek.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 04/10] ARM: syscall: always store thread_info->abi_syscall
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 4, 2023, at 01:17, Kees Cook wrote:
> On Mon, Jul 26, 2021 at 04:11:35PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The system call number is used in a a couple of places, in particular
>> ptrace, seccomp and /proc/<pid>/syscall.
>
> *thread necromancy*
>
> Hi!
>
> So, it seems like the seccomp selftests broke in a few places due to
> this change (back in v5.15). I really thought kernelci.org was running
> the seccomp tests, but it seems like the coverage is spotty.
>
> Specifically, the syscall_restart selftest fails, as well as syscall_errno
> and syscall_faked (both via seccomp and PTRACE), starting with this patch.

Thanks for tracking this down!

>> The last one apparently never worked reliably on ARM for tasks that are
>> not currently getting traced.
>> 
>> Storing the syscall number in the normal entry path makes it work,
>> as well as allowing us to see if the current system call is for OABI
>> compat mode, which is the next thing I want to hook into.
>> 
>> Since the thread_info->syscall field is not just the number any more, it
>> is now renamed to abi_syscall. In kernels that enable both OABI and EABI,
>> the upper bits of this field encode 0x900000 (__NR_OABI_SYSCALL_BASE)
>> for OABI tasks, while normal EABI tasks do not set the upper bits. This
>> makes it possible to implement the in_oabi_syscall() helper later.
>> 
>> All other users of thread_info->syscall go through the syscall_get_nr()
>> helper, which in turn filters out the ABI bits.
>
> While I've reproducing the bisect done by mediatek, I'm still poking
> around in here to figure out what's gone wrong. There was a recent patch
> to fix this, but it looks like it's not complete:
> https://lore.kernel.org/all/20230724121655.7894-1-lecopzer.chen@mediatek.com/
>
> With the above applied, syscall_errno and syscall_faked start working
> again, but not the syscall_restart test.

Right, I also see you addressed this better in your follow-up patch,
I'll comment there.

>> Note that the ABI information is lost with PTRACE_SET_SYSCALL, so one
>> cannot set the internal number to a particular version, but this was
>> already the case. We could change it to let gdb encode the ABI type along
>> with the syscall in a CONFIG_OABI_COMPAT-enabled kernel, but that itself
>> would be a (backwards-compatible) ABI change, so I don't do it here.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Another issue of note, which may just be "by design" for arm32, is that
> an invalid syscall (or, at least, a negative syscall) results in SIGILL,
> rather than a errno=ENOSYS failure. This seems to have been true at least
> as far back as v5.8 (where this was cleaned up for at least arm64 and
> s390). There was a seccomp test added for it in v5.9, but it has been
> failing for arm32 since then. :(
>
> I mention this because the behavior of the syscall_restart test looks
> like an invalid syscall: on restart a SIGILL is caught instead of the
> syscall correctly continuing.


The odd arm behavior came up on IRC recently, and I saw that this
was what arm has always done, but I could not figure out why this
is done. I tried to see where s390 and arm64 changed the behavior
but can't find it. Do you have the commit IDs?

      Arnd
