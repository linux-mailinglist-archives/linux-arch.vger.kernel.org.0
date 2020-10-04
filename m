Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EF5282DAC
	for <lists+linux-arch@lfdr.de>; Sun,  4 Oct 2020 23:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgJDVHw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Oct 2020 17:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgJDVHv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Oct 2020 17:07:51 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DFFC0613CF
        for <linux-arch@vger.kernel.org>; Sun,  4 Oct 2020 14:07:50 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c62so9669501qke.1
        for <linux-arch@vger.kernel.org>; Sun, 04 Oct 2020 14:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AmeqHM8IDXYitzI0EgnxUl/gsEaL+uyJCislVPlifDE=;
        b=s67vt7a3tmBSv1ugGD6TFAB2dlUtTioftfBWuRfSttQFSfgkoH0YxA2QMINdkGwgBD
         ZB/m2NmL9E1Vmsq5y5sG9p0onnyzbu2dehbTkR08mFQ0+UNukbrRpl7aIWmk8LiNlp1T
         YCzXBwUnXDmfVh5t+5GQlD0Kq/fFEFf7T/dmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AmeqHM8IDXYitzI0EgnxUl/gsEaL+uyJCislVPlifDE=;
        b=Nixmof98CY5Y694joSPCsPSiSRxVu0UPqpH1sL77r3vRgwdm+6qA6HbCKEid/c06x6
         PQ4lhoAe/PYx6LGw1Q/W0jjxm6BvWbvHnhAipyC+tLfFLe2xlqTfeIAjt6FERa7GlKUz
         p38DafOFsQoCrqLjoP7vEWk/Zahv/mB/OhirpvGBWjoYAvbumcBaH1/q3RKlSTbe6HqH
         AGCQlqCrYvAu8DDZ8tYvHiNfBWA1w7zOtnv+6KgTPOaRpxbpmfZ8uTi/sERzgCtEX74E
         W8E9/626j18HV4LpSGb3ux7kqLai0r8VkRifgu+wP75t80TGw9p76gunw4mJtj4WgroF
         KC1g==
X-Gm-Message-State: AOAM533qUhXKygwCHOW93QEr10B4WL9C3sBWNuMv4M09+Fa2SYpuys5I
        S/A0H2LobX+sDd/FhMStP0NI8g==
X-Google-Smtp-Source: ABdhPJzJGyxbqmB3t1IJ2AjZ1Lmr3ha2xRe6WYWMIDN3x1lfvpV07MJX/c0dksabjyquHYbmTL7AjQ==
X-Received: by 2002:a05:620a:13e8:: with SMTP id h8mr11508033qkl.322.1601845669322;
        Sun, 04 Oct 2020 14:07:49 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l25sm6410651qtf.18.2020.10.04.14.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 14:07:48 -0700 (PDT)
Date:   Sun, 4 Oct 2020 17:07:47 -0400
From:   joel@joelfernandes.org
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, dlustig@nvidia.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools: memory-model: Document that the LKMM can easily
 miss control dependencies
Message-ID: <20201004210747.GA4078883@google.com>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
 <20201003171338.GA323226@rowland.harvard.edu>
 <20201004014022.GA332600@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004014022.GA332600@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 03, 2020 at 09:40:22PM -0400, Alan Stern wrote:
> Add a small section to the litmus-tests.txt documentation file for
> the Linux Kernel Memory Model explaining that the memory model often
> fails to recognize certain control dependencies.
> 
> Suggested-by: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
> ---
> 
>  tools/memory-model/Documentation/litmus-tests.txt |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> Index: usb-devel/tools/memory-model/Documentation/litmus-tests.txt
> ===================================================================
> --- usb-devel.orig/tools/memory-model/Documentation/litmus-tests.txt
> +++ usb-devel/tools/memory-model/Documentation/litmus-tests.txt
> @@ -946,6 +946,23 @@ Limitations of the Linux-kernel memory m
>  	carrying a dependency, then the compiler can break that dependency
>  	by substituting a constant of that value.
>  
> +	Conversely, LKMM sometimes doesn't recognize that a particular
> +	optimization is not allowed, and as a result, thinks that a
> +	dependency is not present (because the optimization would break it).
> +	The memory model misses some pretty obvious control dependencies
> +	because of this limitation.  A simple example is:
> +
> +		r1 = READ_ONCE(x);
> +		if (r1 == 0)
> +			smp_mb();
> +		WRITE_ONCE(y, 1);
> +
> +	There is a control dependency from the READ_ONCE to the WRITE_ONCE,
> +	even when r1 is nonzero, but LKMM doesn't realize this and thinks
> +	that the write may execute before the read if r1 != 0.  (Yes, that
> +	doesn't make sense if you think about it, but the memory model's
> +	intelligence is limited.)
> +
>  2.	Multiple access sizes for a single variable are not supported,
>  	and neither are misaligned or partially overlapping accesses.
>  
