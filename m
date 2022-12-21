Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924396537E8
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 22:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiLUVB2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 16:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUVB1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 16:01:27 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B07C559A;
        Wed, 21 Dec 2022 13:01:26 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id x25-20020a056830115900b00670932eff32so9805565otq.3;
        Wed, 21 Dec 2022 13:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QEevAywUdrUeO4DWab5onKZKSHXptskyHvOtVcPoLM=;
        b=aujnWgEizYKCjbfJS0vkqFfjSW1AomSGTvnT0QfxNA3xAl1/UE0c6EioKatVhjL6J3
         42OzhiUi6zyvBL7wY3XTyuEq8alVjy5Lntt1sxA64oKRg+psSJwJxWURMsR2zFRMehnS
         p5bSzhLrtQ6JG43iBzwS98Mn7NFVW9/G7uJyU4sWEPCF1v/u9+iojd9sB3rKRquZu9dd
         Ddb2Xpo7Z6m/b/wYn6AHug4zbPUBx6OwV6BX8I2OVPFnWmoUnCmCHY1K4ttgP9wan1nS
         hv5WuDgd04N+rrWjHbEcxpLVcM+VhGI+H9nxfeprB2iBUujj2Qm5KR9lju9SISF0W0DU
         +bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QEevAywUdrUeO4DWab5onKZKSHXptskyHvOtVcPoLM=;
        b=I8tPCmspeAzDZR/DXUcQbU7vykoAo1Pqitjbp/esAhm0AcGG3Qe7BEZbv2U5NnTdvO
         lxkxgrLDTlC7lYiW+BbredvWTsNfSB1eForf5ZL66NcgoeUAf2Cp1Isr3gvIBmCjTjh2
         wSSPIGbmXQPIaeZclzCMtsKVC4aiJCldz/ALFG8nKVjMB7aHCgu/r729k44sKJHlPAnv
         pan+A8lfJ2wVP6VCAenS/ayHDaQiEGEGmWa9yrsX+g7LGuOIWqPpHBWWfGiKkxaufnVP
         ZyoRuCw+5sPFa8m7CuizFEM406fAiNHGkR1FDSgJTaMLYYZcHljdrE6k74iTSRxsXZsQ
         O5hg==
X-Gm-Message-State: AFqh2koRVmeUMXZkvBWjl4Qr8XqujVQ2F2BEfjgf++/IJxreKpeWFIId
        xJmbyx3j1vyyNbNkRD3eUxw=
X-Google-Smtp-Source: AMrXdXt2CGoZmAJkjBkN7Wfr4zFgq9qbfTqFafWIOysIuYF2lmo5XwNR3nI5m/jLSsV4WocFLzdtOA==
X-Received: by 2002:a9d:198a:0:b0:67e:f252:fc9d with SMTP id k10-20020a9d198a000000b0067ef252fc9dmr485763otk.26.1671656485619;
        Wed, 21 Dec 2022 13:01:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r44-20020a05683044ac00b0066e7e4b2f76sm7344017otv.17.2022.12.21.13.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 13:01:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Dec 2022 13:01:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
Message-ID: <20221221210123.GA2717809@roeck-us.net>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net>
 <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
 <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk>
 <20221221155641.GB2468105@roeck-us.net>
 <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
 <20221221171922.GA2470607@roeck-us.net>
 <CAHk-=wjOcqWxpUUrWKLKznRg-HXxRn1AXLW9B6SPq-ioLObdjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjOcqWxpUUrWKLKznRg-HXxRn1AXLW9B6SPq-ioLObdjw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 21, 2022 at 10:46:08AM -0800, Linus Torvalds wrote:
> On Wed, Dec 21, 2022 at 9:19 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Wed, Dec 21, 2022 at 09:06:41AM -0800, Linus Torvalds wrote:
> > >
> > > I think the real fix is to just remove that broken implementation
> > > entirely, and rely on the generic one.
> >
> > Perfectly fine with me.
> 
> That got pushed out as commit 7c0846125358 ("m68k: remove broken
> strcmp implementation") but it's obviously entirely untested. I don't
> do m68k cross-compiles, much less boot tests.
> 
> Just FYI for everybody - I may have screwed something up for some very
> non-obvious reason.
> 
No worries:

Build reference: msi-fixes-6.2-1-2644-g0a924817d2ed

Building mcf5208evb:m5208:m5208evb_defconfig:initrd ... running ..... passed
Building q800:m68040:mac_defconfig:initrd ... running ..... passed
Building q800:m68040:mac_defconfig:rootfs ... running ..... passed

Guenter
