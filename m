Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787FE791DBD
	for <lists+linux-arch@lfdr.de>; Mon,  4 Sep 2023 21:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjIDTht (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Sep 2023 15:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjIDThi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Sep 2023 15:37:38 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800701A7;
        Mon,  4 Sep 2023 12:37:35 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-792623074edso52369139f.1;
        Mon, 04 Sep 2023 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693856255; x=1694461055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7crZJwRytTyyIdDEoCObBVMoTgADDmg//xC0edSFAc=;
        b=DP3qzS0uU5murYOGJ06S73WezdI3YkqOavc5wSfAfZzPE3HKpX126k9YpPU+eEz68X
         Eqkake3Joz/TTjdhlnlW5a6U6nUcfJgaHk9gSi/1UqzHQeJRu2DhVWciJkfFh4hTBb6Q
         QihWPVdkNHmGHCrV0TQsavXzG1d5l9biS1t8OKWd24mALK8crbYj3cUdU0vbOYBiFSA4
         WTl7HlOTgJM9WgaQ+1x0NCqLfgTGSieSqQVkxj9YFVl/r/6cWIDf6IPiosQewC98bUOV
         SF1sEuL2biPJl3nprHI22cWic/l/sZN/z0smxkLTB59yMmqCYM9xdx7bKeShdKjzlGk2
         HdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693856255; x=1694461055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7crZJwRytTyyIdDEoCObBVMoTgADDmg//xC0edSFAc=;
        b=KbgBwZDg78xmo3zOOV6OJkipMjmUnh8JbIXle6fsNiohaoApVjN35PTss8cvC8sLT9
         rN9F19pHNvXZGmDi18a7UkRvEO/EDc/P1wLTG72u8NIL6GBgVXxwO0a9/adCZ3Qd00G5
         3aTxPRqm5tEZWcXYv+lJ664C6gCkPozwUZIBxShO0JuGNLGkOv+hsGGeEfDqqqY/EJlm
         ByGErmhq/ToLR5sKcbkkN+Jy87rcjTUin9QfNrAB4k0WVtJq22UHSzglpt4DaxiPUV9W
         iKTuA3p8qzZYDRr8UdyGdeNZsLPPbQm4cXUuiXdX8o1EDc126CYYPF+QRKkwdPmg1NCa
         iYtA==
X-Gm-Message-State: AOJu0YyiaUcxAiwrSj6rFAcgs0IMyjADvgFOgb35uPoE6cD+g6Y4h873
        X+gJBAZ+8OStuaBwdgNWPaw=
X-Google-Smtp-Source: AGHT+IFDurXHV+YzkGcDx9hZwXp6jjNXSTz4+sen5na4mkdEAIh/GoEp5EEWbtX+xgRfL4fx0ca7MA==
X-Received: by 2002:a05:6e02:1568:b0:346:15f5:2667 with SMTP id k8-20020a056e02156800b0034615f52667mr13409607ilu.4.1693856254831;
        Mon, 04 Sep 2023 12:37:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gg18-20020a056638691200b0042b57bbbaf2sm3604214jab.26.2023.09.04.12.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 12:37:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5a85bd1e-18b1-080f-922c-b14372093035@roeck-us.net>
Date:   Mon, 4 Sep 2023 12:37:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 26/38] sparc64: Implement the new page table range API
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
References: <20230802151406.3735276-1-willy@infradead.org>
 <20230802151406.3735276-27-willy@infradead.org>
 <2513a500-920d-4e32-8231-f428175c7182@roeck-us.net>
 <20230904174350.GF3223@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230904174350.GF3223@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/4/23 10:43, Mike Rapoport wrote:
> On Mon, Sep 04, 2023 at 08:36:44AM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Wed, Aug 02, 2023 at 04:13:54PM +0100, Matthew Wilcox (Oracle) wrote:
>>> Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio() and
>>> flush_icache_pages().  Convert the PG_dcache_dirty flag from being
>>> per-page to per-folio.
>>>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: sparclinux@vger.kernel.org
>>
>> This patch causes all my sparc64 qemu boot tests to crash.
>>
>> [    4.890744] Unable to handle kernel NULL pointer dereference
>> [    4.891273] tsk->{mm,active_mm}->context = 0000000000000001
>> [    4.891475] tsk->{mm,active_mm}->pgd = fffff80005452000
>> [    4.891660]               \|/ ____ \|/
>> [    4.891660]               "@'/ .. \`@"
>> [    4.891660]               /_| \__/ |_\
>> [    4.891660]                  \__U_/
>> [    4.892116] modprobe(45): Oops [#1]
>> [    4.892555] CPU: 0 PID: 45 Comm: modprobe Tainted: G                 N 6.5.0+ #1
>> [    4.892949] TSTATE: 0000004411001601 TPC: 00000000004565d8 TNPC: 00000000004565dc Y: 00000008    Tainted: G                 N
> 
> ...
> 
>> [    4.901535] note: modprobe[45] exited with preempt_count 2
> 
> This should fix it:
> 
>>From 8181d1f582a309b51fe4cb02a783628257b91c86 Mon Sep 17 00:00:00 2001
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Date: Mon, 4 Sep 2023 20:37:59 +0300
> Subject: [PATCH] sparc64: add missing initialization of folio in
>   tlb_batch_add()
> 
> Commit 1a10a44dfc1d ("sparc64: implement the new page table range API")
> missed initialization of folio variable in tlb_batch_add() which causes
> boot tests to crash.
> 
> Add missing initialization.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 1a10a44dfc1d ("sparc64: implement the new page table range API")
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Yes, it does.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
>   arch/sparc/mm/tlb.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index 0d41c94ec3ac..b44d79d778c7 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -128,6 +128,7 @@ void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
>   			goto no_cache_flush;
>   
>   		/* A real file page? */
> +		folio = page_folio(page);
>   		mapping = folio_flush_mapping(folio);
>   		if (!mapping)
>   			goto no_cache_flush;

