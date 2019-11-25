Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8D3109551
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2019 23:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfKYWAr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Nov 2019 17:00:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36242 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYWAq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 17:00:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so20027736wru.3
        for <linux-arch@vger.kernel.org>; Mon, 25 Nov 2019 14:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pK6K8psgHbpF1pg13+lNb6hLePrayQO5yUnaw8JPsNk=;
        b=CPp6YgKBPDRSzCp+2zR0Axg8HSMv3Gyy3VKemypTsBfcFXTTJV0Stsy40n7TfuSteb
         DZmqtuhOEsAzojncjeS4acrMyXQF+gbH2muS3CLcahuoTJDyTbzvqeXGKUCqrMHSRDeN
         KJ09CPYtdhSTfK8MClRYTppzP3KAahyvlYcicN0JCiRnhVnodAKovg6UDuHjcKMUCwu1
         EwatxWhHlNNAZlkpFHH7nXXLQXU69wk1qp4hSNC2EZ7gnPWZbhqAfRbcaoixkUHTsm0N
         TyBnHzI2y+cPZ1WnhFYJ57HSxj23ezTR6eY5JOEtr9T9FDmWauCSKMvVQKW2IX6Y92n4
         3B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pK6K8psgHbpF1pg13+lNb6hLePrayQO5yUnaw8JPsNk=;
        b=Q5DOO5pRLViEGO+OrolgkSRxN4vgII9Ogxw59VB40Ax02yxqBF8ceaAQXmAClUPoZI
         X60Vfx4muI6wA6FSm12suODVsKm2n29rKJu2/oVeU/ZqzU4YNE2178E+qHXwEIIro8/Q
         1h1ESUlE/F4kg6E1E8sw6JJQsrLBohsIiuWW3jQlBP+CVwUPLHb/DtKfnWLNQjopyIWi
         HRmbfmkMB1oeQRSybX7YVqkvs0MIAte9lNYCBQqoU1Op6QpT8dFPLO7l9uSim2rM/paK
         b6O49yYenyg+srne6+L8AABCEg0WS6LsB27zVVT/1yQ8WaVpUietMfal+s3eBYtU8Zyn
         mxwA==
X-Gm-Message-State: APjAAAUIiFVDLbMR0hOa2GgNzrJI04fTIK4jw0mTcEdZozBOUSkHiNGl
        IsD9BkJSTw880l1J7aQA2hDogGqFS+jSdz0LEsY=
X-Google-Smtp-Source: APXvYqwSHNXL4y7qfBAV5NDOFC2UjF0y2EvaPOzdDhmZcp8BgX39ca5HaUjb1lE9A3RaUdQTMbR41zf7pBKtuPaj2w4=
X-Received: by 2002:adf:c449:: with SMTP id a9mr32809537wrg.240.1574719244216;
 Mon, 25 Nov 2019 14:00:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com> <64a5d6c94d331058331af7d191d2cdbe870d009b.1573179553.git.thehajime@gmail.com>
In-Reply-To: <64a5d6c94d331058331af7d191d2cdbe870d009b.1573179553.git.thehajime@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 25 Nov 2019 23:00:33 +0100
Message-ID: <CAFLxGvw+w+xmput3xMjKPXPn4hj9opbo+gtV6896hhzDUzQNiA@mail.gmail.com>
Subject: Re: [RFC v2 03/37] lkl: architecture skeleton for Linux kernel library
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Patrick Collins <pscollins@google.com>,
        Levente Kurusa <levex@linux.com>,
        Matthieu Coudron <mattator@gmail.com>,
        Conrad Meyer <cem@freebsd.org>,
        Octavian Purdila <tavi.purdila@gmail.com>,
        Jens Staal <staal1978@gmail.com>,
        Motomu Utsumi <motomuman@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        Petros Angelatos <petrosagg@gmail.com>,
        Yuan Liu <liuyuan@google.com>, Xiao Jia <xiaoj@google.com>,
        Mark Stillwell <mark@stillwell.me>,
        linux-kernel-library@freelists.org,
        Pierre-Hugues Husson <phh@phh.me>,
        Michael Zimmermann <sigmaepsilon92@gmail.com>,
        Luca Dariz <luca.dariz@gmail.com>,
        "Edison M . Castro" <edisonmcastro@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> Adds the LKL Kconfig, vmlinux linker script, basic architecture
