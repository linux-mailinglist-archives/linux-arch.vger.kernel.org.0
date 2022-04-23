Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EF150CC55
	for <lists+linux-arch@lfdr.de>; Sat, 23 Apr 2022 18:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbiDWQie (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 23 Apr 2022 12:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiDWQie (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 23 Apr 2022 12:38:34 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03D1B76;
        Sat, 23 Apr 2022 09:35:36 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id q129so12443271oif.4;
        Sat, 23 Apr 2022 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ovHkGKEvlIZwtQ9aFgXnHkHqXOrvd8sanG2BE5UeV4=;
        b=CE/MNPBnre0f1a6TKBwmofViVrKgJ05IptkoHG1SdPEtiyLXvKTXsLuufocRXtSDng
         d5JDRBbSvHcatQBIXa+ToEZ/CMq9zT1djryIQ5zcdnOnSe+yXhXEZlvTs5rpDKoElDv3
         9TzUJIsoXr8AtXlK7UwMYZ/CbkWlOlVcvSxY75jobolML9RVUS8/jaz4/AMyaeT76p2I
         DZ1b+YsCWiiLUTXfF+xMgDWSoNsdbRrSiLveQScgNblUdZ+1HoyVR55+vS5Fe33LKauy
         1vrB6j57yhXhHlPLGOwAfRabCTuiY6DgbIZZejJ200pt5FAVUxCzHxW56KLFn4GIwD+7
         PkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+ovHkGKEvlIZwtQ9aFgXnHkHqXOrvd8sanG2BE5UeV4=;
        b=56nRSa57T9xvAY6Mgfqj7CyC0dYxV2JXPuDwDmFzuGDzwemBL6VYBRXgp32bWSxpjl
         5SXfIU+SRO910nF+tI+mCX5O2qeuRB5uOJpNm+wPPHHRRtoOVJl/+R6QBC+Ht3nvW3Q3
         6NNr3E0OLxsKNSxT+HFd9q8ZfC74oXK7dSA2XaUpDyrzdqLHSdiMSlo0CNk9ZN60y/AL
         1/AO6/zu9vX0F1s0Bi4onuCSgBnfJ4baCt9dU2tgImad4TnnfDVSgZ4gQVqBDpuZbE+M
         ZmXJTLHsdUsUAKxSjMdyCedWJLuozUAIS9ZbaJib5hxe+uAivYGD1ADhWT3iHEg7w8mt
         6WCQ==
X-Gm-Message-State: AOAM530SJuQrmiZrkX6F+nXUI6DVH7zZ5BiWHI+dbJhjI9bNzqrsdeoB
        xPXkHoy9xSYiBy99/N4r9rQ=
X-Google-Smtp-Source: ABdhPJzUhgOA/L7vBlij2I/59HEEJY7wUxIWCqzShnoqp2lck8+Dlp3S/SGRjv16vWtHRMXQnI72kA==
X-Received: by 2002:aca:de84:0:b0:2f9:c97c:421c with SMTP id v126-20020acade84000000b002f9c97c421cmr4636599oig.46.1650731736174;
        Sat, 23 Apr 2022 09:35:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x12-20020a4aea0c000000b0035195c4662fsm2163837ood.9.2022.04.23.09.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 09:35:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Apr 2022 09:35:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
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
Subject: Re: [PATCH v1] random: block in /dev/urandom
Message-ID: <20220423163533.GB3964519@roeck-us.net>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net>
 <YjoC5kQMqyC/3L5Y@zx2c4.com>
 <d5c23f68-30ba-a5eb-6bea-501736e79c88@roeck-us.net>
 <CAHmME9rmeQAD2DwG=APTmDxuVxFDH=6GXoKpgPrU9rc9oXrmxQ@mail.gmail.com>
 <20220423135631.GB3958174@roeck-us.net>
 <YmQNK2uicWbklo7U@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmQNK2uicWbklo7U@zx2c4.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 23, 2022 at 04:28:59PM +0200, Jason A. Donenfeld wrote:
> Hi Guenter,
> 
> On Sat, Apr 23, 2022 at 06:56:31AM -0700, Guenter Roeck wrote:
> > Looks like your code is already in -next; I see the same failures in
> > your tree and there.
> 
> It's not in next, actually. The branch I made for you has that
> additional testing commit.
> 

Hmm, then I can't really test it because the other 16 patches
in your branch (which are in -next) already cause a number
of failures.

Guenter
