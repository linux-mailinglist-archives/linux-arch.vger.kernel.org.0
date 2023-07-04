Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA105746BED
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 10:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGDIap (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjGDIag (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 04:30:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A6CF2
        for <linux-arch@vger.kernel.org>; Tue,  4 Jul 2023 01:30:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5704991ea05so58438607b3.1
        for <linux-arch@vger.kernel.org>; Tue, 04 Jul 2023 01:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688459433; x=1691051433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPFPYpJqlVkifeWySsxdrO28y5Ny6mwft6nx5ZGUVhA=;
        b=14EDmER7U5p0mx0dZlvSGrr81vx0YvPVwEF8Gh+/1kQO1+UZJp5K/F+lL9Myx/x9zY
         vQqky1ClisRbs8YYZsldp7K48F4AHDpcvRFkmrCanxn0nYHAdiH69obE/poRWlCqj0S3
         gIjiDU5P5lqw5j1C/hkVynNVKz++87eMq+sLy4J/R1GRKEajNXnBOdVz2049lPGshSxu
         Plc3wwLAX4TBifDwSNOyvfApUkjT85k7e8qgWXHEBAhUpTscsh2hGUe/b7XWHXce6HvG
         34Ur6wKY0ZPaNMh/joOMz71adFz/TgMQVmn6Q0ULqheiTyUL2qEcfppQBE3EID0pNjjr
         bHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688459433; x=1691051433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPFPYpJqlVkifeWySsxdrO28y5Ny6mwft6nx5ZGUVhA=;
        b=N9syIC2Cn8NX1K9nkUzuwbhVrS+xiNVie68Pl+yLf3qMXeFoqT70Vh9Zg7P10ygisO
         A518MnbAFIU5zoNYVatUueWh1pPGfNeAhyOLjLzdhfIaQNFstfi2ud0lo0y7O5nWG2bv
         4P2gZQ/zTSclqG2vedoXWRO8l2gUY5onPl9YolLeHAgPDt3Dfws1/aX432RPxR1nrcYU
         m0b2mnSwei9LUypbrInTpftHy1gWa0XJ3i0uOokDDhuDq0aS4OAr+fKUkhQbWUAu+45H
         It6MKVNJ8UI0UETRjk/lpkS0rjfD0j0TpRxAAPxpZVN74NxDyPupKsk+p/yOkzRbNVNm
         9HLA==
X-Gm-Message-State: ABy/qLb63GfQcPeV5wjmS5K+jaG4w6EkqVhvijI1nD9vkMuO2CgInnXm
        t3F48veFOcVCEAVic3tDzO5KzzJssy66IA==
X-Google-Smtp-Source: APBJJlG/mQtleWpmYTFrXjz5VDtAR3m8iutNTnV65fa5jShxEezd7l/XSMldeUFw12dUkSYPNgkYX2mxR5smOw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:d5c2:0:b0:577:d5b:7ce3 with SMTP id
 x185-20020a0dd5c2000000b005770d5b7ce3mr84586ywd.9.1688459433076; Tue, 04 Jul
 2023 01:30:33 -0700 (PDT)
Date:   Tue,  4 Jul 2023 16:30:22 +0800
In-Reply-To: <20230704083022.692368-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230704083022.692368-1-davidgow@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230704083022.692368-2-davidgow@google.com>
Subject: [PATCH 2/2] arch: um: Use the x86 checksum implementation on 32-bit
From:   David Gow <davidgow@google.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     linux-um@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When UML is compiled under 32-bit x86, it uses its own copy of
checksum_32.S, which is terribly out-of-date and doesn't support
checksumming unaligned data.

This causes the new "checksum" KUnit test to fail:
./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_64BIT=n --cross_compile i686-linux-gnu- checksum
    KTAP version 1
    # Subtest: checksum
    1..3
    # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kunit.c:243
    Expected result == expec, but
        result == 33316 (0x8224)
        expec == 33488 (0x82d0)
    not ok 1 test_csum_fixed_random_inputs
    # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:267
    Expected result == expec, but
        result == 65280 (0xff00)
        expec == 0 (0x0)
    not ok 2 test_csum_all_carry_inputs
    # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:306
    Expected result == expec, but
        result == 65531 (0xfffb)
        expec == 0 (0x0)
    not ok 3 test_csum_no_carry_inputs

Sharing the normal implementation in arch/x86/lib both fixes all of
these issues and means any further fixes only need to be done once.

x86_64 already seems to share the same implementation between UML and
"normal" x86.

Signed-off-by: David Gow <davidgow@google.com>
---

Note that there is a further issue with the pre-pentium-pro codepath in
the shared x86 code, which I'll send a separate fix out for. i686+ works
fine with just this series.

---
 arch/x86/um/Makefile      |   3 +-
 arch/x86/um/checksum_32.S | 214 --------------------------------------
 2 files changed, 2 insertions(+), 215 deletions(-)
 delete mode 100644 arch/x86/um/checksum_32.S

diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index ee89f6bb9242..cb738967a9f5 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -17,11 +17,12 @@ obj-y = bugs_$(BITS).o delay.o fault.o ldt.o \
 
 ifeq ($(CONFIG_X86_32),y)
 
-obj-y += checksum_32.o syscalls_32.o
+obj-y += syscalls_32.o
 obj-$(CONFIG_ELF_CORE) += elfcore.o
 
 subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
 subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o
+subarch-y += ../lib/checksum_32.o
 subarch-y += ../kernel/sys_ia32.o
 
 else
diff --git a/arch/x86/um/checksum_32.S b/arch/x86/um/checksum_32.S
deleted file mode 100644
index aed782ab7721..000000000000
--- a/arch/x86/um/checksum_32.S
+++ /dev/null
@@ -1,214 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * INET		An implementation of the TCP/IP protocol suite for the LINUX
- *		operating system.  INET is implemented using the  BSD Socket
- *		interface as the means of communication with the user level.
- *
- *		IP/TCP/UDP checksumming routines
- *
- * Authors:	Jorge Cwik, <jorge@laser.satlink.net>
- *		Arnt Gulbrandsen, <agulbra@nvg.unit.no>
- *		Tom May, <ftom@netcom.com>
- *              Pentium Pro/II routines:
- *              Alexander Kjeldaas <astor@guardian.no>
- *              Finn Arne Gangstad <finnag@guardian.no>
- *		Lots of code moved from tcp.c and ip.c; see those files
- *		for more names.
- *
- * Changes:     Ingo Molnar, converted csum_partial_copy() to 2.1 exception
- *			     handling.
- *		Andi Kleen,  add zeroing on error
- *                   converted to pure assembler
- */
-
-#include <asm/errno.h>
-#include <asm/asm.h>
-#include <asm/export.h>
-				
-/*
- * computes a partial checksum, e.g. for TCP/UDP fragments
- */
-
-/*	
-unsigned int csum_partial(const unsigned char * buff, int len, unsigned int sum)
- */
-		
-.text
-.align 4
-.globl csum_partial
-		
-#ifndef CONFIG_X86_USE_PPRO_CHECKSUM
-
-	  /*		
-	   * Experiments with Ethernet and SLIP connections show that buff
-	   * is aligned on either a 2-byte or 4-byte boundary.  We get at
-	   * least a twofold speedup on 486 and Pentium if it is 4-byte aligned.
-	   * Fortunately, it is easy to convert 2-byte alignment to 4-byte
-	   * alignment for the unrolled loop.
-	   */		
-csum_partial:
-	pushl %esi
-	pushl %ebx
-	movl 20(%esp),%eax	# Function arg: unsigned int sum
-	movl 16(%esp),%ecx	# Function arg: int len
-	movl 12(%esp),%esi	# Function arg: unsigned char *buff
-	testl $2, %esi		# Check alignment.
-	jz 2f			# Jump if alignment is ok.
-	subl $2, %ecx		# Alignment uses up two bytes.
-	jae 1f			# Jump if we had at least two bytes.
-	addl $2, %ecx		# ecx was < 2.  Deal with it.
-	jmp 4f
-1:	movw (%esi), %bx
-	addl $2, %esi
-	addw %bx, %ax
-	adcl $0, %eax
-2:
-	movl %ecx, %edx
-	shrl $5, %ecx
-	jz 2f
-	testl %esi, %esi
-1:	movl (%esi), %ebx
-	adcl %ebx, %eax
-	movl 4(%esi), %ebx
-	adcl %ebx, %eax
-	movl 8(%esi), %ebx
-	adcl %ebx, %eax
-	movl 12(%esi), %ebx
-	adcl %ebx, %eax
-	movl 16(%esi), %ebx
-	adcl %ebx, %eax
-	movl 20(%esi), %ebx
-	adcl %ebx, %eax
-	movl 24(%esi), %ebx
-	adcl %ebx, %eax
-	movl 28(%esi), %ebx
-	adcl %ebx, %eax
-	lea 32(%esi), %esi
-	dec %ecx
-	jne 1b
-	adcl $0, %eax
-2:	movl %edx, %ecx
-	andl $0x1c, %edx
-	je 4f
-	shrl $2, %edx		# This clears CF
-3:	adcl (%esi), %eax
-	lea 4(%esi), %esi
-	dec %edx
-	jne 3b
-	adcl $0, %eax
-4:	andl $3, %ecx
-	jz 7f
-	cmpl $2, %ecx
-	jb 5f
-	movw (%esi),%cx
-	leal 2(%esi),%esi
-	je 6f
-	shll $16,%ecx
-5:	movb (%esi),%cl
-6:	addl %ecx,%eax
-	adcl $0, %eax 
-7:	
-	popl %ebx
-	popl %esi
-	RET
-
-#else
-
-/* Version for PentiumII/PPro */
-
-csum_partial:
-	pushl %esi
-	pushl %ebx
-	movl 20(%esp),%eax	# Function arg: unsigned int sum
-	movl 16(%esp),%ecx	# Function arg: int len
-	movl 12(%esp),%esi	# Function arg:	const unsigned char *buf
-
-	testl $2, %esi         
-	jnz 30f                 
-10:
-	movl %ecx, %edx
-	movl %ecx, %ebx
-	andl $0x7c, %ebx
-	shrl $7, %ecx
-	addl %ebx,%esi
-	shrl $2, %ebx  
-	negl %ebx
-	lea 45f(%ebx,%ebx,2), %ebx
-	testl %esi, %esi
-	jmp *%ebx
-
-	# Handle 2-byte-aligned regions
-20:	addw (%esi), %ax
-	lea 2(%esi), %esi
-	adcl $0, %eax
-	jmp 10b
-
-30:	subl $2, %ecx          
-	ja 20b                 
-	je 32f
-	movzbl (%esi),%ebx	# csumming 1 byte, 2-aligned
-	addl %ebx, %eax
-	adcl $0, %eax
-	jmp 80f
-32:
-	addw (%esi), %ax	# csumming 2 bytes, 2-aligned
-	adcl $0, %eax
-	jmp 80f
-
-40: 
-	addl -128(%esi), %eax
-	adcl -124(%esi), %eax
-	adcl -120(%esi), %eax
-	adcl -116(%esi), %eax   
-	adcl -112(%esi), %eax   
-	adcl -108(%esi), %eax
-	adcl -104(%esi), %eax
-	adcl -100(%esi), %eax
-	adcl -96(%esi), %eax
-	adcl -92(%esi), %eax
-	adcl -88(%esi), %eax
-	adcl -84(%esi), %eax
-	adcl -80(%esi), %eax
-	adcl -76(%esi), %eax
-	adcl -72(%esi), %eax
-	adcl -68(%esi), %eax
-	adcl -64(%esi), %eax     
-	adcl -60(%esi), %eax     
-	adcl -56(%esi), %eax     
-	adcl -52(%esi), %eax   
-	adcl -48(%esi), %eax   
-	adcl -44(%esi), %eax
-	adcl -40(%esi), %eax
-	adcl -36(%esi), %eax
-	adcl -32(%esi), %eax
-	adcl -28(%esi), %eax
-	adcl -24(%esi), %eax
-	adcl -20(%esi), %eax
-	adcl -16(%esi), %eax
-	adcl -12(%esi), %eax
-	adcl -8(%esi), %eax
-	adcl -4(%esi), %eax
-45:
-	lea 128(%esi), %esi
-	adcl $0, %eax
-	dec %ecx
-	jge 40b
-	movl %edx, %ecx
-50:	andl $3, %ecx
-	jz 80f
-
-	# Handle the last 1-3 bytes without jumping
-	notl %ecx		# 1->2, 2->1, 3->0, higher bits are masked
-	movl $0xffffff,%ebx	# by the shll and shrl instructions
-	shll $3,%ecx
-	shrl %cl,%ebx
-	andl -128(%esi),%ebx	# esi is 4-aligned so should be ok
-	addl %ebx,%eax
-	adcl $0,%eax
-80: 
-	popl %ebx
-	popl %esi
-	RET
-				
-#endif
-	EXPORT_SYMBOL(csum_partial)
-- 
2.41.0.255.g8b1d071c50-goog

