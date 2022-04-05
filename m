Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F184F462B
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 01:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbiDEPEP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 11:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392207AbiDENtk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 09:49:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A1071A043;
        Tue,  5 Apr 2022 05:51:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07A13D6E;
        Tue,  5 Apr 2022 05:51:42 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.8.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DFE03F5A1;
        Tue,  5 Apr 2022 05:51:39 -0700 (PDT)
Date:   Tue, 5 Apr 2022 13:51:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, gcc@gcc.gnu.org,
        catalin.marinas@arm.com, will@kernel.org, marcan@marcan.st,
        maz@kernel.org, szabolcs.nagy@arm.com, f.fainelli@gmail.com,
        opendmb@gmail.com, Andrew Pinski <pinskia@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        andrew.cooper3@citrix.com, Jeremy Linton <jeremy.linton@arm.com>
Subject: GCC 12 miscompilation of volatile asm (was: Re: [PATCH] arm64/io:
 Remind compiler that there is a memory side effect)
Message-ID: <Ykw7UnlTnx63z/Ca@FVFF77S0Q05N>
References: <20220401164406.61583-1-jeremy.linton@arm.com>
 <Ykc0xrLv391/jdJj@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykc0xrLv391/jdJj@FVFF77S0Q05N>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

[adding kernel folk who work on asm stuff]

As a heads-up, GCC 12 (not yet released) appears to erroneously optimize away
calls to functions with volatile asm. Szabolcs has raised an issue on the GCC
bugzilla:  

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105160

... which is a P1 release blocker, and is currently being investigated.

Jemery originally reported this as an issue with {readl,writel}_relaxed(), but
the underlying problem doesn't have anything to do with those specifically.

I'm dumping a bunch of info here largely for posterity / archival, and to find
out who (from the kernel side) is willing and able to test proposed compiler
fixes, once those are available.

I'm happy to do so for aarch64; Peter, I assume you'd be happy to look at the
x86 side?

This is a generic issue, and 

I wrote test cases for aarch64 and x86_64. Those are inline later in this mail,
and currently you can see them on compiler explorer:

  aarch64: https://godbolt.org/z/vMczqjYvs

  x86_64: https://godbolt.org/z/cveff9hq5



My aarch64 test case is:

| #define sysreg_read(regname)		\
| ({					\
| 	unsigned long __sr_val;		\
| 	asm volatile(			\
| 	"mrs %0, " #regname "\n"	\
| 	: "=r" (__sr_val));		\
| 					\
| 	__sr_val;			\
| })
| 
| #define sysreg_write(regname, __sw_val)	\
| do {					\
| 	asm volatile(			\
| 	"msr " #regname ", %0\n"	\
| 	:				\
| 	: "r" (__sw_val));		\
| } while (0)
| 
| #define isb()				\
| do {					\
| 	asm volatile(			\
| 	"isb"				\
| 	:				\
| 	:				\
| 	: "memory");			\
| } while (0)
| 
| static unsigned long sctlr_read(void)
| {
| 	return sysreg_read(sctlr_el1);
| }
| 
| static void sctlr_write(unsigned long val)
| {
| 	sysreg_write(sctlr_el1, val);
| }
| 
| static void sctlr_rmw(void)
| {
| 	unsigned long val;
| 
| 	val = sctlr_read();
| 	val |= 1UL << 7;
| 	sctlr_write(val);
| }
| 
| void sctlr_read_multiple(void)
| {
| 	sctlr_read();
| 	sctlr_read();
| 	sctlr_read();
| 	sctlr_read();
| }
| 
| void sctlr_write_multiple(void)
| {
| 	sctlr_write(0);
| 	sctlr_write(0);
| 	sctlr_write(0);
| 	sctlr_write(0);
| 	sctlr_write(0);
| }
| 
| void sctlr_rmw_multiple(void)
| {
| 	sctlr_rmw();
| 	sctlr_rmw();
| 	sctlr_rmw();
| 	sctlr_rmw();
| }
| 
| void function(void)
| {
| 	sctlr_read_multiple();
| 	sctlr_write_multiple();
| 	sctlr_rmw_multiple();
| 
| 	isb();
| }

