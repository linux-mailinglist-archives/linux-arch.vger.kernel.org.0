Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C335D35C6C5
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 14:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbhDLMzW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 08:55:22 -0400
Received: from foss.arm.com ([217.140.110.172]:49950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240333AbhDLMzV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Apr 2021 08:55:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82EA51FB;
        Mon, 12 Apr 2021 05:55:03 -0700 (PDT)
Received: from [10.37.12.6] (unknown [10.37.12.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E9C53F73B;
        Mon, 12 Apr 2021 05:55:00 -0700 (PDT)
Subject: Re: [PATCH RESEND v1 1/4] lib/vdso: Mark do_hres_timens() and
 do_coarse_timens() __always_inline()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dima@arista.com, avagin@gmail.com, arnd@arndb.de,
        tglx@linutronix.de, luto@kernel.org, linux-arch@vger.kernel.org
References: <cover.1617209141.git.christophe.leroy@csgroup.eu>
 <90dcf45ebadfd5a07f24241551c62f619d1cb930.1617209142.git.christophe.leroy@csgroup.eu>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <8b42e769-2f17-e2b4-4d2a-b86c4e412598@arm.com>
Date:   Mon, 12 Apr 2021 13:54:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <90dcf45ebadfd5a07f24241551c62f619d1cb930.1617209142.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/31/21 5:48 PM, Christophe Leroy wrote:
> In the same spirit as commit c966533f8c6c ("lib/vdso: Mark do_hres()
> and do_coarse() as __always_inline"), mark do_hres_timens() and
> do_coarse_timens() __always_inline.
> 
> The measurement below in on a non timens process, ie on the fastest path.
> 
> On powerpc32, without the patch:
> 
> clock-gettime-monotonic-raw:    vdso: 1155 nsec/call
> clock-gettime-monotonic-coarse:    vdso: 813 nsec/call
> clock-gettime-monotonic:    vdso: 1076 nsec/call
> 
> With the patch:
> 
> clock-gettime-monotonic-raw:    vdso: 1100 nsec/call
> clock-gettime-monotonic-coarse:    vdso: 667 nsec/call
> clock-gettime-monotonic:    vdso: 1025 nsec/call
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  lib/vdso/gettimeofday.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index 2919f1698140..c6f6dee08746 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -46,8 +46,8 @@ static inline bool vdso_cycles_ok(u64 cycles)
>  #endif
>  
>  #ifdef CONFIG_TIME_NS
> -static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
> -			  struct __kernel_timespec *ts)
> +static __always_inline int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
> +					  struct __kernel_timespec *ts)
>  {
>  	const struct vdso_data *vd = __arch_get_timens_vdso_data();
>  	const struct timens_offset *offs = &vdns->offset[clk];
> @@ -97,8 +97,8 @@ static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
>  	return NULL;
>  }
>  
> -static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
> -			  struct __kernel_timespec *ts)
> +static __always_inline int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
> +					  struct __kernel_timespec *ts)
>  {
>  	return -EINVAL;
>  }
> @@ -159,8 +159,8 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
>  }
>  
>  #ifdef CONFIG_TIME_NS
> -static int do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
> -			    struct __kernel_timespec *ts)
> +static __always_inline int do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
> +					    struct __kernel_timespec *ts)
>  {
>  	const struct vdso_data *vd = __arch_get_timens_vdso_data();
>  	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
> @@ -188,8 +188,8 @@ static int do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
>  	return 0;
>  }
>  #else
> -static int do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
> -			    struct __kernel_timespec *ts)
> +static __always_inline int do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
> +					    struct __kernel_timespec *ts)
>  {
>  	return -1;
>  }
> 

-- 
Regards,
Vincenzo
