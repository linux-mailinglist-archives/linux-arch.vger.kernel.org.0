Return-Path: <linux-arch+bounces-9371-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FF29EFE23
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 22:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6519A188746D
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 21:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB971D6DC8;
	Thu, 12 Dec 2024 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m+T8qv/1"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB67C1CCEF7
	for <linux-arch@vger.kernel.org>; Thu, 12 Dec 2024 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734038479; cv=none; b=gfTcomTDxX6KdPYdG1pEQ+tfKeANkEaBG0Wopqdw+owkqo26wCjH3pHNIBWRJs2Dj7r4IVfKPvhSX5kGF/sMjGeoff86xSYgMUD1JsdyUlGKI4tOQQaZbfO3+TAefLuTB7YTYKs/soWOdq5driIlRFQ71dPJcVzNXBphp6JBFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734038479; c=relaxed/simple;
	bh=0xg0cSfkVdjJzmHUqdk9cFaherJKDKXpN9svkkPBA6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVXQ2d+XzgdHJgnEb/A+dbnynph2v3F+LHIsDDNMpkcVfNlOxy/lBzIciILhFKbiNpWKd0Kn4syCYxpqccE4II2s5WdYm9Gaj3JjUBFHqEfARmHNTWhNm/g1XgRzab5eLY78lqgFyqwrcQNHblh2BP9VHS9oIgZrHMzQr6hZu78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m+T8qv/1; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c0a6ae91-c925-40d6-8f95-59a9144d203b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734038462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAYBYhFCMsz3d7tgdSG2PsRwLSDWZC6GVr2NGcmo5rw=;
	b=m+T8qv/1a01qoK/q7hy/Dki7VS621jcPzbemiDCCJuZv03W35uNG/MFFpbJfqbcBjlUqbv
	wXdlwKkuPZ4Ap0bx8eIN9llEEYPo8K4LrSCGCIQEsP6y3M8mfc6eOBJjmxIQUiuPV+gc3D
	cGRRThgw5K/kNbo60c6r6TYh9npDLQ8=
Date: Thu, 12 Dec 2024 13:20:46 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 7/7] Add Propeller configuration for kernel build
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
 Maksim Panchenko <max4bolt@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Yabin Cui <yabinc@google.com>, Krzysztof Pszeniczny
 <kpszeniczny@google.com>, Sriraman Tallam <tmsriram@google.com>,
 Stephane Eranian <eranian@google.com>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20241102175115.1769468-1-xur@google.com>
 <20241102175115.1769468-8-xur@google.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241102175115.1769468-8-xur@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/2/24 10:51 AM, Rong Xu wrote:
