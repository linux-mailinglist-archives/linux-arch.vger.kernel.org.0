Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDBF3A31A3
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 19:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhFJREK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 13:04:10 -0400
Received: from foss.arm.com ([217.140.110.172]:37098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231603AbhFJREJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jun 2021 13:04:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 074851396;
        Thu, 10 Jun 2021 10:02:13 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AD043F719;
        Thu, 10 Jun 2021 10:02:12 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] arm64: Enable BTI for the executable as well as
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
References: <20210604112450.13344-1-broonie@kernel.org>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <43e67d7b-aab9-db1f-f74b-a87ba7442d47@arm.com>
Date:   Thu, 10 Jun 2021 11:28:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210604112450.13344-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 6/4/21 6:24 AM, Mark Brown wrote:
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

I've got a Fedora34 system booting in qemu or a model with BTI enabled. 
On that system I took the systemd-resolved executable, which is one of 
the services with MDWE enabled, and replaced a number of the bti's with 
nops. I expect the service to continue to work with the fedora or 
mainline 5.13 kernel and it does. If instead I boot with MDWE=no for the 
service, it should fail to start given either of those kernels, and it does.

Thus, I expect that with his patch applied to 5.13 the service will fail 
to start regardless of the state of MDWE, but it seems to continue 
starting when I set MDWE=yes. Same behavior with v1 FWTW.

Of course, there is a good chance I've messed something up or i'm 
missing something. I should really validate the /lib/ld-linux behavior 
itself too. I guess this could just as well be a glibc issue (f34 has 
glibc 2.33-5 which appears to have the re-mmap on failure patch). Either 
way, systemd-resolved is a LSB PIE, with /lib/ld-linux as its 
interpreter. I've not dug too deep into debugging this, cause I've got a 
couple other things I need to deal with in the next couple days, and I 
strongly dislike booting a full debug+system on the model. chuckle, sorry...


Thanks,


> 
> This does mean that we may get more code with BTI enabled if running on
> a system without BTI support in the dynamic linker, this is expected to
> be a safe configuration and testing seems to confirm that. It also
> reduces the flexibility userspace has to disable BTI but it is expected
> that for cases where there are problems which require BTI to be disabled
> it is more likely that it will need to be disabled on a system level.
> 
> v2:
>   - Add a patch dropping has_interp from arch_adjust_elf_prot()
>   - Fix bisection issue with static executables on arm64 in the first
>     patch.
> 
> Mark Brown (3):
>    elf: Allow architectures to parse properties on the main executable
>    arm64: Enable BTI for main executable as well as the interpreter
>    elf: Remove has_interp property from arch_adjust_elf_prot()
> 
>   arch/arm64/include/asm/elf.h | 13 ++++++++++---
>   arch/arm64/kernel/process.c  | 20 +++++++-------------
>   fs/binfmt_elf.c              | 29 ++++++++++++++++++++---------
>   include/linux/elf.h          |  8 +++++---
>   4 files changed, 42 insertions(+), 28 deletions(-)
> 
> 
> base-commit: c4681547bcce777daf576925a966ffa824edd09d
> 

