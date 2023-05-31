Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1241C7184C4
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 16:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbjEaOWx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 10:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbjEaOWc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 10:22:32 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE2EE51;
        Wed, 31 May 2023 07:21:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 44D65580177;
        Wed, 31 May 2023 10:21:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 31 May 2023 10:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685542905; x=1685550105; bh=EB
        qVSuczL8zsM7Z+quPoEDfVsyxlfcBd6Pp556uYrbw=; b=OzFEpTKSe5S3pZEmFP
        KK1uM3LsgMCSyqEpKXgp8mQacr9rZEDCmrd2k8BVEDg3tEc7xY/t0qJaQdSDGOT2
        bU9zqMXGeLUQtd2ZGrrNxWGkpEIaVxk071lBAmfAeMQCHDxFTt1RXc0tTa+8BNvc
        dHGAYyoqxLWEz0DRWsqrZCl7jyQXG+IYTwZfBGL3jP6UuAq+xC/o+0owjbxmZ2CX
        jKHn0znJCe5sFHF0XfK674YIkVcUuVTivSqn6lMR/WSjKrRbWWAoJGIngDeXfeY4
        rj3t8KhnnMw/ULtpMFDj7NVn9Ce9QDTK6Kw9M2KCXxWhhGFtgzM636rI9Ixm3L54
        I9vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685542905; x=1685550105; bh=EBqVSuczL8zsM
        7Z+quPoEDfVsyxlfcBd6Pp556uYrbw=; b=oHsmrYj795DmAa232WElXIyigX6QS
        0lEvQFY80QEb+Xv0tRxVq8oUZFcRlC2iXWMf6A9EQv2H5cUZwOYXI3ksFh0MS95T
        a/00JTDEw8+IydUghKJpXfKrc3inW8q2ucI7PDOEPvDnPWUUJno8vH4RJtk3SbTY
        Xo+OOCRlKmOMcOOakCRfPh4R5icttoicQwN5NjWzxihP8oZl/jY89WgumqrZIZXm
        4AoaMaI7N608rPOsEyznGm2POVWr2Onut7ICia06/ESVNpGopI564yXoSbydFLpg
        hbe4TBBj3hxrtKP7i4wcLhqKNVYnyN+0hkR0iUv05alMTrQZU5p/u+1Vw==
X-ME-Sender: <xms:91d3ZBqipQsTqKHY6NRTD4pyQkRXLNRO_yNlvk1OpXfTPQ31eLUkEA>
    <xme:91d3ZDp9FwkAkFZcsZEtPeT3CVkRHmUMy4T3RxqVKzTCMhojIEgOsZyV2jdVmH5Ey
    jaX7xNsSz1_QTWZOGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:91d3ZOPFWq78uKB_gUsNnnF0OeIzGpfUdYgHxMmkoms0hJmzyG_XXA>
    <xmx:91d3ZM6fl1ZFbJDMuACkoSnRzDO_6enBMAgadt8Tx1-uTxmtBRgJMQ>
    <xmx:91d3ZA7jTUqIpcQxCcujApE4FZxs0WEfQdlu7IS1-X3dmHdmqcfy7g>
    <xmx:-Vd3ZFWRn8mhzfxV02UCF_CEnRSQ6iF8oeqZ00eFXYcYhyAZq5xkxQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0E183B60086; Wed, 31 May 2023 10:21:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com>
In-Reply-To: <20230531132323.722039569@infradead.org>
References: <20230531130833.635651916@infradead.org>
 <20230531132323.722039569@infradead.org>
Date:   Wed, 31 May 2023 16:21:22 +0200
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
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Helge Deller" <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 07/12] percpu: #ifndef __SIZEOF_INT128__
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

On Wed, May 31, 2023, at 15:08, Peter Zijlstra wrote:
> Some 64bit architectures do not advertise __SIZEOF_INT128__ on all
> supported compiler versions. Notably the HPPA64 only started doing
> with GCC-11.

I checked the other compilers to be sure that anything else
we support (gcc-5.1 and up) across all 64-bit architectures
does support int128.

It would be nice to have the hack more localized to parisc
and guarded with a CONFIG_GCC_VERSION check so we can kill
it off in the future, once we drop either gcc-10 or parisc
support.

> +#ifndef __SIZEOF_INT128__
> +#define raw_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)		\
> +({									\
> +	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
> +	typeof(pcp) __val = *__p, __old = *(ovalp);			\
> +	bool __ret;							\
> +	if (!__builtin_memcmp(&__val, &__old, sizeof(pcp))) {		\
> +		*__p = nval;						\
> +		__ret = true;						\
> +	} else {							\
> +		*(ovalp) = __val;					\
> +		__ret = false;						\
> +	}								\
> +	__ret;								\
> +})
> +
> +#define raw_cpu_generic_cmpxchg_memcmp(pcp, oval, nval)			\
> +({									\
> +	typeof(pcp) __old = (oval);					\
> +	raw_cpu_generic_try_cmpxchg_memcpy(pcp, &__old, nval);		\
> +	__old;								\
> +})

Instead of having this in include/asm-generic under
!__SIZEOF_INT128__, could you just move this into the parisc
files with a compiler version check?

     Arnd
