Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A71A184659
	for <lists+linux-arch@lfdr.de>; Fri, 13 Mar 2020 13:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgCMMBg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Mar 2020 08:01:36 -0400
Received: from foss.arm.com ([217.140.110.172]:53730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgCMMBg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Mar 2020 08:01:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6AEFFEC;
        Fri, 13 Mar 2020 05:01:35 -0700 (PDT)
Received: from [10.37.12.218] (unknown [10.37.12.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9F7A3F534;
        Fri, 13 Mar 2020 05:01:31 -0700 (PDT)
Subject: Re: [PATCH v2 20/20] arm64: vdso32: Enable Clang Compilation
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>
References: <20200306133242.26279-1-vincenzo.frascino@arm.com>
 <20200306133242.26279-21-vincenzo.frascino@arm.com>
 <20200310014039.GA12211@ubuntu-m2-xlarge-x86>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <ce62f238-eea9-a0eb-6f72-a3ef5c4a275a@arm.com>
Date:   Fri, 13 Mar 2020 12:01:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200310014039.GA12211@ubuntu-m2-xlarge-x86>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/10/20 1:40 AM, Nathan Chancellor wrote:
> On Fri, Mar 06, 2020 at 01:32:42PM +0000, Vincenzo Frascino wrote:
>> Enable Clang Compilation for the vdso32 library.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/kernel/vdso32/Makefile | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
>> index 04df57b43cb1..650cfc5757eb 100644
>> --- a/arch/arm64/kernel/vdso32/Makefile
>> +++ b/arch/arm64/kernel/vdso32/Makefile
>> @@ -10,7 +10,18 @@ include $(srctree)/lib/vdso/Makefile
>>  
>>  # Same as cc-*option, but using CC_COMPAT instead of CC
>>  ifeq ($(CONFIG_CC_IS_CLANG), y)
>> -CC_COMPAT ?= $(CC)
>> +COMPAT_GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE_COMPAT)elfedit))
>> +COMPAT_GCC_TOOLCHAIN := $(realpath $(COMPAT_GCC_TOOLCHAIN_DIR)/..)
>> +
>> +CLANG_CC_COMPAT := $(CC)
>> +CLANG_CC_COMPAT += --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
>> +CLANG_CC_COMPAT += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)
>> +CLANG_CC_COMPAT += -no-integrated-as -Qunused-arguments
>> +ifneq ($(COMPAT_GCC_TOOLCHAIN),)
>> +CLANG_CC_COMPAT += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
>> +endif
>> +
>> +CC_COMPAT ?= $(CLANG_CC_COMPAT)
>>  else
>>  CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
>>  endif
>> -- 
>> 2.25.1
>>
> If CC_COMPAT is ever specified on the command line as clang (maybe by
> some unsuspecting user), we'd loose all of the above flags. Maybe it
> would be better to build a set of COMPAT_CLANG_FLAGS and append them to
> CC_COMPAT, maybe like below?
>

Fine by me.

> Regardless, the current approach works in my testing with clang 9.0.1
> and master (clang 11.0.0). This patch specifically is:
> 

Good to hear. I will add your tags to the patch.

> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build
> 
> ==================================================================================
> 
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 650cfc5757eb..df5145fab287 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -13,15 +13,16 @@ ifeq ($(CONFIG_CC_IS_CLANG), y)
>  COMPAT_GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE_COMPAT)elfedit))
>  COMPAT_GCC_TOOLCHAIN := $(realpath $(COMPAT_GCC_TOOLCHAIN_DIR)/..)
>  
> -CLANG_CC_COMPAT := $(CC)
> -CLANG_CC_COMPAT += --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
> -CLANG_CC_COMPAT += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)
> -CLANG_CC_COMPAT += -no-integrated-as -Qunused-arguments
> +COMPAT_CLANG_FLAGS := --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
> +COMPAT_CLANG_FLAGS += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)
> +COMPAT_CLANG_FLAGS += -no-integrated-as -Qunused-arguments
>  ifneq ($(COMPAT_GCC_TOOLCHAIN),)
> -CLANG_CC_COMPAT += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
> +COMPAT_CLANG_FLAGS += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
>  endif
>  
> -CC_COMPAT ?= $(CLANG_CC_COMPAT)
> +CC_COMPAT ?= $(CC)
> +CC_COMPAT += $(COMPAT_CLANG_FLAGS)
> +
>  else
>  CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
>  endif
> 

-- 
Regards,
Vincenzo
