Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035C33128A0
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 01:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBHAlQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 7 Feb 2021 19:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBHAlQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Feb 2021 19:41:16 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D12C06174A;
        Sun,  7 Feb 2021 16:40:35 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id o21so421464qtr.3;
        Sun, 07 Feb 2021 16:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=k8kyS5NcNbcb+l8f+ny89WYmgXi+Pxs4HtJo/I4TE4I=;
        b=UJfgwkWdAAifQT4DY2OMLzkk7qvAZILoIKw5GzS5a66OtKqunDtGw+eB+VsmoZiGBt
         Cib9sNEW1FBaRGAN3vmYtVLKJfbJH846utlOTQQrMaefyx3cx7Jb07RwsoqLHWtdgZYr
         eHuCkbZU6QH/HSWUumQDZHBng/MbdKBXlqRtvRkV5HooJ5pwOCI9T1gKLRslkn8mxVQF
         Mv8f+Sb74YrbC5L9U4APBrIRQ+dwbZcMbAF0L25ZLOWixyydSt+/FvWqBNDvm5Diuapg
         +SwsDO5/uot5qwiBcY/xc3yGx86kD528v09Kf/4AgoD1E25ltmNknQvH6thRg9nDmfWy
         QcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k8kyS5NcNbcb+l8f+ny89WYmgXi+Pxs4HtJo/I4TE4I=;
        b=cN3LBGU8bKWhL+TCKCEIujCdcMMdzG/NVk0jefONxBtN8T5fMo7wJZdRjbvFzTVUrI
         E3g7ywbL8MAbul5F/1ufVtRpryDoWA1rM/7sKUszp0/QExCp2rUmg4cheyKFDl+jU7jF
         kIiL5UD8XO9S285KEduivBG+p1k67NG6t82AVWt8IQp8ngcupTvz6jYvGHfqCGicDF0N
         PlzfBCoPq2Dd37flp2O0s6zzlpHhDrCyI6lrbaatq2mg03pGHqpDdq59HG7sDOXawFbU
         dFG2/TMkWIWrEn7WaH4I/QBpivoAkfS/4a168ovhfV9f/pXS/Jf7CODZ6QkbThbdYT8L
         b2mw==
X-Gm-Message-State: AOAM532T8mXmHtqc5YPcinwxOnXSeWL4uXQDWoeWiR+cH7ElT+BBtSJS
        y30Eo0D5AQB5ARE7IFFug0I=
X-Google-Smtp-Source: ABdhPJwefXRxSbzlMJ6lWQO+HtxryFVZCyNgQtm3RGVB2HZeDA1Lx2WKkFEIc6i2my9zY0lUeKefIQ==
X-Received: by 2002:ac8:5887:: with SMTP id t7mr13538561qta.182.1612744834574;
        Sun, 07 Feb 2021 16:40:34 -0800 (PST)
Received: from arch-chirva.localdomain (pool-68-133-6-116.bflony.fios.verizon.net. [68.133.6.116])
        by smtp.gmail.com with ESMTPSA id t71sm15755390qka.86.2021.02.07.16.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 16:40:34 -0800 (PST)
Date:   Sun, 7 Feb 2021 19:40:32 -0500
From:   Stuart Little <achirvasub@gmail.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, jpoimboe@redhat.com, nborisov@suse.com,
        bp@suse.de, seth.forshee@canonical.com,
        yamada.masahiro@socionext.com
Subject: Re: PROBLEM: 5.11.0-rc7 fails =?utf-8?Q?to?=
 =?utf-8?Q?_compile_with_error=3A_=E2=80=98-mindirect-branch=E2=80=99_and_?=
 =?utf-8?B?4oCYLWZjZi1wcm90ZWN0aW9u4oCZ?= are not compatible
Message-ID: <YCCIgMHkzh/xT4ex@arch-chirva.localdomain>
References: <YCB4Sgk5g5B2Nu09@arch-chirva.localdomain>
 <YCCFGc97d2U5yUS7@arch-chirva.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YCCFGc97d2U5yUS7@arch-chirva.localdomain>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

And for good measure: reverting that commit 

20bf2b378729c4a0366a53e2018a0b70ace94bcd

flagged by the bisect right on top of the current tree compiles fine. 

On Sun, Feb 07, 2021 at 07:26:01PM -0500, Stuart Little wrote:
> The result of the bisect on the issue reported in the previous message:
> 
> --- cut ---
> 
> 20bf2b378729c4a0366a53e2018a0b70ace94bcd is the first bad commit
> commit 20bf2b378729c4a0366a53e2018a0b70ace94bcd
> Author: Josh Poimboeuf <jpoimboe@redhat.com>
> Date:   Thu Jan 28 15:52:19 2021 -0600
> 
>     x86/build: Disable CET instrumentation in the kernel
>     
>     With retpolines disabled, some configurations of GCC, and specifically
>     the GCC versions 9 and 10 in Ubuntu will add Intel CET instrumentation
>     to the kernel by default. That breaks certain tracing scenarios by
>     adding a superfluous ENDBR64 instruction before the fentry call, for
>     functions which can be called indirectly.
>     
>     CET instrumentation isn't currently necessary in the kernel, as CET is
>     only supported in user space. Disable it unconditionally and move it
>     into the x86's Makefile as CET/CFI... enablement should be a per-arch
>     decision anyway.
>     
>      [ bp: Massage and extend commit message. ]
>     
>     Fixes: 29be86d7f9cb ("kbuild: add -fcf-protection=none when using retpoline flags")
>     Reported-by: Nikolay Borisov <nborisov@suse.com>
>     Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>     Signed-off-by: Borislav Petkov <bp@suse.de>
>     Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>     Tested-by: Nikolay Borisov <nborisov@suse.com>
>     Cc: <stable@vger.kernel.org>
>     Cc: Seth Forshee <seth.forshee@canonical.com>
>     Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>     Link: https://lkml.kernel.org/r/20210128215219.6kct3h2eiustncws@treble
> 
>  Makefile          | 6 ------
>  arch/x86/Makefile | 3 +++
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> --- end ---
> 
> On Sun, Feb 07, 2021 at 06:31:22PM -0500, Stuart Little wrote:
> > I am trying to compile on an x86_64 host for a 32-bit system; my config is at
> > 
> > https://termbin.com/v8jl
> > 
> > I am getting numerous errors of the form
> > 
> > ./include/linux/kasan-checks.h:17:1: error: ‘-mindirect-branch’ and ‘-fcf-protection’ are not compatible
> > 
> > and
> > 
> > ./include/linux/kcsan-checks.h:143:6: error: ‘-mindirect-branch’ and ‘-fcf-protection’ are not compatible
> > 
> > and
> > 
> > ./arch/x86/include/asm/arch_hweight.h:16:1: error: ‘-mindirect-branch’ and ‘-fcf-protection’ are not compatible
> > 
> > (those include files indicated whom I should add to this list; apologies if this reaches you in error).
> > 
> > The full log of the build is at
> > 
> > https://termbin.com/wbgs
> > 
> > ---
> > 
> > 5.11.0-rc6 built fine last week on this same setup. 
