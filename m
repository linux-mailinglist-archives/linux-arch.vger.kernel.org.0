Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E182957FC
	for <lists+linux-arch@lfdr.de>; Thu, 22 Oct 2020 07:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444513AbgJVFiK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Oct 2020 01:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444507AbgJVFiK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Oct 2020 01:38:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC19C0613CE
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2020 22:38:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h7so551065wre.4
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2020 22:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FJ6bgUzNaVY5TwTxhI5fSUYbPLg9JNdup4mEtOxeyg=;
        b=Y9Bl1j6Yr57hSOSVPd/mu8/0LKB/sUaN+4OYq3aFF90Ul5QrtkCiVNH9L8jrUjSMo1
         BOKxsr/7fKRiQpN4kVGgEBqVtWszTvShe7lZdbiv6L+NLtOizZUgujXoZvT2TROyZNLx
         zJdukWtwTTaJzdJoCyxafO4cLJd0w6GUarS9y0hhBoEjh7EAz3ipVzS+BZeksfTcJ5aq
         wnHp4uFAiQq8uwfU3SZkrdpi1ZRZavZERN4yLWk7B//b8QjJsPq+nwqJOB5qXVbbWAae
         FQk9F0x2v9qjKeAsX4OYBfYNubscNVPxafc3jwllMwr2lKF5yAW2F+0L+RR0jcFJ2dTr
         c3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FJ6bgUzNaVY5TwTxhI5fSUYbPLg9JNdup4mEtOxeyg=;
        b=N2nHksD/uqADcPF3MfrDbATRtUyd8JH0cUrOBKFHVsr0CvaK0K9oeeOokA5VsKVlJ5
         cbPtvI/dpEnK8+JREoH5BADUrxl2ooEMU9HJysmmQI6tpnqrY9Ge3G1CCNXHeG11tT/+
         YHK+mkneyrmbNFmEDttviHdKdOtUQLIe4gWYa5RM+c4s1XvagAvL/dWbFVZevaR5DLYN
         xQt/tasBtEV6n3U0r55+vYhYs/38J5r9b9yROk0xXq5uhp74MwlcgbWGsdkoRwnSQKwr
         rkAOgnA1Rbr3igyMXPSj+/di10KOVA2JWySCz7HKQeMliFtJd/seX0hD/PDlsyYGbcV0
         HITg==
X-Gm-Message-State: AOAM5306ii2DDrqk11fNDozAB9mPsX/J2/YgZkTUDkRI3aRgbmMDbKb4
        zu7Q3mz9zdv/NUZSuh0f0ENM0T/ti8msklNNW0Cmtg==
X-Google-Smtp-Source: ABdhPJxk41O0FMwzCS0qOGAJ5pot2HsP0xEUlWx58Nz/Yw02Wcj0cAJSjVw5HNv+6enPy0INENlf+CnoqkGqrrxq84o=
X-Received: by 2002:a5d:6681:: with SMTP id l1mr731145wru.356.1603345088654;
 Wed, 21 Oct 2020 22:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201006001752.248564-1-atish.patra@wdc.com> <20201006001752.248564-4-atish.patra@wdc.com>
In-Reply-To: <20201006001752.248564-4-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 22 Oct 2020 11:07:57 +0530
Message-ID: <CAAhSdy2z=ae1Z92p1zJeiY8tVK3Q5t739ktH3_m_k+hBWNt+sg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] riscv: Separate memory init from paging init
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia He <justin.he@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-arch@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 6, 2020 at 5:48 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, we perform some memory init functions in paging init. But,
> that will be an issue for NUMA support where DT needs to be flattened
> before numa initialization and memblock_present can only be called
> after numa initialization.
>
> Move memory initialization related functions to a separate function.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 1 +
>  arch/riscv/kernel/setup.c        | 1 +
>  arch/riscv/mm/init.c             | 6 +++++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index eaea1f717010..515b42f98d34 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -466,6 +466,7 @@ static inline void __kernel_map_pages(struct page *page, int numpages, int enabl
>  extern void *dtb_early_va;
>  void setup_bootmem(void);
>  void paging_init(void);
> +void misc_mem_init(void);
>
>  #define FIRST_USER_ADDRESS  0
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 2c6dd329312b..07fa6d13367e 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -78,6 +78,7 @@ void __init setup_arch(char **cmdline_p)
>  #else
>         unflatten_device_tree();
>  #endif
> +       misc_mem_init();
>
>  #ifdef CONFIG_SWIOTLB
>         swiotlb_init(1);
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index ed6e83871112..114c3966aadb 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -565,8 +565,12 @@ static void __init resource_init(void)
>  void __init paging_init(void)
>  {
>         setup_vm_final();
> -       sparse_init();
>         setup_zero_page();
> +}
> +
> +void __init misc_mem_init(void)
> +{
> +       sparse_init();
>         zone_sizes_init();
>         resource_init();
>  }
> --
> 2.25.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
