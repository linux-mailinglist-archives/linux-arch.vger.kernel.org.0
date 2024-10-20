Return-Path: <linux-arch+bounces-8296-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA599A5211
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 05:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BCD1C22189
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 03:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF628F1;
	Sun, 20 Oct 2024 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uKHEONGz"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3B2F22
	for <linux-arch@vger.kernel.org>; Sun, 20 Oct 2024 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729394430; cv=none; b=AsSKhKwC816vVhZ4iWoZYGhtl4VvPrEla+yH6CnkjtRa3MYrbQFeNt3anPtCvhwLXz0HMLT9Z9QUN+a/IVk9k+KYe584CCmbSXcN3FbeeMPboNioVs99fenwR7k8GOsM+RLlF64zZzqfjF9QjG/C5m677xxoMtJNZ9VqOLX1X0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729394430; c=relaxed/simple;
	bh=meRoOtmEK+GHaT/Jn/4a7l3dMXe6RHFlKdwtGmZMUe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DG6Vr4hGeIjAF01D3bRPmxIG2TwwL7T2pdYt8MEtdv0TpQxEeJgdHcVkK0Qb2WYIFatYvYZcwf/HFfaFlLLA8v41aDN+WbDmKANpVieYNgREBZ2ylU3eZjpdVkwdPJx8XWW48d5UOsmLbzCzlyH12hJJFDGc4O6BaEqPbYkMuNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uKHEONGz; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7c7b053e-28a1-490f-ba8c-a7eb60ca81d2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729394423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPl2yq5UvwsWil+2Bp35g/sSg8f0++FeykoufY0O9Pw=;
	b=uKHEONGzj6/vGyEFWzF36CBQ6VsmV6+Re01k5sygIpZDVh+EzrT4H8v5v9QfPECsBjX17z
	JGQktFVvR5iuTDRhxB31mpenVShkaTNotuzTVOa7NpwMugxdQKoxkJ0FZEozFEVnqia8jJ
	BPgReqjYOjj6p/D3H4cRWa8zf8+9jbA=
Date: Sat, 19 Oct 2024 20:20:09 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/6] Add AutoFDO and Propeller support for Clang build
Content-Language: en-GB
To: Rong Xu <xur@google.com>, Alice Ryhl <aliceryhl@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>,
 Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Wei Yang <richard.weiyang@gmail.com>,
 workflows@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Maksim Panchenko <max4bolt@gmail.com>, Yabin Cui <yabinc@google.com>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20241014213342.1480681-1-xur@google.com>
 <CAF1bQ=SQ9rFdwRk_waQvn4PW7x6T1uJmJ8qNqj04oRKmujkCQw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAF1bQ=SQ9rFdwRk_waQvn4PW7x6T1uJmJ8qNqj04oRKmujkCQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/18/24 11:20 PM, Rong Xu wrote:
