Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F54D67578E
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjATOk5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjATOk4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:40:56 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABBD73EEB;
        Fri, 20 Jan 2023 06:40:28 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C048D32001BB;
        Fri, 20 Jan 2023 09:39:42 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 20 Jan 2023 09:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674225582; x=1674311982; bh=b4JAJuHxNJ
        8crP6ZpOzWWYxWeuwbnT4P0qgnOUpQ0sI=; b=YpFFzP3VF+EXJCLmreWeBNB9+S
        zXHxKLgMbyNmk2z1VW6q3MxEpkproMFd2XZHbXRd3jw7BKH62BZ93qlWPB+r0tXx
        GbwZZiyJYZEEWYvt4HcxdsEFFE0lLPObyPr5B8oNMr3YVFJBRj3K66+vhYhzgKs/
        5dTWdr/9s8iHSN5+5qnrtbJQ3yCMUPDerYNJ22YIVdBWtYejl55VlFikFlwBAIdo
        1wu/6qiuRfisnPQUn7IDstOQzwRZ2OY2tSeeOoDTrwQg/xL5G/zQs6vtRhpzL8DP
        Fgdfpbi3GAg9bHuV1lTDVypQ9y4jxRbq1AJ3/5km73+LEObdAHBrQILTSssg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674225582; x=1674311982; bh=b4JAJuHxNJ8crP6ZpOzWWYxWeuwb
        nT4P0qgnOUpQ0sI=; b=kbkcGpBlS3kIUHVyg0NKren2v+0ZPixCVs0IHEcgFATv
        /fQDNaGmP5X5P5h19GU2fpwPD1TBW43CHnULxpe+taXxBuiCTAP66XHB1kbw6jVU
        ktB2N/kXAJKDCtVduL7kHyROWsuKfnhUkBDg1JaaVGYEVshIvkSzyvmQ3Mz0kecY
        j2mWceXUaRQVegdU9GN/rHa5HlAqyOMZNLltfaUy/sfmk+CWX6cHgoxSueBp0J0i
        2XczKB1dd7jUSKpZNSGrbGTRUNLi1oRczjpT0oY63IskbhcNKGcpIFxZpm+iiMB0
        rt1VsRAiJTzs0z272UUCumVGSuTlMg9TxL0SPQ1sQQ==
X-ME-Sender: <xms:rafKY_kguGhvxY4s77V4bRvXYVPX-TaLHxAX5Rsi2yUO58HcQO4Zkw>
    <xme:rafKYy3ch5_10fEpPqLPk4skitRZpBS9nUdMMeG_5dV4W4jXI0yFlKr084ITGsZVL
    lGqbdsXwXqxi2OVO80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:rafKY1qFhfPcjqcn3SzgSs11DqXRM8WcWlI7Gu-Kicl7WOeQSyzCNQ>
    <xmx:rafKY3kPhOW_docLyMAkp_w_hKPx7gxrnaYtchGBbzvFANsfGIZ4qA>
    <xmx:rafKY90Q8cyQNciYnFYz9TNs_bgG3H33QbPAoO9563ztIP9MXp_W6Q>
    <xmx:rqfKY83B478JlCxC4F7tHYbChgHt68Lo8MC5zaI3n4bvh6M-xJx_5w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5EF90B60086; Fri, 20 Jan 2023 09:39:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <aa4d68b2-b5b5-4c17-a44f-7c6db443ea4c@app.fastmail.com>
In-Reply-To: <20230120141002.2442-10-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-10-ysionneau@kalray.eu>
Date:   Fri, 20 Jan 2023 15:39:22 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Yann Sionneau" <ysionneau@kalray.eu>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Waiman Long" <longman@redhat.com>,
        "Aneesh Kumar" <aneesh.kumar@linux.ibm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "Eric Paris" <eparis@redhat.com>,
        "Christian Brauner" <brauner@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Jules Maselbas" <jmaselbas@kalray.eu>,
        "Guillaume Thouvenin" <gthouvenin@kalray.eu>,
        "Clement Leger" <clement@clement-leger.fr>,
        "Vincent Chardon" <vincent.chardon@elsys-design.com>,
        =?UTF-8?Q?Marc_Poulhi=C3=A8s?= <dkm@kataplop.net>,
        "Julian Vetter" <jvetter@kalray.eu>,
        "Samuel Jones" <sjones@kalray.eu>,
        "Ashley Lesdalons" <alesdalons@kalray.eu>,
        "Thomas Costis" <tcostis@kalray.eu>,
        "Marius Gligor" <mgligor@kalray.eu>,
        "Jonathan Borne" <jborne@kalray.eu>,
        "Julien Villette" <jvillette@kalray.eu>,
        "Luc Michel" <lmichel@kalray.eu>,
        "Louis Morhet" <lmorhet@kalray.eu>,
        "Julien Hascoet" <jhascoet@kalray.eu>,
        "Jean-Christophe Pince" <jcpince@gmail.com>,
        "Guillaume Missonnier" <gmissonnier@kalray.eu>,
        "Alex Michon" <amichon@kalray.eu>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <git@xen0n.name>,
        "Shaokun Zhang" <zhangshaokun@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>,
        "Guangbin Huang" <huangguangbin2@huawei.com>,
        "Bharat Bhushan" <bbhushan2@marvell.com>,
        "Bibo Mao" <maobibo@loongson.cn>,
        "Atish Patra" <atishp@atishpatra.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        "Qi Liu" <liuqi115@huawei.com>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Janosch Frank" <frankja@linux.ibm.com>,
        "Alexey Dobriyan" <adobriyan@gmail.com>
Cc:     "Benjamin Mugnier" <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v2 09/31] kvx: Add build infrastructure
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 20, 2023, at 15:09, Yann Sionneau wrote:
>      - Fix clean target raising an error from gcc (LIBGCC)

I had not noticed this on v1 but:

> +# Link with libgcc to get __div* builtins.
> +LIBGCC	:= $(shell $(CC) $(DEFAULT_OPTS) --print-libgcc-file-name)

It's better to copy the bits of libgcc that you actually need
than to include the whole thing. The kernel is in a weird
state that is neither freestanding nor the normal libc based
environment, so we generally want full control over what is
used. This is particularly important for 32-bit architectures
that do not want the 64-bit division, but there are probably
enough other cases as well.

     Arnd
