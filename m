Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2976E60D853
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 02:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiJZAKI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Oct 2022 20:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiJZAKH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2022 20:10:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF864A2205
        for <linux-arch@vger.kernel.org>; Tue, 25 Oct 2022 17:10:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b12so38983926edd.6
        for <linux-arch@vger.kernel.org>; Tue, 25 Oct 2022 17:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4taiE5ssQYH2zlfw716I5D+61K8WmNsXSyJ4aqN82N8=;
        b=icD7feogwbnZHXxEHSUlJiUdinyKhya/zRuuqtoVUhyaraQ0seuTNAk/XrxuwJ0hxQ
         +RHi4wpnmQXkdR81PLGgT49IxOWoALW+IFaAfe8ECx3bjTYBHnBCZBluni8j1cgygBJG
         xgmIG0ZBIm2nZn5xaAhnqeRvJwkGoND+Q7SEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4taiE5ssQYH2zlfw716I5D+61K8WmNsXSyJ4aqN82N8=;
        b=28+f9ld/hzsFJXf70jCsDNlKJGoTDauVGm8yFbZMUlir+biCOh/Bzny5dl13SlgNyD
         Eg01umszMbTWebyK2AiVujJbC/0FFjnrJF8lyQt+4ojjpEFQLnpjP+HhnZt7eUD6psFW
         LpbAnXaTuWFpBg565V08KHhhYaxq9zoOYO3D79uDgUhyoXVZYum4bxT3bfgkXyS8pqs+
         +85dVw4JD1t3ECh4kMtjHzjaLe1cc2S/Qq+OG53Niqa5yFv9sB2Tm8vcYeF5BA6nx2TW
         6uakgIwLivCG+JkY2R/iUU8XfLIIZGUyQSRGXEgwzJDtr8j50MFpZUc7xUHmZL5YpR/7
         HjYw==
X-Gm-Message-State: ACrzQf3NGIBTA0RDmmx+wQIdbabEQjxnv3fQMd8SvO81gAhxUaIan6QT
        SlYMCNh2CmpV7hUQQRq7cPdobQgcQYdn88vbLss=
X-Google-Smtp-Source: AMsMyM7YfH3zjdroxgQqniV4fSiNgFe9/PT7uYZeGKrCNU79xQR9xfgcxWPG1xDwPXa1oHQRbz8xag==
X-Received: by 2002:a05:6402:5288:b0:457:22e5:8022 with SMTP id en8-20020a056402528800b0045722e58022mr37785972edb.244.1666743004203;
        Tue, 25 Oct 2022 17:10:04 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id a7-20020a17090640c700b0073d7bef38e3sm2104978ejk.45.2022.10.25.17.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 17:10:03 -0700 (PDT)
Message-ID: <3a2fa7c1-2e31-0479-761f-9c189f8ed8c3@rasmusvillemoes.dk>
Date:   Wed, 26 Oct 2022 02:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: make ctype ascii only? (was [PATCH] kbuild: treat char as always
 signed)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221019162648.3557490-1-Jason@zx2c4.com>
 <CAHk-=whT+xyge9UjH+r6dt0FG-eUdrzu5hDMce_vC+n8uLam2A@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAHk-=whT+xyge9UjH+r6dt0FG-eUdrzu5hDMce_vC+n8uLam2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 19/10/2022 21.54, Linus Torvalds wrote:
> On Wed, Oct 19, 2022 at 9:27 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>
>> So let's just eliminate this particular variety of heisensigned bugs
>> entirely. Set `-fsigned-char` globally, so that gcc makes the type
>> signed on all architectures.
> 
> Btw, I do wonder if we might actually be better off doing this - but
> doing it the other way around.

Only very tangentially related (because it has to do with chars...): Can
we switch our ctype to be ASCII only, just as it was back in the good'ol
mid 90s [i.e. before
https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/commit/lib/ctype.c?id=036b97b05489161be06e63be77c5fad9247d23ff].

It bugs me that it's almost-but-not-quite-latin1, that toupper() isn't
idempotent, and that one can hit an isalpha() with toupper() and get
something that isn't isalpha().

Rasmus
