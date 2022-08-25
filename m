Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBB85A199F
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 21:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbiHYThf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 15:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241530AbiHYThe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 15:37:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D4DBB01E
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 12:37:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gb36so41466624ejc.10
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ug3fzDG0QYxiY3xSd7c4nZwCEdS86ZeW5WM3LA5MHSM=;
        b=g0uJOozT5lU6a75DvEj4h4KqrNPs35pLZkIU4MKoz44BuRVm2ldEff9+o9XfvwCUfA
         6CB6GJ168eYVhTnYKDQ92K/VsTEwnZ3TZqKhODN5kABVXGlU1ASH7oyqrll6gyjBmG3c
         VDI1lNLSTqiDONp8h/eQmERKYaafeOs8Kr8dT9KSTqUeoZvupkP/MnwvMm6rLdSaBj/s
         X0Q0gTjN6ccSlAv795W096/9/y+aZ94j8sXhxc3bSZZaKM6vE/PZnh0U9O4pmR+PI6vD
         fVcqNtGjcEWDRgm27Gyt6RqKsdYSJobymxtbwGVMmXIV+krZT2bCZhQnr6PDHP6IWbUU
         Pc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ug3fzDG0QYxiY3xSd7c4nZwCEdS86ZeW5WM3LA5MHSM=;
        b=uHjW7FwzjQiMgmpT3nU77EmqgMyqplHBmvAwMIoO0MsnssyJUPTcZ3/wsd5Uv+t5PK
         2ePGhPemTbVAzyq7jDTg/9qev/Bw17Tv6UjwKcCplvZ7BsHY2gGG8ZwZdU5ncPgDkuPa
         m5WDzhXDCWK9huFSPPlAwtVYCqVCUNETwN0jVc1MuX+og9VUWlDo6orzzZo3E3Ayo+6P
         c+THxYolOSanZsej7clI4IFl3gsLFeV+EnyMTX0GobznsmSlJFFIY4/Hp2rk97oNc50M
         SJzWjEIsjdfPr4KCbpctlzVKXXI10K0GCb5kxJGN5SObjHD0py2a+ohybmYqB3YWVzay
         zP6w==
X-Gm-Message-State: ACgBeo15UoXkpF8R9vbNMWmkHwGhDV3BXvuPrBJX44bntunOSO56bXzW
        zikyaFGD8D2cRjgSW0xBjTjKAg2/QEhDwuKZ9i5onGR+ZO0DJuO2
X-Google-Smtp-Source: AA6agR7Vmn67v3s4dfV6Z2gSOqTOSHLYzwBGRCw6TengerfmZk7/zFC9K75wXTb1hZHhmc7K57ZZODg47J8yw06KyJM=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr3538212ejs.190.1661456251980; Thu, 25
 Aug 2022 12:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220823085014.208791-1-linus.walleij@linaro.org> <48f9ddc8-02e2-2f2a-8bde-2d7346998096@infradead.org>
In-Reply-To: <48f9ddc8-02e2-2f2a-8bde-2d7346998096@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Aug 2022 21:37:20 +0200
Message-ID: <CACRpkdbG1_eH9kGnGosODfOJto-DZ6C5etnGORjQfesB8ipUsg@mail.gmail.com>
Subject: Re: [PATCH] sparc64: Fix the generic IO helpers
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 25, 2022 at 12:15 AM Randy Dunlap <rdunlap@infradead.org> wrote:

> Both alpha

https://lore.kernel.org/linux-arch/20220818092059.103884-1-linus.walleij@linaro.org/

>  & parisc (32 and 64 bits) need this fix also.

Yeah I'll try to send something for them too. Also fixed Hexagon.
The problem is installing all the cross compilers just to test this
stuff.... It's a lot of work.

> Is it always safe to do this?

I think the arch part is fine, i.e. I don't think it will fix something
broken.

Then it is the matter of testing the new accessors.

That is done by a usecase, in this case, a usecase using
a fixed address in 64bit registers write under regmap MMIO.

Not sure someone will ever have a usecase for that to test
with. The people making use of it need to test it when they
use it.

As mentioned in the alpha patch, the alternative is to leave
regmap-mmio broken for the arch, until someone uses is.
It feels wrong to develop generic code for all archs that cannot
even compile on all of them, so I prefer to fix it to the point
of compiling at least. The generic helpers try their best to
be, well generic helpers.

Yours,
Linus Walleij
