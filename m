Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DF770F334
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 11:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjEXJlB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 05:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjEXJkp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 05:40:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42957E4B;
        Wed, 24 May 2023 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+7rsgv7m8GCnzFvm19d5DgMqjyzShFESP6prEZ6wJl0=; b=KHb/vRVq9nPWkyfrDVNCJCbRnU
        r02TvBlK6AG32SCrGO3KSNfCQvZa6N5eizVD6/ZBLpDNCLMKfuMfrS4hduHPYAbyOmmbEzebI/piP
        ICAizbPhwdM/CwYkH1nxdI5vtyJFFJAFJRvdE4VUHuj9KnBcC1pt4YWa9bkYDrt6ffrCo7dZPG5fd
        n4XHfnYBqz1dbZcOQ2RKg9i1j8/RoKwozKZOPL2GaDvLeog3nVR8gjCA49TA9Zs81ZN3qdHSggcl/
        mOgvg9GjEuf3ThX5Adu5GGG/Vg2xvMQR9OkTo2+c422YYvnUI+qRsLMg6rxL9hiD+0gC7iLGyo4xD
        QiQO7D7A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q1kyC-00B4OS-Rp; Wed, 24 May 2023 09:39:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7126D3002C5;
        Wed, 24 May 2023 11:39:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4112D241F8382; Wed, 24 May 2023 11:39:47 +0200 (CEST)
Date:   Wed, 24 May 2023 11:39:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        suravee.suthikulpanit@amd.com, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-crypto@vger.kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH v3 00/11] Introduce cmpxchg128() -- aka. the demise of
 cmpxchg_double()
Message-ID: <20230524093947.GQ83892@hirez.programming.kicks-ass.net>
References: <20230515075659.118447996@infradead.org>
 <4975b92f-92f6-4d50-8386-9add12ddfd61@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4975b92f-92f6-4d50-8386-9add12ddfd61@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 11:42:23AM +0200, Arnd Bergmann wrote:

> The need for runtime feature checking in the callers on x86-64 is still
> a bit awkward, but this is no worse than before. I understand that
> turning this into a compile-time choice would require first settling
> a larger debate about raising the default target for distros beyond
> the current CONFIG_GENERIC_CPU.

Looks like Power is going to be in the same boat, they can do
cmpxchg128, but only for Power8+.
