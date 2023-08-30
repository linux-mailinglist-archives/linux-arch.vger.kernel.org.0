Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0380A78DC6E
	for <lists+linux-arch@lfdr.de>; Wed, 30 Aug 2023 20:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjH3Spr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Aug 2023 14:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244795AbjH3ODY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Aug 2023 10:03:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6733CFC;
        Wed, 30 Aug 2023 07:03:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a2185bd83cso742867866b.0;
        Wed, 30 Aug 2023 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693404200; x=1694009000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qR8FBesuV6bnDQYMHXUzhTaUk+KcihZET/yksmXJo6c=;
        b=REAWP0F65SsmZM6ZgyIk6rehqYWdPmUm+C2wTG2Sj3EXcyZMeGqY/rh3FwoVJChiCL
         i9BqaGxP9oMvMlg/pL52eXoRSHJTs4Tybmh7pdekLJuQ6X/rur4SuiURN1iZFAtgN5nQ
         UZBp1eihSZMU94MOV+syPFhcoMSF2bL0qHHuB1Ta92Po1F2Q9gjgOPnBAxEveaA8AS3r
         5x1hAZURyAbLC4uVgxgzs3pDn4lOQrGh/OsiVDw+zFdFpEQ2GQjO31/jmA4M9vo0BPAI
         18UGcJoj529nJ7P890XCb54acQX0UrhiPR1nY0kzQvgBq3GiiViGeTrccp7kMtmUZiSt
         Ehyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693404200; x=1694009000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qR8FBesuV6bnDQYMHXUzhTaUk+KcihZET/yksmXJo6c=;
        b=lmuckSuSs5Bo9vZwXNX+wF7rSqbTssY5xSl+iO+kmXjk0FLB1JC7qd0U061aFz7sQ/
         zTRQ/yAk7rzlUB1KGgIVu3KO1Rlk7xRPR24iIjvSYUKfDq3flw51x97LHAEpR2DO7ieO
         GOY2GT8DWDQIDgplt4njrg1Nib/0o+K+60k4mVVZVeWGxWdd5VPWmb8gvIdWLw8+PZzq
         GdpxgZiP0LyVT8vBZWo8KED1KkmmUsYJqDeUl470jGJQF4doElT5d4PN60KECw9EYSuh
         fe2KhXnEycBoAuT5hFMAM/F5eeNppNqPHUoMU2Vja24yvj0fe6bECZCtdh7tcM27o56Y
         0FRQ==
X-Gm-Message-State: AOJu0YzDGtAX/1YPhD3MiqJH8zcmT2i5WRxMD7DjFuaviywL9XZTyZ+u
        4O6xivGbQtKpFGLlpYX/REk=
X-Google-Smtp-Source: AGHT+IF119hvfhGyUF2CbiGcj5ESmW9hj7AvbiwCGvzI5mPU8vGioCNhv78LhcFYvgSAFFrARzo0Vg==
X-Received: by 2002:a17:907:75d8:b0:99c:55a9:3925 with SMTP id jl24-20020a17090775d800b0099c55a93925mr1597688ejc.24.1693404199595;
        Wed, 30 Aug 2023 07:03:19 -0700 (PDT)
Received: from f.. (cst-prg-30-15.cust.vodafone.cz. [46.135.30.15])
        by smtp.gmail.com with ESMTPSA id v17-20020a17090606d100b0098669cc16b2sm7148453ejb.83.2023.08.30.07.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 07:03:19 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de, Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] x86: bring back rep movsq for user access on CPUs without ERMS
Date:   Wed, 30 Aug 2023 16:03:15 +0200
Message-Id: <20230830140315.2666490-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I hacked up this crapper:

#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

