Return-Path: <linux-arch+bounces-3336-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410DC892495
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 20:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEF21C21CD8
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 19:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EBF13A271;
	Fri, 29 Mar 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Wa7YX088"
X-Original-To: linux-arch@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170FD131E59;
	Fri, 29 Mar 2024 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741808; cv=none; b=VBGZ7f902JYVnWFy3C3FqcWpRqpDvIUv55TnZiBZXA/S8c4RVY9cWztiFIOxAfwkB5Oda2n01zJDXeM31lvRsdFr9LMX+N8QMWGo+dXZ+iDWt4JNafAAIW5SqTqPqPYckwlO8qpXpZgw8gSWvdv80RLEk5N+Et7etYe+KnGrD5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741808; c=relaxed/simple;
	bh=yYbZhqg6Kn2qjH/2vqPgNHZZG9gDIqfnwF9btJXe0Sc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sQdIw9MLGYdQnewr0mFGTw0YzwLe+a8QXKeDpuVSP081HySNdnyvcjQ9/VqJGIsQMUwp3VeiobSk4NzUdMvUWytF+1QpEz9eQIQ2B/4z7S493e3FlPfKvVb252KNPF8i5owx2U0pkHtgTEcW07RmbcPpnH6kKqFhou0NsCHQNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Wa7YX088; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711741803;
	bh=yYbZhqg6Kn2qjH/2vqPgNHZZG9gDIqfnwF9btJXe0Sc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Wa7YX088KbkDi+I3Lt+BNMagPIUovcs4Kdec0zlxyKldZWCS1OHkf4bbgYK6ufxKK
	 I3Hlpr5kuB/8CAg3/b9dveIk+9j9oIf/YM5QIyVXxurgQwNWsyWWPphdGQrl/r+PZk
	 C/vMgVeAvDvdHydWg41lPZTkxTvt58kixFhwBQaG7+thEmyfFLF3no/vP6TcunxqmZ
	 N6nDRV9hS1oT7h6QObaJ/51XkUYfE6w3Cm04mwe1OcZgbfiTF82aZyFBvT7/RGvbaK
	 7Isr7TELxJV8fiwhx/eTNolfOW8BjFYp/6SOAvi1DSRzcjD7i02GmO/WaSU2nXdPCz
	 g4mFwQZyZY66w==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C327A3780C22;
	Fri, 29 Mar 2024 19:49:38 +0000 (UTC)
Message-ID: <4b38393a-f69d-4a77-a896-b6cd42c7edcf@collabora.com>
Date: Sat, 30 Mar 2024 00:50:09 +0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, corbet@lwn.net,
 tech-j-ext@lists.risc-v.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
 akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
 shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
 jerry.shih@sifive.com, hankuan.chen@sifive.com, greentime.hu@sifive.com,
 evan@rivosinc.com, xiao.w.wang@intel.com, charlie@rivosinc.com,
 apatel@ventanamicro.com, mchitale@ventanamicro.com,
 dbarboza@ventanamicro.com, sameo@rivosinc.com, shikemeng@huaweicloud.com,
 willy@infradead.org, vincent.chen@sifive.com, guoren@kernel.org,
 samitolvanen@google.com, songshuaishuai@tinylab.org, gerg@kernel.org,
 heiko@sntech.de, bhe@redhat.com, jeeheng.sia@starfivetech.com,
 cyy@cyyself.name, maskray@google.com, ancientmodern4@gmail.com,
 mathis.salmen@matsal.de, cuiyunhui@bytedance.com, bgray@linux.ibm.com,
 mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org, david@redhat.com,
 catalin.marinas@arm.com, revest@chromium.org, josh@joshtriplett.org,
 shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
 jhubbard@nvidia.com
Subject: Re: [PATCH v2 27/27] kselftest/riscv: kselftest for user mode cfi
To: Deepak Gupta <debug@rivosinc.com>, paul.walmsley@sifive.com,
 rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
 kito.cheng@sifive.com, keescook@chromium.org, ajones@ventanamicro.com,
 conor.dooley@microchip.com, cleger@rivosinc.com, atishp@atishpatra.org,
 alex@ghiti.fr, bjorn@rivosinc.com, alexghiti@rivosinc.com,
 samuel.holland@sifive.com, palmer@sifive.com, conor@kernel.org,
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240329044459.3990638-1-debug@rivosinc.com>
 <20240329044459.3990638-28-debug@rivosinc.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240329044459.3990638-28-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/24 9:44 AM, Deepak Gupta wrote:
> Adds kselftest for RISC-V control flow integrity implementation for user
> mode. There is not a lot going on in kernel for enabling landing pad for
> user mode. Thus kselftest simply enables landing pad for the binary and
> a signal handler is registered for SIGSEGV. Any control flow violation are
> reported as SIGSEGV with si_code = SEGV_CPERR. Test will fail on recieving
> any SEGV_CPERR. Shadow stack part has more changes in kernel and thus there
> are separate tests for that
> 	- enable and disable
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
>  tools/testing/selftests/riscv/cfi/Makefile    |  10 +
>  .../testing/selftests/riscv/cfi/cfi_rv_test.h |  85 ++++
>  .../selftests/riscv/cfi/riscv_cfi_test.c      |  91 +++++
>  .../testing/selftests/riscv/cfi/shadowstack.c | 376 ++++++++++++++++++
>  .../testing/selftests/riscv/cfi/shadowstack.h |  39 ++
Please add generated binaries in the .gitignore files.

