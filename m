Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5F457592A
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jul 2022 03:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiGOBp3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Jul 2022 21:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiGOBp3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jul 2022 21:45:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2620B66B9D;
        Thu, 14 Jul 2022 18:45:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eq6so4553061edb.6;
        Thu, 14 Jul 2022 18:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKJrgib6NlReGRP7CDPUE/smLyqBXa9C7wMlxNQsBTA=;
        b=qReu0qeW9uesDP35O40Ak1r8idK4O9CgbEfPz8c7sbqOOC4g19rgOwc7Y7Nf0cMJve
         VHwud/zZzm5annCADY978tvLQA29IgL5uKARrzb7nA7Kp/u9ohAHU/Uoc3laFfeyFv82
         3NvE6Fr+IPR9MFSUs+KYaXTLE4npBFJ2Vcj4F42Mz6qv3HaC4MCx+ag8MrpcmkWW+LoD
         A8pexKC8qY5puSe0QuRx1/diSs17MAvOjpvCEI7jRLHU+cirQYK6oQpe7bjOxKMCXwV4
         h3T37BG2LAfhfJKirkYm4c6biwPu6itaR0LZe1EIroqmoe0m+x1vrKsTKeSrtgYQAI2e
         A1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKJrgib6NlReGRP7CDPUE/smLyqBXa9C7wMlxNQsBTA=;
        b=y/rNgtKdqONzYgZaynfAvSnG4QZIXNm9lCZymPmFherFVHpz8+0tjD0JLqpWJ94Hf4
         KyDEXeeGuiuWA1vota9nhamiIL41axLp4ZbRjXovZgvWUwWBheBYdASdIQS4/u2xZlrr
         YY5jBj9dkdIQ/R+nV4dJP7Pb7tAOhQfUdW+YV1sQo9rZ6OOZ3KkNElBgftY8GMe0IfXo
         qfWm2+WDl9hDDAaHMBe98A08/oTbkb+fX6Lsy7c/Xpju2ez1Oz0s2mq4sfEp+/DdSoBV
         DEfXM3hMZnvRyRO2D0Ml2Xcw+iF8aiHtM2+tr6pYS3hBQGr7rT/KVf56HJ5hFFx4W+fC
         dNGA==
X-Gm-Message-State: AJIora/9Jafnx3KlF3AKPYWGw2VtQhhoBH48FLPTpxtgebCCUmU/G70c
        Bzloghaoax6RmtS7iL/SJFsCls85lMtukgPuS54=
X-Google-Smtp-Source: AGRyM1tepyPfDbQ4UhlRvunVyrzw1+yZr5IvnNlxW7Dt+XzNG9dCJyVfB1/RFmHMmXMFxtwby6G/IhCp+VsAA17XQ40=
X-Received: by 2002:a05:6402:2714:b0:43a:c8ff:e319 with SMTP id
 y20-20020a056402271400b0043ac8ffe319mr16158414edd.33.1657849526605; Thu, 14
 Jul 2022 18:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220714214657.2402250-1-shorne@gmail.com> <20220714214657.2402250-2-shorne@gmail.com>
In-Reply-To: <20220714214657.2402250-2-shorne@gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 14 Jul 2022 18:45:27 -0700
Message-ID: <CAMo8BfKkGRHiFq1vu1ZKkURkUqC+Ee7D42yuKrCeDF+578s9cw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] asm-generic: Remove pci.h copying code out to architectures
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
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
        "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
        "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, linux-pci@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 14, 2022 at 2:47 PM Stafford Horne <shorne@gmail.com> wrote:
>
> The generic pci.h header provides a definition of pci_get_legacy_ide_irq
> which is used by architectures that use PC-style interrupt numbers.
>
> This patch removes the old pci.h in order to make room for a new
> pci.h to be used by arm64, riscv, openrisc, etc.
>
> The existing code in pci.h is moved out to architectures.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/alpha/include/asm/pci.h   |  1 -
>  arch/ia64/include/asm/pci.h    |  1 -
>  arch/m68k/include/asm/pci.h    |  7 +++++--
>  arch/powerpc/include/asm/pci.h |  1 -
>  arch/s390/include/asm/pci.h    |  6 +++++-
>  arch/sparc/include/asm/pci.h   |  5 ++++-
>  arch/x86/include/asm/pci.h     |  6 ++++--
>  arch/xtensa/include/asm/pci.h  |  6 ++++--
>  include/asm-generic/pci.h      | 17 -----------------
>  9 files changed, 22 insertions(+), 28 deletions(-)
>  delete mode 100644 include/asm-generic/pci.h

[...]

> diff --git a/arch/xtensa/include/asm/pci.h b/arch/xtensa/include/asm/pci.h
> index 8e2b48a268db..f57ede61f5db 100644
> --- a/arch/xtensa/include/asm/pci.h
> +++ b/arch/xtensa/include/asm/pci.h
> @@ -43,7 +43,9 @@
>  #define ARCH_GENERIC_PCI_MMAP_RESOURCE 1
>  #define arch_can_pci_mmap_io()         1
>
> -/* Generic PCI */
> -#include <asm-generic/pci.h>

Ok.

> +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> +{
> +       return channel ? 15 : 14;
> +}

This addition does not make sense for the xtensa as it isn't even possible
to enable PNP support (the only user of this function) on xtensa.

-- 
Thanks.
-- Max
