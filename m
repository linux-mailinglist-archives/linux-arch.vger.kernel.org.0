Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3185709CF4
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 18:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjESQyE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjESQyD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 12:54:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5F7114;
        Fri, 19 May 2023 09:53:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C366F5C0096;
        Fri, 19 May 2023 12:53:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 19 May 2023 12:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1684515237; x=1684601637; bh=yhZY0s/47MOrcmNsSFhuJoECsMYmmsbPIqp
        0mRoiHMk=; b=bmwkQjhbHOWz5dV5Cd6mu/m1Neq0V0I8nt1NOZCDWzG5SRkJ7bj
        P68sMNZ1n2l+nY1r9MAUb1Qjku3q93PCLHKXv+K7IE8q6bhUeFiY1i5kpand7kjc
        ojYi3fDh5X0LikoQ8VmE4g6FzhYGPwLPDguwcol0BIEdrBKhwZECKa533dwog1tR
        0Nfp6RB1q+JkmYzufde6dET3U5w2gRAFC5L8bmKWFR5jyt20wB/s5DXZP/l/e8fi
        jXi1jjDcLp3xUIIQ2q/vkvOX6iRGi75+ILf14+HoEI9SyJmE/WWqUQFWmKngM1fV
        KVvpvSOm2oaFxHBNNRsxceKvI26Si1OlNHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684515237; x=1684601637; bh=yhZY0s/47MOrcmNsSFhuJoECsMYmmsbPIqp
        0mRoiHMk=; b=F/0hcqq3GiXxzveFwLkngpTXJrLwBoVWdcv09xFv0ZX1dnxfv+y
        n02DKYYcVysDM2IOCJu2W3bszb3AqbxenpZjIo8GLvM+wHb9LaaCSCS6vEq6EJbj
        70EZzC0OP2uK6ursqDFKVlgGQx+mKlp8jP+aTAF5vEWKVRlo8tUgv9SqIyjyQoEp
        g+5p3mhRKa9KJrAcIxmsCxcLG0WlSqdT3Wf5hf7NWGmQaYr7Gt2K5DjIf/RLWhtZ
        uEvHq0qz2UtPL3cVtwN4/KrgjzbwFWyUvhPaKiZ4sUzTjNf7NWL/QZhy0esXi8Zi
        2QPBNg4ihcPjrO1NBN5kNwXL3m7Res3pZ8w==
X-ME-Sender: <xms:pKlnZCsKXBbX9H4L8l8SHtogv6ii6vS30a0u8eCH6Lz1ex4fb2X-Jg>
    <xme:pKlnZHcS7SeVLxk4boyMugJhzY0NCSoYUoQHR2z21JdcRox37Ynz8Kd1xEiiPwlYo
    wExlK4RVo_S1c9PX9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:pKlnZNwenC2zJcSOrrTY2u7bmCAtug-BuVNWhdGMFXVY_oXUsrfRXA>
    <xmx:pKlnZNM35i5RBk3sYR4mdXrapO59bM1e3WLlV0juzyqDQMaEqpufcA>
    <xmx:pKlnZC8b9XqAgA5BkwPs-vM-_W3fRY5c1FuMBRVRid5HaiENG-srKw>
    <xmx:palnZBeehye73N8PsLdavUwIa4rA3f8ZFvaEZq2vbHa1CT6TCMNo7A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ED0CCB6008D; Fri, 19 May 2023 12:53:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <a9fcf1ad-a387-42a7-957a-e5a6a36fb3d7@app.fastmail.com>
In-Reply-To: <CAJF2gTRO8Qcz2EXz-ZAczpTj=Lm=GPO-UQMPqCRdqrfjg8sXbA@mail.gmail.com>
References: <mhng-24855381-7da8-4c77-bcaf-a3a53c8cb38b@palmer-ri-x1c9>
 <556bebad-3150-4fd5-8725-e4973fd6edd1@app.fastmail.com>
 <CAJF2gTRO8Qcz2EXz-ZAczpTj=Lm=GPO-UQMPqCRdqrfjg8sXbA@mail.gmail.com>
