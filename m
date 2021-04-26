Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E61936B72F
	for <lists+linux-arch@lfdr.de>; Mon, 26 Apr 2021 18:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhDZQrN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 12:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbhDZQrM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Apr 2021 12:47:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EC5C061756
        for <linux-arch@vger.kernel.org>; Mon, 26 Apr 2021 09:46:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u3so6749936eja.12
        for <linux-arch@vger.kernel.org>; Mon, 26 Apr 2021 09:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+cgDeAfZzzmuCTTq4lC5PvZ1hvbfvFcMRWuLEIgDNM=;
        b=lkECTZxtYGXafDLJP7gcUe64u+wM11kk0hx2AVgnxCgsxjNdrKGXelp0XWzjzW8BaV
         NiJWu26mb53eN/c3AjVrdTyjhbQU8SVvQGEaZCWuaB0IHie1Y7FC+5jurVJIviX0HYt7
         D8mdWbMEF8cqs3fPeUQ0ilHqkrRBSevyC7rL61Gj6Yq7Qbklr7m2UtnK0I9TlbXKbCpy
         /cbvn1TLcOxrOFC+bWhLc1IUWFFowNWOTpHL92+8AGzgtTvS3Yvx+imkFtEHDCFsQ6lw
         UERhY0vkTjn13WVfN9A2gBJi9+S7DnXOeFKWv2rK3LenyunLxtbckBK0Sej49btV/Rm0
         7Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+cgDeAfZzzmuCTTq4lC5PvZ1hvbfvFcMRWuLEIgDNM=;
        b=HT5TpnxzcSlnXHduRksTRASA58k15Se79PnpLqMpMUZGSfVghUtsTw1kBk3FvikkTD
         ME7UEB5ECRb2WfaORFqqlXSQtGIedNNfKtp+l0sbvoBJcMEBvAZ00rq6z87LcfrC4TXY
         ML4cysTNXc+lfxokSFOupKWt4UtNsmKIyhPyr7Na1vsCvAgdzmBcKdEkANubjmLYP1QM
         zUWazazM8hKXZIFeB4+IaIxJPFQCw8VO+P+9Oc0E/wooH3VEpmyJuw9ZgSy7k3fFsH1K
         gCMZS2xCTpkvo1ZrfwQGG2D9INcBe52FtukiG9wg5SJtHTxtHn9GFunUpSNbSSRTP7mP
         j8Zw==
X-Gm-Message-State: AOAM530x7ETb4FXy9ZsTKFZYh7cE0BcyJcz1p4ddQpBXTV3IJ3/3AOcj
        +/mLOlu3JFuzylbDRaXk/35DsLcSnmnK+d1XJzEvpA==
X-Google-Smtp-Source: ABdhPJws/y0oULVP57G4/mhkzRlFFYXwQtjXS/r9gsn/T4CCZJ9e2nplrFWa9TdmZd0Bs4ayfImWcKyFyY4sxmAp7k0=
X-Received: by 2002:a17:906:688e:: with SMTP id n14mr8886230ejr.375.1619455587957;
 Mon, 26 Apr 2021 09:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAM4kBBJChiqkarKwn3roe+BLotsGDptfmYKKDxE45AnFZNUoPw@mail.gmail.com>
 <mhng-08bcf932-3a06-43cf-b0b0-9614d09aa17d@palmerdabbelt-glaptop>
In-Reply-To: <mhng-08bcf932-3a06-43cf-b0b0-9614d09aa17d@palmerdabbelt-glaptop>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 26 Apr 2021 22:16:16 +0530
Message-ID: <CA+G9fYv4y+n6PoYf1jOPZbjPxY7rTi+Ajc89zsNzTS0_uL+RJw@mail.gmail.com>
Subject: Re: [PATCH v8] RISC-V: enable XIP
To:     Palmer Dabbelt <palmer@dabbelt.com>, alex@ghiti.fr,
        vitaly.wool@konsulko.com
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

my two cents,

The riscv build failed on Linux -next 20210426 tag kernel due to
below warnings / errors.
Following builds failed.
 - riscv (tinyconfig) with gcc-8
 - riscv (allnoconfig) with gcc-8
 - riscv (tinyconfig) with gcc-9
 - riscv (allnoconfig) with gcc-9
 - riscv (tinyconfig) with gcc-10
 - riscv (allnoconfig) with gcc-10

> >> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> >> > index 30e4af0fd50c..2ddf654c72bb 100644
> >> > --- a/arch/riscv/kernel/setup.c
> >> > +++ b/arch/riscv/kernel/setup.c
> >> > @@ -50,7 +50,11 @@ struct screen_info screen_info __section(".data") = {
> >> >   * This is used before the kernel initializes the BSS so it can't be in the
> >> >   * BSS.
> >> >   */
> >> > -atomic_t hart_lottery __section(".sdata");
> >> > +atomic_t hart_lottery __section(".sdata")
> >> > +#ifdef CONFIG_XIP_KERNEL
> >> > += ATOMIC_INIT(0xC001BEEF)
> >> > +#endif
> >> > +;
> >> >  unsigned long boot_cpu_hartid;
> >> >  static DEFINE_PER_CPU(struct cpu, cpu_devices);
> >> >
> >> > @@ -254,7 +258,7 @@ void __init setup_arch(char **cmdline_p)
> >> >  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
> >> >       unflatten_and_copy_device_tree();
> >> >  #else
> >> > -     if (early_init_dt_verify(__va(dtb_early_pa)))
> >> > +     if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))

arch/riscv/kernel/setup.c: In function 'setup_arch':
arch/riscv/kernel/setup.c:284:32: error: implicit declaration of
function 'XIP_FIXUP' [-Werror=implicit-function-declaration]
  if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
                                ^~~~~~~~~
arch/riscv/include/asm/page.h:112:62: note: in definition of macro
'linear_mapping_pa_to_va'
 #define linear_mapping_pa_to_va(x) ((void *)((unsigned long)(x) +
va_pa_offset))
                                                              ^
arch/riscv/include/asm/page.h:156:27: note: in expansion of macro
'__pa_to_va_nodebug'
 #define __va(x)  ((void *)__pa_to_va_nodebug((phys_addr_t)(x)))
                           ^~~~~~~~~~~~~~~~~~
arch/riscv/kernel/setup.c:284:27: note: in expansion of macro '__va'
  if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
                           ^~~~
cc1: some warnings being treated as errors

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>


steps to reproduce:
---------------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.


tuxmake --runtime podman --target-arch riscv --toolchain gcc-8
--kconfig allnoconfig

--
Linaro LKFT
https://lkft.linaro.org
