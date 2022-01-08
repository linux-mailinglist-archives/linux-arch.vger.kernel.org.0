Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37635488341
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 12:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiAHLiT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 06:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiAHLiS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 06:38:18 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC43C061574;
        Sat,  8 Jan 2022 03:38:18 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id x18-20020a7bc212000000b00347cc83ec07so2044838wmi.4;
        Sat, 08 Jan 2022 03:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3cBlkt0IFDqo3j02RGZKPkNAC+y562vttgIBpBo+5KU=;
        b=HBK13ph8L4p0NCCz88xQiOfNvLIaJ74EYjqIHXgwXgaQC3QOuYUkKDbhxmWykZRKgH
         G903+qO79La+8eRFVld+Lx+E0XfXh7ipEH6Qh/HDzDj8dk1mmCaIg2iZx1uWZ9h1hVsj
         5FYm3h898kVYEz8WlzChhYQCg3sViC89bF5rkIEHZYJHCeFz398znibNqPeRdKqa9xTn
         YveG/hR8vqiBZyLbumFu1R8kBzCrV+pipX+/9DRNtyNNwNX6qP7YL2y0UH7jDduFW9sC
         83fSh/u+zDMoXx70F3ijA5zs4hwkY8szKZXXCZ7MMH5rWOGr8FTc9eUaz2C8u+O0rlre
         3v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3cBlkt0IFDqo3j02RGZKPkNAC+y562vttgIBpBo+5KU=;
        b=HO/4l17uc5Cl/KfVwJdfrG+WcJ3x/tehPRj1ubdtyd6fGBkI8mn4Y+qTR9eOf8oPqn
         c4iW7HIGA+5FvXuRUfPP7W1muTwPH/6mKjulrWwo3pLLtq+8o+c/YvCtnXUIEGrWZ3Kx
         k1Q/6yr3+eXnG68txgsqu718zI6b+HFSyqKEKiueT0yag08I5+VXSvxfitcwhqhI+BP6
         sIHMHW+YLgB1Xqr9U9Se7gPIFbEzbS3nfv/TrX8DHCKMJSrCSOw83yQF2HRH1TqUlXLd
         j/wBLJeqU/gzVQoSjIBjb2f/xRuWN5e9Whg6M0tqzBJOMx5nhQlAtlzAENSryarRfS8B
         /e6A==
X-Gm-Message-State: AOAM531CXl/b27D0R4z3lpiHL0XLpd6BrpB+Ldyof7wWjbJDPPHTA2kZ
        F4p+SXyLxG85D8/MDNWTpHeGTtU5HgI=
X-Google-Smtp-Source: ABdhPJwdBO4j15yeSfxn/1a7R7TCbBFqdCbRAuer2Pd+PCOFZqKlqhtfK7tVlHQcmAHIZgivYnmfhA==
X-Received: by 2002:a05:600c:1d95:: with SMTP id p21mr1948650wms.9.1641641896891;
        Sat, 08 Jan 2022 03:38:16 -0800 (PST)
Received: from gmail.com (84-236-113-171.pool.digikabel.hu. [84.236.113.171])
        by smtp.gmail.com with ESMTPSA id g15sm267498wrm.2.2022.01.08.03.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 03:38:16 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 8 Jan 2022 12:38:14 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
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
Subject: [PATCH] x86/bitops: Remove unused __sw_hweight64() assembly
 implementation
Message-ID: <Ydl3pk94T+V7E7cz@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <YdSI9LmZE+FZAi1K@archlinux-ax161>
 <YdTpAJxgI+s9Wwgi@gmail.com>
 <YdTvXkKFzA0pOjFf@gmail.com>
 <YdYQu9YxNw0CxJRn@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdYQu9YxNw0CxJRn@archlinux-ax161>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Nathan Chancellor <nathan@kernel.org> wrote:

> 4. modpost warning around __sw_hweight64
> 
> With the first issue resolved:
> 
> $ make -skj"$(nproc)" ARCH=i386 allmodconfig
> WARNING: modpost: EXPORT symbol "__sw_hweight64" [vmlinux] version ...
> Is "__sw_hweight64" prototyped in <asm/asm-prototypes.h>?

So I was hoping that this commit made explicit all the random indirect 
header dependencies x86's <asm/asm-prototypes.h> imports on mainline:

    headers/prep: x86/kbuild: Add symbol prototype header dependencies for modversions

... but a i386 case slipped through.

But, this actually highlights a real x86 symbol export bug IMO.

