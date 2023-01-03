Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4E965C439
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 17:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbjACQvJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 11:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbjACQu6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 11:50:58 -0500
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AAC12D28;
        Tue,  3 Jan 2023 08:50:28 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 36F072B06721;
        Tue,  3 Jan 2023 11:50:23 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 03 Jan 2023 11:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672764622; x=1672771822; bh=OAEx+kWOpU
        s1ovkCOUPYt4BrguZtb4ZebjcqYHg4/yk=; b=SAmVbdnFaBzWfpnFGzV4NSDsrp
        w/oJNVKvqGJxgxv+5cuJf5nW1Un9vV0Dp+Wz/8PRNAPQi9a6E9iB6P7fPKvjIxDc
        sL4HDcHtwrl7pXHk7V3MgPQWqu05FxSbB9sUvpWN9KKGs4x8vL+qIY/u0O2fp32A
        WAqTXa3KI/HWcNdqPcB+rYggrEcH15MpJ6Rkc4JPKXgau/UtLCWzNDxTa3kwfqeV
        zzXlg1coYrCQvujOFEC7eWm3ZTrIXSENwnHXqfIt0HR4tRDATgdIYXJK/5Nklyc9
        aK1RL7dvFw5nAF9DzxYqmKbi/kWMx9keHmBbHeA7s/EWyr+VxGNjwhtKapYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672764622; x=1672771822; bh=OAEx+kWOpUs1ovkCOUPYt4BrguZt
        b4ZebjcqYHg4/yk=; b=Os1ym1lstngE1yum7vioqidaf0tpUcIIddLV9oaWSOfr
        Bp/LOs8s1eDc1lv7yge46iL+oTo/wMkxx27m9Yc6N3aV2TFIrYSkjiZdPQ8Dixm+
        MdtzUXOxkrF8n3jv67bTVLyIeEpdtwhZZbr6DRy6eSsxHEeLTvrwGMCkx5wOQru3
        LcNlUNWCaMJK5m1qqNpuLPnUa66cfWOJJRIOlVox9K7/RRqPZ9SJl0dYQTo66EU5
        cPPwriRMEe+ZdKHvf4o8MaE+JiGSbpGlrJv8+wqaIVkBvWZfTB6lLcEQvdFquzkx
        fChHnH7XWHxMTXIIMydoHXwDKugKo6A7KVet7ij5Nw==
X-ME-Sender: <xms:zVy0Y_OMAKlPmEOZgHU3a6aRFfK4FxfhdvwVIklHrp_YRo8o61lqRQ>
    <xme:zVy0Y59x2GX8W2BoN-3zVKBdj25Ajq9AP-OrqTzquZvM2wI-7Ix0NtTzj27YrKddM
    tZvWCMnOIl-fW65cx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeggdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefhfeehgfejkedugeeutdffveehheeugfehgeelleefudeluedtgfejffeihffh
    heenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdguvggsihgrnhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggv
X-ME-Proxy: <xmx:zVy0Y-SSMWtvnv9ZxmJhry6mi4BiUHZLH8otfjVaL1ZvtYqw_HgNxg>
    <xmx:zVy0YzvPJ5VhbjYKcO9WXl04J_Mdvuydp68lACKnB0sC0DcdlpA9uw>
    <xmx:zVy0Y3cCyrZtBDo3MJ4Hdt1EHAWboT_3ZNKcff2QNMqRJXhlhsucqg>
    <xmx:zly0Y2fTU14izRdahtJutvIauGNC4i8YnSE3hUn7fbjaIA917RmO5fEWBSI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 465BAB60086; Tue,  3 Jan 2023 11:50:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <8fea3494-1d1f-4f64-b525-279152cf430b@app.fastmail.com>
In-Reply-To: <Y7RVkjDC3EjQUCzM@FVFF77S0Q05N>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.154045458@infradead.org> <Y6DEfQXymYVgL3oJ@boqun-archlinux>
 <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
 <Y7QszyTEG2+WiI/C@FVFF77S0Q05N> <Y7Q1uexv6DrxCASB@FVFF77S0Q05N>
 <Y7RVkjDC3EjQUCzM@FVFF77S0Q05N>
Date:   Tue, 03 Jan 2023 17:50:00 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Mark Rutland" <mark.rutland@arm.com>,
        "Peter Zijlstra" <peterz@infradead.org>
Cc:     "Boqun Feng" <boqun.feng@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>, dennis@kernel.org,
        "Tejun Heo" <tj@kernel.org>, "Christoph Lameter" <cl@linux.com>,
        "Heiko Carstens" <hca@linux.ibm.com>, gor@linux.ibm.com,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, joro@8bytes.org,
        suravee.suthikulpanit@amd.com,
        "Robin Murphy" <robin.murphy@arm.com>, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, "Pekka Enberg" <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Hyeonggon Yoo" <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC][PATCH 05/12] arch: Introduce arch_{,try_}_cmpxchg128{,_local}()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 3, 2023, at 17:19, Mark Rutland wrote:
> On Tue, Jan 03, 2023 at 02:03:37PM +0000, Mark Rutland wrote:
>> On Tue, Jan 03, 2023 at 01:25:35PM +0000, Mark Rutland wrote:
>> > On Tue, Dec 20, 2022 at 12:08:16PM +0100, Peter Zijlstra wrote:

>> ... makes GCC much happier:
>
>> ... I'll go check whether clang is happy with that, and how far back that can
>> go, otherwise we'll need to blat the high half with a separate constaint that
>> (ideally) doesn't end up allocating a pointless address register.
>
> Hmm... from the commit history it looks like GCC prior to 5.1 might not be
> happy with that, but that *might* just be if we actually do arithmetic on the
> value, and we might be ok just using it for memroy effects. I can't currently
> get such an old GCC to run on my machines so I haven't been able to check.

gcc-5.1 is the oldest (barely) supported compiler, the minimum was
last raised from gcc-4.9 in linux-5.15. If only gcc-4.9 and older are
affected, we're good on mainline but may still want a fix for stable
kernels.

I checked that the cross-compiler binaries from [1] still work, but I noticed
that this version is missing the native aarch64-to-aarch64 compiler (x86 to
aarch64 and vice versa are there), and you need to install libmpfr4 [2]
as a dependency. The newer compilers (6.5.0 and up) don't have these problems.

     Arnd

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/arm64/5.5.0/
[2] http://ftp.uk.debian.org/debian/pool/main/m/mpfr4/libmpfr4_3.1.5-1_arm64.deb
