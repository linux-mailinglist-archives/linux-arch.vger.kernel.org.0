Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D9F57D4EA
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jul 2022 22:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiGUUlZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jul 2022 16:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUUlY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jul 2022 16:41:24 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1781C8F50B;
        Thu, 21 Jul 2022 13:41:23 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 6so4778280ybc.8;
        Thu, 21 Jul 2022 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NN9gIWbssHpQMwgTaofM6Dhn1ydMG7fE42r2fJou3QU=;
        b=EAs5lIdZwfgvMiiFrXAjbIxg4I2+0eHCF172BcCmhd+2wIfUIdxpOx5C+XXGKs/zHH
         SiB+t541qdsMkXlT9JsL9L8ljsZpDqMqnQ/Pk5A6BJBrpUNbDVCu9fRXO+upQ1zzSejp
         smii47hkVd5pf6kpQkjiXRKF0X8UHXHSp+cyH5gNP19ZtP1ovJJEiSIhPEXRIlTIrir7
         S5Z2pHNk7fTYYfkAa4Nu7yZ6rBF2V37UHi60rNcti/KgXL1yMLrLY3ed62PRgR8b1e9M
         WQXpWqt/819bYUEj724B+DjoYBqYVuNcf/Ebl2/owpJX1aVZ1A7EGH+wPNf1pADNSZvH
         SsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NN9gIWbssHpQMwgTaofM6Dhn1ydMG7fE42r2fJou3QU=;
        b=lv3cQ8JjwoZw0B2wuvvZWUDxPNtX5bRT/hvuxhSlvjJWjoBz9aH+NqEp41oEFy6fuK
         mmlIk0U1fWd4NSp6g6+t1FNWi5jDlxw0W9nbD7ot0b+wSX18/ID02CS/LUlQHmh/gXrY
         49hVpNuR9w7Y65tp+qGzl1064ABIeshSKoJMAxCHDhGonT9EmHXskAm+O0EqPBWCDc2n
         6cCEIVHXNeE6BPx//JpDrBQTsqd9+GtCsE3nMNJuKdgxiYeicTUiFvYXwPwIqXLwkA03
         fYb/SOs5RwOdRmKscg+xXLSt9FS7N4hgIuw2qG+vl40BdBZFkxY/FETIF/JXrHhQK7ZR
         dLPw==
X-Gm-Message-State: AJIora/0KXF/ezb8Ql2kx2dLep5KwHKYvuL/AIe4gAbLdCgwbklwj4pw
        w20h5nVF9faQJg9alituLFVB5QgpvmaOZx+Wh9V6T/5v+oU=
X-Google-Smtp-Source: AGRyM1vB0OZ8Yyp2ugdum3iPSv+Y6eUzrmcnReWfrk5hjSgVACxC+ScBe4IoRqDCowQp3s9Lcrsdv1GsDvbQ6kxw6rk=
X-Received: by 2002:a25:850b:0:b0:66c:d287:625a with SMTP id
 w11-20020a25850b000000b0066cd287625amr347706ybk.31.1658436082171; Thu, 21 Jul
 2022 13:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a12-atmqjtjqi-RhFXH2Kwa-hxYcxy3Ftz2YjY5yyPHqg@mail.gmail.com>
 <mhng-f5938c9b-7fc1-4b0c-9449-7dd1431f5446@palmerdabbelt-glaptop>
 <CAKXUXMzpWsdKYbcu5MxvrAEMLHv4_2OGv2bRYEsQaze5trUSiQ@mail.gmail.com>
 <CAK8P3a32m42gT9qz+Ldvr8okYGOc=kKeoJTGNWyYT71N8tJfEA@mail.gmail.com>
 <4ff47e50-8702-1177-612b-73d9700e47c5@microchip.com> <CAK8P3a01x_ETchX2Vwm9oNaFJDhVZEu+G-2vRwegqKkMe54m6g@mail.gmail.com>
 <CAKXUXMxOUs31SkGb0JD=nmHxgFy4tQ5vn6yD6ivgRpbSAxm7mA@mail.gmail.com>
 <CAK8P3a3K8PnPF7KEEVb=hquZsjXiatCkyXe9B_RLBcse2jU5LQ@mail.gmail.com> <CAKXUXMyEG1Sc18NuhONWHuQWvTfFHNPrn4wJf=v9jMSpLGfP+Q@mail.gmail.com>
In-Reply-To: <CAKXUXMyEG1Sc18NuhONWHuQWvTfFHNPrn4wJf=v9jMSpLGfP+Q@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 21 Jul 2022 22:41:12 +0200
Message-ID: <CAKXUXMyfobnA92JAXY56djEP9bUiA2t2aOUEGyDTOACu1NRVuA@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Conor Dooley <Conor.Dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 21, 2022 at 8:52 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Wed, Jul 20, 2022 at 12:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Jul 7, 2022 at 4:41 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > > On Thu, Jul 7, 2022 at 3:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Thu, Jul 7, 2022 at 2:20 PM <Conor.Dooley@microchip.com> wrote:
> >
> > > > lkft just found a build failure:
> > > >
> > > > https://gitlab.com/Linaro/lkft/users/arnd.bergmann/asm-generic/-/jobs/2691154818
> > > >
> > > > I have not investigated what went wrong, but it does look like an actual
> > > > regression, so I'll wait for Lukas to follow up with a new version of the patch.
> > >
> > > Thanks for your testing. I will look into it. Probably it is due to
> > > some more rigor during builds (-Werror and new warning types in the
> > > default build) since I proposed the patch in October 2021. That should
> > > be easy to fix, but let us see. I will send a PATCH v2 soon.
> >
> > Any update on this? I have another bugfix for asm-generic now and was planning
> > to send a pull request with both. If you don't have the updated patch
> > ready yet, this
> > will have to go into 5.21 instead.
> >
>
> It is still on my TODO list for revisiting, but I had other work on
> patches taking me longer than originally expected. I now moved this
> patch revisiting to the top of my TODO list; so, I will certainly look
> into this today. So far, I have not set up an arm64 build on my local
> machine and have not used tuxbuild (which should simplify all this
> setup)---the typical challenges for a "part-time kernel
> contributor/janitor"...
>
> Arnd, I will certainly let you know by this evening (European time
> zone) how far I got. If that is already too late, it is also perfectly
> fine if this goes in 5.21 instead, but I will try my best to make it
> 5.20 material.
>

Arnd, I can reproduce the error from your build system.

I think I have an idea what the correct patch would actually be:

- either make the function declaration completely unconditional,
- or put the function declaration under #ifdef and not #ifndef.

I guess the first should actually lead to some compiler warning (at
W=2 or so) having a function declared multiple times, for some
architectures. And hence, the second option is a better one. This is
all educated guessing so far, so to confirm, I need to build the
kernel with W=2 on the defconfig all architectures before and after
patch application and see if I am right. This is going to take some
build time on my local (home) machine. So, I hope that I can spend
some time tomorrow on just kicking off builds and looking at diffs and
then send out a working patch v2.

Lukas