__arch_hweight64() on x86-32 is defined in the 
arch/x86/include/asm/arch_hweight.h header as an inline, using 
__arch_hweight32():


  #ifdef CONFIG_X86_32
  static inline unsigned long __arch_hweight64(__u64 w)
  {
          return  __arch_hweight32((u32)w) +
                  __arch_hweight32((u32)(w >> 32));
  }

*But* there's also a __sw_hweight64() assembly implementation:

  arch/x86/lib/hweight.S

  SYM_FUNC_START(__sw_hweight64)
  #ifdef CONFIG_X86_64
  ...
  #else /* CONFIG_X86_32 */
        /* We're getting an u64 arg in (%eax,%edx): unsigned long hweight64(__u64 w) */
        pushl   %ecx

        call    __sw_hweight32
        movl    %eax, %ecx                      # stash away result
        movl    %edx, %eax                      # second part of input
        call    __sw_hweight32
        addl    %ecx, %eax                      # result

        popl    %ecx
        ret
  #endif

But this __sw_hweight64 assembly implementation is unused - and it's 
essentially doing the same thing that the inline wrapper does. Then we 
export this unused helper with no prototype.

This went unnoticed in mainline, because mainline defines the prototype for 
the unused prototype.

So I think the real solution to resolve this is by removing the unused 
32-bit variant - see the patch below.

Thanks,

	Ingo

======================>
From: Ingo Molnar <mingo@kernel.org>
Date: Sat, 8 Jan 2022 12:33:58 +0100
Subject: [PATCH] x86/bitops: Remove unused __sw_hweight64() assembly implementation

Header cleanups in the fast-headers tree highlighted that we have an
unused assembly implementation for __sw_hweight64():

    WARNING: modpost: EXPORT symbol "__sw_hweight64" [vmlinux] version ...

__arch_hweight64() on x86-32 is defined in the
arch/x86/include/asm/arch_hweight.h header as an inline, using
__arch_hweight32():

  #ifdef CONFIG_X86_32
  static inline unsigned long __arch_hweight64(__u64 w)
  {
          return  __arch_hweight32((u32)w) +
                  __arch_hweight32((u32)(w >> 32));
  }

*But* there's also a __sw_hweight64() assembly implementation:

  arch/x86/lib/hweight.S

  SYM_FUNC_START(__sw_hweight64)
  #ifdef CONFIG_X86_64
  ...
  #else /* CONFIG_X86_32 */
        /* We're getting an u64 arg in (%eax,%edx): unsigned long hweight64(__u64 w) */
        pushl   %ecx

        call    __sw_hweight32
        movl    %eax, %ecx                      # stash away result
        movl    %edx, %eax                      # second part of input
        call    __sw_hweight32
        addl    %ecx, %eax                      # result

        popl    %ecx
        ret
  #endif

But this __sw_hweight64 assembly implementation is unused - and it's
essentially doing the same thing that the inline wrapper does.

Remove the assembly version and add a comment about it.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/lib/hweight.S | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/x86/lib/hweight.S b/arch/x86/lib/hweight.S
index dbf8cc97b7f5..585e2f1372d0 100644
--- a/arch/x86/lib/hweight.S
+++ b/arch/x86/lib/hweight.S
@@ -36,8 +36,12 @@ SYM_FUNC_START(__sw_hweight32)
 SYM_FUNC_END(__sw_hweight32)
 EXPORT_SYMBOL(__sw_hweight32)
 
-SYM_FUNC_START(__sw_hweight64)
+/*
+ * No 32-bit variant, because it's implemented as an inline wrapper
+ * on top of __arch_hweight32():
+ */
 #ifdef CONFIG_X86_64
+SYM_FUNC_START(__sw_hweight64)
 	pushq   %rdi
 	pushq   %rdx
 
@@ -66,18 +70,6 @@ SYM_FUNC_START(__sw_hweight64)
 	popq    %rdx
 	popq    %rdi
 	ret
-#else /* CONFIG_X86_32 */
-	/* We're getting an u64 arg in (%eax,%edx): unsigned long hweight64(__u64 w) */
-	pushl   %ecx
-
-	call    __sw_hweight32
-	movl    %eax, %ecx                      # stash away result
-	movl    %edx, %eax                      # second part of input
-	call    __sw_hweight32
-	addl    %ecx, %eax                      # result
-
-	popl    %ecx
-	ret
-#endif
 SYM_FUNC_END(__sw_hweight64)
 EXPORT_SYMBOL(__sw_hweight64)
+#endif
