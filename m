Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BC130AAD
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 10:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEaIx5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 04:53:57 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37964 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaIx4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:53:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id l3so10448081qtj.5;
        Fri, 31 May 2019 01:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLETH2OB3IxfKN1eggOuRioC9EOnLLXN9MFUnFFew5s=;
        b=sUN03/0C+hMfoQOP6ZAjoEeEQifClVYy2S6TWneDAJ5QdQyBkIgzcSZWQR0WSR8Iki
         pp2QmTbaCo70vduP2EVL51XRLgZYCsZ+PoRC74vNatvcPLRw4D+i+5NDMLEZInyIi0kz
         zkZXlATQiq5h0fd6GneSufHqHYEIAiTTDxhGHpir+y0iK2qnvvG42qRLwJjb2P4zqRbY
         h1i6AxXl4nzwW9fuUBLLXLWYDYpS4CoX+4nZVHvlI/YoSVqpWsvFondqvpK9gJY64JQy
         iPwnR+6BbrDjUbL4jLgzJ81sqCxf4M1fBq7XlQ707HY+9+58m0OyrEOGa6/yYbJ9l6vz
         larw==
X-Gm-Message-State: APjAAAV35WBhXvJTPyULaJb7pxdJkd5WKb/32zeL3Jfdss7hk2gZIrm6
        5KE6cfLOZjpQX8b9hH5JkxKclT+ebRNtS7g7K/Y=
X-Google-Smtp-Source: APXvYqzU7iWArqELb2azzCaYfon35mBi7acUgoO6bIp937zY6y9ykUj3bD/yvsjRGY3UDM715ORpT4Efor58s/vfKbs=
X-Received: by 2002:a0c:9e0f:: with SMTP id p15mr7638581qve.176.1559292835687;
 Fri, 31 May 2019 01:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-20-vincenzo.frascino@arm.com>
In-Reply-To: <20190530141531.43462-20-vincenzo.frascino@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 May 2019 10:53:39 +0200
Message-ID: <CAK8P3a3Z=wWQDu4aqV73J5PR2jNb3GzyWzYGT3dUp-F81H8mzQ@mail.gmail.com>
Subject: Re: [PATCH v6 19/19] kselftest: Extend vDSO selftest
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 30, 2019 at 4:16 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> +/*
> + * ARM64's vDSO exports its vDSO implementation with different names and
> + * a different version from other architectures, so we need to handle it
> + * as a special case.
> + */
> +#if defined(__aarch64__)
> +const char *version = "LINUX_2.6.39";
> +const char *name[4] = {
> +       "__kernel_gettimeofday",
> +       "__kernel_clock_gettime",
> +       "__kernel_time",
> +       "__kernel_clock_getres",
> +};
> +#else
> +/* Tested on x86, arm, mips */
> +const char *version = "LINUX_2.6";
> +const char *name[4] = {
> +       "__vdso_gettimeofday",
> +       "__vdso_clock_gettime",
> +       "__vdso_time",
> +       "__vdso_clock_getres",
> +};
> +#endif

I see the __kernel_* name used on arm64, powerpc and s390, whiel the __vdso_*
name is used on arm, mips, nds32, riscv, sparc, and x86.

Also the versions have more variants:

$ git ls-files arch | grep vdso | xargs grep
'\(LINUX_[2345]\|VDSO_VERSION_STRING\)'
arch/arm/vdso/vdso.lds.S:    LINUX_2.6 {
arch/arm64/kernel/vdso/vdso.lds.S:    LINUX_2.6.39 {
arch/mips/vdso/vdso.lds.S:    LINUX_2.6 {
arch/nds32/kernel/vdso/vdso.lds.S:    LINUX_4 {
arch/powerpc/include/asm/vdso.h:#define VDSO_VERSION_STRING    LINUX_2.6.15
arch/powerpc/kernel/vdso32/vdso32.lds.S:    VDSO_VERSION_STRING {
arch/powerpc/kernel/vdso64/vdso64.lds.S:    VDSO_VERSION_STRING {
arch/riscv/kernel/vdso/vdso.lds.S:    LINUX_4.15 {
arch/s390/include/asm/vdso.h:#define VDSO_VERSION_STRING    LINUX_2.6.29
arch/s390/kernel/vdso32/vdso32.lds.S:    VDSO_VERSION_STRING {
arch/s390/kernel/vdso64/vdso64.lds.S:    VDSO_VERSION_STRING {
arch/sparc/vdso/vdso.lds.S:    LINUX_2.6 {
arch/sparc/vdso/vdso32/vdso32.lds.S:    LINUX_2.6 {
arch/x86/entry/vdso/vdso.lds.S:    LINUX_2.6 {
arch/x86/entry/vdso/vdso32/vdso32.lds.S:    LINUX_2.6 {
arch/x86/entry/vdso/vdso32/vdso32.lds.S:    LINUX_2.5 {
arch/x86/entry/vdso/vdsox32.lds.S:    LINUX_2.6 {
arch/x86/um/vdso/vdso.lds.S:    LINUX_2.6 {

Maybe change the test case to just try all combinations of the
above (and __vdso_clock_gettime64 as well) and stop checking
the architecture?

       Arnd
