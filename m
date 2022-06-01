Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A7A53A51D
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 14:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbiFAMfG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 08:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352922AbiFAMfA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 08:35:00 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531229CC99;
        Wed,  1 Jun 2022 05:34:56 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B0B9D5C02A2;
        Wed,  1 Jun 2022 08:34:55 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 01 Jun 2022 08:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654086895; x=
        1654173295; bh=fSQbl/szBKEFjumK1szz5KJfO0LgWM08+lmZhQlWlkY=; b=u
        X54DRoa2bs38NJ6LQEhLXi6FNwUkgS/PWWOCO4IORlCPvJAkU3n13yexq3utoX93
        jfGVuBKcuRy6bpRoz0r5L4s0BrYNZuc1wIOUuSJK9FE2oXECjO/alFtgrqein+SZ
        u89dif1y9Hf+RKEXU3NNnhPC7+Z9j7YDI3BehHMlAJY/YXVyc4LOYv8FBvDFaA/K
        Gw87h3gp2p0KVk4l+E+BAXlVyhOnkBR3Y3H1Xg9siTDHbLaZjXCKiGanWXXV3w6s
        j0NW0jhBDji/Rbws1JdeVlut0IG5jTPsC6ZQ0fx1o0VUcIcfzB+MX7uH1hsVV+rx
        UayBnqGlIUcX1z2H3xxTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654086895; x=
        1654173295; bh=fSQbl/szBKEFjumK1szz5KJfO0LgWM08+lmZhQlWlkY=; b=X
        e0NHiPyXYsX8h1xII0lifX9tmwMQIP71Kb/+QdaCXDnOzCoZrZmVdAmcy+4YCPiA
        vG/JMLjdt0xa2eDgSbAxev4945dM+rvJ1tJCaFD1rRlmtzp6UFb2Xxv9+wNB4NJU
        1kAVSGvCAOwkUVo4fdRH8JW6OYyf1kP6Qhwehanrmh6+HlcDaakIt3dYbi/c840X
        HR/zuVEbRMWE0IiL7lQV/Z8s0O7zVdMUTQjx0S2MhvoHsaILzXbK1wGQSg07Mbtz
        HV6YfCcNMUhVQrzk6aBJRKpvbxfPSaKXRIJRrb7BBTkWojFUQFB/ccFd3wIhq+Aa
        xqmW9E+gwPm+KlFCgVELQ==
X-ME-Sender: <xms:71yXYo_lGO7s1NMwnjwPTyYA9VPpVLrejVowDo0v3ewofijP7p4YyA>
    <xme:71yXYgtUoqh_BN9tkJnSwtJj0X6vyzkAQjoEHhSunXhwYhv8jVoui0PIiiLxIB4YB
    2lCdAFU5t8qLwhriF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledtgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudektdehleeihfejhfeuvdeghfeifeefhedujeehfeei
    jeffiefgiefgheeltedtnecuffhomhgrihhnpehtlhguphdrohhrghdphhgvrggurdhssg
    dplhgushdrshgspdhtlhgsvgigrdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hm
X-ME-Proxy: <xmx:71yXYuACJKCSgIZhQh2qxWQa5ygc1_2nUJ83LCxglzDQJHHUApbrGg>
    <xmx:71yXYoflTbUjfGVfPPCKnryxMrTfdzSPpOYN4vGwYwcz0jclldi07Q>
    <xmx:71yXYtPIGRVFb9WM-hCjBJnjGeMltbm9k01r_rMPuCMPvNI3QvhQKw>
    <xmx:71yXYqfS8R0BdC4FoxbL_ZDQXUlDTF3K0a8jA180lYhHOjXDKkoB8g>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 19D1836A006D; Wed,  1 Jun 2022 08:34:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <b70e5690-6bb5-4f2a-9b25-0067085050ae@www.fastmail.com>
In-Reply-To: <20220601100005.2989022-22-chenhuacai@loongson.cn>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-22-chenhuacai@loongson.cn>
Date:   Wed, 01 Jun 2022 13:34:31 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "David Airlie" <airlied@linux.ie>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Yanteng Si" <siyanteng@loongson.cn>,
        "Huacai Chen" <chenhuacai@gmail.com>,
        "Guo Ren" <guoren@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "WANG Xuerui" <git@xen0n.name>
Subject: Re: [PATCH V12 21/24] LoongArch: Add multi-processor (SMP) support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



=E5=9C=A82022=E5=B9=B46=E6=9C=881=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=8811:00=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> LoongArch-based procesors have 4, 8 or 16 cores per package. This patch
> adds multi-processor (SMP) support for LoongArch.
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

CSR IPI makes things much more easily than MIPS era.

Thanks.

