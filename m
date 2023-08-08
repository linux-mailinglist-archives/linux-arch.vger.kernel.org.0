Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04087774D4F
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 23:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjHHVsN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Aug 2023 17:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjHHVsE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2023 17:48:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398F2175DDE
        for <linux-arch@vger.kernel.org>; Tue,  8 Aug 2023 10:19:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5234dee9a44so355457a12.2
        for <linux-arch@vger.kernel.org>; Tue, 08 Aug 2023 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691515187; x=1692119987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMnxgsCoh82ZoNEGZ3gXMUz0wSz2MoqQmZYxTHk1iuo=;
        b=wjthSXg/fQNd9RMXGsA23XJFov9pnFr+goO4hgqTjlahaHNskf5qHl73zO5k342EET
         23L7iqrrcc9JOlHDKnnCkq1LWr+XlYjDwJwB6BnBGNK6DxTayKmpQr45awcpokrvfTX4
         ejS8jY1RrpJ4m6u10RV59/LcUU3dG3UOARhIFMf+ICbaesqOUVad5bgwz3WgOFWG6YFY
         qrw0K3Xkay3PbSRaPNEG8wEIFLcrvHDXCt6qVv3AcO+ifR4t0t+eG7yd+kDudpneuoZo
         UygMQxnKiprtbb7gdGPgFk+B2+Elb+4SJQXQVEosnleEmSuMPaPKrzQ63I4k6lcUKyfc
         rahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515187; x=1692119987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMnxgsCoh82ZoNEGZ3gXMUz0wSz2MoqQmZYxTHk1iuo=;
        b=QTPBvGCXFSxhQdMKucTdyS/8PRgn6vnvexvGh0pH5OX6EkOWSQccOvklJl3RJVus6K
         1Av1aFDOq2W2IqsYfMlMD2YltcTr9nBqDhcq+r599B8uGv+1uQeR6n98gutEITStqvvr
         Sv3WBOlz+EKOHiYV+Hl8kpYItkxdRyM1hVvwRHdTRB6mpHgOVyYOEWE3HT5p80IcTQbU
         wz7y04eEQ1q0ZkZJ8SlzugNHhin1JijrnTMzv6d2dEo/n+eGEODJry+2eh5nRqkV4PTe
         +ACdys8WlaQHbKmKpJ141bM9wSKRpLKoIEQjGz8K+ITL17I8vPaDRUaYZKlXt/eHrUnW
         zvbA==
X-Gm-Message-State: AOJu0YyhK9EkY5oDg3p0Q9xPEg4CY9DcohGC4OkoI5LjUm1/4bmMmvQM
        KIR3wjCNwor8kvE1KH2HiXbF72PpvFqpm/k6hLI=
X-Google-Smtp-Source: AGHT+IGh6quNsM0lZU6+CofawmyTZRbZPfDUraQexF9fMQWdjRw/ox0syxTlOeazcQZlc3UFNsK4eQ==
X-Received: by 2002:adf:dfc8:0:b0:317:f1dc:36ed with SMTP id q8-20020adfdfc8000000b00317f1dc36edmr2849673wrn.47.1691487575619;
        Tue, 08 Aug 2023 02:39:35 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.177.253])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d474a000000b003141a3c4353sm13080004wrs.30.2023.08.08.02.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 02:39:35 -0700 (PDT)
Message-ID: <794d4bfc-2404-9f4f-4a00-f5edf44a3f5a@linaro.org>
Date:   Tue, 8 Aug 2023 11:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] mips: remove <asm/export.h>
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230807153243.996262-1-masahiroy@kernel.org>
 <20230807153243.996262-3-masahiroy@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230807153243.996262-3-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/8/23 17:32, Masahiro Yamada wrote:
> All *.S files under arch/mips/ have been converted to include
> <linux/export.h> instead of <asm/export.h>.
> 
> Remove <asm/export.h>.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>   arch/mips/include/asm/Kbuild | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


