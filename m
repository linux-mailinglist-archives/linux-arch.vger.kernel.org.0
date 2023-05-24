Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0914B70F874
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 16:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjEXOR0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 10:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjEXORZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 10:17:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6AE119;
        Wed, 24 May 2023 07:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=swi01WUviSklMqidhqj5YrNHKiI8dOtJTzSmIt7zpos=; b=B2AHYaD6o5ODxeB/V4LaL/Ra35
        R3sFANQ8pzWNBQpBISJXI7qInCwRzRd0TtNojhAt36sX/ARugssO9I2q59DDz0cG+K5O7tg4Na2jG
        VWwgbodgo4M7j+tm1x6nx5jwlELdHqbOzNrIN8wIc2OiivkwZ7BFIdp7V2mB/vkZEK6Tsu9R96ZSa
        SKqeqhs3sn46D6LXR2qD3bExMmyN3B91aTdq/+tdTuwZqdGgefm3GA3s6/6l9rLFz4IaiE1f/tjMM
        utHx+LJU3hPxHKGsvRaZbD++FYNJ2hzEh8/Ek0r2ivDXaSDh0qmMpi/07pIZR8XcGlhhpCHK9i61R
        iFvTUKgg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1pIk-00500q-1z;
        Wed, 24 May 2023 14:17:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E65A63002C5;
        Wed, 24 May 2023 16:17:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6333200C8D22; Wed, 24 May 2023 16:17:17 +0200 (CEST)
Date:   Wed, 24 May 2023 16:17:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, akiyks@gmail.com,
        boqun.feng@gmail.com, corbet@lwn.net, keescook@chromium.org,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, paulmck@kernel.org,
        sstabellini@kernel.org, will@kernel.org
Subject: Re: [PATCH 24/26] locking/atomic: scripts: generate kerneldoc
 comments
Message-ID: <20230524141717.GM4253@hirez.programming.kicks-ass.net>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
 <20230522122429.1915021-25-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522122429.1915021-25-mark.rutland@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 22, 2023 at 01:24:27PM +0100, Mark Rutland wrote:
>  include/linux/atomic/atomic-arch-fallback.h  | 1848 +++++++++++-
>  include/linux/atomic/atomic-instrumented.h   | 2771 +++++++++++++++++-
>  include/linux/atomic/atomic-long.h           |  925 +++++-

>  29 files changed, 5940 insertions(+), 7 deletions(-)

So my biggest concern with all this is 5k+ lines of comments that GCC
has to read and discard over and over and over.

I'll see if I can measure a difference in compile time before and after
this here patch.
