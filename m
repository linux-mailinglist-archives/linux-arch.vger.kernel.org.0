Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0395F6618
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 14:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJFMbK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Oct 2022 08:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiJFMaq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Oct 2022 08:30:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8EC2DED;
        Thu,  6 Oct 2022 05:30:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w191so1902314pfc.5;
        Thu, 06 Oct 2022 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mEe5lzHlglZonJ+BkLQU4xHEdjlrL8N/cawq7a3PVpk=;
        b=kUP3C9oAmiqJcQ7jg1jzD6HIhLsAYzUiaWINWrooDSSDqJI1OOrI1ciyN3nb0XYHUn
         qqY5dndpvGJmBFpPo/UKiSBVS8P8oJAyjYCsK8wAhgzf36kCFRBnMAXQRPdbLntcBLnh
         RUM1z3HC1bfC1zHS36piDtdKUWJ2kjvucPok78blmX27D83MsTSNh+eFxjjSvM40ad0O
         5+KUiKTD1tzdB1WLeDzm/X/F7B1Uu+VGIlf1bPTF4/IREbz5EwJnpV8hETOD+NXIAr7N
         th6tF+6ThTrSJzdXgOJvuruCfhb3AnFdM0Ex/oHhxEAOTS7bBpb0iyBb6Rwvopzyd+zQ
         n8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mEe5lzHlglZonJ+BkLQU4xHEdjlrL8N/cawq7a3PVpk=;
        b=Ivvu19OM1ZmFKxt72cWgGjiXZELtZ7AykBJlP1b4wpObSmBK7oT0LYVJdpbnEDejy/
         v5YcADCEJsqr5Vb3vmtpjZwEjHM2sLtgCk9G6dFf0eUGqstT4jF56wcRI28NNRRkHb7K
         tV98xaL6IErVdxv55q/l4ovMhrP+1BK9RWncaH8uGs4feP9XJayxDHhzaBHBOgQUNb8D
         NstvPvM1ek+GysYnEh8TJBBrqxLUN/CLQKr9zKT85y+X3WhPKOrzPhKnbWZ3eptzIL+5
         c1zG+lKuz+3nYnjogUo8+PYyHbuo9Sy/VPVUI6Uk38dIuwNryCd/bkFy6G0I5Jp0CHk2
         rFgg==
X-Gm-Message-State: ACrzQf2Ou3xQhkNtPLdcAkHxsjbcpvPvl6RS2HLzr+Ri6qom/IlWHCk+
        XtR2HOGcaczetScqW11d7qk=
X-Google-Smtp-Source: AMsMyM512Cu33EUqlI8KbRRgyMlvRMRb//vnjGjUTibet1JXm3v6iq4C8igpQ30rWuOfRbFdO/Tvqg==
X-Received: by 2002:a63:e64a:0:b0:439:a99a:47a0 with SMTP id p10-20020a63e64a000000b00439a99a47a0mr4421994pgj.593.1665059438630;
        Thu, 06 Oct 2022 05:30:38 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902a3c700b0017f8290fcc0sm2647337plb.252.2022.10.06.05.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 05:30:38 -0700 (PDT)
Message-ID: <2dedeb9a-279d-8756-cb74-6d0919f0a02e@gmail.com>
Date:   Thu, 6 Oct 2022 21:30:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] locking/memory-barriers.txt: Improve documentation for
 writel() example
Content-Language: en-US
To:     Parav Pandit <parav@nvidia.com>
References: <20221006034457.165878-1-parav@nvidia.com>
Cc:     bagasdotme@gmail.com, arnd@arndb.de, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
        dlustig@nvidia.com, joel@joelfernandes.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221006034457.165878-1-parav@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Thu, 6 Oct 2022 06:44:57 +0300, Parav Pandit wrote:
> The cited commit describes that when using writel(), explcit wmb()
> is not needed. wmb() is an expensive barrier. writel() uses the needed
> platform specific barrier instead of expensive wmb().
> 
> Hence update the example to be more accurate that matches the current
> implementation.
> 
> commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> ---
> changelog:
> v2->v3:
> - removed redundant description for writeX()
> - updated text for alignment and smaller change lines
> - updated commit log with blank line before signed-off-by line
> v1->v2:
> - Further improved description of writel() example
> - changed commit subject from 'usage' to 'example'
> v0->v1:
> - Corrected to mention I/O barrier instead of dma_wmb().
> - removed numbered references in commit log
> - corrected typo 'explcit' to 'explicit' in commit log
> ---
>  Documentation/memory-barriers.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 832b5d36e279..8952fd86c6e6 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1927,10 +1927,11 @@ There are some more advanced barrier functions:
>       before we read the data from the descriptor, and the dma_wmb() allows
>       us to guarantee the data is written to the descriptor before the device
>       can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
> -     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
> +     a dma_wmb().  Note that, when using writel(), a prior barrier is not needed
>       to guarantee that the cache coherent memory writes have completed before
>       writing to the MMIO region.  The cheaper writel_relaxed() does not provide
> -     this guarantee and must not be used here.
> +     this guarantee and must not be used here. Hence, writeX() is always
> +     preferred.
So I assumed that this last sentence would be removed altogether.
Can you explain the intention of adding it?

IMHO, "preferred" doesn't mean anything in this document.

        Thanks, Akira

>  
>       See the subsection "Kernel I/O barrier effects" for more information on
>       relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
