Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E184547A8D
	for <lists+linux-arch@lfdr.de>; Sun, 12 Jun 2022 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiFLOrw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Jun 2022 10:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiFLOrv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jun 2022 10:47:51 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81896C08;
        Sun, 12 Jun 2022 07:47:50 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b7so3763773ljr.6;
        Sun, 12 Jun 2022 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stes9yCmLmnvhemwfBRoM/2A/BSzIcMjiRIJCZR/ru4=;
        b=A9vLTVwKCgmOsrnnfPm1sR6ZpB9BFoWzwAnoIqUCxBKl+dnilCTqAg9Ezps9OHFCbl
         9s/K/jr9gvROMAnogdVOGExNyBHF1H0b5LF7g9HXi4GXLEEptTgUZorGKG3nLWjOReP6
         4ok7ULEoYeH1qvLaPdJ6tJLIfqYvyCBxcJEnv5xwOBUR3jEDeXvo+j5Hc0aLgMTwTxYJ
         FhnGrDh3FZ1HMUl+sLMRg/nFPHqrBAuXXlGiG4OvmKBu2oC2MzlVpk10SxEMP7fq7+fB
         7dLFQ5fKRWbipG4koXImxRHxO5byQdxinddEWr5o75JUp44GpkeZScv2YGX5Zh/j8Mse
         N9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stes9yCmLmnvhemwfBRoM/2A/BSzIcMjiRIJCZR/ru4=;
        b=AiMKFletnO2xWvo/ZhsDiq14zG5mnStx8ZVoVbO5ymvGXhwO7xlUoBNnCvqVn7bHd+
         i+UaNDZ/wczl/H6k9/XDHJfnqGGOb3Bo4eIl4V0F2a0fzBQhBDGpLOpro8W9itN0s97F
         GOCUkNAeAvBf3nQUBZrEc3qIt4moHY/kfUh1kd0K60Wik9S1kCMCqhvSD6ovKcTQ6apS
         YOderHIPTHB3mSEVirP7Ef9ECa4RYSl9gaS+s4Jg4bZLtl5f5jwfj9qRIqnRE2V7gJvD
         TDRphjXso3vsB1vi2mDbQt3q+sJDRW/GM/Wg08u4ffvjY5Rp/polija3myDTT3SiV8iQ
         uMZg==
X-Gm-Message-State: AOAM530ZfhShc1fyj16Swi9Z4qyxXP8CXBcQrjEBrW9zgTyza2ZQuyMz
        /oc/k+Iy6xF03xipq3NV2t03XO9Ut/6Cl/zm4hxaqcZmW1WQdA==
X-Google-Smtp-Source: ABdhPJxhxHcJTCiKVcoZLjWkOkx50wlOn1a/CLNHy8PxEygY0uZv7MV8uZTVUS1bB91/3urU48C1MkSuy9CSP+20/yQ=
X-Received: by 2002:a2e:888b:0:b0:255:71aa:494e with SMTP id
 k11-20020a2e888b000000b0025571aa494emr27518804lji.179.1655045268479; Sun, 12
 Jun 2022 07:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220611101714.2623823-1-chenhuacai@loongson.cn> <CAHk-=wj9K=wHATkEVWyqZWzP_BP1bXDVtyEJacP6Da66HsVV2A@mail.gmail.com>
In-Reply-To: <CAHk-=wj9K=wHATkEVWyqZWzP_BP1bXDVtyEJacP6Da66HsVV2A@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 12 Jun 2022 22:47:36 +0800
Message-ID: <CAAhV-H69Hoe+e0VW--sLa7gZeVZuAz4yedPMG508XEGMrgK0wA@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch fixes for v5.19-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Linus,

On Sun, Jun 12, 2022 at 3:41 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Jun 11, 2022 at 3:15 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > LoongArch fixes for v5.19-rc2
>
> I've pulled this, but please next time add an actual note on what the fixes are.
>
> Even if it's something simple like "Fix build errors and a stale
> comment", which is what I made my merge commit say.
Thank you for your comments, I will do this in future.

Huacai
>
>                Linus
