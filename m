Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211FF5B9A91
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 14:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIOMQf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 08:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIOMQe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 08:16:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9594999B76;
        Thu, 15 Sep 2022 05:16:33 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c198so17852208pfc.13;
        Thu, 15 Sep 2022 05:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=qnMPBaAj1F3T+8uZYN8jbU4xqXRIMovL97bP0OzxrFk=;
        b=RU8hZBI/8Ck49RloIrjJgsj+xZtizolgAaWkd130ApklbJmxi6clWXsXoN7u7tfcaP
         p6Njbr14DJqQ1e2AlQYXjcuYP8XcAeyKrdU62m56NHeCYG/wZG9FUxwgzyvdmXqGbr6C
         PJQmOf414VMDGjQjNWhrd0KflKApcIef2nRCgfSCyALTTJXOhQsR10c+FSBy+TqY/ZXM
         TZcHB9xFxx8GgE8pYf2OzXvB1lIbY/HL9Af7yO7c0pvs/nBou2BLN6RqYeYttrxWgHTn
         VKb/pwkzwZTJ8AQ0HpxWmgts5HCcGVg3bWSatpEXw6gW/pfLPk/1S7dMilY2oqUtP/Ek
         VI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qnMPBaAj1F3T+8uZYN8jbU4xqXRIMovL97bP0OzxrFk=;
        b=Ywtl0SltZxZPGJWm14tKRMK27O8UgqboxUqmD91xDcYZhy5Tb2QKpEaT3/oecGCW45
         W4y1VbUhFuUtow+N2+KJJZRT8UYQV7m6yJKacuZlh53uYp9vq5XJSY8J2c0WIYbNn9nC
         KaS8CQ95MaXKabyjjvsiqqwebjgwOb4RfvZ3NOLi/v+L5CCKZSwCPA+1JabS7B4NXJU0
         YX0MKy4XCA1h9kc0fSv92Y3iAdF2bbNv8kq9uhoLjsJb6kM/uwMxzzpB4waxhtrTQXxY
         bzWYgcoiU6O2RRvsxMiXXD8kB8K9TCj4X2nQVQhArxakp4S9VdH1xB+ow6Li1cNBFyBl
         WXvg==
X-Gm-Message-State: ACgBeo1Y5GnO9CyfkXrfaplBxfUULWLKYNac1ZPeanhugvvp+UzjrUsr
        EqyF+QVecEq7dtz2QJCMF2c=
X-Google-Smtp-Source: AA6agR4+pfSgCfDDqhYhxLZkNNkPZXlWG5N7V5crl7vr0SWJD7xxRn4xH2ZIQgtnu2/SiThMWKFDuA==
X-Received: by 2002:a63:8bc8:0:b0:438:bc9e:edc4 with SMTP id j191-20020a638bc8000000b00438bc9eedc4mr21054588pge.20.1663244193024;
        Thu, 15 Sep 2022 05:16:33 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-22.three.co.id. [180.214.232.22])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902f34900b001768b6f9a97sm12657259ple.147.2022.09.15.05.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 05:16:32 -0700 (PDT)
Message-ID: <6698eda3-977b-902f-ba23-89cfd674c121@gmail.com>
Date:   Thu, 15 Sep 2022 19:16:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] locking/memory-barriers.txt: Improve documentation for
 writel() usage
Content-Language: en-US
To:     Parav Pandit <parav@nvidia.com>, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220915050106.650813-1-parav@nvidia.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220915050106.650813-1-parav@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/15/22 12:01, Parav Pandit wrote:
> The cited commit [1] describes that when using writel(), explcit wmb()
> is not needed. However, it should have said that dma_wmb() is not
> needed.
> 
> Hence update the example to be more accurate that matches the current
> implementation and document section of dma_wmb()/dma_rmb().
> 
> [1] commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")

Just say the blamed commit without using numbered references.


-- 
An old man doll... just what I always wanted! - Clara
