Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65395BE723
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 15:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiITNdK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Sep 2022 09:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiITNdJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 09:33:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD007578A0;
        Tue, 20 Sep 2022 06:33:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w10so1503795pll.11;
        Tue, 20 Sep 2022 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=USvrs3UqdxmJVsfGHVufPx+zKN2HZu7qWUWjtAqweNc=;
        b=G/Xk3OOgV88Bxn3Ll3F+ZN7VzG73hcONtPoz8GIZb1IrSfcY78S7cjzlsZTPMjVVOt
         QObn1jeJtb4tBGlbstQ/iT/7FCHQu829ozHl5hOAA1eqmyeCNg5ka/vam8YgLiac9e6v
         fqvJpFAJgVvws2vCM+U8jIwBu99jURFq2evlkgnTTzMjOnnc9IBevT+OhOBNW7QXqhG0
         w/jq6suWMjEIQEnYNHlOcyHbifrnr9DPHFCNjttJvET13Qpu7QW5BCeO+0VfoRPIen1+
         8ZiZSt5a8p4d6KIRvtS7u3VE1W4jbEWqiZajmX4VGzUJ7ZTMWu1ht4Fafjz3krJ99xTR
         /SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=USvrs3UqdxmJVsfGHVufPx+zKN2HZu7qWUWjtAqweNc=;
        b=4mIyfc6LdnG1x2eMAXv++ddb1bQpCxRy75iOxdBbqhvXXfIngz0FFHeLPCj2oaXrkv
         o/92K+2CL7QTyG1Z4gwom1p9gHrzkfcjCeOltAgmXGQzQwwoiJdOC7w2PZ3Ij+k4jwHf
         l6togxGln8NlvWHvVCo7XdZI/Awvdj0XC6rMTs1arqwGnN/9a6tMhrC4AuOnb7rSxID5
         F5htvq1uotyN7jZoIx63GzSIl7NU4BM3UcpXUYi1Uw9ZAlkfeRdKb7i0D7u1qpFfC2yy
         EaVMrmeSK0C+Ha1k0vW4E5wLyOMDswpD4hjDVO2JXSoFbcJz6cls0FCQ+EPVRWzdH3HI
         tkdw==
X-Gm-Message-State: ACrzQf0ONxJXRk7gFV4av+XkMxbWEz0tCLtOh+UDhkMjF9b3Utt9FU9N
        sPpQk0r+VlmpNUNLfDDDiyQ=
X-Google-Smtp-Source: AMsMyM6ESnDu9n1wSpa24KqgwDm7YUPn8gK6IepDB9S9HLM3RI3NEL8k4QjdDgDYxvO2JN86bbIIkA==
X-Received: by 2002:a17:903:32cc:b0:178:41c1:2e41 with SMTP id i12-20020a17090332cc00b0017841c12e41mr4831315plr.126.1663680786829;
        Tue, 20 Sep 2022 06:33:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fu1-20020a17090ad18100b002000d577cc3sm1412719pjb.55.2022.09.20.06.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:33:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <af58a33c-2637-e761-ddc0-13159adf7c4e@roeck-us.net>
Date:   Tue, 20 Sep 2022 06:33:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 7/8] kbuild: use obj-y instead extra-y for objects
 placed at the head
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20220906061313.1445810-1-masahiroy@kernel.org>
 <20220906061313.1445810-8-masahiroy@kernel.org>
 <20220919225053.GA769506@roeck-us.net>
 <CAMuHMdUxrXgJ7HHgk1vSyg6_S8TN3RvEW=QNgH9U0UueM41N-Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAMuHMdUxrXgJ7HHgk1vSyg6_S8TN3RvEW=QNgH9U0UueM41N-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/19/22 23:56, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Tue, Sep 20, 2022 at 12:59 AM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Tue, Sep 06, 2022 at 03:13:12PM +0900, Masahiro Yamada wrote:
>>> The objects placed at the head of vmlinux need special treatments:
>>>
>>>   - arch/$(SRCARCH)/Makefile adds them to head-y in order to place
>>>     them before other archives in the linker command line.
>>>
>>>   - arch/$(SRCARCH)/kernel/Makefile adds them to extra-y instead of
>>>     obj-y to avoid them going into built-in.a.
>>>
>>> This commit gets rid of the latter.
>>>
>>> Create vmlinux.a to collect all the objects that are unconditionally
>>> linked to vmlinux. The objects listed in head-y are moved to the head
>>> of vmlinux.a by using 'ar m'.
>>>
>>> With this, arch/$(SRCARCH)/kernel/Makefile can consistently use obj-y
>>> for builtin objects.
>>>
>>> There is no *.o that is directly linked to vmlinux. Drop unneeded code
>>> in scripts/clang-tools/gen_compile_commands.py.
>>>
>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Where does this R-b come from? It was not present in Yamada-san's
> posting. Added by b4?
> 

Maybe added by patchwork ? That is where I picked up the mbox.

Guenter

>> The following build failure is seen when building m68k:defconfig in
>> next-20220919.
> 
> [...]
> 
>> # first bad commit: [6676e2cdd7c339dc40331faccbaac1112d2c1d78] kbuild: use obj-y instead extra-y for objects placed at the head
> 
> I did provide my R-b on Yamada-san's fix for this issue, which was
> sent later in this thread.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds

