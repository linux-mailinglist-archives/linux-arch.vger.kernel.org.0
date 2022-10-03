Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D291C5F3A24
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 01:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiJCX4o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 19:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJCX4m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 19:56:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7F62A26C
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 16:56:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z20so4553810plb.10
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 16:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=hoQ557WVkZrT1sNBizNwrAm6wVbK6IVUq2zWCBklsu4=;
        b=iKqh9CtLIfENAcL4+uYAXnUUztCbdXXo+DqtC5/LmaLMSykAaZvWFE3BN7rRQLyqRe
         Ijm7TAE2YmOXQ6tyA4P5XhYwT5/bTLrWJT3SOR96Nth39XetTXuTvj/ZOGWVgsax5Kpi
         qM8GaXJHTS1xC1soX9dmlYv0FuF3eVJilps5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=hoQ557WVkZrT1sNBizNwrAm6wVbK6IVUq2zWCBklsu4=;
        b=0oubD9oNVqNgdSJNVFr23OUL4nmIwLE8Qi/Zkg7wvzBJUIglhcGg7hLgPk3WcmCJrm
         8a7RTLs8lMtOgYr/MVLjrqZ8CqbJHWhbNjkoXaOEdeRoLh/j6a7ubKQVr2bmvve9Kons
         L/w43l9hEBu7GDLj4OVXot0FDqZtm6bhoGn5f89rJuNNDCbZjAFkvlsh4cs725T0N9Iz
         EmbJHZIlg0Csrngh41+W5rXeAzZ9i/0o3ST9Ap6gULQzFGv79aT8nkpfsLn+lWI8Wl+p
         60um+7+VWT+rBRqC4gEGnWQisW9QXs2H42DXM7l4MaNDcqehxEHJ6zmQbDE7vs1YmrND
         gwJA==
X-Gm-Message-State: ACrzQf0GYyaw80mUjxTN1u7bBBWhIRWZ4ravOEehh42Wo1uTNRNwouzS
        KYHs+Ush1vzFIzcouOLyS0B/qw==
X-Google-Smtp-Source: AMsMyM4Ce+NULILOu7j7hpcBJhucV7vRRMlYOqGlQZD9cYsOeBf3LUHjjF0VUNd/eUpFV2Fe2kMKwg==
X-Received: by 2002:a17:90a:c916:b0:20a:a145:85bd with SMTP id v22-20020a17090ac91600b0020aa14585bdmr7456993pjt.88.1664841399298;
        Mon, 03 Oct 2022 16:56:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b8-20020aa79508000000b00561c6a4c1b0sm90080pfp.176.2022.10.03.16.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 16:56:38 -0700 (PDT)
Date:   Mon, 3 Oct 2022 16:56:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 32/39] selftests/x86: Add shadow stack test
Message-ID: <202210031546.AE77508DA@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-33-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-33-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:29PM -0700, Rick Edgecombe wrote:
> Add a simple selftest for exercising some shadow stack behavior:
>  - map_shadow_stack syscall and pivot
>  - Faulting in shadow stack memory
>  - Handling shadow stack violations
>  - GUP of shadow stack memory
>  - mprotect() of shadow stack memory
>  - Userfaultfd on shadow stack memory
> 
> Since this test exercises a recently added syscall manually, it needs
> to find the automatically created __NR_foo defines. Per the selftest
> documentation, KHDR_INCLUDES can be used to help the selftest Makefile's
> find the headers from the kernel source. This way the new selftest can
> be built inside the kernel source tree without installing the headers
> to the system. So also add KHDR_INCLUDES as described in the selftest
> docs, to facilitate this.
> 
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Yay tests! Thank you thank you! :)

> @@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
>  			test_FCMOV test_FCOMI test_FISTTP \
>  			vdso_restorer
>  TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
> -			corrupt_xstate_header amx
> +			corrupt_xstate_header amx test_shadow_stack

