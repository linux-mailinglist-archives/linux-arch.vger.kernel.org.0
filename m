Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D25B5ADF00
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 07:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiIFFi5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 01:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiIFFi4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 01:38:56 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE543316;
        Mon,  5 Sep 2022 22:38:54 -0700 (PDT)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2865cQbG025453;
        Tue, 6 Sep 2022 14:38:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2865cQbG025453
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662442707;
        bh=xDCM2ELtfWbaxIghoVdhy/grpBGllqEuV+LeUEWP1Ds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zTF21be2xWgdhSjv2TwodKVjuJGi0Wtzia5qTmbRXgAZiY1NJgXaqumwLiQWGOvTs
         qK5OXstgKtY3Kjbn3LhNap4WDeuK0XzG6PY+prV/fZYHlWBbNvj8G2sgZudazw+mIF
         0sBQ2ALD5TwCz4zOWBf6pVFV4N3M/6xp/OjbPJd2HlbeN2H/eCgAVeNi0Rzs5l6r9v
         rKZ/+oUT9qX0f0PcJvSqlnQet7+eZzDLjlY6X9CVe/oy3TtkI00bCo8gCrRqx+f326
         a+Dlwj9QZ92KHr6J/0AM5Ncu90Mpku8Mp9HiZ5dMPiB7wYU/iHfBwHJEuE+dOzIcMq
         TgNkHpGHajx7g==
X-Nifty-SrcIP: [209.85.160.41]
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-11f34610d4aso25719977fac.9;
        Mon, 05 Sep 2022 22:38:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo3JWKYv4ai0i/5RWYv7aDXtu/mOTAuGre4inY7oZwO0wvwBHi28
        6GDW6ym2hUz+yAniXkh3Lx3gjfNIU53AlB/qldw=
X-Google-Smtp-Source: AA6agR67ml6xVcQPsgWC4IEh9NlgKqQkUD+yzlEWC3f8vVi+rYODcebxIPaYwAMPI4GuNHLB0RRnghEbe5QkXQxURhM=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr10425730oab.287.1662442705835; Mon, 05
 Sep 2022 22:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220828024003.28873-1-masahiroy@kernel.org>
In-Reply-To: <20220828024003.28873-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 6 Sep 2022 14:37:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQNVA0eVEZ_BEKVaVNq0J2iQnyPVJRCPwsXepnm_4UcfQ@mail.gmail.com>
Message-ID: <CAK7LNAQNVA0eVEZ_BEKVaVNq0J2iQnyPVJRCPwsXepnm_4UcfQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] kbuild: various cleanups
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

On Sun, Aug 28, 2022 at 11:40 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>   - Avoid updating init/built-in.a twice
>   - Run modpost just once instead of twice
>   - Link vmlinux and modules in parallel
>   - Remove head-y syntax
>
> These are ground works to make the further refactoring possible.
>
> This patch set is applicable after the following series:
>   https://patchwork.kernel.org/project/linux-kbuild/list/?series=669437
>
>
> Masahiro Yamada (15):
>   kbuild: remove duplicated dependency between modules and modules_check
>   kbuild: refactor single builds of *.ko
>   kbuild: move 'PHONY += modules_prepare' to the common part
>   init/version.c: remove #include <linux/version.h>
>   kbuild: build init/built-in.a just once
>   kbuild: generate include/generated/compile.h in top Makefile
>   scripts/mkcompile_h: move LC_ALL=C to '$LD -v'
>   Revert "kbuild: Make scripts/compile.h when sh != bash"
>   kbuild: rename modules.order in sub-directories to .modules.order
>   kbuild: move core-y in top Makefile to ./Kbuild
>   kbuild: move .vmlinux.objs rule to Makefile.modpost
>   kbuild: move vmlinux.o rule to the top Makefile
>   kbuild: unify two modpost invocations
>   kbuild: use obj-y instead extra-y for objects placed at the head
>   kbuild: remove head-y syntax



I moved 01-08 to for-next.

10 broke single target builds.

