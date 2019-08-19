Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452AB949CA
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 18:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfHSQZ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 12:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfHSQZz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Aug 2019 12:25:55 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2E322CEA;
        Mon, 19 Aug 2019 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566231954;
        bh=dreJjOF/L6ef6NrZc3iuTz3726uHjZ7gkP0YJGdGHG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gqn+tAYqBxyeyvPgLjWRmc6kokYMr8nSG21/SIX3emygHhXCZPb5up2OdCUnMqyJj
         lA6HJZa6khq/ZWrH+cXiwTve9D4s9FTAsov1BewhiVi5qi0Stubtbki018gVCGxfPg
         q9T4xgtaAZO0aBq+CmaHiJ746uzptEAa1tXpGOlo=
Date:   Mon, 19 Aug 2019 17:25:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v8 4/5] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Message-ID: <20190819162548.c7udab6g6i662qaa@willie-the-truck>
References: <20190815154403.16473-1-catalin.marinas@arm.com>
 <20190815154403.16473-5-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815154403.16473-5-catalin.marinas@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 15, 2019 at 04:44:02PM +0100, Catalin Marinas wrote:
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

nit: but the markup is pretty inconsistent throughout. Why is /dev/zero
bold, but not memfd_create()? I think they would both be better off in
typewriter font, if that's a thing in rst.

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

nit, but I'd reword this last bullet slightly to say:

  - The syscall behaviour for a valid tagged pointer is the same as for
    the corresponding untagged pointer.

Since that flows better wrt the previous bullet and is explicit about
syscall behaviour, rather than overall semantics.

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

I agree with Kevin that we should tighten this up. How about:

  - ... other than pointers to user data either passed directly or
    indirectly as arguments to be accessed by the kernel.

?

Will
