Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C8525CC8A
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 23:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgICVov (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 17:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgICVop (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 17:44:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D021C061246
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 14:44:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u13so3184066pgh.1
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wkni4eXx9E7Yx63VN0+vnviLhaoHNM+yB8xZjp7w5hM=;
        b=O5o59mUdRprA27/bBNjMETG5FChmb/k7jW6G/CEqPxqkNExuhCDFNEGkwkwsAAOk9B
         S/ND1TkN2Kb21Yt+dermQ1eJzMamhppfZcA/5BLAHvK0xooF6lH1S7/GgEK+o+mFn5sC
         Q+9Q6xNOHekU+wFfZY8e2e5GVn6y3TV0ytjI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wkni4eXx9E7Yx63VN0+vnviLhaoHNM+yB8xZjp7w5hM=;
        b=fsetS/2WSj7mTqzb1l1wfBM8UTTrxRHT+3tdOHei3BLXiOVMj/t0VP9IbvbbWGlYvk
         wMQZzzdVlW7fvNePJIokC0BX/2v7GtgW1ERGycKsBbyPx0eMRkT1E+GYhMN/W53AVhrh
         ZnZKYBzwfFbWaT93cn1k13lsyZKaX5bSEmkHPUhE/rCvDjb3JuccLqfl0koJu5HWr7Bq
         7+viHr5j6U/AVLwpzV2RDFAcC/o18bJXFn3Si/0rkFb4myfdVYlF/gS02c98X6leqXZU
         na9skg3h+ircdbtqUCC2kqQ9+WZXxzJsEMjthiOmwC3rD0X+r7DAeZ0mj4Pzvls7KJv6
         lvsQ==
X-Gm-Message-State: AOAM530ugGc4SnpswpDTc/Aehp9Z4JxXrsOrliAKzcNbfPIjYVcuIjI+
        Fk58kgHWT/pGB0u0PIlxOqNtVQ==
X-Google-Smtp-Source: ABdhPJzAv2fIwHx5fjsh6FyQ4DUXacQqnpd1HrcO3mYGfEva7Q9zQka0PVlCAE3Ap8Ww7DWt19mfFg==
X-Received: by 2002:a62:1809:: with SMTP id 9mr5726960pfy.217.1599169483379;
        Thu, 03 Sep 2020 14:44:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d77sm4259177pfd.121.2020.09.03.14.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 14:44:42 -0700 (PDT)
Date:   Thu, 3 Sep 2020 14:44:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 01/28] x86/boot/compressed: Disable relocation
 relaxation
Message-ID: <202009031444.F2ECA89E@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-2-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:26PM -0700, Sami Tolvanen wrote:
> From: Arvind Sankar <nivedita@alum.mit.edu>
> 
> The x86-64 psABI [0] specifies special relocation types
> (R_X86_64_[REX_]GOTPCRELX) for indirection through the Global Offset
> Table, semantically equivalent to R_X86_64_GOTPCREL, which the linker
> can take advantage of for optimization (relaxation) at link time. This
> is supported by LLD and binutils versions 2.26 onwards.
> 
> The compressed kernel is position-independent code, however, when using
> LLD or binutils versions before 2.27, it must be linked without the -pie
> option. In this case, the linker may optimize certain instructions into
> a non-position-independent form, by converting foo@GOTPCREL(%rip) to $foo.
> 
> This potential issue has been present with LLD and binutils-2.26 for a
> long time, but it has never manifested itself before now:
> - LLD and binutils-2.26 only relax
> 	movq	foo@GOTPCREL(%rip), %reg
>   to
> 	leaq	foo(%rip), %reg
>   which is still position-independent, rather than
> 	mov	$foo, %reg
>   which is permitted by the psABI when -pie is not enabled.
> - gcc happens to only generate GOTPCREL relocations on mov instructions.
> - clang does generate GOTPCREL relocations on non-mov instructions, but
>   when building the compressed kernel, it uses its integrated assembler
>   (due to the redefinition of KBUILD_CFLAGS dropping -no-integrated-as),
>   which has so far defaulted to not generating the GOTPCRELX
>   relocations.
> 
> Nick Desaulniers reports [1,2]:
>   A recent change [3] to a default value of configuration variable
>   (ENABLE_X86_RELAX_RELOCATIONS OFF -> ON) in LLVM now causes Clang's
>   integrated assembler to emit R_X86_64_GOTPCRELX/R_X86_64_REX_GOTPCRELX
>   relocations. LLD will relax instructions with these relocations based
>   on whether the image is being linked as position independent or not.
>   When not, then LLD will relax these instructions to use absolute
>   addressing mode (R_RELAX_GOT_PC_NOPIC). This causes kernels built with
>   Clang and linked with LLD to fail to boot.
> 
> Patch series [4] is a solution to allow the compressed kernel to be
> linked with -pie unconditionally, but even if merged is unlikely to be
> backported. As a simple solution that can be applied to stable as well,
> prevent the assembler from generating the relaxed relocation types using
> the -mrelax-relocations=no option. For ease of backporting, do this
> unconditionally.
> 
> [0] https://gitlab.com/x86-psABIs/x86-64-ABI/-/blob/master/x86-64-ABI/linker-optimization.tex#L65
> [1] https://lore.kernel.org/lkml/20200807194100.3570838-1-ndesaulniers@google.com/
> [2] https://github.com/ClangBuiltLinux/linux/issues/1121
> [3] https://reviews.llvm.org/rGc41a18cf61790fc898dcda1055c3efbf442c14c0
> [4] https://lore.kernel.org/lkml/20200731202738.2577854-1-nivedita@alum.mit.edu/
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
