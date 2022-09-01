Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DED5A94DC
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 12:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiIAKlg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 06:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiIAKlR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 06:41:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA63BDA3E0;
        Thu,  1 Sep 2022 03:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9563CB823F1;
        Thu,  1 Sep 2022 10:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4127FC43140;
        Thu,  1 Sep 2022 10:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662028844;
        bh=LBa14xoUN0fMhLzLC7wVPDFh9Iet5/+NLV5mMa9mn/o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sPAJY0gVqmkV7XMw/tcX9QW32uvxLniBcF9y2Lb1R3++Jt47suBJWhk3Zkgos6HAi
         0aVIxTO/4iELlWickg+kLbupXAN5gQf403M3WH8C923Wc/C7/wQkKDmmwbIwNkh2Yf
         Hf5+bfMETsCMHE6OOzNY+omspABTzKRWY7oXFFRYTsbUcXr4vP2dGCEWhbcqHFXIYi
         +JBVoVScCsl3WKaNqA3F0aJgIrhmGUuZB1XoI9o2vbSRrr+uSfPjIyp8bRl0rtdjiH
         iPenQcAjSVv6+iiQv4sokE//LOJKE+gsJ2MzVPKVwrfegfKfjxnSDnk6ir6ex1HIcO
         6tZSBcBqUsvxQ==
Received: by mail-vs1-f52.google.com with SMTP id c3so17286381vsc.6;
        Thu, 01 Sep 2022 03:40:44 -0700 (PDT)
X-Gm-Message-State: ACgBeo3ZzaL+h4TQ/B0IsyHFKxgpy6J04KJ6yaEjAGUtlLMLFhuXo2EN
        sA+quoc2j2N/DrCNwftwlm4DEdW6Q7+sbiCKKcE=
X-Google-Smtp-Source: AA6agR7dNMRQwlxYH+D7lL3BtG0CaeaIu0EOhQ46VtPMSzp62FZbuavPop3/iV8rHcRRV0arRmbJashjVsJasIKdqVo=
X-Received: by 2002:a67:df81:0:b0:390:21a3:823a with SMTP id
 x1-20020a67df81000000b0039021a3823amr8091257vsk.70.1662028843133; Thu, 01 Sep
 2022 03:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220819102037.2697798-1-chenhuacai@loongson.cn>
 <9b6f0aeaebbd36882b5b40d655f9ccd20c7be496.camel@xry111.site> <CAMj1kXFOd+gMHbi6MH0KHWkBEKN9V0LeZbyGRw8h630OxtMrdA@mail.gmail.com>
In-Reply-To: <CAMj1kXFOd+gMHbi6MH0KHWkBEKN9V0LeZbyGRw8h630OxtMrdA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 1 Sep 2022 18:40:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6MR=rWhecY_uuiXAysED-BBJhKhGHj2cCkefJiPOo-ZQ@mail.gmail.com>
Message-ID: <CAAhV-H6MR=rWhecY_uuiXAysED-BBJhKhGHj2cCkefJiPOo-ZQ@mail.gmail.com>
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

On Sat, Aug 27, 2022 at 3:14 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sat, 27 Aug 2022 at 06:41, Xi Ruoyao <xry111@xry111.site> wrote:
> >
> > Tested V3 with the magic number check manually removed in my GRUB build.
> > The system boots successfully.  I've not tested Arnd's zBoot patch yet.
>
> I am Ard not Arnd :-)
>
> Please use this branch when testing the EFI decompressor:
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-decompressor-v4
The root cause of LoongArch zboot boot failure has been found, it is a
binutils bug, latest toolchain with the below patch can solve the
problem.

diff --git a/bfd/elfnn-loongarch.c b/bfd/elfnn-loongarch.c
index 5b44901b9e0..fafdc7c7458 100644
--- a/bfd/elfnn-loongarch.c
+++ b/bfd/elfnn-loongarch.c
@@ -2341,9 +2341,10 @@ loongarch_elf_relocate_section (bfd
*output_bfd, struct bfd_link_info *info,
     case R_LARCH_SOP_PUSH_PLT_PCREL:
       unresolved_reloc = false;

-      if (resolved_to_const)
+      if (!is_undefweak && resolved_to_const)
         {
           relocation += rel->r_addend;
+          relocation -= pc;
           break;
         }
       else if (is_undefweak)


Huacai
