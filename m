Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E493980C7
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 18:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfHUQ5M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Aug 2019 12:57:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43544 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfHUQ5M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Aug 2019 12:57:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id v12so1805726pfn.10
        for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2019 09:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VW3KnN8Acc9B0iEM/8SMTYoiqB1C69NJCO/L2fy9T0E=;
        b=LZ29zPgY1JCJZosPEQMWMF8sGqW2T0iQX3VHzbcY14iAPwWBFycPp+Ut1pIp60N+6M
         63yBq7G0RdWy2aANHbwOBTZ+I6GIiz4Xu49tOYEDigKaPpLtizTGQEZRk2iNnATEvJ17
         rn+wmv3o9QmCU40S2WKtKxFJtNrzZxRGvLmkLlhjf3DBDlOI0UBkt+DgXO3e+QQFm5Zb
         Y6xww4gWli2XoEyQfeJfhkDgKBP0nueMLWXzyCl4Pj/8S2K/9i5RjTU0hiY6jRz3yyL+
         wlS2QqQ0eGRZ4KUFDxcOvqO2hyFB4XnME8oveHgJhobYEyApjwYfUlO7YxGHndquQH+w
         3IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VW3KnN8Acc9B0iEM/8SMTYoiqB1C69NJCO/L2fy9T0E=;
        b=R40/y+SK8PmK0tdxw4E9roXPaUXOdk9yfC7+ASMwNqhlqB8HsbPf7ItVDRdV8SUN+P
         iGTzIE9axVIPEvzGHTLgK5JYqcep0c4IMr8bIx6vnhfD9l5Ik4V4n0MyhHvYriqcYFVs
         OE/X8xY9vd+Fu8KZovykXveN46DFw4H36yle4QY84AP0q8w2K7iD72cD4NHPrB9l6ND2
         AED+aFUmokz//kfcFT3DoOwvkf4ilPicO7mec4SokB+GY2xmQf0aa7elPSEvEL8fFMg8
         RWKdZOcDtXvxcxMjZfARKDhpIx0f47IDBZKgvSgavqe5E3hV8A/Za2l/lcGdNmhl5KJb
         wxCA==
X-Gm-Message-State: APjAAAWUZVc0FQIOAa8p5BYZ95RyamD6Y2YbQCsmB5tVQGiAwAOU9Hsi
        qteM35tr4poxQexfp6vjVvzu7XBmSpOifHtJjnt9/Q==
X-Google-Smtp-Source: APXvYqwnj4AfSHo4zaKShEx5x/xfpdyGgXeEebNiuYFmoZO8TrjatmHOB/N9SjERHBTajCv/IJuhtVvRitJpvc0lQQ8=
X-Received: by 2002:a63:3006:: with SMTP id w6mr30236162pgw.440.1566406630977;
 Wed, 21 Aug 2019 09:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190821164730.47450-1-catalin.marinas@arm.com> <20190821164730.47450-3-catalin.marinas@arm.com>
In-Reply-To: <20190821164730.47450-3-catalin.marinas@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 21 Aug 2019 18:57:00 +0200
Message-ID: <CAAeHK+wHDx5bqNd+OQuJWoiA=LzsjCWkQ2UY_JVipr852Gv4JA@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] arm64: Define Documentation/arm64/tagged-address-abi.rst
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 21, 2019 at 6:47 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> On AArch64 the TCR_EL1.TBI0 bit is set by default, allowing userspace
> (EL0) to perform memory accesses through 64-bit pointers with a non-zero
> top byte. Introduce the document describing the relaxation of the
> syscall ABI that allows userspace to pass certain tagged pointers to
> kernel syscalls.
>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Andrey Konovalov <andreyknvl@google.com>


