Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1752C5BAFD6
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiIPPE4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 11:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiIPPEy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 11:04:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B542C3120B;
        Fri, 16 Sep 2022 08:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DF3BB827CD;
        Fri, 16 Sep 2022 15:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E369C433D6;
        Fri, 16 Sep 2022 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663340690;
        bh=M+DmXxb8Nav4aJ99WqznXuiR7oCNvzYJ85lQmDQ9Izg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XpPP02ruXeMlyDqw9AU8lVSQByUbs6eMh26MJMnFahTJwObYyJr4/wuQongHFtH68
         kY1PB9jQ4p8YUKFug0YwKGd0Nq49sgRYHutVZlV6WhV9hmfNSQgkAfGW3OkeW1YL1S
         LPXbCmo6iYjLlnLcxqZicdiT6SvqQX4xlDRvHL5OufpTXHJtDEL17fIsM29fRhHWib
         3giP4eSFRmfmNCOl7aeZAZwJsv3xduvoCB56kQLsPx3g39oXiAHAqLqu4Py2DAZh+k
         l6TPHkf4SrjQUSHLUishzlJ6fUJYW+3fY2dNgqjGBFZF4kHNscazVjfQBhLB8p3xj7
         yuv1p3lZXn1Sw==
Received: by mail-vs1-f42.google.com with SMTP id q26so17512805vsr.7;
        Fri, 16 Sep 2022 08:04:50 -0700 (PDT)
X-Gm-Message-State: ACrzQf26xwbi9FiQaqLifYRCR/5HqVNlHGbWh6BQjBCsLXLR5+je/koE
        /9R0J9RH498pUz1taL+Z1F2lmtx1bvDDY/66X0Y=
X-Google-Smtp-Source: AMsMyM4faniycC3kJf+HRla45fniBnoEma4pmEUEn4z1nLlUd+7aVGjIUb5s2RMrkSft1plARpEZRbhzST5q09/ceFQ=
X-Received: by 2002:a05:6102:2755:b0:398:4f71:86e with SMTP id
 p21-20020a056102275500b003984f71086emr2486151vsu.84.1663340689313; Fri, 16
 Sep 2022 08:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220818040413.2865849-1-chenhuacai@loongson.cn>
 <CAAhV-H7fiyq7tKJw3CsYDBWjJu89oBJqgNZLxgd+UQE=+X6Czw@mail.gmail.com> <e5433179-c300-482e-9dad-b1b15c56970a@www.fastmail.com>
In-Reply-To: <e5433179-c300-482e-9dad-b1b15c56970a@www.fastmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 16 Sep 2022 23:04:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4POp1tgDXOck5nLoi7oQ5hAU8jwHg+AbUdX0zUhjqsoQ@mail.gmail.com>
Message-ID: <CAAhV-H4POp1tgDXOck5nLoi7oQ5hAU8jwHg+AbUdX0zUhjqsoQ@mail.gmail.com>
Subject: Re: [PATCH] Input: i8042 - Add PNP checking hook for Loongson
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Fri, Sep 16, 2022 at 6:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Sep 16, 2022, at 11:53 AM, Huacai Chen wrote:
> > Ping?
> >
> > On Thu, Aug 18, 2022 at 12:04 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >>
> >> Add PNP checking related functions for Loongson, so that i8042 driver
> >> can work well under the ACPI firmware with PNP typed keyboard and mouse
> >> configured in DSDT.
> >>
> >> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> >> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >> ---
> >>  drivers/input/serio/i8042-loongsonio.h | 330 +++++++++++++++++++++++++
> >>  drivers/input/serio/i8042.h            |   2 +
> >>  2 files changed, 332 insertions(+)
>
> This looks like you are just duplicating code from
> i8042-x86ia64io.h. Can't you just use that version
> directly?
OK, I will rename i8042-x86ia64io.h to i8042-acpiio.h and use it for LoongArch.

Huacai
>
>       Arnd
