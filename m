Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4674C85486
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2019 22:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388961AbfHGUiS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Aug 2019 16:38:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:58433 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387957AbfHGUiS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Aug 2019 16:38:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 13:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; 
   d="scan'208";a="165464108"
Received: from ray.jf.intel.com (HELO [10.7.201.140]) ([10.7.201.140])
  by orsmga007.jf.intel.com with ESMTP; 07 Aug 2019 13:38:16 -0700
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Message-ID: <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
Date:   Wed, 7 Aug 2019 13:38:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807155321.9648-2-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/7/19 8:53 AM, Catalin Marinas wrote:
> +- mmap() done by the process itself (or its parent), where either:
> +
> +  - flags have the **MAP_ANONYMOUS** bit set
> +  - the file descriptor refers to a regular file (including those returned
> +    by memfd_create()) or **/dev/zero**

What's a "regular file"? ;)

> +- brk() system call done by the process itself (i.e. the heap area between
> +  the initial location of the program break at process creation and its
> +  current location).
> +
> +- any memory mapped by the kernel in the address space of the process
> +  during creation and with the same restrictions as for mmap() above (e.g.
> +  data, bss, stack).
> +
> +The AArch64 Tagged Address ABI is an opt-in feature and an application can
> +control it via **prctl()** as follows:
> +
> +- **PR_SET_TAGGED_ADDR_CTRL**: enable or disable the AArch64 Tagged Address
> +  ABI for the calling process.
> +
> +  The (unsigned int) arg2 argument is a bit mask describing the control mode
> +  used:
> +
> +  - **PR_TAGGED_ADDR_ENABLE**: enable AArch64 Tagged Address ABI. Default
> +    status is disabled.
> +
> +  The arguments arg3, arg4, and arg5 are ignored.

For previous prctl()'s, we've found that it's best to require that the
unused arguments be 0.  Without that, apps are free to put garbage
there, which makes extending the prctl to use other arguments impossible
in the future.

Also, shouldn't this be converted over to an arch_prctl()?

> +The prctl(PR_SET_TAGGED_ADDR_CTRL, ...) will return -EINVAL if the
> +AArch64 Tagged Address ABI is not available
> +(CONFIG_ARM64_TAGGED_ADDR_ABI disabled or sysctl abi.tagged_addr=0).
> +
> +The ABI properties set by the mechanism described above are inherited by
> +threads of the same application and fork()'ed children but cleared by
> +execve().

What is the scope of these prctl()'s?  Are they thread-scoped or
process-scoped?  Can two threads in the same process run with different
tagging ABI modes?

> +Opting in (the prctl() option described above only) to or out of the
> +AArch64 Tagged Address ABI can be disabled globally at runtime using the
> +sysctl interface:
> +
> +- **abi.tagged_addr**: a new sysctl interface that can be used to prevent
> +  applications from enabling or disabling the relaxed ABI. The sysctl
> +  supports the following configuration options:
> +
> +  - **0**: disable the prctl(PR_SET_TAGGED_ADDR_CTRL) option to
> +    enable/disable the AArch64 Tagged Address ABI globally
> +
> +  - **1** (Default): enable the prctl(PR_SET_TAGGED_ADDR_CTRL) option to
> +    enable/disable the AArch64 Tagged Address ABI globally
> +
> +  Note that this sysctl does not affect the status of the AArch64 Tagged
> +  Address ABI of the running processes.

Shouldn't the name be "abi.tagged_addr_control" or something?  It
actually has *zero* direct effect on tagged addresses in the ABI.

What's the reason for allowing it to be toggled at runtime like this?
Wouldn't it make more sense to just have it be a boot option so you
*know* what the state of individual processes is?

> +When a process has successfully enabled the new ABI by invoking
> +prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE), the following
> +behaviours are guaranteed:
> +
> +- Every currently available syscall, except the cases mentioned in section
> +  3, can accept any valid tagged pointer. The same rule is applicable to
> +  any syscall introduced in the future.
> +
> +- The syscall behaviour is undefined for non valid tagged pointers.

Do you really mean "undefined"?  I mean, a bad pointer is a bad pointer.
 Why should it matter if it's a tagged bad pointer or an untagged bad
pointer?

...
> +A definition of the meaning of tagged pointers on AArch64 can be found in:
> +Documentation/arm64/tagged-pointers.txt.
> +
> +3. AArch64 Tagged Address ABI Exceptions
> +-----------------------------------------
> +
> +The behaviour described in section 2, with particular reference to the
> +acceptance by the syscalls of any valid tagged pointer, is not applicable
> +to the following cases:

This is saying things in a pretty roundabout manner.  Can't it just say:
 "The following cases do not accept tagged pointers:"

> +- mmap() addr parameter.
> +
> +- mremap() new_address parameter.

Is munmap() missing?  Or was there a reason for leaving it out?

> +- prctl(PR_SET_MM, ``*``, ...) other than arg2 PR_SET_MM_MAP and
> +  PR_SET_MM_MAP_SIZE.
> +
> +- prctl(PR_SET_MM, PR_SET_MM_MAP{,_SIZE}, ...) struct prctl_mm_map fields.
> +
> +Any attempt to use non-zero tagged pointers will lead to undefined
> +behaviour.

I wonder if you want to generalize this a bit.  I think you're saying
that parts of the ABI that modify the *layout* of the address space
never accept tagged pointers.

> +4. Example of correct usage
> +---------------------------
> +.. code-block:: c
> +
> +   void main(void)
> +   {
> +           static int tbi_enabled = 0;
> +           unsigned long tag = 0;
> +
> +           char *ptr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
> +                            MAP_ANONYMOUS, -1, 0);
> +
> +           if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE,
> +                     0, 0, 0) == 0)
> +                   tbi_enabled = 1;
> +
> +           if (ptr == (void *)-1) /* MAP_FAILED */
> +                   return -1;
> +
> +           if (tbi_enabled)
> +                   tag = rand() & 0xff;
> +
> +           ptr = (char *)((unsigned long)ptr | (tag << TAG_SHIFT));
> +
> +           *ptr = 'a';
> +
> +           ...
> +   }

It looks like the TAG_SHIFT and tag size are pretty baked into the
aarch64 architecture.  But, are you confident that no future
implementations will want different positions or sizes?  (obviously
controlled by other TCR_EL1 bits)

