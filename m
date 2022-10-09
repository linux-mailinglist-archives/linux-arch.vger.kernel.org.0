Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62FC5F88C4
	for <lists+linux-arch@lfdr.de>; Sun,  9 Oct 2022 04:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJICEb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Oct 2022 22:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiJICEa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Oct 2022 22:04:30 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4D5357DE;
        Sat,  8 Oct 2022 19:04:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f140so8069753pfa.1;
        Sat, 08 Oct 2022 19:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mZNcIuxVWg8kZ0UqoxvnWnvMCMySE4yCtjVKlUiuDk=;
        b=UdiA9qs/nNYzNtP0OZjAa8HtOJktFx2yvyv70tPgV6wAuELOPU6+3Cy0igaZqqlNTt
         CGUVA5BF+zfs400Va79BZYdJkWg1yyktQLIW0VyhYfe9S0duA5s6lxUy63c5bvkqDRxX
         PAUULStdUr3hSdJngUMmsjKAiRUjKC4INM62+sel9oRlLFLHrMS0ZIpdP0phahOCHdlj
         WhVlfrr1FiiE134sC7S9WDpIus2/WoXTKKmiv3ee06xEeqKxdMz8Tr48WJmv0hMvKnLa
         qRHUM9n+k0HL/jkn2j4PRgAQ7w51r9nbUjI+gvzvmayPpQXEnHwTmAPoAmgKCfmCaD7R
         9c0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mZNcIuxVWg8kZ0UqoxvnWnvMCMySE4yCtjVKlUiuDk=;
        b=2BNpIk+588I6wzhRVjfTiV5FKJI+dMzmvspO+5ldj3DG1M6JfbY6eUGoM/goKXP2SJ
         Niyo3FQvR5InZfX0hMeeDAE5OurJDYbItuy+I42PWmS1sPat092N+q67pPmP6DX0avVN
         KTxUartdSEnkqhs0Ov//clfvtPkbKbIFRDpB8J/1AHXDOIOzC5sKVpgB4SUDU85UB/Ty
         sdQj8TbKClvcpK8JqrTHK8eK6TxAl8jYmP0G1JUuicYLRlpVPiMeJ5fBWRvUdtkPoVjl
         vJm8fnoMBrGbvEMPAuoDUoNSGvq6hJ1S2uZ/nofh5DbMQFm/bJhRSSNXtYCZreTuy56U
         iWlg==
X-Gm-Message-State: ACrzQf020cbD4RDxvpNG6N7jqipG/ydvXA/akRWwRoBdVK4HL7LuIDMn
        Fpd1AHbzbLKBd4lzqBzoslFDoWlPq+Y=
X-Google-Smtp-Source: AMsMyM7vvTSDrWOwIC1OjgI0NtjoJChNVuTtmjvZSFCWM/Z7GP7WSh+qQVuCIZAr12JnHka6lq8JBA==
X-Received: by 2002:a63:491b:0:b0:461:7362:e8b7 with SMTP id w27-20020a63491b000000b004617362e8b7mr1332577pga.30.1665281069644;
        Sat, 08 Oct 2022 19:04:29 -0700 (PDT)
Received: from [192.168.43.80] (subs09b-223-255-225-235.three.co.id. [223.255.225.235])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902868c00b0017f7f8bb718sm3906464plo.232.2022.10.08.19.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 19:04:29 -0700 (PDT)
Message-ID: <10204e9e-3118-730a-823b-1f5959a429b8@gmail.com>
Date:   Sun, 9 Oct 2022 09:04:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/4] docs/memory-barriers.txt: Add a missed closing
 parenthesis
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>, paulmck@kernel.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221008174928.13479-1-sj@kernel.org>
 <20221008174928.13479-2-sj@kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221008174928.13479-2-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/9/22 00:49, SeongJae Park wrote:
> Description of io_stop_wc(), which added by commit d5624bb29f49
> ("asm-generic: introduce io_stop_wc() and add implementation for
> ARM64"), have unclosed parenthesis.  This commit closes it.
> 

s/This commit closes it/Close the outer parenthesis/

-- 
An old man doll... just what I always wanted! - Clara