> ---
>  arch/loongarch/Kconfig                  |  40 +-
>  arch/loongarch/include/asm/atomic.h     |   4 +
>  arch/loongarch/include/asm/barrier.h    | 108 ++++
>  arch/loongarch/include/asm/cmpxchg.h    |   1 +
>  arch/loongarch/include/asm/futex.h      |   1 +
>  arch/loongarch/include/asm/hardirq.h    |   2 +
>  arch/loongarch/include/asm/irq.h        |   2 +
>  arch/loongarch/include/asm/percpu.h     | 194 +++++++
>  arch/loongarch/include/asm/pgtable.h    |  21 +
>  arch/loongarch/include/asm/smp.h        | 124 ++++
>  arch/loongarch/include/asm/stackframe.h |  17 +-
>  arch/loongarch/include/asm/tlbflush.h   |  13 +
>  arch/loongarch/include/asm/topology.h   |   7 +-
>  arch/loongarch/kernel/Makefile          |   2 +
>  arch/loongarch/kernel/acpi.c            |  69 +++
>  arch/loongarch/kernel/asm-offsets.c     |  10 +
>  arch/loongarch/kernel/head.S            |  30 +
>  arch/loongarch/kernel/irq.c             |  13 +-
>  arch/loongarch/kernel/proc.c            |   5 +
>  arch/loongarch/kernel/process.c         |   7 +
>  arch/loongarch/kernel/reset.c           |  12 +
>  arch/loongarch/kernel/setup.c           |  26 +
>  arch/loongarch/kernel/smp.c             | 735 ++++++++++++++++++++++++
>  arch/loongarch/kernel/topology.c        |  43 +-
>  arch/loongarch/kernel/vmlinux.lds.S     |   4 +
>  arch/loongarch/mm/tlbex.S               |  69 +++
>  include/linux/cpuhotplug.h              |   1 +
>  27 files changed, 1550 insertions(+), 10 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/smp.h
>  create mode 100644 arch/loongarch/kernel/smp.c
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index d6ac80cf3922..b252a51946e3 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -64,6 +64,7 @@ config LOONGARCH
>  	select GENERIC_LIB_UCMPDI2
>  	select GENERIC_PCI_IOMAP
>  	select GENERIC_SCHED_CLOCK
> +	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_TIME_VSYSCALL
>  	select GPIOLIB
>  	select HAVE_ARCH_AUDITSYSCALL
> @@ -92,7 +93,7 @@ config LOONGARCH
>  	select HAVE_RSEQ
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_TIF_NOHZ
> -	select HAVE_VIRT_CPU_ACCOUNTING_GEN
> +	select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
>  	select IRQ_FORCED_THREADING
>  	select IRQ_LOONGARCH_CPU
>  	select MODULES_USE_ELF_RELA if MODULES
> @@ -306,6 +307,43 @@ config EFI_STUB
>  	  This kernel feature allows the kernel to be loaded directly by
>  	  EFI firmware without the use of a bootloader.
>=20
> +config SMP
> +	bool "Multi-Processing support"
> +	help
> +	  This enables support for systems with more than one CPU. If you ha=
ve
> +	  a system with only one CPU, say N. If you have a system with more
> +	  than one CPU, say Y.
> +
> +	  If you say N here, the kernel will run on uni- and multiprocessor
> +	  machines, but will use only one CPU of a multiprocessor machine. If
> +	  you say Y here, the kernel will run on many, but not all,
> +	  uniprocessor machines. On a uniprocessor machine, the kernel
> +	  will run faster if you say N here.
> +
> +	  See also the SMP-HOWTO available at=20
> <http://www.tldp.org/docs.html#howto>.
> +
> +	  If you don't know what to do here, say N.
> +
> +config HOTPLUG_CPU
> +	bool "Support for hot-pluggable CPUs"
> +	depends on SMP
> +	select GENERIC_IRQ_MIGRATION
> +	help
> +	  Say Y here to allow turning CPUs off and on. CPUs can be
> +	  controlled through /sys/devices/system/cpu.
> +	  (Note: power management support will enable this option
> +	    automatically on SMP systems. )
> +	  Say N if you want to disable CPU hotplug.
> +
> +config NR_CPUS
> +	int "Maximum number of CPUs (2-256)"
> +	range 2 256
> +	depends on SMP
> +	default "64"
> +	help
> +	  This allows you to specify the maximum number of CPUs which this
> +	  kernel will support.
> +
>  config FORCE_MAX_ZONEORDER
>  	int "Maximum zone order"
>  	range 14 64 if PAGE_SIZE_64KB
> diff --git a/arch/loongarch/include/asm/atomic.h=20
> b/arch/loongarch/include/asm/atomic.h
> index 932352342b12..979367ad4e2c 100644
> --- a/arch/loongarch/include/asm/atomic.h
> +++ b/arch/loongarch/include/asm/atomic.h
> @@ -162,6 +162,7 @@ static inline int arch_atomic_sub_if_positive(int=20
> i, atomic_t *v)
>  		"	sc.w	%1, %2					\n"
>  		"	beq	$zero, %1, 1b				\n"
>  		"2:							\n"
> +		__WEAK_LLSC_MB
>  		: "=3D&r" (result), "=3D&r" (temp),
>  		  "+" GCC_OFF_SMALL_ASM() (v->counter)
>  		: "I" (-i));
> @@ -174,6 +175,7 @@ static inline int arch_atomic_sub_if_positive(int=20
> i, atomic_t *v)
>  		"	sc.w	%1, %2					\n"
>  		"	beq	$zero, %1, 1b				\n"
>  		"2:							\n"
> +		__WEAK_LLSC_MB
>  		: "=3D&r" (result), "=3D&r" (temp),
>  		  "+" GCC_OFF_SMALL_ASM() (v->counter)
>  		: "r" (i));
> @@ -323,6 +325,7 @@ static inline long=20
> arch_atomic64_sub_if_positive(long i, atomic64_t *v)
>  		"	sc.d	%1, %2					\n"
>  		"	beq	%1, $zero, 1b				\n"
>  		"2:							\n"
> +		__WEAK_LLSC_MB
>  		: "=3D&r" (result), "=3D&r" (temp),
>  		  "+" GCC_OFF_SMALL_ASM() (v->counter)
>  		: "I" (-i));
> @@ -335,6 +338,7 @@ static inline long=20
> arch_atomic64_sub_if_positive(long i, atomic64_t *v)
>  		"	sc.d	%1, %2					\n"
>  		"	beq	%1, $zero, 1b				\n"
>  		"2:							\n"
> +		__WEAK_LLSC_MB
>  		: "=3D&r" (result), "=3D&r" (temp),
>  		  "+" GCC_OFF_SMALL_ASM() (v->counter)
>  		: "r" (i));
> diff --git a/arch/loongarch/include/asm/barrier.h=20
> b/arch/loongarch/include/asm/barrier.h
> index e57571bcaf4f..b6517eeeb141 100644
> --- a/arch/loongarch/include/asm/barrier.h
> +++ b/arch/loongarch/include/asm/barrier.h
> @@ -18,6 +18,19 @@
>  #define mb()		fast_mb()
>  #define iob()		fast_iob()
>=20
> +#define __smp_mb()	__asm__ __volatile__("dbar 0" : : : "memory")
> +#define __smp_rmb()	__asm__ __volatile__("dbar 0" : : : "memory")
> +#define __smp_wmb()	__asm__ __volatile__("dbar 0" : : : "memory")
> +
> +#ifdef CONFIG_SMP
> +#define __WEAK_LLSC_MB		"	dbar 0  \n"
> +#else
> +#define __WEAK_LLSC_MB		"		\n"
> +#endif
> +
> +#define __smp_mb__before_atomic()	barrier()
> +#define __smp_mb__after_atomic()	barrier()
> +
>  /**
>   * array_index_mask_nospec() - generate a ~0 mask when index < size, =
0=20
> otherwise
>   * @index: array element index
> @@ -46,6 +59,101 @@ static inline unsigned long=20
> array_index_mask_nospec(unsigned long index,
>  	return mask;
>  }
>=20
> +#define __smp_load_acquire(p)							\
> +({										\
> +	union { typeof(*p) __val; char __c[1]; } __u;				\
> +	unsigned long __tmp =3D 0;							\
> +	compiletime_assert_atomic_type(*p);					\
> +	switch (sizeof(*p)) {							\
> +	case 1:									\
> +		*(__u8 *)__u.__c =3D *(volatile __u8 *)p;				\
> +		__smp_mb();							\
> +		break;								\
> +	case 2:									\
> +		*(__u16 *)__u.__c =3D *(volatile __u16 *)p;			\
> +		__smp_mb();							\
> +		break;								\
> +	case 4:									\
> +		__asm__ __volatile__(						\
> +		"amor_db.w %[val], %[tmp], %[mem]	\n"				\
> +		: [val] "=3D&r" (*(__u32 *)__u.__c)				\
> +		: [mem] "ZB" (*(u32 *) p), [tmp] "r" (__tmp)			\
> +		: "memory");							\
> +		break;								\
> +	case 8:									\
> +		__asm__ __volatile__(						\
> +		"amor_db.d %[val], %[tmp], %[mem]	\n"				\
> +		: [val] "=3D&r" (*(__u64 *)__u.__c)				\
> +		: [mem] "ZB" (*(u64 *) p), [tmp] "r" (__tmp)			\
> +		: "memory");							\
> +		break;								\
> +	}									\
> +	(typeof(*p))__u.__val;								\
> +})
> +
> +#define __smp_store_release(p, v)						\
> +do {										\
> +	union { typeof(*p) __val; char __c[1]; } __u =3D				\
> +		{ .__val =3D (__force typeof(*p)) (v) };				\
> +	unsigned long __tmp;							\
> +	compiletime_assert_atomic_type(*p);					\
> +	switch (sizeof(*p)) {							\
> +	case 1:									\
> +		__smp_mb();							\
> +		*(volatile __u8 *)p =3D *(__u8 *)__u.__c;				\
> +		break;								\
> +	case 2:									\
> +		__smp_mb();							\
> +		*(volatile __u16 *)p =3D *(__u16 *)__u.__c;			\
> +		break;								\
> +	case 4:									\
> +		__asm__ __volatile__(						\
> +		"amswap_db.w %[tmp], %[val], %[mem]	\n"			\
> +		: [mem] "+ZB" (*(u32 *)p), [tmp] "=3D&r" (__tmp)			\
> +		: [val] "r" (*(__u32 *)__u.__c)					\
> +		: );								\
> +		break;								\
> +	case 8:									\
> +		__asm__ __volatile__(						\
> +		"amswap_db.d %[tmp], %[val], %[mem]	\n"			\
> +		: [mem] "+ZB" (*(u64 *)p), [tmp] "=3D&r" (__tmp)			\
> +		: [val] "r" (*(__u64 *)__u.__c)					\
> +		: );								\
> +		break;								\
> +	}									\
> +} while (0)
> +
> +#define __smp_store_mb(p, v)							\
> +do {										\
> +	union { typeof(p) __val; char __c[1]; } __u =3D				\
> +		{ .__val =3D (__force typeof(p)) (v) };				\
> +	unsigned long __tmp;							\
> +	switch (sizeof(p)) {							\
> +	case 1:									\
> +		*(volatile __u8 *)&p =3D *(__u8 *)__u.__c;			\
> +		__smp_mb();							\
> +		break;								\
> +	case 2:									\
> +		*(volatile __u16 *)&p =3D *(__u16 *)__u.__c;			\
> +		__smp_mb();							\
> +		break;								\
> +	case 4:									\
> +		__asm__ __volatile__(						\
> +		"amswap_db.w %[tmp], %[val], %[mem]	\n"			\
> +		: [mem] "+ZB" (*(u32 *)&p), [tmp] "=3D&r" (__tmp)			\
> +		: [val] "r" (*(__u32 *)__u.__c)					\
> +		: );								\
> +		break;								\
> +	case 8:									\
> +		__asm__ __volatile__(						\
> +		"amswap_db.d %[tmp], %[val], %[mem]	\n"			\
> +		: [mem] "+ZB" (*(u64 *)&p), [tmp] "=3D&r" (__tmp)			\
> +		: [val] "r" (*(__u64 *)__u.__c)					\
> +		: );								\
> +		break;								\
> +	}									\
> +} while (0)
> +
>  #include <asm-generic/barrier.h>
>=20
>  #endif /* __ASM_BARRIER_H */
> diff --git a/arch/loongarch/include/asm/cmpxchg.h=20
> b/arch/loongarch/include/asm/cmpxchg.h
> index 48613b872bc8..75b3a4478652 100644
> --- a/arch/loongarch/include/asm/cmpxchg.h
> +++ b/arch/loongarch/include/asm/cmpxchg.h
> @@ -59,6 +59,7 @@ static inline unsigned long __xchg(volatile void=20
> *ptr, unsigned long x,
>  	"	" st "	$t0, %1				\n"		\
>  	"	beq	$zero, $t0, 1b			\n"		\
>  	"2:						\n"		\
> +	__WEAK_LLSC_MB							\
>  	: "=3D&r" (__ret), "=3DZB"(*m)					\
>  	: "ZB"(*m), "Jr" (old), "Jr" (new)				\
>  	: "t0", "memory");						\
> diff --git a/arch/loongarch/include/asm/futex.h=20
> b/arch/loongarch/include/asm/futex.h
> index b27d55f92db7..9de8231694ec 100644
> --- a/arch/loongarch/include/asm/futex.h
> +++ b/arch/loongarch/include/asm/futex.h
> @@ -86,6 +86,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user=20
> *uaddr, u32 oldval, u32 newv
>  	"2:	sc.w	$t0, %2					\n"
>  	"	beq	$zero, $t0, 1b				\n"
>  	"3:							\n"
> +	__WEAK_LLSC_MB
>  	"	.section .fixup,\"ax\"				\n"
>  	"4:	li.d	%0, %6					\n"
>  	"	b	3b					\n"
> diff --git a/arch/loongarch/include/asm/hardirq.h=20
> b/arch/loongarch/include/asm/hardirq.h
> index d32f83938880..befe8184aa08 100644
> --- a/arch/loongarch/include/asm/hardirq.h
> +++ b/arch/loongarch/include/asm/hardirq.h
> @@ -21,4 +21,6 @@ typedef struct {
>=20
>  DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
>=20
> +#define __ARCH_IRQ_STAT
> +
>  #endif /* _ASM_HARDIRQ_H */
> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include=
/asm/irq.h
> index f3f1baf7027c..ace3ea6da72e 100644
> --- a/arch/loongarch/include/asm/irq.h
> +++ b/arch/loongarch/include/asm/irq.h
> @@ -125,6 +125,8 @@ extern struct irq_domain *pch_lpc_domain;
>  extern struct irq_domain *pch_msi_domain[MAX_IO_PICS];
>  extern struct irq_domain *pch_pic_domain[MAX_IO_PICS];
>=20
> +extern irqreturn_t loongson3_ipi_interrupt(int irq, void *dev);
> +
>  #include <asm-generic/irq.h>
>=20
>  #endif /* _ASM_IRQ_H */
> diff --git a/arch/loongarch/include/asm/percpu.h=20
> b/arch/loongarch/include/asm/percpu.h
> index b03d8f8b9fd3..34f15a6fb1e7 100644
> --- a/arch/loongarch/include/asm/percpu.h
> +++ b/arch/loongarch/include/asm/percpu.h
> @@ -5,6 +5,8 @@
>  #ifndef __ASM_PERCPU_H
>  #define __ASM_PERCPU_H
>=20
> +#include <asm/cmpxchg.h>
> +
>  /* Use r21 for fast access */
>  register unsigned long __my_cpu_offset __asm__("$r21");
>=20
> @@ -15,6 +17,198 @@ static inline void set_my_cpu_offset(unsigned long=
 off)
>  }
>  #define __my_cpu_offset __my_cpu_offset
>=20
> +#define PERCPU_OP(op, asm_op, c_op)					\
> +static inline unsigned long __percpu_##op(void *ptr,			\
> +			unsigned long val, int size)			\
> +{									\
> +	unsigned long ret;						\
> +									\
> +	switch (size) {							\
> +	case 4:								\
> +		__asm__ __volatile__(					\
> +		"am"#asm_op".w"	" %[ret], %[val], %[ptr]	\n"		\
> +		: [ret] "=3D&r" (ret), [ptr] "+ZB"(*(u32 *)ptr)		\
> +		: [val] "r" (val));					\
> +		break;							\
> +	case 8:								\
> +		__asm__ __volatile__(					\
> +		"am"#asm_op".d" " %[ret], %[val], %[ptr]	\n"		\
> +		: [ret] "=3D&r" (ret), [ptr] "+ZB"(*(u64 *)ptr)		\
> +		: [val] "r" (val));					\
> +		break;							\
> +	default:							\
> +		ret =3D 0;						\
> +		BUILD_BUG();						\
> +	}								\
> +									\
> +	return ret c_op val;						\
> +}
> +
> +PERCPU_OP(add, add, +)
> +PERCPU_OP(and, and, &)
> +PERCPU_OP(or, or, |)
> +#undef PERCPU_OP
> +
> +static inline unsigned long __percpu_read(void *ptr, int size)
> +{
> +	unsigned long ret;
> +
> +	switch (size) {
> +	case 1:
> +		__asm__ __volatile__ ("ldx.b %[ret], $r21, %[ptr]	\n"
> +		: [ret] "=3D&r"(ret)
> +		: [ptr] "r"(ptr)
> +		: "memory");
> +		break;
> +	case 2:
> +		__asm__ __volatile__ ("ldx.h %[ret], $r21, %[ptr]	\n"
> +		: [ret] "=3D&r"(ret)
> +		: [ptr] "r"(ptr)
> +		: "memory");
> +		break;
> +	case 4:
> +		__asm__ __volatile__ ("ldx.w %[ret], $r21, %[ptr]	\n"
> +		: [ret] "=3D&r"(ret)
> +		: [ptr] "r"(ptr)
> +		: "memory");
> +		break;
> +	case 8:
> +		__asm__ __volatile__ ("ldx.d %[ret], $r21, %[ptr]	\n"
> +		: [ret] "=3D&r"(ret)
> +		: [ptr] "r"(ptr)
> +		: "memory");
> +		break;
> +	default:
> +		ret =3D 0;
> +		BUILD_BUG();
> +	}
> +
> +	return ret;
> +}
> +
> +static inline void __percpu_write(void *ptr, unsigned long val, int s=
ize)
> +{
> +	switch (size) {
> +	case 1:
> +		__asm__ __volatile__("stx.b %[val], $r21, %[ptr]	\n"
> +		:
> +		: [val] "r" (val), [ptr] "r" (ptr)
> +		: "memory");
> +		break;
> +	case 2:
> +		__asm__ __volatile__("stx.h %[val], $r21, %[ptr]	\n"
> +		:
> +		: [val] "r" (val), [ptr] "r" (ptr)
> +		: "memory");
> +		break;
> +	case 4:
> +		__asm__ __volatile__("stx.w %[val], $r21, %[ptr]	\n"
> +		:
> +		: [val] "r" (val), [ptr] "r" (ptr)
> +		: "memory");
> +		break;
> +	case 8:
> +		__asm__ __volatile__("stx.d %[val], $r21, %[ptr]	\n"
> +		:
> +		: [val] "r" (val), [ptr] "r" (ptr)
> +		: "memory");
> +		break;
> +	default:
> +		BUILD_BUG();
> +	}
> +}
> +
> +static inline unsigned long __percpu_xchg(void *ptr, unsigned long va=
l,
> +						int size)
> +{
> +	switch (size) {
> +	case 4:
> +		return __xchg_asm("amswap.w", (volatile u32 *)ptr, (u32)val);
> +
> +	case 8:
> +		return __xchg_asm("amswap.d", (volatile u64 *)ptr, (u64)val);
> +
> +	default:
> +		BUILD_BUG();
> +	}
> +
> +	return 0;
> +}
> +
> +/* this_cpu_cmpxchg */
> +#define _protect_cmpxchg_local(pcp, o, n)			\
> +({								\
> +	typeof(*raw_cpu_ptr(&(pcp))) __ret;			\
> +	preempt_disable_notrace();				\
> +	__ret =3D cmpxchg_local(raw_cpu_ptr(&(pcp)), o, n);	\
> +	preempt_enable_notrace();				\
> +	__ret;							\
> +})
> +
> +#define _percpu_read(pcp)						\
> +({									\
> +	typeof(pcp) __retval;						\
> +	__retval =3D (typeof(pcp))__percpu_read(&(pcp), sizeof(pcp));	\
> +	__retval;							\
> +})
> +
> +#define _percpu_write(pcp, val)						\
> +do {									\
> +	__percpu_write(&(pcp), (unsigned long)(val), sizeof(pcp));	\
> +} while (0)								\
> +
> +#define _pcp_protect(operation, pcp, val)			\
> +({								\
> +	typeof(pcp) __retval;					\
> +	preempt_disable_notrace();				\
> +	__retval =3D (typeof(pcp))operation(raw_cpu_ptr(&(pcp)),	\
> +					  (val), sizeof(pcp));	\
> +	preempt_enable_notrace();				\
> +	__retval;						\
> +})
> +
> +#define _percpu_add(pcp, val) \
> +	_pcp_protect(__percpu_add, pcp, val)
> +
> +#define _percpu_add_return(pcp, val) _percpu_add(pcp, val)
> +
> +#define _percpu_and(pcp, val) \
> +	_pcp_protect(__percpu_and, pcp, val)
> +
> +#define _percpu_or(pcp, val) \
> +	_pcp_protect(__percpu_or, pcp, val)
> +
> +#define _percpu_xchg(pcp, val) ((typeof(pcp)) \
> +	_pcp_protect(__percpu_xchg, pcp, (unsigned long)(val)))
> +
> +#define this_cpu_add_4(pcp, val) _percpu_add(pcp, val)
> +#define this_cpu_add_8(pcp, val) _percpu_add(pcp, val)
> +
> +#define this_cpu_add_return_4(pcp, val) _percpu_add_return(pcp, val)
> +#define this_cpu_add_return_8(pcp, val) _percpu_add_return(pcp, val)
> +
> +#define this_cpu_and_4(pcp, val) _percpu_and(pcp, val)
> +#define this_cpu_and_8(pcp, val) _percpu_and(pcp, val)
> +
> +#define this_cpu_or_4(pcp, val) _percpu_or(pcp, val)
> +#define this_cpu_or_8(pcp, val) _percpu_or(pcp, val)
> +
> +#define this_cpu_read_1(pcp) _percpu_read(pcp)
> +#define this_cpu_read_2(pcp) _percpu_read(pcp)
> +#define this_cpu_read_4(pcp) _percpu_read(pcp)
> +#define this_cpu_read_8(pcp) _percpu_read(pcp)
> +
> +#define this_cpu_write_1(pcp, val) _percpu_write(pcp, val)
> +#define this_cpu_write_2(pcp, val) _percpu_write(pcp, val)
> +#define this_cpu_write_4(pcp, val) _percpu_write(pcp, val)
> +#define this_cpu_write_8(pcp, val) _percpu_write(pcp, val)
> +
> +#define this_cpu_xchg_4(pcp, val) _percpu_xchg(pcp, val)
> +#define this_cpu_xchg_8(pcp, val) _percpu_xchg(pcp, val)
> +
> +#define this_cpu_cmpxchg_4(ptr, o, n) _protect_cmpxchg_local(ptr, o, =
n)
> +#define this_cpu_cmpxchg_8(ptr, o, n) _protect_cmpxchg_local(ptr, o, =
n)
> +
>  #include <asm-generic/percpu.h>
>=20
>  #endif /* __ASM_PERCPU_H */
> diff --git a/arch/loongarch/include/asm/pgtable.h=20
> b/arch/loongarch/include/asm/pgtable.h
> index 8920dd8b297b..5e33987d0a13 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -279,8 +279,29 @@ static inline void set_pte(pte_t *ptep, pte_t=20
> pteval)
>  		 * Make sure the buddy is global too (if it's !none,
>  		 * it better already be global)
>  		 */
> +#ifdef CONFIG_SMP
> +		/*
> +		 * For SMP, multiple CPUs can race, so we need to do
> +		 * this atomically.
> +		 */
> +		unsigned long page_global =3D _PAGE_GLOBAL;
> +		unsigned long tmp;
> +
> +		__asm__ __volatile__ (
> +		"1:"	__LL	"%[tmp], %[buddy]		\n"
> +		"	bnez	%[tmp], 2f			\n"
> +		"	 or	%[tmp], %[tmp], %[global]	\n"
> +			__SC	"%[tmp], %[buddy]		\n"
> +		"	beqz	%[tmp], 1b			\n"
> +		"	nop					\n"
> +		"2:						\n"
> +		__WEAK_LLSC_MB
> +		: [buddy] "+m" (buddy->pte), [tmp] "=3D&r" (tmp)
> +		: [global] "r" (page_global));
> +#else /* !CONFIG_SMP */
>  		if (pte_none(*buddy))
>  			pte_val(*buddy) =3D pte_val(*buddy) | _PAGE_GLOBAL;
> +#endif /* CONFIG_SMP */
>  	}
>  }
>=20
> diff --git a/arch/loongarch/include/asm/smp.h=20
> b/arch/loongarch/include/asm/smp.h
> new file mode 100644
> index 000000000000..551e1f37c705
> --- /dev/null
> +++ b/arch/loongarch/include/asm/smp.h
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Author: Huacai Chen <chenhuacai@loongson.cn>
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM_SMP_H
> +#define __ASM_SMP_H
> +
> +#include <linux/atomic.h>
> +#include <linux/bitops.h>
> +#include <linux/linkage.h>
> +#include <linux/smp.h>
> +#include <linux/threads.h>
> +#include <linux/cpumask.h>
> +
> +void loongson3_smp_setup(void);
> +void loongson3_prepare_cpus(unsigned int max_cpus);
> +void loongson3_boot_secondary(int cpu, struct task_struct *idle);
> +void loongson3_init_secondary(void);
> +void loongson3_smp_finish(void);
> +void loongson3_send_ipi_single(int cpu, unsigned int action);
> +void loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int=20
> action);
> +#ifdef CONFIG_HOTPLUG_CPU
> +int loongson3_cpu_disable(void);
> +void loongson3_cpu_die(unsigned int cpu);
> +#endif
> +
> +#ifdef CONFIG_SMP
> +
> +static inline void plat_smp_setup(void)
> +{
> +	loongson3_smp_setup();
> +}
> +
> +#else /* !CONFIG_SMP */
> +
> +static inline void plat_smp_setup(void) { }
> +
> +#endif /* !CONFIG_SMP */
> +
> +extern int smp_num_siblings;
> +extern int num_processors;
> +extern int disabled_cpus;
> +extern cpumask_t cpu_sibling_map[];
> +extern cpumask_t cpu_core_map[];
> +extern cpumask_t cpu_foreign_map[];
> +
> +static inline int raw_smp_processor_id(void)
> +{
> +#if defined(__VDSO__)
> +	extern int vdso_smp_processor_id(void)
> +		__compiletime_error("VDSO should not call smp_processor_id()");
> +	return vdso_smp_processor_id();
> +#else
> +	return current_thread_info()->cpu;
> +#endif
> +}
> +#define raw_smp_processor_id raw_smp_processor_id
> +
> +/* Map from cpu id to sequential logical cpu number.  This will only
> + * not be idempotent when cpus failed to come on-line.	*/
> +extern int __cpu_number_map[NR_CPUS];
> +#define cpu_number_map(cpu)  __cpu_number_map[cpu]
> +
> +/* The reverse map from sequential logical cpu number to cpu id.  */
> +extern int __cpu_logical_map[NR_CPUS];
> +#define cpu_logical_map(cpu)  __cpu_logical_map[cpu]
> +
> +#define cpu_physical_id(cpu)	cpu_logical_map(cpu)
> +
> +#define SMP_BOOT_CPU		0x1
> +#define SMP_RESCHEDULE		0x2
> +#define SMP_CALL_FUNCTION	0x4
> +
> +struct secondary_data {
> +	unsigned long stack;
> +	unsigned long thread_info;
> +};
> +extern struct secondary_data cpuboot_data;
> +
> +extern asmlinkage void smpboot_entry(void);
> +
> +extern void calculate_cpu_foreign_map(void);
> +
> +/*
> + * Generate IPI list text
> + */
> +extern void show_ipi_list(struct seq_file *p, int prec);
> +
> +/*
> + * This function sends a 'reschedule' IPI to another CPU.
> + * it goes straight through and wastes no time serializing
> + * anything. Worst case is that we lose a reschedule ...
> + */
> +static inline void smp_send_reschedule(int cpu)
> +{
> +	loongson3_send_ipi_single(cpu, SMP_RESCHEDULE);
> +}
> +
> +static inline void arch_send_call_function_single_ipi(int cpu)
> +{
> +	loongson3_send_ipi_single(cpu, SMP_CALL_FUNCTION);
> +}
> +
> +static inline void arch_send_call_function_ipi_mask(const struct=20
> cpumask *mask)
> +{
> +	loongson3_send_ipi_mask(mask, SMP_CALL_FUNCTION);
> +}
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +static inline int __cpu_disable(void)
> +{
> +	return loongson3_cpu_disable();
> +}
> +
> +static inline void __cpu_die(unsigned int cpu)
> +{
> +	loongson3_cpu_die(cpu);
> +}
> +
> +extern void play_dead(void);
> +#endif
> +
> +#endif /* __ASM_SMP_H */
> diff --git a/arch/loongarch/include/asm/stackframe.h=20
> b/arch/loongarch/include/asm/stackframe.h
> index 44151b878d00..4ca953062b5b 100644
> --- a/arch/loongarch/include/asm/stackframe.h
> +++ b/arch/loongarch/include/asm/stackframe.h
> @@ -77,17 +77,24 @@
>   * new value in sp.
>   */
>  	.macro	get_saved_sp docfi=3D0
> -	la.abs	t1, kernelsp
> -	move	t0, sp
> +	la.abs	  t1, kernelsp
> +#ifdef CONFIG_SMP
> +	csrrd	  t0, PERCPU_BASE_KS
> +	LONG_ADD  t1, t1, t0
> +#endif
> +	move	  t0, sp
>  	.if \docfi
>  	.cfi_register sp, t0
>  	.endif
> -	LONG_L	sp, t1, 0
> +	LONG_L	  sp, t1, 0
>  	.endm
>=20
>  	.macro	set_saved_sp stackp temp temp2
> -	la.abs	\temp, kernelsp
> -	LONG_S	\stackp, \temp, 0
> +	la.abs	  \temp, kernelsp
> +#ifdef CONFIG_SMP
> +	LONG_ADD  \temp, \temp, u0
> +#endif
> +	LONG_S	  \stackp, \temp, 0
>  	.endm
>=20
>  	.macro	SAVE_SOME docfi=3D0
> diff --git a/arch/loongarch/include/asm/tlbflush.h=20
> b/arch/loongarch/include/asm/tlbflush.h
> index 36bd6d11dc2d..a0785e590681 100644
> --- a/arch/loongarch/include/asm/tlbflush.h
> +++ b/arch/loongarch/include/asm/tlbflush.h
> @@ -25,6 +25,17 @@ extern void local_flush_tlb_kernel_range(unsigned=20
> long start, unsigned long end)
>  extern void local_flush_tlb_page(struct vm_area_struct *vma, unsigned=20
> long page);
>  extern void local_flush_tlb_one(unsigned long vaddr);
>=20
> +#ifdef CONFIG_SMP
> +
> +extern void flush_tlb_all(void);
> +extern void flush_tlb_mm(struct mm_struct *);
> +extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long=
,=20
> unsigned long);
> +extern void flush_tlb_kernel_range(unsigned long, unsigned long);
> +extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
> +extern void flush_tlb_one(unsigned long vaddr);
> +
> +#else /* CONFIG_SMP */
> +
>  #define flush_tlb_all()			local_flush_tlb_all()
>  #define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
>  #define flush_tlb_range(vma, vmaddr, end)	local_flush_tlb_range(vma,=20
> vmaddr, end)
> @@ -32,4 +43,6 @@ extern void local_flush_tlb_one(unsigned long vaddr);
>  #define flush_tlb_page(vma, page)	local_flush_tlb_page(vma, page)
>  #define flush_tlb_one(vaddr)		local_flush_tlb_one(vaddr)
>=20
> +#endif /* CONFIG_SMP */
> +
>  #endif /* __ASM_TLBFLUSH_H */
> diff --git a/arch/loongarch/include/asm/topology.h=20
> b/arch/loongarch/include/asm/topology.h
> index 9ac71a25207a..da135841e5b1 100644
> --- a/arch/loongarch/include/asm/topology.h
> +++ b/arch/loongarch/include/asm/topology.h
> @@ -7,7 +7,12 @@
>=20
>  #include <linux/smp.h>
>=20
> -#define cpu_logical_map(cpu)  0
> +#ifdef CONFIG_SMP
> +#define topology_physical_package_id(cpu)	(cpu_data[cpu].package)
> +#define topology_core_id(cpu)			(cpu_data[cpu].core)
> +#define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
> +#define topology_sibling_cpumask(cpu)		(&cpu_sibling_map[cpu])
> +#endif
>=20
>  #include <asm-generic/topology.h>
>=20
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Ma=
kefile
> index e5a3b2fb9961..2cb6f698716a 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -18,4 +18,6 @@ obj-$(CONFIG_MODULES)		+=3D module.o module-sections=
.o
>=20
>  obj-$(CONFIG_PROC_FS)		+=3D proc.o
>=20
> +obj-$(CONFIG_SMP)		+=3D smp.o
> +
>  CPPFLAGS_vmlinux.lds		:=3D $(KBUILD_CFLAGS)
> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi=
.c
> index a644220bb426..181c59493b63 100644
> --- a/arch/loongarch/kernel/acpi.c
> +++ b/arch/loongarch/kernel/acpi.c
> @@ -137,8 +137,44 @@ void __init acpi_boot_table_init(void)
>  	}
>  }
>=20
> +static int set_processor_mask(u32 id, u32 flags)
> +{
> +
> +	int cpu, cpuid =3D id;
> +
> +	if (num_processors >=3D nr_cpu_ids) {
> +		pr_warn(PREFIX "nr_cpus/possible_cpus limit of %i reached."
> +			" processor 0x%x ignored.\n", nr_cpu_ids, cpuid);
> +
> +		return -ENODEV;
> +
> +	}
> +	if (cpuid =3D=3D loongson_sysconf.boot_cpu_id)
> +		cpu =3D 0;
> +	else
> +		cpu =3D cpumask_next_zero(-1, cpu_present_mask);
> +
> +	if (flags & ACPI_MADT_ENABLED) {
> +		num_processors++;
> +		set_cpu_possible(cpu, true);
> +		set_cpu_present(cpu, true);
> +		__cpu_number_map[cpuid] =3D cpu;
> +		__cpu_logical_map[cpu] =3D cpuid;
> +	} else
> +		disabled_cpus++;
> +
> +	return cpu;
> +}
> +
>  static void __init acpi_process_madt(void)
>  {
> +	int i;
> +
> +	for (i =3D 0; i < NR_CPUS; i++) {
> +		__cpu_number_map[i] =3D -1;
> +		__cpu_logical_map[i] =3D -1;
> +	}
> +
>  	loongson_sysconf.nr_cpus =3D num_processors;
>  }
>=20
> @@ -167,3 +203,36 @@ void __init=20
> arch_reserve_mem_area(acpi_physical_address addr, size_t size)
>  {
>  	memblock_reserve(addr, size);
>  }
> +
> +#ifdef CONFIG_ACPI_HOTPLUG_CPU
> +
> +#include <acpi/processor.h>
> +
> +int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id=
,=20
> int *pcpu)
> +{
> +	int cpu;
> +
> +	cpu =3D set_processor_mask(physid, ACPI_MADT_ENABLED);
> +	if (cpu < 0) {
> +		pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
> +		return cpu;
> +	}
> +
> +	*pcpu =3D cpu;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(acpi_map_cpu);
> +
> +int acpi_unmap_cpu(int cpu)
> +{
> +	set_cpu_present(cpu, false);
> +	num_processors--;
> +
> +	pr_info("cpu%d hot remove!\n", cpu);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(acpi_unmap_cpu);
> +
> +#endif /* CONFIG_ACPI_HOTPLUG_CPU */
> diff --git a/arch/loongarch/kernel/asm-offsets.c=20
> b/arch/loongarch/kernel/asm-offsets.c
> index 3531e3c60a6e..bfb65eb2844f 100644
> --- a/arch/loongarch/kernel/asm-offsets.c
> +++ b/arch/loongarch/kernel/asm-offsets.c
> @@ -252,3 +252,13 @@ void output_signal_defines(void)
>  	DEFINE(_SIGXFSZ, SIGXFSZ);
>  	BLANK();
>  }
> +
> +#ifdef CONFIG_SMP
> +void output_smpboot_defines(void)
> +{
> +	COMMENT("Linux smp cpu boot offsets.");
> +	OFFSET(CPU_BOOT_STACK, secondary_data, stack);
> +	OFFSET(CPU_BOOT_TINFO, secondary_data, thread_info);
> +	BLANK();
> +}
> +#endif
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head=
.S
> index 4cb79e9c70f5..8ca45cf17433 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -96,4 +96,34 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
>=20
>  SYM_CODE_END(kernel_entry)
>=20
> +#ifdef CONFIG_SMP
> +
> +/*
> + * SMP slave cpus entry point.	Board specific code for bootstrap call=
s this
> + * function after setting up the stack and tp registers.
> + */
> +SYM_CODE_START(smpboot_entry)
> +	li.d		t0, CSR_DMW0_INIT	# UC, PLV0
> +	csrwr		t0, LOONGARCH_CSR_DMWIN0
> +	li.d		t0, CSR_DMW1_INIT	# CA, PLV0
> +	csrwr		t0, LOONGARCH_CSR_DMWIN1
> +	li.w		t0, 0xb0		# PLV=3D0, IE=3D0, PG=3D1
> +	csrwr		t0, LOONGARCH_CSR_CRMD
> +	li.w		t0, 0x04		# PLV=3D0, PIE=3D1, PWE=3D0
> +	csrwr		t0, LOONGARCH_CSR_PRMD
> +	li.w		t0, 0x00		# FPE=3D0, SXE=3D0, ASXE=3D0, BTE=3D0
> +	csrwr		t0, LOONGARCH_CSR_EUEN
> +
> +	la.abs		t0, cpuboot_data
> +	ld.d		sp, t0, CPU_BOOT_STACK
> +	ld.d		tp, t0, CPU_BOOT_TINFO
> +
> +	la.abs	t0, 0f
> +	jirl	zero, t0, 0
> +0:
> +	bl		start_secondary
> +SYM_CODE_END(smpboot_entry)
> +
> +#endif /* CONFIG_SMP */
> +
>  SYM_ENTRY(kernel_entry_end, SYM_L_GLOBAL, SYM_A_NONE)
> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
> index 9bd07edf0bce..4b671d305ede 100644
> --- a/arch/loongarch/kernel/irq.c
> +++ b/arch/loongarch/kernel/irq.c
> @@ -47,13 +47,17 @@ asmlinkage void spurious_interrupt(void)
>=20
>  int arch_show_interrupts(struct seq_file *p, int prec)
>  {
> +#ifdef CONFIG_SMP
> +	show_ipi_list(p, prec);
> +#endif
>  	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count=
));
>  	return 0;
>  }
>=20
>  void __init init_IRQ(void)
>  {
> -	int i;
> +	int i, r, ipi_irq;
> +	static int ipi_dummy_dev;
>  	unsigned int order =3D get_order(IRQ_STACK_SIZE);
>  	struct page *page;
>=20
> @@ -61,6 +65,13 @@ void __init init_IRQ(void)
>  	clear_csr_estat(ESTATF_IP);
>=20
>  	irqchip_init();
> +#ifdef CONFIG_SMP
> +	ipi_irq =3D EXCCODE_IPI - EXCCODE_INT_START;
> +	irq_set_percpu_devid(ipi_irq);
> +	r =3D request_percpu_irq(ipi_irq, loongson3_ipi_interrupt, "IPI",=20
> &ipi_dummy_dev);
> +	if (r < 0)
> +		panic("IPI IRQ request failed\n");
> +#endif
>=20
>  	for (i =3D 0; i < NR_IRQS; i++)
>  		irq_set_noprobe(i);
> diff --git a/arch/loongarch/kernel/proc.c b/arch/loongarch/kernel/proc=
.c
> index d25592a29196..1effc73850fe 100644
> --- a/arch/loongarch/kernel/proc.c
> +++ b/arch/loongarch/kernel/proc.c
> @@ -35,6 +35,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  	unsigned int fp_version =3D cpu_data[n].fpu_vers;
>  	struct proc_cpuinfo_notifier_args proc_cpuinfo_notifier_args;
>=20
> +#ifdef CONFIG_SMP
> +	if (!cpu_online(n))
> +		return 0;
> +#endif
> +
>  	/*
>  	 * For the first processor also print the system type
>  	 */
> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/p=
rocess.c
> index 54020223068f..6d944d65f600 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
> @@ -53,6 +53,13 @@
>  unsigned long boot_option_idle_override =3D IDLE_NO_OVERRIDE;
>  EXPORT_SYMBOL(boot_option_idle_override);
>=20
> +#ifdef CONFIG_HOTPLUG_CPU
> +void arch_cpu_idle_dead(void)
> +{
> +	play_dead();
> +}
> +#endif
> +
>  asmlinkage void ret_from_fork(void);
>  asmlinkage void ret_from_kernel_thread(void);
>=20
> diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/res=
et.c
> index ef484ce43c5c..2b86469e4718 100644
> --- a/arch/loongarch/kernel/reset.c
> +++ b/arch/loongarch/kernel/reset.c
> @@ -65,16 +65,28 @@ EXPORT_SYMBOL(pm_power_off);
>=20
>  void machine_halt(void)
>  {
> +#ifdef CONFIG_SMP
> +	preempt_disable();
> +	smp_send_stop();
> +#endif
>  	default_halt();
>  }
>=20
>  void machine_power_off(void)
>  {
> +#ifdef CONFIG_SMP
> +	preempt_disable();
> +	smp_send_stop();
> +#endif
>  	pm_power_off();
>  }
>=20
>  void machine_restart(char *command)
>  {
> +#ifdef CONFIG_SMP
> +	preempt_disable();
> +	smp_send_stop();
> +#endif
>  	do_kernel_restart(command);
>  	pm_restart();
>  }
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/set=
up.c
> index 29f3b82cd0a5..34a3011f679e 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -38,6 +38,7 @@
>  #include <asm/pgalloc.h>
>  #include <asm/sections.h>
>  #include <asm/setup.h>
> +#include <asm/smp.h>
>  #include <asm/time.h>
>=20
>  #define SMBIOS_BIOSSIZE_OFFSET		0x09
> @@ -322,6 +323,29 @@ static int __init reserve_memblock_reserved_regio=
ns(void)
>  }
>  arch_initcall(reserve_memblock_reserved_regions);
>=20
> +#ifdef CONFIG_SMP
> +static void __init prefill_possible_map(void)
> +{
> +	int i, possible;
> +
> +	possible =3D num_processors + disabled_cpus;
> +	if (possible > nr_cpu_ids)
> +		possible =3D nr_cpu_ids;
> +
> +	pr_info("SMP: Allowing %d CPUs, %d hotplug CPUs\n",
> +			possible, max((possible - num_processors), 0));
> +
> +	for (i =3D 0; i < possible; i++)
> +		set_cpu_possible(i, true);
> +	for (; i < NR_CPUS; i++)
> +		set_cpu_possible(i, false);
> +
> +	nr_cpu_ids =3D possible;
> +}
> +#else
> +static inline void prefill_possible_map(void) {}
> +#endif
> +
>  void __init setup_arch(char **cmdline_p)
>  {
>  	cpu_probe();
> @@ -336,6 +360,8 @@ void __init setup_arch(char **cmdline_p)
>  	arch_mem_init(cmdline_p);
>=20
>  	resource_init();
> +	plat_smp_setup();
> +	prefill_possible_map();
>=20
>  	paging_init();
>  }
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> new file mode 100644
> index 000000000000..99ba7a56edf9
> --- /dev/null
> +++ b/arch/loongarch/kernel/smp.c
> @@ -0,0 +1,735 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + *
> + * Derived from MIPS:
> + * Copyright (C) 2000, 2001 Kanoj Sarcar
> + * Copyright (C) 2000, 2001 Ralf Baechle
> + * Copyright (C) 2000, 2001 Silicon Graphics, Inc.
> + * Copyright (C) 2000, 2001, 2003 Broadcom Corporation
> + */
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/seq_file.h>
> +#include <linux/smp.h>
> +#include <linux/threads.h>
> +#include <linux/export.h>
> +#include <linux/time.h>
> +#include <linux/tracepoint.h>
> +#include <linux/sched/hotplug.h>
> +#include <linux/sched/task_stack.h>
> +
> +#include <asm/cpu.h>
> +#include <asm/idle.h>
> +#include <asm/loongson.h>
> +#include <asm/mmu_context.h>
> +#include <asm/processor.h>
> +#include <asm/setup.h>
> +#include <asm/time.h>
> +
> +int __cpu_number_map[NR_CPUS];   /* Map physical to logical */
> +EXPORT_SYMBOL(__cpu_number_map);
> +
> +int __cpu_logical_map[NR_CPUS];		/* Map logical to physical */
> +EXPORT_SYMBOL(__cpu_logical_map);
> +
> +/* Number of threads (siblings) per CPU core */
> +int smp_num_siblings =3D 1;
> +EXPORT_SYMBOL(smp_num_siblings);
> +
> +/* Representing the threads (siblings) of each logical CPU */
> +cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
> +EXPORT_SYMBOL(cpu_sibling_map);
> +
> +/* Representing the core map of multi-core chips of each logical CPU =
*/
> +cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
> +EXPORT_SYMBOL(cpu_core_map);
> +
> +static DECLARE_COMPLETION(cpu_starting);
> +static DECLARE_COMPLETION(cpu_running);
> +
> +/*
> + * A logcal cpu mask containing only one VPE per core to
> + * reduce the number of IPIs on large MT systems.
> + */
> +cpumask_t cpu_foreign_map[NR_CPUS] __read_mostly;
> +EXPORT_SYMBOL(cpu_foreign_map);
> +
> +/* representing cpus for which sibling maps can be computed */
> +static cpumask_t cpu_sibling_setup_map;
> +
> +/* representing cpus for which core maps can be computed */
> +static cpumask_t cpu_core_setup_map;
> +
> +struct secondary_data cpuboot_data;
> +static DEFINE_PER_CPU(int, cpu_state);
> +DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
> +EXPORT_PER_CPU_SYMBOL(irq_stat);
> +
> +enum ipi_msg_type {
> +	IPI_RESCHEDULE,
> +	IPI_CALL_FUNCTION,
> +};
> +
> +static const char *ipi_types[NR_IPI] __tracepoint_string =3D {
> +	[IPI_RESCHEDULE] =3D "Rescheduling interrupts",
> +	[IPI_CALL_FUNCTION] =3D "Function call interrupts",
> +};
> +
> +void show_ipi_list(struct seq_file *p, int prec)
> +{
> +	unsigned int cpu, i;
> +
> +	for (i =3D 0; i < NR_IPI; i++) {
> +		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i, prec >=3D 4 ? " " : "=
");
> +		for_each_online_cpu(cpu)
> +			seq_printf(p, "%10u ", per_cpu(irq_stat, cpu).ipi_irqs[i]);
> +		seq_printf(p, " LoongArch  %d  %s\n", i + 1, ipi_types[i]);
> +	}
> +}
> +
> +/* Send mailbox buffer via Mail_Send */
> +static void csr_mail_send(uint64_t data, int cpu, int mailbox)
> +{
> +	uint64_t val;
> +
> +	/* Send high 32 bits */
> +	val =3D IOCSR_MBUF_SEND_BLOCKING;
> +	val |=3D (IOCSR_MBUF_SEND_BOX_HI(mailbox) << IOCSR_MBUF_SEND_BOX_SHI=
FT);
> +	val |=3D (cpu << IOCSR_MBUF_SEND_CPU_SHIFT);
> +	val |=3D (data & IOCSR_MBUF_SEND_H32_MASK);
> +	iocsr_write64(val, LOONGARCH_IOCSR_MBUF_SEND);
> +
> +	/* Send low 32 bits */
> +	val =3D IOCSR_MBUF_SEND_BLOCKING;
> +	val |=3D (IOCSR_MBUF_SEND_BOX_LO(mailbox) << IOCSR_MBUF_SEND_BOX_SHI=
FT);
> +	val |=3D (cpu << IOCSR_MBUF_SEND_CPU_SHIFT);
> +	val |=3D (data << IOCSR_MBUF_SEND_BUF_SHIFT);
> +	iocsr_write64(val, LOONGARCH_IOCSR_MBUF_SEND);
> +};
> +
> +static u32 ipi_read_clear(int cpu)
> +{
> +	u32 action;
> +
> +	/* Load the ipi register to figure out what we're supposed to do */
> +	action =3D iocsr_read32(LOONGARCH_IOCSR_IPI_STATUS);
> +	/* Clear the ipi register to clear the interrupt */
> +	iocsr_write32(action, LOONGARCH_IOCSR_IPI_CLEAR);
> +	smp_mb();
> +
> +	return action;
> +}
> +
> +static void ipi_write_action(int cpu, u32 action)
> +{
> +	unsigned int irq =3D 0;
> +
> +	while ((irq =3D ffs(action))) {
> +		uint32_t val =3D IOCSR_IPI_SEND_BLOCKING;
> +
> +		val |=3D (irq - 1);
> +		val |=3D (cpu << IOCSR_IPI_SEND_CPU_SHIFT);
> +		iocsr_write32(val, LOONGARCH_IOCSR_IPI_SEND);
> +		action &=3D ~BIT(irq - 1);
> +	}
> +}
> +
> +void loongson3_send_ipi_single(int cpu, unsigned int action)
> +{
> +	ipi_write_action(cpu_logical_map(cpu), (u32)action);
> +}
> +
> +void loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int=20
> action)
> +{
> +	unsigned int i;
> +
> +	for_each_cpu(i, mask)
> +		ipi_write_action(cpu_logical_map(i), (u32)action);
> +}
> +
> +irqreturn_t loongson3_ipi_interrupt(int irq, void *dev)
> +{
> +	unsigned int action;
> +	unsigned int cpu =3D smp_processor_id();
> +
> +	action =3D ipi_read_clear(cpu_logical_map(cpu));
> +
> +	if (action & SMP_RESCHEDULE) {
> +		scheduler_ipi();
> +		per_cpu(irq_stat, cpu).ipi_irqs[IPI_RESCHEDULE]++;
> +	}
> +
> +	if (action & SMP_CALL_FUNCTION) {
> +		generic_smp_call_function_interrupt();
> +		per_cpu(irq_stat, cpu).ipi_irqs[IPI_CALL_FUNCTION]++;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +void __init loongson3_smp_setup(void)
> +{
> +	cpu_data[0].core =3D cpu_logical_map(0) %=20
> loongson_sysconf.cores_per_package;
> +	cpu_data[0].package =3D cpu_logical_map(0) /=20
> loongson_sysconf.cores_per_package;
> +
> +	iocsr_write32(0xffffffff, LOONGARCH_IOCSR_IPI_EN);
> +	pr_info("Detected %i available CPU(s)\n", loongson_sysconf.nr_cpus);
> +}
> +
> +void __init loongson3_prepare_cpus(unsigned int max_cpus)
> +{
> +	int i =3D 0;
> +
> +	for (i =3D 0; i < loongson_sysconf.nr_cpus; i++) {
> +		set_cpu_present(i, true);
> +		csr_mail_send(0, __cpu_logical_map[i], 0);
> +	}
> +
> +	per_cpu(cpu_state, smp_processor_id()) =3D CPU_ONLINE;
> +}
> +
> +/*
> + * Setup the PC, SP, and TP of a secondary processor and start it=20
> running!
> + */
> +void loongson3_boot_secondary(int cpu, struct task_struct *idle)
> +{
> +	unsigned long entry;
> +
> +	pr_info("Booting CPU#%d...\n", cpu);
> +
> +	entry =3D __pa_symbol((unsigned long)&smpboot_entry);
> +	cpuboot_data.stack =3D (unsigned long)__KSTK_TOS(idle);
> +	cpuboot_data.thread_info =3D (unsigned long)task_thread_info(idle);
> +
> +	csr_mail_send(entry, cpu_logical_map(cpu), 0);
> +
> +	loongson3_send_ipi_single(cpu, SMP_BOOT_CPU);
> +}
> +
> +/*
> + * SMP init and finish on secondary CPUs
> + */
> +void loongson3_init_secondary(void)
> +{
> +	unsigned int cpu =3D smp_processor_id();
> +	unsigned int imask =3D ECFGF_IP0 | ECFGF_IP1 | ECFGF_IP2 |
> +			     ECFGF_IPI | ECFGF_PMC | ECFGF_TIMER;
> +
> +	change_csr_ecfg(ECFG0_IM, imask);
> +
> +	iocsr_write32(0xffffffff, LOONGARCH_IOCSR_IPI_EN);
> +
> +	per_cpu(cpu_state, cpu) =3D CPU_ONLINE;
> +	cpu_data[cpu].core =3D
> +		     cpu_logical_map(cpu) % loongson_sysconf.cores_per_package;
> +	cpu_data[cpu].package =3D
> +		     cpu_logical_map(cpu) / loongson_sysconf.cores_per_package;
> +}
> +
> +void loongson3_smp_finish(void)
> +{
> +	local_irq_enable();
> +	iocsr_write64(0, LOONGARCH_IOCSR_MBUF0);
> +	pr_info("CPU#%d finished\n", smp_processor_id());
> +}
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +
> +static bool io_master(int cpu)
> +{
> +	if (cpu =3D=3D 0)
> +		return true;
> +
> +	return false;
> +}
> +
> +int loongson3_cpu_disable(void)
> +{
> +	unsigned long flags;
> +	unsigned int cpu =3D smp_processor_id();
> +
> +	if (io_master(cpu))
> +		return -EBUSY;
> +
> +	set_cpu_online(cpu, false);
> +	calculate_cpu_foreign_map();
> +	local_irq_save(flags);
> +	irq_migrate_all_off_this_cpu();
> +	clear_csr_ecfg(ECFG0_IM);
> +	local_irq_restore(flags);
> +	local_flush_tlb_all();
> +
> +	return 0;
> +}
> +
> +void loongson3_cpu_die(unsigned int cpu)
> +{
> +	while (per_cpu(cpu_state, cpu) !=3D CPU_DEAD)
> +		cpu_relax();
> +
> +	mb();
> +}
> +
> +/*
> + * The target CPU should go to XKPRANGE (uncached area) and flush
> + * ICache/DCache/VCache before the control CPU can safely disable its=20
> clock.
> + */
> +static void loongson3_play_dead(int *state_addr)
> +{
> +	register int val;
> +	register void *addr;
> +	register void (*init_fn)(void);
> +
> +	__asm__ __volatile__(
> +		"   li.d %[addr], 0x8000000000000000\n"
> +		"1: cacop 0x8, %[addr], 0           \n" /* flush ICache */
> +		"   cacop 0x8, %[addr], 1           \n"
> +		"   cacop 0x8, %[addr], 2           \n"
> +		"   cacop 0x8, %[addr], 3           \n"
> +		"   cacop 0x9, %[addr], 0           \n" /* flush DCache */
> +		"   cacop 0x9, %[addr], 1           \n"
> +		"   cacop 0x9, %[addr], 2           \n"
> +		"   cacop 0x9, %[addr], 3           \n"
> +		"   addi.w %[sets], %[sets], -1     \n"
> +		"   addi.d %[addr], %[addr], 0x40   \n"
> +		"   bnez %[sets], 1b                \n"
> +		"   li.d %[addr], 0x8000000000000000\n"
> +		"2: cacop 0xa, %[addr], 0           \n" /* flush VCache */
> +		"   cacop 0xa, %[addr], 1           \n"
> +		"   cacop 0xa, %[addr], 2           \n"
> +		"   cacop 0xa, %[addr], 3           \n"
> +		"   cacop 0xa, %[addr], 4           \n"
> +		"   cacop 0xa, %[addr], 5           \n"
> +		"   cacop 0xa, %[addr], 6           \n"
> +		"   cacop 0xa, %[addr], 7           \n"
> +		"   cacop 0xa, %[addr], 8           \n"
> +		"   cacop 0xa, %[addr], 9           \n"
> +		"   cacop 0xa, %[addr], 10          \n"
> +		"   cacop 0xa, %[addr], 11          \n"
> +		"   cacop 0xa, %[addr], 12          \n"
> +		"   cacop 0xa, %[addr], 13          \n"
> +		"   cacop 0xa, %[addr], 14          \n"
> +		"   cacop 0xa, %[addr], 15          \n"
> +		"   addi.w %[vsets], %[vsets], -1   \n"
> +		"   addi.d %[addr], %[addr], 0x40   \n"
> +		"   bnez   %[vsets], 2b             \n"
> +		"   li.w   %[val], 0x7              \n" /* *state_addr =3D CPU_DEAD=
; */
> +		"   st.w   %[val], %[state_addr], 0 \n"
> +		"   dbar 0                          \n"
> +		"   cacop 0x11, %[state_addr], 0    \n" /* flush entry of=20
> *state_addr */
> +		: [addr] "=3D&r" (addr), [val] "=3D&r" (val)
> +		: [state_addr] "r" (state_addr),
> +		  [sets] "r" (cpu_data[smp_processor_id()].dcache.sets),
> +		  [vsets] "r" (cpu_data[smp_processor_id()].vcache.sets));
> +
> +	local_irq_enable();
> +	change_csr_ecfg(ECFG0_IM, ECFGF_IPI);
> +
> +	__asm__ __volatile__(
> +		"   idle      0			    \n"
> +		"   li.w      $t0, 0x1020	    \n"
> +		"   iocsrrd.d %[init_fn], $t0	    \n" /* Get init PC */
> +		: [init_fn] "=3D&r" (addr)
> +		: /* No Input */
> +		: "a0");
> +	init_fn =3D __va(addr);
> +
> +	init_fn();
> +	unreachable();
> +}
> +
> +void play_dead(void)
> +{
> +	int *state_addr;
> +	unsigned int cpu =3D smp_processor_id();
> +	void (*play_dead_uncached)(int *s);
> +
> +	idle_task_exit();
> +	play_dead_uncached =3D (void *)TO_UNCACHE(__pa((unsigned=20
> long)loongson3_play_dead));
> +	state_addr =3D &per_cpu(cpu_state, cpu);
> +	mb();
> +	play_dead_uncached(state_addr);
> +}
> +
> +static int loongson3_enable_clock(unsigned int cpu)
> +{
> +	uint64_t core_id =3D cpu_data[cpu].core;
> +	uint64_t package_id =3D cpu_data[cpu].package;
> +
> +	LOONGSON_FREQCTRL(package_id) |=3D 1 << (core_id * 4 + 3);
> +
> +	return 0;
> +}
> +
> +static int loongson3_disable_clock(unsigned int cpu)
> +{
> +	uint64_t core_id =3D cpu_data[cpu].core;
> +	uint64_t package_id =3D cpu_data[cpu].package;
> +
> +	LOONGSON_FREQCTRL(package_id) &=3D ~(1 << (core_id * 4 + 3));
> +
> +	return 0;
> +}
> +
> +static int register_loongson3_notifier(void)
> +{
> +	return cpuhp_setup_state_nocalls(CPUHP_LOONGARCH_SOC_PREPARE,
> +					 "loongarch/loongson:prepare",
> +					 loongson3_enable_clock,
> +					 loongson3_disable_clock);
> +}
> +early_initcall(register_loongson3_notifier);
> +
> +#endif
> +
> +/*
> + * Power management
> + */
> +#ifdef CONFIG_PM
> +
> +static int loongson3_ipi_suspend(void)
> +{
> +	return 0;
> +}
> +
> +static void loongson3_ipi_resume(void)
> +{
> +	iocsr_write32(0xffffffff, LOONGARCH_IOCSR_IPI_EN);
> +}
> +
> +static struct syscore_ops loongson3_ipi_syscore_ops =3D {
> +	.resume         =3D loongson3_ipi_resume,
> +	.suspend        =3D loongson3_ipi_suspend,
> +};
> +
> +/*
> + * Enable boot cpu ipi before enabling nonboot cpus
> + * during syscore_resume.
> + */
> +static int __init ipi_pm_init(void)
> +{
> +	register_syscore_ops(&loongson3_ipi_syscore_ops);
> +	return 0;
> +}
> +
> +core_initcall(ipi_pm_init);
> +#endif
> +
> +static inline void set_cpu_sibling_map(int cpu)
> +{
> +	int i;
> +
> +	cpumask_set_cpu(cpu, &cpu_sibling_setup_map);
> +
> +	if (smp_num_siblings <=3D 1)
> +		cpumask_set_cpu(cpu, &cpu_sibling_map[cpu]);
> +	else {
> +		for_each_cpu(i, &cpu_sibling_setup_map) {
> +			if (cpus_are_siblings(cpu, i)) {
> +				cpumask_set_cpu(i, &cpu_sibling_map[cpu]);
> +				cpumask_set_cpu(cpu, &cpu_sibling_map[i]);
> +			}
> +		}
> +	}
> +}
> +
> +static inline void set_cpu_core_map(int cpu)
> +{
> +	int i;
> +
> +	cpumask_set_cpu(cpu, &cpu_core_setup_map);
> +
> +	for_each_cpu(i, &cpu_core_setup_map) {
> +		if (cpu_data[cpu].package =3D=3D cpu_data[i].package) {
> +			cpumask_set_cpu(i, &cpu_core_map[cpu]);
> +			cpumask_set_cpu(cpu, &cpu_core_map[i]);
> +		}
> +	}
> +}
> +
> +/*
> + * Calculate a new cpu_foreign_map mask whenever a
> + * new cpu appears or disappears.
> + */
> +void calculate_cpu_foreign_map(void)
> +{
> +	int i, k, core_present;
> +	cpumask_t temp_foreign_map;
> +
> +	/* Re-calculate the mask */
> +	cpumask_clear(&temp_foreign_map);
> +	for_each_online_cpu(i) {
> +		core_present =3D 0;
> +		for_each_cpu(k, &temp_foreign_map)
> +			if (cpus_are_siblings(i, k))
> +				core_present =3D 1;
> +		if (!core_present)
> +			cpumask_set_cpu(i, &temp_foreign_map);
> +	}
> +
> +	for_each_online_cpu(i)
> +		cpumask_andnot(&cpu_foreign_map[i],
> +			       &temp_foreign_map, &cpu_sibling_map[i]);
> +}
> +
> +/* Preload SMP state for boot cpu */
> +void smp_prepare_boot_cpu(void)
> +{
> +	unsigned int cpu;
> +
> +	set_cpu_possible(0, true);
> +	set_cpu_online(0, true);
> +	set_my_cpu_offset(per_cpu_offset(0));
> +
> +	for_each_possible_cpu(cpu)
> +		set_cpu_numa_node(cpu, 0);
> +}
> +
> +/* called from main before smp_init() */
> +void __init smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	init_new_context(current, &init_mm);
> +	current_thread_info()->cpu =3D 0;
> +	loongson3_prepare_cpus(max_cpus);
> +	set_cpu_sibling_map(0);
> +	set_cpu_core_map(0);
> +	calculate_cpu_foreign_map();
> +#ifndef CONFIG_HOTPLUG_CPU
> +	init_cpu_present(cpu_possible_mask);
> +#endif
> +}
> +
> +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> +{
> +	loongson3_boot_secondary(cpu, tidle);
> +
> +	/* Wait for CPU to start and be ready to sync counters */
> +	if (!wait_for_completion_timeout(&cpu_starting,
> +					 msecs_to_jiffies(5000))) {
> +		pr_crit("CPU%u: failed to start\n", cpu);
> +		return -EIO;
> +	}
> +
> +	/* Wait for CPU to finish startup & mark itself online before return=20
> */
> +	wait_for_completion(&cpu_running);
> +
> +	return 0;
> +}
> +
> +/*
> + * First C code run on the secondary CPUs after being started up by
> + * the master.
> + */
> +asmlinkage void start_secondary(void)
> +{
> +	unsigned int cpu;
> +
> +	sync_counter();
> +	cpu =3D smp_processor_id();
> +	set_my_cpu_offset(per_cpu_offset(cpu));
> +
> +	cpu_probe();
> +	constant_clockevent_init();
> +	loongson3_init_secondary();
> +
> +	set_cpu_sibling_map(cpu);
> +	set_cpu_core_map(cpu);
> +
> +	notify_cpu_starting(cpu);
> +
> +	/* Notify boot CPU that we're starting */
> +	complete(&cpu_starting);
> +
> +	/* The CPU is running, now mark it online */
> +	set_cpu_online(cpu, true);
> +
> +	calculate_cpu_foreign_map();
> +
> +	/*
> +	 * Notify boot CPU that we're up & online and it can safely return
> +	 * from __cpu_up()
> +	 */
> +	complete(&cpu_running);
> +
> +	/*
> +	 * irq will be enabled in loongson3_smp_finish(), enabling it too
> +	 * early is dangerous.
> +	 */
> +	WARN_ON_ONCE(!irqs_disabled());
> +	loongson3_smp_finish();
> +
> +	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
> +}
> +
> +void __init smp_cpus_done(unsigned int max_cpus)
> +{
> +}
> +
> +static void stop_this_cpu(void *dummy)
> +{
> +	set_cpu_online(smp_processor_id(), false);
> +	calculate_cpu_foreign_map();
> +	local_irq_disable();
> +	while (true);
> +}
> +
> +void smp_send_stop(void)
> +{
> +	smp_call_function(stop_this_cpu, NULL, 0);
> +}
> +
> +int setup_profiling_timer(unsigned int multiplier)
> +{
> +	return 0;
> +}
> +
> +static void flush_tlb_all_ipi(void *info)
> +{
> +	local_flush_tlb_all();
> +}
> +
> +void flush_tlb_all(void)
> +{
> +	on_each_cpu(flush_tlb_all_ipi, NULL, 1);
> +}
> +
> +static void flush_tlb_mm_ipi(void *mm)
> +{
> +	local_flush_tlb_mm((struct mm_struct *)mm);
> +}
> +
> +void flush_tlb_mm(struct mm_struct *mm)
> +{
> +	if (atomic_read(&mm->mm_users) =3D=3D 0)
> +		return;		/* happens as a result of exit_mmap() */
> +
> +	preempt_disable();
> +
> +	if ((atomic_read(&mm->mm_users) !=3D 1) || (current->mm !=3D mm)) {
> +		on_each_cpu_mask(mm_cpumask(mm), flush_tlb_mm_ipi, mm, 1);
> +	} else {
> +		unsigned int cpu;
> +
> +		for_each_online_cpu(cpu) {
> +			if (cpu !=3D smp_processor_id() && cpu_context(cpu, mm))
> +				cpu_context(cpu, mm) =3D 0;
> +		}
> +		local_flush_tlb_mm(mm);
> +	}
> +
> +	preempt_enable();
> +}
> +
> +struct flush_tlb_data {
> +	struct vm_area_struct *vma;
> +	unsigned long addr1;
> +	unsigned long addr2;
> +};
> +
> +static void flush_tlb_range_ipi(void *info)
> +{
> +	struct flush_tlb_data *fd =3D info;
> +
> +	local_flush_tlb_range(fd->vma, fd->addr1, fd->addr2);
> +}
> +
> +void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,=20
> unsigned long end)
> +{
> +	struct mm_struct *mm =3D vma->vm_mm;
> +
> +	preempt_disable();
> +	if ((atomic_read(&mm->mm_users) !=3D 1) || (current->mm !=3D mm)) {
> +		struct flush_tlb_data fd =3D {
> +			.vma =3D vma,
> +			.addr1 =3D start,
> +			.addr2 =3D end,
> +		};
> +
> +		on_each_cpu_mask(mm_cpumask(mm), flush_tlb_range_ipi, &fd, 1);
> +	} else {
> +		unsigned int cpu;
> +		int exec =3D vma->vm_flags & VM_EXEC;
> +
> +		for_each_online_cpu(cpu) {
> +			/*
> +			 * flush_cache_range() will only fully flush icache if
> +			 * the VMA is executable, otherwise we must invalidate
> +			 * ASID without it appearing to has_valid_asid() as if
> +			 * mm has been completely unused by that CPU.
> +			 */
> +			if (cpu !=3D smp_processor_id() && cpu_context(cpu, mm))
> +				cpu_context(cpu, mm) =3D !exec;
> +		}
> +		local_flush_tlb_range(vma, start, end);
> +	}
> +	preempt_enable();
> +}
> +
> +static void flush_tlb_kernel_range_ipi(void *info)
> +{
> +	struct flush_tlb_data *fd =3D info;
> +
> +	local_flush_tlb_kernel_range(fd->addr1, fd->addr2);
> +}
> +
> +void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> +{
> +	struct flush_tlb_data fd =3D {
> +		.addr1 =3D start,
> +		.addr2 =3D end,
> +	};
> +
> +	on_each_cpu(flush_tlb_kernel_range_ipi, &fd, 1);
> +}
> +
> +static void flush_tlb_page_ipi(void *info)
> +{
> +	struct flush_tlb_data *fd =3D info;
> +
> +	local_flush_tlb_page(fd->vma, fd->addr1);
> +}
> +
> +void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
> +{
> +	preempt_disable();
> +	if ((atomic_read(&vma->vm_mm->mm_users) !=3D 1) || (current->mm !=3D=20
> vma->vm_mm)) {
> +		struct flush_tlb_data fd =3D {
> +			.vma =3D vma,
> +			.addr1 =3D page,
> +		};
> +
> +		on_each_cpu_mask(mm_cpumask(vma->vm_mm), flush_tlb_page_ipi, &fd, 1=
);
> +	} else {
> +		unsigned int cpu;
> +
> +		for_each_online_cpu(cpu) {
> +			/*
> +			 * flush_cache_page() only does partial flushes, so
> +			 * invalidate ASID without it appearing to
> +			 * has_valid_asid() as if mm has been completely unused
> +			 * by that CPU.
> +			 */
> +			if (cpu !=3D smp_processor_id() && cpu_context(cpu, vma->vm_mm))
> +				cpu_context(cpu, vma->vm_mm) =3D 1;
> +		}
> +		local_flush_tlb_page(vma, page);
> +	}
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(flush_tlb_page);
> +
> +static void flush_tlb_one_ipi(void *info)
> +{
> +	unsigned long vaddr =3D (unsigned long) info;
> +
> +	local_flush_tlb_one(vaddr);
> +}
> +
> +void flush_tlb_one(unsigned long vaddr)
> +{
> +	on_each_cpu(flush_tlb_one_ipi, (void *)vaddr, 1);
> +}
> +EXPORT_SYMBOL(flush_tlb_one);
> diff --git a/arch/loongarch/kernel/topology.c=20
> b/arch/loongarch/kernel/topology.c
> index 3b2cbb95875b..ab1a75c0b5a6 100644
> --- a/arch/loongarch/kernel/topology.c
> +++ b/arch/loongarch/kernel/topology.c
> @@ -1,13 +1,52 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/cpu.h>
> +#include <linux/cpumask.h>
>  #include <linux/init.h>
> +#include <linux/node.h>
> +#include <linux/nodemask.h>
>  #include <linux/percpu.h>
>=20
> -static struct cpu cpu_device;
> +static DEFINE_PER_CPU(struct cpu, cpu_devices);
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +int arch_register_cpu(int cpu)
> +{
> +	int ret;
> +	struct cpu *c =3D &per_cpu(cpu_devices, cpu);
> +
> +	c->hotpluggable =3D 1;
> +	ret =3D register_cpu(c, cpu);
> +	if (ret < 0)
> +		pr_warn("register_cpu %d failed (%d)\n", cpu, ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(arch_register_cpu);
> +
> +void arch_unregister_cpu(int cpu)
> +{
> +	struct cpu *c =3D &per_cpu(cpu_devices, cpu);
> +
> +	c->hotpluggable =3D 0;
> +	unregister_cpu(c);
> +}
> +EXPORT_SYMBOL(arch_unregister_cpu);
> +#endif
>=20
>  static int __init topology_init(void)
>  {
> -	return register_cpu(&cpu_device, 0);
> +	int i, ret;
> +
> +	for_each_present_cpu(i) {
> +		struct cpu *c =3D &per_cpu(cpu_devices, i);
> +
> +		c->hotpluggable =3D !!i;
> +		ret =3D register_cpu(c, i);
> +		if (ret < 0)
> +			pr_warn("topology_init: register_cpu %d failed (%d)\n", i, ret);
> +	}
> +
> +	return 0;
>  }
>=20
>  subsys_initcall(topology_init);
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S=20
> b/arch/loongarch/kernel/vmlinux.lds.S
> index 7da4c4d7c50d..006cbb1bd5c6 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -73,6 +73,10 @@ SECTIONS
>  		EXIT_DATA
>  	}
>=20
> +#ifdef CONFIG_SMP
> +	PERCPU_SECTION(1 << CONFIG_L1_CACHE_SHIFT)
> +#endif
> +
>  	.init.bss : {
>  		*(.init.bss)
>  	}
> diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
> index bef740710a3b..7eee40271577 100644
> --- a/arch/loongarch/mm/tlbex.S
> +++ b/arch/loongarch/mm/tlbex.S
> @@ -88,7 +88,14 @@ vmalloc_done_load:
>  	slli.d	t0, t0, _PTE_T_LOG2
>  	add.d	t1, ra, t0
>=20
> +#ifdef CONFIG_SMP
> +smp_pgtable_change_load:
> +#endif
> +#ifdef CONFIG_SMP
> +	ll.d	t0, t1, 0
> +#else
>  	ld.d	t0, t1, 0
> +#endif
>  	tlbsrch
>=20
>  	srli.d	ra, t0, _PAGE_PRESENT_SHIFT
> @@ -96,7 +103,12 @@ vmalloc_done_load:
>  	beq	ra, $r0, nopage_tlb_load
>=20
>  	ori	t0, t0, _PAGE_VALID
> +#ifdef CONFIG_SMP
> +	sc.d	t0, t1, 0
> +	beq	t0, $r0, smp_pgtable_change_load
> +#else
>  	st.d	t0, t1, 0
> +#endif
>  	ori	t1, t1, 8
>  	xori	t1, t1, 8
>  	ld.d	t0, t1, 0
> @@ -120,14 +132,24 @@ vmalloc_load:
>  	 * spots a huge page.
>  	 */
>  tlb_huge_update_load:
> +#ifdef CONFIG_SMP
> +	ll.d	t0, t1, 0
> +#else
>  	ld.d	t0, t1, 0
> +#endif
>  	srli.d	ra, t0, _PAGE_PRESENT_SHIFT
>  	andi	ra, ra, 1
>  	beq	ra, $r0, nopage_tlb_load
>  	tlbsrch
>=20
>  	ori	t0, t0, _PAGE_VALID
> +#ifdef CONFIG_SMP
> +	sc.d	t0, t1, 0
> +	beq	t0, $r0, tlb_huge_update_load
> +	ld.d	t0, t1, 0
> +#else
>  	st.d	t0, t1, 0
> +#endif
>  	addu16i.d	t1, $r0, -(CSR_TLBIDX_EHINV >> 16)
>  	addi.d	ra, t1, 0
>  	csrxchg	ra, t1, LOONGARCH_CSR_TLBIDX
> @@ -173,6 +195,7 @@ tlb_huge_update_load:
>  	csrxchg		t1, t0, LOONGARCH_CSR_TLBIDX
>=20
>  nopage_tlb_load:
> +	dbar	0
>  	csrrd	ra, EXCEPTION_KS2
>  	la.abs	t0, tlb_do_page_fault_0
>  	jirl	$r0, t0, 0
> @@ -229,7 +252,14 @@ vmalloc_done_store:
>  	slli.d	t0, t0, _PTE_T_LOG2
>  	add.d	t1, ra, t0
>=20
> +#ifdef CONFIG_SMP
> +smp_pgtable_change_store:
> +#endif
> +#ifdef CONFIG_SMP
> +	ll.d	t0, t1, 0
> +#else
>  	ld.d	t0, t1, 0
> +#endif
>  	tlbsrch
>=20
>  	srli.d	ra, t0, _PAGE_PRESENT_SHIFT
> @@ -238,7 +268,12 @@ vmalloc_done_store:
>  	bne	ra, $r0, nopage_tlb_store
>=20
>  	ori	t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
> +#ifdef CONFIG_SMP
> +	sc.d	t0, t1, 0
> +	beq	t0, $r0, smp_pgtable_change_store
> +#else
>  	st.d	t0, t1, 0
> +#endif
>=20
>  	ori	t1, t1, 8
>  	xori	t1, t1, 8
> @@ -263,7 +298,11 @@ vmalloc_store:
>  	 * spots a huge page.
>  	 */
>  tlb_huge_update_store:
> +#ifdef CONFIG_SMP
> +	ll.d	t0, t1, 0
> +#else
>  	ld.d	t0, t1, 0
> +#endif
>  	srli.d	ra, t0, _PAGE_PRESENT_SHIFT
>  	andi	ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
>  	xori	ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
> @@ -272,7 +311,13 @@ tlb_huge_update_store:
>  	tlbsrch
>  	ori	t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
>=20
> +#ifdef CONFIG_SMP
> +	sc.d	t0, t1, 0
> +	beq	t0, $r0, tlb_huge_update_store
> +	ld.d	t0, t1, 0
> +#else
>  	st.d	t0, t1, 0
> +#endif
>  	addu16i.d	t1, $r0, -(CSR_TLBIDX_EHINV >> 16)
>  	addi.d	ra, t1, 0
>  	csrxchg	ra, t1, LOONGARCH_CSR_TLBIDX
> @@ -318,6 +363,7 @@ tlb_huge_update_store:
>  	csrxchg		t1, t0, LOONGARCH_CSR_TLBIDX
>=20
>  nopage_tlb_store:
> +	dbar	0
>  	csrrd	ra, EXCEPTION_KS2
>  	la.abs	t0, tlb_do_page_fault_1
>  	jirl	$r0, t0, 0
> @@ -373,7 +419,14 @@ vmalloc_done_modify:
>  	slli.d	t0, t0, _PTE_T_LOG2
>  	add.d	t1, ra, t0
>=20
> +#ifdef CONFIG_SMP
> +smp_pgtable_change_modify:
> +#endif
> +#ifdef CONFIG_SMP
> +	ll.d	t0, t1, 0
> +#else
>  	ld.d	t0, t1, 0
> +#endif
>  	tlbsrch
>=20
>  	srli.d	ra, t0, _PAGE_WRITE_SHIFT
> @@ -381,7 +434,12 @@ vmalloc_done_modify:
>  	beq	ra, $r0, nopage_tlb_modify
>=20
>  	ori	t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
> +#ifdef CONFIG_SMP
> +	sc.d	t0, t1, 0
> +	beq	t0, $r0, smp_pgtable_change_modify
> +#else
>  	st.d	t0, t1, 0
> +#endif
>  	ori	t1, t1, 8
>  	xori	t1, t1, 8
>  	ld.d	t0, t1, 0
> @@ -405,7 +463,11 @@ vmalloc_modify:
>  	 * build_tlbchange_handler_head spots a huge page.
>  	 */
>  tlb_huge_update_modify:
> +#ifdef CONFIG_SMP
> +	ll.d	t0, t1, 0
> +#else
>  	ld.d	t0, t1, 0
> +#endif
>=20
>  	srli.d	ra, t0, _PAGE_WRITE_SHIFT
>  	andi	ra, ra, 1
> @@ -414,7 +476,13 @@ tlb_huge_update_modify:
>  	tlbsrch
>  	ori	t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
>=20
> +#ifdef CONFIG_SMP
> +	sc.d	t0, t1, 0
> +	beq	t0, $r0, tlb_huge_update_modify
> +	ld.d	t0, t1, 0
> +#else
>  	st.d	t0, t1, 0
> +#endif
>  	/*
>  	 * A huge PTE describes an area the size of the
>  	 * configured huge page size. This is twice the
> @@ -454,6 +522,7 @@ tlb_huge_update_modify:
>  	csrxchg	t1, t0, LOONGARCH_CSR_TLBIDX
>=20
>  nopage_tlb_modify:
> +	dbar	0
>  	csrrd	ra, EXCEPTION_KS2
>  	la.abs	t0, tlb_do_page_fault_1
>  	jirl	$r0, t0, 0
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index b66c5f389159..19f0dbfdd7fe 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -130,6 +130,7 @@ enum cpuhp_state {
>  	CPUHP_ZCOMP_PREPARE,
>  	CPUHP_TIMERS_PREPARE,
>  	CPUHP_MIPS_SOC_PREPARE,
> +	CPUHP_LOONGARCH_SOC_PREPARE,
>  	CPUHP_BP_PREPARE_DYN,
>  	CPUHP_BP_PREPARE_DYN_END		=3D CPUHP_BP_PREPARE_DYN + 20,
>  	CPUHP_BRINGUP_CPU,
> --=20
> 2.27.0

--=20
- Jiaxun
