Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F6876F343
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 21:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjHCTLa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Aug 2023 15:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjHCTL3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Aug 2023 15:11:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3E2106;
        Thu,  3 Aug 2023 12:11:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6877eb31261so958319b3a.1;
        Thu, 03 Aug 2023 12:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691089888; x=1691694688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qIGiPfm4hS40ZpPqvFdolNkVIuhy187vavdxiwOEMqs=;
        b=i2gLtqDPkuaHH7oy2Mv6lwVVjH2aiWpiZfCF+9hAV+dKYmYCPSMeMm98zePZ5lBEJ4
         8jcjwOoVSGY4efzL7bHWOGqL8Gp6TwR94BKPBLumkgqZxAfcDDk5lUV7814Yu/3Vy4m+
         BapYr0AOR/g7C79KMOQ6D2h0pnmubXs2ZG0iXA9q5SX3QbY4eb8gVdras0lYIFpUDh9y
         gafm7mnb9fReUAXQcxN8TW4LbGNfnDU3N2PG0gzH+Gdgnl1LE5v2r+wvkD0cuV10f7qK
         hRRQppe4PF19gNP+SgF6NvJqPwbpa+fs1D0HHICo8jMzln7atqcB9tT4yOCQRYIz4INw
         hNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691089888; x=1691694688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIGiPfm4hS40ZpPqvFdolNkVIuhy187vavdxiwOEMqs=;
        b=UYKQjCjD39Hp0JxTRBt9T8g7rr4JEGWC5M3BCRGDIePcEdyMs0qcMAInvgNKqUBqd4
         udk+B1sULAxz9rm4vN5bzjTBgYyGGKRZBD7FyVa/gg04d+wM05GVwzfDaBMZ2OdIYdSi
         8d0oJUj8k+UP7IaHbiiUfAUHDBdW5ZDAGKwYs7NsB7N3TinQBeIoe1n/fh9UTaGWt5Y4
         7WhVnIX0QoKz/K7CPSue3MyzM2dqVgGbEQsHqaiYM/QLajacSh6KCigpZdgXjL0XOFmL
         cbr2NJocB8U70k19jN3Begiux7Xb2fgBpJkeGIyOt8mNoXKgksalfsH+MnEdxYQb1s2L
         /6Vw==
X-Gm-Message-State: ABy/qLagWYAbGKC9U/pt9IWZleBsno8WW2rAFbuSyTP3/IVU29oGudh5
        3fPMUfbdqHPlNHF0Izoxcgg7i8tRECQ=
X-Google-Smtp-Source: APBJJlHiipwmSv+Wv3jDp9R0HHNyX4KmIynHEIYQvubFj6cHWFDW0cXR+Itq5lVXyekkIc5e+MDh2g==
X-Received: by 2002:a05:6a00:1501:b0:687:5763:ef27 with SMTP id q1-20020a056a00150100b006875763ef27mr9918964pfu.33.1691089888210;
        Thu, 03 Aug 2023 12:11:28 -0700 (PDT)
Received: from [192.168.1.100] (bb220-255-255-44.singnet.com.sg. [220.255.255.44])
        by smtp.gmail.com with ESMTPSA id n6-20020a63b446000000b0055fedbf1938sm159068pgu.31.2023.08.03.12.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 12:11:27 -0700 (PDT)
Message-ID: <c6bfa51b-eeda-04c8-242c-d177f0889023@gmail.com>
Date:   Fri, 4 Aug 2023 03:11:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 01/38] minmax: Add in_range() macro
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230802151406.3735276-1-willy@infradead.org>
 <20230802151406.3735276-2-willy@infradead.org>
 <cf3085ba-5b2e-c048-20bf-4b9a54443cc8@gmail.com>
 <ZMuqLhfsu0tV/tAT@casper.infradead.org>
Content-Language: en-US
From:   Phi Nguyen <phind.uet@gmail.com>
In-Reply-To: <ZMuqLhfsu0tV/tAT@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/3/2023 9:22 PM, Matthew Wilcox wrote:
> On Thu, Aug 03, 2023 at 09:00:35PM +0800, Phi Nguyen wrote:
>> On 8/2/2023 11:13 PM, Matthew Wilcox (Oracle) wrote:
>>> +static inline bool in_range64(u64 val, u64 start, u64 len)
>>> +{
>>> +	return (val - start) < len;
>>> +}
>>> +
>>> +static inline bool in_range32(u32 val, u32 start, u32 len)
>>> +{
>>> +	return (val - start) < len;
>>> +}
>>> +
>>
>> I think these two functions return wrong result if val is smaller than start
>> and len is big enough.
> 
> How is it that you stopped reading at exactly the point where I explained
> that this is intentional?
> 
> +/**
> + * in_range - Determine if a value lies within a range.
> + * @val: Value to test.
> + * @start: First value in range.
> + * @len: Number of values in range.
> + *
> + * This is more efficient than "if (start <= val && val < (start + len))".
> + * It also gives a different answer if @start + @len overflows the size of
> + * the type by a sufficient amount to encompass @val.  Decide for yourself
> + * which behaviour you want, or prove that start + len never overflow.
> + * Do not blindly replace one form with the other.
> + */
> 

Oh, sorry, I see, my bad.
