Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C65E7199E2
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 12:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjFAKfE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 06:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjFAKep (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 06:34:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9087A8E;
        Thu,  1 Jun 2023 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1685615570; i=deller@gmx.de;
        bh=G2fVWfFa8Mg7zk8fckBtVkE46aW59z85USR51MF7qtA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FmEhh+g+1DMt5R00VGwoA6elCJBKz5sYnrCS4k8pbs4FebbObsTMoS8ilG3++VVdP
         gNj+IpkiOmplBoLThMFtiF09gwNBcv0lLa3SddmTzCjnQAcAsEV+gQ4IBtia3VTe0q
         tAzyoTc4yp1UsMYHpvORsVDA4Z0vtf1JD1mZWgh9ltZBLhSBiHmnraCm4wJ38oQfL1
         uPtjeboQwb5+cNsLX86hk7wLs9t+iTGic+maNc4YnIU/GKSF9v4CUlwOTClbhL7HfT
         GkEVVU9TosKjG0dG5Lplx/pL7aKB6FeDQbKeezr5taz3oH5M4y6JrWRaSXYSXLdHbS
         3tntj4pI5wyMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.56.61] ([109.43.49.30]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1qQkp02L1k-00mYV1; Thu, 01
 Jun 2023 12:32:50 +0200
Message-ID: <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de>
Date:   Thu, 1 Jun 2023 12:32:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 07/12] parisc/percpu: Work around the lack of
 __SIZEOF_INT128__
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        suravee.suthikulpanit@amd.com, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>,
        Sam James <sam@gentoo.org>
References: <20230531130833.635651916@infradead.org>
 <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com>
 <20230601101409.GS4253@hirez.programming.kicks-ass.net>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230601101409.GS4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qA5DnM4FMT01IDeGOwln/QBbEhpU1XDaseD6BNrJd2GZ0tWK4QE
 0yoTPW4Cs8Vtb3/jrIjTmQtVVNUdP3oXYDtFd4z2kq0x7GFNVrwG5gEaGKtm2ktl4Sd3zvp
 kxZFe+aVo2LRvUHYM94SCcI5Q+2GxcLHYu9LTSFdlRkYd2lDVuDk6B25dzssNg2eXbmZQ9f
 0TxMAa4XkIBRA/JlzP4cw==
UI-OutboundReport: notjunk:1;M01:P0:lEDV+OwbF54=;tqVeNJO4hsUSgmJjpmBUSoVfvY1
 P/H67S16xvXuBRLnk1x8/0oamZFGOOIFXOCJe/hmp8CSY77eEc61k7PxC47hbEI87zrTTLHFH
 dWEbnJsKLZlhk+5pY153PoS6l0SyGPAHVim7eKVrjxF1IXcFt6PFd5Vw+aE2QUnUut9h8jTrt
 Lq78XVCHJNdVnVPOJ47gp+5mkAIqZ6pWonbrlGATCpt+n7YpCCajAlAKSABpRGJjOoOdODf86
 mbdjdqFtOKhQ04CKFfgEyxLNXMYJVzCKf+9SGFTQe/omDQvuTYBYZOi2ceVwi6hH2ZxAiLY7G
 u20XwVk1X296jyJNemf6fgt6cmc7qArCvySvCtplxwnVnBZpfg4bhGRMCdOK1dwbdMNhiav2x
 /dycPeP0gpTyirVYPahuuzRj/g9O6bPOei6Tb1RDaPwoZDm4IFD+PNESrNHJyi/jrX/3NFu4x
 L+EWKh+v2YK6Q8Z4ViEGto3VXXk23pDZGs60enM93LX9ImtdpC4c1PqAYLweRHwPsvBPY6D0i
 bgNY5zxSa7nBXYhTH8oIwu71bBf237gaOpeqzYMcQTLrjv43F7VYzJpJPkM0mvPd3wkz9aiWf
 4mw7PRUsxB3LwZhEm7ohSC6LPzYEHCjoYFHAyNOqsbdav6WfYZWi610L05paEqu4V1YOWv33S
 8KLExn5u3Elk8eh4/xpS0HMIf4XUoZwDq1vDVtESK25wGc6HkRYkIl97wmW2TSPBc2Am1fTlb
 roglOE/2aTWHWoCN/qEH4yPzzYaSiJeSyzj+I4skyIkbhebChyE+RALqWDxTybIFJ1w2DfP2o
 anH6ZPyfZQ6d4BLKrKYuyEVPj6FtGAUtN+xLNu0C1FQJFgpdr1j6Txfz7cmh2SG1zaEyeKXQ4
 oXiPN6V3C8LedVzp/tvsi0kHrOtlI6iXIoTkBTy9WR2wsc3i777kCVAftkQkqBuYnkgkQ/rue
 3QqTKVV3MwstFz1j8XAvezd2tOQ=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/1/23 12:14, Peter Zijlstra wrote:
