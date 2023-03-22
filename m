Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B3D6C3F55
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 01:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCVAva (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 20:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCVAv3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 20:51:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD291136C1;
        Tue, 21 Mar 2023 17:51:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cn12so21012373edb.4;
        Tue, 21 Mar 2023 17:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679446287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/D//vq30gDfSAxNqZwDD5621tlN45WCAw1FWd9BqcCA=;
        b=TSKcI0tuP2Ju+B6pP9VT5ptFQ8Di1BhckjhFdZ/43FtFsCdpfCdvSvMoTnFnpFXkfw
         5HH/QGz7nIFIOyoqaTBeGmEemGc9vhBgTPZUs2G70iAWK/Rb0xPT9tT1IkGOiNwKTXH8
         Q4zT6ud9vvcPOw4/o09Qj7AeMyrR+cVSQeN2aENkoLoPn6ZmhGygaEkiQX0h7a6jP1UO
         mfVqeYaVqWDe5NZj+w7IgFafcSxAO0EMPsLNhiBu190i2e0Pmg/Vh87Ci+kdY2lfWtf5
         Eis6tpfbVv9Zbw3EmlBNlb3NeyU0QJFcw1g6+41L6OeJjGyzDku16L2Q/7pPEHWUUVqL
         /6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679446287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/D//vq30gDfSAxNqZwDD5621tlN45WCAw1FWd9BqcCA=;
        b=IQzIbBbHWGgMaf+oDRWi5WTGgXF/+wxVeWGTK+G60MDeyfMJCbkf3+ahxYkqtBQZdv
         SYRN5eK4wo03F9ZwYPlW3DSWNsctHjd42yhu7E5uraUK/Fn9dVLaK//xI4rnfYSDqOmV
         zqBq1v8dtMZuDtxsVHKMUg6cPytqKaQztza0pleYh68izJ0ouTL/yBsBmF8E5NKOYHAE
         DCBfQiCIBi+djDXXolA4OE8fKbGLhRg+yIfE0h5FRJ5tDJBjAvIsn7aRhBJmUjirSY7a
         K4KtvS8V6ylF4C6X7XoQ+HesuLJ79xWGhJkzMgTVUdhJ+gMOG1tVN9RfOXs+gQLtX88+
         vgdQ==
X-Gm-Message-State: AO0yUKV6+XkT7QEu3kl3GDkIpyM0pAjNJ2hxyT+WwklI4zaBP8DvQbXM
        qjPx/sSecXD9obAgSX7GJ78=
X-Google-Smtp-Source: AK7set9dAVfJ7otaBNTbqgHH52y55gibQ0cV8TsPgxrer+dKm3cdqy1ShNxwJXR4t5oCAFDnHodd6A==
X-Received: by 2002:a17:906:94ce:b0:8aa:875d:9d9a with SMTP id d14-20020a17090694ce00b008aa875d9d9amr4667867ejy.50.1679446287094;
        Tue, 21 Mar 2023 17:51:27 -0700 (PDT)
Received: from andrea (93-41-0-79.ip79.fastwebnet.it. [93.41.0.79])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906c00800b008e1509dde19sm6364793ejz.205.2023.03.21.17.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 17:51:26 -0700 (PDT)
Date:   Wed, 22 Mar 2023 01:51:22 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: Re: [PATCH memory-model 1/8] tools/memory-model: Update some warning
 labels
Message-ID: <ZBpRCiHuC6LPkFOc@andrea>
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
 <20230321010246.50960-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321010246.50960-1-paulmck@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 20, 2023 at 06:02:39PM -0700, Paul E. McKenney wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> Some of the warning labels used in the LKMM are unfortunately
> ambiguous.  In particular, the same warning is used for both an
> unmatched rcu_read_lock() call and for an unmatched rcu_read_unlock()
> call.  Likewise for the srcu_* equivalents.  Also, the warning about
> passing a wrong value to srcu_read_unlock() -- i.e., a value different
> from the one returned by the matching srcu_read_lock() -- talks about
> bad nesting rather than non-matching values.
> 
> Let's update the warning labels to make their meanings more clear.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Reviewed-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea


> ---
>  tools/memory-model/linux-kernel.bell | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index 70a9073dec3e..dc464854d28a 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -53,8 +53,8 @@ let rcu-rscs = let rec
>  	in matched
>  
>  (* Validate nesting *)
> -flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
> -flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
> +flag ~empty Rcu-lock \ domain(rcu-rscs) as unmatched-rcu-lock
> +flag ~empty Rcu-unlock \ range(rcu-rscs) as unmatched-rcu-unlock
>  
>  (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
>  let srcu-rscs = let rec
> @@ -69,14 +69,14 @@ let srcu-rscs = let rec
>  	in matched
>  
>  (* Validate nesting *)
> -flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
> -flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> +flag ~empty Srcu-lock \ domain(srcu-rscs) as unmatched-srcu-lock
> +flag ~empty Srcu-unlock \ range(srcu-rscs) as unmatched-srcu-unlock
>  
>  (* Check for use of synchronize_srcu() inside an RCU critical section *)
>  flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
>  
>  (* Validate SRCU dynamic match *)
> -flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> +flag ~empty different-values(srcu-rscs) as srcu-bad-value-match
>  
>  (* Compute marked and plain memory accesses *)
>  let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
> -- 
> 2.40.0.rc2
> 
