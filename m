Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5C825CE75
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 01:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgICXmU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 19:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgICXmU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 19:42:20 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F172C061244;
        Thu,  3 Sep 2020 16:42:19 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f142so4774436qke.13;
        Thu, 03 Sep 2020 16:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Buf4pyI8QjmO6EzkejoF7rJNgrRLPFkG+pFmWeqNXSU=;
        b=LPBJX9YYiLdzfuvHhhApORKkjEcCokH8S7S+ixf/lb6PKyLameB2R/hO1MnJZ8lfjk
         RccIntdXKYJgeoTeIUtHPwlFVqlLK41Ye4qgM7C8a0Dl1XuqkWA/EbQaEDzvjYVM9Hem
         hXNDGnNCBxAUmwKqqrZTo5Z/pkPOaE+IU8GFh1uCzHl1RfLknP0FL1YAO1qizXvgdhoV
         jmGJqRqmzLQ/4JKXNZnVHBJKIv2uY/AATQNPFgyOPe5n3lAtj8q8KQIY8t8e6ZIeqzLb
         hUxL86tW8/dBzbuxUwIdIX/bzmz1jVTQI4jTiffCrlo0tyEZPNJWWfn9FXi7SgOBoEwA
         YQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Buf4pyI8QjmO6EzkejoF7rJNgrRLPFkG+pFmWeqNXSU=;
        b=F85Y7ChYcN2rlSmiphqxWbOQZtxSYwyltws1712fuoTdEQZPKOBjGLUzoaSly0v78R
         Ob5npEGly4c3BzIK+1OEERlRvqbySdAaFXei2ThB64vFjj/Mr+moxJjYKxuxlTaT4XA0
         G/Ko9/mioV/m/kYRvbXINGmi2FyEsEloaCi7DKoAxA9G2mJ7GxfNMlxMVEF9IhRRP56D
         o6CyEmoSKAPL5w4rIG2BZfGrONdPcwghrJ/qZ9+Y1C7tzuejhBhJiTiuYePPkQ36XNF8
         oNkIUcnPhSsyJb4BbcjVvM2tv0cqTLwZjpPllygasC9izASRA/dg87orDND163yMC37a
         gwig==
X-Gm-Message-State: AOAM531POp7t0BiPuriRJCIKKRjHvap8nC/U1Tnc8XF4BCFOaE6QIeJZ
        VhIAMY+GgmJUVaVpNgwt/lQ=
X-Google-Smtp-Source: ABdhPJwk7xSMHZgBS2KIiKPpibl4+puFeN+IUbUk1MnxASjO8ffXMYr1LuHhmFwUKcYtabk7P9z+Ww==
X-Received: by 2002:a37:4c4:: with SMTP id 187mr5768921qke.40.1599176538868;
        Thu, 03 Sep 2020 16:42:18 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 205sm3305039qki.118.2020.09.03.16.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 16:42:18 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 3 Sep 2020 19:42:15 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
Message-ID: <20200903234215.GA106172@rani.riverdale.lan>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-2-samitolvanen@google.com>
 <202009031444.F2ECA89E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202009031444.F2ECA89E@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 02:44:41PM -0700, Kees Cook wrote:
> On Thu, Sep 03, 2020 at 01:30:26PM -0700, Sami Tolvanen wrote:
> > From: Arvind Sankar <nivedita@alum.mit.edu>
> > 
> > Patch series [4] is a solution to allow the compressed kernel to be
> > linked with -pie unconditionally, but even if merged is unlikely to be
> > backported. As a simple solution that can be applied to stable as well,
> > prevent the assembler from generating the relaxed relocation types using
> > the -mrelax-relocations=no option. For ease of backporting, do this
> > unconditionally.
> > 
> > [0] https://gitlab.com/x86-psABIs/x86-64-ABI/-/blob/master/x86-64-ABI/linker-optimization.tex#L65
> > [1] https://lore.kernel.org/lkml/20200807194100.3570838-1-ndesaulniers@google.com/
> > [2] https://github.com/ClangBuiltLinux/linux/issues/1121
> > [3] https://reviews.llvm.org/rGc41a18cf61790fc898dcda1055c3efbf442c14c0
> > [4] https://lore.kernel.org/lkml/20200731202738.2577854-1-nivedita@alum.mit.edu/
> > 
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -- 
> Kees Cook

Note that since [4] is now in tip, assuming it doesn't get dropped for
some reason, this patch isn't necessary unless you need to backport this
LTO series to 5.9 or below.

Thanks.