> On Wed, May 31, 2023 at 04:21:22PM +0200, Arnd Bergmann wrote:
>
>> It would be nice to have the hack more localized to parisc
>> and guarded with a CONFIG_GCC_VERSION check so we can kill
>> it off in the future, once we drop either gcc-10 or parisc
>> support.
>
> I vote for dropping parisc -- it's the only 64bit arch that doesn't have
> sane atomics.

Of course I'm against dropping parisc.

> Anyway, the below seems to work -- build tested with GCC-10.1

I don't think we need to care about gcc-10 on parisc.
Debian and Gentoo are the only supported distributions, while Debian
requires gcc-12 to build > 6.x kernels, and I assume Gentoo uses at least
gcc-12 as well.

So raising the gcc limit for parisc only (at least temporarily for now)
should be fine and your workaround below wouldn't be necessary, right?

Helge

> ---
> Subject: parisc/percpu: Work around the lack of __SIZEOF_INT128__
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue May 30 22:27:40 CEST 2023
>
> HPPA64 is unique in not providing __SIZEOF_INT128__ across all
> supported compilers, specifically it only started doing this with
> GCC-11.
>
> Since the per-cpu ops are universally availably, and
> this_cpu_{,try_}cmpxchg128() is expected to be available on all 64bit
> architectures a wee bodge is in order.
>
> Sadly, while C reverts to memcpy() for assignment of POD types, it does
> not revert to memcmp() for for equality. Therefore frob that manually.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/parisc/include/asm/percpu.h |   77 ++++++++++++++++++++++++++++++=
+++++++++
>   1 file changed, 77 insertions(+)
>
> --- /dev/null
> +++ b/arch/parisc/include/asm/percpu.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_PARISC_PERCPU_H
> +#define _ASM_PARISC_PERCPU_H
> +
> +#include <linux/types.h>
> +
> +#if defined(CONFIG_64BIT) && CONFIG_GCC_VERSION < 1100000
> +
> +/*
> + * GCC prior to 11 does not provide __SIZEOF_INT128__ on HPPA64
> + * as such we need to provide an alternative implementation of
> + * {raw,this}_cpu_{,try_}cmpxchg128().
> + *
> + * This obviously doesn't function as u128 should, but for the purpose
> + * of per-cpu cmpxchg128 it might just do.
> + */
> +typedef struct {
> +	u64 a, b;
> +} u128 __attribute__((aligned(16)));
> +
> +#define raw_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)		\
> +({									\
> +	typeof(pcp) *__p =3D raw_cpu_ptr(&(pcp));				\
> +	typeof(pcp) __val =3D *__p, __old =3D *(ovalp);			\
> +	bool __ret;							\
> +	if (!__builtin_memcmp(&__val, &__old, sizeof(pcp))) {		\
> +		*__p =3D nval;						\
> +		__ret =3D true;						\
> +	} else {							\
> +		*(ovalp) =3D __val;					\
> +		__ret =3D false;						\
> +	}								\
> +	__ret;								\
> +})
> +
> +#define raw_cpu_generic_cmpxchg_memcmp(pcp, oval, nval)			\
> +({									\
> +	typeof(pcp) __old =3D (oval);					\
> +	raw_cpu_generic_try_cmpxchg_memcpy(pcp, &__old, nval);		\
> +	__old;								\
> +})
> +
> +#define raw_cpu_cmpxchg128(pcp, oval, nval) \
> +	raw_cpu_generic_cmpxchg_memcmp(pcp, oval, nval)
> +#define raw_cpu_try_cmpxchg128(pcp, ovalp, nval) \
> +	raw_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)
> +
> +#define this_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)		\
> +({									\
> +	bool __ret;							\
> +	unsigned long __flags;						\
> +	raw_local_irq_save(__flags);					\
> +	__ret =3D raw_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval);	\
> +	raw_local_irq_restore(__flags);					\
> +	__ret;								\
> +})
> +
> +#define this_cpu_generic_cmpxchg_memcmp(pcp, oval, nval)		\
> +({									\
> +	typeof(pcp) __ret;						\
> +	unsigned long __flags;						\
> +	raw_local_irq_save(__flags);					\
> +	__ret =3D raw_cpu_generic_cmpxchg_memcmp(pcp, oval, nval);	\
> +	raw_local_irq_restore(__flags);					\
> +	__ret;								\
> +})
> +
> +#define this_cpu_cmpxchg128(pcp, oval, nval) \
> +	this_cpu_generic_cmpxchg_memcmp(pcp, oval, nval)
> +#define this_cpu_try_cmpxchg128(pcp, ovalp, nval) \
> +	this_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)
> +
> +#endif /* !__SIZEOF_INT128__ */
> +
> +#include <asm-generic/percpu.h>
> +
> +#endif /* _ASM_PARISC_PERCPU_H */

