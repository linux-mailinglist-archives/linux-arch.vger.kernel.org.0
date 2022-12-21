Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605406534F9
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 18:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiLURU7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 12:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbiLURUb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 12:20:31 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7732B4B;
        Wed, 21 Dec 2022 09:19:25 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id k7-20020a056830168700b0067832816190so4575513otr.1;
        Wed, 21 Dec 2022 09:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I3f0UiW+/YoUBXR0TYEPPrtQ962Pvq8PyjcKApLuolY=;
        b=S4JDz4fwJKnV0j2t+m3muAgfmV/i9v941+5H/WJccBUYbdnIgsgPX1hsplf1lkWywn
         LPmwsR7CREX8GM2K+FgIWNqn2RPJeUWoRfvoUZA9KgsCHYUb2OHx47O/Yr/+zO3V8fvW
         e9+is3kGg7xnW5j56R/KzPqFMy7sqXpaAgbT+KFGkNVA9xzWWZUWE5nnXvl2vrZ0OcuE
         qhfq5HGatwlHJs/MMATO0vpWXoHI0A7mmg0mB+DcJ1I87EbHZu3srhnDjNFExkEYVzGJ
         BxxYjI5nbfyBLmrnJo204A7t446z1aPtQd2Bt5gQakxLLM0B2bcpMZkFe6OUwvvP4uqI
         vi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3f0UiW+/YoUBXR0TYEPPrtQ962Pvq8PyjcKApLuolY=;
        b=LRJ38qPI4peWMAKanj8fLowA/Csbmk7wAQSw+STV0XckZim0TAV3OJWqy9ocKfDIfh
         AZ0VhHAyIuuoHiJbkbi7Z5jkeESubp8paxCipiopl2xy2Xhr1rX0BnWFvsbFSLHMd4HR
         8PsoEmm5a4GvOJedV21ubJ2ojaHSiKcdU0AByU/L1xPteSWdB24LAdm/1G/zQk7I5iJj
         93vnFMuDzL8W3hGp6W0JLvHf1o88zDrYA7PygaG2LGRqmvWEa/ejtBsdm7U4HBax2vbF
         G7NzFrOPOzvHsHZB9WAKmsukEWGvd/jnbjLEF4BLdMeX6t63uqzofkjjPr2eoQmMv6G8
         EhsA==
X-Gm-Message-State: AFqh2koE00JRPy/cD55nXLMrd1OsXYhWztot6Uhs82TpC1N8C+/BjUKP
        /ph0Us/jzJxehoeQD4tXGic=
X-Google-Smtp-Source: AMrXdXv3pz+hJczk8WjDAV1ETvQ0uIZOdEC7sf8fk6L8WyKCM6qdlf4HmLrabf51xN28VtW9sKIJww==
X-Received: by 2002:a9d:6a11:0:b0:670:8270:1290 with SMTP id g17-20020a9d6a11000000b0067082701290mr1201996otn.38.1671643165022;
        Wed, 21 Dec 2022 09:19:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v17-20020a0568301bd100b0067c87f23476sm1074448ota.57.2022.12.21.09.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 09:19:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Dec 2022 09:19:22 -0800
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
Message-ID: <20221221171922.GA2470607@roeck-us.net>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net>
 <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
 <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk>
 <20221221155641.GB2468105@roeck-us.net>
 <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
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

On Wed, Dec 21, 2022 at 09:06:41AM -0800, Linus Torvalds wrote:
> On Wed, Dec 21, 2022 at 7:56 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > The above assumes an unsigned char as input to strcmp(). I consider that
> > a hypothetical problem because "comparing" strings with upper bits
> > set doesn't really make sense in practice (How does one compare Günter
> > against Gunter ? And how about Gǖnter ?). On the other side, the problem
> > observed here is real and immediate.
> 
> POSIX does actually specify "Günter" vs "Gunter".
> 
> The way strcmp is supposed to work is to return the sign of the
> difference between the byte values ("unsigned char").
> 
> But that sign has to be computed in 'int', not in 'signed char'.
> 
> So yes, the m68k implementation is broken regardless, but with a
> signed char it just happened to work for the US-ASCII case that the
> crypto case tested.
> 

I understand. I just prefer a known limited breakage to completely
broken code.

> I think the real fix is to just remove that broken implementation
> entirely, and rely on the generic one.

Perfectly fine with me.

Thanks,
Guenter
