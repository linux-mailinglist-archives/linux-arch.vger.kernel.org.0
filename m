Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757826AB222
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 21:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCEUo0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 15:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCEUoZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 15:44:25 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C07BDEA;
        Sun,  5 Mar 2023 12:44:23 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so11238244pjb.3;
        Sun, 05 Mar 2023 12:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678049063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQEhAEnCoSqPNLqIdWFb7wfcuPxRiAiR2KEKFk8XhXg=;
        b=XsgLdLib5YxD3UoqpUHhBtiMXrRSCSRmpOEeXQH70qS3WFbdWPt1QYhHdkVRA9Gj21
         mEDZTI0L9f5gUoHNGUz8dYsJKIca+pLBKlsRCwlYQKvVTuWV6OlYHhFz17PFlGmk2qai
         w48jZGK8k3O71v2p3Ca68xusJCiIKgpGuvqnOrH57yLfgW4OTASVw0mgHUaeGODiWwxk
         x10bxn2cw3B9cZ28kNFwxInwQIFf7GHfVfivx+Mb0UN+PaMJzNLbgbuQI61l0y63Tqnq
         f43J6fG1L58LZBfsbeLd8oQiz0acVMwoTIHqcI0gtuJJD7VWsi/T2hq99QSLOBlqWZNa
         wg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678049063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQEhAEnCoSqPNLqIdWFb7wfcuPxRiAiR2KEKFk8XhXg=;
        b=vvwPu6TGSPRVShDDpEBjVpc2kc7gwnEWEwDVOyNZQ4IN5V//YonbKzIqeXinK8aol+
         4mSdwj/AqNvUMSZ8AsjBgXx1rmu4ZdVlDKzpyHJiIUmNocNZh/09Bth/ei5vTjGvfL/R
         49EkLt0Bo9SIa3nSJA+ybvWr9474BZdbmjmA5k15HUEEh6AtvrdXp14gRM6P/5f9Z0Qf
         ogy7HKJVwIdblkH3RqV55wsBgroFH31wRSXchFWWlHmTxDGGD1lpXb4JbMSuGkuP4Gzp
         VimR4KMhAOaSa/3KPAr6YOLyr3+WWSSaBxqS/5q1HvYC5Tf4rmWUU1Pj/qA8SoJ4jZpj
         udZQ==
X-Gm-Message-State: AO0yUKXP7pM4gTbcf8nHldOtWcB816D7qDKeGn4i2raFKAMgZIx78k/Q
        ED+Kr5K3lOWeDqUKix77HEy3enmGlPo=
X-Google-Smtp-Source: AK7set/RbEx9jtFCpRX+pR8Y+f6oCnVFm4mqzGAENK55LPzQH1+61UY9MM+V+7mTev/dOMa3U25bEQ==
X-Received: by 2002:a17:903:41ca:b0:19c:be63:a9ce with SMTP id u10-20020a17090341ca00b0019cbe63a9cemr9066698ple.4.1678049063223;
        Sun, 05 Mar 2023 12:44:23 -0800 (PST)
Received: from ?IPV6:2001:df0:0:200c:c02f:c6b5:6aff:ae1d? ([2001:df0:0:200c:c02f:c6b5:6aff:ae1d])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902690700b001991942dde7sm5106140plk.125.2023.03.05.12.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 12:44:22 -0800 (PST)
Message-ID: <0b00a30e-cb7f-d42b-7d16-0ae8d50ed916@gmail.com>
Date:   Mon, 6 Mar 2023 09:44:17 +1300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 13/34] m68k: Implement the new page table range API
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-14-willy@infradead.org>
 <CAMuHMdW5TtUeZDmtHvxw+DxqUADC-OCW=tHE2Gptcoie62T+4w@mail.gmail.com>
 <ZAS1Lq6//oO/0PXe@casper.infradead.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <ZAS1Lq6//oO/0PXe@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Matthew, Geert,

sorry, I missed that one when it got posted ...

On 6/03/23 04:28, Matthew Wilcox wrote:
> On Sun, Mar 05, 2023 at 11:16:13AM +0100, Geert Uytterhoeven wrote:
>>> +               while (nr--) {
>>> +                       __asm__ __volatile__("nop\n\t"
>>> +                                            ".chip 68040\n\t"
>>> +                                            "cpushp %%bc,(%0)\n\t"
>>> +                                            ".chip 68k"
>>> +                                            : : "a" (paddr + nr * PAGE_SIZE));
>> As gcc (9.5.0) keeps on calculating "paddr + nr * PAGE_SIZE"
>> inside the loop (albeit using a shift instead of a multiplication),
>> please use "paddr" here, followed by "paddr += PAGE_SIZE;".

Are we certain that contiguous vaddr always maps to contiguous paddr?

If not, I'd suggest we increment vaddr inside the loop, and use __pa() 
each time:

> +++ b/arch/m68k/include/asm/cacheflush_mm.h
> @@ -235,13 +235,14 @@ static inline void __flush_pages_to_ram(void *vaddr, unsigned int nr)
>          } else if (CPU_IS_040_OR_060) {
>   
> -               while (nr--) {
> +               do {
>                          __asm__ __volatile__("nop\n\t"
>                                               ".chip 68040\n\t"
>                                               "cpushp %%bc,(%0)\n\t"
>                                               ".chip 68k"
> -                                            : : "a" (paddr + nr * PAGE_SIZE));
> -               }
> +                                            : : "a" __pa(vaddr));
> +                       vaddr += PAGE_SIZE;
> +               } while (--nr);
>          } else {
>                  unsigned long _tmp;
>                  __asm__ __volatile__("movec %%cacr,%0\n\t"
>
(just edited Matthew's patch in the mail editor, untested, may not apply 
cleanly ...)

Cheers,

     Michael


