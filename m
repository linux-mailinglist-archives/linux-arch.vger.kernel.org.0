Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2F9312895
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 01:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBHA0p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 7 Feb 2021 19:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBHA0o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Feb 2021 19:26:44 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1647C06174A;
        Sun,  7 Feb 2021 16:26:04 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id d85so12873229qkg.5;
        Sun, 07 Feb 2021 16:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dDf+QsV3I3slhxIeK/jswJxScHK7l3HKSebkL3FSL9k=;
        b=jz7LMxEYA/vHgdinygwhgVHio//xQm9L//Y9rQ/2Vxs//B3IhjSu8yh4zYfHgjKSlu
         fxJjqLl59/akG8NxRVeRdpT30cK58TEtWBKbU67ufeE5P7sTlcetCwaSSBMTM0DcLEmV
         /PpOQl0SJKPiZkcjwVmgSMy0YwZpC5ywPG88qZJXvZgxUq08tMjDaC4WBIZearZHFY8V
         CRz3nGNWkaivI39QmDH0vVdGxs+gf93WKX1BCobwWdygDEtmZF2RD+h5OOvXtHTawICk
         9YUmD1N+1XzZnvq3X7r/xCBUb8rOYlhac6UESToZULYHOkj7xl9GoCr0G2OYcrT3p7tn
         bPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dDf+QsV3I3slhxIeK/jswJxScHK7l3HKSebkL3FSL9k=;
        b=OoCifVDAyOipSQJdYEVAMCprwUFg9IuM1pHc0NTbME6C9aQpCJzRefsmee5bRS8r4s
         7NyhLOy7vZXxg4r1ClNIp5G7TXzOZguSXJ+fZ34XkAxZbEOED0REOfQuH8jk4i6fNsLq
         nioZ+Y8mbC5cK9opcuwa0BbcKpXxnJ4nQpDGRQ5jKD4ALtH96KzqXXxNiFYwr68Zt5X1
         vNaQHsSVx4x6vxLMG6fukD26VCNoxDaO841dzl99a81lDzym2co4tTroSyGSUXOAa8co
         KOpb9krr3bIobsAHUKPCUn2Eebnh2950W5UqiXL4CLDO/C3UsBwwUb1n1y4HrsM+WOpz
         Ygyg==
X-Gm-Message-State: AOAM531AaZiDIWhdtdCQNHtwbPXAcJi2Om7uWGTCLPL6ezCHCydHWDD2
        EeEjy5xBKQbNl2pQvId9OO8=
X-Google-Smtp-Source: ABdhPJzXvhHBy8pC0CVk3hJ3hf6GxIuoTUs6iHJ0KX9VYnlfy2QOyONXe9jWULHxxU4o7y83k5o/6g==
X-Received: by 2002:ae9:d881:: with SMTP id u123mr14644020qkf.133.1612743963970;
        Sun, 07 Feb 2021 16:26:03 -0800 (PST)
Received: from arch-chirva.localdomain (pool-68-133-6-116.bflony.fios.verizon.net. [68.133.6.116])
        by smtp.gmail.com with ESMTPSA id y186sm7645292qka.121.2021.02.07.16.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 16:26:03 -0800 (PST)
Date:   Sun, 7 Feb 2021 19:26:01 -0500
From:   Stuart Little <achirvasub@gmail.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: PROBLEM: 5.11.0-rc7 fails =?utf-8?Q?to?=
 =?utf-8?Q?_compile_with_error=3A_=E2=80=98-mindirect-branch=E2=80=99_and_?=
 =?utf-8?B?4oCYLWZjZi1wcm90ZWN0aW9u4oCZ?= are not compatible
Message-ID: <YCCFGc97d2U5yUS7@arch-chirva.localdomain>
References: <YCB4Sgk5g5B2Nu09@arch-chirva.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YCB4Sgk5g5B2Nu09@arch-chirva.localdomain>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The result of the bisect on the issue reported in the previous message:

--- cut ---

20bf2b378729c4a0366a53e2018a0b70ace94bcd is the first bad commit
commit 20bf2b378729c4a0366a53e2018a0b70ace94bcd
Author: Josh Poimboeuf <jpoimboe@redhat.com>
Date:   Thu Jan 28 15:52:19 2021 -0600

    x86/build: Disable CET instrumentation in the kernel
    
    With retpolines disabled, some configurations of GCC, and specifically
    the GCC versions 9 and 10 in Ubuntu will add Intel CET instrumentation
    to the kernel by default. That breaks certain tracing scenarios by
    adding a superfluous ENDBR64 instruction before the fentry call, for
    functions which can be called indirectly.
    
    CET instrumentation isn't currently necessary in the kernel, as CET is
    only supported in user space. Disable it unconditionally and move it
    into the x86's Makefile as CET/CFI... enablement should be a per-arch
    decision anyway.
    
     [ bp: Massage and extend commit message. ]
    
    Fixes: 29be86d7f9cb ("kbuild: add -fcf-protection=none when using retpoline flags")
    Reported-by: Nikolay Borisov <nborisov@suse.com>
    Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
    Signed-off-by: Borislav Petkov <bp@suse.de>
    Reviewed-by: Nikolay Borisov <nborisov@suse.com>
    Tested-by: Nikolay Borisov <nborisov@suse.com>
    Cc: <stable@vger.kernel.org>
    Cc: Seth Forshee <seth.forshee@canonical.com>
    Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
    Link: https://lkml.kernel.org/r/20210128215219.6kct3h2eiustncws@treble

 Makefile          | 6 ------
 arch/x86/Makefile | 3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

--- end ---

On Sun, Feb 07, 2021 at 06:31:22PM -0500, Stuart Little wrote:
> I am trying to compile on an x86_64 host for a 32-bit system; my config is at
> 
> https://termbin.com/v8jl
> 
> I am getting numerous errors of the form
> 
> ./include/linux/kasan-checks.h:17:1: error: ‘-mindirect-branch’ and ‘-fcf-protection’ are not compatible
> 
> and
> 
> ./include/linux/kcsan-checks.h:143:6: error: ‘-mindirect-branch’ and ‘-fcf-protection’ are not compatible
> 
> and
> 
> ./arch/x86/include/asm/arch_hweight.h:16:1: error: ‘-mindirect-branch’ and ‘-fcf-protection’ are not compatible
> 
> (those include files indicated whom I should add to this list; apologies if this reaches you in error).
> 
> The full log of the build is at
> 
> https://termbin.com/wbgs
> 
> ---
> 
> 5.11.0-rc6 built fine last week on this same setup. 
