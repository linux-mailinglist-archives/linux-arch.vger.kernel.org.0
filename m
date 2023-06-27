Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37F973FB5D
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 13:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjF0Lub (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 07:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0Lu3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 07:50:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F1DF4;
        Tue, 27 Jun 2023 04:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZFk3rI0pDzWmxm4Gf7JRHIIfrzOCQHrAsHdKlDXLYc8=; b=eIHd5RuS/3J2bUC2zRrjKrzmhz
        iHAclDZ3gNGhsrHkOk5RiBrrq0Y1U3NLI1c+8+asrcWUgiJb9ZMSDkHkdpgn4X7QOC0FneSXf03DP
        7bkXIpF5QOakANkbIgnZzs5XZT2c9iSMKofc5q1RiWBfx+xruoNPfy9oSjehTwU0OxMBMXIQkuZQk
        F5alDcuVEc4nzWTAdX9wW+LX34RTxFhIlcnObwzCACchlmuXky8rHkTUZNq2Kt8TAJ1WuF/uZsA1o
        GaIsu6wQM8b12xY8Bf4UzwZbHyrf3GRloAjpwdQ0JGF4xIE0L8aef6XpWrqBRkFOczGQJM/T6tPNS
        /v8KV0gQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qE7Cu-002g8o-IV; Tue, 27 Jun 2023 11:50:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59B4B300095;
        Tue, 27 Jun 2023 13:50:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3692E24A42F47; Tue, 27 Jun 2023 13:50:02 +0200 (CEST)
Date:   Tue, 27 Jun 2023 13:50:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com, Tianyu Lan <tiala@microsoft.com>,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com
Subject: Re: [EXTERNAL] Re: [PATCH 5/9] x86/hyperv: Use vmmcall to implement
 Hyper-V hypercall in sev-snp enlightened guest
Message-ID: <20230627115002.GW83892@hirez.programming.kicks-ass.net>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-6-ltykernel@gmail.com>
 <20230608132127.GK998233@hirez.programming.kicks-ass.net>
 <8b93aa93-903f-3a69-77f9-0c6b694d826b@gmail.com>
 <d06bb33e-047f-c849-de6a-246bc361c7af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d06bb33e-047f-c849-de6a-246bc361c7af@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 27, 2023 at 06:57:28PM +0800, Tianyu Lan wrote:

> > "There is no x86 SEV SNP feature(X86_FEATURE_SEV_SNP) flag

I'm sure we can arrange such a feature if we need it, this isn't rocket
science. Boris?

> > support so far and hardware provides MSR_AMD64_SEV register
> > to check SEV-SNP capability with MSR_AMD64_SEV_ENABLED bit
> > ALTERNATIVE can't work without SEV-SNP x86 feature flag."
> > There is no cpuid leaf bit to check AMD SEV-SNP feature.
> > 
> > After some Hyper-V doesn't provides SEV and SEV-ES guest before and so
> > may reuse X86_FEATURE_SEV and X86_FEATURE_SEV_ES flag as alternative
> > feature check for Hyper-V SEV-SNP guest. Will refresh patch.
> > 
> 
> Hi Peter:
>      I tried using alternative for "vmmcall" and CALL_NOSPEC in a single
> Inline assembly. The output is different in the SEV-SNP mode. When SEV-
> SNP is enabled, thunk_target is not required. While it's necessary in
> the non SEV-SNP mode. Do you have any idea how to differentiate outputs in
> the single Inline assembly which just like alternative works for
> assembler template.

This seems to work; it's a bit magical for having a nested ALTERNATIVE
but the output seems correct (the outer alternative comes last in
.altinstructions and thus has precedence). Sure the [thunk_target] input
goes unsed in one of the alteratives, but who cares.


static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
{
	u64 input_address = input ? virt_to_phys(input) : 0;
	u64 output_address = output ? virt_to_phys(output) : 0;
	u64 hv_status;

#ifdef CONFIG_X86_64
	if (!hv_hypercall_pg)
		return U64_MAX;

#if 0
	if (hv_isolation_type_en_snp()) {
		__asm__ __volatile__("mov %4, %%r8\n"
				     "vmmcall"
				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
				       "+c" (control), "+d" (input_address)
				     :  "r" (output_address)
				     : "cc", "memory", "r8", "r9", "r10", "r11");
	} else {
		__asm__ __volatile__("mov %4, %%r8\n"
				     CALL_NOSPEC
				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
				       "+c" (control), "+d" (input_address)
				     :  "r" (output_address),
					THUNK_TARGET(hv_hypercall_pg)
				     : "cc", "memory", "r8", "r9", "r10", "r11");
	}
#endif

	asm volatile("mov %[output], %%r8\n"
		     ALTERNATIVE(CALL_NOSPEC, "vmmcall", X86_FEATURE_SEV_ES)
		     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
		       "+c" (control), "+d" (input_address)
		     : [output] "r" (output_address),
		       THUNK_TARGET(hv_hypercall_pg)
		     : "cc", "memory", "r8", "r9", "r10", "r11");

#else
	u32 input_address_hi = upper_32_bits(input_address);
	u32 input_address_lo = lower_32_bits(input_address);
	u32 output_address_hi = upper_32_bits(output_address);
	u32 output_address_lo = lower_32_bits(output_address);

	if (!hv_hypercall_pg)
		return U64_MAX;

	__asm__ __volatile__(CALL_NOSPEC
			     : "=A" (hv_status),
			       "+c" (input_address_lo), ASM_CALL_CONSTRAINT
			     : "A" (control),
			       "b" (input_address_hi),
			       "D"(output_address_hi), "S"(output_address_lo),
			       THUNK_TARGET(hv_hypercall_pg)
			     : "cc", "memory");
#endif /* !x86_64 */
	return hv_status;
}

(in actual fact x86_64-defconfig + kvm_guest.config + HYPERV)

$ ./scripts/objdump-func defconfig-build/arch/x86/hyperv/mmu.o hv_do_hypercall
0000 0000000000000cd0 <hv_do_hypercall.constprop.0>:
0000      cd0:  48 89 f9                mov    %rdi,%rcx
0003      cd3:  31 d2                   xor    %edx,%edx
0005      cd5:  48 85 f6                test   %rsi,%rsi
0008      cd8:  74 1b                   je     cf5 <hv_do_hypercall.constprop.0+0x25>
000a      cda:  b8 00 00 00 80          mov    $0x80000000,%eax
000f      cdf:  48 01 c6                add    %rax,%rsi
0012      ce2:  72 38                   jb     d1c <hv_do_hypercall.constprop.0+0x4c>
0014      ce4:  48 c7 c2 00 00 00 80    mov    $0xffffffff80000000,%rdx
001b      ceb:  48 2b 15 00 00 00 00    sub    0x0(%rip),%rdx        # cf2 <hv_do_hypercall.constprop.0+0x22>   cee: R_X86_64_PC32      page_offset_base-0x4
0022      cf2:  48 01 f2                add    %rsi,%rdx
0025      cf5:  48 8b 35 00 00 00 00    mov    0x0(%rip),%rsi        # cfc <hv_do_hypercall.constprop.0+0x2c>   cf8: R_X86_64_PC32      hv_hypercall_pg-0x4
002c      cfc:  48 85 f6                test   %rsi,%rsi
002f      cff:  74 0f                   je     d10 <hv_do_hypercall.constprop.0+0x40>
0031      d01:  31 c0                   xor    %eax,%eax
0033      d03:  49 89 c0                mov    %rax,%r8
0036      d06:  ff d6                   call   *%rsi
0038      d08:  90                      nop
0039      d09:  90                      nop
003a      d0a:  90                      nop
003b      d0b:  e9 00 00 00 00          jmp    d10 <hv_do_hypercall.constprop.0+0x40>   d0c: R_X86_64_PLT32     __x86_return_thunk-0x4
0040      d10:  48 c7 c0 ff ff ff ff    mov    $0xffffffffffffffff,%rax
0047      d17:  e9 00 00 00 00          jmp    d1c <hv_do_hypercall.constprop.0+0x4c>   d18: R_X86_64_PLT32     __x86_return_thunk-0x4
004c      d1c:  48 8b 15 00 00 00 00    mov    0x0(%rip),%rdx        # d23 <hv_do_hypercall.constprop.0+0x53>   d1f: R_X86_64_PC32      phys_base-0x4
0053      d23:  eb cd                   jmp    cf2 <hv_do_hypercall.constprop.0+0x22>

$ objdump -wdr -j .altinstr_replacement defconfig-build/arch/x86/hyperv/mmu.o
0000000000000000 <.altinstr_replacement>:
0:   f3 48 0f b8 c7          popcnt %rdi,%rax
5:   e8 00 00 00 00          call   a <.altinstr_replacement+0xa>    6: R_X86_64_PLT32       __x86_indirect_thunk_rsi-0x4
a:   0f ae e8                lfence
d:   ff d6                   call   *%rsi
f:   0f 01 d9                vmmcall

$ ./readelf-section.sh defconfig-build/arch/x86/hyperv/mmu.o altinstructions
Relocation section '.rela.altinstructions' at offset 0x5420 contains 8 entries:
Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000000  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e3
0000000000000004  0000000700000002 R_X86_64_PC32          0000000000000000 .altinstr_replacement + 0
000000000000000e  0000000200000002 R_X86_64_PC32          0000000000000000 .text + d06
0000000000000012  0000000700000002 R_X86_64_PC32          0000000000000000 .altinstr_replacement + 5
000000000000001c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + d06
0000000000000020  0000000700000002 R_X86_64_PC32          0000000000000000 .altinstr_replacement + a
000000000000002a  0000000200000002 R_X86_64_PC32          0000000000000000 .text + d06
000000000000002e  0000000700000002 R_X86_64_PC32          0000000000000000 .altinstr_replacement + f

