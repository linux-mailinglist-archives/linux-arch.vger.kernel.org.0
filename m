Return-Path: <linux-arch+bounces-6653-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A929F9604F0
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 10:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3291E1F230CC
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 08:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F96198A19;
	Tue, 27 Aug 2024 08:55:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044C6158DD0;
	Tue, 27 Aug 2024 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748938; cv=none; b=jCGLF0lu15EN3HuIdG9dTf/lnQkrPv4n38QK2mcv6fJbkaFj6YSKhu3txS25cRjrz/kug9wyIT6iFlUeau32cXgMl8K5VO8kpnh/eQEvht1YZOlGsJynhUihwoY/GsWLK2Wih6QoV0lhj9stG8JFnUmuZ9dCJDLdWDnAhf8pGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748938; c=relaxed/simple;
	bh=ZfA+lNjZLRY1OVSU5/JRfG/bdaLh+2XWOYPWuqUMM4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwCFYbO6/0I9bxAgahES6xPLa4tHSMyLxnZBIxsy8RObOSIt3CZCc0Q0jhQI79nTSDWmagreGPBTk8OAscGTUDHms4+VvsJX6g9oUUmbBdnw8bPhEhSH1rxy9t7ZCBwKPRqk+sXGsd0tyZaDlnuwLBv/Huywjas/n5LO41QKDAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtLwk0nMzz9sRr;
	Tue, 27 Aug 2024 10:55:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XOoAxCltyyiQ; Tue, 27 Aug 2024 10:55:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtLwj6xKNz9rvV;
	Tue, 27 Aug 2024 10:55:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DC4A38B781;
	Tue, 27 Aug 2024 10:55:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id E77BewEmZDDY; Tue, 27 Aug 2024 10:55:33 +0200 (CEST)
