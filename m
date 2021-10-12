Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D08429D75
	for <lists+linux-arch@lfdr.de>; Tue, 12 Oct 2021 08:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhJLGG3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Oct 2021 02:06:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:33883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232431AbhJLGG2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Oct 2021 02:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634018618;
        bh=t9NgUWQCN+x3V7Hp4Nfn0+U2T6Ph1w/p+Efg9vnjBf8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ff8FjRkeCGbDpe/67S+poZ4/cjMzIGK70KzKAoKGGO3UvGG+Ix7k9hOGT/JA5zFVb
         b0wSwWqJ8dMxsjQlVFW3HytK5O2ttt/GMmp/w5AxEKZod1TvXVGZhceo9V7kW7X6iz
         hClSRgqyy8hhts09vENLoYs8936bTXAsRMicxeAY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.128.177]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1n5vBn0vWP-00q9gl; Tue, 12
 Oct 2021 08:03:38 +0200
Message-ID: <91b38fce-8a5c-ccc7-fba5-b75b9769d4fc@gmx.de>
Date:   Tue, 12 Oct 2021 08:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v1 04/10] asm-generic: Use
 HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR to define associated stubs
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <8db2a3ca2b26a8325c671baa3e0492914597f079.1633964380.git.christophe.leroy@csgroup.eu>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <8db2a3ca2b26a8325c671baa3e0492914597f079.1633964380.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3FVNBuFx64HT0tuoJYG2SIgMIMfL8fXzN53XykVw2JLzU6FqL0B
 47lugWj6rkUtNsiz8tcSM75G3rrpuahDYFok+XAuxw63YZr0F3Nhdr2cn7g/FuAFNgPo2yC
 CK5N7YfnT66ssXgewYk+lLdJFDOEy4prM32Gprx7BezR9iX89W0jxYI1RVQZpS0fcrDSbsr
 e0AtWhnfZqeJ2pYoyvi6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:umUw8efNMTI=:/9tlCPWVCKekVvKKamGFwj
 BsaJeIoRtjZCIzQfUGtUOy4GhMdkFU78x6mufwb1nMvsoc7NzTz8Q9gP0yAMU7CGYWq2JxYKN
 KlVEg2hQJjl70wBfi5acPN0BuvbZBUj5hO2+w04TTvnUfmsDJ5rZ5s5s+XxUK1l+rd5r5ZLYP
 3QtzM2rz3+1qdNSOhvX7E3erRQkCijzBY/8rbNtm+QTfHiI7iq1TKJkIGxXjKPdSKHajjC9yd
 RLdQGEIUVJpGCZfNDQQ1qDpn1bX83xhpFzZG22mXow6Du//OvXPejMza7rcsqLAJOlXNFw7YI
 2+98mFao5Cm2br+C+xQvtJKTFkhilgseoNe5cdpFQNWfqhlF6Buf3vMrQcroYBTtGEY0qZY5z
 caVBMhqD0jjhDWo5rBeHIUTjkf7Xts6TqygocHWFmFatrtHqLmz3CcViihdysH99uzMB5wQJ3
 zWcRj83iI2U6tIvgo4b5Dq5EtI6tWmFbib8nowxMiSbMpREz+yajuBBAIZyicGjZ55D/Oh7/m
 swqmY0o0ObRMbrIwTxqy9uHn9RL86+ng4I0V7Qx53qGKp+QfKAzOBhlhuL4iywFYrJhloX1zr
 MfXWy3vpu0zrMos+Nn5xMiFvbvbxEnjQe7EoUMnaRNMmsvQ0w7y0H4eB3C9Z8b8NLs2s15q8O
 v7gh8pNHpJYWHy4nFkvBVZxKDjAO/uD0oYyhAl5bVuoIcmxRA9UY4d0o2+kyC6vZ1TZTYrJDk
 ta2bQLCEG+2xpDnOHJAMXSfdgWdpXeVu0wU+Xkx/NG1xweXLZ8/wcnOYH9JvTJjvWI8CzUcme
 6So+BaIoAa/L3qjJZvf5eBIaPEg6RELwFbj+f/k+jXImqEP4Lv5TkXZN5TJPsYmeqz3KbIKRv
 aBxuKiJNOBszOzO9VQWnHjxLXwClcL+tjwXNS3XwX8UEU8VrsmzWpMMZOW3nTJ2nwzDjzWQWx
 BGOQ0y8GPQD+KVYUN628i7hwI6ntwrNiecBM4JjoWqV/ZT9rsaIS4dasc+sUpXJasDDp26unL
 sDC01ifkzZiOzrrT/B31TP0moswG49S/dABdQ4qrLmnrxnobAtogIGonFxz2l341BK4NOCN+S
 /UisBwh5D8+KG4=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/11/21 17:25, Christophe Leroy wrote:
