Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E5870F85D
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 16:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjEXOMI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 10:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjEXOMH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 10:12:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A88B122;
        Wed, 24 May 2023 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KCVdDQUCcI7LTcVQSiTlkpqu+i/JOMxs6BaNLI0J8lg=; b=ozVFP8vGVZJvQa0hBO+yTmwJX0
        vHFa5+hNFQ6tZVs0+Dd48VNJxreJ1J/vvjWtybbz61LEwBRKKmeVjCWLXLmk94W2IpFd3IKeXJxy+
        DprFbIIdowawc8B8OmsCbvflTPSlMd0fGVbJWmDI6PuhFQiXybHS2QgqNhigN5+U0128MfIVpMX7u
        p79Sx3Ifu/Qk4hBl3GsETGR7RAhDNtz7YBo9Bot0jN7oIIB0GzVLKfwIGGL2F6bZQlkSFU7dbJuIO
        4FoaRuU9rhZvgkihLgJhPxHuytm26WgzHL7404Y/g0DTmVQSaizjr3gzl2GtEfJD9O/4GoKIinxJb
        NY7jjNbQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1pDV-004zxB-1J;
        Wed, 24 May 2023 14:11:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA7F8300282;
        Wed, 24 May 2023 16:11:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C5AC24A35F45; Wed, 24 May 2023 16:11:52 +0200 (CEST)
Date:   Wed, 24 May 2023 16:11:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, corbet@lwn.net, keescook@chromium.org,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, paulmck@kernel.org,
        sstabellini@kernel.org, will@kernel.org
Subject: Re: [PATCH 24/26] locking/atomic: scripts: generate kerneldoc
 comments
Message-ID: <20230524141152.GL4253@hirez.programming.kicks-ass.net>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
 <20230522122429.1915021-25-mark.rutland@arm.com>
 <96d6930b-78b1-4b4c-63e3-c385a764d6e3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d6930b-78b1-4b4c-63e3-c385a764d6e3@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 24, 2023 at 11:03:58PM +0900, Akira Yokosawa wrote:

> > * All ops are described as an expression using their usual C operator.
> >   For example:
> > 
> >   andnot: "Atomically updates @v to (@v & ~@i)"
> 
> The kernel-doc script converts "~@i" into reST source of "~**i**",
> where the emphasis of i is not recognized by Sphinx.
> 
> For the "@" to work as expected, please say "~(@i)" or "~ @i".
> My preference is the former.

And here we start :-/ making the actual comment less readable because
retarded tooling.

> >   inc:    "Atomically updates @v to (@v + 1)"
> > 
> >   Which may be clearer to non-naative English speakers, and allows all
>                             non-native
> 
> >   the operations to be described in the same style.
> > 
> > * All conditional ops have their condition described as an expression
> >   using the usual C operators. For example:
> > 
> >   add_unless: "If (@v != @u), atomically updates @v to (@v + @i)"
> >   cmpxchg:    "If (@v == @old), atomically updates @v to @new"
> > 
> >   Which may be clearer to non-naative English speakers, and allows all
> 
> Ditto.

How about we just keep it as is, and all the rst and html weenies learn
to use a text editor to read code comments?
