Return-Path: <linux-arch+bounces-4293-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DA48C1BF9
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 03:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8171F21D03
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC3613B5AF;
	Fri, 10 May 2024 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="No4Zltzk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC1E328A0
	for <linux-arch@vger.kernel.org>; Fri, 10 May 2024 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304040; cv=none; b=twrQk1aJPZZHHUzamgWxVfAngPl8HjXoRAvCBbPLemHQNDAxOvgcfYV0i8e/s7DPY+ZYJ2kT0Slly7As4uSVGz/6e8pxch+nbD5Va9Z1Aan0WEMKs8JUMwnPP4flCC3uo0VSubiIeMoSNxYIHXU5TBrgnGVofDtPFJPk25j/nAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304040; c=relaxed/simple;
	bh=2nMM7sLs0QzijyAp1RbckGSp73oxg9I46GLy66K124E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPmtsfW/s3xWFWURyu3hr4RAImmPxyMcqLD+FL2Y5TMCTrIYae/X0e5F6/bQrIWm236FK2e5u0vdt5pwaFjlSEHB4K2GzVE58i59dMB043Vo658j5dkw5VhPjxYfvM/g1tdwrnqFW2xt0QigfI1tlR0YKJrTPyJZiq7jrePZGpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=No4Zltzk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f447260f9dso1340862b3a.0
        for <linux-arch@vger.kernel.org>; Thu, 09 May 2024 18:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715304037; x=1715908837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xYKjow0ZEXE4z99kLg6hCwSLUOoK7JRYXv7gY7/gcOU=;
        b=No4ZltzkS2JQEaU67MmMjAcKJyee5BlEBRS8dPOMp+PrC76BqZNIiMWnd9FQ/1L8yB
         PvHI/994gnxygzmVWn8c/lDa48fhoBSKE22zVNBc/dDX2MasSackHfDWodK6U0uUNh12
         3P2ktQpwzZKpGYixZIBHwgnNjPYjPaFMLTEIaqbQIi5dIEa6kiXKbNXJ3KSGg8UgthHz
         M8A7pQkuVkQca6GOndYwJovR3rAa0il5FMn6tj57cVrFY3g1nws8WffrU2LGkrvnstpq
         f+IWW99RLAblpU7WYNZ589p2xdyQvvCxGfiR5mzwFp5T8riR0PAu1zMjFTtda1RBW/ku
         54/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715304037; x=1715908837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYKjow0ZEXE4z99kLg6hCwSLUOoK7JRYXv7gY7/gcOU=;
        b=F+cxPYzUtmyC9CbFzQx2vQi9IuB/eP6TnWuIX7xWtZMbqRLVuGQ12fBXbCDFxX0j+S
         HFpb2NEy7H6GX8ozvaZapMXZtcl8Mr+gMsqQMZAXTu/43XpYkVp48IHNnpFAyQ3rauGa
         D3Q7yRr8zwqk3rArgK1Oxj6o36NtJvbLkbymXuzJeDJI6snNYBA8vvwdKJ1+c7ETG3zf
         fpqxjJQcMxnbB9Sdt4WKs2ql1lbBrnygHmY2iqRETZfqLhpfYkD5WubP9lAwh3ggtmE0
         Ls7iED70sySoxHzlONQ2Gv/SjvEOF2CAWus7n4Ke2dVBlvOlcfHXoNzH2DWvLZoRyvHx
         uyMg==
X-Forwarded-Encrypted: i=1; AJvYcCXBJL7/7ii14Y0052GWdJ2hKzyzQsBzC8oYCi0gGKIqyWtfBEqsNKm7IdL5K2PldC2I6htrb1mWxoEdtgZ5PrW4gMekH1h4D40I8Q==
X-Gm-Message-State: AOJu0Yy3bfohVgofp1htNZFfG728e5rcGvbma6jnA5l1gCnz123BbiGf
	cqCQiV7sDHycfQIxSbAfrl5Mk6R7hc1ca7HzGbIKAiaL93HYd8ZD8vMHK9uWfiM=
