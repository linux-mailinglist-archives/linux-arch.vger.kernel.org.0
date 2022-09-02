Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0D15AADCC
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 13:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiIBLjz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 07:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbiIBLju (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 07:39:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C218D61;
        Fri,  2 Sep 2022 04:39:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n17so1960601wrm.4;
        Fri, 02 Sep 2022 04:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=BbNW3nWA9xoISgDnreRt3yDUZfE36fLGkaifLKvs7p8=;
        b=TbB4Z1VjM/ogBtCUQS5J0Nde2hFGUx1Tx5pmdt/iUX4DLsQ7UQk0kpszVCw3Wwpf1v
         9v/7yFR3H7HR7aUf13/9M2vKdVbNjPrMYqhEcS84Cq+2vgxNzUcPnsho1jRNRX0lf90s
         Fbitx8g0js2Yipnba5uKZrknZBXIouv0vDp0SjQ5W6cLTEki90dIUQPaa32nWqHhjF13
         jJTwAH2tcGEAeXDP8sxK5MoNDzarrGXbGN5cvnd+1ZpRs5XRZiNje5YchVOuZxt6t1Cg
         BDuFRAvRIw5WUrjjtwGN9J4/GAcNCjjJNOYRQIsMtUxj3I7+ypq+e0moK5JtxJSx4YUn
         mxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=BbNW3nWA9xoISgDnreRt3yDUZfE36fLGkaifLKvs7p8=;
        b=L0jqHrXACEZ60NuxRsa/sK3KgVGWlxX7i0KqdGViaR9q7OrMoxnw+tRAgTVyuUu0lw
         CjZzWhwt+Ym7kVJ6ibxZIg2VxJ0KgCPpFeUrTKCQyQ0jcfdTRGJlFeq4Tzt8m9J5Kqz5
         PWuGRUJaRFm0R5TIrii36H3Iafv5jsz65HWD8o39+zXfzVhfRRlSJrHJv8BSmoku3zjq
         cRQoK9L39YxYzzY6UjSuSXaLXDS3rrpkabU6U/WUP32rM/Qq6IaJaSuG5kJzwvJcmyQX
         0KSdQ0yW+9DN4P/CvRgfmwX6T9RWsLJiz0vz6HbcQwQVRJFfW9rFt/fzGbPQ0zZx4LRT
         iIXA==
X-Gm-Message-State: ACgBeo1VxrDVAz8NVrVTIOEnImaareyLRpGC3RRA7h2wSwoxD1lBS9DT
        OHxwBxFf1jzInmBNBDJcp94=
X-Google-Smtp-Source: AA6agR718If+mhK78grxGtOAsVSpfjTIku97uK9bbTkkxnoJ2hSLV74xT7AT4TmJ6nGzKObdg3FntQ==
X-Received: by 2002:a5d:4b8c:0:b0:226:d4a9:d1b1 with SMTP id b12-20020a5d4b8c000000b00226d4a9d1b1mr15718741wrt.674.1662118786755;
        Fri, 02 Sep 2022 04:39:46 -0700 (PDT)
Received: from fedora.fritz.box ([2001:a61:2ade:3401:dc2b:c0fc:8a52:49ef])
        by smtp.gmail.com with ESMTPSA id ba10-20020a0560001c0a00b00226fa6cf1d3sm1302973wrb.7.2022.09.02.04.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 04:39:45 -0700 (PDT)
Message-ID: <a3de0d490ab28ebab45d4e7c4d4673d1d622335e.camel@gmail.com>
Subject: Re: [PATCH v1 4/8] gpiolib: Get rid of ARCH_NR_GPIOS
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Date:   Fri, 02 Sep 2022 13:39:43 +0200
In-Reply-To: <CAHp75VfF78rWpC6+i2Hu6-PMULFeFMbqXhBVRkx5aFGFTU3U4A@mail.gmail.com>
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
         <abb46a587b76d379ad32d53817d837d8a5fea8bd.1661789204.git.christophe.leroy@csgroup.eu>
         <CAHp75VcngRihpfUkeKs-g+TbPnpOsZ+-Q37zDVoWp8p_2GbSvQ@mail.gmail.com>
         <18cda49e-84f0-a806-566a-6e77705e98b3@csgroup.eu>
         <1d548a19-feec-42b9-944d-890d6dde2fb8@www.fastmail.com>
         <CAHp75VfF78rWpC6+i2Hu6-PMULFeFMbqXhBVRkx5aFGFTU3U4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2022-09-02 at 13:52 +0300, Andy Shevchenko wrote:
> (Nuno, one point below for you)
> 
> On Wed, Aug 31, 2022 at 11:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> 
> ...
> 
> > drivers/gpio/gpio-adp5520.c:    gc->base = pdata->gpio_start; //
> > unused
> > drivers/gpio/gpio-adp5588.c:            gc->base = pdata-
> > >gpio_start; // unused
> > drivers/input/keyboard/adp5588-keys.c:  kpad->gc.base = gpio_data-
> > >gpio_start; // unused
> > drivers/input/keyboard/adp5589-keys.c:  kpad->gc.base = gpio_data-
> > >gpio_start; // unused
> 
> I believe we should convert them to -1.
> 

Well, the adp5588-keys.c was already refactored [1] to use FW
properties so that -1 will be used. In the process, gpio-adp5588.c
was dropped.

For the adp5589-keys.c driver, we might also need to do a similar
work as I suspect there's no platform making use of pdata. Hence,
yes, I believe -1 is the way to go.

Ditto for gpio-adp5520.c...

[1]:
https://lore.kernel.org/linux-input/Yw7hRIbsTqOWVeyJ@google.com/T/#m382bec5c587241010d453ce1000bea2d34b86380

- Nuno Sá
> 
