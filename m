Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7411A5B5624
	for <lists+linux-arch@lfdr.de>; Mon, 12 Sep 2022 10:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiILI2D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Sep 2022 04:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiILI1p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Sep 2022 04:27:45 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D8032EC4;
        Mon, 12 Sep 2022 01:26:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id C00962B0599F;
        Mon, 12 Sep 2022 04:25:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 12 Sep 2022 04:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662971117; x=1662974717; bh=tsNPVOrPcn
        bS/ZtizYvmEykCmDXx6k4ciLrQUuedWiI=; b=Ntsn5SbES6EvgQeQsPMsOgnpyy
        G1wg6+2tTqt8u7pcPWo4HycB4vtrwNQqN1wUvaUH4s2QiyKdXEns08R9KHWYPYTW
        ZMkh0ltcAk7gnQjDoh8RczGZ3i2f0e4KcYLAI7QvtBXnKokmS/f+Cl9v8qBnTOiL
        R+7phj+x3+QvbiU5+zLhLZlSiTlu+x3U1t/AVac+u7IGXM7ogXAhyGkBIXg/yys9
        FO4GDTFV9Pt5TzvqCqKd7xyPj5NvUJ3igQySSRgw/7a9R26VMalIdN1sv09cSQXg
        sU3Xu0fbcL7+L1NXCE/DNQkwWeROh2QHwNNaGASh6cHaJin76TNC6i7zdHpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662971117; x=1662974717; bh=tsNPVOrPcnbS/ZtizYvmEykCmDXx
        6k4ciLrQUuedWiI=; b=gZFYA7C7XpqI8oikRw6gFjvdTmsK8blFN7aEZ9BkW2KD
        Gy0sGBp3k+JxX/0ZZGsEwJkIuRpogo5qa232ZlslX/cy3r8AaAhrRQb1AzEOOZQN
        U7dkqegeV2yrW0QgBLWaWLx5HMiA/EbyouiMb8EHVw8fyVUA+oxJs7wTwmgSkwxJ
        pvy62Mcfy3re/oOeAWxWncUJlVVkCl2KWeSv/kv/yXrHlAdYtJ90TV+axxI0jEf1
        CY8eSp65wVaEXcTv983dfYMTprEufiMjM5EpmdhbnM+2Ps9BkZv+EOQevEJa6AuM
        dzKE2gW56DS2vq/yPHqPevBuBYBZz4wxGeB3EiZSdA==
X-ME-Sender: <xms:6uweY_c-Qe93cpCldYEWl9cKDFEoZ4P80bTaFYWeJX74SlyuZLq9lw>
    <xme:6uweY1PVAwPdPWdQ4dXdzYcuE7eKmBYVzY1ciDsuKzT8B-wW-CsQC24Yg0-lebWhE
    2-VK88jUfdk4e7f6Ps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduvddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:6uweY4i-LlTYQXjRERyQWY03TxhGbZ7lZ0NsIXugRwasEvw1IMpgFA>
    <xmx:6uweYw-8WLFwEoOnES6vRTYhZMnbXSppF9wL6h8E2Ez9iYCYDR-n5w>
    <xmx:6uweY7tQ1dcB1UyBVuPIpxxxwGwk9iTVa2TKoL1e0_5Gi6nzGS9OJQ>
    <xmx:7eweY2lJxrkLUlZc8HSKt-q5I-T7sxWECpks6hvSbuFVwVLMtSvo-DMzG4vJ4IlM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7FB9AB60086; Mon, 12 Sep 2022 04:25:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <2b06f28d-a13d-4c86-af04-39e383aaf07b@www.fastmail.com>
In-Reply-To: <CAJF2gTRxt_b2TswE6YJgmFZeRyVzV7fQdMX+7Ptrfa_k=auSjg@mail.gmail.com>
References: <20220908022506.1275799-1-guoren@kernel.org>
 <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com>
 <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
 <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com>
 <CAJF2gTRnY+vc2nKbqubTZvv+FWVgO3yCK4LcwpeNgx51JuETzw@mail.gmail.com>
 <7409c92a-68df-4406-bd86-835d9a959ef5@www.fastmail.com>
 <CAJF2gTRxt_b2TswE6YJgmFZeRyVzV7fQdMX+7Ptrfa_k=auSjg@mail.gmail.com>
Date:   Mon, 12 Sep 2022 10:23:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     guoren <guoren@kernel.org>
Cc:     "Palmer Dabbelt" <palmer@rivosinc.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Jisheng Zhang" <jszhang@kernel.org>, lazyparser@gmail.com,
        falcon@tinylab.org, "Huacai Chen" <chenhuacai@kernel.org>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@atishpatra.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        "Guo Ren" <guoren@linux.alibaba.com>,
        "Andreas Schwab" <schwab@suse.de>
Subject: Re: [PATCH V4 8/8] riscv: Add config of thread stack size
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 12, 2022, at 6:14 AM, Guo Ren wrote:
> On Mon, Sep 12, 2022 at 2:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Sun, Sep 11, 2022, at 1:35 AM, Guo Ren wrote:
>> > On Sun, Sep 11, 2022 at 12:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> >>
>> >> That sounds like a really bad idea, why would you want to risk
>> >> using such a small stack without CONFIG_VMAP_STACK?
>> >>
>> >> Are you worried about increased memory usage or something else?
>> > The requirement is from [1], and I think disabling CONFIG_VMAP_STACK
>> > would be the last step after serious testing.
>>
>> I still don't see why you need to turn off VMAP_STACK at all
>> if it works. The only downside I can see with using VMAP_STACK
>> on a 64-bit system is that it may expose bugs with device
>> drivers that do DMA to stack data. Once you have tested the
>> system successfully, you can also assume that you have no such
>> drivers.
> 1st, VMAP_STACK could be enabled&disabled in arch/Kconfig. If we don't
> force users to enable VMAP_STACK, why couldn't user adjust
> THREAD_SIZE?

Turning off VMAP_STACK is harmless and may help debug issues
with VMAP_STACK itself. It's also required on architectures
that don't have KASAN_VMALLOC or something else that conflicts
with it.

Changing THREAD_SIZE is also fine, as long as VMAP_STACK catches
the inevitable overflows. I would not object to having an
option that allows setting the stack size larger than the
default without VMAP_STACK, as long as setting it lower requires
using VMAP_STACK. That would however add a lot more complexity
and probably doesn't do what you want either.

> 2nd, VMAP_STACK is not free, we still need 1KB shadow_stack.
> The EXPERT is enough for your concern.

It's actually more than the 1KB: you need both 1KB of shadow
stack and 4KB per CPU for the actual overflow_stack. If you
are micro-optimizing at this level, then a possible option
may be to change the handle_kernel_stack_overflow() function
to not preserve the task stack and just panic() without
showing the backtrace. That way you don't see which code
caused the issue, but at least you avoid corrupting random
data.

     Arnd