X-Google-Smtp-Source: AGHT+IFjtK0F8YMZkBlhd6iv1JvpVJN4/vsUmGSU4W+yawsfxSZ1EvHgYyS7vILVhy+mCP6ABY+HnA==
X-Received: by 2002:a05:6a20:3d84:b0:1a9:84f6:dcb6 with SMTP id adf61e73a8af0-1afde1d91dfmr1696810637.57.1715304037443;
        Thu, 09 May 2024 18:20:37 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:3668:6b5b:d71d:2683])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67105661esm2132895a91.1.2024.05.09.18.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 18:20:36 -0700 (PDT)
Date: Thu, 9 May 2024 18:20:33 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	apatel@ventanamicro.com, mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com, sameo@rivosinc.com,
	shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 29/29] kselftest/riscv: kselftest for user mode cfi
Message-ID: <Zj12YazL2SwajYR8@ghost>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-30-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403234054.2020347-30-debug@rivosinc.com>

On Wed, Apr 03, 2024 at 04:35:17PM -0700, Deepak Gupta wrote:
> Adds kselftest for RISC-V control flow integrity implementation for user
> mode. There is not a lot going on in kernel for enabling landing pad for
> user mode. cfi selftest are intended to be compiled with zicfilp and
> zicfiss enabled compiler. Thus kselftest simply checks if landing pad and
> shadow stack for the binary and process are enabled or not. selftest then
> register a signal handler for SIGSEGV. Any control flow violation are
> reported as SIGSEGV with si_code = SEGV_CPERR. Test will fail on recieving
> any SEGV_CPERR. Shadow stack part has more changes in kernel and thus there
> are separate tests for that
> 	- Exercise `map_shadow_stack` syscall
> 	- `fork` test to make sure COW works for shadow stack pages
> 	- gup tests
> 	  As of today kernel uses FOLL_FORCE when access happens to memory via
> 	  /proc/<pid>/mem. Not breaking that for shadow stack
> 	- signal test. Make sure signal delivery results in token creation on
>       shadow stack and consumes (and verifies) token on sigreturn
>     - shadow stack protection test. attempts to write using regular store
> 	  instruction on shadow stack memory must result in access faults
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  tools/testing/selftests/riscv/Makefile        |   2 +-
>  tools/testing/selftests/riscv/cfi/.gitignore  |   3 +
>  tools/testing/selftests/riscv/cfi/Makefile    |  10 +
>  .../testing/selftests/riscv/cfi/cfi_rv_test.h |  83 ++++
>  .../selftests/riscv/cfi/riscv_cfi_test.c      |  82 ++++
>  .../testing/selftests/riscv/cfi/shadowstack.c | 362 ++++++++++++++++++
>  .../testing/selftests/riscv/cfi/shadowstack.h |  37 ++
>  7 files changed, 578 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/riscv/cfi/.gitignore
>  create mode 100644 tools/testing/selftests/riscv/cfi/Makefile
>  create mode 100644 tools/testing/selftests/riscv/cfi/cfi_rv_test.h
>  create mode 100644 tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
>  create mode 100644 tools/testing/selftests/riscv/cfi/shadowstack.c
>  create mode 100644 tools/testing/selftests/riscv/cfi/shadowstack.h
> 
> diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
> index 4a9ff515a3a0..867e5875b7ce 100644
> --- a/tools/testing/selftests/riscv/Makefile
> +++ b/tools/testing/selftests/riscv/Makefile
> @@ -5,7 +5,7 @@
>  ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>  
>  ifneq (,$(filter $(ARCH),riscv))
> -RISCV_SUBTARGETS ?= hwprobe vector mm
> +RISCV_SUBTARGETS ?= hwprobe vector mm cfi
>  else
>  RISCV_SUBTARGETS :=
>  endif
> diff --git a/tools/testing/selftests/riscv/cfi/.gitignore b/tools/testing/selftests/riscv/cfi/.gitignore
> new file mode 100644
> index 000000000000..ce7623f9da28
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/.gitignore
> @@ -0,0 +1,3 @@
> +cfitests
> +riscv_cfi_test
> +shadowstack
> \ No newline at end of file
> diff --git a/tools/testing/selftests/riscv/cfi/Makefile b/tools/testing/selftests/riscv/cfi/Makefile
> new file mode 100644
> index 000000000000..b65f7ff38a32
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/Makefile
> @@ -0,0 +1,10 @@
> +CFLAGS += -I$(top_srcdir)/tools/include
> +
> +CFLAGS += -march=rv64gc_zicfilp_zicfiss
> +
> +TEST_GEN_PROGS := cfitests
> +
> +include ../../lib.mk
> +
> +$(OUTPUT)/cfitests: riscv_cfi_test.c shadowstack.c
> +	$(CC) -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/cfi/cfi_rv_test.h b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
> new file mode 100644
> index 000000000000..fa1cf7183672
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef SELFTEST_RISCV_CFI_H
> +#define SELFTEST_RISCV_CFI_H
> +#include <stddef.h>
> +#include <sys/types.h>
> +#include "shadowstack.h"
> +
> +#define RISCV_CFI_SELFTEST_COUNT RISCV_SHADOW_STACK_TESTS
> +
> +#define CHILD_EXIT_CODE_SSWRITE		10
> +#define CHILD_EXIT_CODE_SIG_TEST	11
> +
> +#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)		\
> +({															\
> +	register long _num  __asm__ ("a7") = (num);				\
> +	register long _arg1 __asm__ ("a0") = (long)(arg1);		\
> +	register long _arg2 __asm__ ("a1") = (long)(arg2);		\
> +	register long _arg3 __asm__ ("a2") = (long)(arg3);		\
> +	register long _arg4 __asm__ ("a3") = (long)(arg4);		\
> +	register long _arg5 __asm__ ("a4") = (long)(arg5);		\
> +															\
> +	__asm__ volatile (										\
> +		"ecall\n"											\
> +		: "+r"(_arg1)										\
> +		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),	\
> +		  "r"(_num)											\
> +		: "memory", "cc"									\
> +	);														\
> +	_arg1;													\
> +})
> +
> +#define my_syscall3(num, arg1, arg2, arg3)					\
> +({															\
> +	register long _num  __asm__ ("a7") = (num);				\
> +	register long _arg1 __asm__ ("a0") = (long)(arg1);		\
> +	register long _arg2 __asm__ ("a1") = (long)(arg2);		\
> +	register long _arg3 __asm__ ("a2") = (long)(arg3);		\
> +															\
> +	__asm__ volatile (										\
> +		"ecall\n"											\
> +		: "+r"(_arg1)										\
> +		: "r"(_arg2), "r"(_arg3),							\
> +		  "r"(_num)											\
> +		: "memory", "cc"									\
> +	);														\
> +	_arg1;													\
> +})
> +
> +#ifndef __NR_prctl
> +#define __NR_prctl 167
> +#endif
> +
> +#ifndef __NR_map_shadow_stack
> +#define __NR_map_shadow_stack 453
> +#endif
> +
> +#define CSR_SSP 0x011
> +
> +#ifdef __ASSEMBLY__
> +#define __ASM_STR(x)    x
> +#else
> +#define __ASM_STR(x)    #x
> +#endif
> +
> +#define csr_read(csr)									\
> +({														\
> +	register unsigned long __v;							\
> +	__asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)	\
> +						  : "=r" (__v) :				\
> +						  : "memory");					\
> +	__v;												\
> +})
> +
> +#define csr_write(csr, val)								\
> +({														\
> +	unsigned long __v = (unsigned long) (val);			\
> +	__asm__ __volatile__ ("csrw " __ASM_STR(csr) ", %0"	\
> +						  : : "rK" (__v)				\
> +						  : "memory");					\
> +})
> +
> +#endif
> diff --git a/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c b/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
> new file mode 100644
> index 000000000000..f22b3f0f24de
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "../../kselftest.h"
> +#include <signal.h>
> +#include <asm/ucontext.h>
> +#include <linux/prctl.h>
> +#include "cfi_rv_test.h"
> +
> +/* do not optimize cfi related test functions */
> +#pragma GCC push_options
> +#pragma GCC optimize("O0")
> +
> +void sigsegv_handler(int signum, siginfo_t *si, void *uc)
> +{
> +	struct ucontext *ctx = (struct ucontext *) uc;
> +
> +	if (si->si_code == SEGV_CPERR) {
> +		printf("Control flow violation happened somewhere\n");
> +		printf("pc where violation happened %lx\n", ctx->uc_mcontext.gregs[0]);
> +		exit(-1);
> +	}
> +
> +	printf("In sigsegv handler\n");
> +	/* all other cases are expected to be of shadow stack write case */
> +	exit(CHILD_EXIT_CODE_SSWRITE);
> +}
> +
> +bool register_signal_handler(void)
> +{
> +	struct sigaction sa = {};
> +
> +	sa.sa_sigaction = sigsegv_handler;
> +	sa.sa_flags = SA_SIGINFO;
> +	if (sigaction(SIGSEGV, &sa, NULL)) {
> +		printf("registering signal handler for landing pad violation failed\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int ret = 0;
> +	unsigned long lpad_status = 0, ss_status = 0;
> +
> +	ksft_print_header();
> +
> +	ksft_set_plan(RISCV_CFI_SELFTEST_COUNT);
> +
> +	ksft_print_msg("starting risc-v tests\n");
> +
> +	/*
> +	 * Landing pad test. Not a lot of kernel changes to support landing
> +	 * pad for user mode except lighting up a bit in senvcfg via a prctl
> +	 * Enable landing pad through out the execution of test binary
> +	 */
> +	ret = my_syscall5(__NR_prctl, PR_GET_INDIR_BR_LP_STATUS, &lpad_status, 0, 0, 0);
> +	if (ret)
> +		ksft_exit_skip("Get landing pad status failed with %d\n", ret);
> +
> +	if (!(lpad_status & PR_INDIR_BR_LP_ENABLE))
> +		ksft_exit_skip("landing pad is not enabled, should be enabled via glibc\n");
> +
> +	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
> +	if (ret)
> +		ksft_exit_skip("Get shadow stack failed with %d\n", ret);
> +
> +	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
> +		ksft_exit_skip("shadow stack is not enabled, should be enabled via glibc\n");
> +
> +	if (!register_signal_handler())
> +		ksft_exit_skip("registering signal handler for SIGSEGV failed\n");
> +
> +	ksft_print_msg("landing pad and shadow stack are enabled for binary\n");
> +	ksft_print_msg("starting risc-v shadow stack tests\n");
> +	execute_shadow_stack_tests();
> +
> +	ksft_finished();

The test case framework is based off of static variables, so these tests
actually report that nothing passed because the setup is in this file
and the actual test cases are in a different file. This can be remedied
by moving ksft_set_plan(RISCV_CFI_SELFTEST_COUNT) and ksft_finished()
into execute_shadow_stack_tests().

There are two versions of the kselftest framework and the one that this
is using is the low-level version that has the note in the header:

   kselftest.h:	low-level kselftest framework to include from
		selftest programs. When possible, please use
 		kselftest_harness.h instead.

There is not a good enough reason for you to change up this code to use
kselftest_harness.h instead, but just something to think about for any
future test cases you may write.

- Charlie

> +}
> +
> +#pragma GCC pop_options
> diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.c b/tools/testing/selftests/riscv/cfi/shadowstack.c
> new file mode 100644
> index 000000000000..2f65eb970c44
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/shadowstack.c
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "../../kselftest.h"
> +#include <sys/wait.h>
> +#include <signal.h>
> +#include <fcntl.h>
> +#include <asm-generic/unistd.h>
> +#include <sys/mman.h>
> +#include "shadowstack.h"
> +#include "cfi_rv_test.h"
> +
> +/* do not optimize shadow stack related test functions */
> +#pragma GCC push_options
> +#pragma GCC optimize("O0")
> +
> +void zar(void)
> +{
> +	unsigned long ssp = 0;
> +
> +	ssp = csr_read(CSR_SSP);
> +	printf("inside %s and shadow stack ptr is %lx\n", __func__, ssp);
> +}
> +
> +void bar(void)
> +{
> +	printf("inside %s\n", __func__);
> +	zar();
> +}
> +
> +void foo(void)
> +{
> +	printf("inside %s\n", __func__);
> +	bar();
> +}
> +
> +void zar_child(void)
> +{
> +	unsigned long ssp = 0;
> +
> +	ssp = csr_read(CSR_SSP);
> +	printf("inside %s and shadow stack ptr is %lx\n", __func__, ssp);
> +}
> +
> +void bar_child(void)
> +{
> +	printf("inside %s\n", __func__);
> +	zar_child();
> +}
> +
> +void foo_child(void)
> +{
> +	printf("inside %s\n", __func__);
> +	bar_child();
> +}
> +
> +typedef void (call_func_ptr)(void);
> +/*
> + * call couple of functions to test push pop.
> + */
> +int shadow_stack_call_tests(call_func_ptr fn_ptr, bool parent)
> +{
> +	if (parent)
> +		printf("call test for parent\n");
> +	else
> +		printf("call test for child\n");
> +
> +	(fn_ptr)();
> +
> +	return 0;
> +}
> +
> +/* forks a thread, and ensure shadow stacks fork out */
> +bool shadow_stack_fork_test(unsigned long test_num, void *ctx)
> +{
> +	int pid = 0, child_status = 0, parent_pid = 0, ret = 0;
> +	unsigned long ss_status = 0;
> +
> +	printf("exercising shadow stack fork test\n");
> +
> +	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
> +	if (ret) {
> +		printf("shadow stack get status prctl failed with errorcode %d\n", ret);
> +		return false;
> +	}
> +
> +	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
> +		ksft_exit_skip("shadow stack is not enabled, should be enabled via glibc\n");
> +
> +	parent_pid = getpid();
> +	pid = fork();
> +
> +	if (pid) {
> +		printf("Parent pid %d and child pid %d\n", parent_pid, pid);
> +		shadow_stack_call_tests(&foo, true);
> +	} else
> +		shadow_stack_call_tests(&foo_child, false);
> +
> +	if (pid) {
> +		printf("waiting on child to finish\n");
> +		wait(&child_status);
> +	} else {
> +		/* exit child gracefully */
> +		exit(0);
> +	}
> +
> +	if (pid && WIFSIGNALED(child_status)) {
> +		printf("child faulted");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/* exercise `map_shadow_stack`, pivot to it and call some functions to ensure it works */
> +#define SHADOW_STACK_ALLOC_SIZE 4096
> +bool shadow_stack_map_test(unsigned long test_num, void *ctx)
> +{
> +	unsigned long shdw_addr;
> +	int ret = 0;
> +
> +	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
> +
> +	if (((long) shdw_addr) <= 0) {
> +		printf("map_shadow_stack failed with error code %d\n", (int) shdw_addr);
> +		return false;
> +	}
> +
> +	ret = munmap((void *) shdw_addr, SHADOW_STACK_ALLOC_SIZE);
> +
> +	if (ret) {
> +		printf("munmap failed with error code %d\n", ret);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * shadow stack protection tests. map a shadow stack and
> + * validate all memory protections work on it
> + */
> +bool shadow_stack_protection_test(unsigned long test_num, void *ctx)
> +{
> +	unsigned long shdw_addr;
> +	unsigned long *write_addr = NULL;
> +	int ret = 0, pid = 0, child_status = 0;
> +
> +	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
> +
> +	if (((long) shdw_addr) <= 0) {
> +		printf("map_shadow_stack failed with error code %d\n", (int) shdw_addr);
> +		return false;
> +	}
> +
> +	write_addr = (unsigned long *) shdw_addr;
> +	pid = fork();
> +
> +	/* no child was created, return false */
> +	if (pid == -1)
> +		return false;
> +
> +	/*
> +	 * try to perform a store from child on shadow stack memory
> +	 * it should result in SIGSEGV
> +	 */
> +	if (!pid) {
> +		/* below write must lead to SIGSEGV */
> +		*write_addr = 0xdeadbeef;
> +	} else {
> +		wait(&child_status);
> +	}
> +
> +	/* test fail, if 0xdeadbeef present on shadow stack address */
> +	if (*write_addr == 0xdeadbeef) {
> +		printf("write suceeded\n");
> +		return false;
> +	}
> +
> +	/* if child reached here, then fail */
> +	if (!pid) {
> +		printf("child reached unreachable state\n");
> +		return false;
> +	}
> +
> +	/* if child exited via signal handler but not for write on ss */
> +	if (WIFEXITED(child_status) &&
> +		WEXITSTATUS(child_status) != CHILD_EXIT_CODE_SSWRITE) {
> +		printf("child wasn't signaled for write on shadow stack\n");
> +		return false;
> +	}
> +
> +	ret = munmap(write_addr, SHADOW_STACK_ALLOC_SIZE);
> +	if (ret) {
> +		printf("munmap failed with error code %d\n", ret);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +#define SS_MAGIC_WRITE_VAL 0xbeefdead
> +
> +int gup_tests(int mem_fd, unsigned long *shdw_addr)
> +{
> +	unsigned long val = 0;
> +
> +	lseek(mem_fd, (unsigned long)shdw_addr, SEEK_SET);
> +	if (read(mem_fd, &val, sizeof(val)) < 0) {
> +		printf("reading shadow stack mem via gup failed\n");
> +		return 1;
> +	}
> +
> +	val = SS_MAGIC_WRITE_VAL;
> +	lseek(mem_fd, (unsigned long)shdw_addr, SEEK_SET);
> +	if (write(mem_fd, &val, sizeof(val)) < 0) {
> +		printf("writing shadow stack mem via gup failed\n");
> +		return 1;
> +	}
> +
> +	if (*shdw_addr != SS_MAGIC_WRITE_VAL) {
> +		printf("GUP write to shadow stack memory didn't happen\n");
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +bool shadow_stack_gup_tests(unsigned long test_num, void *ctx)
> +{
> +	unsigned long shdw_addr = 0;
> +	unsigned long *write_addr = NULL;
> +	int fd = 0;
> +	bool ret = false;
> +
> +	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
> +
> +	if (((long) shdw_addr) <= 0) {
> +		printf("map_shadow_stack failed with error code %d\n", (int) shdw_addr);
> +		return false;
> +	}
> +
> +	write_addr = (unsigned long *) shdw_addr;
> +
> +	fd = open("/proc/self/mem", O_RDWR);
> +	if (fd == -1)
> +		return false;
> +
> +	if (gup_tests(fd, write_addr)) {
> +		printf("gup tests failed\n");
> +		goto out;
> +	}
> +
> +	ret = true;
> +out:
> +	if (shdw_addr && munmap(write_addr, SHADOW_STACK_ALLOC_SIZE)) {
> +		printf("munmap failed with error code %d\n", ret);
> +		ret = false;
> +	}
> +
> +	return ret;
> +}
> +
> +volatile bool break_loop;
> +
> +void sigusr1_handler(int signo)
> +{
> +	printf("In sigusr1 handler\n");
> +	break_loop = true;
> +}
> +
> +bool sigusr1_signal_test(void)
> +{
> +	struct sigaction sa = {};
> +
> +	sa.sa_handler = sigusr1_handler;
> +	sa.sa_flags = 0;
> +	sigemptyset(&sa.sa_mask);
> +	if (sigaction(SIGUSR1, &sa, NULL)) {
> +		printf("registering signal handler for SIGUSR1 failed\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +/*
> + * shadow stack signal test. shadow stack must be enabled.
> + * register a signal, fork another thread which is waiting
> + * on signal. Send a signal from parent to child, verify
> + * that signal was received by child. If not test fails
> + */
> +bool shadow_stack_signal_test(unsigned long test_num, void *ctx)
> +{
> +	int pid = 0, child_status = 0, ret = 0;
> +	unsigned long ss_status = 0;
> +
> +	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
> +	if (ret) {
> +		printf("shadow stack get status prctl failed with errorcode %d\n", ret);
> +		return false;
> +	}
> +
> +	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
> +		ksft_exit_skip("shadow stack is not enabled, should be enabled via glibc\n");
> +
> +	/* this should be caught by signal handler and do an exit */
> +	if (!sigusr1_signal_test()) {
> +		printf("registering sigusr1 handler failed\n");
> +		exit(-1);
> +	}
> +
> +	pid = fork();
> +
> +	if (pid == -1) {
> +		printf("signal test: fork failed\n");
> +		goto out;
> +	}
> +
> +	if (pid == 0) {
> +		while (!break_loop)
> +			sleep(1);
> +
> +		exit(11);
> +		/* child shouldn't go beyond here */
> +	}
> +
> +	/* send SIGUSR1 to child */
> +	kill(pid, SIGUSR1);
> +	wait(&child_status);
> +
> +out:
> +
> +	return (WIFEXITED(child_status) &&
> +			WEXITSTATUS(child_status) == 11);
> +}
> +
> +int execute_shadow_stack_tests(void)
> +{
> +	int ret = 0;
> +	unsigned long test_count = 0;
> +	unsigned long shstk_status = 0;
> +
> +	printf("Executing RISC-V shadow stack self tests\n");
> +
> +	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &shstk_status, 0, 0, 0);
> +
> +	if (ret != 0)
> +		ksft_exit_skip("Get shadow stack status failed with %d\n", ret);
> +
> +	/*
> +	 * If we are here that means get shadow stack status succeeded and
> +	 * thus shadow stack support is baked in the kernel.
> +	 */
> +	while (test_count < ARRAY_SIZE(shstk_tests)) {
> +		ksft_test_result((*shstk_tests[test_count].t_func)(test_count, NULL),
> +						 shstk_tests[test_count].name);
> +		test_count++;
> +	}
> +
> +	return 0;
> +}
> +
> +#pragma GCC pop_options
> diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.h b/tools/testing/selftests/riscv/cfi/shadowstack.h
> new file mode 100644
> index 000000000000..b43e74136a26
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/shadowstack.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef SELFTEST_SHADOWSTACK_TEST_H
> +#define SELFTEST_SHADOWSTACK_TEST_H
> +#include <stddef.h>
> +#include <linux/prctl.h>
> +
> +/*
> + * a cfi test returns true for success or false for fail
> + * takes a number for test number to index into array and void pointer.
> + */
> +typedef bool (*shstk_test_func)(unsigned long test_num, void *);
> +
> +struct shadow_stack_tests {
> +	char *name;
> +	shstk_test_func t_func;
> +};
> +
> +bool shadow_stack_fork_test(unsigned long test_num, void *ctx);
> +bool shadow_stack_map_test(unsigned long test_num, void *ctx);
> +bool shadow_stack_protection_test(unsigned long test_num, void *ctx);
> +bool shadow_stack_gup_tests(unsigned long test_num, void *ctx);
> +bool shadow_stack_signal_test(unsigned long test_num, void *ctx);
> +
> +static struct shadow_stack_tests shstk_tests[] = {
> +	{ "shstk fork test\n", shadow_stack_fork_test },
> +	{ "map shadow stack syscall\n", shadow_stack_map_test },
> +	{ "shadow stack gup tests\n", shadow_stack_gup_tests },
> +	{ "shadow stack signal tests\n", shadow_stack_signal_test},
> +	{ "memory protections of shadow stack memory\n", shadow_stack_protection_test }
> +};
> +
> +#define RISCV_SHADOW_STACK_TESTS ARRAY_SIZE(shstk_tests)
> +
> +int execute_shadow_stack_tests(void);
> +
> +#endif
> -- 
> 2.43.2
> 