> Add the build support for using Clang's Propeller optimizer. Like
> AutoFDO, Propeller uses hardware sampling to gather information
> about the frequency of execution of different code paths within a
> binary. This information is then used to guide the compiler's
> optimization decisions, resulting in a more efficient binary.
>
> The support requires a Clang compiler LLVM 19 or later, and the
> create_llvm_prof tool
> (https://github.com/google/autofdo/releases/tag/v0.30.1). This
> commit is limited to x86 platforms that support PMU features
> like LBR on Intel machines and AMD Zen3 BRS.
>
> Here is an example workflow for building an AutoFDO+Propeller
> optimized kernel:
>
> 1) Build the kernel on the host machine, with AutoFDO and Propeller
>     build config
>        CONFIG_AUTOFDO_CLANG=y
>        CONFIG_PROPELLER_CLANG=y
>     then
>        $ make LLVM=1 CLANG_AUTOFDO_PROFILE=<autofdo_profile>
>
> “<autofdo_profile>” is the profile collected when doing a non-Propeller
> AutoFDO build. This step builds a kernel that has the same optimization
> level as AutoFDO, plus a metadata section that records basic block
> information. This kernel image runs as fast as an AutoFDO optimized
> kernel.
>
> 2) Install the kernel on test/production machines.
>
> 3) Run the load tests. The '-c' option in perf specifies the sample
>     event period. We suggest using a suitable prime number,
>     like 500009, for this purpose.
>     For Intel platforms:
>        $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count> \
>          -o <perf_file> -- <loadtest>
>     For AMD platforms:
>        The supported system are: Zen3 with BRS, or Zen4 with amd_lbr_v2
>        # To see if Zen3 support LBR:
>        $ cat proc/cpuinfo | grep " brs"
>        # To see if Zen4 support LBR:
>        $ cat proc/cpuinfo | grep amd_lbr_v2
>        # If the result is yes, then collect the profile using:
>        $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a \
>          -N -b -c <count> -o <perf_file> -- <loadtest>
>
> 4) (Optional) Download the raw perf file to the host machine.
>
> 5) Generate Propeller profile:
>     $ create_llvm_prof --binary=<vmlinux> --profile=<perf_file> \
>       --format=propeller --propeller_output_module_name \
>       --out=<propeller_profile_prefix>_cc_profile.txt \
>       --propeller_symorder=<propeller_profile_prefix>_ld_profile.txt
>
>     “create_llvm_prof” is the profile conversion tool, and a prebuilt
>     binary for linux can be found on
>     https://github.com/google/autofdo/releases/tag/v0.30.1 (can also build
>     from source).
>
>     "<propeller_profile_prefix>" can be something like
>     "/home/user/dir/any_string".
>
>     This command generates a pair of Propeller profiles:
>     "<propeller_profile_prefix>_cc_profile.txt" and
>     "<propeller_profile_prefix>_ld_profile.txt".
>
> 6) Rebuild the kernel using the AutoFDO and Propeller profile files.
>        CONFIG_AUTOFDO_CLANG=y
>        CONFIG_PROPELLER_CLANG=y
>     and
>        $ make LLVM=1 CLANG_AUTOFDO_PROFILE=<autofdo_profile> \
>          CLANG_PROPELLER_PROFILE_PREFIX=<propeller_profile_prefix>
>
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>
> Signed-off-by: Rong Xu <xur@google.com>
> Suggested-by: Sriraman Tallam <tmsriram@google.com>
> Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Stephane Eranian <eranian@google.com>
> Tested-by: Yonghong Song <yonghong.song@linux.dev>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---
>   Documentation/dev-tools/index.rst     |   1 +
>   Documentation/dev-tools/propeller.rst | 162 ++++++++++++++++++++++++++
>   MAINTAINERS                           |   7 ++
>   Makefile                              |   1 +
>   arch/Kconfig                          |  19 +++
>   arch/x86/Kconfig                      |   1 +
>   arch/x86/kernel/vmlinux.lds.S         |   4 +
>   include/asm-generic/vmlinux.lds.h     |   6 +-
>   scripts/Makefile.lib                  |  10 ++
>   scripts/Makefile.propeller            |  28 +++++
>   tools/objtool/check.c                 |   1 +
>   11 files changed, 237 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/dev-tools/propeller.rst
>   create mode 100644 scripts/Makefile.propeller
>
> diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
> index 6945644f7008a..3c0ac08b27091 100644
> --- a/Documentation/dev-tools/index.rst
> +++ b/Documentation/dev-tools/index.rst
> @@ -35,6 +35,7 @@ Documentation/dev-tools/testing-overview.rst
>      checkuapi
>      gpio-sloppy-logic-analyzer
>      autofdo
> +   propeller
>   
>   
>   .. only::  subproject and html
> diff --git a/Documentation/dev-tools/propeller.rst b/Documentation/dev-tools/propeller.rst
> new file mode 100644
> index 0000000000000..92195958e3dbc
> --- /dev/null
> +++ b/Documentation/dev-tools/propeller.rst
> @@ -0,0 +1,162 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================
> +Using Propeller with the Linux kernel
> +=====================================
> +
> +This enables Propeller build support for the kernel when using Clang
> +compiler. Propeller is a profile-guided optimization (PGO) method used
> +to optimize binary executables. Like AutoFDO, it utilizes hardware
> +sampling to gather information about the frequency of execution of
> +different code paths within a binary. Unlike AutoFDO, this information
> +is then used right before linking phase to optimize (among others)
> +block layout within and across functions.
> +
> +A few important notes about adopting Propeller optimization:
> +
> +#. Although it can be used as a standalone optimization step, it is
> +   strongly recommended to apply Propeller on top of AutoFDO,
> +   AutoFDO+ThinLTO or Instrument FDO. The rest of this document
> +   assumes this paradigm.
> +
> +#. Propeller uses another round of profiling on top of
> +   AutoFDO/AutoFDO+ThinLTO/iFDO. The whole build process involves
> +   "build-afdo - train-afdo - build-propeller - train-propeller -
> +   build-optimized".
> +
> +#. Propeller requires LLVM 19 release or later for Clang/Clang++
> +   and the linker(ld.lld).
> +
> +#. In addition to LLVM toolchain, Propeller requires a profiling
> +   conversion tool: https://github.com/google/autofdo with a release
> +   after v0.30.1: https://github.com/google/autofdo/releases/tag/v0.30.1.
> +
> +The Propeller optimization process involves the following steps:
> +
> +#. Initial building: Build the AutoFDO or AutoFDO+ThinLTO binary as
> +   you would normally do, but with a set of compile-time / link-time
> +   flags, so that a special metadata section is created within the
> +   kernel binary. The special section is only intend to be used by the
> +   profiling tool, it is not part of the runtime image, nor does it
> +   change kernel run time text sections.
> +
> +#. Profiling: The above kernel is then run with a representative
> +   workload to gather execution frequency data. This data is collected
> +   using hardware sampling, via perf. Propeller is most effective on
> +   platforms supporting advanced PMU features like LBR on Intel
> +   machines. This step is the same as profiling the kernel for AutoFDO
> +   (the exact perf parameters can be different).
> +
> +#. Propeller profile generation: Perf output file is converted to a
> +   pair of Propeller profiles via an offline tool.
> +
> +#. Optimized build: Build the AutoFDO or AutoFDO+ThinLTO optimized
> +   binary as you would normally do, but with a compile-time /
> +   link-time flag to pick up the Propeller compile time and link time
> +   profiles. This build step uses 3 profiles - the AutoFDO profile,
> +   the Propeller compile-time profile and the Propeller link-time
> +   profile.
> +
> +#. Deployment: The optimized kernel binary is deployed and used
> +   in production environments, providing improved performance
> +   and reduced latency.
> +
> +Preparation
> +===========
> +
> +Configure the kernel with::
> +
> +   CONFIG_AUTOFDO_CLANG=y
> +   CONFIG_PROPELLER_CLANG=y
> +
> +Customization
> +=============
> +
> +The default CONFIG_PROPELLER_CLANG setting covers kernel space objects
> +for Propeller builds. One can, however, enable or disable Propeller build
> +for individual files and directories by adding a line similar to the
> +following to the respective kernel Makefile:
> +
> +- For enabling a single file (e.g. foo.o)::
> +
> +   PROPELLER_PROFILE_foo.o := y
> +
> +- For enabling all files in one directory::
> +
> +   PROPELLER_PROFILE := y
> +
> +- For disabling one file::
> +
> +   PROPELLER_PROFILE_foo.o := n
> +
> +- For disabling all files in one directory::
> +
> +   PROPELLER__PROFILE := n
> +
> +
> +Workflow
> +========
> +
> +Here is an example workflow for building an AutoFDO+Propeller kernel:
> +
> +1) Assuming an AutoFDO profile is already collected following
> +   instructions in the AutoFDO document, build the kernel on the host
> +   machine, with AutoFDO and Propeller build configs ::
> +
> +      CONFIG_AUTOFDO_CLANG=y
> +      CONFIG_PROPELLER_CLANG=y
> +
> +   and ::
> +
> +      $ make LLVM=1 CLANG_AUTOFDO_PROFILE=<autofdo-profile-name>
> +
> +2) Install the kernel on the test machine.
> +
> +3) Run the load tests. The '-c' option in perf specifies the sample
> +   event period. We suggest using a suitable prime number, like 500009,
> +   for this purpose.
> +
> +   - For Intel platforms::
> +
> +      $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count> -o <perf_file> -- <loadtest>
> +
> +   - For AMD platforms::
> +
> +      $ perf record --pfm-event RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a -N -b -c <count> -o <perf_file> -- <loadtest>
> +
> +   Note you can repeat the above steps to collect multiple <perf_file>s.
> +
> +4) (Optional) Download the raw perf file(s) to the host machine.
> +
> +5) Use the create_llvm_prof tool (https://github.com/google/autofdo) to
> +   generate Propeller profile. ::
> +
> +      $ create_llvm_prof --binary=<vmlinux> --profile=<perf_file>
> +                         --format=propeller --propeller_output_module_name
> +                         --out=<propeller_profile_prefix>_cc_profile.txt
> +                         --propeller_symorder=<propeller_profile_prefix>_ld_profile.txt

Prevously I am using perf-6.8.5-0.hs1.hsx.el9.x86_64 and it works fine.
Now in my system, the perf is upgraded to 6.12.gadc218676eef

[root@twshared7248.15.atn5 ~]# perf --version
perf version 6.12.gadc218676eef

and create_llvm_prof does not work any more.

The command to collect sampling data:

# perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c 500009 -- stress --cpu 36 --io 36 --vm 36 --vm-bytes 128M --timeout 300s
stress: info: [536354] dispatching hogs: 36 cpu, 36 io, 36 vm, 0 hdd
stress: info: [536354] successful run completed in 300s
[ perf record: Woken up 2210 times to write data ]
[ perf record: Captured and wrote 562.529 MB perf.data (701971 samples) ]
# uname -r
6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39

The kernel is a 6.11 lto kernel.

I then run the following command:
$ cat ../run.sh
# perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c 500009 \
#       -- stress --cpu 36 --io 36 --vm 36 --vm-bytes 128M --timeout 300s
# good: perf-6.8.5-0.hs1.hsx.el9.x86_64

# <propeller_profile_prefix>: /tmp/propeller
./create_llvm_prof --binary=vmlinux-6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39 \
          --profile=perf.data \
          --format=propeller --propeller_output_module_name \
          --out=/tmp/propeller_cc_profile.txt \
          --propeller_symorder=/tmp/propeller_ld_profile.txt

$ ./run.sh
WARNING: Logging before InitGoogleLogging() is written to STDERR
I20241212 13:12:18.401772 463318 llvm_propeller_binary_content.cc:376] 'vmlinux-6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39' is PIE: 0
I20241212 13:12:18.403692 463318 llvm_propeller_binary_content.cc:380] 'vmlinux-6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39' is relocatable: 0
I20241212 13:12:18.404873 463318 llvm_propeller_binary_content.cc:388] Build Id found in 'vmlinux-6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39': eaacd5a14abc48cf832b3ad0fa6c64635ab569a8
I20241212 13:12:18.521499 463318 llvm_propeller_binary_content.cc:376] 'vmlinux-6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39' is PIE: 0
I20241212 13:12:18.521530 463318 llvm_propeller_binary_content.cc:380] 'vmlinux-6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39' is relocatable: 0
I20241212 13:12:18.521553 463318 llvm_propeller_binary_content.cc:388] Build Id found in 'vmlinux-6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39': eaacd5a14abc48cf832b3ad0fa6c64635ab569a8
I20241212 13:12:18.521611 463318 llvm_propeller_perf_lbr_aggregator.cc:51] Parsing [1/1] perf.data ...
[ERROR:/home/runner/work/autofdo/autofdo/third_party/perf_data_converter/src/quipper/perf_reader.cc:1386] Event size 132 after uint64_t alignment of the filename length is greater than event size 128 reported by perf for the buildid event of type 0
W20241212 13:12:18.521708 463318 llvm_propeller_perf_lbr_aggregator.cc:55] Skipped profile [1/1] perf.data: FAILED_PRECONDITION: Failed to read perf data file: [1/1] perf.data
W20241212 13:12:18.521718 463318 llvm_propeller_perf_lbr_aggregator.cc:67] Too few branch records in perf data.
E20241212 13:12:18.554437 463318 create_llvm_prof.cc:238] FAILED_PRECONDITION: No perf file is parsed, cannot proceed.