Per compiler explorer (https://godbolt.org/z/vMczqjYvs) GCC trunk currently
compiles this as:

| sctlr_rmw:
|         mrs x0, sctlr_el1
|         orr     x0, x0, 128
|         msr sctlr_el1, x0
|         ret
| sctlr_read_multiple:
|         mrs x0, sctlr_el1
|         mrs x0, sctlr_el1
|         mrs x0, sctlr_el1
|         mrs x0, sctlr_el1
|         ret
| sctlr_write_multiple:
|         mov     x0, 0
|         msr sctlr_el1, x0
|         msr sctlr_el1, x0
|         msr sctlr_el1, x0
|         msr sctlr_el1, x0
|         msr sctlr_el1, x0
|         ret
| sctlr_rmw_multiple:
|         ret
| function:
|         isb
|         ret

Whereas GCC 11.2 compiles this as:

| sctlr_rmw:
|         mrs x0, sctlr_el1
|         orr     x0, x0, 128
|         msr sctlr_el1, x0
|         ret
| sctlr_read_multiple:
|         mrs x0, sctlr_el1
|         mrs x0, sctlr_el1
|         mrs x0, sctlr_el1
|         mrs x0, sctlr_el1
|         ret
| sctlr_write_multiple:
|         mov     x0, 0
|         msr sctlr_el1, x0
|         msr sctlr_el1, x0
|         msr sctlr_el1, x0
|         msr sctlr_el1, x0
|         msr sctlr_el1, x0
|         ret
| sctlr_rmw_multiple:
|         stp     x29, x30, [sp, -16]!
|         mov     x29, sp
|         bl      sctlr_rmw
|         bl      sctlr_rmw
|         bl      sctlr_rmw
|         bl      sctlr_rmw
|         ldp     x29, x30, [sp], 16
|         ret
| function:
|         stp     x29, x30, [sp, -16]!
|         mov     x29, sp
|         bl      sctlr_read_multiple
|         bl      sctlr_write_multiple
|         bl      sctlr_rmw_multiple
|         isb
|         ldp     x29, x30, [sp], 16
|         ret



My x86_64 test case is:

| unsigned long rdmsr(unsigned long reg)
| {
|     unsigned int lo, hi;
| 
|     asm volatile(
|     "rdmsr"
|     : "=d" (hi), "=a" (lo)
|     : "c" (reg)
|     );
| 
|     return ((unsigned long)hi << 32) | lo;
| }
| 
| void wrmsr(unsigned long reg, unsigned long val)
| {
|     unsigned int lo = val;
|     unsigned int hi = val >> 32;
| 
|     asm volatile(
|     "wrmsr"
|     :
|     : "d" (hi), "a" (lo), "c" (reg)
|     );
| }
| 
| void msr_rmw_set_bits(unsigned long reg, unsigned long bits)
| {
|     unsigned long val;
| 
|     val = rdmsr(reg);
|     val |= bits;
|     wrmsr(reg, val);
| }
| 
| void func_with_msr_side_effects(unsigned long reg)
| {
|     msr_rmw_set_bits(reg, 1UL << 0);
|     msr_rmw_set_bits(reg, 1UL << 1);
|     msr_rmw_set_bits(reg, 1UL << 2);
|     msr_rmw_set_bits(reg, 1UL << 3);
| }

Per compiler explorer (https://godbolt.org/z/cveff9hq5) GCC trunk currently
compiles this as:

| msr_rmw_set_bits:
|         mov     rcx, rdi
|         rdmsr
|         sal     rdx, 32
|         mov     eax, eax
|         or      rax, rsi
|         or      rax, rdx
|         mov     rdx, rax
|         shr     rdx, 32
|         wrmsr
|         ret
| func_with_msr_side_effects:
|         ret

While GCC 11.2 compiles that as:

| msr_rmw_set_bits:
|         mov     rcx, rdi
|         rdmsr
|         sal     rdx, 32
|         mov     eax, eax
|         or      rax, rsi
|         or      rax, rdx
|         mov     rdx, rax
|         shr     rdx, 32
|         wrmsr
|         ret
| func_with_msr_side_effects:
|         push    rbp
|         push    rbx
|         mov     rbx, rdi
|         mov     rbp, rsi
|         call    msr_rmw_set_bits
|         mov     rsi, rbp
|         mov     rdi, rbx
|         call    msr_rmw_set_bits
|         mov     rsi, rbp
|         mov     rdi, rbx
|         call    msr_rmw_set_bits
|         mov     rsi, rbp
|         mov     rdi, rbx
|         call    msr_rmw_set_bits
|         pop     rbx
|         pop     rbp
|         ret

Thanks,
Mark.
