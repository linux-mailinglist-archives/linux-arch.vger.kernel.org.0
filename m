Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547585EE817
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 23:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiI1VOd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 17:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbiI1VOJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 17:14:09 -0400
Received: from condef-06.nifty.com (condef-06.nifty.com [202.248.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCF3110B12;
        Wed, 28 Sep 2022 14:09:10 -0700 (PDT)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-06.nifty.com with ESMTP id 28SL5JwE013651;
        Thu, 29 Sep 2022 06:05:19 +0900
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 28SL4kYs027628;
        Thu, 29 Sep 2022 06:04:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 28SL4kYs027628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664399087;
        bh=la5EsbEMHmA/CJNM5Muo6C+Tq1IqrhfhIXVR576yhI4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0xjS+HokgTAU6kykjqgYtjKz0jxmy+3LdP3cMcJHu+q+1xOZwXi+MWzZveVqtgSij
         37LB4ehOlUx3A9cQPJ7H2KDVud99BZ0BCghRGLbnwilqqLQFFxmFcapYxRK/NwxC/D
         xtJBFDynJ8HdevSGWcyrCs9eo+iiZDDL43zNnK840H0UIiuL4VFpRJ52VTIUnDKtWD
         B27y23S3cpsA2z70Jp4nlt4RiXmQS+vkRFE0jGpcbpZCrv0viN3dC22u1YYtsAr1vd
         F501/9Fz3tzRmswzZMJ/8O72yVFrKuXmb+wBepX2BUHL9IuQh3nvFrIApqI3e9XMkd
         CmSw1BoBrGkBg==
X-Nifty-SrcIP: [209.85.160.41]
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-13189cd5789so7106477fac.11;
        Wed, 28 Sep 2022 14:04:47 -0700 (PDT)
X-Gm-Message-State: ACrzQf3S+M0vWNsumDngacdUse3ItN4pPQm3OtP9W/s9YPQUBnGRK7Oh
        RNw9DbYIjohAvRAYSsSAZnEVc3YzYVwrdrz5dQ8=
X-Google-Smtp-Source: AMsMyM6zUXjs63osdv/4PtoIRZPm5pM0/2GbAXZtQFtkOYhlyrTLkXOA/MyaUldtI41YO3Iyzt+XIGVub+g3qLnneww=
X-Received: by 2002:a05:6870:6326:b0:131:9200:c99d with SMTP id
 s38-20020a056870632600b001319200c99dmr4953220oao.194.1664399086115; Wed, 28
 Sep 2022 14:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220928063947.299333-1-masahiroy@kernel.org>
In-Reply-To: <20220928063947.299333-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 29 Sep 2022 06:04:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNATcD6k+R66YFVg_mhe7-FGNc0nYaTPuORCcd34Qw3ra2g@mail.gmail.com>
Message-ID: <CAK7LNATcD6k+R66YFVg_mhe7-FGNc0nYaTPuORCcd34Qw3ra2g@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Unify <linux/export.h> and <asm/export.h>, remove
 EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 28, 2022 at 3:41 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
> This patch set refactors EXPORT_SYMBOL, <linux/export.h> and <asm/export.h>.
> Also, re-implement TRIM_UNUSED_KSYMS in one-pass.
>
> You can still put EXPORT_SYMBOL() in *.S file, very close to the definition,
> but you do not need to care about whether it is a function or a data.
> Remove EXPORT_DATA_SYMBOL().
>
> In v1, I broke ia64 because of missing distinction between functions and data.
>
> V2 handles it correctly.
> If the exported symbols is a function, KSYMTAB_FUNC is output.
> Otherwise, KSYMTAB_DATA is output.
>



I noticed this patch set is broken in multiple ways.
No test is needed.
(0day may send various reports, but please ignore them)

I will fix the code when I have time.







Best Regards

Masahiro Yamada
