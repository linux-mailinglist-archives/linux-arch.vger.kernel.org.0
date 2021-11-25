Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E45845D896
	for <lists+linux-arch@lfdr.de>; Thu, 25 Nov 2021 12:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbhKYLDJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Nov 2021 06:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354693AbhKYLBH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Nov 2021 06:01:07 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88184C061748;
        Thu, 25 Nov 2021 02:56:54 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id s17so3592360vka.5;
        Thu, 25 Nov 2021 02:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19XxhN1cPhuBovF+Xh4gn1b03Gy0GpCCVXwbXEhLi/Y=;
        b=g4HEKhiSSbHpHj5yFd7PfkOCC7OjRDa51IdTeUlVTfAai66FDIoyoUR79zc+fQdbz8
         tc19wl9pyY+DEs1Xm1MIoS1J4IdjHoGTNF+3mryBMD6ckQs32XzAN1SqwFz9BcnloFXK
         tQUXtmCqgQZDGSKbAfvUMhM8RF1byNDRfaALLRJWWSCiGK4n4ishPhzsVn9InWnUBVeK
         yBatM+MagxOFcS9yfsEcGz7aRivqX2fYTK+L9aHZyHr4H3xhnvnMHBNfruDN1KHILche
         hZJuQHctID1iokGll0VabYZIhGU5u5KwNIwgOHXrT6M4E9/M3Gf0QoediHeCnYvum+Sh
         GRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19XxhN1cPhuBovF+Xh4gn1b03Gy0GpCCVXwbXEhLi/Y=;
        b=gJ447K/qg7wkk3r4eW4zW2h2koXGoCUr5dPCLaaYGopmLGQq5/lUsecqXlxIkxNybH
         pfFhVbBPbltVM/lM0XFhyu3y2M7ARsjUCW7AJiPmY6olhJ8K9JlESGuO5nZK8XkrcHA1
         ZjU/nwgO7YdCvQZlodjINKNA2ocAQ3V6Cu00PDYqV+zF+MjF/THaD7IE388uFajuDHYZ
         0vhlZwHAzYa5ExEOeKPrlD5NxSssdrWBs3kc4kbuke2FEaLXXXfxxeQbLI73l5H/9vQ9
         EAZAY+on/ZHzfjRmPWqBdmzdAdzg2pk7hDWZ1/CU58NNsor6rczWsY0RGZbtCexIf/9M
         uauA==
X-Gm-Message-State: AOAM533F9r9ioZ4NMsaVQQgGXFovf+15/Wd207nGc69scT3P0le+Mt7w
        oP/g09lNaNAazMwOAKDNNXKn1lv2rEvKOGME5qs=
X-Google-Smtp-Source: ABdhPJw08+vO8xvImD361nCgmPTJ+oAFgtqZIP1QpMejp7pxO+ovFtVtHwaNa0Pb3/X68lyALNXkewo6EsgomvUodzo=
X-Received: by 2002:a05:6122:8cf:: with SMTP id 15mr9414800vkg.16.1637837813643;
 Thu, 25 Nov 2021 02:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20210929172234.31620-1-mcroce@linux.microsoft.com> <20210929172234.31620-4-mcroce@linux.microsoft.com>
In-Reply-To: <20210929172234.31620-4-mcroce@linux.microsoft.com>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Thu, 25 Nov 2021 18:56:41 +0800
Message-ID: <CAFiDJ5-OJzWWR0hSZDsuAmxzxTE7cRR9Bsetpfh5vvrTxzkKPw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] riscv: optimized memset
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 30, 2021 at 1:56 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> The generic memset is defined as a byte at time write. This is always
> safe, but it's slower than a 4 byte or even 8 byte write.
>
> Write a generic memset which fills the data one byte at time until the
> destination is aligned, then fills using the largest size allowed,
> and finally fills the remaining data one byte at time.
>
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>  arch/riscv/include/asm/string.h |  10 +--
>  arch/riscv/kernel/Makefile      |   1 -
>  arch/riscv/kernel/riscv_ksyms.c |  13 ----
>  arch/riscv/lib/Makefile         |   1 -
>  arch/riscv/lib/memset.S         | 113 --------------------------------
>  arch/riscv/lib/string.c         |  41 ++++++++++++
>  6 files changed, 44 insertions(+), 135 deletions(-)
>  delete mode 100644 arch/riscv/kernel/riscv_ksyms.c
>  delete mode 100644 arch/riscv/lib/memset.S

This patch causes the Linux kernel to hang if compile with LLVM/Clang.
Tested on Qemu.

Steps to compile with Clang:
make CC=clang  defconfig
make CC=clang -j

Boot log:

[    0.000000] Linux version 5.15.4-01003-g23eeaac40da8 (xxxxx@ubuntu)
(clang version 14.0.0 (https://github.com/llvm/llvm-project
6b715e9c4d9cc00f59906d48cd57f4c767229093), GNU ld (GNU Binutils)
2.36.1) #151 SMP Thu Nov 25 18:41:47 +08 2021
[    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
[    0.000000] Machine model: riscv-virtio,qemu
[    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
[    0.000000] printk: bootconsole [sbi0] enabled
[    0.000000] efi: UEFI not found.

Regards
Ley Foon
