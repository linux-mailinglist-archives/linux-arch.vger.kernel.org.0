Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C48420A2B8
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 18:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390746AbgFYQPM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Jun 2020 12:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390589AbgFYQPL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2020 12:15:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5803EC08C5DD
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 09:15:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so3481463pge.12
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=no7YVr00DbKKQ+yaF/NLUAHDlIF83IoT6Cfe6Ue8Rsk=;
        b=QWdvdGQMKWLXFCj/e3uSXu3nIed+fEpI9sixMesz0lmaFvY+vhrbPQCL2sfOwX5Xtz
         dJOd7qtWZudwGhWJ+gbv1sxQvZIkuGk6XpJScPP6djHS3Gjtpwa7FrqRlou+lHRJtZZZ
         E6lOy4qOE0EckdWmFhkcLT54pDwlj99vXre4+ksDWSXwsjNcFMNF4qwlEGG8e1VqTFDQ
         xJh5VQeFsuhh9JPP5l68M979tHfFPP91RJEzeejy+3inJ6Ch9ZslROLlJkFXrp0dB7vi
         CJdzxgSmmDz68iPXfh2R8CxQ1kMKTk1lzBLXZYMYpViAqBc0if/psRGS2Bx8e3vIkdLC
         XavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=no7YVr00DbKKQ+yaF/NLUAHDlIF83IoT6Cfe6Ue8Rsk=;
        b=n439fDhwKMoEeyXvEP2IAIO6xPP8rSxIbIoTmFnZASPomp73DwMElHY2T0Mk509OuC
         8xtQ3ZIqnJFWGIWiOpKiROD7M48yyXMaRTYt5UvuEkrawguEE/7Fuw16GoTeSyzYmwTl
         072ZvEv8zeQ7GFriyAAEEuyGf6oTuc/pxCfd1Gl99n/ohNA/VAd3kEb3549QTlpeBc/i
         SQLhVSpapHgDf85oTflHUPHS+3RRVxnN17dobmuoqvQ8nHX6HlaW345qSdmmqYhCnRdZ
         QVLw/AdfqtGLYdcimcGXJapeXoX/tnWuOkVs2tfdtkYKUV+891nA0BgEDmav/ih9Q6np
         +AcA==
X-Gm-Message-State: AOAM530d0BHgZgYKNM1BhY3N//bDgXvKAGXi69gtMiwogiVRDuqlFAqp
        5TZqx8Yq754qasNzIGOgelaCpQ==
X-Google-Smtp-Source: ABdhPJwBA+f5YY24rFGe1FlZ0Pbcr47k53bKGlTrbuSqy24H60q+oFwTSxgIA7OapKwETcq0tJs/tw==
X-Received: by 2002:a63:395:: with SMTP id 143mr23203113pgd.57.1593101710493;
        Thu, 25 Jun 2020 09:15:10 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id u12sm8450067pjy.37.2020.06.25.09.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:15:09 -0700 (PDT)
Date:   Thu, 25 Jun 2020 09:15:03 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
Subject: Re: [PATCH 04/22] kbuild: lto: fix recordmcount
Message-ID: <20200625161503.GB173089@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com>
 <20200624212737.GV4817@hirez.programming.kicks-ass.net>
 <20200624214530.GA120457@google.com>
 <20200625074530.GW4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625074530.GW4817@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 25, 2020 at 09:45:30AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 24, 2020 at 02:45:30PM -0700, Sami Tolvanen wrote:
> > On Wed, Jun 24, 2020 at 11:27:37PM +0200, Peter Zijlstra wrote:
> > > On Wed, Jun 24, 2020 at 01:31:42PM -0700, Sami Tolvanen wrote:
> > > > With LTO, LLVM bitcode won't be compiled into native code until
> > > > modpost_link. This change postpones calls to recordmcount until after
> > > > this step.
> > > > 
> > > > In order to exclude specific functions from inspection, we add a new
> > > > code section .text..nomcount, which we tell recordmcount to ignore, and
> > > > a __nomcount attribute for moving functions to this section.
> > > 
> > > I'm confused, you only add this to functions in ftrace itself, which is
> > > compiled with:
> > > 
> > >  KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
> > > 
> > > and so should not have mcount/fentry sites anyway. So what's the point
> > > of ignoring them further?
> > > 
> > > This Changelog does not explain.
> > 
> > Normally, recordmcount ignores each ftrace.o file, but since we are
> > running it on vmlinux.o, we need another way to stop it from looking
> > at references to mcount/fentry that are not calls. Here's a comment
> > from recordmcount.c:
> > 
> >   /*
> >    * The file kernel/trace/ftrace.o references the mcount
> >    * function but does not call it. Since ftrace.o should
> >    * not be traced anyway, we just skip it.
> >    */
> > 
> > But I agree, the commit message could use more defails. Also +Steven
> > for thoughts about this approach.
> 
> Ah, is thi because recordmcount isn't smart enough to know the
> difference between "CALL $mcount" and any other RELA that has mcount?

Yes.

> At least for x86_64 I can do a really quick take for a recordmcount pass
> in objtool, but I suppose you also need this for ARM64 ?

Sure, sounds good. arm64 uses -fpatchable-function-entry with clang, so we
don't need recordmcount there.

Sami
