Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FFB68BE2C
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 14:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBFNbC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 08:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBFNa6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 08:30:58 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52120A5C5;
        Mon,  6 Feb 2023 05:30:48 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 47B8E581FCA;
        Mon,  6 Feb 2023 08:20:27 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 06 Feb 2023 08:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675689627; x=1675696827; bh=YEEKxWvDaU
        UtEFigpSanl+1o6NoqA2MTTLwchnDt7mc=; b=JJZuuSyMXi8+7dbMJeo+D5x90Q
        QSbmGMLSv82Wox3Is7pYL6nhbEWJBfC0wbE6oSvPTHqWQlE4S2v1bVxYTpkKfNnK
        y8m5HTeGnuwwsAD7ZZ/Q5cz/1UGExNYutXiIkce2Je9GS2BfYijaO1nPMpyEnLWr
        e1MxJrchORh3tiGvi4noN95wywfSBXFN8OHGqnJ+ZaCd4RHMwutetH/6Sbd12cji
        2SXSakWZMLrIogUEFOmJzEZa7IigmbvUSyaMF7rDnUNQDshLq7sV/QJTa+Bm/lbD
        AYSybO0NjenKBsowbzxVsgQxpoJxGppz/CNhM9yfZz9cvm68/YozcNpmfl6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675689627; x=1675696827; bh=YEEKxWvDaUUtEFigpSanl+1o6Noq
        A2MTTLwchnDt7mc=; b=KRQjthpW7gLPW560Bl7atCLRmIn2E7b44jydvggP3nts
        V9EQyO1jI7xhj/PaB6Fw7rijYTBROEnM7JBkgAxTMlEK/nvofQ6gCC9o0toDI1mK
        1e34kfAUyoBC8rCDYv4yKTzg3Rs83/ceaAksG7AaJcQ5CudvZhUJNzpFFGnNtFUs
        oTmdC/2MFKSomfaBaN/1og55RxtXWQBUxpKWjd+g4OPFIO3Cy8cCm5T3mYnswIpa
        +7jyNRgX0ExN4Wdu3h6A3lqGV4Hsikw4md/C7hMVJAALwT7aZZYlvy8sDNefeghT
        P0bAjLowOlA3PmNDGQnzD87RWuAk2krAFZokgXES2Q==
X-ME-Sender: <xms:mf7gY3foy0vdkEfg6nDAo-B7hqZwkLBctiTaAbFv7FRBT1mOsdtWCw>
    <xme:mf7gY9MAV0AzwLHZ58z5Gsc5pDW1kC76uT6ALWEjNsFllcVehpPeP9y2OiWwGwrIL
    B5dUScsbPfqBDdBtsc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegiedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:mf7gYwhErUMLiE8ckBfrt1leyzv5fLxQUxR0yy-vfBSj3VPXrlrf_A>
    <xmx:mf7gY4-TKGg2qSpA-Ql4Q76CcYHKsKWfJx2ltb6rViaRwX2xpB9wKA>
    <xmx:mf7gYzsS8RMxI7v2oEYaAkRyWFamtuSzaJQEDtWi58FRx7SVZ_MvFA>
    <xmx:m_7gY5vB_pxzNaeJp31Wk1pS-jfDAK-fntPE2o5v-Ht24Fv0S-HWQg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 35F87B60086; Mon,  6 Feb 2023 08:20:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-108-ge995779fee-fm-20230203.001-ge995779f
Mime-Version: 1.0
Message-Id: <86c8ba70-2a2f-4c5b-8e74-20e3823e2db3@app.fastmail.com>
In-Reply-To: <Y+D3F2pg7X4XFT4r@hirez.programming.kicks-ass.net>
References: <20230202145030.223740842@infradead.org>
 <20230202152655.494373332@infradead.org>
 <24007667-1ff3-4c86-9c17-a361c3f9f072@app.fastmail.com>
 <Y+DjULnIxcPU/rtp@hirez.programming.kicks-ass.net>
 <Y+DvI7ai/wuovjER@hirez.programming.kicks-ass.net>
 <Y+D3F2pg7X4XFT4r@hirez.programming.kicks-ass.net>
Date:   Mon, 06 Feb 2023 14:20:06 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Peter Zijlstra" <peterz@infradead.org>
Cc:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
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
        "Robin Murphy" <robin.murphy@arm.com>, dwmw2@infradead.org,
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
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 05/10] percpu: Wire up cmpxchg128
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 6, 2023, at 13:48, Peter Zijlstra wrote:
> On Mon, Feb 06, 2023 at 01:14:28PM +0100, Peter Zijlstra wrote:
>> On Mon, Feb 06, 2023 at 12:24:00PM +0100, Peter Zijlstra wrote:
>> Basically, using 64bit percpu ops on 32bit is already somewhat dangerous
>> -- wiring up native cmpxchg64 support in that case seemed an
>> improvement.
>> 
>> Anyway... let me get on with doing explicit
>> {raw,this}_cpu_cmpxchg{64,128}() thingies.
>
> I only converted x86 and didn't do the automagic downgrade...
>
> Opinions?

I think that's much better, it keeps the interface symmetric
between cmpxchg and this_cpu_cmp_cmpxchg, and makes it harder
to run into the subtle corner case on old x86 CPUs.

For the M486/M586/MK8/MPSC/MATOM/MCORE2 configs, I would
probably want to go with a compile-time check and have most
distro kernels build with at least M586TSC for 32-bit or
an upgraded CONFIG_GENERIC_CPU for x86_64 that assumes cmpxchg16b
(nehalem, second-geneneration k8, silverthorne, ...) in
order to turn system_has_cmpxchg* into a constant value on
all architectures. That can be a separate discussion though
and shouldn't block your series as you just keep the current
state.

> -#ifdef system_has_freelist_aba
> +#ifdef syste_has_freelist_aba

Typo

    Arnd
