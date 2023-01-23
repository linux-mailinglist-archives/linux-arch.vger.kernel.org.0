Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6192E677601
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jan 2023 09:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjAWICy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 03:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjAWICx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 03:02:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1207DF75A
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 00:02:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bk16so9918034wrb.11
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 00:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1Gxh+1vf6kqqu8QMgqF+ZuE7dNwAJOxaP/Fg9TsMVI=;
        b=ABfrupbuMKJ5qEZ20DIw5wuM+lYY2FXTw7ee7JerJvXbm8mdVsJQ/Le8r+mQIQx9r2
         y0FnMyAHQ9ksp5lMMroOFmp/ubrstkdqM1+gS2lSjfdPe7kfNrhdPB6OEalv4b48eruj
         bUJHtEbxrocnhwayzOyNo177BND9U7z65jstRIDM4C6u7M2igp0ILac1T+nfcAFPrEAk
         NbIK5GXQ4IvAC/rE82Hk541twkxoIsq3YKV6VpkYX7uezcfpT6Uvq2EHphrDdKOWla6R
         98dZguUw+SbkQWOVeIiQz/pWbNutbH6Yo3MrlV562+ImFu7NyrUdnzPXuzoZqqwdfZBY
         79ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1Gxh+1vf6kqqu8QMgqF+ZuE7dNwAJOxaP/Fg9TsMVI=;
        b=tnmVPjCeGxuezcGyspQ7lSTZ9cZAH6Rdo6iS3wiBf2FTTggqdbAh03pN1ReK+KSmtK
         NYRZYUaFXUduF/dQ6T1vt28QC4rjn8+OYS+iBC6i2TMwPh/yhyebERQi9JYDAip+exOD
         3rf3lsyO5QAMcgkqh+RgNnbrJtu5d657aZROQlBlwdP7t5X1Xuw6Xyi76dinzcAtN6iU
         lRMkTFElzaxLIDG8+7V9GBSh+L7McpUGPyFW6UkEI2+d6jSrvUgoHlEWxNpYTYM8DHAM
         AG9/ZjQMkg1uHwauyPaHq05HedWZBW6pqxfMMlUFIPf0jd9yF15dbZbe26AoysKutATT
         KLTQ==
X-Gm-Message-State: AFqh2kqM9M7cbeqEa+D9K2u5dtft7lhbvdUr+QrFPULzUyOgaslck61w
        caN2fEJEDzUx6iCS7MkV3yg=
X-Google-Smtp-Source: AMrXdXvtVzd4wrInqjGZf8+t4ZCgLi7z3CMmu5lM22MHoDwkB+IefqFJI2CQnBOQIMb4RzHb1a9uKg==
X-Received: by 2002:a5d:56d1:0:b0:242:ac3:87f4 with SMTP id m17-20020a5d56d1000000b002420ac387f4mr19674169wrw.50.1674460970223;
        Mon, 23 Jan 2023 00:02:50 -0800 (PST)
Received: from [192.168.86.94] ([77.137.66.37])
        by smtp.gmail.com with ESMTPSA id m8-20020adfa3c8000000b00236545edc91sm3424033wrb.76.2023.01.23.00.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:02:49 -0800 (PST)
Message-ID: <4d26df97-3725-182b-6312-fa5cd8e9f85d@gmail.com>
Date:   Mon, 23 Jan 2023 10:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.0
Subject: Re: [PATCH v6 2/5] lazy tlb: allow lazy tlb mm refcounting to be
 configurable
Content-Language: en-US
From:   Nadav Amit <nadav.amit@gmail.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
References: <20230118080011.2258375-1-npiggin@gmail.com>
 <20230118080011.2258375-3-npiggin@gmail.com>
 <ee3844c0-b342-edc6-77cf-4cdc78e30a18@gmail.com>
In-Reply-To: <ee3844c0-b342-edc6-77cf-4cdc78e30a18@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 1/23/23 9:35 AM, Nadav Amit wrote:
>> +    if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT)) {
>> +        mmdrop(mm);
>> +    } else {
>> +        /*
>> +         * mmdrop_lazy_tlb must provide a full memory barrier, see the
>> +         * membarrier comment finish_task_switch which relies on this.
>> +         */
>> +        smp_mb();
>> +    }
>>   }
> 
> Considering the fact that mmdrop_lazy_tlb() replaced mmdrop() in various 
> locations in which smp_mb() was not required, this comment might be 
> confusing. IOW, for the cases in most cases where mmdrop_lazy_tlb() 
> replaced mmdrop(), this comment was irrelevant, and therefore it now 
> becomes confusing.
> 
> I am not sure the include the smp_mb() here instead of "open-coding" it 
> helps.
I think that I now understand why you do need the smp_mb() here, so 
ignore my comment.
