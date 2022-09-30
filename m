Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D195F031C
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 05:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiI3DMB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 23:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiI3DL7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 23:11:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACACD1406DE;
        Thu, 29 Sep 2022 20:11:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id z3so1903374plb.10;
        Thu, 29 Sep 2022 20:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IaT+z8wShHYZ5w6wMv6AiwMbJkJWmBsh9rvT19CMinI=;
        b=J/jseeYzpVxCMDcGzDXwcZNW3C6aU+eo7MQB5E77/pE7rLKYOqYqcvQlx9xR3yWeL8
         mZ3PdlsGDNFKwscr/20w9VhgjtQdc0I0dZbC4Bg4zIbpZlemO7twGRYHLrSmuXxDu6Sr
         4wiuWl8L5Tun/MYFcZDrMMEd2Zhyb26oKkGd9a0NAkTB35HLP9+88q8JD6Bht0K5Glc7
         7wdkPXj8Px08ujBQsm5K8nFwjkvJr78URyeiLxtVHM6JgyA/B+fJzUoBzUEUlY0yxVhq
         bTQfCXmtVtoYSIibYr0UMUL5voRnB8Sl6ImJDzec0d2vPTg7bcm57ccMdZQg4XfW8/P7
         iKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IaT+z8wShHYZ5w6wMv6AiwMbJkJWmBsh9rvT19CMinI=;
        b=iKGHebclqpvqOcTxJGJIZ0IV/nHvN+7bE34zAt77BNj55YkmSruUb7f8CIywx0611L
         BgrHz975enRFWyYhFwJti/gkeXavJJ0dAt8cqlMf/ni3/wOyajW8vA5CYpO596ZJXNCa
         VpzioGYdVG750X3BPeopq+p+clnHKjwWy1AHNPvjgG/rcwGp0PUy0Nn58BbPkwY2Rwv8
         G5qs7iJonKtAOetC57ivvrF4xm10daz573X5Kpq18hiAe7pK58j85sYqF/oyLH48aNaD
         hChBIp9m4UXbJtGYRQ4hhXZynlqcqqUhOnPIU7YR0EKXWg2l9/AXSR+j4Qzu/fqQWfzc
         vJTA==
X-Gm-Message-State: ACrzQf1PwOfKMGHQ5SelDbBFItcQUAfxD/DVkHyUOpe5UhYlb46lOUoS
        bgQ5+72CCrUN+oC192kV2L8=
X-Google-Smtp-Source: AMsMyM7BVkTC6CjkcAnzMc20d6OIZ9udRuQlU3FFY6GuA9vEMGhjwdjv8EGZE+BBc6fcrxyJbs19cA==
X-Received: by 2002:a17:90b:17c3:b0:202:bc13:e4e7 with SMTP id me3-20020a17090b17c300b00202bc13e4e7mr7183779pjb.125.1664507498260;
        Thu, 29 Sep 2022 20:11:38 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id w1-20020a627b01000000b0053e7293be0bsm446891pfc.121.2022.09.29.20.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 20:11:37 -0700 (PDT)
Message-ID: <5db465f3-698f-ebee-a668-1740a705ce9c@gmail.com>
Date:   Fri, 30 Sep 2022 12:11:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] locking/memory-barriers.txt: Improve documentation for
 writel() usage
Content-Language: en-US
To:     Parav Pandit <parav@nvidia.com>
References: <20220930020355.98534-1-parav@nvidia.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Cc:     bagasdotme@gmail.com, arnd@arndb.de, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
        dlustig@nvidia.com, joel@joelfernandes.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220930020355.98534-1-parav@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, 

On Fri, 30 Sep 2022 05:03:55 +0300, Parav Pandit wrote:
> The cited commit describes that when using writel(), explcit wmb()
> is not needed. wmb() is an expensive barrier. writel() uses the needed
> I/O barrier instead of expensive wmb().
> 
> Hence update the example to be more accurate that matches the current
> implementation.
> 
> commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> ---
> changelog:
> v0->v1:
> - Corrected to mention I/O barrier instead of dma_wmb().
I don't think dma_wmb() and wmb() belong to "I/O barrier" as far as
memory-barriers.txt is concerned. They are listed in the "CPU MEMORY
BARRIERS" section. dma_wmb() belongs to "advanced barrier functions".

You see, writel() is one of the functions listed in the "KERNEL I/O
BARRIER EFFECTS" section.

Please be consistent with the word choice of the doc you are modifying,
so that any further confusion can be avoided in this infamously 
hard-to-follow document. :-)

Regards,
Akira

> - removed numbered references in commit log
> - corrected typo 'explcit' to 'explicit' in commit log
> ---
>  Documentation/memory-barriers.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
[...]
