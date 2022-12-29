Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C427658D91
	for <lists+linux-arch@lfdr.de>; Thu, 29 Dec 2022 14:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiL2Nkf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Dec 2022 08:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiL2NkI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Dec 2022 08:40:08 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B73517073;
        Thu, 29 Dec 2022 05:37:37 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id D47B95818EC;
        Thu, 29 Dec 2022 08:36:54 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 29 Dec 2022 08:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1672321014; x=1672328214; bh=lvF0202SLO
        TzT8hbWZsF0xJL4uK7PlwT0Y7oJgXZa8M=; b=nLBnuo5MB8ib40z9s0xLWilN6X
        /WXV1Zqm3SxWb/ruB/kuFnhd7wdVmFZDNY+gYekuqiDs/3zSKTYpDCWeSGomp00d
        RPXAAm15lH7k/HckP7H41S1nTIssGFqnGEUCiAueXZhfqHbgvsgt2V/PjS5+24eK
        AZrmaFdvUCvnyYqeGiXNjFNJi0Nt+kY19b5QAViPegESXxc5lkw5/x38rzXBkE3E
        iMI/LuxJaJhu/PzxHG/w2bIL1OevR4DRQqXzZhgnnNrL6JlGZ2hfawrGtcjmfT5j
        4NFrf2y4B2F4odzFC/4UEfyR9o8m6Tb2OX8h3xaP+cQbWCLPHyzz+PMCgWqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672321014; x=1672328214; bh=lvF0202SLOTzT8hbWZsF0xJL4uK7
        PlwT0Y7oJgXZa8M=; b=Jr7RZJ443Rh8Qo+omI31KtzhJxzRr/gmnxzyHbaByHQ4
        STqt+Vc4cv+k0j8Dn73jUOrcx91eQtuXMzjq9aHKcghW7M7CCsGYLd01CHiSCaAJ
        imgUtF7DvNdZzdYbFAKU118qzhWZ45FFNkuq01JO3G44O8dNsNM026hoPloISUUK
        uLAuPol2cYeE+H6rlz4SUHqOMhoDdaT6jlH1aTcg49YvTbDlhhD5kYpLI5s8bJxE
        VEdpvdUeBr2HOtE5jiNe1JbI9qe+BqGW8ENvyet3ESOPsDs6y7wveuue+TeGQ6OF
        63+RmCQO5AYjeEdbwbZySMWQsDDFqh1CfW/rw6fbgQ==
X-ME-Sender: <xms:9JetY317jGDP8GU6R9s5P3feYX4b7JYnXuYW9oxrPtX4neZSlQhn_g>
    <xme:9JetY2H-9Ndmta7egwtoh9Qd7iKWQAb1a1Gysv2bD9db8yknC1mA_eZz9GoINFs1O
    mxmkGXxxIrZhDgI32M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:9JetY37Np6b49AaL3STy0ZgjFyhCS7H5vsUZxB6VrMJPnKFk2gWG_Q>
    <xmx:9JetY80eHbEBLheoSTsnWIIch3xp-KorU8P9-48XP3Ihye8VysyR4g>
    <xmx:9JetY6EPUvpUXO4ud7kX_WBGQ-K_e16zVv9iLREEkWdF5C8vmD3ZiA>
    <xmx:9petY6ndaNDL17h1d1VwhHZdsw1NSQgvJDADFPi05YBImlRtM5t8dA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 640B9B60086; Thu, 29 Dec 2022 08:36:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <1d88ba9f-5541-4b67-9cc8-a361eef36547@app.fastmail.com>
In-Reply-To: <20221219154119.286760562@infradead.org>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.286760562@infradead.org>
Date:   Thu, 29 Dec 2022 14:36:32 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Peter Zijlstra" <peterz@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Jonathan Corbet" <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>, dennis@kernel.org,
        "Tejun Heo" <tj@kernel.org>, "Christoph Lameter" <cl@linux.com>,
        hca@linux.ibm.com, gor@linux.ibm.com,
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
Subject: Re: [RFC][PATCH 07/12] percpu: Wire up cmpxchg128
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 19, 2022, at 16:35, Peter Zijlstra wrote:
> In order to replace cmpxchg_double() with the newly minted
> cmpxchg128() family of functions, wire it up in this_cpu_cmpxchg().
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Does this work on x86 chips without X86_FEATURE_CX16?

As far as I can tell, the new percpu_cmpxchg128_op uses
the cmpxchg16b instruction unconditionally without checking
for the feature bit first, and is now used by this_cpu_cmpxchg()
unconditionally as well.

This is fine for the moment if the only user is mm/slub.c
and that retains the system_has_cmpxchg128() runtime check,
but I think a better interface would be to guarantee that
this_cpu_cmpxchg() always ends up either in a working
inline asm or the generic fallback but not an invalid
opcode.

For consistency, I would also suggest this_cpu_cmpxchg() to
take the same argument types as cmpxchg(): at most 'unsigned
long' sized, with additional this_cpu_cmpxchg64() and
this_cpu_cmpxchg128() macros that take fixed-size arguments.
I have an older patch set that additionally converts all
8-bit and 16-bit cmpxchg()/xchg() calls to cmpxchg_8()/
xchg_8()/cmpxchg_16()/xchg_16() and and leaves only the
fixed-32bit and variable typed 'unsigned long' sized
callers for the weakly typed variant.

       Arnd
