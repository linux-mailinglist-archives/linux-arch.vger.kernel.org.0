Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A3821A951
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGIUum (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 16:50:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42362 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgGIUum (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 16:50:42 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069KZM6E090986;
        Thu, 9 Jul 2020 16:49:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32637twb3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 16:49:34 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 069KZM9B090993;
        Thu, 9 Jul 2020 16:49:33 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32637twb2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 16:49:33 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 069Kg1WF002260;
        Thu, 9 Jul 2020 20:49:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 325u410wps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 20:49:30 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 069KnSoq10748324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jul 2020 20:49:28 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA81E11C04A;
        Thu,  9 Jul 2020 20:49:27 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A38E211C052;
        Thu,  9 Jul 2020 20:49:23 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.204.222])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  9 Jul 2020 20:49:23 +0000 (GMT)
Date:   Thu, 9 Jul 2020 23:49:21 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, zong.li@sifive.com,
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
        linux-arch@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH 1/5] lib: Add a generic version of devmem_is_allowed()
Message-ID: <20200709204921.GJ781326@linux.ibm.com>
References: <20200709200552.1910298-1-palmer@dabbelt.com>
 <20200709200552.1910298-2-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709200552.1910298-2-palmer@dabbelt.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_11:2020-07-09,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 mlxlogscore=999 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1011 mlxscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007090139
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Palmer,

On Thu, Jul 09, 2020 at 01:05:48PM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> As part of adding support for STRICT_DEVMEM to the RISC-V port, Zong
> provided a devmem_is_allowed() implementation that's exactly the same as
> all the others I checked.  Instead I'm adding a generic version, which
> will soon be used.
> 
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  include/asm-generic/io.h |  4 ++++
>  lib/Kconfig              |  4 ++++
>  lib/Makefile             |  2 ++
>  lib/devmem_is_allowed.c  | 27 +++++++++++++++++++++++++++
>  4 files changed, 37 insertions(+)
>  create mode 100644 lib/devmem_is_allowed.c
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 8b1e020e9a03..69e3db65fba0 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1122,6 +1122,10 @@ static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
>  }
>  #endif
>  
> +#ifndef CONFIG_GENERIC_DEVMEM_IS_ALLOWED
> +extern int devmem_is_allowed(unsigned long pfn);
> +#endif
> +
>  #endif /* __KERNEL__ */
>  
>  #endif /* __ASM_GENERIC_IO_H */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index df3f3da95990..3b1b6481e073 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -676,3 +676,7 @@ config GENERIC_LIB_CMPDI2
>  
>  config GENERIC_LIB_UCMPDI2
>  	bool
> +
> +config GENERIC_LIB_DEVMEM_IS_ALLOWED
> +	bool
> +	select ARCH_HAS_DEVMEM_IS_ALLOWED

This seems to work the other way around from the usual Kconfig chains.
In the most cases ARCH_HAS_SOMETHING selects GENERIC_SOMETHING.

I believe nicer way would be to make 

config STRICT_DEVMEM
	bool "Filter access to /dev/mem"
	depends on MMU && DEVMEM
	depends on ARCH_HAS_DEVMEM_IS_ALLOWED || GENERIC_LIB_DEVMEM_IS_ALLOWED

config GENERIC_LIB_DEVMEM_IS_ALLOWED
	bool

and then s/select ARCH_HAS_DEVMEM_IS_ALLOWED/select GENERIC_LIB_DEVMEM_IS_ALLOWED/
in the arch Kconfigs and drop ARCH_HAS_DEVMEM_IS_ALLOWED in the end.

> diff --git a/lib/Makefile b/lib/Makefile
> index b1c42c10073b..554ef14f9be5 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -318,3 +318,5 @@ obj-$(CONFIG_OBJAGG) += objagg.o
>  # KUnit tests
>  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> +
> +obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
> diff --git a/lib/devmem_is_allowed.c b/lib/devmem_is_allowed.c
> new file mode 100644
> index 000000000000..c0d67c541849
> --- /dev/null
> +++ b/lib/devmem_is_allowed.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * A generic version of devmem_is_allowed.
> + *
> + * Based on arch/arm64/mm/mmap.c
> + *
> + * Copyright (C) 2020 Google, Inc.
> + * Copyright (C) 2012 ARM Ltd.
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/ioport.h>
> +
> +/*
> + * devmem_is_allowed() checks to see if /dev/mem access to a certain address
> + * is valid. The argument is a physical page number.  We mimic x86 here by
> + * disallowing access to system RAM as well as device-exclusive MMIO regions.
> + * This effectively disable read()/write() on /dev/mem.
> + */
> +int devmem_is_allowed(unsigned long pfn)
> +{
> +	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
> +		return 0;
> +	if (!page_is_ram(pfn))
> +		return 1;
> +	return 0;
> +}
> -- 
> 2.27.0.383.g050319c2ae-goog
> 

-- 
Sincerely yours,
Mike.
