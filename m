Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D2A65D7B7
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jan 2023 16:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbjADP7S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 10:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbjADP6t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 10:58:49 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A551413F6B;
        Wed,  4 Jan 2023 07:58:47 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 284635C00D1;
        Wed,  4 Jan 2023 10:58:45 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 04 Jan 2023 10:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672847925; x=1672934325; bh=H0UTR4kJze
        AkAZivC7ap8DwhEwb/MXnY4XPO+uy9kKc=; b=U8pU6dYSVrl/CVJUPPEqx1R9Aq
        lRxcqMgYm/TyRX26ZRhyXa5uD+cs/yqjcy+nxmXyUIG+GTv181nQJi14UJAOIAjf
        9og92IBPb31uZ6dMCyYRlMnZEfzQ6xvntOWmT3FWGrbwUq5HC7doLJZu6KqzASKI
        hx0t/iE+7VsGIErLSpVMU0gFj5/H+ZQaKAZypwzKqJpGCyYDp223hOv+Zz4SLqW0
        aap4i0c2yXuHQ0fuFazE/+lmbeVPJ9sjpKCGtqT+ziNxFO9URfDlN8d6S8yyG2Kc
        gfoSMJGJPpNha+B3JWXggdUNoTtSLSxTxQuqa+jy3h74M4/4siNT+25L+AnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672847925; x=1672934325; bh=H0UTR4kJzeAkAZivC7ap8DwhEwb/
        MXnY4XPO+uy9kKc=; b=HgaFI40sC8yMY8VOy7QQ2F4//wyS3hYp0LPxGg03HAWk
        qEtLjRM+JzoyCdjTkYPOh/vyRMocCgEQJJqgRHD5+URJ6Ih4+/PWfKLiNnp0SZ5c
        2eVHhYC4JvCfKwLmmEFnjnFQRQl/X6q87HzGKYozVQvf+hOjcXLbChRn7u4v6rVv
        A7h6PsV/16E/QY06UxPPdbXrMJQ3AXHk2Coz61RWuHtjaXz5GAT/CtwzH0J/hC6Z
        8GBNd2fU1eV3VheOX6SEI3N2hK9df+iJYKLxk619yg08GulRxfRBLXa5HcZVP0mX
        atQsepbklOuSYA/wRkqz2dILaWkGdP1/uzO37OwLPg==
X-ME-Sender: <xms:NKK1Y48HslmbYS4XfyvkV25JDSKz4gqEZbPhEXvALJOvcqVVorgYrQ>
    <xme:NKK1YwvOYWU86IT641Xjgz28D53RJaLRPWwjvOCq1FuTvXSRIj9DM-9LxgP0a6zpv
    RWXh9d7Rchms20DgzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:NKK1Y-D0Rn03uTnG6oMJtNULtppKVKQLRwrnCdfDvZq1rkRA1aAVAg>
    <xmx:NKK1Y4fvmlqny8-TiW5EIb1Km8tOPFA7Fqn4qJNuwbm4wf6rLLbgkw>
    <xmx:NKK1Y9MK4-XTCquhXJiLE_n3OfFxMW22ddTI_UZsemVu5efG4lpnyQ>
    <xmx:NaK1YztseASQahJ66RWxLZYnhH-1ueAQdizsGnk9d2-oLHJ_jMdhJw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 43F24B6008D; Wed,  4 Jan 2023 10:58:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <7c531595-e987-422b-bcf7-48ad0ba49ce6@app.fastmail.com>
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
Date:   Wed, 04 Jan 2023 16:58:25 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Yann Sionneau" <ysionneau@kalray.eu>
Cc:     "Albert Ou" <aou@eecs.berkeley.edu>,
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
        "Jules Maselbas" <jmaselbas@kalray.eu>,
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 3, 2023, at 17:43, Yann Sionneau wrote:
> This patch series adds support for the kv3-1 CPU architecture of the kvx family
> found in the Coolidge (aka MPPA3-80) SoC of Kalray.
>
> This is an RFC, since kvx support is not yet upstreamed into gcc/binutils,
> therefore this patch series cannot be merged into Linux for now.
>
> The goal is to have preliminary reviews and to fix problems early.
>
> The Kalray VLIW processor family (kvx) has the following features:
> * 32/64 bits execution mode
> * 6-issue VLIW architecture
> * 64 x 64bits general purpose registers
> * SIMD instructions
> * little-endian
> * deep learning co-processor

Thanks for posting these, I had been wondering about the
state of the port. Overall this looks really nice, I can
see that you and the team have looked at other ports
and generally made the right decisions.

I commented on the syscall patch directly, I think it's
important to stop using the deprecated syscalls as soon
as possible to avoid having dependencies in too many
libc binaries. Almost everything else can be changed
easily as you get closer to upstream inclusion.

I did not receive most of the other patches as I'm
not subscribed to all the mainline lists. For future 
submissions, can you add the linux-arch list to Cc for
all patches?

Reading the rest of the series through lore.kernel.org,
most of the comments I have are for improvements that
you may find valuable rather than serious mistakes:

- the {copy_to,copy_from,clear}_user functions are
  well worth optimizing better than the byte-at-a-time
  version you have, even just a C version built around
  your __get_user/__put_user inline asm should help, and
  could be added to lib/usercopy.c.

- The __raw_{read,write}{b,w,l,q} helpers should
  normally be defined as inline asm instead of
  volatile pointer dereferences, I've seen cases where
  the compiler ends up splitting the access or does
  other things you may not want on MMIO areas.

- I would recomment implementing HAVE_ARCH_VMAP_STACK
  as well as IRQ stacks, both of these help to
  avoid data corruption from stack overflow that you
  will eventually run into.

- You use qspinlock as the only available spinlock
  implementation, but only support running on a
  single cluster of 16 cores. It may help to use
  the generic ticket spinlock instead, or leave it
  as a Kconfig option, in particular since you only
  have the emulated xchg16() atomic for qspinlock.

- Your defconfig file enables CONFIG_EMBEDDED, which
  in turn enables CONFIG_EXPERT. This is probably
  not what you want, so better turn off both of these.

- The GENERIC_CALIBRATE_DELAY should not be necessary
  since you have a get_cycles() based delay loop.
  Just set loops_per_jiffy to the correct value based
  on the frequency of the cycle counter, to save
  a little time during boot and get a more accurate
  delay loop.

    Arnd