> ---
>  Documentation/arm64/tagged-address-abi.rst | 156 +++++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/arm64/tagged-address-abi.rst
>
> diff --git a/Documentation/arm64/tagged-address-abi.rst b/Documentation/arm64/tagged-address-abi.rst
> new file mode 100644
> index 000000000000..d4a85d535bf9
> --- /dev/null
> +++ b/Documentation/arm64/tagged-address-abi.rst
> @@ -0,0 +1,156 @@
> +==========================
> +AArch64 TAGGED ADDRESS ABI
> +==========================
> +
> +Authors: Vincenzo Frascino <vincenzo.frascino@arm.com>
> +         Catalin Marinas <catalin.marinas@arm.com>
> +
> +Date: 21 August 2019
> +
> +This document describes the usage and semantics of the Tagged Address
> +ABI on AArch64 Linux.
> +
> +1. Introduction
> +---------------
> +
> +On AArch64 the ``TCR_EL1.TBI0`` bit is set by default, allowing
> +userspace (EL0) to perform memory accesses through 64-bit pointers with
> +a non-zero top byte. This document describes the relaxation of the
> +syscall ABI that allows userspace to pass certain tagged pointers to
> +kernel syscalls.
> +
> +2. AArch64 Tagged Address ABI
> +-----------------------------
> +
> +From the kernel syscall interface perspective and for the purposes of
> +this document, a "valid tagged pointer" is a pointer with a potentially
> +non-zero top-byte that references an address in the user process address
> +space obtained in one of the following ways:
> +
> +- ``mmap()`` syscall where either:
> +
> +  - flags have the ``MAP_ANONYMOUS`` bit set or
> +  - the file descriptor refers to a regular file (including those
> +    returned by ``memfd_create()``) or ``/dev/zero``
> +
> +- ``brk()`` syscall (i.e. the heap area between the initial location of
> +  the program break at process creation and its current location).
> +
> +- any memory mapped by the kernel in the address space of the process
> +  during creation and with the same restrictions as for ``mmap()`` above
> +  (e.g. data, bss, stack).
> +
> +The AArch64 Tagged Address ABI has two stages of relaxation depending
> +how the user addresses are used by the kernel:
> +
> +1. User addresses not accessed by the kernel but used for address space
> +   management (e.g. ``mmap()``, ``mprotect()``, ``madvise()``). The use
> +   of valid tagged pointers in this context is always allowed.
> +
> +2. User addresses accessed by the kernel (e.g. ``write()``). This ABI
> +   relaxation is disabled by default and the application thread needs to
> +   explicitly enable it via ``prctl()`` as follows:
> +
> +   - ``PR_SET_TAGGED_ADDR_CTRL``: enable or disable the AArch64 Tagged
> +     Address ABI for the calling thread.
> +
> +     The ``(unsigned int) arg2`` argument is a bit mask describing the
> +     control mode used:
> +
> +     - ``PR_TAGGED_ADDR_ENABLE``: enable AArch64 Tagged Address ABI.
> +       Default status is disabled.
> +
> +     Arguments ``arg3``, ``arg4``, and ``arg5`` must be 0.
> +
> +   - ``PR_GET_TAGGED_ADDR_CTRL``: get the status of the AArch64 Tagged
> +     Address ABI for the calling thread.
> +
> +     Arguments ``arg2``, ``arg3``, ``arg4``, and ``arg5`` must be 0.
> +
> +   The ABI properties described above are thread-scoped, inherited on
> +   clone() and fork() and cleared on exec().
> +
> +   Calling ``prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0)``
> +   returns ``-EINVAL`` if the AArch64 Tagged Address ABI is globally
> +   disabled by ``sysctl abi.tagged_addr_disabled=1``. The default
> +   ``sysctl abi.tagged_addr_disabled`` configuration is 0.
> +
> +When the AArch64 Tagged Address ABI is enabled for a thread, the
> +following behaviours are guaranteed:
> +
> +- All syscalls except the cases mentioned in section 3 can accept any
> +  valid tagged pointer.
> +
> +- The syscall behaviour is undefined for invalid tagged pointers: it may
> +  result in an error code being returned, a (fatal) signal being raised,
> +  or other modes of failure.
> +
> +- The syscall behaviour for a valid tagged pointer is the same as for
> +  the corresponding untagged pointer.
> +
> +
> +A definition of the meaning of tagged pointers on AArch64 can be found
> +in Documentation/arm64/tagged-pointers.rst.
> +
> +3. AArch64 Tagged Address ABI Exceptions
> +-----------------------------------------
> +
> +The following system call parameters must be untagged regardless of the
> +ABI relaxation:
> +
> +- ``prctl()`` other than pointers to user data either passed directly or
> +  indirectly as arguments to be accessed by the kernel.
> +
> +- ``ioctl()`` other than pointers to user data either passed directly or
> +  indirectly as arguments to be accessed by the kernel.
> +
> +- ``shmat()`` and ``shmdt()``.
> +
> +Any attempt to use non-zero tagged pointers may result in an error code
> +being returned, a (fatal) signal being raised, or other modes of
> +failure.
> +
> +4. Example of correct usage
> +---------------------------
> +.. code-block:: c
> +
> +   #include <stdlib.h>
> +   #include <string.h>
> +   #include <unistd.h>
> +   #include <sys/mman.h>
> +   #include <sys/prctl.h>
> +
> +   #define PR_SET_TAGGED_ADDR_CTRL     55
> +   #define PR_TAGGED_ADDR_ENABLE       (1UL << 0)
> +
> +   #define TAG_SHIFT           56
> +
> +   int main(void)
> +   {
> +       int tbi_enabled = 0;
> +       unsigned long tag = 0;
> +       char *ptr;
> +
> +       /* check/enable the tagged address ABI */
> +       if (!prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0))
> +               tbi_enabled = 1;
> +
> +       /* memory allocation */
> +       ptr = mmap(NULL, sysconf(_SC_PAGE_SIZE), PROT_READ | PROT_WRITE,
> +                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +       if (ptr == MAP_FAILED)
> +               return 1;
> +
> +       /* set a non-zero tag if the ABI is available */
> +       if (tbi_enabled)
> +               tag = rand() & 0xff;
> +       ptr = (char *)((unsigned long)ptr | (tag << TAG_SHIFT));
> +
> +       /* memory access to a tagged address */
> +       strcpy(ptr, "tagged pointer\n");
> +
> +       /* syscall with a tagged pointer */
> +       write(1, ptr, strlen(ptr));
> +
> +       return 0;
> +   }