Received: from [192.168.233.149] (unknown [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2BECF8B763;
	Tue, 27 Aug 2024 10:55:33 +0200 (CEST)
Message-ID: <cd32f64c-e3c4-46f3-94cc-69baf493f452@csgroup.eu>
Date: Tue, 27 Aug 2024 10:55:32 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] random: vDSO: Redefine PAGE_SIZE and PAGE_MASK
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
References: <b8f8fb6d1d10386c74f2d8826b737a74c60b76b2.1724743492.git.christophe.leroy@csgroup.eu>
 <defab86b7fb897c88a05a33b62ccf38467dda884.1724747058.git.christophe.leroy@csgroup.eu>
 <Zs2RCfMgfNu_2vos@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Zs2RCfMgfNu_2vos@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/08/2024 à 10:40, Jason A. Donenfeld a écrit :
> I don't love this, but it might be the lesser of evils, so sure, let's
> do it.

I don't love it either but I still prefer it to:

#ifndef PAGE_SIZE
#define PAGE_SIZE
#define PAGE_MASK
#endif

At least we are sure that every architecture get the same , independant 
of the selected options, and we know what we get.

For instance, on x86, when you select CONFIG_HYPERV_TIMER you get 
asm/hyperv_timer.h which indirectly pulls page.h. But when 
CONFIG_HYPERV_TIMER is not selected you don't get asm/hyperv_timer.h

> 
> I think I'll combine these header fixups so that the whole operation is
> a bit more clear. The commit is still pretty small. Something like
> below:

Looks good to me.

Thanks
Christophe

> 
>  From 0d9a3d68cd6222395a605abd0ac625c41d4cabfa Mon Sep 17 00:00:00 2001
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> Date: Tue, 27 Aug 2024 09:31:47 +0200
> Subject: [PATCH] random: vDSO: clean header inclusion in getrandom
> 
> Depending on the architecture, building a 32-bit vDSO on a 64-bit kernel
> is problematic when some system headers are included.
> 
> Minimise the amount of headers by moving needed items, such as
> __{get,put}_unaligned_t, into dedicated common headers and in general
> use more specific headers, similar to what was done in commit
> 8165b57bca21 ("linux/const.h: Extract common header for vDSO") and
> commit 8c59ab839f52 ("lib/vdso: Enable common headers").
> 
> On some architectures this results in missing PAGE_SIZE, as was
> described by commit 8b3843ae3634 ("vdso/datapage: Quick fix - use
> asm/page-def.h for ARM64"), so define this if necessary, in the same way
> as done prior by commit cffaefd15a8f ("vdso: Use CONFIG_PAGE_SHIFT in
> vdso/datapage.h").
> 
> Removing linux/time64.h leads to missing 'struct timespec64' in
> x86's asm/pvclock.h. Add a forward declaration of that struct in
> that file.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   arch/x86/include/asm/pvclock.h  |  1 +
>   include/asm-generic/unaligned.h | 11 +----------
>   include/vdso/helpers.h          |  1 +
>   include/vdso/unaligned.h        | 15 +++++++++++++++
>   lib/vdso/getrandom.c            | 13 ++++++++-----
>   5 files changed, 26 insertions(+), 15 deletions(-)
>   create mode 100644 include/vdso/unaligned.h
> 
> diff --git a/arch/x86/include/asm/pvclock.h b/arch/x86/include/asm/pvclock.h
> index 0c92db84469d..6e4f8fae3ce9 100644
> --- a/arch/x86/include/asm/pvclock.h
> +++ b/arch/x86/include/asm/pvclock.h
> @@ -5,6 +5,7 @@
>   #include <asm/clocksource.h>
>   #include <asm/pvclock-abi.h>
> 
> +struct timespec64;
>   /* some helper functions for xen and kvm pv clock sources */
>   u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src);
>   u64 pvclock_clocksource_read_nowd(struct pvclock_vcpu_time_info *src);
> diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
> index a84c64e5f11e..95acdd70b3b2 100644
> --- a/include/asm-generic/unaligned.h
> +++ b/include/asm-generic/unaligned.h
> @@ -8,16 +8,7 @@
>    */
>   #include <linux/unaligned/packed_struct.h>
>   #include <asm/byteorder.h>
> -
> -#define __get_unaligned_t(type, ptr) ({						\
> -	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
> -	__pptr->x;								\
> -})
> -
> -#define __put_unaligned_t(type, val, ptr) do {					\
> -	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
> -	__pptr->x = (val);							\
> -} while (0)
> +#include <vdso/unaligned.h>
> 
>   #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
>   #define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
> diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
> index 73501149439d..3ddb03bb05cb 100644
> --- a/include/vdso/helpers.h
> +++ b/include/vdso/helpers.h
> @@ -4,6 +4,7 @@
> 
>   #ifndef __ASSEMBLY__
> 
> +#include <asm/barrier.h>
>   #include <vdso/datapage.h>
> 
>   static __always_inline u32 vdso_read_begin(const struct vdso_data *vd)
> diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
> new file mode 100644
> index 000000000000..eee3d2a4dbe4
> --- /dev/null
> +++ b/include/vdso/unaligned.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __VDSO_UNALIGNED_H
> +#define __VDSO_UNALIGNED_H
> +
> +#define __get_unaligned_t(type, ptr) ({						\
> +	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
> +	__pptr->x;								\
> +})
> +
> +#define __put_unaligned_t(type, val, ptr) do {					\
> +	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
> +	__pptr->x = (val);							\
> +} while (0)
> +
> +#endif /* __VDSO_UNALIGNED_H */
> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> index 1281fa3546c2..938ca539aaa6 100644
> --- a/lib/vdso/getrandom.c
> +++ b/lib/vdso/getrandom.c
> @@ -4,15 +4,18 @@
>    */
> 
>   #include <linux/array_size.h>
> -#include <linux/cache.h>
> -#include <linux/kernel.h>
> -#include <linux/time64.h>
> +#include <linux/minmax.h>
>   #include <vdso/datapage.h>
>   #include <vdso/getrandom.h>
> +#include <vdso/unaligned.h>
>   #include <asm/vdso/getrandom.h>
> -#include <asm/vdso/vsyscall.h>
> -#include <asm/unaligned.h>
>   #include <uapi/linux/mman.h>
> +#include <uapi/linux/random.h>
> +
> +#undef PAGE_SIZE
> +#undef PAGE_MASK
> +#define PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
> +#define PAGE_MASK (~(PAGE_SIZE - 1))
> 
>   #define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {				\
>   	while (len >= sizeof(type)) {						\
> --
> 2.46.0

