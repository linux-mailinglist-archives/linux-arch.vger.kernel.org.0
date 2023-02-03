Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE9868A0D5
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 18:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjBCRvf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 12:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjBCRve (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 12:51:34 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A3783F8;
        Fri,  3 Feb 2023 09:51:21 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id C60BE582007;
        Fri,  3 Feb 2023 12:25:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 03 Feb 2023 12:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675445135; x=1675452335; bh=WOj1XJ/2nW
        hhYICuUWvW/halINqVJ3cfLXpbNnnM1BY=; b=b16DgUjGr10ahekmo+ZIsgBmwH
        NI+4WKiYPn0WRip7ki2No6/JcXSEn5Lbchwr0PX4NJN4lZDK/RDjs5Y94yJM0ggC
        5JAdFObkE0yrMYUboTNDTueCCZ/jMUgQdLERu0cCkQyqwP2mQ/nbcj9IlEgvkNDu
        kYscEQW5aPKbRIpuSz9VJ1Gjku5hfKhRLWalPFD8O4wjXGCtju1rGzPBqPmfh0+F
        C+v8aQzPfNrMRqHt6Y4zRdZsvFi2gaFgnMrO4eHfnIjNvBwmaMzspYjxyu/FTHU8
        Kect+k+Hs3CGy3Ro6Nsd8+xuC98eXMBBmkaA5enHge8egtEYjQ899wWzQXjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675445135; x=1675452335; bh=WOj1XJ/2nWhhYICuUWvW/halINqV
        J3cfLXpbNnnM1BY=; b=ndNbp+CxgZoarRRJg0oDB1vu4ErnnZgQS9OnLuWKTxJ3
        rZsTad8uHfRNwCp3NH9sjW3eSUBjBT90p6HLG+cI4sDwH5CdapVchP2gGhkYXqDl
        7GiE90ULhcZqBEwWeTskCI3DL48asLTwbW65TIZwFlNRm+TtDxecNFlIkuy0I6W3
        x5tof5n4OYnE5HG4V4JoORLn7VxtHBxUXzWp3dTqBWZjAzZF8qMHeowxswghIZi6
        IBFFhovJvoh7fNI40KDbP/tFtIJLeFomNfM3wl/+Xz+Pim6Zs6EGiSC/Yha+XLPe
        2+XVk1aLuV0zQOzcvp3wMLMAoyn8vMzYzYYr5a9KWw==
X-ME-Sender: <xms:jUPdYw7P6JnOYeN8iVeMNrpkTwrTbP8jzfhe_AeB0wWU4AGZJ0ydzQ>
    <xme:jUPdYx7ZBP_oam7Utuhlz8bYRrfCtkYTOiUD_Zwf4E-ytw7QNteB5TeHvFvXmASTj
    1UsZEEUzcT1qMIF4WE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegtddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:jUPdY_e9KRM9ZbeTMsHtXXWE5CukEx6HAbnENBBhMVXHkp_an_WOjA>
    <xmx:jUPdY1I4CUAZY-Bp5g6StetrxCGSeaG2raErr07Q6bwJAGAL3BNzjg>
    <xmx:jUPdY0JrYtCQXVjTuwyWdhYJ8TY4Hg1WUFzvGpzaxx2LW0ah7BzuRA>
    <xmx:j0PdYyakU9xoWDa5ryktR4FHchVeWoQd1ZNOvmSn4fM710A1pe4JuA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 78555B6044F; Fri,  3 Feb 2023 12:25:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <24007667-1ff3-4c86-9c17-a361c3f9f072@app.fastmail.com>
In-Reply-To: <20230202152655.494373332@infradead.org>
References: <20230202145030.223740842@infradead.org>
 <20230202152655.494373332@infradead.org>
Date:   Fri, 03 Feb 2023 18:25:04 +0100
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

On Thu, Feb 2, 2023, at 15:50, Peter Zijlstra wrote:
> In order to replace cmpxchg_double() with the newly minted
> cmpxchg128() family of functions, wire it up in this_cpu_cmpxchg().
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I commented on this in the previous version but never got any
reply from you:

https://lore.kernel.org/all/1d88ba9f-5541-4b67-9cc8-a361eef36547@app.fastmail.com/

Unless I have misunderstood what you are doing, my concerns are
still the same:

>  #define this_cpu_cmpxchg(pcp, oval, nval) \
> -	__pcpu_size_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
> +	__pcpu_size16_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
>  #define this_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, 
> nval2) \
>  	__pcpu_double_call_return_bool(this_cpu_cmpxchg_double_, pcp1, pcp2, 
> oval1, oval2, nval1, nval2)

Having a variable-length this_cpu_cmpxchg() that turns into cmpxchg128()
and cmpxchg64() even on CPUs where this traps (!X86_FEATURE_CX16) seems
like a bad design to me.

I would much prefer fixed-length this_cpu_cmpxchg64()/this_cpu_cmpxchg128()
calls that never trap but fall back to the generic version on CPUs that
are lacking the atomics.

     Arnd
