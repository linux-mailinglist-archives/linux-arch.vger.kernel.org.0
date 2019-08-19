Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6EB79492D
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 17:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfHSPvK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 11:51:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33811 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSPvK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 11:51:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so1457846pgc.1
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3aT4hIoGoOxTITnPRxvZVZEP0ZMplvO3FsPS6VTLrIE=;
        b=PFK+Euq4eAv4stee6fofZ6gDmqlftrBH/YMhCED0VWVhe5SooEqYb0YDDhkOtZtnZ7
         JLrxQc5VrC3cql3m2lqkw7PtsRM2xPQp4TDduiB6uTA1yixI9WRHt6pwiUM/J/L7dSBG
         XIft5dFKclnG+cguBASUE2SfAWFUgRIkjbPSBUjIVPozrNnTE3KiaYqmdk66vRsW/Dgz
         3mAKmVjZIcwcVZcprRTiqT7aoarPwN2ROPgQOoaj8KtoebC6zUruPAjuaz/oqJvH9xng
         ndiSeIKWtl73t5T8Vy0zFIQneF3vpVaibiO23HLMJKsr40xCM00mBJNYOW1WVePtCpoU
         eLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aT4hIoGoOxTITnPRxvZVZEP0ZMplvO3FsPS6VTLrIE=;
        b=q88hk7FVCjTTqr0vbMYTF+ffIusOmBuUqWsv5hR/4BIrXYIze+Nv/Q+VGcH5g7w1Jq
         b9DKdixoPUc6sR9u8ABC2BL6F+Eo/LSL/y4ruIEWhUPBcKlVD8f9HNdBaRaU/CyuOwte
         cmscfd1TzPcGq22P+NGXz56trwcjBsCr5Qpi8sS+w/2fNkBUFF5ccHeoO66JiOXHI9l9
         ifB3KSIcQwY152nLB7ZzJNV2UnJ0LTalX+dvjjSbIJ2cdCZ5DZ6gr11tINFJLlKhKTmR
         oPS2oN9E2ezF7PCJHWXQdW7qghp3O6LRliTgYgYT6fRXpiDjYrWkrW0jLPa9UWhMH3Ql
         l5Zg==
X-Gm-Message-State: APjAAAUK0Zw0IeuMwJQWcNiUJlCG2NdlnL9u+BRtUPr66rHQL4c7ay7l
        36y7HgWfT27GqvtxSMFTGPnJsjspJDArGpXQXTpALQ==
X-Google-Smtp-Source: APXvYqzpbwkdUPa164NFyhgPqd+w4X5msjPIvE7rxGK6/5zEmTXY5YFlDgIHgUQ8fIpsWQbEJbgIB1DEIMJXUsWPBDA=
X-Received: by 2002:aa7:9e9a:: with SMTP id p26mr25307646pfq.25.1566229868631;
 Mon, 19 Aug 2019 08:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190815154403.16473-1-catalin.marinas@arm.com> <20190815154403.16473-5-catalin.marinas@arm.com>
In-Reply-To: <20190815154403.16473-5-catalin.marinas@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 19 Aug 2019 17:50:57 +0200
Message-ID: <CAAeHK+xpfCxeMya5aiwaUw1hKTd5C32naqrREpz-3GSXM73ELw@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] arm64: Define Documentation/arm64/tagged-address-abi.rst
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 15, 2019 at 5:44 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
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
>  Documentation/arm64/tagged-address-abi.rst | 155 +++++++++++++++++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 Documentation/arm64/tagged-address-abi.rst
>
> diff --git a/Documentation/arm64/tagged-address-abi.rst b/Documentation/arm64/tagged-address-abi.rst
> new file mode 100644
> index 000000000000..8808337775d6
> --- /dev/null
> +++ b/Documentation/arm64/tagged-address-abi.rst
> @@ -0,0 +1,155 @@
> +==========================
> +AArch64 TAGGED ADDRESS ABI
> +==========================
> +
> +Authors: Vincenzo Frascino <vincenzo.frascino@arm.com>
> +         Catalin Marinas <catalin.marinas@arm.com>
> +
> +Date: 15 August 2019
> +
> +This document describes the usage and semantics of the Tagged Address
> +ABI on AArch64 Linux.
> +
> +1. Introduction
> +---------------
> +
> +On AArch64 the TCR_EL1.TBI0 bit is set by default, allowing userspace
> +(EL0) to perform memory accesses through 64-bit pointers with a non-zero
> +top byte. This document describes the relaxation of the syscall ABI that
> +allows userspace to pass certain tagged pointers to kernel syscalls.
> +
> +2. AArch64 Tagged Address ABI
> +-----------------------------
> +
> +From the kernel syscall interface perspective and for the purposes of
> +this document, a "valid tagged pointer" is a pointer with a potentially
> +non-zero top-byte that references an address in the user process address
> +space obtained in one of the following ways:
> +
> +- mmap() done by the process itself (or its parent), where either:
> +
> +  - flags have the **MAP_ANONYMOUS** bit set
> +  - the file descriptor refers to a regular file (including those
> +    returned by memfd_create()) or **/dev/zero**
> +
> +- brk() system call done by the process itself (i.e. the heap area
> +  between the initial location of the program break at process creation
> +  and its current location).
> +
> +- any memory mapped by the kernel in the address space of the process
> +  during creation and with the same restrictions as for mmap() above
> +  (e.g. data, bss, stack).
> +
> +The AArch64 Tagged Address ABI has two stages of relaxation depending
> +how the user addresses are used by the kernel:
> +
> +1. User addresses not accessed by the kernel but used for address space
> +   management (e.g. mmap(), mprotect(), madvise()). The use of valid
> +   tagged pointers in this context is always allowed.
> +
> +2. User addresses accessed by the kernel (e.g. write()). This ABI
> +   relaxation is disabled by default and the application thread needs to
> +   explicitly enable it via **prctl()** as follows:
> +
> +   - **PR_SET_TAGGED_ADDR_CTRL**: enable or disable the AArch64 Tagged
> +     Address ABI for the calling thread.
> +
> +     The (unsigned int) arg2 argument is a bit mask describing the
> +     control mode used:
> +
> +     - **PR_TAGGED_ADDR_ENABLE**: enable AArch64 Tagged Address ABI.
> +       Default status is disabled.
> +
> +     Arguments arg3, arg4, and arg5 must be 0.
> +
> +   - **PR_GET_TAGGED_ADDR_CTRL**: get the status of the AArch64 Tagged
> +     Address ABI for the calling thread.
> +
> +     Arguments arg2, arg3, arg4, and arg5 must be 0.
> +
> +   The ABI properties described above are thread-scoped, inherited on
> +   clone() and fork() and cleared on exec().
> +
> +   Calling prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0)
> +   returns -EINVAL if the AArch64 Tagged Address ABI is globally disabled
> +   by sysctl abi.tagged_addr_disabled=1. The default sysctl
> +   abi.tagged_addr_disabled configuration is 0.
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
> +- A valid tagged pointer has the same semantics as the corresponding
> +  untagged pointer.
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
> +- prctl() other than arguments pointing to user structures to be
> +  accessed by the kernel.
> +
> +- ioctl() other than arguments pointing to user structures to be
> +  accessed by the kernel.
> +
> +- shmat() and shmdt().
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
