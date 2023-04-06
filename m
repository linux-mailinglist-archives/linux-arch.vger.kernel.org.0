Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9325D6D9E20
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 19:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbjDFRFG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 13:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjDFRFG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 13:05:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646F48688
        for <linux-arch@vger.kernel.org>; Thu,  6 Apr 2023 10:05:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g18so2997560ejj.5
        for <linux-arch@vger.kernel.org>; Thu, 06 Apr 2023 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680800703; x=1683392703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+/M2omUP0H0I3+C442gwyIY7zx7Kzi7zGFIhChXSsk=;
        b=LsYWYUn/bUzcFairJl4RxVpnt4tZrFJtg2/saPdsjse1TtzDH0Z/UgBqyrweA/Y+xI
         XMxjK261SuwjMgkK4lQvz+5uK8VrIWqktK8Y77rAu/PB7dCTIR9elWNQYGK/7fpb0bjb
         uVFSGzwQqtQvccqzswF7R83Lk5CddU3sfjZt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680800703; x=1683392703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+/M2omUP0H0I3+C442gwyIY7zx7Kzi7zGFIhChXSsk=;
        b=a17dCy5J+MTOeDpayyD4n2PEZUKMHgDRnR7IFauy+UhhNfvaQ1My/f6LAJnQxMvUlh
         jdDTCsvrpZIsTs/yB5KtysM9eWbfNL0QA87dI/+UD/Ny9nQDzg6kdypiJ9Ry/G609qY4
         xx04+JGJc3z8Aj4T/7f3IAj37jilkR9lvSqFkpFBacdJ3qtaURGNpuun9aQxFwsTpHwI
         Qj3qlVDB7CX5IdbYa9TgDsJIe+tUMOBoOBkfnwR/RLzT62LzgdO8gcY7Y770wkgF532E
         WkZarhNE8QjqW0QXD8PoNX6L6R4XeTEA/eZYRG6tHMLVav741/JAm0oCtR8mHtRH5LDM
         bfCA==
X-Gm-Message-State: AAQBX9dSYzK8I2qTBznA3ryjQzU+zAOKNbbnXaDhekZEQMX8B1dn85lr
        HFzu6zfC0xU0mZ9GgOltyL85qzdTyR0aN8F12JLUuA==
X-Google-Smtp-Source: AKy350YmROoXwPeDCnmrvnA2tBqZJ84U+j7MMeuDt0xS9Cpc3OkyH+9zmMCMvG6XbbjWOyI3zYhddg==
X-Received: by 2002:a17:907:a49:b0:949:cb6a:b6ed with SMTP id be9-20020a1709070a4900b00949cb6ab6edmr2663274ejc.32.1680800702575;
        Thu, 06 Apr 2023 10:05:02 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id gg20-20020a170906e29400b008f767c69421sm1054220ejb.44.2023.04.06.10.05.01
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:05:01 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id sg7so2998401ejc.9
        for <linux-arch@vger.kernel.org>; Thu, 06 Apr 2023 10:05:01 -0700 (PDT)
X-Received: by 2002:a17:906:3393:b0:933:7658:8b44 with SMTP id
 v19-20020a170906339300b0093376588b44mr3515396eja.15.1680800701412; Thu, 06
 Apr 2023 10:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <f44680f5-df08-4034-9ed7-6d43ee4c4c2a@app.fastmail.com>
In-Reply-To: <f44680f5-df08-4034-9ed7-6d43ee4c4c2a@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Apr 2023 10:04:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyY_FKpWk1LAHirjmWbABc78C+mgVhqaYHZts0fbkYJQ@mail.gmail.com>
Message-ID: <CAHk-=wgyY_FKpWk1LAHirjmWbABc78C+mgVhqaYHZts0fbkYJQ@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic fixes for 6.3
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Matt Evans <mev@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 6, 2023 at 1:13=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Some of the less common I/O accessors are missing __force casts and
> cause sparse warnings for their implied byteswap, and a recent change
> to __generic_cmpxchg_local() causes a warning about constant integer
> truncation.

Ugh. I'm not super-happy about those casts, and maybe sparse should be
less chatty about these things. It shouldn't be impossible to have
sparse not warn about losing bits in casts in code that is statically
dead.

But we seem to have lost our sparse maintainer, so I've pulled this.

I also wish we had a size-specific version of "_Generic()" instead of
having to play games with "switch (sizeof(..))" like we traditionally
do.

But things like xchg() and user accesses really just care about the
size of the object, and there is no size-specific "_Generic()" thing,
and I can't think of any cute trick either.

               Linus
