Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011CE57758A
	for <lists+linux-arch@lfdr.de>; Sun, 17 Jul 2022 11:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiGQJXn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Jul 2022 05:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiGQJXk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Jul 2022 05:23:40 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E30B60F2;
        Sun, 17 Jul 2022 02:23:38 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id v5so6821805qvq.8;
        Sun, 17 Jul 2022 02:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wc3nIaC4TGrabTRR6ZU1E+ucBztRvo43HV92KBQYbRU=;
        b=h2MAkKSs+RER3S36NySpEgdWBqDUEDTz8bcQ3yyLDR6Mrmw2+Fh7a+TC+ahsak+4q5
         9sXmPJzF8eR0KLnEreWzymlfzzK5FkflQHr1nwHh7zDZSGyxnOFDPxnLFrQy2nbHb7eb
         wqSBqNa6d5oQ1mgZthLmewje9QqK0iCige/y9zvGnDhZ16INcP37ECIFXUiESQpT77IE
         N/2vUvzLd15UY8YXPI33lxyjHcxYPmSrxmNvLJUPSjC7JrTi9HupvruIG0OmNXPivBH+
         7kF2ZQojOu7aDcDdW5hAfoiQ3qr4i9QcM8duxpzc/6pNNMabTZq9yKjEgy6c0r9I4s90
         D0YQ==
X-Gm-Message-State: AJIora9BgCzHI/FCYpKBJch9JLBgAtfrtHu8WaPNTRBecZQQmVWDO/yW
        BkTMqXvKHDtgwvAqS4gMe5dDKfNnHJmeQg==
X-Google-Smtp-Source: AGRyM1t51WwmhbtfyGxOcmUWrsVBMYC6D23aukovVLV8+WYPG9Sdoc3xGe3oxOfFLfpjT3lZBM60Uw==
X-Received: by 2002:a05:6214:509c:b0:473:4d8b:1ffa with SMTP id kk28-20020a056214509c00b004734d8b1ffamr17310401qvb.125.1658049817451;
        Sun, 17 Jul 2022 02:23:37 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id ay31-20020a05620a179f00b006b5de51ec1asm3022771qkb.26.2022.07.17.02.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 02:23:36 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-31c8a1e9e33so82581587b3.5;
        Sun, 17 Jul 2022 02:23:35 -0700 (PDT)
X-Received: by 2002:a81:af27:0:b0:31c:833f:eda5 with SMTP id
 n39-20020a81af27000000b0031c833feda5mr24448251ywh.358.1658049815479; Sun, 17
 Jul 2022 02:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220717033453.2896843-1-shorne@gmail.com> <20220717033453.2896843-2-shorne@gmail.com>
In-Reply-To: <20220717033453.2896843-2-shorne@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 17 Jul 2022 11:23:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUT6nEft8v30sq0WP49RW2qUn+1sunk+ow2_EEyVEieEQ@mail.gmail.com>
Message-ID: <CAMuHMdUT6nEft8v30sq0WP49RW2qUn+1sunk+ow2_EEyVEieEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] asm-generic: Remove pci.h copying remaining code
 to x86
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Child <nick.child@ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Stafford,

On Sun, Jul 17, 2022 at 5:35 AM Stafford Horne <shorne@gmail.com> wrote:
> The generic pci.h header now only provides a definition of
> pci_get_legacy_ide_irq which is used by architectures that support PNP.
> Of the architectures that use asm-generic/pci.h this is only x86.
>
> This patch removes the old pci.h in order to make room for a new
> pci.h to be used by arm64, riscv, openrisc, etc.
>
> The existing code in pci.h is moved out to x86.  On other architectures
> we clean up any outstanding references.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Thanks for your patch!

> --- a/arch/m68k/include/asm/pci.h
> +++ b/arch/m68k/include/asm/pci.h
> @@ -2,11 +2,14 @@
>  #ifndef _ASM_M68K_PCI_H
>  #define _ASM_M68K_PCI_H
>
> -#include <asm-generic/pci.h>
> -
>  #define        pcibios_assign_all_busses()     1
>
>  #define        PCIBIOS_MIN_IO          0x00000100
>  #define        PCIBIOS_MIN_MEM         0x02000000
>
> +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> +{
> +       return channel ? 15 : 14;
> +}
> +

I thought you were not going to add this?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