> Use HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR instead of 'dereference_functio=
n_descriptor'
> to know whether arch has function descriptors.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/ia64/include/asm/sections.h    | 4 ++--
>  arch/parisc/include/asm/sections.h  | 6 ++++--
>  arch/powerpc/include/asm/sections.h | 6 ++++--
>  include/asm-generic/sections.h      | 3 ++-
>  4 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/se=
ctions.h
> index 35f24e52149a..80f5868afb06 100644
> --- a/arch/ia64/include/asm/sections.h
> +++ b/arch/ia64/include/asm/sections.h
> @@ -7,6 +7,8 @@
>   *	David Mosberger-Tang <davidm@hpl.hp.com>
>   */
>
> +#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> +
>  #include <linux/elf.h>
>  #include <linux/uaccess.h>
>  #include <asm-generic/sections.h>
> @@ -27,8 +29,6 @@ extern char __start_gate_brl_fsys_bubble_down_patchlis=
t[], __end_gate_brl_fsys_b
>  extern char __start_unwind[], __end_unwind[];
>  extern char __start_ivt_text[], __end_ivt_text[];
>
> -#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> -
>  #undef dereference_function_descriptor
>  static inline void *dereference_function_descriptor(void *ptr)
>  {
> diff --git a/arch/parisc/include/asm/sections.h b/arch/parisc/include/as=
m/sections.h
> index bb52aea0cb21..2e781ee19b66 100644
> --- a/arch/parisc/include/asm/sections.h
> +++ b/arch/parisc/include/asm/sections.h
> @@ -2,6 +2,10 @@
>  #ifndef _PARISC_SECTIONS_H
>  #define _PARISC_SECTIONS_H
>
> +#ifdef CONFIG_64BIT
> +#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> +#endif
> +
>  /* nothing to see, move along */
>  #include <asm-generic/sections.h>
>
> @@ -9,8 +13,6 @@ extern char __alt_instructions[], __alt_instructions_en=
d[];
>
>  #ifdef CONFIG_64BIT
>
> -#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> -
>  #undef dereference_function_descriptor
>  void *dereference_function_descriptor(void *);
>
> diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/=
asm/sections.h
> index 32e7035863ac..b7f1ba04e756 100644
> --- a/arch/powerpc/include/asm/sections.h
> +++ b/arch/powerpc/include/asm/sections.h
> @@ -8,6 +8,10 @@
>
>  #define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
>
> +#ifdef PPC64_ELF_ABI_v1
> +#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> +#endif
> +
>  #include <asm-generic/sections.h>
>
>  extern bool init_mem_is_free;
> @@ -69,8 +73,6 @@ static inline int overlaps_kernel_text(unsigned long s=
tart, unsigned long end)
>
>  #ifdef PPC64_ELF_ABI_v1
>
> -#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> -
>  #undef dereference_function_descriptor
>  static inline void *dereference_function_descriptor(void *ptr)
>  {
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sectio=
ns.h
> index d16302d3eb59..1db5cfd69817 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -59,7 +59,8 @@ extern char __noinstr_text_start[], __noinstr_text_end=
[];
>  extern __visible const void __nosave_begin, __nosave_end;
>
>  /* Function descriptor handling (if any).  Override in asm/sections.h *=
/
> -#ifndef dereference_function_descriptor
> +#ifdef HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR
> +#else

why not
#ifndef HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR
instead of #if/#else ?

>  #define dereference_function_descriptor(p) ((void *)(p))
>  #define dereference_kernel_function_descriptor(p) ((void *)(p))
>  #endif
>

