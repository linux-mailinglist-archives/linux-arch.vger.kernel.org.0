Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACE25B1579
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 09:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiIHHQq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Sep 2022 03:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIHHQp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Sep 2022 03:16:45 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6092656A;
        Thu,  8 Sep 2022 00:16:44 -0700 (PDT)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2887GSk7002753;
        Thu, 8 Sep 2022 16:16:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2887GSk7002753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662621389;
        bh=Zi1KVRpArAd4GR+l41DO7f/S57oZpGFbgNVPesyN+LI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HYgzSQA08bn/vrZoJrrsfn1nafgpdBorzTYJJ17aN/376DKO61InNDkP7mWtR+s8u
         oiiu7gDNTjlT1gmEtHO9pO41lv7EBg/k+aQb7Wihs/tz/+l4JWVqFTWIZRf1/TgUPz
         3KnSIs6wGZlcLyhQrqi5l075iCRIXEQTKfNYmdJv7pMimwYiJeA8k6Mc1mgjWayA0L
         saG08GhyVKRXcQLXnB21STQckf2zSW4Pnx8KzYpKhNfV38rwQdG9JkX5koWYKWIycJ
         fjBjLoZXr31w5HJcI4T4+uDs/QJHknple84JeFbKLoRWTc4VwsACMIUGiS7R5OcDzJ
         A1ISG6xBJdJ7A==
X-Nifty-SrcIP: [209.85.160.43]
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1280590722dso8623750fac.1;
        Thu, 08 Sep 2022 00:16:28 -0700 (PDT)
X-Gm-Message-State: ACgBeo3pu5aVcQrUKVcEWhStTTlSqGuTSVWzg4/KP3pte+rsXcu4Nd6m
        ylY/Kkt8Us0DMNw5QjSnbugmO2pcOPF+gQ1q33c=
X-Google-Smtp-Source: AA6agR5xWpm1RVlxiP0x+wSspMDyK7HdF4a5HOzRxJyNSy1PDSTemdEx7Juu4iK1N3Ml/H8qsNZ8nDiNxaRx2DoAIBw=
X-Received: by 2002:a05:6808:90a:b0:34b:826c:6116 with SMTP id
 w10-20020a056808090a00b0034b826c6116mr868875oih.194.1662621387757; Thu, 08
 Sep 2022 00:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220906061313.1445810-1-masahiroy@kernel.org> <20220906061313.1445810-8-masahiroy@kernel.org>
In-Reply-To: <20220906061313.1445810-8-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 8 Sep 2022 16:15:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR_nbuzH6Cj8E7jgZq+wuKEt9ra6RiRE2dUwPi1ZJOoWw@mail.gmail.com>
Message-ID: <CAK7LNAR_nbuzH6Cj8E7jgZq+wuKEt9ra6RiRE2dUwPi1ZJOoWw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] kbuild: use obj-y instead extra-y for objects
 placed at the head
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Tue, Sep 6, 2022 at 3:13 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The objects placed at the head of vmlinux need special treatments:
>
>  - arch/$(SRCARCH)/Makefile adds them to head-y in order to place
>    them before other archives in the linker command line.
>
>  - arch/$(SRCARCH)/kernel/Makefile adds them to extra-y instead of
>    obj-y to avoid them going into built-in.a.
>
> This commit gets rid of the latter.
>
> Create vmlinux.a to collect all the objects that are unconditionally
> linked to vmlinux. The objects listed in head-y are moved to the head
> of vmlinux.a by using 'ar m'.
>
> With this, arch/$(SRCARCH)/kernel/Makefile can consistently use obj-y
> for builtin objects.
>
> There is no *.o that is directly linked to vmlinux. Drop unneeded code
> in scripts/clang-tools/gen_compile_commands.py.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> (no changes since v1)
>




> @@ -198,12 +198,12 @@ KCOV_INSTRUMENT_paca.o := n
>  CFLAGS_setup_64.o              += -fno-stack-protector
>  CFLAGS_paca.o                  += -fno-stack-protector
>
> -extra-$(CONFIG_PPC_FPU)                += fpu.o
> -extra-$(CONFIG_ALTIVEC)                += vector.o
> -extra-$(CONFIG_PPC64)          += entry_64.o
> -extra-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE) += prom_init.o
> +obj-$(CONFIG_PPC_FPU)          += fpu.o
> +obj-$(CONFIG_ALTIVEC)          += vector.o
> +obj-$(CONFIG_PPC64)            += entry_64.o
> +obj-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)   += prom_init.o
>
> -extra-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE) += prom_init_check
> +obj-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)   += prom_init_check


This line should not be changed.

I fixed it up locally.

https://lore.kernel.org/lkml/CAK7LNARzFmJjpyUciy1LRvaFo72aZcqRbzY-63ArpeszC+HfmQ@mail.gmail.com/






-- 
Best Regards
Masahiro Yamada