At present, there is still a map_shadow_stack syscall on 32-bit, so it
should be tested (that it correctly does nothing with the expected error
results), if it is kept. :P

> [...]
> +#if (__GNUC__ < 8) || (__GNUC__ == 8 && __GNUC_MINOR__ < 5)
> +int main(int argc, char *argv[])
> +{
> +	printf("[SKIP]\tCompiler does not support CET.\n");
> +	return 0;
> +}

I realize other x86 selftests doesn't use the standard kselftest test
harness, but if an entirely new test is being written, like here, it
makes sense to use that instead. It would avoid bugs like the above,
where a SKIP is seen as a success, not a skip (i.e. wrong exit code).
See tools/testing/selftests/kselftest_harness.h

Note that each TEST is run as a separate process.

The skip here would be rewritten as:

...
#include "../kselftest_harness.h"

#if (__GNUC__ < 8) || (__GNUC__ == 8 && __GNUC_MINOR__ < 5)
TEST(compiler_support)
{
	SKIP(return, "Compiler does not support CET.");
}
#else
...rest of tests...
#endif

TEST_HARNESS_MAIN


I'll give some other examples of replacements below...

> +#else
> +void write_shstk(unsigned long *addr, unsigned long val)
> +{
> +	asm volatile("wrssq %[val], (%[addr])\n"
> +		     : "+m" (addr)
> +		     : [addr] "r" (addr), [val] "r" (val));
> +}
> +
> +static inline unsigned long __attribute__((always_inline)) get_ssp(void)
> +{
> +	unsigned long ret = 0;
> +
> +	asm volatile("xor %0, %0; rdsspq %0" : "=r" (ret));
> +	return ret;
> +}
> +
> +/*
> + * For use in inline enablement of shadow stack.
> + *
> + * The program can't return from the point where shadow stack get's enabled
> + * because there will be no address on the shadow stack. So it can't use
> + * syscall() for enablement, since it is a function.

Hmm, this will be a problem for glibc too?

> + *
> + * Based on code from nolibc.h. Keep a copy here because this can't pull in all
> + * of nolibc.h.
> + */
> +#define ARCH_PRCTL(arg1, arg2)					\
> +({								\
> +	long _ret;						\
> +	register long _num  asm("eax") = __NR_arch_prctl;	\
> +	register long _arg1 asm("rdi") = (long)(arg1);		\
> +	register long _arg2 asm("rsi") = (long)(arg2);		\
> +								\
> +	asm volatile (						\
> +		"syscall\n"					\
> +		: "=a"(_ret)					\
> +		: "r"(_arg1), "r"(_arg2),			\
> +		  "0"(_num)					\
> +		: "rcx", "r11", "memory", "cc"			\
> +	);							\
> +	_ret;							\
> +})
> +
> +void *create_shstk(void *addr)
> +{
> +	return (void *)syscall(__NR_map_shadow_stack, addr, SS_SIZE, SHADOW_STACK_SET_TOKEN);
> +}

Hmm, I'd suggest adding some wider exercising of the syscall itself.
(This only ever tests SS_SIZE and SHADOW_STACK_SET_TOKEN). I'd expect to
see testing of error conditions too:

TEST(map_shadow_stack_bad_args)
{
	int ret;

	ret = ARCH_PRCTL(ARCH_CET_ENABLE, CET_SHSTK);
	ASSERT_EQ(0, ret) {
		TH_LOG("Could not enable SHSTK");
	}

	ret = syscall(__NR_map_shadow_stack, addr, SS_SIZE, 0);
	EXPECT_EQ(-1, ret);
	EXPECT_EQ(errno, EINVAL);

	ret = syscall(__NR_map_shadow_stack, addr, SS_SIZE, ~(SHADOW_STACK_SET_TOKEN));
	EXPECT_EQ(-1, ret);
	EXPECT_EQ(errno, EINVAL);

	ret = syscall(__NR_map_shadow_stack, addr, ULONG_MAX, SHADOW_STACK_SET_TOKEN);
	EXPECT_EQ(-1, ret);
	EXPECT_EQ(errno, ENOMEM);

	ret = syscall(__NR_map_shadow_stack, addr, 0, SHADOW_STACK_SET_TOKEN);
	EXPECT_EQ(-1, ret);
	EXPECT_EQ(errno, EINVAL);

	...
}

