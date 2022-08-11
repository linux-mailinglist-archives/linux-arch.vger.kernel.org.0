Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166CF590732
	for <lists+linux-arch@lfdr.de>; Thu, 11 Aug 2022 22:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiHKUCc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Aug 2022 16:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiHKUCb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Aug 2022 16:02:31 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BA79BB4F;
        Thu, 11 Aug 2022 13:02:30 -0700 (PDT)
Received: from [127.0.0.1] ([12.0.243.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 27BJvVcV569135
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 11 Aug 2022 12:57:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 27BJvVcV569135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022080501; t=1660247855;
        bh=LZ5/i1TBlH5OS+iyknyKHVuU6iY8SydC5jqehDFiCrg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=EbPAmL9QTPSIaBoTRMPStYWl+qU6Ug1qOfcvMRQWxRtrZGXKoJtzeiYyW6agNxxfr
         T+HeWHmKTA4oczR30s6NcwYGQoGLPrmNdGwlDB8GC143sGVRAqHiUicdlg1dEXrH/m
         NeXj6yevSlRpo2kNlCwoVQ4UO5JhlWJz1VaUsXsxzFoCjO+c27FV3y4Oq5+Cm9SXK8
         0huM8v14WT3kPV2w4GWBjYztOsMlqJTGZx4j5C2BHthDuAmnPuIiQxlGLR4T6zC1fK
         SIxc8fF/p0t7gK8qatwkBKYcVdKmiRDxO6C09i894SX6A4SUW4ZWFoASW7X7FZ+KWQ
         Si+SZXjBwBMtQ==
Date:   Thu, 11 Aug 2022 12:57:25 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
CC:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
User-Agent: K-9 Mail for Android
In-Reply-To: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
Message-ID: <C1886F9A-1799-4E3D-9153-579D31488695@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On August 9, 2022 3:40:38 AM PDT, Christophe Leroy <christophe=2Eleroy@csgr=
oup=2Eeu> wrote:
>At the time being, the default maximum number of GPIOs is set to 512
>and can only get customised via an architecture specific
>CONFIG_ARCH_NR_GPIO=2E
>
>The maximum number of GPIOs might be dependent on the number of
>interface boards and is somewhat independent of architecture=2E
>
>Allow the user to select that maximum number outside of any
>architecture configuration=2E To enable that, re-define a
>core CONFIG_ARCH_NR_GPIO for architectures which don't already
>define one=2E Guard it with a new hidden CONFIG_ARCH_HAS_NR_GPIO=2E
>
>Only two architectures will need CONFIG_ARCH_HAS_NR_GPIO: x86 and arm=2E
>
>On arm, do like x86 and set 512 as the default instead of 0, that
>allows simplifying the logic in asm-generic/gpio=2Eh
>
>Signed-off-by: Christophe Leroy <christophe=2Eleroy@csgroup=2Eeu>
>---
> Documentation/driver-api/gpio/legacy=2Erst |  2 +-
> arch/arm/Kconfig                         |  3 ++-
> arch/arm/include/asm/gpio=2Eh              |  1 -
> arch/x86/Kconfig                         |  1 +
> drivers/gpio/Kconfig                     | 14 ++++++++++++++
> include/asm-generic/gpio=2Eh               |  6 ------
> 6 files changed, 18 insertions(+), 9 deletions(-)
>
>diff --git a/Documentation/driver-api/gpio/legacy=2Erst b/Documentation/d=
river-api/gpio/legacy=2Erst
>index 9b12eeb89170=2E=2E566b06a584cf 100644
>--- a/Documentation/driver-api/gpio/legacy=2Erst
>+++ b/Documentation/driver-api/gpio/legacy=2Erst
>@@ -558,7 +558,7 @@ Platform Support
> To force-enable this framework, a platform's Kconfig will "select" GPIOL=
IB,
> else it is up to the user to configure support for GPIO=2E
>=20
>-It may also provide a custom value for ARCH_NR_GPIOS, so that it better
>+It may also provide a custom value for CONFIG_ARCH_NR_GPIO, so that it b=
etter
> reflects the number of GPIOs in actual use on that platform, without
> wasting static table space=2E  (It should count both built-in/SoC GPIOs =
and
> also ones on GPIO expanders=2E
>diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>index 53e6a1da9af5=2E=2Ee55b6560fe4f 100644
>--- a/arch/arm/Kconfig
>+++ b/arch/arm/Kconfig
>@@ -14,6 +14,7 @@ config ARM
> 	select ARCH_HAS_KCOV
> 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
> 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>+	select ARCH_HAS_NR_GPIO
> 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
> 	select ARCH_HAS_PHYS_TO_DMA
> 	select ARCH_HAS_SETUP_DMA_OPS
>@@ -1243,7 +1244,7 @@ config ARCH_NR_GPIO
> 	default 352 if ARCH_VT8500
> 	default 288 if ARCH_ROCKCHIP
> 	default 264 if MACH_H4700
>-	default 0
>+	default 512
> 	help
> 	  Maximum number of GPIOs in the system=2E
>=20
>diff --git a/arch/arm/include/asm/gpio=2Eh b/arch/arm/include/asm/gpio=2E=
h
>index f3bb8a2bf788=2E=2E4ebbb58f06ea 100644
>--- a/arch/arm/include/asm/gpio=2Eh
>+++ b/arch/arm/include/asm/gpio=2Eh
>@@ -2,7 +2,6 @@
> #ifndef _ARCH_ARM_GPIO_H
> #define _ARCH_ARM_GPIO_H
>=20
>-/* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio=
=2Eh */
> #include <asm-generic/gpio=2Eh>
>=20
> /* The trivial gpiolib dispatchers */
>diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>index f9920f1341c8=2E=2Ea8c956abc21e 100644
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -82,6 +82,7 @@ config X86
> 	select ARCH_HAS_MEM_ENCRYPT
> 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
> 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>+	select ARCH_HAS_NR_GPIO
> 	select ARCH_HAS_PMEM_API		if X86_64
> 	select ARCH_HAS_PTE_DEVMAP		if X86_64
> 	select ARCH_HAS_PTE_SPECIAL
>diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>index 0642f579196f=2E=2E250b50ed44e1 100644
>--- a/drivers/gpio/Kconfig
>+++ b/drivers/gpio/Kconfig
>@@ -11,6 +11,9 @@ config ARCH_HAVE_CUSTOM_GPIO_H
> 	  overriding the default implementations=2E  New uses of this are
> 	  strongly discouraged=2E
>=20
>+config ARCH_HAS_NR_GPIO
>+	bool
>+
> menuconfig GPIOLIB
> 	bool "GPIO Support"
> 	help
>@@ -22,6 +25,17 @@ menuconfig GPIOLIB
>=20
> if GPIOLIB
>=20
>+config ARCH_NR_GPIO
>+	int "Maximum number of GPIOs" if EXPERT
>+	depends on !ARCH_HAS_NR_GPIO
>+	default 512
>+	help
>+	  This allows the user to select the maximum number of GPIOs the
>+	  kernel must support=2E When the architecture defines a number
>+	  through CONFIG_ARCH_NR_GPIO, that value is taken and the user
>+	  cannot change it=2E Otherwise it defaults to 512 and the user
>+	  can change it when CONFIG_EXPERT is set=2E
>+
> config GPIOLIB_FASTPATH_LIMIT
> 	int "Maximum number of GPIOs for fast path"
> 	range 32 512
>diff --git a/include/asm-generic/gpio=2Eh b/include/asm-generic/gpio=2Eh
>index aea9aee1f3e9=2E=2Eee090f534ab8 100644
>--- a/include/asm-generic/gpio=2Eh
>+++ b/include/asm-generic/gpio=2Eh
>@@ -24,13 +24,7 @@
>  * actually an estimate of a board-specific value=2E
>  */
>=20
>-#ifndef ARCH_NR_GPIOS
>-#if defined(CONFIG_ARCH_NR_GPIO) && CONFIG_ARCH_NR_GPIO > 0
> #define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
>-#else
>-#define ARCH_NR_GPIOS		512
>-#endif
>-#endif
>=20
> /*
>  * "valid" GPIO numbers are nonnegative and may be passed to

This seems very odd to me=2E GPIOs can be, and often are, attached to peri=
pheral buses which means that the *same system* can have anything from none=
 to thousands of gpios =2E=2E
