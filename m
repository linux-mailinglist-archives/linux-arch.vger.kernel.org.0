Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236B868BA46
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 11:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBFKfd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 05:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjBFKe7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 05:34:59 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3520F74C;
        Mon,  6 Feb 2023 02:34:19 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 722DC5C00C4;
        Mon,  6 Feb 2023 05:33:29 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 06 Feb 2023 05:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675679609; x=1675766009; bh=Yhoj4RnsjN
        wKN2xZh2UIOjfZ9pZQfvv4RITKRu8FFow=; b=GfhJooMvkS9m0B3ZP3Jm/DKvb2
        wvkzZNFlsHdcx5GQqXTOIIdgkW4AGVQucd2TLpM/YV5QsF+MVqoiJIlnUds4bMOz
        svFuluBDDN8+nSim5Mb/3ZrR2LMvYNKrbfMDG/xNIuAP26843MFZaYN6EEXUJCFC
        6l8UKBvPYFB16QO3q6t8Vu2jmGzTfA8hUS60QfPeQMq+lskVHTbUcEcNP8g9B4fD
        qtFEIydIKwI6KAdacJuMeA+RsDd7Mq1Yr99c1Jv37FTsGFCZHB4MtmHdRaiWXKXr
        Kqjeyxxmx/1REDs7/mPld0JC4yLprMnOCy2qk8ASd51+OAJyS6+s3pqugtlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675679609; x=1675766009; bh=Yhoj4RnsjNwKN2xZh2UIOjfZ9pZQ
        fvv4RITKRu8FFow=; b=smvapOgGiyeVDzUGIFSkC6FMHwu8GJl/mQ2mRzFEwfAS
        1wQFNTRw1ls8AdmAk5o83ay72Q1d24UOpPkqtwJ6fQ9Wmz661+5/TTDBss1ax7el
        bBoiy+pmhnKFTxkqxAmy4+lBplbrYj/pMZy+/1SBHIC17Mt5UeYADcUnqGqGut5P
        nEzMVSCQ4hS/ujuNY/Axefumn4MXSHRmljxXrZAGyT2HP45Z233zAL+C2b3+qsA/
        M3ya1mDoW3yL2zY+YSxrVMQRDwymkIU2KUHehFbDZXOWwP81z6LA55iADxrWjvUm
        29HePxvSoH37lfDU3PUO74//Cqp92ayWEwcjLTEMjA==
X-ME-Sender: <xms:eNfgY2VjFZtwvSNVOzZumQuALWJSJkDbt9otapt09R4D1tdz8Zi4rA>
    <xme:eNfgYykser4L5UfWugKaekgvBVWr2aVuH4rmsdAaY6WHQMtnmkdEhjd65IOVrDdjv
    Z4iDVwNXuNCr1I2UHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegiedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:eNfgY6b73RgmQJC8bndoUUg7foWU12-uYnoR0C1s2zCBVDIqdO0v6w>
    <xmx:eNfgY9W1hjzrdQLrDp6ke8IneMRoQ4aGwSOgXK_-GRsQXh9hB9KlEQ>
    <xmx:eNfgYwmOWF-Gc51XNSJaGYCQCq3ncsZ6iHhepHElRY9EiDxspbSs0A>
    <xmx:edfgY-ZrZiBljwjhr7COVAbRJDx5zMWSAsP1FBiGN7KnrvJQxxaKkw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CEE61B60086; Mon,  6 Feb 2023 05:33:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-108-ge995779fee-fm-20230203.001-ge995779f
Mime-Version: 1.0
Message-Id: <f90129d9-3262-4e3a-9d78-57f641dbdb64@app.fastmail.com>
In-Reply-To: <CAAhV-H6kuzfjw5i8-6L_68c50nsXzFipHY5hxtbShuv16bqRbg@mail.gmail.com>
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
 <ccf74ebd-ccc1-4de5-a425-dcde4ac39a8d@app.fastmail.com>
 <CAAhV-H6kuzfjw5i8-6L_68c50nsXzFipHY5hxtbShuv16bqRbg@mail.gmail.com>
Date:   Mon, 06 Feb 2023 11:33:10 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huacai Chen" <chenhuacai@kernel.org>
Cc:     "Huacai Chen" <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 3, 2023, at 03:08, Huacai Chen wrote:
> On Thu, Feb 2, 2023 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Thu, Feb 2, 2023, at 09:42, Huacai Chen wrote:
>> > Introduce Kconfig option ARCH_STRICT_ALIGN to make -mstrict-align be
>> > configurable.
>> >
>> > Not all LoongArch cores support h/w unaligned access, we can use the
>> > -mstrict-align build parameter to prevent unaligned accesses.
>> >
>> > This option is disabled by default to optimise for performance, but you
>> > can enabled it manually if you want to run kernel on systems without h/w
>> > unaligned access support.
>> >
>> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>
>> This feels like it's a way too low-level option, I would not expect
>> users to be able to answer this correctly.
>>
>> What I would do instead is to have Kconfig options for specific
>> CPU implementations and derive the alignment requirements from
>> that.
> You mean provide something like CONFIG_CPU_XXXX as MIPS do?  That
> seems not a good idea, too. If there are more than 3 CONFIG_CPU_XXXX,
> the complexity is more than CONFIG_ARCH_STRICT_ALIGN.

The way that mips does it is not useful since that forces you to
pick a single CPU from a 'choice' list in Kconfig, with the CPUs
being mutually exclusive in that list. What you need here is either
a strict hierarchy of CPUs like in arch/x86/Kconfig.cpus where each
option is a superset of the previous one, or a set of options
like in arch/arm/mm/Kconfig that are not mutually exclusive and
let you pick any combinations that you want to support in a kernel
image.

The important bit is that a kernel you build will by default
always work across all hardware except the ones that are
explicitly excluded.

> Then users are also unable to do a correct selection. On the other
> hand, we can add more words under CONFIG_ARCH_STRICT_ALIGN to
> describe which processors support hardware unaligned accesses.

Trying to handle this with help texts quickly gets out of hand
when you get to dozens of CPU specific optimizations that are
incompatible with other CPU cores. I assume you will need similar
options e.g. for the broken cpu-idle instruction on early cores
or the missing sub-word atomics, once these are fixed in new
CPU cores.

     Arnd
