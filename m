Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978935B50AC
	for <lists+linux-arch@lfdr.de>; Sun, 11 Sep 2022 20:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIKSkG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Sep 2022 14:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIKSkF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Sep 2022 14:40:05 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED9EBC1D;
        Sun, 11 Sep 2022 11:40:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 947732B05927;
        Sun, 11 Sep 2022 14:39:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sun, 11 Sep 2022 14:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662921599; x=1662925199; bh=UfGN9EkXoT
        86oWuOWRB8qaSDzpqIdiSsLF8lJ30Qpio=; b=V0XLIuSmvv94NFAKfH+ekuPdli
        P+JePexh7RLuNLA6ZGNbKbWjP39O9kyp/hlE6APlUB5DOUbygulX3KR0XFx9XAue
        TL0ra5DvtzHx3Lol4lm4F+ESUKZ2bTIDmQo1K0HgKQmUUVqjyaCRIy+BMNDoBdLN
        Cy9KhpBg6x35/owc/S9y8Bk9pAiE63mHeHMW/9yxWSc/TeKdDswZeE6tIEjm8qoI
        qQPuMJJoMZM8bbmmhE9pW6c/yk0W3bl25wNkhnjtTf8Px3ZJHnx57a2bId6htXNx
        VGV6BSArH5nZ+GgDRWwxpQSkSBngEq1qQvxo51VHeiEn+dYVLH9o/F/zlWfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662921599; x=1662925199; bh=UfGN9EkXoT86oWuOWRB8qaSDzpqI
        diSsLF8lJ30Qpio=; b=sN6Da89eKJbI/7HCzPENwcVL5wfrpK/ZoS53TBDBVHm1
        qLeBXLv3rAfohOTKwNNmrGnQfZHkpmGKkLmlJOF1Q4tN5pTkq8WPiFMHxMlxTGWw
        Fy/PrUPvo2RVtLf9VpQ7NGd++U1QtjW9m8xPGYfgHdTwhwjUgU7xHUSjkQGrGmmJ
        Ca63zRo/OEifl1RYQvu2NaVnHjIlC7AXIQU4Ny6WHWbgj8bnonuZ7JrFnWeAAFbr
        1r2sZPzDaXKyFLh0ZhQZg+frhjis+W6dAm52rLfArt0cJnYVw6EK4gOT2+D7Hwyw
        hJgRn3o7Jvgj/eKhG7zZBrzCJWANvtCXp3x4qVO6Uw==
X-ME-Sender: <xms:fCseY1Sl4Uc_QMc34bInOkJzBGYxvylgRzNFJyXwblsPyi_RJcpXAg>
    <xme:fCseY-z4At9dK_MzOlSKE23eBCRl3RhCtYTDYWFIu7Kx1yc-3mi9qv9XSlfCqSVYT
    -d9lskEHwscf85jkes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedutddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:fCseY61c2LgvvwOgFWbY4yYrADhkrBgT55GXFE51fdxmDajdaGdx9A>
    <xmx:fCseY9BPwtHaIYWwM8JVH7zjO7pYzYOsOoR4ubiUcEMNP9y-nrb2HQ>
    <xmx:fCseY-ifdBPVu3ot44Ot2ehGdzvGFGVKi_KSi6l4D9VvcC1lqf1QFA>
    <xmx:fyseY3b--qSqUQDwplz8JtdqNhyXKGy_vBf8CnDi1cFOOGnkw7HatWNGHCg4MbrD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CD899B60086; Sun, 11 Sep 2022 14:39:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <7409c92a-68df-4406-bd86-835d9a959ef5@www.fastmail.com>
In-Reply-To: <CAJF2gTRnY+vc2nKbqubTZvv+FWVgO3yCK4LcwpeNgx51JuETzw@mail.gmail.com>
References: <20220908022506.1275799-1-guoren@kernel.org>
 <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com>
 <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
 <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com>
 <CAJF2gTRnY+vc2nKbqubTZvv+FWVgO3yCK4LcwpeNgx51JuETzw@mail.gmail.com>
Date:   Sun, 11 Sep 2022 20:39:35 +0200
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



On Sun, Sep 11, 2022, at 1:35 AM, Guo Ren wrote:
> On Sun, Sep 11, 2022 at 12:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Sat, Sep 10, 2022, at 2:52 PM, Guo Ren wrote:
>> > On Thu, Sep 8, 2022 at 3:37 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> >> On Thu, Sep 8, 2022, at 4:25 AM, guoren@kernel.org wrote:
>> >> > From: Guo Ren <guoren@linux.alibaba.com>
>> >> - When VMAP_STACK is set, make it possible to select non-power-of-two
>> >>   stack sizes. Most importantly, 12KB should be a really interesting
>> >>   choice as 8KB is probably still not enough for many 64-bit workloads,
>> >>   but 16KB is often more than what you need. You probably don't
>> >>   want to allow 64BIT/8KB without VMAP_STACK anyway since that just
>> >>   makes it really hard to debug, so hiding the option when VMAP_STACK
>> >>   is disabled may also be a good idea.
>> > I don't want this config to depend on VMAP_STACK. Some D1 chips would
>> > run with an 8K stack size and !VMAP_STACK.
>>
>> That sounds like a really bad idea, why would you want to risk
>> using such a small stack without CONFIG_VMAP_STACK?
>>
>> Are you worried about increased memory usage or something else?
> The requirement is from [1], and I think disabling CONFIG_VMAP_STACK
> would be the last step after serious testing.

I still don't see why you need to turn off VMAP_STACK at all
if it works. The only downside I can see with using VMAP_STACK
on a 64-bit system is that it may expose bugs with device
drivers that do DMA to stack data. Once you have tested the
system successfully, you can also assume that you have no such
drivers.

     Arnd
