Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BBC702968
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 11:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjEOJpa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 05:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbjEOJpL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 05:45:11 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFDC1BD7;
        Mon, 15 May 2023 02:43:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id DD5495803CE;
        Mon, 15 May 2023 05:43:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 15 May 2023 05:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684143821; x=1684151021; bh=rh
        DpJI+VS2ftRNM4C+B3O914qD0XGOeUnvYVI19CEcc=; b=ouvD58uxjfNX4wP0nP
        xvpLpKJ0T+XQe0vE3+HQlIgXzQFoYhQav58t5Dt2KUNupaE1hauor5HqsvRweZIA
        n7VUIbSESGSsJAS4/IBRJKBSsxxY38GuTgOajMXeSWSgJQimKnSYKuYGHWHVY4NP
        /Z9Gf1cMeQiyDMZN5qrJRzyawySnZgkgQbE4fwGD0ipwb+g7TY93g3qvv7gHFwjA
        LLXU0AdO2UkJkc2revwtVIywBQkAzGtx29mZ5LC6bOrEx+xHyUGvBZi9mcGzUgv7
        bZKliDv8gyReD6p2qApGsiWp78ZcFzHWVRJfXszfRmnRY8Ih0GVViZweQT8LUDUT
        mtnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684143821; x=1684151021; bh=rhDpJI+VS2ftR
        NM4C+B3O914qD0XGOeUnvYVI19CEcc=; b=W0CbDVAPadlsN/NG6WntcvQsG7eam
        98jhjJQ/QA65KOBFXAByPwX2xRzcv5kefvCfHPyQfFXa0MZRfWDETlJBF1OM7JTd
        KGU/Srx/r17/VNHIFDuh+T58q6Lcf9BWxvGxNcF3d0lxRehwVtidwFFf4DBPLiXJ
        cJfmJ30HkBGxX4vJRin9a4WPll+IgH7hNRfqTxWjs8QSbe4SPY5P4YZHkg9FjAh6
        Vckfzq4j7n1ln9MnIkonN2rGXhPG0IqlKgKNjAzWvEmgORkY0ycBuLQj62JeA408
        +aj8JQv1XXfSBVZ5xCX6pwqZJ1zQHl98KBdzzqe14Hydi21btJoSo9DIA==
X-ME-Sender: <xms:y_5hZKy7-ycOVkrUGZnJEVNTV3o6YuyL_MeHS-twItZHxAUa3nejWw>
    <xme:y_5hZGSMUaPvv901TovUBRVAUK_jevHQqJtWvocrwJVgb2lacmpWr56gmq4_8jr92
    yS_vMMHlrogk3gXavU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:y_5hZMX2aul_vmm39YeEhHkNWk0zLtYqTE5NC3HBR9sayqdtv0vKtw>
    <xmx:y_5hZAh8vxQdrl9TrGbz6lAoeU8NgKb2AF_qgUO4jxo84uU8puLK3A>
    <xmx:y_5hZMDDmmLTxLsN8FYBvs8HP-DutPDML8AhpGWpw48AuKcy5Vu4_Q>
    <xmx:zf5hZOyPkZngc4eRCdWmxCUqxpL7o310qROMxzps2Vc0Ig1f5oDEJg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7747DB60086; Mon, 15 May 2023 05:43:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <4975b92f-92f6-4d50-8386-9add12ddfd61@app.fastmail.com>
In-Reply-To: <20230515075659.118447996@infradead.org>
References: <20230515075659.118447996@infradead.org>
Date:   Mon, 15 May 2023 11:42:23 +0200
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
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Introduce cmpxchg128() -- aka. the demise of
 cmpxchg_double()
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

On Mon, May 15, 2023, at 09:56, Peter Zijlstra wrote:
>
> Since v2:
>
>  - reworked this_cpu_cmpxchg() to not implicity do u128 but provide explicit
>    this_cpu_cmpxchg128() (arnd)
>  - added try_cmpxchg12_local() (per the addition of the try_cmpxchg*_local()
>    family of functions)
>  - slight cleanup of the SLUB conversion (due to rebase and having to touch it)
>  - added a 'cleanup' patch for SLUB, since I was staring at that anyway
>

This is clearly an improvement over the previous state, so I'm
happy with that, and the explicit this_cpu_cmpxchg128() interface
addresses most of my previous concerns.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

The need for runtime feature checking in the callers on x86-64 is still
a bit awkward, but this is no worse than before. I understand that
turning this into a compile-time choice would require first settling
a larger debate about raising the default target for distros beyond
the current CONFIG_GENERIC_CPU.

    Arnd
