Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697555AC47C
	for <lists+linux-arch@lfdr.de>; Sun,  4 Sep 2022 15:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiIDNY7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Sep 2022 09:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIDNY6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Sep 2022 09:24:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8061E3E2;
        Sun,  4 Sep 2022 06:24:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 00DD3CE0EA9;
        Sun,  4 Sep 2022 13:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5CFC4347C;
        Sun,  4 Sep 2022 13:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662297893;
        bh=rl6fLZU0cQ0lmq75jhbnr25T1XXEIy5vIoogxAgbYxk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SmYl2hECZR3wKwP+FMP1Gd8wTuF9lZuvDfmmxHZg94srIxB3nUdZUAKqkh7F+0bTa
         CKO2jUfuZg8Y0U5tNgIK6sZ0H9rDqwAe2kZVpJygXouICSger77vb4WHfYTNcJng83
         7ewP7a5EHhWyoyf985PhLtLWyec5WSYKsR9K8BY5RuOI42dw1qj3CTLLCQpj/ooNiN
         ZARzUJSFT8eLRxfHn8XqiGkAFtXpF5cnMfCZQGvCqctNVAM5sevqlPi3dvNlwZLpIf
         j+wzJG+lP7APtAYKInLayW+1mxccmxwJNJHaOqSyeVJmJP5EAPLUX68tAnpMhS8jsx
         qaWk6BZxazCnQ==
Received: by mail-ua1-f46.google.com with SMTP id s5so2474523uar.1;
        Sun, 04 Sep 2022 06:24:53 -0700 (PDT)
X-Gm-Message-State: ACgBeo10yMjmzWVL7VjnvcS2y7lL7BYN9eTS3fTn/akhxzFShTpe14iF
        LxaXIqu2DG6mYHCA58ZXqbH2G65oPyM5n31k6bw=
X-Google-Smtp-Source: AA6agR5Y4uVz9cAZw9EOYYNKxQt74TW6VgX0gb/I4EmRjuSpKKxu15vMq4u5YFoTjUSdQWo9wYv1viWPPTHI6+gP+sk=
X-Received: by 2002:a05:6130:c13:b0:39f:58bb:d51c with SMTP id
 cg19-20020a0561300c1300b0039f58bbd51cmr13564275uab.104.1662297892187; Sun, 04
 Sep 2022 06:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220819102037.2697798-1-chenhuacai@loongson.cn>
 <9b6f0aeaebbd36882b5b40d655f9ccd20c7be496.camel@xry111.site>
 <CAMj1kXFOd+gMHbi6MH0KHWkBEKN9V0LeZbyGRw8h630OxtMrdA@mail.gmail.com> <CAAhV-H6MR=rWhecY_uuiXAysED-BBJhKhGHj2cCkefJiPOo-ZQ@mail.gmail.com>
In-Reply-To: <CAAhV-H6MR=rWhecY_uuiXAysED-BBJhKhGHj2cCkefJiPOo-ZQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 4 Sep 2022 21:24:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4KXVUBgNoQxOFiEj2AH-ojhnrEJ8QLvNrALY69MhXF3w@mail.gmail.com>
Message-ID: <CAAhV-H4KXVUBgNoQxOFiEj2AH-ojhnrEJ8QLvNrALY69MhXF3w@mail.gmail.com>
Subject: Re: [PATCH V3] LoongArch: Add efistub booting support
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ard,

On Thu, Sep 1, 2022 at 6:40 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Ard,
>
> On Sat, Aug 27, 2022 at 3:14 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Sat, 27 Aug 2022 at 06:41, Xi Ruoyao <xry111@xry111.site> wrote:
> > >
> > > Tested V3 with the magic number check manually removed in my GRUB build.
> > > The system boots successfully.  I've not tested Arnd's zBoot patch yet.
> >
> > I am Ard not Arnd :-)
> >
> > Please use this branch when testing the EFI decompressor:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-decompressor-v4
> The root cause of LoongArch zboot boot failure has been found, it is a
> binutils bug, latest toolchain with the below patch can solve the
> problem.
>
> diff --git a/bfd/elfnn-loongarch.c b/bfd/elfnn-loongarch.c
> index 5b44901b9e0..fafdc7c7458 100644
> --- a/bfd/elfnn-loongarch.c
> +++ b/bfd/elfnn-loongarch.c
> @@ -2341,9 +2341,10 @@ loongarch_elf_relocate_section (bfd
> *output_bfd, struct bfd_link_info *info,
>      case R_LARCH_SOP_PUSH_PLT_PCREL:
>        unresolved_reloc = false;
>
> -      if (resolved_to_const)
> +      if (!is_undefweak && resolved_to_const)
>          {
>            relocation += rel->r_addend;
> +          relocation -= pc;
>            break;
>          }
>        else if (is_undefweak)
>
>
> Huacai
Now the patch is submitted here:
https://sourceware.org/pipermail/binutils/2022-September/122713.html

And I have some other questions about kexec: kexec should jump to the
elf entry or the pe entry? I think is the elf entry, because if we
jump to the pe entry, then SVAM will be executed twice (but it should
be executed only once). However, how can we jump to the elf entry if
we use zboot? Maybe it is kexec-tool's responsibility to decompress
the zboot kernel image?

Huacai