Could you help take a look why perf 12 does not work with create_llvm_prof?
The create_llvm_prof is downloaded from https://github.com/google/autofdo/releases/tag/v0.30.1.

> +
> +   "<propeller_profile_prefix>" can be something like "/home/user/dir/any_string".
> +
> +   This command generates a pair of Propeller profiles:
> +   "<propeller_profile_prefix>_cc_profile.txt" and
> +   "<propeller_profile_prefix>_ld_profile.txt".
> +
> +   If there are more than 1 perf_file collected in the previous step,
> +   you can create a temp list file "<perf_file_list>" with each line
> +   containing one perf file name and run::
> +
> +      $ create_llvm_prof --binary=<vmlinux> --profile=@<perf_file_list>
> +                         --format=propeller --propeller_output_module_name
> +                         --out=<propeller_profile_prefix>_cc_profile.txt
> +                         --propeller_symorder=<propeller_profile_prefix>_ld_profile.txt
> +
> +6) Rebuild the kernel using the AutoFDO and Propeller
> +   profiles. ::
> +
> +      CONFIG_AUTOFDO_CLANG=y
> +      CONFIG_PROPELLER_CLANG=y
> +
> +   and ::
> +
> +      $ make LLVM=1 CLANG_AUTOFDO_PROFILE=<profile_file> CLANG_PROPELLER_PROFILE_PREFIX=<propeller_profile_prefix>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6ea49433747a..42e3af0791e15 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18449,6 +18449,13 @@ S:	Maintained
>   F:	include/linux/psi*
>   F:	kernel/sched/psi.c
>
[...]