Although the last example there will probably segv, so that could be
extracted to a separate test:

TEST_SIGNAL(map_shadow_stack_tiny, SIGSEGV)
{
	int ret;

	ret = ARCH_PRCTL(ARCH_CET_ENABLE, CET_SHSTK);
	ASSERT_EQ(0, ret) {
		TH_LOG("Could not enable SHSTK");
	}

	ret = syscall(__NR_map_shadow_stack, addr, 0, SHADOW_STACK_SET_TOKEN);
	EXPECT_EQ(0, ret) {
		TH_LOG("Wasn't expecting to survive the syscall");
	}
}

Helpers are easier to plumb as expression statement macros, so:

#define create_shstk(addr)	({				\
	void *__addr;						\
	__addr = (void *)syscall(__NR_map_shadow_stack, addr,	\
				 SS_SIZE, SHADOW_STACK_SET_TOKEN); \
	ASSERT_NE(MMAP_FAILED, __addr) { \
		TH_LOG("Error creating shadow stack: %d", errno); \
	} \
	__addr;	\
})

And I expect the enable will need to be in each test, so:

#define enable_shstk		do {	\
	int __ret;			\
					\
	__ret = ARCH_PRCTL(ARCH_CET_ENABLE, CET_SHSTK);	\
	ASSERT_EQ(0, __ret) { \
		TH_LOG("Could not enable SHSTK"); \
} while (0)