int main(void)
{
        char *buf;
        int fd, n;

        buf = mmap((void *)0xAA0000, 4096, PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
        if (buf == MAP_FAILED) {
                perror("mmap");
                return 1;
        }

        fd = open("/tmp/out", O_RDWR | O_CREAT, 0644);
        if (fd == -1) {
                perror("open");
                return 1;
        }
        n = write(fd, &buf[4096 - 66], 130);
        printf("%d\n", n);
}

Then I modified the unrolled loop to have the following fixup:
.Lfallback:
	ud2

	_ASM_EXTABLE_UA(10b, .Lfallback)
	_ASM_EXTABLE_UA(11b, .Lfallback)
[and so on]

Similarly, the movsq implementation:
1:     leaq (%rax,%rcx,8),%rcx
       ud2
       jmp .Lcopy_user_tail

Then I compared regdumps from both results and they match up:
stock:  RCX: 0000000000000042 RSI: 0000000000aa0ffe
movsq:  RCS: 0000000000000042 RSI: 0000000000aa0ffe

[note MAP_FIXED with 0xAA0000]

v1 gives a bogus result.

Finally write returns 66 on both stock and patched kernel.

So I think we are fine here.

================ cut here ================

Intel CPUs ship with ERMS for over a decade, but this is not true for
AMD.  In particular one reasonably recent uarch (EPYC 7R13) does not
have it (or at least the bit is inactive when running on the Amazon
EC2 cloud -- I found rather conflicting information about AMD CPUs vs the
extension).

Hand-rolled mov loops executing in this case are quite pessimal compared
to rep movsq for bigger sizes. While the upper limit depends on uarch,
everyone is well south of 1KB AFAICS and sizes bigger than that are
common.

While technically ancient CPUs may be suffering from rep usage, gcc has
been emitting it for years all over kernel code, so I don't think this
is a legitimate concern.

Sample result from read1_processes from will-it-scale (4KB reads/s):
before:	1507021
after:	1721828 (+14%)

Note that the cutoff point for rep usage is set to 64 bytes, which is
way too conservative but I'm sticking to what was done in 47ee3f1dd93b
("x86: re-introduce support for ERMS copies for user space accesses").
That is to say *some* copies will now go slower, which is fixable but
beyond the scope of this patch.

v2:
- correct fixup handling
- use 0/1 labels, stop messing with ones already put there for erms
[the _ASM_EXTABLE_UA line is still modified because it was indented with
spaces]
- removu now unneded clobbers on r8-r11
- add a note about removal of the unrolled loop

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 arch/x86/include/asm/uaccess_64.h |  2 +-
 arch/x86/lib/copy_user_64.S       | 57 +++++++------------------------
 2 files changed, 14 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 81b826d3b753..f2c02e4469cc 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -116,7 +116,7 @@ copy_user_generic(void *to, const void *from, unsigned long len)
 		"2:\n"
 		_ASM_EXTABLE_UA(1b, 2b)
 		:"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
-		: : "memory", "rax", "r8", "r9", "r10", "r11");
+		: : "memory", "rax");
 	clac();
 	return len;
 }
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 01c5de4c279b..0a81aafed7f8 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -27,7 +27,7 @@
  * NOTE! The calling convention is very intentionally the same as
  * for 'rep movs', so that we can rewrite the function call with
  * just a plain 'rep movs' on machines that have FSRM.  But to make
- * it simpler for us, we can clobber rsi/rdi and rax/r8-r11 freely.
+ * it simpler for us, we can clobber rsi/rdi and rax freely.
  */
 SYM_FUNC_START(rep_movs_alternative)
 	cmpq $64,%rcx
@@ -68,55 +68,24 @@ SYM_FUNC_START(rep_movs_alternative)
 	_ASM_EXTABLE_UA( 3b, .Lcopy_user_tail)
 
 .Llarge:
-0:	ALTERNATIVE "jmp .Lunrolled", "rep movsb", X86_FEATURE_ERMS
+0:	ALTERNATIVE "jmp .Llarge_movsq", "rep movsb", X86_FEATURE_ERMS
 1:	RET
 
-        _ASM_EXTABLE_UA( 0b, 1b)
+	_ASM_EXTABLE_UA( 0b, 1b)
 
-	.p2align 4
-.Lunrolled:
-10:	movq (%rsi),%r8
-11:	movq 8(%rsi),%r9
-12:	movq 16(%rsi),%r10
-13:	movq 24(%rsi),%r11
-14:	movq %r8,(%rdi)
-15:	movq %r9,8(%rdi)
-16:	movq %r10,16(%rdi)
-17:	movq %r11,24(%rdi)
-20:	movq 32(%rsi),%r8
-21:	movq 40(%rsi),%r9
-22:	movq 48(%rsi),%r10
-23:	movq 56(%rsi),%r11
-24:	movq %r8,32(%rdi)
-25:	movq %r9,40(%rdi)
-26:	movq %r10,48(%rdi)
-27:	movq %r11,56(%rdi)
-	addq $64,%rsi
-	addq $64,%rdi
-	subq $64,%rcx
-	cmpq $64,%rcx
-	jae .Lunrolled
-	cmpl $8,%ecx
-	jae .Lword
+.Llarge_movsq:
+	movq %rcx,%rax
+	shrq $3,%rcx
+	andl $7,%eax
+0:	rep movsq
+	movl %eax,%ecx
 	testl %ecx,%ecx
 	jne .Lcopy_user_tail
 	RET
 
-	_ASM_EXTABLE_UA(10b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(11b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(12b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(13b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(14b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(15b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(16b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(17b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(20b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(21b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(22b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(23b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(24b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(25b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(26b, .Lcopy_user_tail)
-	_ASM_EXTABLE_UA(27b, .Lcopy_user_tail)
+1:	leaq (%rax,%rcx,8),%rcx
+	jmp .Lcopy_user_tail
+
+	_ASM_EXTABLE_UA( 0b, 1b)
 SYM_FUNC_END(rep_movs_alternative)
 EXPORT_SYMBOL(rep_movs_alternative)
-- 
2.39.2