Date:   Fri, 19 May 2023 18:53:35 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     guoren <guoren@kernel.org>
Cc:     "Palmer Dabbelt" <palmer@rivosinc.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@atishpatra.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
        "Anup Patel" <anup@brainfault.org>, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        "Andy Chiu" <andy.chiu@sifive.com>,
        "Vincent Chen" <vincent.chen@sifive.com>,
        "Greentime Hu" <greentime.hu@sifive.com>,
        "Jonathan Corbet" <corbet@lwn.net>, wuwei2016@iscas.ac.cn,
        "Jessica Clarke" <jrtc27@jrtc27.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        "Guo Ren" <guoren@linux.alibaba.com>
Subject: Re: [RFC PATCH 00/22] riscv: s64ilp32: Running 32-bit Linux kernel on 64-bit
 supervisor mode
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 19, 2023, at 17:31, Guo Ren wrote:
> On Fri, May 19, 2023 at 2:29=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Thu, May 18, 2023, at 17:38, Palmer Dabbelt wrote:
>> > On Thu, 18 May 2023 06:09:51 PDT (-0700), guoren@kernel.org wrote:
>>
>> If for some crazy reason you'd still want the 64ilp32 ABI in user
>> space, running the kernel this way is probably still a bad idea,
>> but that one is less clear. There is clearly a small memory
>> penalty of running a 64-bit kernel for larger data structures
>> (page, inode, task_struct, ...) and vmlinux, and there is no
> I don't think it's a small memory penalty, our measurement is about
> 16% with defconfig, see "Why 32-bit Linux?" section.
>
> This patch series doesn't add 64ilp32 userspace abi, but it seems you
> also don't like to run 32-bit Linux kernel on 64-bit hardware, right?

Ok, I'm sorry for missing the important bit here. So if this can
still use the normal 32-bit user space, the cost of this patch set
is not huge, and it's something that can be beneficial in a few
cases, though I suspect most users are still better off running
64-bit kernels.

> The motivation of s64ilp32 (running 32-bit Linux kernel on 64-bit s-mo=
de):
>  - The target hardware (Canaan Kendryte k230) only supports MXL=3D64,
> SXL=3D64, UXL=3D64/32.
>  - The 64-bit Linux + compat 32-bit app can't satisfy the 64/128MB sce=
narios.
>
>> huge additional maintenance cost on top of the ABI itself
>> that you'd need either way, but using a 64-bit address space
>> in the kernel has some important advantages even when running
>> 32-bit userland: processes can use the entire 4GB virtual
>> space, while the kernel can address more than 768MB of lowmem,
>> and KASLR has more bits to work with for randomization. On
>> RISCV, some additional features (VMAP_STACK, KASAN, KFENCE,
>> ...) depend on 64-bit kernels even though they don't
>> strictly need that.
>
> I agree that the 64-bit linux kernel has more functionalities, but:
>  - What do you think about linux on a 64/128MB SoC? Could it be
> affordable to VMAP_STACK, KASAN, KFENCE?

I would definitely recommend VMAP_STACK, but that can be implemented
and is used on other 32-bit architectures (ppc32, arm32) without a
huge cost. The larger virtual user address space can help even on
machines with 128MB, though most applications probably don't care at
that point.

>  - I think 32-bit Linux & RTOS have monopolized this market (64/128MB
> scenarios), right?

The minimum amount of RAM that makes a system usable for Linux is
constantly going up, so I think with 64MB, most new projects are
already better off running some RTOS kernel instead of Linux.
The ones that are still usable today probably won't last a lot
of distro upgrades before the bloat catches up with them, but I
can see how your patch set can give them a few extra years of
updates.

For the 256MB+ systems, I would expect the sensitive kernel
allocations to be small enough that the series makes little
difference. The 128MB systems are the most interesting ones
here, and I'm curious to see where you spot most of the
memory usage differences, I'll also reply to your initial
mail for that.

       Arnd
