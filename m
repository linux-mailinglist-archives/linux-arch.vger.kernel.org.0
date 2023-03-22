Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A3A6C3F5C
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 01:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCVAxI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 20:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCVAxH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 20:53:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68C5128;
        Tue, 21 Mar 2023 17:53:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h8so66649669ede.8;
        Tue, 21 Mar 2023 17:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679446385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWanL4XoGy6t+xq48/4j9gGBTUnLwvzHVYZkeKl6VbQ=;
        b=RdseRlDCBR9eS9GdfveQeNqOTOGuKEuvv+HePDyMvbyCt4e5hUpGRQ5PPs1UmAIufr
         G2yLolV6AQ+7v3Pg9AepDKXIQbWIxnrE6GHb0aLRNUG0/5hg1boYChtIJvq+MlE4mRmM
         nZ/FXE3lK4tpyAZIQ9oCRlAg6TYk/chfjeJOAl+Werk8t39Gb7PXfgHC5B9xhKyZouTH
         cx+tBd95RluLALhBgoTeRAE40oz8dBFBzCy1MEwlTq6i9LjnKmTsFm+LHbWBXQ4x6M2G
         TPB2x6fOoVjVJljRWJv4cHKUmNHpc3YfHXD9sAImxaqmpTuaB5n3WDy2FM6ESSLYyFrl
         Jxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679446385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWanL4XoGy6t+xq48/4j9gGBTUnLwvzHVYZkeKl6VbQ=;
        b=3Rpgvy/VDLcg7CtiiYb0zjzK9vt4JGd5CQGSDf56E4NnY4OuHg/XK4srIMwQPKS3t5
         NdmYucC93vwsH5lkq9OKT4heiLWZf+3MR/+ykc0hGBLXKYaoSu/Ddde+29PrY4V6Xime
         wKePhgA7Kk1ZzCmnXZIccl8pbbqEyR+G6k17NE0iHDuIPE++piQ8AXcOArNSWkH65E8O
         ftKFPwRK/ei8fUJECZ/cua6llcMFeNTiB0ieFanYYnFb7rnJ6Hc3zZv2GW7PqUgor+yi
         cm4vHyxfhJJSgJgiqvGPGuuXmk6goIkTAW81QPmQuxQPH2VV6gQqovVsaIC4HnooDiSm
         Vewg==
X-Gm-Message-State: AO0yUKW4esfqZzdZ2sf7fiUdgWwCjcnSzLy7kenEnFvm2DHIFsYUCBbG
        1lG0QA4HMlRgPo5vMooB8NM=
X-Google-Smtp-Source: AK7set94eoaNQw1l/nDMh6hRX1FLBMDuisHYGDIgeC1+Xl+p+jDLBAj0mQbz+bCkIJ+xu8gRe+k15w==
X-Received: by 2002:a17:906:33c7:b0:933:9f43:5c3b with SMTP id w7-20020a17090633c700b009339f435c3bmr5174418eja.59.1679446384821;
        Tue, 21 Mar 2023 17:53:04 -0700 (PDT)
Received: from andrea (93-41-0-79.ip79.fastwebnet.it. [93.41.0.79])
        by smtp.gmail.com with ESMTPSA id g26-20020a1709064e5a00b00930525d89e2sm6375124ejw.89.2023.03.21.17.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 17:53:04 -0700 (PDT)
Date:   Wed, 22 Mar 2023 01:53:00 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH memory-model 4/8] tools/memory-model: Restrict to-r to
 read-read address dependency
Message-ID: <ZBpRbPvdq6hQLyhX@andrea>
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
 <20230321010246.50960-4-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321010246.50960-4-paulmck@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 20, 2023 at 06:02:42PM -0700, Paul E. McKenney wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> During a code-reading exercise of linux-kernel.cat CAT file, I generated
> a graph to show the to-r relations. While likely not problematic for the
> model, I found it confusing that a read-write address dependency would
> show as a to-r edge on the graph.
> 
> This patch therefore restricts the to-r links derived from addr to only
> read-read address dependencies, so that read-write address dependencies don't
> show as to-r in the graphs. This should also prevent future users of to-r from
> deriving incorrect relations. Note that a read-write address dep, obviously,
> still ends up in the ppo relation via the to-w relation.
> 
> I verified that a read-read address dependency still shows up as a to-r
> link in the graph, as it did before.
> 
> For reference, the problematic graph was generated with the following
> command:
> herd7 -conf linux-kernel.cfg \
>    -doshow dep -doshow to-r -doshow to-w ./foo.litmus -show all -o OUT/
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea


> ---
>  tools/memory-model/linux-kernel.cat | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 3a4d3b49e85c..cfc1b8fd46da 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -81,7 +81,7 @@ let dep = addr | data
>  let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
> -let to-r = addr | (dep ; [Marked] ; rfi)
> +let to-r = (addr ; [R]) | (dep ; [Marked] ; rfi)
>  let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
>  
>  (* Propagation: Ordering from release operations and strong fences. *)
> -- 
> 2.40.0.rc2
> 
