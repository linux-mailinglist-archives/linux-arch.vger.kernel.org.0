Return-Path: <linux-arch+bounces-4286-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DECD8C14A8
	for <lists+linux-arch@lfdr.de>; Thu,  9 May 2024 20:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077031F223BE
	for <lists+linux-arch@lfdr.de>; Thu,  9 May 2024 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C1A770E9;
	Thu,  9 May 2024 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HKu838Hd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B1E77106
	for <linux-arch@vger.kernel.org>; Thu,  9 May 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278885; cv=none; b=GN0YFnX8ppjFJx8gJmajo2ZreuhodWqFUmpdab/Oc1Ta7Vv5y+nhK1KwaHXd0gLCNrd7jfmb1idfwKucfpLBVsXa+aX+7cgSCO2vxTzvwBeo4S/O+mf++6eSZXR2dsoasKc9uxQQw8YkD4KTtKzoBHjbQjieZmUDGA73pQane/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278885; c=relaxed/simple;
	bh=tItt9fCcmxH+KT3autSbwgt+5jdGUNymcKrdHGH/5tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFe18ndsFPUQzQNo+yDkxKPZtemlr6I+BOjBQ5krNSRo0SovDJde9DjknNstR8h/FMavJfmA7jCho+MirYP1deOQv+b7Y/SSZ6s6u+pjnxagTNVuBbqLrqX2HElSmk/nZC9keMuOSyw74aTvAeuMocCFyZyHRqdC7/nME22dggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HKu838Hd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ec4b2400b6so10716115ad.3
        for <linux-arch@vger.kernel.org>; Thu, 09 May 2024 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715278882; x=1715883682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BGxRf0AVV4aVFrMR88o5/plgrY2cWWLG2HESkcqxnvA=;
        b=HKu838HdCcSbsJfn+FZy5DYCaodx2GT4+IdSKW475mMwA4MoD8N7WCb9x5IK1LRJdc
         DlWlScqLDpQ6/NWdut7sCJVnZG99fCpe3dAn7Jk7sUTh5DOsLTiAQDJu6rJ0bwzrbJXh
         fRYNJcSG9elcYbd5c7OdmLqGzXSHrR0iFLRshM3f11QTgPVL308Oh3tyGeSTIgnGnWUd
         iU0AiPiNVOZXkxuG40g1kE5xhj/+oZct2KgSLeMwGj9kuRlW/3l77hkeHd7mvH9yPnyz
         BvQ45vYrTlqu9G6KSMS2RWZginbv/aao4ny4OdwU//kmFheXdEn7ja/K3VjWBnLIRzZK
         S8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715278882; x=1715883682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGxRf0AVV4aVFrMR88o5/plgrY2cWWLG2HESkcqxnvA=;
        b=CE1eo7csbkNCNITQmZb0pQS2eOAyW4M61WDUoIc2tBUKZrLqa5u3Bu69lIwlmiBEn5
         FjFNbtUbwszOfwur4Z9xW69Kn0nbkcfs3WsNyNht3yNczBF6lfJcSBNNmz9zAvPJJHM8
         sxw+SLiJFhYds9rLsIBZ37Igja+hdmpahEqxjuyAByd2lV6WaMB9Ea8IrPDlbRFH/hDh
         AGcEKXew0WKYaFJcCv5Bl100Q0pc0LkwyH8xuhbaf5e96NzPGOWRwUc49oyvhXfbLeuf
         6w5FL3YorQT8ZLp2Pc5DLS5V7MRSgkUIUGSU+8j+b4aBB1teT9tj0Ne+b6kSUfnfd9xs
         FpDw==
X-Forwarded-Encrypted: i=1; AJvYcCXI4YNBcv41NfarBNMHzpVL33g5CnknRkXJj3Q6sRgVmzB1YM8yBpl6V3jv6R8+P8d66ONFFE5anjCfzIwNSt7ngDXac4i+pIxaCQ==
X-Gm-Message-State: AOJu0YyHbIkaATiuRBl9xiPoSLJ2a1tVqD/7fhwkPknlT4sf7iapk6a2
	42IPkL5atc+9FNJ5Ylhee8Wv2Vvbk+yg1yOGKQrt6dadUey4HBUW8g2P6kJoWsY=
X-Google-Smtp-Source: AGHT+IFPTV52f7s+oghlxMGBbkyvJyMbBVZakVxArirHHS+Pd5dJGIxrmiYl9FPzQMF3JKqso2Jwiw==
X-Received: by 2002:a17:902:ecc6:b0:1ea:b3ba:79f5 with SMTP id d9443c01a7336-1ef44059a56mr4690605ad.60.1715278882273;
        Thu, 09 May 2024 11:21:22 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:3668:6b5b:d71d:2683])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c15d516sm17257175ad.274.2024.05.09.11.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 11:21:21 -0700 (PDT)
Date: Thu, 9 May 2024 11:21:15 -0700
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
Message-ID: <Zj0UGweLoRD1U9Po@ghost>
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

There is an assumption here that the libc supports setting
INDIR_BR_LP_STATUS but does not support the standard prctl interface
defined in <sys/prctl.h>. my_syscall5() is defined to fill in gaps in
the libc, so this test case should also set the status manually rather
than relying on the libc.

I don't think it's necessary to define my_syscall5() since every libc
should have a prctl() definition. However, these CFI prctls are very new
and glibc does not yet support (correct me if I am wrong) it so these
prctls should be enabled by the test cases.

- Charlie

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

