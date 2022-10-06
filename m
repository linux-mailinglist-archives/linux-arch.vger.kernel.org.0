Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC185F5E86
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 04:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJFCBB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 22:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJFCBA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 22:01:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D20A38463;
        Wed,  5 Oct 2022 19:00:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so375939pjo.4;
        Wed, 05 Oct 2022 19:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6s3ao32CYkBZ7LY5HMNWqdpQ7ZGa5SPsXw0rY2SB3c=;
        b=JjUunvLo+jOhDGcLkJUdg3dQ7htfmQL0Em6StsXJKNdx110T0EuQSgU4smcsIXLd80
         UbipMkYAsr4C9CyZi2XX38DszTmoMcl8KR3U829PDIk6PW5mXX8FJsk0dErADYWGFv4z
         PgMf4cJaao128y+/3hKkK7EIpCFgVACbGPayeB/jxrUIC5GHvenWARDyllIlO1TLugu+
         M8eZzINVzfOVIpWMlenvsknDo/yf4QA7GMv3D2Kn1yxyX9bf7VojnJV/gLgJ1IINkg9i
         ieb7XMoLl9bVmPVyYS5tYWCNBc9phBXtj/zV1X455o1nwwor67GfFzGVFcIt/L4p6CR6
         KaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6s3ao32CYkBZ7LY5HMNWqdpQ7ZGa5SPsXw0rY2SB3c=;
        b=kt4YJz+pS1DfNbZYceH7AyuiFazhpZbtz7SX3eEg/81eAW/oAxOspLO+grzvrI4B+H
         sZMZ6PmJSUhysJOXBDLkUL/GAQtT78838iAQB1ZbzZ6rQ1nnDzETNx4i5M5NvPwHVAc1
         LxPQ+lX9JyNC+Zjte0ANdcKqAbXOb4Xj51YCM2PSQtAZzg4tHJB9JA+efI2Rwe/JU1w2
         J/64gn+SdeZizgRYx3IhqPix0e2VWcbzFt47IYLZI+sGHmOJCdpP1go2LLnZPyT2WaVT
         rD14SGvtVudLpTs6uirgqFKLc24kl1HbTkYqR/KclDALlguPL2pb3O9vhjYFy9h3oxgF
         cT2w==
X-Gm-Message-State: ACrzQf191Ba793AqrpK65xbqdshMJd0652RGVTtIdT4568KewqjkL8AZ
        A1yd7Q2LA/gg6AW5j031ulc=
X-Google-Smtp-Source: AMsMyM4RmbJWNF/D35Z32gj1oG5TSk0Kf4Y9uNodlR2+cbUxNykHme/2bouK+TbY0eMSmL/p0U62lw==
X-Received: by 2002:a17:902:f546:b0:177:ed6b:4696 with SMTP id h6-20020a170902f54600b00177ed6b4696mr2411132plf.171.1665021658687;
        Wed, 05 Oct 2022 19:00:58 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-20.three.co.id. [180.214.232.20])
        by smtp.gmail.com with ESMTPSA id y3-20020a1709027c8300b001754e086eb3sm11011450pll.302.2022.10.05.19.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 19:00:58 -0700 (PDT)
Message-ID: <a938dcae-0f0c-e99c-7217-29e52a4b2052@gmail.com>
Date:   Thu, 6 Oct 2022 09:00:50 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] locking/memory-barriers.txt: Improve documentation for
 writel() example
Content-Language: en-US
To:     Parav Pandit <parav@nvidia.com>, arnd@arndb.de,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@kernel.org, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221005104749.157444-1-parav@nvidia.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221005104749.157444-1-parav@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/5/22 17:47, Parav Pandit wrote:
> @@ -1927,10 +1927,12 @@ There are some more advanced barrier functions:
>       before we read the data from the descriptor, and the dma_wmb() allows
>       us to guarantee the data is written to the descriptor before the device
>       can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
> -     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
> -     to guarantee that the cache coherent memory writes have completed before
> -     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
> -     this guarantee and must not be used here.
> +     a dma_wmb().  Note that, when using writel(), a prior barrier is not
> +     needed to guarantee that the cache coherent memory writes have completed
> +     before writing to the MMIO region.  The cheaper writel_relaxed() does not
> +     provide this guarantee and must not be used here. Hence, writeX() is always
> +     preferred which inserts needed platform specific barrier before writing to
> +     the specified MMIO region.
>  

Did you mean that writeX() is write() function family?

-- 
An old man doll... just what I always wanted! - Clara
