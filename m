Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CDD484B58
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 00:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbiADXs7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 18:48:59 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:30195 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiADXs6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 18:48:58 -0500
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 204NmcIT030502;
        Wed, 5 Jan 2022 08:48:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 204NmcIT030502
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1641340119;
        bh=n/Pj0GuzGOQz52d0M2ySHYPW8PnjPW/MC0KNt6VisQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WNyXe+TNpD+5PhYmJl/5PzFyxxou0Gl28BaS9COblPxjUDBR6TbjkF02wKfbqJOe4
         KQSI+cDKcTkBo2o4ZnJgkJDEJe5laVDVEBMOAkAhHvz0q4/pIDfFGtJ/6vFPoZUAtf
         rpBSCStylfIchiziCNptVJlKsjT+uHV5Cz7uXAZrV8qwM1I5qxtSNmfaQshmh9Aru4
         XauiZuwvYIjgoMJgyKwnqzt0h2ixDCx9d1nBA9TaSAWnR/AGOA5gcF/lSuOYXJbQHX
         2oeWMitgvKnev1/NtAs1UsVQxP9Th8k/A37YNHq80egjyIN9r/Bngg26ay8VH8eszE
         Hf4HoCHsK91vA==
X-Nifty-SrcIP: [209.85.210.170]
Received: by mail-pf1-f170.google.com with SMTP id 196so33569911pfw.10;
        Tue, 04 Jan 2022 15:48:38 -0800 (PST)
X-Gm-Message-State: AOAM530rldZX5KL0DzN1ShVV871i0KAXp1xrkoqNTQWwzvfg5mtT0aVP
        7n5Jftln7ooJzs5kgIwDzpT3Dpi/NMNHZtXvepM=
X-Google-Smtp-Source: ABdhPJy1ElIOgaDmwcYlNYCKdVORotcnknHA9hhyGHQzzGq2dcvsZQ4k61/RlcmBwmUA89kzriKYSp+QP7PuwVN5vSo=
X-Received: by 2002:a63:7148:: with SMTP id b8mr23513297pgn.616.1641340117654;
 Tue, 04 Jan 2022 15:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20211214025355.1267796-1-masahiroy@kernel.org>
In-Reply-To: <20211214025355.1267796-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 5 Jan 2022 08:48:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ98p=UbtdgdTkdO1djA--Ch7QwmR=0Q11QL6aKKZYC2w@mail.gmail.com>
Message-ID: <CAK7LNAQ98p=UbtdgdTkdO1djA--Ch7QwmR=0Q11QL6aKKZYC2w@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] kbuild: do not quote string values in Makefile
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Nicolas Schier <n.schier@avm.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 14, 2021 at 11:55 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
> This patch refactors the code as outlined in:
>
>   https://lore.kernel.org/linux-kbuild/CAK7LNAR-VXwHFEJqCcrFDZj+_4+Xd6oynbj_0eS8N504_ydmyw@mail.gmail.com/
>
> First some patches refactor certs/Makefile. This Makefile is written
> in a too complicated way.
>
> I will revert cd8c917a56f20f48748dd43d9ae3caff51d5b987
> after this lands in the upstream.
>
>



Applied to linux-kbuild.



> Masahiro Yamada (11):
>   certs: use $< and $@ to simplify the key generation rule
>   certs: unify duplicated cmd_extract_certs and improve the log
>   certs: remove unneeded -I$(srctree) option for system_certificates.o
>   certs: refactor file cleaning
>   certs: remove misleading comments about GCC PR
>   kbuild: stop using config_filename in scripts/Makefile.modsign
>   certs: simplify $(srctree)/ handling and remove config_filename macro
>   kbuild: do not include include/config/auto.conf from shell scripts
>   kbuild: do not quote string values in include/config/auto.conf
>   certs: move scripts/extract-cert to certs/
>   microblaze: use built-in function to get CPU_{MAJOR,MINOR,REV}
>
>  MAINTAINERS                                   |  1 -
>  Makefile                                      |  6 +-
>  arch/arc/Makefile                             |  4 +-
>  arch/arc/boot/dts/Makefile                    |  4 +-
>  arch/h8300/boot/dts/Makefile                  |  6 +-
>  arch/microblaze/Makefile                      |  8 +--
>  arch/nds32/boot/dts/Makefile                  |  7 +--
>  arch/nios2/boot/dts/Makefile                  |  2 +-
>  arch/openrisc/boot/dts/Makefile               |  7 +--
>  arch/powerpc/boot/Makefile                    |  2 +-
>  arch/riscv/boot/dts/canaan/Makefile           |  4 +-
>  arch/sh/boot/dts/Makefile                     |  4 +-
>  arch/xtensa/Makefile                          |  2 +-
>  arch/xtensa/boot/dts/Makefile                 |  5 +-
>  certs/.gitignore                              |  1 +
>  certs/Makefile                                | 55 +++++++------------
>  {scripts => certs}/extract-cert.c             |  2 +-
>  drivers/acpi/Makefile                         |  2 +-
>  drivers/base/firmware_loader/builtin/Makefile |  4 +-
>  init/Makefile                                 |  2 +-
>  net/wireless/Makefile                         |  4 +-
>  scripts/.gitignore                            |  1 -
>  scripts/Kbuild.include                        | 47 ----------------
>  scripts/Makefile                              | 11 +---
>  scripts/Makefile.modinst                      |  4 +-
>  scripts/gen_autoksyms.sh                      | 11 +---
>  scripts/kconfig/confdata.c                    |  2 +-
>  scripts/link-vmlinux.sh                       | 47 ++++++++--------
>  scripts/remove-stale-files                    |  2 +
>  scripts/setlocalversion                       |  9 ++-
>  usr/Makefile                                  |  2 +-
>  31 files changed, 87 insertions(+), 181 deletions(-)
>  rename {scripts => certs}/extract-cert.c (98%)
>
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
