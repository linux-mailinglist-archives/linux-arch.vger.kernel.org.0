Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E267D54F747
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 14:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381628AbiFQMNR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 08:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiFQMNQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 08:13:16 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F85E3D;
        Fri, 17 Jun 2022 05:13:15 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i81-20020a1c3b54000000b0039c76434147so4269153wma.1;
        Fri, 17 Jun 2022 05:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hnlyRioGpxx+rbPm2S0jS6ADUAhgKmqzSuVKtSCygKE=;
        b=DtNHpfpHlFlaeqXduwx0230ymigZwE3YzhrDwapDz6K7xjYWim1sOMYwnNqiFUtIdO
         LtRUjjUdSifY8JlG/rs5SUmn3NvK1rDYkFwODdcErzXrabvUSYS6mj4qWre9UNA3jsQK
         xmj00Gg7lW4qkYffU+wUvpcHXY0opEJwW1UU+pRlFBzqK6r7gXx+2mrjZ7dHbiln8iau
         aA4Zxc0DzqPAg1WlyEPnvDkBb3KXdViTCXE2bjYWMqb00WQlM4W9FibqQv4HJ8ttXTET
         MHmzHNaZFdWHVCRulhu6KHWpPB1ewT73HoTPmPZwu6AvVbcPeALy6jsLwbHzpT6at+0U
         YiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hnlyRioGpxx+rbPm2S0jS6ADUAhgKmqzSuVKtSCygKE=;
        b=enFkf3sOmvcejbNwl+4Q8xiXB1ldCQkAac1KzcBnEdGlPl+Lal5XkZVkBK4EJiDxmj
         D7jBfOEsYXY27NrHfPd2NUjkBNxpqLWIWZrkItL/+miB00swyvcBEME0O/N1eeLf4tzK
         ri0P4GSKiPq/wUUyzR7NzFmjuQgtH/og2gNGYloPDGawFg0qjs5nZctIuXgMjk0jyPKg
         kHBtBaHv9YoZn2gTF7zRROiylSNdnexwoE/PEzbztyAHEtg8ekfSk1LfP1FNhQkhei9+
         1T9K9dnBObisreVt/PMsUuouCpFR+BU0hu8PylvXNjYYF9fStVvYf8gJ2DnUNmvbfGuZ
         76Kg==
X-Gm-Message-State: AJIora8ChZXnxCAmKtu1f0u5N6Oa94zwDuOJj05D0i755pH3pLWdaBh/
        CBw0o2ndZAMvTqVRTNr82NXfJ54RhRs=
X-Google-Smtp-Source: AGRyM1tQeLWeg+xDGUA28c6lmAfKslWy7OeQwCiqFA+VwETfyXI6hxyyCo/pbQbUgFGCRx13Tp54qw==
X-Received: by 2002:a05:600c:190b:b0:39c:7704:74a4 with SMTP id j11-20020a05600c190b00b0039c770474a4mr9806897wmq.92.1655467994150;
        Fri, 17 Jun 2022 05:13:14 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id d8-20020adfc088000000b00213ba0cab3asm4526185wrf.44.2022.06.17.05.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 05:13:13 -0700 (PDT)
Message-ID: <fe7c52f9-5ff3-95a5-2692-20f81d6decf7@gmail.com>
Date:   Fri, 17 Jun 2022 14:13:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Ping: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Content-Language: en-US
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        libc-alpha@sourceware.org,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Zack Weinberg <zack@owlfolio.org>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        David Howells <dhowells@redhat.com>
References: <b8d6f890-e5aa-44bf-8a55-5998efa05967@www.fastmail.com>
 <YZvIlz7J6vOEY+Xu@yuki> <1618289.1637686052@warthog.procyon.org.uk>
 <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com> <YaTAffbvzxGGsVIv@yuki>
 <CAK8P3a1Rvf_+qmQ5pyDeKweVOFM_GoOKnG4HA3Ffs6LeVuoDhA@mail.gmail.com>
 <913509.1638457313@warthog.procyon.org.uk> <YbDQW6uakG3XD8jV@yuki>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <YbDQW6uakG3XD8jV@yuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Cyril,

On 12/8/21 16:33, Cyril Hrubis wrote:
> Hi!
>>> I could be persuaded otherwise with an example of a program for which
>>> changing __s64 from 'long long' to 'long' would break *binary* backward
>>> compatibility, or similarly for __u64.
>>
>> C++ could break.
> 
> Thinking of this again we can detect C++ as well so it can be safely
> enabled just for C with:
> 
> #if !defined(__KERNEL__) && !defined(__cplusplus) && __BITSPERLONG == 64
> # include <asm-generic/int-l64.h>
> #else
> # include <asm-generic/int-ll64.h>
> #endif
> 

I'm very interested in seeing this merged, as that would allow 
simplifying the man-pages by removing unnecessary kernel details such as 
u64[1].  How is the state of this patch?

Cheers,

Alex


[1]: 
<https://lore.kernel.org/linux-man/20210423230609.13519-1-alx.manpages@gmail.com/T/#u>

-- 
Alejandro Colomar
<http://www.alejandro-colomar.es/>
