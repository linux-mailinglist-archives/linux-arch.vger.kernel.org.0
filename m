Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A26D3CC6B5
	for <lists+linux-arch@lfdr.de>; Sun, 18 Jul 2021 01:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhGQXHg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Jul 2021 19:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhGQXHf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Jul 2021 19:07:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A89C061762
        for <linux-arch@vger.kernel.org>; Sat, 17 Jul 2021 16:04:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id my10so9020734pjb.1
        for <linux-arch@vger.kernel.org>; Sat, 17 Jul 2021 16:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=nlw4nPMoOI8+3Hlyk5DjWGy59a0MNaD/nVkFISsRKEo=;
        b=ZO1Xn99bO+sfm+otTVj7FfER2z67jKuGcNouXcxEK2/1U0im9d3r90B0Oe5ihzTRZP
         iOkyzZJ1CKl/8pfCB65B0ghUrPZnr2RJpLCrSMAuv/VNRFpXmvi4vVkztbZUskDcaPhu
         uEftHDA0/cU5d+85XB1wkc332mEuPAj0vUitQwqU3Npfhmru3evT89dYeYCohxvm4uFJ
         /S9J7knNZay9a8XrgzWcxOoVYm9zooF4kc5CsWwQm1aNG7urh3dkuZ/l63rnSmRm68b8
         VFaJXMIKKAFbQx+JwARzaGrNj09LocrYVPxMbHl4KkvUm8BHzBeumchAWKHJGMtCrzwi
         Ca/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=nlw4nPMoOI8+3Hlyk5DjWGy59a0MNaD/nVkFISsRKEo=;
        b=V2YAUqU222tXjMuWPmY2fXIfyQWVkw7NzbYkzQb4b1lvqndAa1BbUQjkD6q8bBI6IM
         CIlGz5iSqbah0T0uN4Zu0X3xvJ6K7meOgOTvdOTnC3KhCaPUVQRU3xrGgpw5VJ7i3hpF
         RnftydfQxyvINNG+nMy31dTUFSdX60hc83l5I6ohp4lG8+TcdJ2RNfRO5ucQJUQ2HMqI
         MCQcZvt0msOewzZSoPG+9rbg0M6fjPtxE3bPwiUksPqQLzfjdrTZdIx/rPyz001R+Ci3
         t78oLzuiX8hS+BoJIDi0p8x+Mn/TzUE5nQDCpx/iT1bZ6HaN5KEfRbURAqfdz/5YwbAp
         xF1g==
X-Gm-Message-State: AOAM533D4eLU409p7Q1yk/0de2+jFNllQn1yDVi/844Q0/oXTowDLp5I
        ghk6bILpbVC6cFNcNLJuhUg=
X-Google-Smtp-Source: ABdhPJxSdqt/sf7B4dtuX0FmQlsBQn9gG3yWw7AFHqwMJ8wgKruvmPwAo//K9/wPoxx2l8RDWiJkQQ==
X-Received: by 2002:a17:90a:db8d:: with SMTP id h13mr17028441pjv.141.1626563078179;
        Sat, 17 Jul 2021 16:04:38 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-37-fibre.sparkbb.co.nz. [222.152.189.37])
        by smtp.gmail.com with ESMTPSA id q18sm14422023pfj.178.2021.07.17.16.04.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jul 2021 16:04:37 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
To:     "Eric W. Biederman" <ebiederm@xmission.com>
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
 <87zgunzovm.fsf@disp2133> <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
 <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com> <8735scvklk.fsf@disp2133>
 <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
Cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com>
Date:   Sun, 18 Jul 2021 11:04:31 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------905F5E72384F74352E84B186"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a multi-part message in MIME format.
--------------905F5E72384F74352E84B186
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Am 18.07.2021 um 08:09 schrieb Michael Schmitz:
> Hi Eric,
>
> Am 18.07.2021 um 06:52 schrieb Eric W. Biederman:
>>> I should have looked more closely at skeleton.S - most FPU exceptions
>>> handled there call trap_c the same way as is done for generic traps,
>>> i.e. SAVE_ALL_INT before, ret_from_exception after.
>>>
>>> Instead of adding code to entry.S, much better to add it in
>>> skeleton.S. I'll try to come up with a way to test this code path
>>> (calling fpsp040_die from the dz exception hander seems much the
>>> easiest way) to make sure this doesn't have side effects.
>>>
>>> Does do_exit() ever return?
>>
>> No.  The function do_exit never returns.
>
> Fine - nothing to worry about as regards restoring the stack pointer
> correctly then.
>
>> If it is not too much difficulty I would be in favor of having the code
>> do force_sigsegv(SIGSEGV), instead of calling do_exit directly.
>
> That _would_ force a return, right? The exception handling in skeleton.S
> won't be set up for that.

See attached patch - note that when you change fpsp040_die() to call 
force_sig(SIGSEGV), the access exception handler will return to whatever 
function in fpsp040 attempted the user space access, and continue that 
operation with quite likely bogus data. That may well force another FPU 
trap before the SIGSEGV is delivered (will force_sig() immediately force 
a trap, or wait until returning to user space?).

Compile tested - haven't found an easy way to execute that code path yet.

Cheers,

	Michael


>
>> Looking at that code I have not been able to figure out the call paths
>> that get into skeleton.S.  I am not certain saving all of the registers
>> on an the exceptions that reach there make sense.  In practice I suspect
>
> The registers are saved only so trap_c has a stack frame to work with.
> In that sense, adding a stack frame before calling fpsp040_die is no
> different.
>
>> taking an exception is much more expensive than saving the registers
>> so it
>> might not make any difference.  But this definitely looks like code that
>> is performance sensitive.
>
> We're only planning to add a stack frame save before calling out of the
> user access exception handler, right? I doubt that will be called very
> often.
>
>> My sense when I was reading through skeleton.S was just one or two
>> registers were saved before the instruction emulation was called.
>
> skeleton.S only contains the entry points for code to handle FPU
> exceptions, from what I've seen (plus the user space access code).
>
> Wherever that exception handling requires calling into the C exception
> handler (trap_c), a stack frame is added.
>
> Cheers,
>
>     Michael
>
>>

--------------905F5E72384F74352E84B186
Content-Type: text/x-diff;
 name="0001-m68k-fpsp040-save-full-stack-frame-before-calling-fp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-m68k-fpsp040-save-full-stack-frame-before-calling-fp.pa";
 filename*1="tch"

From 1e9be9238fb88dc0b87a7ffdd48068f944d8626c Mon Sep 17 00:00:00 2001
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Sun, 18 Jul 2021 10:31:42 +1200
Subject: [PATCH] m68k/fpsp040 - save full stack frame before calling
 fpsp040_die

The FPSP040 floating point support code does not know how to
handle user space access faults gracefully, and just calls
do_exit(SIGSEGV) indirectly on these faults to abort.

do_exit() may stop if traced, and needs a full stack frame
available to avoid exposing kernel data.

Add the current stack frame before calling do_exit() from the
fpsp040 user access exception handler. Unwind the stack frame
and return to caller once done, in case do_exit() is replaced
by force_sig() later on.

CC: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/fpsp040/skeleton.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index a8f4161..6c92d38 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -502,7 +502,17 @@ in_ea:
 	.section .fixup,#alloc,#execinstr
 	.even
 1:
+
+	SAVE_ALL_INT
+	SAVE_SWITCH_STACK
 	jbra	fpsp040_die
+	addql   #8,%sp
+	addql   #8,%sp
+	addql   #8,%sp
+	addql   #8,%sp
+	addql   #8,%sp
+	addql   #4,%sp
+	rts
 
 	.section __ex_table,#alloc
 	.align	4
-- 
2.7.4


--------------905F5E72384F74352E84B186--
