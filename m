Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4498A403A0D
	for <lists+linux-arch@lfdr.de>; Wed,  8 Sep 2021 14:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243146AbhIHMnC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Sep 2021 08:43:02 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:57725 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234005AbhIHMnC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Sep 2021 08:43:02 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 72B3D2B00487;
        Wed,  8 Sep 2021 08:41:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 08 Sep 2021 08:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=H
        g2+3Qr+/MRX/gW3fk1uj/XbgRis4A1DpfEGIntSixc=; b=W3HKfXU+iiqp+mOWY
        nb1lLfN1qlpLrnfuoeiLUDRkuqKUPwMpKQD58Cnt9Eu9ZV0t51rF2wtsQWS6v236
        oAB7Pqn9J64nZocGfslPlNYFTqevaVqdt9BKu3W5N6uKqVxyx6x7srd+7eFDFQRV
        st64gheX72QyngXw0ROkzUjVn0uAf7BS14h+Mz1C1hkp9Aw99jgmM/mLUfU/UWPZ
        mHpI+fGxFgMlZCQG1TN+zs3rh8upVnyVeYR7oRZOkYIrLipU5h0omH2PdrG+2y2u
        DBxMm9BQMSUt8wX7nyvhGJqmdM5MhTWQwI3oHyXFlWDHmWDLootCYYtjy7Q+ozDS
        LWFEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Hg2+3Qr+/MRX/gW3fk1uj/XbgRis4A1DpfEGIntSi
        xc=; b=XGPget4AzdNTB8ClE6PZ4TkKic9J0rvW3GFAnc2u0sRuZ28GFhxGtE81M
        Kyr3Ya672CaNG4Y1oiZD7z9WM/bKj+A2DSb8Pk0QH8IGKku7BHWFqFnvZ0T3Tk/M
        34sExhKH4p4+fZZ2wrVRpiGsw0Huw7chbzroXwYy46obGLZYVUvCU5qoiDK1SGgt
        2g2dXrkaeGK1RkPz69ucUyI+HuS2P0CSsuPeba+YWlpDqAe+TTnC5ejpAwOzGAYV
        2yTsw0OEAetKRdFteDhRj7qAODnqf7GlQ6KB/NiSllTsQtPQEJAEaOh3KtHsSq5U
        DUbWtLBRgxQCCLSFB8u+m6itvheJQ==
X-ME-Sender: <xms:jq84YWI3u7vguqb3B1Cb9PHUs8uuYJICVsTyjpTsrj0XGWGVDvOEgw>
    <xme:jq84YeK8xnR_Wkqr9yqLOqD_bEMKNdETgTVgyT-bqIGfeIkhRiBr767XHQ-HFW0-s
    E5vMyQGVOnIvLAlR_8>
X-ME-Received: <xmr:jq84YWvQCVq43pdDjtcQXn0WWWwWUY62CgYEgA4vfeiY8mnWvD0-9F9XafQZfOgC955J-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefjedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeehieduvdevhfekjeeftddtkeeitefhudekvdeiueeulefgleei
    jeeghedvkeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:jq84YbZL9Vgv_60smQ2jEZuALCbC0wXlxXHBRUKY-3V5zA7v4Ofshw>
    <xmx:jq84YdaEgh4Ku7Lqufy8ZY5Z-L98EOqDMzRJ6SpDfotX1E0RcV7YZQ>
    <xmx:jq84YXBvGcvd0mLDrKEB4XK-0HGpaRm9J3XyqppP-EhUcdUlcohGxw>
    <xmx:ka84YaT4i8XGgNSPTBsfYfWvdYSJwiTBqm8s-bB5zC9x2_tOy4x3rccBP78>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 08:41:46 -0400 (EDT)
Message-ID: <13d237ab-0ef3-772d-6f21-ff023781efcf@flygoat.com>
Date:   Wed, 8 Sep 2021 20:41:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 1/2] mips: convert syscall to generic entry
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        =?UTF-8?B?6ZmI6aOe5oms?= <chris.chenfeiyang@gmail.com>
Cc:     tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        arnd@arndb.de, Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        chenhuacai@kernel.org, Yanteng Si <siyanteng@loongson.cn>,
        zhouyu@wanyeetech.com
References: <cover.1630929519.git.chenfeiyang@loongson.cn>
 <ec14e242a73227bf5314bbc1b585919500e6fbc7.1630929519.git.chenfeiyang@loongson.cn>
 <59feb382-a4ab-c94e-8f71-10ad0c0ceceb@flygoat.com>
 <CACWXhKnA24KuJo33+OitPQVRRd3g_05DWRC2Dsnm7w8hVyKjNQ@mail.gmail.com>
 <20210908085150.GA5622@alpha.franken.de>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20210908085150.GA5622@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


在 2021/9/8 16:51, Thomas Bogendoerfer 写道:
> On Wed, Sep 08, 2021 at 10:08:47AM +0800, 陈飞扬 wrote:
>> On Tue, 7 Sept 2021 at 21:49, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>>
>>> 在 2021/9/7 14:16, FreeFlyingSheep 写道:
>>>> From: Feiyang Chen <chenfeiyang@loongson.cn>
>>>>
>>>> Convert mips syscall to use the generic entry infrastructure from
>>>> kernel/entry/*.
>>>>
>>>> There are a few special things on mips:
>>>>
>>>> - There is one type of syscall on mips32 (scall32-o32) and three types
>>>> of syscalls on mips64 (scall64-o32, scall64-n32 and scall64-n64). Now
>>>> convert to C code to handle different types of syscalls.
>>>>
>>>> - For some special syscalls (e.g. fork, clone, clone3 and sysmips),
>>>> save_static_function() wrapper is used to save static registers. Now
>>>> SAVE_STATIC is used in handle_sys before calling do_syscall(), so the
>>>> save_static_function() wrapper can be removed.
>>>>
>>>> - For sigreturn/rt_sigreturn and sysmips, inline assembly is used to
>>>> jump to syscall_exit directly for skipping setting the error flag and
>>>> restoring all registers. Now use regs->regs[27] to mark whether to
>>>> handle the error flag and always restore all registers in handle_sys,
>>>> so these functions can return normally as other architecture.
>>> Hmm, that would give us overhead of register context on these syscalls.
>>>
>>> I guess it's worthy?
>>>
>> Hi, Jiaxun,
>>
>> Saving and restoring registers against different system calls can be
>> difficult due to the use of generic entry.
>> To avoid a lot of duplicate code, I think the overhead is worth it.
> could you please provide numbers for that ? This code still runs
> on low end MIPS CPUs for which overhead might mean a different
> ballpark than some highend Loongson CPUs.

It shows ~3% regression for UnixBench on MT7621A (1004Kec).

+ Yanjie could you help with a run on ingenic platform?

Thanks.

- Jiaxun

>
> Thomas.
>
