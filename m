Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2467A9BB4
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 21:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjIUTDj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 15:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIUTDT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 15:03:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590DE897F5;
        Thu, 21 Sep 2023 10:40:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695309274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CdL9YLU917mz9bSVqQOnbPogm4sWd+XSOeiwRKnUfOc=;
        b=XhrFn60eMbE0szEpTAcfdWgjqQpDZ2KXF1a667MpRddN2MSJFVt9+kAI35dBoRjmRyxR40
        bXhnmHYR8VK7DOB2KbKQjNETNYqXVoGnOCfmezabGkMZDZbXSa/QzC6l0lAqlxKi3Z48/j
        OnEMkVkcgFQg++7cslAeMeIskQ2o7kdFaUeRerbShtMXC1UlUnr+y38lwaXJw5sfjMUvsy
        xlMMvi9cvgnJ27jOJBC/epQNTziP9FW5Pc31rUiIPqYncNaBWOA7b12jfMH37Xa+tXekmC
        kCoB0snjJnibigSF5XBiqPqnid2wsHwTiVXlryhrgLITxMUOTpF61vuDcJQWCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695309274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CdL9YLU917mz9bSVqQOnbPogm4sWd+XSOeiwRKnUfOc=;
        b=m9QPMWUipJ+Ma35LeoH4T85m85BLxDEtFlezhMzgOWR2IGiUtUv+SIxeMLTeT1/FuQYMSc
        V5WOLLgJD0p+bfAg==
To:     peterz@infradead.org, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v3 06/15] futex: FLAGS_STRICT
In-Reply-To: <20230921105248.048643656@noisy.programming.kicks-ass.net>
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
 <20230921105248.048643656@noisy.programming.kicks-ass.net>
Date:   Thu, 21 Sep 2023 17:14:34 +0200
Message-ID: <87y1gzh82t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 21 2023 at 12:45, peterz@infradead.org wrote:
> The current semantics for futex_wake() are a bit loose, specifically
> asking for 0 futexes to be woken actually gets you 1.
>
> Adding a !nr check to sys_futex_wake() makes that it would return 0
> for unaligned futex words, because that check comes in the shared
> futex_wake() function. Adding the !nr check there, would affect the
> legacy sys_futex() semantics.
>
> Hence frob a flag :-(
>
> Suggested-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