I will send v2 for the rest.






>  Documentation/kbuild/makefiles.rst          |  27 +----
>  Kbuild                                      |  16 +++
>  Makefile                                    | 120 ++++++++++++--------
>  arch/alpha/Makefile                         |   2 -
>  arch/alpha/kernel/Makefile                  |   4 +-
>  arch/arc/Makefile                           |   2 -
>  arch/arc/kernel/Makefile                    |   4 +-
>  arch/arm/Makefile                           |   3 -
>  arch/arm/kernel/Makefile                    |   4 +-
>  arch/arm64/Makefile                         |   3 -
>  arch/arm64/kernel/Makefile                  |   4 +-
>  arch/csky/Makefile                          |   2 -
>  arch/csky/kernel/Makefile                   |   4 +-
>  arch/hexagon/Makefile                       |   2 -
>  arch/hexagon/kernel/Makefile                |   3 +-
>  arch/ia64/Makefile                          |   1 -
>  arch/ia64/kernel/Makefile                   |   4 +-
>  arch/loongarch/Makefile                     |   2 -
>  arch/loongarch/kernel/Makefile              |   4 +-
>  arch/m68k/68000/Makefile                    |   2 +-
>  arch/m68k/Makefile                          |   9 --
>  arch/m68k/coldfire/Makefile                 |   2 +-
>  arch/m68k/kernel/Makefile                   |  21 ++--
>  arch/microblaze/Makefile                    |   1 -
>  arch/microblaze/kernel/Makefile             |   4 +-
>  arch/mips/Makefile                          |   2 -
>  arch/mips/kernel/Makefile                   |   4 +-
>  arch/nios2/Makefile                         |   1 -
>  arch/nios2/kernel/Makefile                  |   2 +-
>  arch/openrisc/Makefile                      |   2 -
>  arch/openrisc/kernel/Makefile               |   4 +-
>  arch/parisc/Makefile                        |   2 -
>  arch/parisc/kernel/Makefile                 |   4 +-
>  arch/powerpc/Makefile                       |  12 --
>  arch/powerpc/kernel/Makefile                |  22 ++--
>  arch/riscv/Makefile                         |   2 -
>  arch/riscv/kernel/Makefile                  |   2 +-
>  arch/s390/Makefile                          |   2 -
>  arch/s390/boot/version.c                    |   1 +
>  arch/s390/kernel/Makefile                   |   4 +-
>  arch/sh/Makefile                            |   2 -
>  arch/sh/kernel/Makefile                     |   4 +-
>  arch/sparc/Makefile                         |   2 -
>  arch/sparc/kernel/Makefile                  |   3 +-
>  arch/x86/Makefile                           |   5 -
>  arch/x86/boot/compressed/kaslr.c            |   1 +
>  arch/x86/boot/version.c                     |   1 +
>  arch/x86/kernel/Makefile                    |  10 +-
>  arch/xtensa/Makefile                        |   2 -
>  arch/xtensa/kernel/Makefile                 |   4 +-
>  init/Makefile                               |  55 ++++++---
>  init/build-version                          |  10 ++
>  init/version-timestamp.c                    |  31 +++++
>  init/version.c                              |  37 +++---
>  scripts/Makefile.build                      |  20 ++--
>  scripts/Makefile.lib                        |   8 +-
>  scripts/Makefile.modfinal                   |   2 +-
>  scripts/Makefile.modpost                    | 112 ++++++++----------
>  scripts/Makefile.vmlinux_o                  |   6 +-
>  scripts/clang-tools/gen_compile_commands.py |  19 +---
>  scripts/head-object-list.txt                |  53 +++++++++
>  scripts/link-vmlinux.sh                     |  51 ++-------
>  scripts/mkcompile_h                         |  96 ++--------------
>  63 files changed, 393 insertions(+), 457 deletions(-)
>  create mode 100755 init/build-version
>  create mode 100644 init/version-timestamp.c
>  create mode 100644 scripts/head-object-list.txt
>
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
