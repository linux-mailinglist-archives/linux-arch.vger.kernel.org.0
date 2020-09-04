Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6725D22A
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 09:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgIDHOQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 03:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgIDHOP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 03:14:15 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99CCC061244;
        Fri,  4 Sep 2020 00:14:14 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n18so3981166qtw.0;
        Fri, 04 Sep 2020 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GSiu7q5INNKgwni6kCKdhOc96uZE70+2Wp8nmvDrTrM=;
        b=pVN64zaLQdVkm9y++BHIgl9U2HYy1ga2ItqCVhDAXoHtDKlW3qke2dVxHARuY9RHA4
         JUXg1v+XjSIPkvHaPAES954FDBnkDthsJ07QWrZWlLC1Yxvts+zg+VSZ71Jr7bMf4H18
         u+0x8AbJlY06zTXVdXCVAaZkz0P58VhuZ3vIqnnqn+1RHth8aDaaHihuQTu2cTuGP5+3
         QKjsFfOhUxNBDB2GrG5Sk14VIWkDiRKKFbRsv4Q0YKTpBWjSdZYERZUvbfkCq0u2TeU0
         bLUvSo40kyTW0CnRezsekbOBqmkwZv+n8+E0AQy8h84U4iMnz0lUwHSZcy5P0MrB+ESd
         R2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GSiu7q5INNKgwni6kCKdhOc96uZE70+2Wp8nmvDrTrM=;
        b=H6s4otDlUqDFuSAFZ1DlCB+xJr1rKokQQVV80ln5sUS3rpkWx9HYP89kk5S5fA/p+x
         tj0okB46dpzvPLgoVa08bSvGw/50nte8XdvPPV1zNmyrOhU2HWN0G1MBjsXgsB983egC
         Rc4dLUhYUBK+0vH4v+4pXUxnve2OFu0SSofTBmPD0uGtQQA6JGi7CDIKmhDGQUMwKU49
         35efQNvx4QGYsyenBXoJU4FBN2SoLIL8/iCRq6IUdjpnRD1r267TVotXI76lEkS9AMCB
         4QedM+dK0+467FnuH4AwB2AIA6qEvHD3kkYwS3TiQri4zwCbSmgF+BNXqb6eaK9nFOa8
         0rUw==
X-Gm-Message-State: AOAM533pCVik9VoJ+sTlRFvCrE6QSyRmtw2YqhYNk2cZzSXURNBL4P8y
        +NlHABm2+vkJu6CqoXEslq0=
X-Google-Smtp-Source: ABdhPJyxhXjoiuUHJ8yHqedEnX8rmWvhjD+7ADa6DmR56ksBmgeSMROQzmrkQSZxIIn6pfwVxB0aYA==
X-Received: by 2002:aed:2c63:: with SMTP id f90mr7360733qtd.262.1599203653880;
        Fri, 04 Sep 2020 00:14:13 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id 202sm2202325qkg.56.2020.09.04.00.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 00:14:12 -0700 (PDT)
Date:   Fri, 4 Sep 2020 00:14:11 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
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
        x86@kernel.org
Subject: Re: [PATCH v2 01/28] x86/boot/compressed: Disable relocation
 relaxation
Message-ID: <20200904071411.GA1712031@ubuntu-n2-xlarge-x86>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-2-samitolvanen@google.com>
 <202009031444.F2ECA89E@keescook>
 <20200903234215.GA106172@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903234215.GA106172@rani.riverdale.lan>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 07:42:15PM -0400, Arvind Sankar wrote:
> On Thu, Sep 03, 2020 at 02:44:41PM -0700, Kees Cook wrote:
> > On Thu, Sep 03, 2020 at 01:30:26PM -0700, Sami Tolvanen wrote:
> > > From: Arvind Sankar <nivedita@alum.mit.edu>
> > > 
> > > Patch series [4] is a solution to allow the compressed kernel to be
> > > linked with -pie unconditionally, but even if merged is unlikely to be
> > > backported. As a simple solution that can be applied to stable as well,
> > > prevent the assembler from generating the relaxed relocation types using
> > > the -mrelax-relocations=no option. For ease of backporting, do this
> > > unconditionally.
> > > 
> > > [0] https://gitlab.com/x86-psABIs/x86-64-ABI/-/blob/master/x86-64-ABI/linker-optimization.tex#L65
> > > [1] https://lore.kernel.org/lkml/20200807194100.3570838-1-ndesaulniers@google.com/
> > > [2] https://github.com/ClangBuiltLinux/linux/issues/1121
> > > [3] https://reviews.llvm.org/rGc41a18cf61790fc898dcda1055c3efbf442c14c0
> > > [4] https://lore.kernel.org/lkml/20200731202738.2577854-1-nivedita@alum.mit.edu/
> > > 
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > -- 
> > Kees Cook
> 
> Note that since [4] is now in tip, assuming it doesn't get dropped for
> some reason, this patch isn't necessary unless you need to backport this
> LTO series to 5.9 or below.
> 
> Thanks.

It is still necessary for tip of tree LLVM to work properly
(specifically clang and ld.lld) regardless of whether or not LTO is
used.

[4] also fixes it but I don't think it can be backported to stable so it
would still be nice to get it picked up so that it can be sent back
there. We have been carrying it in our CI for a decent amount of time...

Cheers,
Nathan
