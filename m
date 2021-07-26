Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE233D512E
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 04:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhGZBTi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Jul 2021 21:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhGZBTh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jul 2021 21:19:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E464C061757
        for <linux-arch@vger.kernel.org>; Sun, 25 Jul 2021 19:00:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso4790418pjo.1
        for <linux-arch@vger.kernel.org>; Sun, 25 Jul 2021 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=PuA/B3Xh8re6VMwGprN6Srm77JaO2WORhSdLB6MfWAQ=;
        b=SL4RxgMK8041Wo1farGcExnBzUsee47iybSuyx3oajO/ZsJnZZnIAsf5cNgXL+YSl7
         NdHkGpOHhSpFUBUwz+8ZiC40Yb2XXz//kdYZHj2oY/qMxukMh7A4UO7jc0gO37GV4ULZ
         jdVi8dh1ZVu495kHlmWGeHAZKlqgV8JY8I42IYvRlouIILzZcPdb9o5yScsTvHPWRPMV
         g1ssN2GKQVN6bBGWJOaK0MqFcKLA0PbtxhRmE1aYa9jBsNEaXVfG4+L39FEQQv3Ipm17
         ijs9iN2Yhbgo61aqb0YA2B5FkJZDjWKVDLQqJ+WnOIq3G6dlPcHHWH4w86P6o1FXLla2
         lz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=PuA/B3Xh8re6VMwGprN6Srm77JaO2WORhSdLB6MfWAQ=;
        b=o9IRlT3AsG4CMvZ8kFzxXp4gLrP/aCC/Y5j3zvCnYwcYCzTm9ZiklETA9U6mP5x2jY
         494rhFl8rG2eFRfBN98s6jrd9IY6l7x3L+tRf/mX+4Tful2MZjnHYwuVT5z8qElLPeN2
         l7jSPfI3YvhKmQMn/gPNKDlK+0Egf8wBzFaPLH2jxoya0AxtcIE52AXVdErRjXSkqQP/
         1q3k/Z5yr26unxsxB6L+aIOV5eP8FxjhsMDD0S1646c+j2QYR80Za0H3NjekQTcmLzD7
         77kvAjpZVjJwsY1VOceb5HLBAylhuwqiRar7dmijgeKJwYxjjfzel0tqgq9VwQMkWOrX
         pvyA==
X-Gm-Message-State: AOAM533KmOUyy8XdwbjsHmtvSHkRLO7dtZ8G3wYoI1am7vJDty41Sycc
        pPJXzQiclHMG7/Nz5HEblD0=
X-Google-Smtp-Source: ABdhPJyzbS8fwVaXCSxa39rdu0IeSQie7q0OEfkNhi2FgnV0VBE8n0oUHNosI1phIwHr+HR7VU6Dnw==
X-Received: by 2002:aa7:84c1:0:b029:32d:6bbf:b788 with SMTP id x1-20020aa784c10000b029032d6bbfb788mr15597150pfn.38.1627264807179;
        Sun, 25 Jul 2021 19:00:07 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:29ad:8fa7:168b:a8c8? ([2001:df0:0:200c:29ad:8fa7:168b:a8c8])
        by smtp.gmail.com with ESMTPSA id r15sm34733108pje.12.2021.07.25.19.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 19:00:06 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
To:     Brad Boyer <flar@allandria.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, geert@linux-m68k.org,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        torvalds@linux-foundation.org
References: <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
 <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com> <87h7gopvz2.fsf@disp2133>
 <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com> <877dhio13t.fsf@disp2133>
 <12992a3c-0740-f90e-aa4e-1ec1d8ea38f6@gmail.com> <87tukkk6h3.fsf@disp2133>
 <df6618bf-d1bc-4759-2d14-934c22d54a83@gmail.com> <87eebn7w7y.fsf@igel.home>
 <db43bef1-7938-4fc1-853d-c20d66521329@gmail.com>
 <20210725101253.GA6096@allandria.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <be3ddf9a-745e-4798-17a7-a9d0ddd7eef7@gmail.com>
Date:   Mon, 26 Jul 2021 14:00:01 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210725101253.GA6096@allandria.com>
Content-Type: multipart/mixed;
 boundary="------------8DA757192A993533D4532EED"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a multi-part message in MIME format.
--------------8DA757192A993533D4532EED
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks Brad, Andreas,

I won't rely on ARAnyM for these tests any longer then.

I would be much obliged if one of the m68k kernel crowd with access to a 
68040 could apply the two attached patches, on top of Eric's 
'refactoring exit' series for preference, and check that any program 
attempting a simple sin() or exp() operation exits with SEGV.

