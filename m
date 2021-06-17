Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B13A3ABC50
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jun 2021 21:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhFQTHL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Jun 2021 15:07:11 -0400
Received: from foss.arm.com ([217.140.110.172]:58744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232508AbhFQTHK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Jun 2021 15:07:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63D4113A1;
        Thu, 17 Jun 2021 12:05:02 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D0833F694;
        Thu, 17 Jun 2021 12:05:02 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
References: <20210614223214.39011-1-broonie@kernel.org>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <10f9df55-47e4-f230-e1b4-73113daa9791@arm.com>
Date:   Thu, 17 Jun 2021 14:05:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210614223214.39011-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 6/14/21 5:32 PM, Mark Brown wrote:
> Deployments of BTI on arm64 have run into issues interacting with
> systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
> linked executables the kernel will only handle architecture specific
> properties like BTI for the interpreter, the expectation is that the
> interpreter will then handle any properties on the main executable.
> For BTI this means remapping the executable segments PROT_EXEC |
> PROT_BTI.
> 
> This interacts poorly with MemoryDenyWriteExecute since that is
> implemented using a seccomp filter which prevents setting PROT_EXEC on
> already mapped memory and lacks the context to be able to detect that
> memory is already mapped with PROT_EXEC.  This series resolves this by
> handling the BTI property for both the interpreter and the main
> executable.
> 
> This does mean that we may get more code with BTI enabled if running on
> a system without BTI support in the dynamic linker, this is expected to
> be a safe configuration and testing seems to confirm that. It also
> reduces the flexibility userspace has to disable BTI but it is expected
> that for cases where there are problems which require BTI to be disabled
> it is more likely that it will need to be disabled on a system level.

It looks like its working as expected now (the previously detailed test 
is now failing) in a MDWE enviroment, and the smaps/etc looks as 
expected too.

Thanks for fixing this!

tested-by: Jeremy Linton <jeremy.linton@arm.com>


> 
> v3:
>   - Fix passing of properties for parsing by the main executable.
>   - Drop has_interp from arch_parse_elf_property().
>   - Coding style tweaks.
> v2:
>   - Add a patch dropping has_interp from arch_adjust_elf_prot()
>   - Fix bisection issue with static executables on arm64 in the first
>     patch.
> 
> Mark Brown (4):
>    elf: Allow architectures to parse properties on the main executable
>    arm64: Enable BTI for main executable as well as the interpreter
>    elf: Remove has_interp property from arch_adjust_elf_prot()
>    elf: Remove has_interp property from arch_parse_elf_property()
> 
>   arch/arm64/include/asm/elf.h | 13 ++++++++++---
>   arch/arm64/kernel/process.c  | 23 +++++++++++------------
>   fs/binfmt_elf.c              | 33 ++++++++++++++++++++++++---------
>   include/linux/elf.h          |  8 +++++---
>   4 files changed, 50 insertions(+), 27 deletions(-)
> 
> 
> base-commit: c4681547bcce777daf576925a966ffa824edd09d
> 

