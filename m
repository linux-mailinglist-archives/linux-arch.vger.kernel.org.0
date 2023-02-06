Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E55268BCB2
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 13:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBFMUF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 07:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBFMUD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 07:20:03 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAA3DBF4;
        Mon,  6 Feb 2023 04:20:02 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id BEDE0581F89;
        Mon,  6 Feb 2023 07:19:59 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 06 Feb 2023 07:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675685999; x=1675693199; bh=EttWCI1bpe
        AjhBiaJSAzg8VXO8QdUkkL5lYBTi6kKQM=; b=maQtG7CXW2j0vs9LdTv/Far0Kj
        r+JQ8DrPxOijBj5u/M26nfyCBg3LxOaSsoSj863bQj93nOQt4obnx4yBCRfGWoom
        VPyhj9PwipzQQmE41f2irREabq1vHc4ubDRvewHR1SzZChLeVlrXH0nfIHWBleeE
        RO/tfMb77+jVXkYb4Td8o9TS+Fr/9JaIPlh0TKo/wohxWZnBLwn8PUfeH7QVBtCx
        Wqrq8iqLfP/yc8jgZ0wd6C+KZi1EkperQDi+XjIq/+qyBj282AOUruNzvU+apOiU
        UrBvkzmnKoxYB2gQP5BM2fjtXoNWI0Wg0pjpuL7zBhyE5qlhjYETNv+Ld2Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675685999; x=1675693199; bh=EttWCI1bpeAjhBiaJSAzg8VXO8Qd
        UkkL5lYBTi6kKQM=; b=HbjcZlBHM73FLUMGEg7g7Txy3GkpYltTnf/zta3DkBCu
        vVtq6kehTsHtsjC4kcAls1wCwzA/hPgTf1m7qcEXHGNxri+4cilSJgq7EUXgwqnZ
        9Cx7AO3RuNKm8gvh57qoAZI+7DiggrksU0tGQKZGsndoxp5VyChBY2/2dNuQOI0+
        7/I/NfA9CM7eDn8EDMmm6HSPztcSgzps4TzOuFyVR8pJYEmd0YxAuc1qjpMy8mcR
        l8QbPS2Vwyc8TV/DerYXjwbRgpCWytjcTigKukYttUCDZVEH1rzWDdbNeUYTx6VU
        EZWD42Z2YdEcJHF4ltoafp7TQFLVqoWipL0uxiVVQQ==
X-ME-Sender: <xms:bPDgY5KzB2ri1Ul3J4ZZ-u0ujckW1ael6I62cn_VIyX43QnGR2WNWw>
    <xme:bPDgY1K9Kn-IaYAdfhgU412LtP9SdQG1xiY0grMcfY8NtDIa-IhyFe9Wbig3N-y9b
    vlTK-o2ewogd7npLzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:bPDgYxugQiZwrOa8DZy7dYElDk2UcABpqCFI_C0314MlOUG708AHng>
    <xmx:bPDgY6bZ_W1evxK2IksLFVeC6lvA7NqXGKBJEfyKrID7MKWT2MW5Hw>
    <xmx:bPDgYwaU7LvC6nJpoeuF95cXIo7XRoCoCG2Fas_NKl7HMaOw82Kk1Q>
    <xmx:b_DgY1qnEwX0fd-s6xmNm76Jo2tfbVaOegUXXSMsFnzIZaabdBntJA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D47B2B60086; Mon,  6 Feb 2023 07:19:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-108-ge995779fee-fm-20230203.001-ge995779f
Mime-Version: 1.0
Message-Id: <30e43e0b-4d16-433f-845d-dd026adfb252@app.fastmail.com>
In-Reply-To: <Y+DjULnIxcPU/rtp@hirez.programming.kicks-ass.net>
References: <20230202145030.223740842@infradead.org>
 <20230202152655.494373332@infradead.org>
 <24007667-1ff3-4c86-9c17-a361c3f9f072@app.fastmail.com>
 <Y+DjULnIxcPU/rtp@hirez.programming.kicks-ass.net>
Date:   Mon, 06 Feb 2023 13:19:38 +0100
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

On Mon, Feb 6, 2023, at 12:24, Peter Zijlstra wrote:
> On Fri, Feb 03, 2023 at 06:25:04PM +0100, Arnd Bergmann wrote:

>> Unless I have misunderstood what you are doing, my concerns are
>> still the same:
>> 
>> >  #define this_cpu_cmpxchg(pcp, oval, nval) \
>> > -	__pcpu_size_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
>> > +	__pcpu_size16_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
>> >  #define this_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, 
>> > nval2) \
>> >  	__pcpu_double_call_return_bool(this_cpu_cmpxchg_double_, pcp1, pcp2, 
>> > oval1, oval2, nval1, nval2)
>> 
>> Having a variable-length this_cpu_cmpxchg() that turns into cmpxchg128()
>> and cmpxchg64() even on CPUs where this traps (!X86_FEATURE_CX16) seems
>> like a bad design to me.
>> 
>> I would much prefer fixed-length this_cpu_cmpxchg64()/this_cpu_cmpxchg128()
>> calls that never trap but fall back to the generic version on CPUs that
>> are lacking the atomics.
>
> You're thinking acidental usage etc..? Lemme see what I can do.

I wouldn't even call it accidental when the dependency is so subtle:

Having to call system_has_cmpxchg64() beforce calling cmpxchg64()
is already somewhat awkward but has some logic to it. Having to
call system_has_cmpxchg64()/system_has_cmpxchg128() before calling
this_cpu_cmpxchg() depending on the argument size on architectures
that sometimes have cmpxchg128 but not on architectures that always
have it or that never have it makes it useless as an abstraction.

     Arnd
