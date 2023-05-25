Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF2710A5B
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 12:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbjEYKwk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 06:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238970AbjEYKwi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 06:52:38 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2AB199;
        Thu, 25 May 2023 03:52:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 6FAD52B0681B;
        Thu, 25 May 2023 06:52:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 25 May 2023 06:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685011952; x=1685019152; bh=DU
        FYLgNR0P3iMDujbNPJ6zcWMVF2ZDhcLM/UDfvQ7oE=; b=MOQIz0mdsCpzsJDpOT
        8ymmHxd6/8U/1WrSlAu+26J9rPY+bl/QIyP7HlCrsPmJUlV8qXrewBBWaZM/zPbl
        Avlzez1zIuARarFB8Q+CSpanGgDvavP3UvS7jOZjuO8BEJC5Skq+WhgsPSE7BYso
        huvQr31ejgwQADplhhctQIrYZoiYvP65bWrP7Ep2/ENITKCKFjM+ORNVQInWBB/U
        e1xnq3JiYlOQMGLPzi2Gn4d5fn7nPmSS0o6PhQUi+JS4X88aY797/1dcU900mr0r
        b8dxJ/azB1vY1PWRzlUrX+dxP0NYO2gi5TQFJt7KPkijRDPkRNSWoC8W0yTowW0l
        f+Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685011952; x=1685019152; bh=DUFYLgNR0P3iM
        DujbNPJ6zcWMVF2ZDhcLM/UDfvQ7oE=; b=EflHhJQg9wl2mG7bcZk8ETaFCFS2e
        +KCM2ZXWihEVKvLhonnr7dOUeqG2bh5qJx2FysmmLCMzUPG+HlbFcFxvGE9Yt6Rg
        c1Zq4zh4OEYt+Q71eWIJqiin1aNt49jXbiLQh9SJE62wFNAo911XNBoucik+Gzc8
        cspfKUzRXOjWxDMSK7p38IylIxc/LuzE632/sGzGIEm6R1Y34aKYTzNNhuewVS6x
        mPkAw7cYASaqD4haDeYKF5F8Li1HLZYnk6WFDdHQJiPyYzjJou5z/uFu4KgXX886
        wVCJOeYCov0f/WDjAlcaoDUMGPabIC66aH+QqtLdoHG3Q/7JEQQMjfKGQ==
X-ME-Sender: <xms:7D1vZO4QU9Jez8-ha0NTKuIxJkxVOyWMOw59fwy-mdgdKCWyERZ0Qw>
    <xme:7D1vZH4l8nWr7ujQavOzUH-YdKW1mkNYstrhjZKuCzbgYa4fM7wmWEDCrZfB3fK5i
    E6t_sOrA2-CCtDMUqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:7D1vZNeCUZGBr8hqNazi1vE2XPDcy56nt9wPzXEdZqoJHZzP3_eX-w>
    <xmx:7D1vZLJLWXCFdXo0PikDzn15lfJXSQx6C7gtfm9COaeI2OXgWNRmiw>
    <xmx:7D1vZCLrYnBxTsTvaUHJd6WCBIVu4xSqVNpfgBb3TGefKjjwmCI_bg>
    <xmx:8D1vZJLI8FQKNsj_QLZ7J4Fw_p8dg7sgs9AIRGxRbmH08jCfAongICIo1Eg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C3EA8B60086; Thu, 25 May 2023 06:52:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <292934ce-73fa-4077-9051-2ad909828f4a@app.fastmail.com>
In-Reply-To: <20230525102946.GE38236@hirez.programming.kicks-ass.net>
References: <20230515075659.118447996@infradead.org>
 <20230515080554.453785148@infradead.org>
 <20230524093246.GP83892@hirez.programming.kicks-ass.net>
 <20230525102946.GE38236@hirez.programming.kicks-ass.net>
Date:   Thu, 25 May 2023 12:52:06 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Peter Zijlstra" <peterz@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Jonathan Corbet" <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>, dennis@kernel.org,
        "Tejun Heo" <tj@kernel.org>, "Christoph Lameter" <cl@linux.com>,
        "Heiko Carstens" <hca@linux.ibm.com>, gor@linux.ibm.com,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, "Sven Schnelle" <svens@linux.ibm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel" <joro@8bytes.org>,
        suravee.suthikulpanit@amd.com,
        "Robin Murphy" <robin.murphy@arm.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Baolu Lu" <baolu.lu@linux.intel.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Pekka Enberg" <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Hyeonggon Yoo" <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 08/11] slub: Replace cmpxchg_double()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 25, 2023, at 12:29, Peter Zijlstra wrote:
> On Wed, May 24, 2023 at 11:32:47AM +0200, Peter Zijlstra wrote:
>> On Mon, May 15, 2023 at 09:57:07AM +0200, Peter Zijlstra wrote:
>
> This then also means I need to look at this_cpu_cmpxchg128 and
> this_cpu_cmoxchg64 behaviour when we dont have the CPUID feature.
>
> Because current verions seem to assume the instruction is present.

As far as I could tell when reviewing your series, this_cpu_cmpxchg64()
is always available on all architectures. Depending on compile-time
feature detection this would be either a native instruction that
is guaranteed to work, or the irq-disabled version. On x86, this
is handled at runtime with alternative_io().

this_cpu_cmpxchg128() clearly needed the system_has_cmpxchg128()
check, same as system_has_cmpxchg_double() today.

     Arnd
