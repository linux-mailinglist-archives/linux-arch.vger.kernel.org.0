Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DC757C4B7
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jul 2022 08:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiGUGwa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jul 2022 02:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiGUGwa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jul 2022 02:52:30 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A69645986;
        Wed, 20 Jul 2022 23:52:29 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2ef5380669cso7485717b3.9;
        Wed, 20 Jul 2022 23:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jgg9rGf43HqONHkXh2HTUDVIWowHE0j+MEj4elq8HBU=;
        b=YhYtUggpWoK5/IgnxwPRU86N/OA28sUtY1zsyxQnrWzTtUvthi1I+SuuIcKBxnTpWF
         7l4/WtdGjmEyQaVJi/lAQ35ISoAKX6USn6QaKtIqjfHUrVCjhOcf/8K0xgUtocKqOJzw
         R/0NeOjUXy0FF0l9gcIGXTWMZ6Cr8emocvdJfZp74A2yeNawFgKWAvD4Vt1dqemCnnX2
         ZzwpOGbMAfOhcZpEGJC8r6RLB5lacXSRUpX2RifCMqBp1AJFIdvp694/77bHzr++vp7j
         WV0Y1psdPbceOFSg7jYe4af16RoFkxb7InoQa3ga3WNjznruhPypz4+9QwtdKDwwGlW0
         4TVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jgg9rGf43HqONHkXh2HTUDVIWowHE0j+MEj4elq8HBU=;
        b=fiyqMNehT5fTo6qNWDTGPerZnXCwlVNG85tRteMYt1k+nmloibxgfkpaYeocl5CXVk
         BNQD8iZlR7F4bu6GrzjhtAR0mzaTNZ2l4F738CloEXNsQp+Ci8JctcM5wexusN/2BzU4
         B9V0gVAvpTP7InKqoOxo+qTYjyD7SkR9PX83EOSt5a2d2PHD071LJYELIBmnUaj7nsgy
         N1CKueVa16YtuHX0n/rUbm+HYjYaML1R5rXBa2+g7GoGmg47hExlHCZIALxXIh3W9DMU
         UEJAdh0rXha5Qhu3GqDB0lrvTzIA/Qk+LhdIn1jT9oiBNjpGKi95+qShWdNpZWMeRxF+
         92gQ==
X-Gm-Message-State: AJIora8cNTg1hGNk1n8FjhrfYfIdf+PWpvaawOTiiRsVbKHXaQ77bQkV
        D841bCnv0HDRDY2MvounODib+JDvamxBo87IRis=
X-Google-Smtp-Source: AGRyM1voSX2Y3Y6IgHU5wEb0mgCtOm2aFWUUnYKRxA/BGm1rsVVoyVkGm3nRRMlIxXh8fssuiL8DLA2yON/devKvcIA=
X-Received: by 2002:a81:1905:0:b0:31e:6a62:ebe6 with SMTP id
 5-20020a811905000000b0031e6a62ebe6mr6905604ywz.237.1658386348221; Wed, 20 Jul
 2022 23:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a12-atmqjtjqi-RhFXH2Kwa-hxYcxy3Ftz2YjY5yyPHqg@mail.gmail.com>
 <mhng-f5938c9b-7fc1-4b0c-9449-7dd1431f5446@palmerdabbelt-glaptop>
 <CAKXUXMzpWsdKYbcu5MxvrAEMLHv4_2OGv2bRYEsQaze5trUSiQ@mail.gmail.com>
 <CAK8P3a32m42gT9qz+Ldvr8okYGOc=kKeoJTGNWyYT71N8tJfEA@mail.gmail.com>
 <4ff47e50-8702-1177-612b-73d9700e47c5@microchip.com> <CAK8P3a01x_ETchX2Vwm9oNaFJDhVZEu+G-2vRwegqKkMe54m6g@mail.gmail.com>
 <CAKXUXMxOUs31SkGb0JD=nmHxgFy4tQ5vn6yD6ivgRpbSAxm7mA@mail.gmail.com> <CAK8P3a3K8PnPF7KEEVb=hquZsjXiatCkyXe9B_RLBcse2jU5LQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3K8PnPF7KEEVb=hquZsjXiatCkyXe9B_RLBcse2jU5LQ@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 21 Jul 2022 08:52:17 +0200
Message-ID: <CAKXUXMyEG1Sc18NuhONWHuQWvTfFHNPrn4wJf=v9jMSpLGfP+Q@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Conor Dooley <Conor.Dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
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

On Wed, Jul 20, 2022 at 12:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 7, 2022 at 4:41 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > On Thu, Jul 7, 2022 at 3:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thu, Jul 7, 2022 at 2:20 PM <Conor.Dooley@microchip.com> wrote:
>
> > > lkft just found a build failure:
> > >
> > > https://gitlab.com/Linaro/lkft/users/arnd.bergmann/asm-generic/-/jobs/2691154818
> > >
> > > I have not investigated what went wrong, but it does look like an actual
> > > regression, so I'll wait for Lukas to follow up with a new version of the patch.
> >
> > Thanks for your testing. I will look into it. Probably it is due to
> > some more rigor during builds (-Werror and new warning types in the
> > default build) since I proposed the patch in October 2021. That should
> > be easy to fix, but let us see. I will send a PATCH v2 soon.
>
> Any update on this? I have another bugfix for asm-generic now and was planning
> to send a pull request with both. If you don't have the updated patch
> ready yet, this
> will have to go into 5.21 instead.
>

It is still on my TODO list for revisiting, but I had other work on
patches taking me longer than originally expected. I now moved this
patch revisiting to the top of my TODO list; so, I will certainly look
into this today. So far, I have not set up an arm64 build on my local
machine and have not used tuxbuild (which should simplify all this
setup)---the typical challenges for a "part-time kernel
contributor/janitor"...

Arnd, I will certainly let you know by this evening (European time
zone) how far I got. If that is already too late, it is also perfectly
fine if this goes in 5.21 instead, but I will try my best to make it
5.20 material.

Thanks for the patience so far.


Best regards,

Lukas

>       Arnd
