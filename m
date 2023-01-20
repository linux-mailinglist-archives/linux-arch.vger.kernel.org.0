Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6F46757FE
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 16:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjATPBi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 10:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjATPBh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 10:01:37 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD5741B72;
        Fri, 20 Jan 2023 07:01:36 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 64F0B320077A;
        Fri, 20 Jan 2023 10:01:33 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 20 Jan 2023 10:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674226892; x=1674313292; bh=1/i8XkaZ2k
        WH/ANJugw9+lV13XFt/Z3piuqR1SILJ8I=; b=Z7ILUxnUEkzDx9iXK5m79/Qfx6
        5NgR1h7GaZSs6m6EjGhB0T2JyLonAq8QbFo+zMdp+sskyZqCcQN4J4MCKdJrvyfA
        /Zo/6LiA3eGCe2G6FQaiwRiamDyIYyyBsM8EJkVXknTRIEy5lxOjr8jdj6oXA1cx
        7H9gGJWGdYNzHnIbeA5V+uqFjz8OHl1jLoaORBjHV+IiuGNpspQ+dRbLsVKOcXmw
        pybet8+YyK0Pu1iSXizlB0CFOzrqdvJ4JF3UksO8pdnRNeb2Um/Alt0yZzVj1gXv
        mGDyU2VjAxeLzFSgn56X3lP5U2gT7i7xaZfY+hFG/i+QEtPClr0MyyqtGxeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674226892; x=1674313292; bh=1/i8XkaZ2kWH/ANJugw9+lV13XFt
        /Z3piuqR1SILJ8I=; b=AScM23Xt6qrpZI1KEsWsxYOn46MGu0a4483EASgzUxif
        KYkOY2m52kcdjHCovknnMnYQJ99X6orCBhmLWS5xVQNF19oVu15lFoonVHv2dog0
        MlegsyeEhaQHG7sDEAMLF52WrEfHd41pMMUH5jWBBBIgD5r/yVwPNdvoZLVRvCZs
        XG5nbVuootxqzspKIpkBHJUrA/jQbdScKeazemZDA0PLBUbUKMeHPhT8dTcZfYa1
        vMGiw2YIYuERhKpZr0F8jFDtOWVZmYE5EkKJ3QGc89GGjO2vTN5126Ne8Xy8EYkt
        yE05gOqaELiKxFdzrS/8jcqdrHeyoZrmDrqh11FfTw==
X-ME-Sender: <xms:y6zKY1--FxFV5WM_dvH3L-jhvDJdkUv2VKNjqycw8wsWi1kY60t_Hg>
    <xme:y6zKY5uEr8VwywOYKxxuRFHA2t7uhUz8er2Qni3FDxgSf42PnIomr8bT4uWQPMrSj
    vl6wYFssrKwy6qpeIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduvddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:y6zKYzAQI32j9NDjRfMqwyTzyHZ7gpDAsgcrznJyKaxYWkjqDKkMig>
    <xmx:y6zKY5dwnJnhoe3QJUqC8kllrSTTegH2oqUNSRINTZtDGCG_doy8wg>
    <xmx:y6zKY6NeO-4u4ZZ4r7o7F71zTnD9XHdwpsJ3MbruCFIRzX2R-IamTw>
    <xmx:zKzKY0uSG_2mGZuS71TMJo-MA0P9EOIrBzWmkXOZx-9ZotVtWq1S0w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 786ABB60086; Fri, 20 Jan 2023 10:01:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <9965e2d1-bae8-4ce7-911c-783c772e9ff1@app.fastmail.com>
In-Reply-To: <20230120145316.GA4155@tellis.lin.mbt.kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-10-ysionneau@kalray.eu>
 <aa4d68b2-b5b5-4c17-a44f-7c6db443ea4c@app.fastmail.com>
 <20230120145316.GA4155@tellis.lin.mbt.kalray.eu>
Date:   Fri, 20 Jan 2023 16:01:11 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jules Maselbas" <jmaselbas@kalray.eu>
Cc:     "Yann Sionneau" <ysionneau@kalray.eu>,
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
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Benjamin Mugnier" <mugnier.benjamin@gmail.com>,
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

On Fri, Jan 20, 2023, at 15:53, Jules Maselbas wrote:
> On Fri, Jan 20, 2023 at 03:39:22PM +0100, Arnd Bergmann wrote:
>> On Fri, Jan 20, 2023, at 15:09, Yann Sionneau wrote:
>> >      - Fix clean target raising an error from gcc (LIBGCC)
>> 
>> I had not noticed this on v1 but:
>> 
>> > +# Link with libgcc to get __div* builtins.
>> > +LIBGCC	:= $(shell $(CC) $(DEFAULT_OPTS) --print-libgcc-file-name)
>> 
>> It's better to copy the bits of libgcc that you actually need
>> than to include the whole thing. The kernel is in a weird
> It was initialy using KCONFIG_CFLAGS which do not contains valid options
> when invoking the clean target.
>
> I am not exactly sure what's needed by gcc for --print-libgcc-file-name,
> my guess is that only the -march option matters, I will double check
> internally with compiler peoples.
>
>> state that is neither freestanding nor the normal libc based
>> environment, so we generally want full control over what is
>> used. This is particularly important for 32-bit architectures
>> that do not want the 64-bit division, but there are probably
>> enough other cases as well.

To clarify: I meant you should not include libgcc.a at all but
add the minimum set of required files as arch/kvx/lib/*.S.

     Arnd
