Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4A24BB4BE
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 10:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiBRJBK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 04:01:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiBRJBJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 04:01:09 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7711D1867C4;
        Fri, 18 Feb 2022 01:00:52 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id q9so3731377vsg.2;
        Fri, 18 Feb 2022 01:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nYL/qjPVlkIqK+5dnbJ/5QVdVKG9AQSDTVmJuSTxwE=;
        b=Zv5we/RxYb0vPcwmthg0UKS7t8MJAYVmVgrUzX//i6/+r/z75j0fq9KuaSGpBRCpRD
         pZQVMpJrgHDjmG/pE8NlMIvxraQAFXZnmK35GZwk3dCq7hULFowna8Yz/6wIN1vtjrWg
         lj0Oyn2RsxPnATMlbZt062i4aueZdDsQ8CYOVZfIggEJ5EAMCANlwVUlMHA196K4g6b+
         kT0ndFGmgRy0zi8Tbd/Tqb7JAUhQDMdAROWAJIF1NzUZ27qX4OlzI5x0LiEXRgN4YiWd
         sKJI0XDR/2shnBfhqNzA1yJeMbZQTBjUrPoMcf/6mCGwNr017Gv2BTYqMMgB8+rLJ4jD
         YlzQ==
X-Gm-Message-State: AOAM532ndTqZyoRzKkrB94qVdAYO9LGhrj6jjuLVe0C2uEIPb4o6vVLZ
        Dfoh87O71pgFgZS3iuGX6YHyHo0+q8dGPA==
X-Google-Smtp-Source: ABdhPJxp40nmkJXiu8iNeCwx9n2AED0TZQVM/tj+B9o99AsQIveQ6vybTcySkFQDWjbvuLfgWeR4eA==
X-Received: by 2002:a67:d50a:0:b0:31b:9be2:8aa0 with SMTP id l10-20020a67d50a000000b0031b9be28aa0mr2906226vsj.76.1645174851807;
        Fri, 18 Feb 2022 01:00:51 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id n77sm7184646vkn.29.2022.02.18.01.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 01:00:50 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id u10so9161585vsu.13;
        Fri, 18 Feb 2022 01:00:50 -0800 (PST)
X-Received: by 2002:a67:e113:0:b0:30e:303d:d1d6 with SMTP id
 d19-20020a67e113000000b0030e303dd1d6mr3151546vsl.38.1645174850220; Fri, 18
 Feb 2022 01:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-11-arnd@kernel.org>
In-Reply-To: <20220216131332.1489939-11-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Feb 2022 10:00:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWMhP5WgZ7CvOz53SyfizaAvLkHbeuds8G+_nZkwzhWWw@mail.gmail.com>
Message-ID: <CAMuHMdWMhP5WgZ7CvOz53SyfizaAvLkHbeuds8G+_nZkwzhWWw@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] m68k: fix access_ok for coldfire
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Wed, Feb 16, 2022 at 2:17 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> While most m68k platforms use separate address spaces for user
> and kernel space, at least coldfire does not, and the other
> ones have a TASK_SIZE that is less than the entire 4GB address
> range.
>
> Using the default implementation of __access_ok() stops coldfire
> user space from trivially accessing kernel memory.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/arch/m68k/include/asm/uaccess.h
> +++ b/arch/m68k/include/asm/uaccess.h
> @@ -12,14 +12,21 @@
>  #include <asm/extable.h>
>
>  /* We let the MMU do all checking */
> -static inline int access_ok(const void __user *addr,
> +static inline int access_ok(const void __user *ptr,
>                             unsigned long size)
>  {
> +       unsigned long limit = TASK_SIZE;
> +       unsigned long addr = (unsigned long)ptr;
> +
>         /*
>          * XXX: for !CONFIG_CPU_HAS_ADDRESS_SPACES this really needs to check
>          * for TASK_SIZE!
> +        * Removing this helper is probably sufficient.
>          */

Shouldn't the above comment block be removed completely,
as this is now implemented below?

> -       return 1;
> +       if (IS_ENABLED(CONFIG_CPU_HAS_ADDRESS_SPACES))
> +               return 1;
> +
> +       return (size <= limit) && (addr <= (limit - size));
>  }

Any pesky compilers that warn (or worse with -Werror) about
"condition always true" for TASK_SIZE = 0xFFFFFFFFUL?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
