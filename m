Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C210224D47F
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 13:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgHULyB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 07:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgHULv1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 07:51:27 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B861C061388
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 04:51:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t23so974645qto.3
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 04:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gFr9Xs5EElVSv/fUTGh7jgK0DiOtFjiMWxGxvaqivc=;
        b=PixCF4QVbNKFaXIjeDdt8fSzko6aEe0Fqncx1DkJgEAfRi+YBaF1qttW7mpzanmsut
         V9WFD2mMJy329+GXa7qJklCGvuAEpndBnkBTHLthKvufP1c9c8Gkv+H5Fv520zWXmR1K
         eJ5HWxpTFxlV8jUXYU0RwGX7uOqGW0OYfjxUbGMkh3piCkTvm5D6kKOJhem5bJTzFayx
         ajxrx6SQDKJ2MXqzhMkDSEScR2aHdfQMv/VN/ATnHB9UjIU27VXVzZUpWVhRf6A9PKSE
         Wl1eSaIHZn89anb3oXy4xFJ5O6ikJPVhJVDCgaUWpw8PwxzTLTorVfkJ/W8U3eWDw44P
         BCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gFr9Xs5EElVSv/fUTGh7jgK0DiOtFjiMWxGxvaqivc=;
        b=rhjMTa8DsE18Dc8WnUsQFmDZb5SwnnU+paeRq6hTW+4COuWViKzI4UhnO1bvZBfZn8
         7H11DSAsNgGpTIEn/ZRdMXb9OODAIjr62NQnh12DY2Mc6+FG8qlTCLHZFycqLSe3vg8W
         P4nHbS4SNOZVxFMdTbKRdPzSsNGppSctJSj2S6Eus1UqlELQjXLLT2QFLrtzCdol2pHR
         Y1VVTLoeZo1fTjof0qmMrIdjkaH6fW1pUo3nwpEx7EgtcX2F80V//lQCvt17fL0TPi8E
         gCNJ5dzgwkTTXWafFQVyoPRx3lVacfCHRQwhT8gtg9XVwQNajojDEyopLuaqEdhbxncM
         hGJw==
X-Gm-Message-State: AOAM531SwmjWwKlMvbT+AWdhAOj06ulqvQIWPh1KKQfv2O4t8G4TP8px
        CfikgXUuaR+VmAyqnL11oahQAzXQT3lCeB/RWkl9ug==
X-Google-Smtp-Source: ABdhPJw4S97OapVp8oPBhFQuGIaYHCnNjLel2vnOd+8Ghoo9TmXmzdMDTdegaHwD9rjgqsBPdXZL6vSVTxWAxiENUCg=
X-Received: by 2002:ac8:470e:: with SMTP id f14mr2280512qtp.380.1598010685125;
 Fri, 21 Aug 2020 04:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200821104926.828511-1-alinde@google.com> <20200821104926.828511-2-alinde@google.com>
