Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8670E547732
	for <lists+linux-arch@lfdr.de>; Sat, 11 Jun 2022 20:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiFKSuJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Jun 2022 14:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFKSuH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Jun 2022 14:50:07 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188C050E20;
        Sat, 11 Jun 2022 11:50:05 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 25BInlWQ004278;
        Sun, 12 Jun 2022 03:49:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 25BInlWQ004278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654973388;
        bh=bD7jP1iJvMOBRR4wFvh3GrsKbBZ36/ShSLScO4jpsBM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wWYiP77c2IMmGVCFSpG6eXk4unRfyeNxHfCjfoKoJghKHmudnYcnMepwX0me0oTVX
         oEjMbypKIH3ox+SLw/cu+TmRO3BOiiw8tNGOD04d2OfsGU9nYI/IxtAD92l3HvfLKc
         1JHedJI+u6VBIrGh9HLpFS5cbqNhk7CxYRMmPFbazo515cCJtsE/CtzcmzbdscwQBL
         EysV42e9GEvQ5VA7uJOOJK1u1eELd63NCxfiJDmHAKa/sfBPXfH3AdzSpZExQe6Df8
         Fr9IgWFq1nszZODqkzg3TDaWIMZpUcctvEWHs/LcJoPJPjPDweTt2Labk76zK7m7If
         WTEI4wUkhlK5g==
X-Nifty-SrcIP: [209.85.128.48]
Received: by mail-wm1-f48.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso2610439wms.3;
        Sat, 11 Jun 2022 11:49:48 -0700 (PDT)
X-Gm-Message-State: AOAM532BEGneWkShSZ3dTGcM/OPeWNckGkBgO/hFRkxrn7eSZq0dpeZH
        k/pJcJY0CzV1hICYjAiRvLGoOcdpCtvM/4CB88g=
X-Google-Smtp-Source: ABdhPJxgBws9fAznvGdZuoxQOpLUSUp/oq6pjV627bxS6pXkMrMXZlFT6waKzrKG10fh1yTbiW7WLbksaid1iTUM820=
X-Received: by 2002:a7b:c346:0:b0:397:626d:d2c4 with SMTP id
 l6-20020a7bc346000000b00397626dd2c4mr6094127wmj.172.1654973386797; Sat, 11
 Jun 2022 11:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220610183236.1272216-1-masahiroy@kernel.org> <20220610183236.1272216-5-masahiroy@kernel.org>
In-Reply-To: <20220610183236.1272216-5-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 12 Jun 2022 03:49:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNATb0QsqkY3CZqrBcg3eLTc1pWuKK+M6WbadzuTvdK6GeQ@mail.gmail.com>
Message-ID: <CAK7LNATb0QsqkY3CZqrBcg3eLTc1pWuKK+M6WbadzuTvdK6GeQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nicolas Pitre <npitre@baylibre.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 11, 2022 at 3:33 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> With the previous refactoring, you no longer need to know whether the
> exported symbol is a function or a data.
>
> Replace two instances in ia64, then remove EXPORT_DATA_SYMBOL*.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Please ignore this patch.

The previous refactoring is not working correctly.





-- 
Best Regards
Masahiro Yamada
