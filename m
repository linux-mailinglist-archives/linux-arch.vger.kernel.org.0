Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41334FC6A3
	for <lists+linux-arch@lfdr.de>; Mon, 11 Apr 2022 23:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350187AbiDKVXb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Apr 2022 17:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350251AbiDKVXF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2022 17:23:05 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59352ED57;
        Mon, 11 Apr 2022 14:20:50 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id s14so5364863plk.8;
        Mon, 11 Apr 2022 14:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9+KXQz4AgAAaQRzQM2YK2R02WQKfgHNx/VOWl4V0PaA=;
        b=1oPPT+iExtkBTKo2HxfhiQ/rc/pAatBu7AYU6CuIMI/ceuVzDRiv2aXE9W7DE2tZdA
         hxNxGfyjLtD0jtrM8Fk7OnP9+obcDqui8v8UilWhWvW/gxnv4RWyn2t/21k3EtdFEfyp
         8b9W8tq6fbdG2xPzbaC1T3ysrxu+9FPloPRTiXr8gPh1Dz/3Doa1P9YbYP+lOcLuPodJ
         YQtTaM9IVRnqEH/fDY9w26hC2xs10Q37Hw6GWsVSuEwpjRomoYAn/xJmBHC+xIzyhw4k
         9+kFJ/UIOcCFy4s9mSeL+NNZFc8sA7DfRIG+BYtL8586+I79NZbpcxGhYeKhRlDzjI9b
         A7Uw==
X-Gm-Message-State: AOAM531pI6Y17OqFiY9+0s0gJy8HF4/Qchv2hRxPtW7zkPNSsuF9OUbv
        35FgwsKqKsNCKNzh0jV9Ies=
X-Google-Smtp-Source: ABdhPJwMQ4QcZZ4omhtshFNnao7W4LvQ5dY8Q00SlCWpvG1OUohcRikoWl0Ht9jN0ylJbCQoEV490A==
X-Received: by 2002:a17:90b:3a87:b0:1c9:9eef:7a9 with SMTP id om7-20020a17090b3a8700b001c99eef07a9mr1222767pjb.103.1649712050142;
        Mon, 11 Apr 2022 14:20:50 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ec99:44ba:c45c:cd3e? ([2620:15c:211:201:ec99:44ba:c45c:cd3e])
        by smtp.gmail.com with ESMTPSA id md4-20020a17090b23c400b001cb66e3e1f8sm401333pjb.0.2022.04.11.14.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 14:20:49 -0700 (PDT)
Message-ID: <32c07164-ae1a-a135-2d1f-3b660cbcf107@acm.org>
Date:   Mon, 11 Apr 2022 14:20:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] asm-generic: fix __get_unaligned_be48() on 32 bit
 platforms
Content-Language: en-US
To:     Alexander Lobakin <alobakin@pm.me>, Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406233909.529613-1-alobakin@pm.me>
 <20220411195403.230899-1-alobakin@pm.me>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220411195403.230899-1-alobakin@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/11/22 13:00, Alexander Lobakin wrote:
> Uhm, ping?

What happened with the plan to move this function into the block layer?
I'm asking this because if that function is moved your patch will conflict
with the patch that moves that function.

Thanks,

Bart.
