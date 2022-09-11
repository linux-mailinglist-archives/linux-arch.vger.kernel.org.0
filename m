Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0A5B4F82
	for <lists+linux-arch@lfdr.de>; Sun, 11 Sep 2022 16:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiIKOyB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Sep 2022 10:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIKOx7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Sep 2022 10:53:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F702CDD3;
        Sun, 11 Sep 2022 07:53:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bj14so11414361wrb.12;
        Sun, 11 Sep 2022 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uypL6+Xj/GKvVxDwG8c8USvO49xWLjhIva5vwnPAO2Q=;
        b=ofg2adC2oN11oXhZUzmHj9ISfTGifL1qcHk34kuEZW0WSO9bZMO7EjBAk/OhdDQgi6
         uDrVjstKqPIMjU7SU5okbBzJnBWu9Wu5AK0kQIaP5dfYQgkVuSPnpKU2K8D60zdba1Yd
         dhZXM2ZhhjOgedN6fuz7TSj0cACkAT8wCfDoJoGPNWRlWeAyQwubQqsRhmbIQ3udJoTU
         ftwsGZ4YSqaG6OnpPKZBp6oOQVw9atI8FS2c3YfJHJFOxAG2X/BphoMfWxwQxFO/FxB1
         iMdBeoIxlNlroTHxZfkxJ1S7HTZ+J3r2MFbjYfzajoScm3vSDkL9HU/ktk4rop4JreOP
         4gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uypL6+Xj/GKvVxDwG8c8USvO49xWLjhIva5vwnPAO2Q=;
        b=ajXV7yo7VWPICD37ITepUMfyLClk1FdLa1Ae1eHxRcsicIdBeFWIb8sfgiVGTESiPQ
         hYT2TETmslj7teNoANvqRld6Be2azg4S3MK/VMqTnEAS7YH3xAskmcRRLoU+3rVqQfyY
         0WRXm0y2Z3aTEoSyaE0UFl4l9TcFiIp4ZKtJV4x7ssMzYmDRE3SRjbC3q3F9Jc5aEMw4
         CSdukPkZZpWPB0qEyEz8p87w7QwWfajC+7ExID9btGPfag537uvrcx/gjxF0BNmSTCb9
         l+nkezZoSD4ZvBTOmLOE4Ie9E4b3bGSnZwcFMfNPkqDtT9cVR6kvWdedpQEffZRyGAIq
         asQw==
X-Gm-Message-State: ACgBeo1ajwN+95EBVEM6aINhhBWtWVonheljbOsfZzAk/DQWszg+TLw+
        4whA5s5zmc3D56Q+cGo2LJo=
X-Google-Smtp-Source: AA6agR5YtYTKXGMPLNfzZ7sWDdyqmfet3x3sryBlrwxVu7YSdC0ZaCYF/Z5xINtqrXbVSLxoCqCr0w==
X-Received: by 2002:a05:6000:136b:b0:22a:3b92:4c05 with SMTP id q11-20020a056000136b00b0022a3b924c05mr6716973wrz.183.1662908037225;
        Sun, 11 Sep 2022 07:53:57 -0700 (PDT)
Received: from anparri ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm7011166wmq.28.2022.09.11.07.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 07:53:56 -0700 (PDT)
Date:   Sun, 11 Sep 2022 16:53:51 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Hernan Luis Ponce de Leon <hernanl.leon@huawei.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <Yx32f3O6weMIbilh@anparri>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <YwlbpPHzp8tj0Gn0@hirez.programming.kicks-ass.net>
 <YwpAzTwSRCK5kdLN@rowland.harvard.edu>
 <YwpJ4ZPVbuCnnFKS@boqun-archlinux>
 <674d0fda790d4650899e2fcf43894053@huawei.com>
 <b7e32a603fdc4883b87c733f5681c6d9@huawei.com>
 <YxynQmEL6e194Wuw@rowland.harvard.edu>
 <e8b6b7222a894984b4d66cdcc6435efe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8b6b7222a894984b4d66cdcc6435efe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> Here is a litmus test showing the problem (I hope the comment are enough to relate it back to qspinlock)
> 
> C Liveness
> {
>   atomic_t x = ATOMIC_INIT(0);
>   atomic_t y = ATOMIC_INIT(0);
> }
> 
> P0(atomic_t *x) {
>   // clear_pending_set_locked
>   int r0 = atomic_fetch_add(2,x) ;
> }
> 
> P1(atomic_t *x, int *z) {
>   // queued_spin_trylock
>   int r0 = atomic_read(x);
>   // barrier after the initialization of nodes
>   smp_wmb();
>   // xchg_tail
>   int r1 = atomic_cmpxchg_relaxed(x,r0,42);
>   // link node into the waitqueue
>   WRITE_ONCE(*z, 1);
> }
> 
> P2(atomic_t *x,atomic_t *z) {
>   // node initialization
>   WRITE_ONCE(*z, 2);
>   // queued_spin_trylock
>   int r0 = atomic_read(x);
>   // barrier after the initialization of nodes
>   smp_wmb();
>   // xchg_tail
>   int r1 = atomic_cmpxchg_relaxed(x,r0,24);
> }
> 
> exists (0:r0 = 24 /\ 1:r0 = 26 /\ z=2)
> 
> herd7 says that the behavior is observable. 
> However if you change wmb by mb, it is not observable anymore.

Indeed.  For more context, this is a 3-threads extension of the 2+2W
test/behavior, cf.

  https://github.com/paulmckrcu/litmus/blob/master/manual/lwn573436/C-2+2w+o-wb-o+o-wb-o.litmus

which is also allowed by the LKMM.  The basic rationale for allowing
such behaviors was that we "don't think we need to care" (cf. the
comment in the link above), except that it seems the developers of the
code at stake disagreed.  ;-)  So this does look like a good time to
review that design choice/code.

  Andrea
