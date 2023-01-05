Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB18465EA65
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 13:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjAEMF4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Jan 2023 07:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjAEMFz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2023 07:05:55 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570B95471F;
        Thu,  5 Jan 2023 04:05:53 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BB1615C0153;
        Thu,  5 Jan 2023 07:05:52 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 05 Jan 2023 07:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672920352; x=1673006752; bh=UhZB23ikgg
        upzfYjMRU5YJTnDOqqv+WR2zf5S9u612M=; b=RS4DcE88H2bSZhCoHSBnFauHLI
        iBC3nX2sj/ud09rEeqkh7ALUK2+vJlNREh/g8XdJcaG+kAhrVR6CKwuzuB1MCx2E
        Fd64uqrJ/zNqGXSf/cffjs61K1WY5KqXxX3tJP0Ky+bvozO/KNcSf/waz4N6ollD
        G/5Q5PKyhM686OqNqyPvpMU6a5D+1TDYtqua1dvkfUaVXRg5/SPfLEqQSlRKhJP8
        3QjrIr2FCb6ie9mz4X7dvpzhtQiMlFhm2IhyzSVlBOjygSOCeocgaGES8JPsAf22
        KW4ZMmq6cWH7gGqpOpkPQDzzRpwe+HlgYEAxcdKKq5OFQXwSp7+V/UXO7/EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672920352; x=1673006752; bh=UhZB23ikggupzfYjMRU5YJTnDOqq
        v+WR2zf5S9u612M=; b=Sr04uMptHAnE4rxGGbbE3gGANmQXNawSH5VJVMuhRPJo
        7sOz5iB7b8B3KY1JcnwE1J7eHomLLVlkcQC3m/NIDkr6OhW77G2TR4hnm/dclZwN
        m/8Sat0FZVDEM2ggTTy8qPGr8hx9Odws7QLwpt90XoUyFqpSm7bQ8L30EJ2MNlWL
        184gGj+kN9mBMn3xBMdccDAos+EcZpKJdohCICDIjfZd/kk5rc7Sm461pIEH3Pe1
        pHhmXZ0oLWoMQbXd239AJTqhGTOGyUctE/Lq6/s/ON4qu24ox5vSrqErYNXvPZK7
        Oq/3hpF9V8NglYnLd+ZiWWByYq8By36AlzxbrVESTw==
X-ME-Sender: <xms:H722Y-iPa3z3j_Obn9xJ3y4iLVHhLZYRWE53ebwI868UqtTNDK5plw>
    <xme:H722Y_DR7L7Ik-e0GNVxK4qRWiDzyZlVGLcd9_UeECqwuSW1v_o48jnzUAXib3fI1
    l2hOQJUDcEf27Bnh80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeekgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:IL22Y2FbE7Dg5EIyTdQbXO2BylVr2xsUQ8dgioEgrBp0aBvl5yIzAw>
    <xmx:IL22Y3R6pvyQ83oUVYNDJvXQYrV_MCh96rREY2TwUokJi-LRFkGQew>
    <xmx:IL22Y7wfGtxDIPBbXqwUsBIkc8fSVT82W3nBfU_1b_qETo-u8EOO8g>
    <xmx:IL22YzhCDyHE_6V7W5RQnzsUyD5S1ryM9MpvwA09NHFl1ioeyc63Vg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E6BA2B60086; Thu,  5 Jan 2023 07:05:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <5b69db0b-9eed-42ce-8e93-4b656022433f@app.fastmail.com>
In-Reply-To: <20230105104019.GA7446@tellis.lin.mbt.kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <7c531595-e987-422b-bcf7-48ad0ba49ce6@app.fastmail.com>
 <20230105104019.GA7446@tellis.lin.mbt.kalray.eu>