> headers and miscellaneous basic functions or stubs such as
> dump_stack(), show_regs() and cpuinfo proc ops.
>
> The headers we introduce in this patch are simple wrappers to the
> asm-generic headers or stubs for things we don't support, such as
> ptrace, DMA, signals, ELF handling and low level processor operations.
>
> The kernel configuration is automatically updated to reflect the
> endianness of the host, 64bit support or the output format for
> vmlinux's linker script. We do this by looking at the ld's default
> output format.
>
> Signed-off-by: Andreas Abel <aabel@google.com>
> Signed-off-by: Conrad Meyer <cem@FreeBSD.org>
> Signed-off-by: Edison M. Castro <edisonmcastro@hotmail.com>
> Signed-off-by: H.K. Jerry Chu <hkchu@google.com>
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Jens Staal <staal1978@gmail.com>
> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Levente Kurusa <levex@linux.com>
> Signed-off-by: Luca Dariz <luca.dariz@gmail.com>
> Signed-off-by: Mark Stillwell <mark@stillwell.me>
> Signed-off-by: Matthieu Coudron <mattator@gmail.com>
> Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
> Signed-off-by: Motomu Utsumi <motomuman@gmail.com>
> Signed-off-by: Patrick Collins <pscollins@google.com>
> Signed-off-by: Petros Angelatos <petrosagg@gmail.com>
> Signed-off-by: Pierre-Hugues Husson <phh@phh.me>
> Signed-off-by: Xiao Jia <xiaoj@google.com>
> Signed-off-by: Yuan Liu <liuyuan@google.com>
> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>

Can we please have this chain cleaned up?
Please see process/submitting-patches.rst.

> ---
>  MAINTAINERS                                |   8 +
>  arch/um/lkl/.gitignore                     |   2 +
>  arch/um/lkl/Kconfig                        |  95 ++++++
>  arch/um/lkl/Kconfig.debug                  |   0
>  arch/um/lkl/configs/lkl_defconfig          |  91 ++++++
>  arch/um/lkl/include/asm/Kbuild             |  80 +++++
>  arch/um/lkl/include/asm/bitsperlong.h      |  11 +
>  arch/um/lkl/include/asm/byteorder.h        |   7 +
>  arch/um/lkl/include/asm/cpu.h              |  14 +
>  arch/um/lkl/include/asm/elf.h              |  15 +
>  arch/um/lkl/include/asm/mutex.h            |   7 +
>  arch/um/lkl/include/asm/processor.h        |  60 ++++
>  arch/um/lkl/include/asm/ptrace.h           |  25 ++
>  arch/um/lkl/include/asm/sched.h            |  23 ++
>  arch/um/lkl/include/asm/syscalls.h         |  18 ++
>  arch/um/lkl/include/asm/syscalls_32.h      |  43 +++
>  arch/um/lkl/include/asm/tlb.h              |  12 +
>  arch/um/lkl/include/asm/uaccess.h          |  64 ++++
>  arch/um/lkl/include/asm/unistd_32.h        |  31 ++
>  arch/um/lkl/include/asm/vmlinux.lds.h      |  14 +
>  arch/um/lkl/include/asm/xor.h              |   9 +
>  arch/um/lkl/include/uapi/asm/Kbuild        |   9 +
>  arch/um/lkl/include/uapi/asm/bitsperlong.h |  13 +
>  arch/um/lkl/include/uapi/asm/byteorder.h   |  11 +
>  arch/um/lkl/include/uapi/asm/siginfo.h     |  11 +
>  arch/um/lkl/include/uapi/asm/swab.h        |  11 +
>  arch/um/lkl/include/uapi/asm/syscalls.h    | 348 +++++++++++++++++++++

I think this is the first big thing which needs a unification.

In UML we try hard to re-use headers from x86.
We also have some headers in arch/x86/um/.

LKL should do the same. At least try hard to avoid duplication.

-- 
Thanks,
//richard
