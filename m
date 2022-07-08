Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABFD56B96C
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jul 2022 14:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiGHMOv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jul 2022 08:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiGHMOu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jul 2022 08:14:50 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07042F3AB
        for <linux-arch@vger.kernel.org>; Fri,  8 Jul 2022 05:14:49 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z13so26897227qts.12
        for <linux-arch@vger.kernel.org>; Fri, 08 Jul 2022 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iNABZ+iRiUdeEgm98v4CN7DQd/touY+ubNiQ+SHp/1I=;
        b=F18GnCBIiGap9h2kUdgSNdeFQWCvNTEy4Q7oyKH5zxsjLSDT/H/JIRauf/QdXv+DCg
         d3TWT4BZTEuz4/xnlh6Bic9EJdXSa5JUUnUZ445uLaXo27DLEyl47xZOy50Z48ZIp42f
         aibfHJ2/gcmd06dR3uz/b8L30DUJhvi/jRw/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iNABZ+iRiUdeEgm98v4CN7DQd/touY+ubNiQ+SHp/1I=;
        b=Y2HIws9pir0mQwM2/z3Pog3Kk2+MYr3ZGzKw+x0iz44M4p7WJk5FV1BtcNywW4trYP
         Peqc6+E8gkWPJeXPs9XqSgtGdFvEaTnanej2XpFdSLYK/1/wyoGXw9W051fhKFYo/5M2
         +GIpYY3+WnFrlS2lqvipnkZggwW78y/0Z/7S+1WcAVh+owDvnmH4q2qxPhik11VdUH1N
         1wJ+TwGJU6ROM6T2l6OXlNeCtaTDJZWjcKOdYxS65AWwMpLI12iw8MUkW7+/ODOKurwe
         xE4w4DdYIbNN/r0Qd3PRqXFQUg8drRe/YbwJGroZTb/1ZH/eOIR9xNmK4C+DCe1obLcA
         KDuw==
X-Gm-Message-State: AJIora+tIkiIpkfes8PaqwmpCWD/W+toliGnacszVzd+gxzaEBDhNtWu
        jvQKQJb98NPD6LV+sssbkycLtQ==
X-Google-Smtp-Source: AGRyM1ta/lumzdkWN6c7W7I9GlPbIBf2Nfy40vmN8MM7M2ItHOidfwZtNNTFG8vdv1Z+nDTlCIbnOw==
X-Received: by 2002:ac8:5f51:0:b0:31d:2909:bf56 with SMTP id y17-20020ac85f51000000b0031d2909bf56mr2632574qta.73.1657282487558;
        Fri, 08 Jul 2022 05:14:47 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bq30-20020a05620a469e00b006a785ba0c25sm25214448qkb.77.2022.07.08.05.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 05:14:47 -0700 (PDT)
Date:   Fri, 8 Jul 2022 12:14:46 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Re: [PATCH v2] tools/memory-model: Clarify LKMM's limitations in
 litmus-tests.txt
Message-ID: <YsgftiGp/eOQIkdy@google.com>
References: <Yqdb3CZ8bKtbWZ+z@rowland.harvard.edu>
 <20220614154812.1870099-1-paul.heidekrueger@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220614154812.1870099-1-paul.heidekrueger@in.tum.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 14, 2022 at 03:48:11PM +0000, Paul Heidekrüger wrote:
> As discussed, clarify LKMM not recognizing certain kinds of orderings.
> In particular, highlight the fact that LKMM might deliberately make
> weaker guarantees than compilers and architectures.
> 
> Link: https://lore.kernel.org/all/YpoW1deb%2FQeeszO1@ethstick13.dse.in.tum.de/T/#u
> Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: Marco Elver <elver@google.com>
> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
> Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
> Cc: Martin Fink <martin.fink@in.tum.de>
> ---

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> v2:
> - Incorporate Alan Stern's feedback.
> - Add suggested text by Alan Stern to clearly state how the branch and the
>   smp_mb() affect ordering.
> - Add "Co-developed-by: Alan Stern <stern@rowland.harvard.edu>" based on the
>   above.
> 
>  .../Documentation/litmus-tests.txt            | 37 ++++++++++++++-----
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/memory-model/Documentation/litmus-tests.txt
> index 8a9d5d2787f9..cc355999815c 100644
> --- a/tools/memory-model/Documentation/litmus-tests.txt
> +++ b/tools/memory-model/Documentation/litmus-tests.txt
> @@ -946,22 +946,39 @@ Limitations of the Linux-kernel memory model (LKMM) include:
>  	carrying a dependency, then the compiler can break that dependency
>  	by substituting a constant of that value.
>  
> -	Conversely, LKMM sometimes doesn't recognize that a particular
> -	optimization is not allowed, and as a result, thinks that a
> -	dependency is not present (because the optimization would break it).
> -	The memory model misses some pretty obvious control dependencies
> -	because of this limitation.  A simple example is:
> +	Conversely, LKMM will sometimes overestimate the amount of
> +	reordering compilers and CPUs can carry out, leading it to miss
> +	some pretty obvious cases of ordering.  A simple example is:
>  
>  		r1 = READ_ONCE(x);
>  		if (r1 == 0)
>  			smp_mb();
>  		WRITE_ONCE(y, 1);
>  
> -	There is a control dependency from the READ_ONCE to the WRITE_ONCE,
> -	even when r1 is nonzero, but LKMM doesn't realize this and thinks
> -	that the write may execute before the read if r1 != 0.  (Yes, that
> -	doesn't make sense if you think about it, but the memory model's
> -	intelligence is limited.)
> +	The WRITE_ONCE() does not depend on the READ_ONCE(), and as a
> +	result, LKMM does not claim ordering.  However, even though no
> +	dependency is present, the WRITE_ONCE() will not be executed before
> +	the READ_ONCE().  There are two reasons for this:
> +
> +                The presence of the smp_mb() in one of the branches
> +                prevents the compiler from moving the WRITE_ONCE()
> +                up before the "if" statement, since the compiler has
> +                to assume that r1 will sometimes be 0 (but see the
> +                comment below);
> +
> +                CPUs do not execute stores before po-earlier conditional
> +                branches, even in cases where the store occurs after the
> +                two arms of the branch have recombined.
> +
> +	It is clear that it is not dangerous in the slightest for LKMM to
> +	make weaker guarantees than architectures.  In fact, it is
> +	desirable, as it gives compilers room for making optimizations.  
> +	For instance, suppose that a 0 value in r1 would trigger undefined
> +	behavior elsewhere.  Then a clever compiler might deduce that r1
> +	can never be 0 in the if condition.  As a result, said clever
> +	compiler might deem it safe to optimize away the smp_mb(),
> +	eliminating the branch and any ordering an architecture would
> +	guarantee otherwise.
>  
>  2.	Multiple access sizes for a single variable are not supported,
>  	and neither are misaligned or partially overlapping accesses.
> -- 
> 2.35.1
> 