In-Reply-To: <20200821104926.828511-2-alinde@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 21 Aug 2020 13:51:13 +0200
Message-ID: <CACT4Y+ZeoUX39tBZs-DLoX0q5tC+skB56Cxf_SSpKiJdv3mMFg@mail.gmail.com>
Subject: Re: [PATCH 1/3] lib, include/linux: add usercopy failure capability
To:     albert.linde@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Albert van der Linde <alinde@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 21, 2020 at 12:50 PM <albert.linde@gmail.com> wrote:
>
> From: Albert van der Linde <alinde@google.com>
>
> Add a failure injection capability to improve testing of fault-tolerance
> in usages of user memory access functions.
>
> Adds CONFIG_FAULT_INJECTION_USERCOPY to enable faults in usercopy
> functions. By default functions are to either fail with -EFAULT or
> return that no bytes were copied. To use partial copies (e.g.,
> copy_from_user permits partial failures) the number of bytes not to copy
> must be written to /sys/kernel/debug/fail_usercopy/failsize.
>
> Signed-off-by: Albert van der Linde <alinde@google.com>
> ---
>  .../fault-injection/fault-injection.rst       | 64 ++++++++++++++++++
>  include/linux/fault-inject-usercopy.h         | 20 ++++++
>  lib/Kconfig.debug                             |  7 ++
>  lib/Makefile                                  |  1 +
>  lib/fault-inject-usercopy.c                   | 66 +++++++++++++++++++
>  5 files changed, 158 insertions(+)
>  create mode 100644 include/linux/fault-inject-usercopy.h
>  create mode 100644 lib/fault-inject-usercopy.c
>
> diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
> index f850ad018b70..cf52eabde332 100644
> --- a/Documentation/fault-injection/fault-injection.rst
> +++ b/Documentation/fault-injection/fault-injection.rst
> @@ -16,6 +16,10 @@ Available fault injection capabilities
>
>    injects page allocation failures. (alloc_pages(), get_free_pages(), ...)
>
> +- fail_usercopy
> +
> +  injects failures in user memory access functions. (copy_from_user(), get_user(), ...)
> +
>  - fail_futex
>
>    injects futex deadlock and uaddr fault errors.
> @@ -138,6 +142,12 @@ configuration of fault-injection capabilities.
>         specifies the minimum page allocation order to be injected
>         failures.
>
> +- /sys/kernel/debug/fail_usercopy/failsize:
> +
> +       specifies the error code to return or amount of bytes not to copy.
> +       If set to 0 then -EFAULT is returned instead. Positive values can be
> +       used to inject partial copies (copy_from_user(), ...)
> +
>  - /sys/kernel/debug/fail_futex/ignore-private:
>
>         Format: { 'Y' | 'N' }
> @@ -177,6 +187,7 @@ use the boot option::
>
>         failslab=
>         fail_page_alloc=
> +       fail_usercopy=
>         fail_make_request=
>         fail_futex=
>         mmc_core.fail_request=<interval>,<probability>,<space>,<times>
> @@ -383,6 +394,59 @@ allocation failure::
>                 ./tools/testing/fault-injection/failcmd.sh --times=100 \
>                 -- make -C tools/testing/selftests/ run_tests
>
> +
> +Fail usercopy functions
> +---------------------------------
> +
> +The following code fails the usercopy call in stat: copy_to_user is only
> +partially completed.
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/sendfile.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +void inject_size()
> +{
> +       int fd = open("/sys/kernel/debug/fail_usercopy/failsize", O_RDWR);
> +       char buf[16];
> +       sprintf(buf, "%d", 60);
> +       write(fd, buf, strlen(buf));
> +}
> +
> +void inject_fault()
> +{
> +       int fd = open("/proc/thread-self/fail-nth", O_RDWR);
> +       char buf[16];
> +       sprintf(buf, "%d", 4);
> +       write(fd, buf, strlen(buf));
> +}
> +
> +int main()
> +{
> +       struct stat sb;
> +       inject_size();
> +       inject_fault();
> +       stat(".", &sb);
> +       printf("Stat error code:          %d\n", errno);
> +       printf("Last status change:       %s", ctime(&sb.st_ctime));
> +       printf("Last file access:         %s", ctime(&sb.st_atime));
> +       printf("Last file modification:   %s", ctime(&sb.st_mtime));
> +       return 0;
> +}
> +
> +Example output:
> +Stat error code:          14
> +Last status change:       Thu Jan  1 00:00:00 1970
> +Last file access:         Tue Aug 18 14:09:34 2020
> +Last file modification:   Sun Dec 12 00:19:57 2989041
> +
>  Systematic faults using fail-nth
>  ---------------------------------
>
> diff --git a/include/linux/fault-inject-usercopy.h b/include/linux/fault-inject-usercopy.h
> new file mode 100644
> index 000000000000..95dad8ddb56f
> --- /dev/null
> +++ b/include/linux/fault-inject-usercopy.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This header provides a wrapper for partial failures on usercopy functions.
> + * For usage see Documentation/fault-injection/fault-injection.rst
> + */
> +#ifndef __LINUX_FAULT_INJECT_USERCOPY_H__
> +#define __LINUX_FAULT_INJECT_USERCOPY_H__
> +
> +#ifdef CONFIG_FAULT_INJECTION_USERCOPY
> +
> +long should_fail_usercopy(unsigned long n);
> +
> +#else
> +
> +static inline long should_fail_usercopy(unsigned long n) { return 0; }
> +
> +#endif /* CONFIG_FAULT_INJECTION_USERCOPY */
> +
> +#endif /* __LINUX_FAULT_INJECT_USERCOPY_H__ */
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index e068c3c7189a..bd0ec3ddb459 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1770,6 +1770,13 @@ config FAIL_PAGE_ALLOC
>         help
>           Provide fault-injection capability for alloc_pages().
>
> +config FAULT_INJECTION_USERCOPY
> +       bool "Fault injection capability for usercopy functions"
> +       depends on FAULT_INJECTION
> +       help
> +         Provides fault-injection capability to inject failures and
> +         partial copies in usercopy functions.
> +
>  config FAIL_MAKE_REQUEST
>         bool "Fault-injection capability for disk IO"
>         depends on FAULT_INJECTION && BLOCK
> diff --git a/lib/Makefile b/lib/Makefile
> index a4a4c6864f51..18daad2bc606 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -207,6 +207,7 @@ obj-$(CONFIG_AUDIT_COMPAT_GENERIC) += compat_audit.o
>
>  obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o
>  obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
> +obj-$(CONFIG_FAULT_INJECTION_USERCOPY) += fault-inject-usercopy.o
>  obj-$(CONFIG_NOTIFIER_ERROR_INJECTION) += notifier-error-inject.o
>  obj-$(CONFIG_PM_NOTIFIER_ERROR_INJECT) += pm-notifier-error-inject.o
>  obj-$(CONFIG_NETDEV_NOTIFIER_ERROR_INJECT) += netdev-notifier-error-inject.o
> diff --git a/lib/fault-inject-usercopy.c b/lib/fault-inject-usercopy.c
> new file mode 100644
> index 000000000000..c151e0817ca7
> --- /dev/null
> +++ b/lib/fault-inject-usercopy.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/fault-inject.h>
> +#include <linux/fault-inject-usercopy.h>
> +#include <linux/random.h>
> +
> +static struct {
> +       struct fault_attr attr;
> +       u32 failsize;
> +} fail_usercopy = {
> +       .attr = FAULT_ATTR_INITIALIZER,
> +       .failsize = 0,
> +};
> +
> +static int __init setup_fail_usercopy(char *str)
> +{
> +       return setup_fault_attr(&fail_usercopy.attr, str);
> +}
> +__setup("fail_usercopy=", setup_fail_usercopy);
> +
> +#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> +
> +static int __init fail_usercopy_debugfs(void)
> +{
> +       umode_t mode = S_IFREG | 0600;
> +       struct dentry *dir;
> +
> +       dir = fault_create_debugfs_attr("fail_usercopy", NULL,
> +                                       &fail_usercopy.attr);
> +       if (IS_ERR(dir))
> +               return PTR_ERR(dir);
> +
> +       debugfs_create_u32("failsize", mode, dir,
> +                          &fail_usercopy.failsize);

Marco, what's the right way to annotate these concurrent accesses for KCSAN?

> +       return 0;
> +}
> +
> +late_initcall(fail_usercopy_debugfs);
> +
> +#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
> +
> +/**
> + * should_fail_usercopy() - Failure code or amount of bytes not to copy.
> + * @n: Size of the original copy call.
> + *
> + * The general idea is to have a method which returns the amount of bytes not
> + * to copy, a failure to return, or 0 if the calling function should progress
> + * without a failure. E.g., copy_{to,from}_user should NOT copy the amount of
> + * bytes returned by should_fail_usercopy, returning this value (in addition
> + * to any bytes that could actually not be copied) or a failure.
> + *
> + * Return: one of:
> + * negative, failure to return;
> + * 0, progress normally;
> + * a number in ]0, n], the number of bytes not to copy.
> + *
> + */
> +long should_fail_usercopy(unsigned long n)
> +{
> +       if (should_fail(&fail_usercopy.attr, n)) {
> +               if (fail_usercopy.failsize > 0)
> +                       return fail_usercopy.failsize % (n + 1);

What's the use-case for this fail_usercopy.failsize? How is it
supposed to be used?
It seems that setting an exact value only makes sense if you know the
exact failure site (and size it will use). But it's global and not
per-task.
It does not allow systematic enumeration of all return values because
there is no way to understand that we tried all possible return values
for a particular usercopy. And it also can "undo" failure if %(n+1)
yields 0, right? Maybe it should saturate?


> +               return -EFAULT;
> +       }
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(should_fail_usercopy);
> --
> 2.28.0.297.g1956fa8f8d-goog
>