>  6 files changed, 602 insertions(+), 1 deletion(-)
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
> diff --git a/tools/testing/selftests/riscv/cfi/Makefile b/tools/testing/selftests/riscv/cfi/Makefile
> new file mode 100644
> index 000000000000..77f12157fa29
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
> +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/cfi/cfi_rv_test.h b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
> new file mode 100644
> index 000000000000..27267a2e1008
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
> @@ -0,0 +1,85 @@
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
> +#define BAD_POINTER	(NULL)
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
> index 000000000000..c116ae4bb358
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
> @@ -0,0 +1,91 @@
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
> +#define SEGV_CPERR 10 /* control protection fault */
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
> +	/* null pointer deref */
> +	if (si->si_addr == BAD_POINTER)
> +		exit(CHILD_EXIT_CODE_NULL_PTR_DEREF);
> +
> +	/* shadow stack write case */
> +	exit(CHILD_EXIT_CODE_SSWRITE);
> +}
> +
> +int lpad_enable(void)
> +{
> +	int ret = 0;
> +
> +	ret = my_syscall5(__NR_prctl, PR_SET_INDIR_BR_LP_STATUS, PR_INDIR_BR_LP_ENABLE, 0, 0, 0);
> +
> +	return ret;
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
> +	unsigned long lpad_status = 0;
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
> +	ret = lpad_enable();
> +
> +	if (ret)
> +		ksft_exit_skip("Enabling landing pad failed with %d\n", ret);
> +
> +	if (!register_signal_handler())
> +		ksft_exit_skip("registering signal handler for SIGSEGV failed\n");
> +
> +	ksft_print_msg("landing pad enabled for binary\n");
> +	ksft_print_msg("starting risc-v shadow stack tests\n");
> +	execute_shadow_stack_tests();
> +
> +	ksft_finished();
> +}
> +
> +#pragma GCC pop_options
> diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.c b/tools/testing/selftests/riscv/cfi/shadowstack.c
> new file mode 100644
> index 000000000000..126654801bed
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/shadowstack.c
> @@ -0,0 +1,376 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "../../kselftest.h"
> +#include <sys/wait.h>
> +#include <signal.h>
> +#include <fcntl.h>
> +#include <unistd.h>
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
> +	unsigned long ssp = 0, swaped_val = 0;
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
> +bool enable_disable_check(unsigned long test_num, void *ctx)
> +{
> +	int ret = 0;
> +
> +	if (!my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, PR_SHADOW_STACK_ENABLE, 0, 0, 0)) {
> +		printf("Shadow stack was enabled\n");
> +		shadow_stack_call_tests(&foo, true);
> +
> +		ret = my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0, 0, 0, 0);
> +		if (ret)
> +			ksft_test_result_fail("shadow stack disable failed\n");
> +	} else {
> +		ksft_test_result_fail("shadow stack enable failed\n");
> +		ret = -EINVAL;
> +	}
> +
> +	return ret ? false : true;
> +}
> +
> +/* forks a thread, and ensure shadow stacks fork out */
> +bool shadow_stack_fork_test(unsigned long test_num, void *ctx)
> +{
> +	int pid = 0, child_status = 0, parent_pid = 0;
> +
> +	printf("exercising shadow stack fork test\n");
> +
> +	if (my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, PR_SHADOW_STACK_ENABLE, 0, 0, 0)) {
> +		printf("shadow stack enable prctl failed\n");
> +		return false;
> +	}
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
> +	/* disable shadow stack again */
> +	if (my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0, 0, 0, 0)) {
> +		printf("shadow stack disable prctl failed\n");
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
> +	if (signal(SIGUSR1, sigusr1_handler) == SIG_ERR) {
> +		printf("registerting sigusr1 handler failed\n");
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
> +	int pid = 0, child_status = 0;
> +	unsigned long ssp = 0;
> +
> +	if (my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, PR_SHADOW_STACK_ENABLE, 0, 0, 0)) {
> +		printf("shadow stack enable prctl failed\n");
> +		return false;
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
> +		/* this should be caught by signal handler and do an exit */
> +		if (!sigusr1_signal_test()) {
> +			printf("sigusr1_signal_test failed\n");
> +			exit(-1);
> +		}
> +
> +		while (!break_loop)
> +			sleep(1);
> +
> +		exit(11);
> +		/* child shouldn't go beyond here */
> +	}
> +	/* send SIGUSR1 to child */
> +	kill(pid, SIGUSR1);
> +	wait(&child_status);
> +
> +out:
> +	if (my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0, 0, 0, 0)) {
> +		printf("shadow stack disable prctl failed\n");
> +		return false;
> +	}
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
> index 000000000000..92cb0752238d
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/cfi/shadowstack.h
> @@ -0,0 +1,39 @@
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
> +bool enable_disable_check(unsigned long test_num, void *ctx);
> +bool shadow_stack_fork_test(unsigned long test_num, void *ctx);
> +bool shadow_stack_map_test(unsigned long test_num, void *ctx);
> +bool shadow_stack_protection_test(unsigned long test_num, void *ctx);
> +bool shadow_stack_gup_tests(unsigned long test_num, void *ctx);
> +bool shadow_stack_signal_test(unsigned long test_num, void *ctx);
> +
> +static struct shadow_stack_tests shstk_tests[] = {
> +	{ "enable disable\n", enable_disable_check },
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

-- 
BR,
Muhammad Usama Anjum

