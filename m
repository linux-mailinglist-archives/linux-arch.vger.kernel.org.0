Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B2578B602
	for <lists+linux-arch@lfdr.de>; Mon, 28 Aug 2023 19:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjH1RIh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Aug 2023 13:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjH1RIZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Aug 2023 13:08:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5F9AD;
        Mon, 28 Aug 2023 10:07:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so4647409a12.3;
        Mon, 28 Aug 2023 10:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693242459; x=1693847259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LS43YliouTR1Tmc7pmJvHEse7b+ov00zdmVcklEZbk=;
        b=WjbBuRKf73KWIf9F16bsplRaKkQYbBrXNhZKRfwSUCn7V2kGzFBhkn6zr7JmpUCbjQ
         zNyiBMSz7sqLugek3VQ2I2FiSZdtVsFMT3gReHzS54UJGdAqdCWO9OBn1by4L6mEiwfP
         qFBHIBzYKHW+eQs89YthaCQsVJVQa0214HBThV99zm0ul3mmSRGJoe8njjAjcFxwRCVR
         hpiwlS2K55g6zHjQrOqGvX4OXLg//NgNs+f+5ytuKfdV+AX9NnMAm/zNRGT5gjhJtaNv
         gs09FmAyghk5vRq2pTJkyQ4YqIj3sca26atVb2EMZ+z2DYPX1plM48V9ugWPSIEBFQfN
         dDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693242459; x=1693847259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LS43YliouTR1Tmc7pmJvHEse7b+ov00zdmVcklEZbk=;
        b=RMlc5KLkzKdjVGjGRW9hDdqwf9cL9dwY5obDinCKrl5DzLEm77+yD1oU5qBE5M24y9
         76L91gMZu5SnC5KwCZrglXLpOYOv+Gcoyc10uPDfS6gD25RPqWIpeDI16HAU/vObCkEA
         2OkPZqQEXCmleaoco7OS4ZydEAls0bcUM5PiOKVn3ZsAQmxoXR5LjGhPkR0atYMUofRc
         rPM69kMuwMuGeM2nb1kwNkiz3XLsdP9RSeuJMdQZVPqP36SqfVAvtDQen5u+AzZtoMv3
         wxxuvU4kBtORdbdwGC++litn2TB7vwTRox6RBre+ViqWyiE8ldrvh1EUWCaK+i3HsMRL
         9Daw==
X-Gm-Message-State: AOJu0YwXQp8GorjV7+TEWNdXellffklxNC0G4yw7+8fpRRLlwpdzgTfN
        51o5P1MYIVCL4loMZDQQFJs=
X-Google-Smtp-Source: AGHT+IGJHHsPMMf5Pt7kdbB0Fc2JnHdPcucxkbCKZJkRQy5+4EkECR+NWw0nSebMXoWkv12Q3+E4Bg==
X-Received: by 2002:aa7:d995:0:b0:525:44c5:48e2 with SMTP id u21-20020aa7d995000000b0052544c548e2mr18222390eds.22.1693242459025;
        Mon, 28 Aug 2023 10:07:39 -0700 (PDT)
Received: from f.. (cst-prg-30-15.cust.vodafone.cz. [46.135.30.15])
        by smtp.gmail.com with ESMTPSA id i15-20020a056402054f00b005236410a16bsm4667696edx.35.2023.08.28.10.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 10:07:38 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de, Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] x86: bring back rep movsq for user access on CPUs without ERMS
Date:   Mon, 28 Aug 2023 19:07:32 +0200
Message-Id: <20230828170732.2526618-1-mjguzik@gmail.com>
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

I spotted rep_movs_alternative on a flamegraph while building the kernel
on an AMD CPU and I was surprised to find it does not have ERMS.

The 64 byte loop there can be trivially replaced with movsq and I don't
think there are any reasons to NOT do it. If anything I'm surprised the
non-ERMS case was left hanging around after the 32KB regression reported
by Eric Dumazet.

Anyhow patch below remedies it.

The patch initially had:
 SYM_FUNC_START(rep_movs_alternative)
        cmpq $64,%rcx
-       jae .Llarge
+       ALTERNATIVE "jae .Lrep_movsq", "jae .Lrep_movsb", X86_FEATURE_ERMS


But then I found the weird nops and after reading the thread which
resulted in bringing back ERMS I see why
https://lore.kernel.org/lkml/CANn89iKUbyrJ=r2+_kK+sb2ZSSHifFZ7QkPLDpAtkJ8v4WUumA@mail.gmail.com/

That said, whacking the 64 byte loop in favor of rep movsq is definitely
the right to do and the patch below is one way to do it.

What I don't get is what's up with ERMS availability on AMD CPUs. I was
told newer uarchs support it, but the bit may be disabled in bios(?).

Anyhow, I temporarily got an instance on Amazon EC2 with EPYC 7R13 and
the bit is not there, whether this is a config problem or not.

I also note there is quite a mess concerning other string ops, which I'm
going to tackle in another thread later(tm).

================ cut here ================

Intel CPUs ship with ERMS for over a decade, but this is not true for
AMD. 

Hand-rolled mov loops executing in this case are quite pessimal compared
to rep movsq for bigger sizes. While the upper limit depends on uarch,
everyone is well south of 1KB AFAICS and sizes bigger than that are
common. The problem can be easily remedied so do it.

Sample result from read1_processes from will-it-scale on EPYC 7R13
(4KB reads/s):
before:	1507021
after:	1721828 (+14%)

Note that the cutoff point for rep usage is set to 64 bytes, which is
way too conservative but I'm sticking to what was done in 47ee3f1dd93b
("x86: re-introduce support for ERMS copies for user space accesses").
That is to say *some* copies will now go slower, which is fixable but
beyond the scope of this patch.

While here make sure labels are unique.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 arch/x86/lib/copy_user_64.S | 61 +++++++++++--------------------------
 1 file changed, 17 insertions(+), 44 deletions(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 01c5de4c279b..2fe61de81a22 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -68,55 +68,28 @@ SYM_FUNC_START(rep_movs_alternative)
 	_ASM_EXTABLE_UA( 3b, .Lcopy_user_tail)
 
 .Llarge:
-0:	ALTERNATIVE "jmp .Lunrolled", "rep movsb", X86_FEATURE_ERMS
-1:	RET
+4:	ALTERNATIVE "jmp .Llarge_movsq", "rep movsb", X86_FEATURE_ERMS
+5:	RET
 
-        _ASM_EXTABLE_UA( 0b, 1b)
+	_ASM_EXTABLE_UA( 4b, 5b)
 
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
+	movq %rcx,%r8
+	movq %rcx,%rax
+	shrq $3,%rcx
+	andl $7,%eax
+6:	rep movsq
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
+/*
+ * Recovery after failed rep movsq
+ */
+7:	movq %r8,%rcx
+	jmp .Lcopy_user_tail
+
+	_ASM_EXTABLE_UA( 6b, 7b)
 SYM_FUNC_END(rep_movs_alternative)
 EXPORT_SYMBOL(rep_movs_alternative)
-- 
2.39.2