Date:   Thu, 05 Jan 2023 13:05:32 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jules Maselbas" <jmaselbas@kalray.eu>
Cc:     "Yann Sionneau" <ysionneau@kalray.eu>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Aneesh Kumar" <aneesh.kumar@linux.ibm.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Boqun Feng" <boqun.feng@gmail.com>, bpf@vger.kernel.org,
        "Christian Brauner" <brauner@kernel.org>,
        devicetree@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Eric Paris" <eparis@redhat.com>, "Ingo Molnar" <mingo@redhat.com>,
        "Jan Kiszka" <jan.kiszka@siemens.com>,
        "Jason Baron" <jbaron@akamai.com>, "Jiri Olsa" <jolsa@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Kieran Bingham" <kbingham@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-audit@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        "Marc Zyngier" <maz@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Sebastian Reichel" <sre@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Waiman Long" <longman@redhat.com>,
        "Will Deacon" <will@kernel.org>, "Alex Michon" <amichon@kalray.eu>,
        "Ashley Lesdalons" <alesdalons@kalray.eu>,
        "Benjamin Mugnier" <mugnier.benjamin@gmail.com>,
        "Clement Leger" <clement.leger@bootlin.com>,
        "Guillaume Missonnier" <gmissonnier@kalray.eu>,
        "Guillaume Thouvenin" <gthouvenin@kalray.eu>,
        "Jean-Christophe Pince" <jcpince@gmail.com>,
        "Jonathan Borne" <jborne@kalray.eu>,
        "Julian Vetter" <jvetter@kalray.eu>,
        "Julien Hascoet" <jhascoet@kalray.eu>,
        "Julien Villette" <jvillette@kalray.eu>,
        "Louis Morhet" <lmorhet@kalray.eu>,
        "Luc Michel" <lmichel@kalray.eu>,
        =?UTF-8?Q?Marc_Poulhi=C3=A8s?= <dkm@kataplop.net>,
        "Marius Gligor" <mgligor@kalray.eu>,
        "Samuel Jones" <sjones@kalray.eu>,
        "Thomas Costis" <tcostis@kalray.eu>,
        "Vincent Chardon" <vincent.chardon@elsys-design.com>
Subject: Re: [RFC PATCH 00/25] Upstream kvx Linux port
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

On Thu, Jan 5, 2023, at 11:40, Jules Maselbas wrote:
> On Wed, Jan 04, 2023 at 04:58:25PM +0100, Arnd Bergmann wrote:
>> On Tue, Jan 3, 2023, at 17:43, Yann Sionneau wrote:

>> I commented on the syscall patch directly, I think it's
>> important to stop using the deprecated syscalls as soon
>> as possible to avoid having dependencies in too many
>> libc binaries. Almost everything else can be changed
>> easily as you get closer to upstream inclusion.
>> 
>> I did not receive most of the other patches as I'm
>> not subscribed to all the mainline lists. For future 
>> submissions, can you add the linux-arch list to Cc for
>> all patches?
>
> We misused get_maintainers.pl, running it on each patch instead
> of using it on the whole series. next time every one will be in
> copy of every patch in the series and including linux-arch.

Be careful not to make the list too long though, there is
usually a limit of 1024 characters for the entire Cc list,
above this your mails may get dropped by the mailing lists.

>> Reading the rest of the series through lore.kernel.org,
>> most of the comments I have are for improvements that
>> you may find valuable rather than serious mistakes:
>> 
>> - the {copy_to,copy_from,clear}_user functions are
>>   well worth optimizing better than the byte-at-a-time
>>   version you have, even just a C version built around
>>   your __get_user/__put_user inline asm should help, and
>>   could be added to lib/usercopy.c.
>
> right, we are using memcpy for {copy_to,copy_from}_user_page
> which has a simple optimized version introduced in
> (kvx: Add some library functions).
> I wonder if it is possible to do the same for copy_*_user functions.

copy_from_user_page() is only about managing cache aliases,
not user access, and it's not used anywhere in the fast
path, so it's a bit different.

arch/arm/lib/copy_template.S has an example for how
you can share the same assembler implementation between
memcpy() and copy_from_user(), but it's not very
intuitive.

The tricky bit with copy_from_user() is the partial copy
that relies on copying the exact amount of data that can
be accessed including the last byte before the end of
the mapping, and returning the correct count of non-copied
bytes.

If you want a C version, you can probably use the
copy_from_kernel_nofault implementation mm/maccess.c
as a template, but have to add code for the correct
return value.

    Arnd
