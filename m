Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228F5484BC3
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 01:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiAEAgE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 19:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbiAEAgC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 19:36:02 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E96CC061761;
        Tue,  4 Jan 2022 16:36:02 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z29so154999311edl.7;
        Tue, 04 Jan 2022 16:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XIYZPrPq0Nz4GldCeOXf4vMbUjZfTiGp6yytMV7qdxo=;
        b=TCegI6SZaay1+FEoaHOJcvPlaiZc/HaZO0R7NblofrYikzDKuPbkcKQ6lS9ZVHVMZY
         g+hDgATgLNbH1ufS9yPk4BvYicS2RtcOJ7j4/ekrdU+n+C51vdfdqKCrhxnbJXbQ+Zrd
         KEkMcfaCS5XgU7NGHyi+ticBofbZZfRDzV5W8HIlvSGvbNmRcm+BP4tZPgbNDDznX6nz
         NbxjVlWB/TmKyIudg6E0+IadwqWRSAwylSYhIkWMPQrMWih8fhxw8cWr26+AdpvTMUNY
         LG3IgNErq3hppjmps/MURPw+9w/ZfnkCkHtt/fma2VV9u5Vh4/I+8tQX7YrnAEYgSmeV
         RRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=XIYZPrPq0Nz4GldCeOXf4vMbUjZfTiGp6yytMV7qdxo=;
        b=K6DlG/sibWLSPLJBmUx/IDrvBEPye9de1DOv8k+VVSvpuJlFZgwWMy3DB++G7i5ocP
         aMDg3lQXc/RWb8zPj/tHyjzBm/hEGTzvSc6LPO/xS6eu9/GV8z24nYR/57Az9/gx6HEO
         5CFCEXiuHt2lrpnI90ieEpTd8qDaWw9MMGE0vl+vBA/XOJO7+6vme0K8olktYgrcwE9u
         EUQXMp94tfYQBeikWqHBBeWC8honGlTtkzvHHl24OMQ6KZDSTNh7r3qZ0hq9EaW3ypkN
         owLksNh0OZJWN1ghEura7QYsziMgxAR3Jx7oOjN2xhgOy0mjtNIND6kxEcp0akCZQg4K
         yU1g==
X-Gm-Message-State: AOAM5321NlTQS9qjwLf7o/KIXFLG8wR0tW/z7VWBc1SLcT0bb91ajHtL
        avBJimCCvwHIM5dqfcmztSk=
X-Google-Smtp-Source: ABdhPJyknKH7KOwCkxAqbHyY7hFOS8FmZBLzZP6c7qd3HC9CTMFisqGgsyXL+CmdsQyTY7s0DukAcA==
X-Received: by 2002:a17:906:1c51:: with SMTP id l17mr39332364ejg.610.1641342960753;
        Tue, 04 Jan 2022 16:36:00 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id f13sm7577520ejf.53.2022.01.04.16.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 16:36:00 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 5 Jan 2022 01:35:58 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>, llvm@lists.linux.dev
Subject: [PATCH] x86/kbuild: Enable CONFIG_KALLSYMS_ALL=y in the defconfigs
Message-ID: <YdTn7gssoMVDMgMw@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <YdSI9LmZE+FZAi1K@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdSI9LmZE+FZAi1K@archlinux-ax161>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Nathan Chancellor <nathan@kernel.org> wrote:

> Good point. With my main box (AMD EPYC 7502P), with the performance governor...
> 
> GCC:
> 
> Benchmark 1: ARCH=x86_64 defconfig (linux)
>   Time (mean ± σ):     48.685 s ±  0.049 s    [User: 1969.835 s, System: 204.166 s]
>   Range (min … max):   48.620 s … 48.782 s    10 runs
> 
> Benchmark 2: ARCH=x86_64 defconfig (linux-fast-headers)
>   Time (mean ± σ):     46.797 s ±  0.119 s    [User: 1403.854 s, System: 154.336 s]
>   Range (min … max):   46.620 s … 47.052 s    10 runs
> 
> Summary
>   'ARCH=x86_64 defconfig (linux-fast-headers)' ran
>     1.04 ± 0.00 times faster than 'ARCH=x86_64 defconfig (linux)'
> 
> LLVM:
> 
> Benchmark 1: ARCH=x86_64 defconfig (linux)
>   Time (mean ± σ):     51.816 s ±  0.079 s    [User: 2208.577 s, System: 200.410 s]
>   Range (min … max):   51.671 s … 51.900 s    10 runs
> 
> Benchmark 2: ARCH=x86_64 defconfig (linux-fast-headers)
>   Time (mean ± σ):     46.806 s ±  0.062 s    [User: 1438.972 s, System: 154.846 s]
>   Range (min … max):   46.696 s … 46.917 s    10 runs
> 
> Summary
>   'ARCH=x86_64 defconfig (linux-fast-headers)' ran
>     1.11 ± 0.00 times faster than 'ARCH=x86_64 defconfig (linux)'
> 
> $ rg KALLSYMS .config
> 246:CONFIG_KALLSYMS=y
> 247:# CONFIG_KALLSYMS_ALL is not set
> 248:CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> 249:CONFIG_KALLSYMS_BASE_RELATIVE=y
> 250:CONFIG_KALLSYMS_FAST=y
> 706:CONFIG_HAVE_OBJTOOL_KALLSYMS=y
> 
> It seems like everything is working right but maybe the build is so
> short that there just is not much time for the difference to be as
> apparent?

Yeah, x86 defconfig doesn't have KALLSYMS_ALL - while all distro configs I 
checked have it enabled, because it makes crash printouts / backtraces more 
informative.

Lockep will also enable it unconditionally.

So I've applied the patch below, to make the x86 defconfig more 
representative of what people are using in practice. This will also, as a 
side effect, bring elapsed time improvements closer to what the underlying 
cpu-time improvements offer, in the small-config case too.

Thanks,

	Ingo

====================================>
From: Ingo Molnar <mingo@kernel.org>
Date: Wed, 5 Jan 2022 01:31:35 +0100
Subject: [PATCH] x86/kbuild: Enable CONFIG_KALLSYMS_ALL=y in the defconfigs

Most distro kernels have this option enabled, to improve debug output.

Lockdep also selects it.

Enable this in the defconfig kernel as well, to make it more
representative of what people are using on x86.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/configs/i386_defconfig   | 1 +
 arch/x86/configs/x86_64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 5d97a2dfbaa7..71124cf8630c 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -261,3 +261,4 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
+CONFIG_KALLSYMS_ALL=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 30ab3e582d53..92b1169ec90b 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -257,3 +257,4 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
+CONFIG_KALLSYMS_ALL=y