> Thanks to all for the feedback and suggestions! We are ready to make any further
> changes needed. Is there anything else we can address for this patch?
>
> Also, we know it's not easy to test this patch, but if anyone has had a chance
> to try building AutoFDO/Propeller kernels with it, we'd really appreciate your
> input here. Any confirmation that it works as expected would be very helpful.
>
> -Rong
>
> On Mon, Oct 14, 2024 at 2:33 PM Rong Xu <xur@google.com> wrote:
>> Hi,
>>
>> This patch series is to integrate AutoFDO and Propeller support into
>> the Linux kernel. AutoFDO is a profile-guided optimization technique
>> that leverages hardware sampling to enhance binary performance.
>> Unlike Instrumentation-based FDO (iFDO), AutoFDO offers a user-friendly
>> and straightforward application process. While iFDO generally yields
>> superior profile quality and performance, our findings reveal that
>> AutoFDO achieves remarkable effectiveness, bringing performance close
>> to iFDO for benchmark applications.
>>
>> Propeller is a profile-guided, post-link optimizer that improves
>> the performance of large-scale applications compiled with LLVM. It
>> operates by relinking the binary based on an additional round of runtime
>> profiles, enabling precise optimizations that are not possible at
>> compile time.  Similar to AutoFDO, Propeller too utilizes hardware
>> sampling to collect profiles and apply post-link optimizations to improve
>> the benchmark’s performance over and above AutoFDO.
>>
>> Our empirical data demonstrates significant performance improvements
>> with AutoFDO and Propeller, up to 10% on microbenchmarks and up to 5%
>> on large warehouse-scale benchmarks. This makes a strong case for their
>> inclusion as supported features in the upstream kernel.
>>
>> Background
>>
>> A significant fraction of fleet processing cycles (excluding idle time)
>> from data center workloads are attributable to the kernel. Ware-house
>> scale workloads maximize performance by optimizing the production kernel
>> using iFDO (a.k.a instrumented PGO, Profile Guided Optimization).
>>
>> iFDO can significantly enhance application performance but its use
>> within the kernel has raised concerns. AutoFDO is a variant of FDO that
>> uses the hardware’s Performance Monitoring Unit (PMU) to collect
>> profiling data. While AutoFDO typically yields smaller performance
>> gains than iFDO, it presents unique benefits for optimizing kernels.
>>
>> AutoFDO eliminates the need for instrumented kernels, allowing a single
>> optimized kernel to serve both execution and profile collection. It also
>> minimizes slowdown during profile collection, potentially yielding
>> higher-fidelity profiling, especially for time-sensitive code, compared
>> to iFDO. Additionally, AutoFDO profiles can be obtained from production
>> environments via the hardware’s PMU whereas iFDO profiles require
>> carefully curated load tests that are representative of real-world
>> traffic.
>>
>> AutoFDO facilitates profile collection across diverse targets.
>> Preliminary studies indicate significant variation in kernel hot spots
>> within Google’s infrastructure, suggesting potential performance gains
>> through target-specific kernel customization.
>>
>> Furthermore, other advanced compiler optimization techniques, including
>> ThinLTO and Propeller can be stacked on top of AutoFDO, similar to iFDO.
>> ThinLTO achieves better runtime performance through whole-program
>> analysis and cross module optimizations. The main difference between
>> traditional LTO and ThinLTO is that the latter is scalable in time and
>> memory.
>>
>> This patch series adds AutoFDO and Propeller support to the kernel. The
>> actual solution comes in six parts:
>>
>> [P 1] Add the build support for using AutoFDO in Clang
>>
>>        Add the basic support for AutoFDO build and provide the
>>        instructions for using AutoFDO.
>>
>> [P 2] Fix objtool for bogus warnings when -ffunction-sections is enabled
>>
>> [P 3] Change the subsection ordering when -ffunction-sections is enabled
>>
>> [P 4] Enable –ffunction-sections for the AutoFDO build
>>
>> [P 5] Enable Machine Function Split (MFS) optimization for AutoFDO
>>
>> [P 6] Add Propeller configuration to the kernel build
>>
>> Patch 1 provides basic AutoFDO build support. Patches 2 to 5 further
>> enhance the performance of AutoFDO builds and are functionally dependent
>> on Patch 1. Patch 6 enables support for Propeller and is dependent on
>> patch 2 and patch 3.
>>
>> Caveats
>>
>> AutoFDO is compatible with both GCC and Clang, but the patches in this
>> series are exclusively applicable to LLVM 17 or newer for AutoFDO and
>> LLVM 19 or newer for Propeller. For profile conversion, two different
>> tools could be used, llvm_profgen or create_llvm_prof. llvm_profgen
>> needs to be the LLVM 19 or newer, or just the LLVM trunk. Alternatively,
>> create_llvm_prof v0.30.1 or newer can be used instead of llvm-profgen.
>>
>> Additionally, the build is only supported on x86 platforms equipped
>> with PMU capabilities, such as LBR on Intel machines. More
>> specifically:
>>   * Intel platforms: works on every platform that supports LBR;
>>     we have tested on Skylake.
>>   * AMD platforms: tested on AMD Zen3 with the BRS feature. The kernel
>>     needs to be configured with “CONFIG_PERF_EVENTS_AMD_BRS=y", To
>>     check, use
>>     $ cat /proc/cpuinfo | grep “ brs”
>>     For the AMD Zen4, AMD LBRV2 is supported, but we suspect a bug with
>>     AMD LBRv2 implementation in Genoa which blocks the usage.
>>
>> Experiments and Results
>>
>> Experiments were conducted to compare the performance of AutoFDO-optimized
>> kernel images (version 6.9.x) against default builds.. The evaluation
>> encompassed both open source microbenchmarks and real-world production
>> services from Google and Meta. The selected microbenchmarks included Neper,
>> a network subsystem benchmark, and UnixBench which is a comprehensive suite
>> for assessing various kernel operations.
>>
>> For Neper, AutoFDO optimization resulted in a 6.1% increase in throughput
>> and a 10.6% reduction in latency. Unixbench saw a 2.2% improvement in its
>> index score under low system load and a 2.6% improvement under high system
>> load.
>>
>> For further details on the improvements observed in Google and Meta's
>> production services, please refer to the LLVM discourse post:
>> https://discourse.llvm.org/t/optimizing-the-linux-kernel-with-autofdo-including-thinlto-and-propeller/79108
>>
>> Thanks,
>>
>> Rong Xu and Han Shen
>>
>> Change-Logs in V2:
>> Rebased the source to e32cde8d2bd7 (Merge tag 'sched_ext-for-6.12-rc1-fixes-1')
>> 1. Cover-letter: moved the Propeller description to the top (Peter Zijlstra)
>> 2. [P 1]: (1) Makefile: fixed file order (Masahiro Yamada)
>>            (2) scripts/Makefile.lib: used is-kernel-object to exclude
>>                files (Masahiro Yamada)
>>            (3) scripts/Makefile.autofdo: improved the code (Masahiro Yamada)
>>            (4) scripts/Makefile.autofdo: handled when DEBUG_INFO disabled (Nick Desaulniers)
>> 3. [P 2]: tools/objtool/elf.c: updated the comments (Peter Zijlstra)
>> 4. [P 3]: include/asm-generic/vmlinux.lds.h:
>>            (1) explicit set cold text function aligned (Peter Zijlstra and Peter Anvin)
>>            (2) set hot-text page aligned
>> 5. [P 6]: (1) include/asm-generic/vmlinux.lds.h: made Propeller not depending
>>                on AutoFDO
>>            (2) Makefile: fixed file order (Masahiro Yamada)
>>            (3) scripts/Makefile.lib: used is-kernel-object to exclude
>>                files (Masahiro Yamada). This removed the change in
>>                arch/x86/platform/efi/Makefile,
>>                drivers/firmware/efi/libstub/Makefile, and
>>                arch/x86/boot/compressed/Makefile.
>>                And this also addressed the comment from Arnd Bergmann regarding
>>                arch/x86/purgatory/Makefile.
>>            (4) scripts/Makefile.propeller: improved the code (Masahiro Yamada)
>>
>> Change-Logs in V3:
>> Rebased the source to eb952c47d154 (Merge tag 'for-6.12-rc2-tag').
>> 1. [P 1]: autofdo.rst: removed code-block directives and used "::" (Mike Rapoport)
>> 2. [P 6]: propeller.rst: removed code-block directives and use "::" (Mike Rapoport)
>>
>> Change-Logs in V4:
>> 1. [P 1]: autofdo.rst: fixed a typo for create_llvm_prof commmand.
>>
>> Rong Xu (6):
>>    Add AutoFDO support for Clang build
>>    objtool: Fix unreachable instruction warnings for weak funcitons
>>    Change the symbols order when --ffuntion-sections is enabled
>>    AutoFDO: Enable -ffunction-sections for the AutoFDO build
>>    AutoFDO: Enable machine function split optimization for AutoFDO
>>    Add Propeller configuration for kernel build.
>>
>>   Documentation/dev-tools/autofdo.rst   | 165 ++++++++++++++++++++++++++
>>   Documentation/dev-tools/index.rst     |   2 +
>>   Documentation/dev-tools/propeller.rst | 161 +++++++++++++++++++++++++
>>   MAINTAINERS                           |  14 +++
>>   Makefile                              |   2 +
>>   arch/Kconfig                          |  42 +++++++
>>   arch/x86/Kconfig                      |   2 +
>>   arch/x86/kernel/vmlinux.lds.S         |   4 +
>>   include/asm-generic/vmlinux.lds.h     |  54 +++++++--
>>   scripts/Makefile.autofdo              |  25 ++++
>>   scripts/Makefile.lib                  |  20 ++++
>>   scripts/Makefile.propeller            |  28 +++++
>>   tools/objtool/check.c                 |   2 +
>>   tools/objtool/elf.c                   |  15 ++-
>>   14 files changed, 524 insertions(+), 12 deletions(-)
>>   create mode 100644 Documentation/dev-tools/autofdo.rst
>>   create mode 100644 Documentation/dev-tools/propeller.rst
>>   create mode 100644 scripts/Makefile.autofdo
>>   create mode 100644 scripts/Makefile.propeller
>>
>>
>> base-commit: eb952c47d154ba2aac794b99c66c3c45eb4cc4ec
>> --
>> 2.47.0.rc1.288.g06298d1525-goog
>>
I tried this patch set on our production machine.
I am using llvm19, built by myself from the llvm19 release branch. I tried
with x86_64 intel processor only. The base config file is based on Meta internal
config file (production version).

Overall, I didn't find any issues. I checked IR file with both non-lto and lto
version and in both cases, the expected sample PGO loader indeed added
some profiles to IR. For non-lto versions during normal compilation. For lto
version both optimization before lto and during lto.

The propeller works fine too. I downloaded the binary from the autofdo git
repo as directed in the commit message of patch 6. create_llvm_prof dumps
a lot of information which shows quite some functions with profile data.
I also checked some asm code and does see basic-block level section
are encoded in .s file (it should be in .o file as well but .s file is easier
to reason.)

The training data is collected with some workloads in the machine, not heavy
but for testing purposes it should be enough.
I run bpf selftests on the eventual kernel (after autofdo and propeller).
Everything works fine.

Of course I didn't try all possible combination. But for the config I am using
(heavily geared for bpf selftests), things work fine. So

Tested-by: Yonghong Song <yonghong.song@linux.dev>


