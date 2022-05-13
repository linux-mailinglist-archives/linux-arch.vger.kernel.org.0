Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25B9525E4E
	for <lists+linux-arch@lfdr.de>; Fri, 13 May 2022 11:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378527AbiEMIpZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 May 2022 04:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378510AbiEMIpS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 May 2022 04:45:18 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECF22AC0CC;
        Fri, 13 May 2022 01:45:17 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 24D8inc8008984;
        Fri, 13 May 2022 17:44:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 24D8inc8008984
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652431490;
        bh=9eAHLsfIBIOaVsxfyDkUkCcn4KH4T6JIzksZgbEKTD8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jGNuZob53bNFNxhx8NeeoPd8HMc6tay3prv3JJOGahRjQKbEcN8v0eUdQbNH7n6ZS
         zlbiFTB48M8s23G9NZjb4owJnt784q5ZqGiydctKSPpOumLjTTn0m2TJvePa6km5tC
         IH2UOYYdAgHlgUtf59FUp5amxb7ZdZ/qCx9e9YF0gLnKX1confJypLtbRkaouSnJPx
         QVvNLkCZDrKmq8n6cnnmuhEasLdQ1AmwEDcNibEwC34XE4IsgDNCnRt5VWAZLvBqF2
         gwgTVF5MtnUVX89w5VnPjgtuzWOebmSIbkP4B04/7m/8TdW+aZkBNGUFJ57TVon02r
         DTXrK3tqB/gkA==
X-Nifty-SrcIP: [209.85.216.52]
Received: by mail-pj1-f52.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so10216345pju.2;
        Fri, 13 May 2022 01:44:49 -0700 (PDT)
X-Gm-Message-State: AOAM531BYfg6GMjzD7lP8VoEfT2n2xMxEysE/sz4fW6kZ5GMAO5s0eFY
        BI+pH2Y3WLTMwn8UjiUdDGUJkYjm8RGzw70M2mk=
X-Google-Smtp-Source: ABdhPJwA2t5OI6nAtm9Un+hubZNmwvMRSWcBSE+7aGQkjmqDqI1E7a/Uw6stY+Rm0GeVbwNt9q6TVG2kK+dW1r7mHps=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr3852931plh.99.1652431488849; Fri, 13 May
 2022 01:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220404061948.2111820-1-masahiroy@kernel.org> <CAK8P3a3RWypZ2H6zRTdEWMvg608VFVAoNAQZbUM4GbW7uAWk8A@mail.gmail.com>
In-Reply-To: <CAK8P3a3RWypZ2H6zRTdEWMvg608VFVAoNAQZbUM4GbW7uAWk8A@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 13 May 2022 17:43:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNASxCvbqTLaUmVmmp_cKFNCj8hfVUA2kzEBYRf+u45Y3TQ@mail.gmail.com>
Message-ID: <CAK7LNASxCvbqTLaUmVmmp_cKFNCj8hfVUA2kzEBYRf+u45Y3TQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] UAPI: make more exported headers self-contained, and
 put them into test coverage
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Mon, Apr 4, 2022 at 4:35 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Apr 4, 2022 at 8:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> >
> > Here are more efforts to put more headers to UAPI compile testing
> > (CONFIG_UAPI_HEADER_TEST).
> >
> > I am sending this series to Arnd because he has deep knowledge for the
> > kernel APIs and manages asm-generic pull requests.
>
> These all look good to me, I can apply them for 5.19 but would wait
> a few days for others to comment.
>
>        Arnd


Can you apply 01-06 for the next MW?

I got a 0-day bot report for 07, but
I may not have time to come back to it
in this development cycle.


-- 
Best Regards
Masahiro Yamada