If you know of a way to trace said program and set a breakpoint in 
do_exit(), please also try to inspect saved registers at that point 
(though I'm not sure how to create a dump of the actual registers from 
inside the exception handler to compare with).

Cheers,

     Michael


On 25/07/21 10:12 pm, Brad Boyer wrote:

> On Sun, Jul 25, 2021 at 07:44:11PM +1200, Michael Schmitz wrote:
>> Am 25.07.2021 um 00:05 schrieb Andreas Schwab:
>>> On Jul 24 2021, Michael Schmitz wrote:
>>>
>>>> According to my understanding, you can't get a F-line exception on
>>>> 68040.
>>> The F-line exception vector is used for all FPU illegal and
>>> unimplemented insns.
>> Thanks - now from my reading of the fpsp040 code (which has mislead me in
>> the past), it would seem that operations like sin() and exp() ought to raise
>> that exception then. I don't see that in ARAnyM.
> Yes, according to the 68040 user's manual, unimplemented and illegal F-line
> instructions trigger the standard F-line exception vector (11) but have
> separate stack frame formats so the fpsp040 code gets some extra data.
> The CPU does a bunch of the prep work so that part doesn't need to be
> emulated in software.
>
> The ARAnyM docs appear to claim a strange combination that wouldn't
> exist in hardware by implementing a full 68882 instead of the limited
> subset found on a real 68040. Strangely, that might have been easier to
> implement. However, it would also completely bypass any use of fpsp040.
>
> 	Brad Boyer
> 	flar@allandria.com
>

--------------8DA757192A993533D4532EED
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-m68k-fpsp040-test-changes-to-copyin-out-exception-ha.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-m68k-fpsp040-test-changes-to-copyin-out-exception-ha.pa";
 filename*1="tch"

From 3df3164dd0f34f3ef7cfaccd079e83a7d146ee5f Mon Sep 17 00:00:00 2001
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Sat, 24 Jul 2021 15:22:58 +1200
Subject: [PATCH 2/2] m68k/fpsp040 - test changes to copyin/out exception
 handling

Call the exception handler in fpsp040/skeleton.S on each f-line
trap. This ought to allow verifying that the added stack frame
is accessible and contains useful data by just tracing a simple
program using one of the floating point operations not supported
by the 68040 FPU.

Signed-off-By: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/fpsp040/skeleton.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index 1cbc52b..1ca04bd 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -302,7 +302,8 @@ real_bsun:
 	.global	real_fline
 	.global	fline
 fline:
-	jmp	fpsp_fline
+	jmp	test_fpsp040_die
+	|jmp	fpsp_fline
 real_fline:
 
 	SAVE_ALL_INT
@@ -501,6 +502,7 @@ in_ea:
 
 	.section .fixup,#alloc,#execinstr
 	.even
+test_fpsp040_die:
 1:
 
 	SAVE_ALL_INT
-- 
2.7.4


--------------8DA757192A993533D4532EED
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-m68k-fpsp040-save-full-stack-frame-before-calling-fp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-m68k-fpsp040-save-full-stack-frame-before-calling-fp.pa";
 filename*1="tch"

From 737b74a376f0b3da09ba7cb088e99c2c85b7405c Mon Sep 17 00:00:00 2001
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Sun, 18 Jul 2021 10:31:42 +1200
Subject: [PATCH 1/2] m68k/fpsp040 - save full stack frame before calling
 fpsp040_die

The FPSP040 floating point support code does not know how to
handle user space access faults gracefully, and just calls
do_exit(SIGSEGV) indirectly on these faults to abort.

do_exit() may stop if traced, and needs a full stack frame
available to avoid exposing kernel data.

Add the current stack frame before calling do_exit() from the
fpsp040 user access exception handler. Top of stack frame saved
to task->thread.esp0 as is done for system calls.

Unwind the stack frame and return to caller once done, in case
do_exit() is replaced by force_sig() later on. Note that this
will allow the current exception handler to continue with
incorrect state, but the results will never make it to the
calling user program which is terminated by SYSSIGV upon return
from exception.

CC: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/fpsp040/skeleton.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index a8f4161..1cbc52b 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -502,7 +502,14 @@ in_ea:
 	.section .fixup,#alloc,#execinstr
 	.even
 1:
+
+	SAVE_ALL_INT
+	| save top of frame
+	movel	%sp,%curptr@(TASK_THREAD+THREAD_ESP0)
+	SAVE_SWITCH_STACK
 	jbra	fpsp040_die
+	lea	44(%sp),%sp
+	rts
 
 	.section __ex_table,#alloc
 	.align	4
-- 
2.7.4


--------------8DA757192A993533D4532EED--
