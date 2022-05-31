Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D83539825
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 22:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbiEaUlV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 May 2022 16:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbiEaUlU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2022 16:41:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDAB2A7;
        Tue, 31 May 2022 13:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C9EBB80FB3;
        Tue, 31 May 2022 20:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB82C341C6;
        Tue, 31 May 2022 20:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654029676;
        bh=pJkA28MYtLxRIxdBNIGyaIzZMHuixKblkEVeOXjCztQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VWcfGezUwRb/Zeq9RJ8smztfHBwzyZ1MsKlThN8toiLSmD4YS2YZDI6zDF+nAytnF
         WayKbiamfjtPPDyhJAZmH6zzZUDLkGKX9QihnTbUQEDkSWMtvkztUHmBwSYWCGozg3
         K36CM/wriFIpVrmtk6+QnmNan8mZs5G+SoHv2jZ3SNDJQ3ikRNGKJIZ4SGFu8sUHFe
         pASO8hYwSZ+HCLZmxCZCy+i1h5uvPjW2nUYF/RsHvDRY2CImnb9KSORB4t/3AvhtPG
         VyOLv69ZL/kplDjJCqp4HG4pBmdmUNzEZJgmb/cnwtQSGNLzSj5YQa/bOPud1qtw/w
         bnLvmGyk3nGmg==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2f83983782fso152892057b3.6;
        Tue, 31 May 2022 13:41:16 -0700 (PDT)
X-Gm-Message-State: AOAM532dObBDBH2J2JR9TBO36aLggL9p+w435Q6W0VRL2wDwgJaEP/Zb
        Mxpw7YQNgDUaj9q9DC+YfOXKPECjlwL79aMIwQM=
X-Google-Smtp-Source: ABdhPJxXa52JB96dEGmMMbjyWZgKzuSGhmh2BklKLjs5FBCGtGzMkaptgm5Aoiqqleh0v4fR3TR1BO1ls94gmjh98Ck=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr67745984ywk.209.1654029675316; Tue, 31
 May 2022 13:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
 <df5c406c-eec6-c340-2847-49670b7fe8bf@xen0n.name> <CAK8P3a3awFdB1-G65DC38NBuSTvo6SvFTaS0m9YBxunHjHjQvQ@mail.gmail.com>
 <CAAhV-H6sNr-yo8brBFtzziH6k9Tby0dFp7yehK55SfH5HjZ8hQ@mail.gmail.com>
 <358025d1-28e6-708b-d23d-3f22ae12a800@xen0n.name> <CAK8P3a1ge2bZS13ahm_LdO3jEcbtR4w3do-gLjggKvppqnBDkw@mail.gmail.com>
 <CAAhV-H5NCUpR6aBtR9d7c9vW2KiHpk3iFQxj7BeTSS0boMz8PQ@mail.gmail.com>
 <CAK8P3a2JgrW5a7_udCUWen-gOnJgVeRV2oAd-uq4VSuYkFUqNQ@mail.gmail.com>
 <CAAhV-H6wfmdcV=a4L43dcabsvO+JbOebCX3_6PV+p85NjA9qhQ@mail.gmail.com>
 <CAK8P3a0c_tbHov_b6cz-_Tj6VD3OWLwpGJf_2rj-nitipSKdYQ@mail.gmail.com>
 <CAAhV-H4_qqQtTp2=mJF=OV+qcKzA0j8SPWKRMR-LJgC0zNfatQ@mail.gmail.com> <CAK8P3a3UfDJkoAkA6an2kXyAYSzz2vt__19JoQmum8LZehXrgg@mail.gmail.com>
In-Reply-To: <CAK8P3a3UfDJkoAkA6an2kXyAYSzz2vt__19JoQmum8LZehXrgg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 31 May 2022 22:40:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0tu4ZANdxY-beVb4C1hKrn2VJqpfwBemhqHkr6760b7A@mail.gmail.com>
Message-ID: <CAK8P3a0tu4ZANdxY-beVb4C1hKrn2VJqpfwBemhqHkr6760b7A@mail.gmail.com>
Subject: Re: [musl] Re: [GIT PULL] asm-generic changes for 5.19
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     musl@lists.openwall.com, WANG Xuerui <kernel@xen0n.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        linux-pci <linux-pci@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 31, 2022 at 10:07 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, May 31, 2022 at 6:01 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > On Tue, May 31, 2022 at 7:15 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > On Tue, May 31, 2022 at 10:17 AM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
> > has been updated. Now this branch droped irqchip drivers and pci
> > drivers. But the existing irqchip drivers need some small adjustment
> > to avoid build errors [1], and I hope Marc can give an Acked-by.
>
> Ok, glad you got that working.
>

From an allmodconfig build, I see two more things that could be addressed first:

drivers/pci/probe.c: In function 'pci_scan_bridge_extend':
drivers/pci/probe.c:1298:44: error: implicit declaration of function
'pcibios_assign_all_busses' [-Werror=implicit-function-declaration]
 1298 |         if ((secondary || subordinate) &&
!pcibios_assign_all_busses() &&
      |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/pci/setup-res.c: In function '__pci_assign_resource':
drivers/pci/setup-res.c:257:46: error: 'PCIBIOS_MIN_IO' undeclared
(first use in this function)
  257 |         min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO :
PCIBIOS_MIN_MEM;
      |                                              ^~~~~~~~~~~~~~
drivers/pci/setup-res.c:257:46: note: each undeclared identifier is
reported only once for each function it appears in
drivers/pci/setup-res.c:257:63: error: 'PCIBIOS_MIN_MEM' undeclared
(first use in this function)
  257 |         min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO :
PCIBIOS_MIN_MEM;
      |
^~~~~~~~~~~~~~~
drivers/pci/quirks.c: In function 'quirk_isa_dma_hangs':
drivers/pci/quirks.c:252:14: error: 'isa_dma_bridge_buggy' undeclared
(first use in this function)
  252 |         if (!isa_dma_bridge_buggy) {
      |              ^~~~~~~~~~~~~~~~~~~~

I think you accidentally dropped the asm/pci.h header, so adding that one back
should make it build again.


lib/test_printf.c:215: warning: "PTR" redefined
  215 | #define PTR ((void *)0xffff0123456789abUL)
      |
In file included from /git/arm-soc/arch/loongarch/include/asm/vdso/vdso.h:9,
                 from
/git/arm-soc/arch/loongarch/include/asm/vdso/gettimeofday.h:13,
                 from /git/arm-soc/include/vdso/datapage.h:137,
                 from /git/arm-soc/arch/loongarch/include/asm/vdso.h:11,
                 from /git/arm-soc/arch/loongarch/include/asm/elf.h:13,
                 from /git/arm-soc/include/linux/elf.h:6,
                 from /git/arm-soc/include/linux/module.h:19,
                 from /git/arm-soc/lib/test_printf.c:10:
/git/arm-soc/arch/loongarch/include/asm/asm.h:182: note: this is the
location of the previous definition
  182 | #define PTR             .dword
      |

Not sure what the best fix is for this, maybe the contents of asm/asm.h could
just be hidden in an "#idef __ASSEMBLER__" check. This can be a follow-up
patch when the branch is merged.

        Arnd
