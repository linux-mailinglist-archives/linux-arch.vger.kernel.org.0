Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D331F57E6E6
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 20:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiGVS6C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 14:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiGVS6B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 14:58:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFD58EEF7
        for <linux-arch@vger.kernel.org>; Fri, 22 Jul 2022 11:58:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l23so10092242ejr.5
        for <linux-arch@vger.kernel.org>; Fri, 22 Jul 2022 11:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CFtWv8cujsml9Nm915ayXL51uD/obgxi8OyaZQUdDOE=;
        b=EoUYvGEmiLqZvCHAadV8xm3zldGQR/AXQXlplxHKyoH+GrNylYMUcu/cP++VqO2kQj
         Jn6jLRt8ddpSkCTTFV05lNnMWPFZbYpaE1l9/iaVHhsqS04FE30XEhi5KRPIpzUecWk7
         ln4SJtufGrukvBkolkbObTwkHMbWnl355APQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFtWv8cujsml9Nm915ayXL51uD/obgxi8OyaZQUdDOE=;
        b=YnJk4PmBH7pR+YbG0dPTU6IXhOL7AyYkucbJQBBL8/jZjShJqQYHiBh4/cpoU5iJ8W
         3Ju8tzsEZLgVTgDy3CMuRKcWIIrGnA9al8aq+lnIURqZF54vqYTCwXDrndDd92rRPmCy
         FRjZYX9cbYU97Qqu+IwjFtTod+mxJ2yxEqbpXTia6x1w7zfT+wgdwKAjPFzx33tzeki8
         PHyB41sXqrL9bGuvQQwTgga4+M0s7WOabynjfdSw2XIW3wMt1Sj519V2dyCCPfuXmKoX
         T0wKdLtn5fbA0sG0TnCd3KFWOR80ik4IPK93Vzzz0eHlHEHI4ElbuelX9W4I8cnjnKMk
         C23g==
X-Gm-Message-State: AJIora9FKqznUHAAGCH4MA3wQPpPIHIRXfQp9g1ZTO3ZCoGNPzO4s+Ze
        e3QmDel/xYmuff4GOB/gccM0w+RNEDmeRnDr
X-Google-Smtp-Source: AGRyM1tyMgxOBRk/R7ces1rm/xpttFOHCnAl6eCos5nihlvUn9xMezswEQxiUUwmjVJ4nNnRdwIs5g==
X-Received: by 2002:a17:907:b04:b0:72b:5cf4:4631 with SMTP id h4-20020a1709070b0400b0072b5cf44631mr1031927ejl.180.1658516278259;
        Fri, 22 Jul 2022 11:57:58 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906528200b0072aeaa1bb5esm2256717ejm.211.2022.07.22.11.57.57
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:57:57 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id b26so7718043wrc.2
        for <linux-arch@vger.kernel.org>; Fri, 22 Jul 2022 11:57:57 -0700 (PDT)
X-Received: by 2002:a05:6000:1049:b0:21e:584f:3574 with SMTP id
 c9-20020a056000104900b0021e584f3574mr838736wrx.274.1658516276828; Fri, 22 Jul
 2022 11:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <YtpXh0QHWwaEWVAY@debian> <CAHk-=wipavrPuNPqiZ_zMP8EdbLKnnTkFukVCWm8FmCTUth4gQ@mail.gmail.com>
 <CADVatmPkXQ3mJpdTvaHxN4qmacYBhvzz=nxduQn-y+QUz4Pu2Q@mail.gmail.com>
In-Reply-To: <CADVatmPkXQ3mJpdTvaHxN4qmacYBhvzz=nxduQn-y+QUz4Pu2Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Jul 2022 11:57:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjFd-2j1qCsqdsakwcH=QML2BJBCpN2+rg10Y+PMGOOg@mail.gmail.com>
Message-ID: <CAHk-=whjFd-2j1qCsqdsakwcH=QML2BJBCpN2+rg10Y+PMGOOg@mail.gmail.com>
Subject: Re: mainline build failure due to b67fbebd4cf9 ("mmu_gather: Force
 tlb-flush VM_PFNMAP vmas")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 22, 2022 at 10:20 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> That fixes the alpha build failure.
> If you commit it today then my nightly builds can test other
> combinations of all other arch also.

Thanks.

It's commit 7fb5e5083190 ("mmu_gather: fix the
CONFIG_MMU_GATHER_NO_RANGE case") in my tree now.

I decided to not amend the commit, so it doesn't have your tested-by,
only your reported-by, but I put the link your report (this thread),
so it's kind of there.

                   Linus
