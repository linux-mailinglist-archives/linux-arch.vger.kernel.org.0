Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB37421A961
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 22:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgGIUyf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 16:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGIUye (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 16:54:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613C3C08C5CE
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 13:54:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so1313176pls.4
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 13:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TVsRdosVdOrgb86VUqLK7jhphF0DWrgDdhx+LVQ5W9o=;
        b=RmcOQKDrKS4TjND+INPK5tStmtBHyi5qtg3Y2/m9cYCZFW0uO+IsLknrvepsIgymvM
         1rl8Qh9/awqelifoBxaCYJMhnqffwoXjTs28EWlKt/CYudymkz1bs5PReyMJxMNTy+kP
         VLBVpcaqzusSMmJ0G2K7yF/PXcUGPYm2ytCjhz+pZTEsf1xaskMKyxLQ7VN4tyQWYhT5
         uCR73NTeWBkQNZGAK+oBDrbqr+Wdo37GJKjNCSc9EjpVYVpEnN4c+t+NA2rCRpG4xao1
         S/e+ZozWba84kJcqWLJpfkRM3NcJ/IAYnDfAqxHH7dreMJytVTh97TQQMiu68P1KnCos
         35yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TVsRdosVdOrgb86VUqLK7jhphF0DWrgDdhx+LVQ5W9o=;
        b=JCpgPKk7MSLtUuORuzHy3k7otFHnt8VxrUZl4btf/VQsGQNKwyq2KCAqA8agq3Plil
         ItAhGPTF/XX7mbPUIqQiQ1Ae6QWz5xR3T2sikEAWqG60DmoM3kPt01v7t5wjkVTAQaHM
         qcS2KZNzVNSRY6bt9qoWZHKUM2qZ7H+utpkAOWBZdkFgZlSKi5JzDTMfTtTkdhCtMHCN
         I58PeYqr99kmss++Z6Qi06+6H90O2cRwKDfES8zdiiWlOOVDf4PjcyLQYGQBsvMfNPKE
         7StsBctMn3fCjRf1LhJnD6L1YLzN38f+/xESSECStzsnuSYf7TIgiLVUqnNGpHTy2zTi
         t/EA==
X-Gm-Message-State: AOAM530Rxezv2Ott3gby105cdxd9LVVIyiVW7Nc+Jhs5jdsse+1N3oDt
        Ou7bTqwNhqlr36HJ74K8bivSyg==
X-Google-Smtp-Source: ABdhPJziIZaC2dw+9NZRbd8F8njrpqBsYNP/YdbUiTKDLO5hKbULu6MH/NnhmS/fwOD8OTxyeRAVaQ==
X-Received: by 2002:a17:90b:4c0f:: with SMTP id na15mr1998077pjb.33.1594328073688;
        Thu, 09 Jul 2020 13:54:33 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f131sm3700561pgc.14.2020.07.09.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:54:33 -0700 (PDT)
Date:   Thu, 09 Jul 2020 13:54:33 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Jul 2020 13:54:30 PDT (-0700)
Subject:     Re: [PATCH 1/5] lib: Add a generic version of devmem_is_allowed()
In-Reply-To: <20200709204921.GJ781326@linux.ibm.com>
CC:     linux-riscv@lists.infradead.org, zong.li@sifive.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, gxt@pku.edu.cn,
        Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org,
        linus.walleij@linaro.org, mchehab+samsung@kernel.org,
        gregory.0xf0@gmail.com, masahiroy@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com, tglx@linutronix.de, steve@sk2.org,
        keescook@chromium.org, mcgrof@kernel.org, alex@ghiti.fr,
        mark.rutland@arm.com, james.morse@arm.com,
        andriy.shevchenko@linux.intel.com, alex.shi@linux.alibaba.com,
        davem@davemloft.net, rdunlap@infradead.org, broonie@kernel.org,
        uwe@kleine-koenig.org, rostedt@goodmis.org,
        dan.j.williams@intel.com, mhiramat@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, zaslonko@linux.ibm.com,
        krzk@kernel.org, willy@infradead.org, paulmck@kernel.org,
        pmladek@suse.com, glider@google.com, elver@google.com,
        davidgow@google.com, ardb@kernel.org, takahiro.akashi@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rppt@linux.ibm.com
Message-ID: <mhng-809d2d2d-add0-4f43-9225-610485ee46d5@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 09 Jul 2020 13:49:21 PDT (-0700), rppt@linux.ibm.com wrote:
> Hi Palmer,
>
> On Thu, Jul 09, 2020 at 01:05:48PM -0700, Palmer Dabbelt wrote:
>> From: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> As part of adding support for STRICT_DEVMEM to the RISC-V port, Zong
>> provided a devmem_is_allowed() implementation that's exactly the same as
>> all the others I checked.  Instead I'm adding a generic version, which
>> will soon be used.
>>
>> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> ---
>>  include/asm-generic/io.h |  4 ++++
>>  lib/Kconfig              |  4 ++++
>>  lib/Makefile             |  2 ++
>>  lib/devmem_is_allowed.c  | 27 +++++++++++++++++++++++++++
>>  4 files changed, 37 insertions(+)
>>  create mode 100644 lib/devmem_is_allowed.c
>>
>> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
>> index 8b1e020e9a03..69e3db65fba0 100644
>> --- a/include/asm-generic/io.h
>> +++ b/include/asm-generic/io.h
>> @@ -1122,6 +1122,10 @@ static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
>>  }
>>  #endif
>>
>> +#ifndef CONFIG_GENERIC_DEVMEM_IS_ALLOWED
>> +extern int devmem_is_allowed(unsigned long pfn);
>> +#endif
>> +
>>  #endif /* __KERNEL__ */
>>
>>  #endif /* __ASM_GENERIC_IO_H */
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index df3f3da95990..3b1b6481e073 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -676,3 +676,7 @@ config GENERIC_LIB_CMPDI2
>>
>>  config GENERIC_LIB_UCMPDI2
>>  	bool
>> +
>> +config GENERIC_LIB_DEVMEM_IS_ALLOWED
>> +	bool
>> +	select ARCH_HAS_DEVMEM_IS_ALLOWED
>
> This seems to work the other way around from the usual Kconfig chains.
> In the most cases ARCH_HAS_SOMETHING selects GENERIC_SOMETHING.

