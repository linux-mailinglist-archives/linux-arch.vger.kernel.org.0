Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD13206849
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 01:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbgFWXYc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 19:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388200AbgFWXYa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 19:24:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB10C061573;
        Tue, 23 Jun 2020 16:24:30 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m21so53374eds.13;
        Tue, 23 Jun 2020 16:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qg4pRwyioF70kpz98uHFH8Xcc44ozp1PlRWmbay6J2w=;
        b=HFEJGHPprM3bOHD1+gxF55zE2NhzUfb4wpVzfOFCcFMtGbT1FF78kNWmLMFjXIilby
         1jhr3YEY6ZsI35Bs1jlAdLAkhnlHMfBAYVMwVL/zaSybG31MG70pvX6V/WWavmzfI5f2
         WPywh5CHiIoHUtgJmpzJuvwTwZSyJl/YvslqqmVehhVe3jVYkCM7js49kUeyx5dHRvUn
         jyEbWNJ6XXPTJJA/Ta9q6l+6oVojbl/5l/cSlMjJlLRRP9NHpeGcC0SbpzNVicdtLkJR
         2Jf+fmPBbjMl9k9+sxbBkcQnVK0dyO+sdte2TwGGttmhRwkP5aAB8Ix/LeLBv3O+Mb9d
         ACdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qg4pRwyioF70kpz98uHFH8Xcc44ozp1PlRWmbay6J2w=;
        b=EgXWr1D7GeoO3xFPsYgOy0EFnVmlPEYLlLhurN8X4lL5TmUQ1Cd5K2pHujVoAwJYBv
         VBpRnuJWuFQrCKpBTpcmh8+ZALX4Xda6k8EOwkN5NWIYcXfYGL1j7xwu4PQoSJ2n3cZS
         SZBPitazp76RpC6NnaV5hN1C4aOFicIZk3ci88LCa2r7LaZ7RkFmhS3Bq/Tokram5S4L
         /36HYf5rADqqvU04YVBvPZ6Rk7E2mx76eOEAKhoR46hmx//FBGH+3vlHeWTkc78ReIFI
         l8pwR6DMrDbDpCR2EGf8rAHntaMmuzgNSvC5E8k2V2dHm/0s++LBaqopqxHyXHJ6gKbX
         8qpQ==
X-Gm-Message-State: AOAM532moFmeZSgC/19J7ITI2TeLqb5WqE2IZom+yfHyJ4EBojQls7uW
        Xf5KoDafxk9asSDa/M+YPIg=
X-Google-Smtp-Source: ABdhPJyAT1d/IwlKuS/na5EbKXi3//g9xDMtPn0+NfNC4Z6jKGX2hsbEiR3inayxc9aJtllFSa2blw==
X-Received: by 2002:a50:a701:: with SMTP id h1mr23535578edc.170.1592954668632;
        Tue, 23 Jun 2020 16:24:28 -0700 (PDT)
Received: from andrea (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id rp21sm14247191ejb.97.2020.06.23.16.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 16:24:28 -0700 (PDT)
Date:   Wed, 24 Jun 2020 01:24:25 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr
Subject: Re: [PATCH 2/2] Documentation/litmus-tests: Add note on herd7 7.56
 in atomic litmus test
Message-ID: <20200623232425.GB418699@andrea>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
 <20200623005231.27712-13-paulmck@kernel.org>
 <e3693dec-213a-3f65-eb1c-284bf8ca6e13@gmail.com>
 <20200623155419.GI9247@paulmck-ThinkPad-P72>
 <b3433b44-29af-4ef4-d047-b0b0d51a9fbd@gmail.com>
 <9e1d448a-cf3c-523d-e0a6-f46ac4706c48@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e1d448a-cf3c-523d-e0a6-f46ac4706c48@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 07:09:01AM +0900, Akira Yokosawa wrote:
> From f808c371075d2f92b955da1a83ecb3828db1972e Mon Sep 17 00:00:00 2001
> From: Akira Yokosawa <akiyks@gmail.com>
> Date: Wed, 24 Jun 2020 06:59:26 +0900
> Subject: [PATCH 2/2] Documentation/litmus-tests: Add note on herd7 7.56 in atomic litmus test
> 
> herdtools 7.56 has enhanced herd7's C parser so that the "(void)expr"
> construct in Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus is
> accepted.
> 
> This is independent of LKMM's cat model, so mention the required
> version in the header of the litmus test and its entry in README.
> 
> CC: Boqun Feng <boqun.feng@gmail.com>
> Reported-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>

Frankly, I was hoping that we could simply bump the herd7 version in
tools/memory-model/README; I understand your point, but I admit that
I haven't being playing with 7.52 for a while now...

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea


> ---
>  Documentation/litmus-tests/README                                | 1 +
>  .../atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus       | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
> index b79e640214b9..7f5c6c3ed6c3 100644
> --- a/Documentation/litmus-tests/README
> +++ b/Documentation/litmus-tests/README
> @@ -19,6 +19,7 @@ Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
>  
>  Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
>      Test that atomic_set() cannot break the atomicity of atomic RMWs.
> +    NOTE: Require herd7 7.56 or later which supports "(void)expr".
>  
>  
>  RCU (/rcu directory)
> diff --git a/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus b/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> index 49385314d911..ffd4d3e79c4a 100644
> --- a/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> +++ b/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> @@ -4,6 +4,7 @@ C Atomic-RMW-ops-are-atomic-WRT-atomic_set
>   * Result: Never
>   *
>   * Test that atomic_set() cannot break the atomicity of atomic RMWs.
> + * NOTE: This requires herd7 7.56 or later which supports "(void)expr".
>   *)
>  
>  {
> -- 
> 2.17.1
> 
> 
