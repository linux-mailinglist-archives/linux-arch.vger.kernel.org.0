Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D9F7B5470
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 16:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbjJBOJc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 10:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbjJBOJb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 10:09:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F36B7;
        Mon,  2 Oct 2023 07:09:28 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzjS861dVz67ydC;
        Mon,  2 Oct 2023 22:06:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 15:09:25 +0100
Date:   Mon, 2 Oct 2023 15:09:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <linux-mm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <x86@kernel.org>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC v2 5/5] ktest: sys_move_phys_pages ktest
Message-ID: <20231002150924.00006a7b@Huawei.com>
In-Reply-To: <20230919230909.530174-6-gregory.price@memverge.com>
References: <20230919230909.530174-1-gregory.price@memverge.com>
        <20230919230909.530174-6-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 19 Sep 2023 19:09:08 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> Implement simple ktest that looks up the physical address via
> /proc/self/pagemap and migrates the page based on that information.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

One trivial comment inline.


> ---
>  tools/testing/selftests/mm/migration.c | 101 +++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
> index 6908569ef406..67fbae243f94 100644
> --- a/tools/testing/selftests/mm/migration.c
> +++ b/tools/testing/selftests/mm/migration.c
> @@ -5,6 +5,8 @@
>   */
>  
>  #include "../kselftest_harness.h"
> +#include <stdint.h>
> +#include <stdio.h>
>  #include <strings.h>
>  #include <pthread.h>
>  #include <numa.h>
> @@ -14,11 +16,17 @@
>  #include <sys/types.h>
>  #include <signal.h>
>  #include <time.h>
> +#include <unistd.h>
>  
>  #define TWOMEG (2<<20)
>  #define RUNTIME (20)
>  
> +#define GET_BIT(X, Y) ((X & ((uint64_t)1<<Y)) >> Y)
> +#define GET_PFN(X) (X & 0x7FFFFFFFFFFFFFull)
>  #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
> +#define PAGEMAP_ENTRY 8
> +const int __endian_bit = 1;
> +#define is_bigendian() ((*(char *)&__endian_bit) == 0)
>  
>  FIXTURE(migration)
>  {
> @@ -94,6 +102,47 @@ int migrate(uint64_t *ptr, int n1, int n2)
>  	return 0;
>  }
>  
> +
Trivial, but 3 lines definitely more than needed.

> +
> +int migrate_phys(uint64_t paddr, int n1, int n2)
> +{
> +	int ret, tmp;
> +	int status = 0;
> +	struct timespec ts1, ts2;
> +
> +	if (clock_gettime(CLOCK_MONOTONIC, &ts1))
> +		return -1;
> +
> +	while (1) {
> +		if (clock_gettime(CLOCK_MONOTONIC, &ts2))
> +			return -1;
> +
> +		if (ts2.tv_sec - ts1.tv_sec >= RUNTIME)
> +			return 0;
> +
> +		/*
> +		 * FIXME: move_phys_pages was syscall 454 during RFC.
> +		 * Update this when an official syscall number is adopted
> +		 * and the libnuma interface is implemented.
> +		 */
> +		ret = syscall(454, 1, (void **) &paddr, &n2, &status,
> +			      MPOL_MF_MOVE_ALL);
> +		if (ret) {
> +			if (ret > 0)
> +				printf("Didn't migrate %d pages\n", ret);
> +			else
> +				perror("Couldn't migrate pages");
> +			return -2;
> +		}
> +
> +		tmp = n2;
> +		n2 = n1;
> +		n1 = tmp;
> +	}
> +
> +	return 0;
> +}


