Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BA248D529
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jan 2022 10:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiAMJsA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jan 2022 04:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiAMJr6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jan 2022 04:47:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D2C061748
        for <linux-arch@vger.kernel.org>; Thu, 13 Jan 2022 01:47:58 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h10so9058659wrb.1
        for <linux-arch@vger.kernel.org>; Thu, 13 Jan 2022 01:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CX43QDixuqKZIQi1caGIH9xkhhuEjj8Yo37fB7bYrCU=;
        b=mS9c7WYPOjEYqY0z57OkohJfYKxS1sEbS5dh95i5/ktJjsnhE1OBl3a5empJ57Tc9+
         vXCdKF1aVlgN8Ya60KTvtQP65EZshzhtsyMuurpf3VVMBT4OVClDdAkZZgBaoU3Pbn63
         OQonlsVQO/NJOuw0vFQ/RM0ORIylaNF+BoErifIu6Mfl+bjdN1qCJIsj4dQBPJGCHt03
         ZFZhAXiQ7hVZFVhdH0mB00lten0AvuI2nqcLRy1MGja7axieY+SWi0RKUAcDxJsDtT8W
         qToO9nCQSq+jcdo48D7L/ujhj6MVZKsZSk0YW5LeEZo1UEbqkFWVQcrtuPnew8DAgaOB
         iLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CX43QDixuqKZIQi1caGIH9xkhhuEjj8Yo37fB7bYrCU=;
        b=SI40DLseMBM+sZvCLMUmdSvVOfZhRoC2abWEltX4bEs4YsncL7LJHiCyXLjhM3YwkN
         Totf3I8MnNVU1YUVloo5eAchJCQnPjZca4w3ipaWshXO/NOGBjddkc1pYtuRk9Ck0KDA
         uZp64x+exl3jS5Ldr5MchuJvX1CNnR/jG3nYPxxAd3iUyKlEwreuz5mH8xBF117KMtwm
         XKQgwc1gFtz++7Io0SEMZhuOK+ndzLhO4sSRkMjkfXCWYanLUoMcCyg7dT5RiEz3R0az
         TcZdtW7uj4DYmJFrmGwy6ogHSGIm63v26MRr1JGHmNpBJmkF0qwQgZGKi93y2uaJ/kLj
         D66g==
X-Gm-Message-State: AOAM5318qmcVwuRWKNUJIHqfDbcI3JZWjauEnH9u4Hndd2KiX7RYnHqR
        Zb1Sv8EBV8eIm5xHqH09CK/ZqA==
X-Google-Smtp-Source: ABdhPJwCxOjHGND3tEMn9aaulcJoj7F5nN7KMLPFRCkl/nTB3ab+vx5Miz06ZRUi4IOldmbTlMKmew==
X-Received: by 2002:a05:6000:1a85:: with SMTP id f5mr2365884wry.463.1642067277004;
        Thu, 13 Jan 2022 01:47:57 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o11sm7519813wmq.15.2022.01.13.01.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:47:56 -0800 (PST)
Date:   Thu, 13 Jan 2022 09:47:54 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 08/10] ARM: uaccess: add __{get,put}_kernel_nofault
Message-ID: <20220113094754.6ei6ssiqbuw7tfj7@maple.lan>
References: <20210726141141.2839385-1-arnd@kernel.org>
 <20210726141141.2839385-9-arnd@kernel.org>
 <Yd8P37V/N9EkwmYq@wychelm>
 <Yd8ZEbywqjXkAx9k@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd8ZEbywqjXkAx9k@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 12, 2022 at 06:08:17PM +0000, Russell King (Oracle) wrote:
> On Wed, Jan 12, 2022 at 05:29:03PM +0000, Daniel Thompson wrote:
> > On Mon, Jul 26, 2021 at 04:11:39PM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > These mimic the behavior of get_user and put_user, except
> > > for domain switching, address limit checking and handling
> > > of mismatched sizes, none of which are relevant here.
> > > 
> > > To work with pre-Armv6 kernels, this has to avoid TUSER()
> > > inside of the new macros, the new approach passes the "t"
> > > string along with the opcode, which is a bit uglier but
> > > avoids duplicating more code.
> > > 
> > > As there is no __get_user_asm_dword(), I work around it
> > > by copying 32 bit at a time, which is possible because
> > > the output size is known.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > I've just been bisecting some regressions running the kgdbts tests on
> > arm and this patch came up.
> 
> So the software PAN code is working :)

Interesting. I noticed it was odd that kgdbts works just fine
if launched from kernel command line. I guess that runs before
PAN is activated. Neat.


> The kernel attempted to access an address that is in the userspace
> domain (NULL pointer) and took an exception.
> 
> I suppose we should handle a domain fault more gracefully - what are
> the required semantics if the kernel attempts a userspace access
> using one of the _nofault() accessors?

I think the best answer might well be that, if the arch provides
implementations of hooks such as copy_from_kernel_nofault_allowed()
then the kernel should never attempt a userspace access using the
_nofault() accessors. That means they can do whatever they like!

In other words something like the patch below looks like a promising
approach.


Daniel.


From f66a63b504ff582f261a506c54ceab8c0e77a98c Mon Sep 17 00:00:00 2001
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 13 Jan 2022 09:34:45 +0000
Subject: [PATCH] arm: mm: Implement copy_from_kernel_nofault_allowed()

Currently copy_from_kernel_nofault() can actually fault (due to software
PAN) if we attempt userspace access. In any case, the documented
behaviour for this function is to return -ERANGE if we attempt an access
outside of kernel space.

Implementing copy_from_kernel_nofault_allowed() solves both these
problems.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/mm/Makefile  | 2 +-
 arch/arm/mm/maccess.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mm/maccess.c

diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 3510503bc5e6..d1c5f4f256de 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the linux arm-specific parts of the memory manager.
 #
 
-obj-y				:= extable.o fault.o init.o iomap.o
+obj-y				:= extable.o fault.o init.o iomap.o maccess.o
 obj-y				+= dma-mapping$(MMUEXT).o
 obj-$(CONFIG_MMU)		+= fault-armv.o flush.o idmap.o ioremap.o \
 				   mmap.o pgd.o mmu.o pageattr.o
diff --git a/arch/arm/mm/maccess.c b/arch/arm/mm/maccess.c
new file mode 100644
index 000000000000..0251062cb40d
--- /dev/null
+++ b/arch/arm/mm/maccess.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/uaccess.h>
+#include <linux/kernel.h>
+
+bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+{
+	return (unsigned long)unsafe_src >= TASK_SIZE;
+}
-- 
2.33.1
