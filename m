Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65747BBA2A
	for <lists+linux-arch@lfdr.de>; Fri,  6 Oct 2023 16:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjJFOYq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Oct 2023 10:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjJFOYq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2023 10:24:46 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F107EA6;
        Fri,  6 Oct 2023 07:24:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-533edb5ac54so4071647a12.0;
        Fri, 06 Oct 2023 07:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696602283; x=1697207083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b8I/pmp7HdKLDHhCdi41zE+MtAKI0m0CcPz66uBEWEc=;
        b=ZzbGrKpphOqZjqODmc3CS06vkcTmMlu9ShEuI80HJ1taZVYLZBXUB1Mj0ElxafoiHA
         6vvpbXQE/hw26qswIgcWRkeYEgHZaMZllKITvs7518p2SVQU5xwKkdCSuLrTH84Z52C/
         22rX5zpA5ypJyFg7RAYgmklIOWvwuKNZXU1yiO07WZtJFWlQTyT48Kiox/YPO4h6N96o
         FBlS+xatQqOrqA8hH/Gg48m2sj1eDV2rfHBGN5faCMF3gTWc9ah1pcShMqp5kN8FqR2t
         f55Jq3BXgwGpM1Cqyb231HKXsD2C5rYKCNKHKSUiHHCj7kBLFs6UYiGKSx0+g6CmuWde
         rO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696602283; x=1697207083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8I/pmp7HdKLDHhCdi41zE+MtAKI0m0CcPz66uBEWEc=;
        b=EAa81lDAKGdkBfKEO7VUeDnXabWaNDETrlViYR+QggyXSrlmMbuhNkMkM6/g8qVRUL
         Je2U+br3Q68eHrn6DH7JPyIDVuzkaH56Z1kq/aEwXfA0Y3Bsa1mpjGaKURCw6h97efH0
         idjBMXfmHofJvo+O9j7EhEeYFUW+wH15IU4uZWUZu5Zp0MZleb6CUUrbgH1fVaE661Nx
         vnPJlOOXVzCMwxU7hn3koYOTnwmUYGlpNyNIXSZYMaY5VCLDOeVGir8ftdSxsNrwtjh2
         L9GyFoHzsj/OPvMiP4lFjQBZUa9MvierIZ8C/XkOvZYzb4I7UNa/MZtSUeInf95d6dEw
         8kyA==
X-Gm-Message-State: AOJu0YwJDr28yVMka18lLWwq4ySQmPi0CqXmUbLvsAFyh9G6CCUKnz8W
        5Q5aIvkl+FPuf5fi8eVasVM=
X-Google-Smtp-Source: AGHT+IHGovDes+jvG4htvuA7NtIoGCkf/8iTafYIPPjGC9PWkToPrw3WgxZ9oEY68z98ydS8TRGtUA==
X-Received: by 2002:aa7:d501:0:b0:52f:2bd3:6f4d with SMTP id y1-20020aa7d501000000b0052f2bd36f4dmr7896584edq.0.1696602283036;
        Fri, 06 Oct 2023 07:24:43 -0700 (PDT)
Received: from andrea ([151.76.7.139])
        by smtp.gmail.com with ESMTPSA id ca15-20020aa7cd6f000000b005331f6d4a30sm2637771edb.56.2023.10.06.07.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 07:24:42 -0700 (PDT)
Date:   Fri, 6 Oct 2023 16:24:38 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH memory-model] docs: memory-barriers: Add note on compiler
 transformation and address deps
Message-ID: <ZSAYplkpVlmcL1bb@andrea>
References: <ceaeba0a-fc30-4635-802a-668c859a58b2@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceaeba0a-fc30-4635-802a-668c859a58b2@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 05, 2023 at 09:53:12AM -0700, Paul E. McKenney wrote:
> The compiler has the ability to cause misordering by destroying
> address-dependency barriers if comparison operations are used. Add a
> note about this to memory-barriers.txt in the beginning of both the
> historical address-dependency sections and point to rcu-dereference.rst
> for more information.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

Thanks,
  Andrea


> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 06e14efd8662..d414e145f912 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -396,6 +396,10 @@ Memory barriers come in four basic varieties:
>  
>  
>   (2) Address-dependency barriers (historical).
> +     [!] This section is marked as HISTORICAL: For more up-to-date
> +     information, including how compiler transformations related to pointer
> +     comparisons can sometimes cause problems, see
> +     Documentation/RCU/rcu_dereference.rst.
>  
>       An address-dependency barrier is a weaker form of read barrier.  In the
>       case where two loads are performed such that the second depends on the
> @@ -556,6 +560,9 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
>  
>  ADDRESS-DEPENDENCY BARRIERS (HISTORICAL)
>  ----------------------------------------
> +[!] This section is marked as HISTORICAL: For more up-to-date information,
> +including how compiler transformations related to pointer comparisons can
> +sometimes cause problems, see Documentation/RCU/rcu_dereference.rst.
>  
>  As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
>  DEC Alpha, which means that about the only people who need to pay attention
