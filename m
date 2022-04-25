Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D850D6BC
	for <lists+linux-arch@lfdr.de>; Mon, 25 Apr 2022 03:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiDYB5Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Apr 2022 21:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiDYB5W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Apr 2022 21:57:22 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E536140A32;
        Sun, 24 Apr 2022 18:54:15 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i3-20020a056830010300b00605468119c3so9831493otp.11;
        Sun, 24 Apr 2022 18:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=igNMWVB0BCCRkPYfikUJYnBxF9vywzLMTQ38+RboaBU=;
        b=eGKOKm7arB3Mkck5UGNAVGH1J+LW9yasn1IK/T07ZIbbSGNYF5qegU0+OrvbQAwafz
         JNdWdyLj/T74zZe5iMRtOwYZSEWqnePyVCDuwzx7ebcF4DTsq9eMSXWzpX/NjFC8u3Fa
         0sbT6fZdcWjxAPpxGoehybf1M8SXzWaxKb2YC9jzvbtM9A7yhBgF3/DFmnoeaipNXLjV
         JQhlDMB3SsWnyUdKZOYZjqoxvQ0rjUCwZu8M05px9rxWQRTstKx/CzBj/MBJhU/aXiUU
         t4ffQDIhzUmvd0nU4+vU/EayqrGotXZr/ih6L/obEZHUhcWjcK+5qy2heREUFCPnrK9a
         Us7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=igNMWVB0BCCRkPYfikUJYnBxF9vywzLMTQ38+RboaBU=;
        b=57llMSg5QAxSxn4DYrzA9PTd6lDOKUu3X3YeiOXwhQ3iys7jlmg+OMpY+OYW1oURRh
         DiU8wWmTl6KPo+0jMUkFkXvD95VGfqeF9COfVv1hfEEJqs89/1YZRJ+EhxHFIppCPR/9
         3Hnnf5HVWi9wPgUa1QW2IwOGUMz+c+krsOHzxcPxnm957QRqcEPqupXAEUAewAWzSVH+
         bQTQwEIC1AijA1Y8MX7l0rbl7SPM8Jxg3/TO20SxLzu1pFDTyw9kOtffvVblYg5yJ0ga
         dxR7P1zEb/GDK/uJdaVDTz96EtwwIyievLn6jxkdIwcwlTEfagK3o7SK/B/zXafPXTt5
         AfrA==
X-Gm-Message-State: AOAM531z+8JYT0DZLhjfjrmv87bYQx8pIpBmnXP2hathOSRcc0Sb5xG5
        XiLSJWMH5EyogJOL34YVXX4=
X-Google-Smtp-Source: ABdhPJydeC4xOzNedxnPid3fIWvDUhntKJuRxEUcVA9wj+uWTuCsq7BzKnYP+Eccbkl8lfeC8tg0/g==
X-Received: by 2002:a9d:2f29:0:b0:605:4290:ec9a with SMTP id h38-20020a9d2f29000000b006054290ec9amr5432881otb.344.1650851655199;
        Sun, 24 Apr 2022 18:54:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d3-20020a9d2903000000b005cda765f578sm3281005otb.0.2022.04.24.18.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 18:54:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8c27dfab-db37-651e-2828-78309755cb87@roeck-us.net>
Date:   Sun, 24 Apr 2022 18:54:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] random: block in /dev/urandom
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Borislav Petkov <bp@alien8.de>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Kinard <kumba@gentoo.org>,
        David Laight <David.Laight@aculab.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net> <YjoC5kQMqyC/3L5Y@zx2c4.com>
 <d5c23f68-30ba-a5eb-6bea-501736e79c88@roeck-us.net>
 <CAHmME9rmeQAD2DwG=APTmDxuVxFDH=6GXoKpgPrU9rc9oXrmxQ@mail.gmail.com>
 <20220423135631.GB3958174@roeck-us.net> <YmRrUYfsXkF3XZ5S@zx2c4.com>
 <5dfb14f4-23c6-1aa9-9ab3-bd5373ceaa64@roeck-us.net>
 <YmXncURQMUHOS0IQ@zx2c4.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YmXncURQMUHOS0IQ@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/24/22 17:12, Jason A. Donenfeld wrote:
> Hi Guenter,
> 
> On Sat, Apr 23, 2022 at 07:04:26PM -0700, Guenter Roeck wrote:
>> I'll run another test tonight.
> 
> Super, thanks. Looking forward to learning what transpires. Hopefully
> all pass this time through...
> 

Build results:
	total: 147 pass: 146 fail: 1
Failed builds:
	m68k:allmodconfig
Qemu test results:
	total: 489 pass: 489 fail: 0

The failure is inherited from mainline, so all looks good.

Guenter