> +void *create_normal_mem(void *addr)
> +{
> +	return mmap(addr, SS_SIZE, PROT_READ | PROT_WRITE,
> +		    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +}
> +
> +void free_shstk(void *shstk)
> +{
> +	munmap(shstk, SS_SIZE);
> +}
> +
> +int reset_shstk(void *shstk)
> +{
> +	return madvise(shstk, SS_SIZE, MADV_DONTNEED);
> +}
> +
> +void try_shstk(unsigned long new_ssp)
> +{
> +	unsigned long ssp;
> +
> +	printf("[INFO]\tnew_ssp = %lx, *new_ssp = %lx\n",
> +		new_ssp, *((unsigned long *)new_ssp));
> +
> +	ssp = get_ssp();
> +	printf("[INFO]\tchanging ssp from %lx to %lx\n", ssp, new_ssp);
> +
> +	asm volatile("rstorssp (%0)\n":: "r" (new_ssp));
> +	asm volatile("saveprevssp");
> +	printf("[INFO]\tssp is now %lx\n", get_ssp());
> +
> +	/* Switch back to original shadow stack */
> +	ssp -= 8;
> +	asm volatile("rstorssp (%0)\n":: "r" (ssp));
> +	asm volatile("saveprevssp");
> +}
> +
> +int test_shstk_pivot(void)
> +{
> +	void *shstk = create_shstk(0);
> +
> +	if (shstk == MAP_FAILED) {
> +		printf("[FAIL]\tError creating shadow stack: %d\n", errno);
> +		return 1;
> +	}
> +	try_shstk((unsigned long)shstk + SS_SIZE - 8);
> +	free_shstk(shstk);
> +
> +	printf("[OK]\tShadow stack pivot\n");
> +	return 0;
> +}

e.g., the above could be written as this, using the previous
create_shstk macro:

TEST(shstk_pivot)
{
	unsigned long ssp, new_ssp;
	void *shstk = create_shstk(0);

	new_ssp = (unsigned long)shstk + SS_SIZE - 8;
	TH_LOG("new_ssp = %lx, *new_ssp = %lx",
		new_ssp, *((unsigned long *)new_ssp);

	ssp = get_ssp();
	TH_LOG("changing ssp from %lx to %lx", ssp, new_ssp);
	asm volatile("rstorssp (%0)\n":: "r" (new_ssp));
	asm volatile("saveprevssp");
	TH_LOG("ssp is now %lx", get_ssp());
	ssp -= 8;
	asm volatile("rstorssp (%0)\n":: "r" (ssp));
	asm volatile("saveprevssp");

	free_shstk(shstk);
}


> +
> +int test_shstk_faults(void)
> +{
> +	unsigned long *shstk = create_shstk(0);
> +
> +	/* Read shadow stack, test if it's zero to not get read optimized out */
> +	if (*shstk != 0)
> +		goto err;
> +
> +	/* Wrss memory that was already read. */
> +	write_shstk(shstk, 1);
> +	if (*shstk != 1)
> +		goto err;
> +
> +	/* Page out memory, so we can wrss it again. */
> +	if (reset_shstk((void *)shstk))
> +		goto err;
> +
> +	write_shstk(shstk, 1);
> +	if (*shstk != 1)
> +		goto err;
> +
> +	printf("[OK]\tShadow stack faults\n");
> +	return 0;
> +
> +err:
> +	return 1;
> +}
> +
> +unsigned long saved_ssp;
> +unsigned long saved_ssp_val;
> +volatile bool segv_triggered;
> +
> +void __attribute__((noinline)) violate_ss(void)
> +{
> +	saved_ssp = get_ssp();
> +	saved_ssp_val = *(unsigned long *)saved_ssp;
> +
> +	/* Corrupt shadow stack */
> +	printf("[INFO]\tCorrupting shadow stack\n");
> +	write_shstk((void *)saved_ssp, 0);
> +}
> +
> +void segv_handler(int signum, siginfo_t *si, void *uc)
> +{
> +	printf("[INFO]\tGenerated shadow stack violation successfully\n");
> +
> +	segv_triggered = true;
> +
> +	/* Fix shadow stack */
> +	write_shstk((void *)saved_ssp, saved_ssp_val);
> +}

To call TH_LOG() or EXPECT(), etc from a signal handler, you'll need to
store a global and use it local with the name _metadata:

struct __test_metadata *global_test_metadata;

And I'd expect a test for SEGV_CPERR (add in below example).

void segv_handler(int signum, siginfo_t *si, void *uc)
{
	struct __test_metadata *_metadata = global_test_metadata;

	TH_LOG("enerated shadow stack violation successfully");

	EXPECT_EQ(si.si_code, SEGV_CPERR);
	segv_triggered = true;

	/* Fix shadow stack */
	write_shstk((void *)saved_ssp, saved_ssp_val);
}

> +
> +int test_shstk_violation(void)
> +{
> +	struct sigaction sa;
> +
> +	sa.sa_sigaction = segv_handler;
> +	if (sigaction(SIGSEGV, &sa, NULL))
> +		return 1;
> +	sa.sa_flags = SA_SIGINFO;
> +
> +	segv_triggered = false;
> +
> +	/* Make sure segv_triggered is set before violate_ss() */
> +	asm volatile("" : : : "memory");
> +
> +	violate_ss();
> +
> +	signal(SIGSEGV, SIG_DFL);
> +
> +	printf("[OK]\tShadow stack violation test\n");
> +
> +	return !segv_triggered;
> +}
> +

becomes:

TEST(shstk_violation)
{
	struct sigaction sa = {
		.sa_sigaction = segv_handler;
		.sa_flags = SA_SIGINFO;
	};

	global_test_metadata = _metadata;
	ASSERT_EQ(sigaction(SIGSEGV, &sa, NULL), 0);

	segv_triggered = false;

	/* Make sure segv_triggered is set before violate_ss() */
	asm volatile("" : : : "memory");
	violate_ss();
	signal(SIGSEGV, SIG_DFL);
	EXPECT_EQ(segv_trigger, 1) {
		TH_LOG("Segfault did not happen");
	}
}

Without the SEGV_CPERR test, the entire thing could just be:

TEST_SIGNAL(shstk_violation, SIGSEGV)
{
	enable_shstk();
	violate_ss();
}


> +/* Gup test state */
> +#define MAGIC_VAL 0x12345678
> +bool is_shstk_access;
> +void *shstk_ptr;
> +int fd;
> +
> +void reset_test_shstk(void *addr)
> +{
> +	if (shstk_ptr != NULL)
> +		free_shstk(shstk_ptr);
> +	shstk_ptr = create_shstk(addr);
> +}
> +
> +void test_access_fix_handler(int signum, siginfo_t *si, void *uc)
> +{
> +	printf("[INFO]\tViolation from %s\n", is_shstk_access ? "shstk access" : "normal write");
> +
> +	segv_triggered = true;
> +
> +	/* Fix shadow stack */
> +	if (is_shstk_access) {
> +		reset_test_shstk(shstk_ptr);
> +		return;
> +	}
> +
> +	free_shstk(shstk_ptr);
> +	create_normal_mem(shstk_ptr);
> +}
> +
> +bool test_shstk_access(void *ptr)
> +{
> +	is_shstk_access = true;
> +	segv_triggered = false;
> +	write_shstk(ptr, MAGIC_VAL);
> +
> +	asm volatile("" : : : "memory");
> +
> +	return segv_triggered;
> +}
> +
> +bool test_write_access(void *ptr)
> +{
> +	is_shstk_access = false;
> +	segv_triggered = false;
> +	*(unsigned long *)ptr = MAGIC_VAL;
> +
> +	asm volatile("" : : : "memory");
> +
> +	return segv_triggered;
> +}
> +
> +bool gup_write(void *ptr)
> +{
> +	unsigned long val;
> +
> +	lseek(fd, (unsigned long)ptr, SEEK_SET);
> +	if (write(fd, &val, sizeof(val)) < 0)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +bool gup_read(void *ptr)
> +{
> +	unsigned long val;
> +
> +	lseek(fd, (unsigned long)ptr, SEEK_SET);
> +	if (read(fd, &val, sizeof(val)) < 0)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +int test_gup(void)
> +{
> +	struct sigaction sa;
> +	int status;
> +	pid_t pid;
> +
> +	sa.sa_sigaction = test_access_fix_handler;
> +	if (sigaction(SIGSEGV, &sa, NULL))
> +		return 1;
> +	sa.sa_flags = SA_SIGINFO;
> +
> +	segv_triggered = false;
> +
> +	fd = open("/proc/self/mem", O_RDWR);
> +	if (fd == -1)
> +		return 1;
> +
> +	reset_test_shstk(0);
> +	if (gup_read(shstk_ptr))
> +		return 1;
> +	if (test_shstk_access(shstk_ptr))
> +		return 1;
> +	printf("[INFO]\tGup read -> shstk access success\n");
> +
> +	reset_test_shstk(0);
> +	if (gup_write(shstk_ptr))
> +		return 1;
> +	if (test_shstk_access(shstk_ptr))
> +		return 1;
> +	printf("[INFO]\tGup write -> shstk access success\n");

For multiple thing with the same setup, you can use a fixture:

FIXTURE(GUP) {
	int fd;
	void *shstk_ptr;
};

FIXTURE_SETUP(GUP)
{
	... sigaction ...

	self->fd = open("/proc/self/mem", O_RDWR);
	ASSERT_GE(fd, 0);
	self->shstk_ptr = create_shstk(0);
	ASSERT_NE(self->shstk_ptr, NULL);
}

/* Don't need to clean up fd nor sigaction since process will die */

TEST_F(GUP, read)
{
	gup_read ...
	test_shstk_access ...
}

TEST_F(GUP, write)
...


Anyway, I won't cry if this doesn't get swapped to kselftest_harness,
but it would be much nicer. Writing tests for that is way way easier.

-- 
Kees Cook
