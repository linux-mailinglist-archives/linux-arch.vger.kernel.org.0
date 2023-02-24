Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396D76A14EE
	for <lists+linux-arch@lfdr.de>; Fri, 24 Feb 2023 03:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBXCc6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Feb 2023 21:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBXCc5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2023 21:32:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B1C768C;
        Thu, 23 Feb 2023 18:32:55 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so1331268pjb.3;
        Thu, 23 Feb 2023 18:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GQeJVvg/Xq1llksWxXLaIlMuU+sIYem1jysYdYOXA1M=;
        b=aok1sTKs05q+RHHaG7VDHTj+CQre/3l8M0lcrzaYUlFAns9TCpuHQg6Rl3/eHIYccD
         2PGLR5BbfDtDZvqAMhFpIL/XKhX1SQOSmFe5uVfEDUpGvx30/cjebMhgLaMwmKzI8w4Q
         fXFfLbpovvgghULVzX9tyY1V7QNN+fKpjk0p9TnfrcXM15FbLWBW9Etig6pHwiXO5qpR
         UZlUdPG/ThDVqKawgTybUiJaxyrFoQbCme/zLcEWQ01vpZ/OooRWGlXM62bN73W1UItE
         8hKkzl6ECF7LaGrmssDLMv8C0FVMdcLDtDdm8JMJZbq990Enx1XyvUzGOy5vCiNOT/p3
         9xZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQeJVvg/Xq1llksWxXLaIlMuU+sIYem1jysYdYOXA1M=;
        b=BOendlMTsc5+7Qezwd2cCPUuN++OxDphPfzmzxkK2QSDaSEm7m+zZW1rVuwHTjolky
         b8CwqZI+FLqU6DcarA4c5KV93t3WT7A69YlcMBD1zAhj7l53ElDPi+nRuUmUpCzPv/L5
         svRL1+q9XBa+tUHxP3IDpPyP2ShQXTUHXaHV5m83SJ6JllmnlX4F0+f6dRSYKTpnwLmG
         gzbxuNZbrJkOqO6jAP4NlUn7o8a4+L2tBG8imBDHXgyEiD2Q5pcyumBiFDNc4umOR4Ub
         99J6fM/PLxW/zRkehzehLVjX5Q0KE2YznsSYcMxzvKJZLkJf6IXqJFXROWUdObjPgMC7
         LqkA==
X-Gm-Message-State: AO0yUKWqv7JUIZQdF5vXk5rMGGAVH5Is1h0IJUYXa+nw6P5pPVn2DYKb
        QpHfmriynvDXz1Ceo2pewt0=
X-Google-Smtp-Source: AK7set9e7ljKbpHqDWQDVNkPwGWXXsXNs5w+Zm10RWeHo8uoOwwkyfnObqMZL4HVvaWqoP4k/r8QEg==
X-Received: by 2002:a05:6a20:6998:b0:cb:a64b:6e1b with SMTP id t24-20020a056a20699800b000cba64b6e1bmr12405109pzk.58.1677205975274;
        Thu, 23 Feb 2023 18:32:55 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id p20-20020aa78614000000b005b0853a1a3esm7973008pfn.159.2023.02.23.18.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 18:32:54 -0800 (PST)
Message-ID: <73baee18-802e-f694-a3d7-9ae776e6fd69@gmail.com>
Date:   Fri, 24 Feb 2023 11:32:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] tools/memory-model: Add documentation about SRCU
 read-side critical sections
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?Q?Paul_Heidekr=c3=bcger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20230213015506.778246-1-joel@joelfernandes.org>
 <Y/JS5SYKPeeDQErL@rowland.harvard.edu>
 <CAEXW_YQrFSiDEM9cuhkTT2_1+CZoGbg7vC9oL-D-Wd5OQ2mm2w@mail.gmail.com>
 <CAEXW_YR6eKDCv+E8Xv2aX=Eo=H0667cqrXkMqKhc_QMZ4Vf59A@mail.gmail.com>
 <Y/PgxRorDQZ7wPKU@rowland.harvard.edu>
 <20230222195051.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y/bRFNrzjIRjFgxz@rowland.harvard.edu>
Content-Language: en-US
In-Reply-To: <Y/bRFNrzjIRjFgxz@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alan,

One minor nit.  Please find inline comment below.

On Wed, 22 Feb 2023 21:36:04 -0500, Alan Stern wrote:
> Expand the discussion of SRCU and its read-side critical sections in
> the Linux Kernel Memory Model documentation file explanation.txt.  The
> new material discusses recent changes to the memory model made in
> commit 6cd244c87428 ("tools/memory-model: Provide exact SRCU
> semantics").
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jonas Oberhauser <jonas.oberhauser@huawei.com>
> 
> ---
> 
> Joel, please feel free to add your Co-developed-by and Signed-off-by
> tags to this patch.
> 
>  tools/memory-model/Documentation/explanation.txt |  178 +++++++++++++++++++++--
>  1 file changed, 167 insertions(+), 11 deletions(-)
> 
> Index: usb-devel/tools/memory-model/Documentation/explanation.txt
> ===================================================================
> --- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-devel/tools/memory-model/Documentation/explanation.txt
> @@ -28,9 +28,10 @@ Explanation of the Linux-Kernel Memory C
>    20. THE HAPPENS-BEFORE RELATION: hb
>    21. THE PROPAGATES-BEFORE RELATION: pb
>    22. RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-order, rcu-fence, and rb
> -  23. LOCKING
> -  24. PLAIN ACCESSES AND DATA RACES
> -  25. ODDS AND ENDS
> +  23. SRCU READ-SIDE CRITICAL SECTIONS
> +  24. LOCKING
> +  25. PLAIN ACCESSES AND DATA RACES
> +  26. ODDS AND ENDS
>  
>  
>  
> @@ -1848,14 +1849,169 @@ section in P0 both starts before P1's gr
>  before it does, and the critical section in P2 both starts after P1's
>  grace period does and ends after it does.
>  
> -Addendum: The LKMM now supports SRCU (Sleepable Read-Copy-Update) in
> -addition to normal RCU.  The ideas involved are much the same as
> -above, with new relations srcu-gp and srcu-rscsi added to represent
> -SRCU grace periods and read-side critical sections.  There is a
> -restriction on the srcu-gp and srcu-rscsi links that can appear in an
> -rcu-order sequence (the srcu-rscsi links must be paired with srcu-gp
> -links having the same SRCU domain with proper nesting); the details
> -are relatively unimportant.
> +The LKMM supports SRCU (Sleepable Read-Copy-Update) in addition to
> +normal RCU.  The ideas involved are much the same as above, with new
> +relations srcu-gp and srcu-rscsi added to represent SRCU grace periods
> +and read-side critical sections.  However, there are some important
> +differences between RCU read-side critical sections and their SRCU
> +counterparts, as described in the next section.
> +
> +
> +SRCU READ-SIDE CRITICAL SECTIONS
> +--------------------------------
> +
> +The LKMM models uses the srcu-rscsi relation to model SRCU read-side

I think you mean either:

   The LKMM models the srcu-rscsi relation ...

or: 

   The LKMM uses the srcu-rscsi relation ...

With this fixed,

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

> +critical sections.  They are different from RCU read-side critical
> +sections in the following respects:
> +
[...]

        Thanks, Akira