Ya, it seemed kind of odd.

>
> I believe nicer way would be to make
>
> config STRICT_DEVMEM
> 	bool "Filter access to /dev/mem"
> 	depends on MMU && DEVMEM
> 	depends on ARCH_HAS_DEVMEM_IS_ALLOWED || GENERIC_LIB_DEVMEM_IS_ALLOWED
>
> config GENERIC_LIB_DEVMEM_IS_ALLOWED
> 	bool
>
> and then s/select ARCH_HAS_DEVMEM_IS_ALLOWED/select GENERIC_LIB_DEVMEM_IS_ALLOWED/
> in the arch Kconfigs and drop ARCH_HAS_DEVMEM_IS_ALLOWED in the end.

There's some arches that can't be converted to the generic version, at least
not trivially, so we wouldn't drop it.  I think it's still cleaner, though.
I'll send a v2.

>
>> diff --git a/lib/Makefile b/lib/Makefile
>> index b1c42c10073b..554ef14f9be5 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -318,3 +318,5 @@ obj-$(CONFIG_OBJAGG) += objagg.o
>>  # KUnit tests
>>  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
>> +
>> +obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>> diff --git a/lib/devmem_is_allowed.c b/lib/devmem_is_allowed.c
>> new file mode 100644
>> index 000000000000..c0d67c541849
>> --- /dev/null
>> +++ b/lib/devmem_is_allowed.c
>> @@ -0,0 +1,27 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * A generic version of devmem_is_allowed.
>> + *
>> + * Based on arch/arm64/mm/mmap.c
>> + *
>> + * Copyright (C) 2020 Google, Inc.
>> + * Copyright (C) 2012 ARM Ltd.
>> + */
>> +
>> +#include <linux/mm.h>
>> +#include <linux/ioport.h>
>> +
>> +/*
>> + * devmem_is_allowed() checks to see if /dev/mem access to a certain address
>> + * is valid. The argument is a physical page number.  We mimic x86 here by
>> + * disallowing access to system RAM as well as device-exclusive MMIO regions.
>> + * This effectively disable read()/write() on /dev/mem.
>> + */
>> +int devmem_is_allowed(unsigned long pfn)
>> +{
>> +	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
>> +		return 0;
>> +	if (!page_is_ram(pfn))
>> +		return 1;
>> +	return 0;
>> +}
>> --
>> 2.27.0.383.g050319c2ae-goog
>>
