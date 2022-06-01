Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D79F539A72
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 02:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348416AbiFAAlu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 May 2022 20:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiFAAlt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2022 20:41:49 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B540D110B;
        Tue, 31 May 2022 17:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1654044103; bh=gAA/T6RmFtJ8e1KmZkGo7oW84DFSEfMlvKn6/ylyuf0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uhjVYNRyqBoD6KwGoMOam9BA2X3FFe4lh4HVCU56n5uxcuDR8qAjGPmL87LsIT0Qc
         W0+AUC8UNdzT31FvW+2zBxeC7+eJTsyV/VHrypPQhnc3qNSc+ORdo/bR0vVYuNYh4j
         0CK2jp+rnLLoUsef2u6AaRh9KuelLXGg/BK8K9cI=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id B8D83600FF;
        Wed,  1 Jun 2022 08:41:42 +0800 (CST)
Message-ID: <1dbaed5d-fb83-be70-85fc-4b819fa7d47c@xen0n.name>
Date:   Wed, 1 Jun 2022 08:41:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: [musl] Re: [GIT PULL] asm-generic changes for 5.19
To:     Arnd Bergmann <arnd@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
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
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
 <df5c406c-eec6-c340-2847-49670b7fe8bf@xen0n.name>
 <CAK8P3a3awFdB1-G65DC38NBuSTvo6SvFTaS0m9YBxunHjHjQvQ@mail.gmail.com>
 <CAAhV-H6sNr-yo8brBFtzziH6k9Tby0dFp7yehK55SfH5HjZ8hQ@mail.gmail.com>
 <358025d1-28e6-708b-d23d-3f22ae12a800@xen0n.name>
 <CAK8P3a1ge2bZS13ahm_LdO3jEcbtR4w3do-gLjggKvppqnBDkw@mail.gmail.com>
 <CAAhV-H5NCUpR6aBtR9d7c9vW2KiHpk3iFQxj7BeTSS0boMz8PQ@mail.gmail.com>
 <CAK8P3a2JgrW5a7_udCUWen-gOnJgVeRV2oAd-uq4VSuYkFUqNQ@mail.gmail.com>
 <CAAhV-H6wfmdcV=a4L43dcabsvO+JbOebCX3_6PV+p85NjA9qhQ@mail.gmail.com>
 <CAK8P3a0c_tbHov_b6cz-_Tj6VD3OWLwpGJf_2rj-nitipSKdYQ@mail.gmail.com>
 <CAAhV-H4_qqQtTp2=mJF=OV+qcKzA0j8SPWKRMR-LJgC0zNfatQ@mail.gmail.com>
 <CAK8P3a3UfDJkoAkA6an2kXyAYSzz2vt__19JoQmum8LZehXrgg@mail.gmail.com>
 <CAK8P3a0tu4ZANdxY-beVb4C1hKrn2VJqpfwBemhqHkr6760b7A@mail.gmail.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAK8P3a0tu4ZANdxY-beVb4C1hKrn2VJqpfwBemhqHkr6760b7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/1/22 04:40, Arnd Bergmann wrote:
> lib/test_printf.c:215: warning: "PTR" redefined
>    215 | #define PTR ((void *)0xffff0123456789abUL)
>        |
> In file included from /git/arm-soc/arch/loongarch/include/asm/vdso/vdso.h:9,
>                   from
> /git/arm-soc/arch/loongarch/include/asm/vdso/gettimeofday.h:13,
>                   from /git/arm-soc/include/vdso/datapage.h:137,
>                   from /git/arm-soc/arch/loongarch/include/asm/vdso.h:11,
>                   from /git/arm-soc/arch/loongarch/include/asm/elf.h:13,
>                   from /git/arm-soc/include/linux/elf.h:6,
>                   from /git/arm-soc/include/linux/module.h:19,
>                   from /git/arm-soc/lib/test_printf.c:10:
> /git/arm-soc/arch/loongarch/include/asm/asm.h:182: note: this is the
> location of the previous definition
>    182 | #define PTR             .dword
>        |
>
> Not sure what the best fix is for this, maybe the contents of asm/asm.h could
> just be hidden in an "#idef __ASSEMBLER__" check. This can be a follow-up
> patch when the branch is merged.

Ah, the dreaded PTR... This has plagued Loongson users since antiquity 
(i.e. the MIPS era).

It must have been the case that the arch/loongarch was based on an 
earlier version of arch/mips, that didn't have the commit fa62f39dc7e25 
("MIPS: Fix build error due to PTR used in more places"). So the fix 
would be simple: just rename the PTR to something else. MIPS changed 
that to PTR_WD and maybe we could re-use that name.

But I agree that wrapping the whole asm/asm.h with an #ifdef 
__ASSEMBLY__ is very reasonable regardless. Maybe both could be done.

