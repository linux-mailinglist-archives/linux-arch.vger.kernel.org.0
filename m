Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DD2207ED9
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 23:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404973AbgFXVtd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 17:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404700AbgFXVtc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 17:49:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9BDC061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:49:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ev7so1277445pjb.2
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9J2CZUP48fiuDe+l15O7PqgQWB3mKCPT+APYGkolERE=;
        b=U3zcce4R0BFZQpBMXUia0L4rUmnNxJL6RRN0I2qT8KyRFHOUyab+3sv5FvK7Q+xQT6
         BfXPRGjflDr7UeiF3S5kP1XPOkiAWEVZZ/sDu+fq3VlegLJ+3XLrquIZWjn7ayWkYCzD
         DGlm9hqV04oeJ5pt1TWn2smpfobQHkJ+60DVMifOj5Dgwdf34GqiNbK4bIibj5IwSOzY
         okUcH/p5gUNVj1kjU2l3JaKAdYw5JsvwR8Hv2An0RNPw4VAHR44NH77iLSgJAsOZJFW9
         jBx989iScWXwNiWoAxg5iH7/axM+9HKVvfS/FqN1YlndNZjL6GijGhSrKxkAPsx47LD2
         ZwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9J2CZUP48fiuDe+l15O7PqgQWB3mKCPT+APYGkolERE=;
        b=AV9tPjdd+Pq+BQNXMNFcgj4p/l64Qg416pq5s2Lbhz39UhwOrNyBvKD0rDlVvwL5dV
         +NlF/xgh3zpP+BVa7a8wBPcckrh00ko55E6nvavYgf9zzSXSBdeuu3PA0FF3cpenyDRj
         VeDnthVqTqHdbrRWZ+JZcS73ltsuBrzH4iaaONJx1vZijRagguYCRUV5o9oopd1fh5eB
         so/vF+5UYVZN9re/mqwfQSVxfv3XL2yWAzH+yh6KBxHo22yEHCPtovWtAUhXNcILYiNn
         3nE04tWDhcsNh91Zn7HXEQuBHlUg4ubM/Hy+sb4MUTWX69hiD03E9eC1wY0tigHFGNVJ
         Lz1w==
X-Gm-Message-State: AOAM530PGc4Xt5Li/LxuXHc1jFlbToCojW0cLqWA2wyxitYHAosymtY1
        MHSL8Tp9hBjEa1xcLTbzjxgogA==
X-Google-Smtp-Source: ABdhPJxYBIdYkNbMX8PMFnJWZ0uuJrnuXagI0eh1U8IdCvJqB4VqKOTU2xlvfTQ3szE4BUL/AQHpug==
X-Received: by 2002:a17:90a:a406:: with SMTP id y6mr32616295pjp.216.1593035372032;
        Wed, 24 Jun 2020 14:49:32 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id w124sm20560279pfc.213.2020.06.24.14.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 14:49:31 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:49:25 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 05/22] kbuild: lto: postpone objtool
Message-ID: <20200624214925.GB120457@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-6-samitolvanen@google.com>
 <20200624211908.GT4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624211908.GT4817@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 11:19:08PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 24, 2020 at 01:31:43PM -0700, Sami Tolvanen wrote:
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 30827f82ad62..12b115152532 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -120,7 +120,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >  /* Annotate a C jump table to allow objtool to follow the code flow */
> >  #define __annotate_jump_table __section(.rodata..c_jump_table)
> >  
> > -#ifdef CONFIG_DEBUG_ENTRY
> > +#if defined(CONFIG_DEBUG_ENTRY) || defined(CONFIG_LTO_CLANG)
> >  /* Begin/end of an instrumentation safe region */
> >  #define instrumentation_begin() ({					\
> >  	asm volatile("%c0:\n\t"						\
> 
> Why would you be doing noinstr validation for lto builds? That doesn't
> make sense.

This is just to avoid a ton of noinstr warnings when we run objtool on
vmlinux.o, but I'm also fine with skipping noinstr validation with LTO.

> > +ifdef CONFIG_STACK_VALIDATION
> > +ifneq ($(SKIP_STACK_VALIDATION),1)
> > +cmd_ld_ko_o +=								\
> > +	$(objtree)/tools/objtool/objtool				\
> > +		$(if $(CONFIG_UNWINDER_ORC),orc generate,check)		\
> > +		--module						\
> > +		$(if $(CONFIG_FRAME_POINTER),,--no-fp)			\
> > +		$(if $(CONFIG_GCOV_KERNEL),--no-unreachable,)		\
> > +		$(if $(CONFIG_RETPOLINE),--retpoline,)			\
> > +		$(if $(CONFIG_X86_SMAP),--uaccess,)			\
> > +		$(@:.ko=$(prelink-ext).o);
> > +
> > +endif # SKIP_STACK_VALIDATION
> > +endif # CONFIG_STACK_VALIDATION
> 
> What about the objtool invocation from link-vmlinux.sh ?

What about it? The existing objtool_link invocation in link-vmlinux.sh
works fine for our purposes as well.

Sami
