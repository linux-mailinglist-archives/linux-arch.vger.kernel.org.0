Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB7B577D66
	for <lists+linux-arch@lfdr.de>; Mon, 18 Jul 2022 10:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiGRIW3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Jul 2022 04:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiGRIW1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Jul 2022 04:22:27 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1623F1900B;
        Mon, 18 Jul 2022 01:22:27 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id r12so8265037qvm.3;
        Mon, 18 Jul 2022 01:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQibuB+HRd3lrCPdCHjd5Kptvz7t3wE5RCUTUbzpTH8=;
        b=NlrPf2Ceni4K+B8ZD1iIzmYW1ljlu/GQcpa6Y3gFvAEaIHCjBYn7M1oR+PFH5bcPDa
         xSib4vCYKrPj8UNxVwnSTIZLLYk8loGs2ZBxMfYJtNSXFdIe4X/Sxh3hn1PzosQfelLr
         4wqLNYa48Teo2Ki0Ds2Arv7Uod1adopX4O2hf7Q0Ci4L3i89RJFrb6eos3ll9FZFx3xO
         t810/hkl9gCfwNzHJ/wIZei+4U7dWLRdx4MtO9mwAT0v9v9rZUI44l+3T3Dl2826C4Fz
         xuUDf0xaTlhz577ronNrkv0PjQI5nrIANMbO06qX95a6vdMVFA9OEcafXDJXUBd/iLHo
         KpQw==
X-Gm-Message-State: AJIora8fB2I1YbexVYBV1YUtiOStH48WSbMTLrE4T9Pb4rNRowUrHP9Y
        OaMI8kEuTELK8B7yeXr32Ss3i+NbJv68vA==
X-Google-Smtp-Source: AGRyM1v0AfWpISYzwGkWUx12otwWQtC3/XMcNcCr45toH8/q0KPo9Daexw3wlSCj/xaFjYR96YafYQ==
X-Received: by 2002:a05:6214:2aa1:b0:473:2cc2:63e with SMTP id js1-20020a0562142aa100b004732cc2063emr20457565qvb.26.1658132546301;
        Mon, 18 Jul 2022 01:22:26 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id bk34-20020a05620a1a2200b006af1f0af045sm10390047qkb.107.2022.07.18.01.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 01:22:26 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31bf3656517so98859317b3.12;
        Mon, 18 Jul 2022 01:22:25 -0700 (PDT)
X-Received: by 2002:a81:5404:0:b0:31c:c24d:94b0 with SMTP id
 i4-20020a815404000000b0031cc24d94b0mr28386378ywb.502.1658132545091; Mon, 18
 Jul 2022 01:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220718004114.3925745-1-shorne@gmail.com> <20220718004114.3925745-2-shorne@gmail.com>
In-Reply-To: <20220718004114.3925745-2-shorne@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Jul 2022 10:22:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVP=1ovo62oXaOXT4ipA9Qb61XQ1e4XVVi1gEi+s+wtTQ@mail.gmail.com>
Message-ID: <CAMuHMdVP=1ovo62oXaOXT4ipA9Qb61XQ1e4XVVi1gEi+s+wtTQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] asm-generic: Remove pci.h copying remaining code
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
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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

On Mon, Jul 18, 2022 at 2:41 AM Stafford Horne <shorne@gmail.com> wrote:
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
> ---
> Since v2:
>  - Remove pci_get_legacy_ide_irq in m68k
> Since v1:
>  - Remove pci_get_legacy_ide_irq for most architectures as its not needed.

>  arch/m68k/include/asm/pci.h    |  2 --

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
