Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986842589F0
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 09:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgIAH7n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 03:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIAH7m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 03:59:42 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF33C061244;
        Tue,  1 Sep 2020 00:59:42 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q21so538352edv.1;
        Tue, 01 Sep 2020 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1tUkMsxqX+EmvRrvz0z84bC2IgPMV2uqRkretCUGwiQ=;
        b=qkxZLlPRV+HvJ1qB5AZTMRDPW93Z/gzTs0x18/F1NW5XRe5b7fQSGM/dUk5AQ+7TY+
         L+3oJiEQCjjswVwRkAz8MEGaDpWxIlfKhvbV9ByS3B9z0US62lCR1AXO9dN33RXqYtLI
         sWaSYa87lhOHVY3YpM/I8IWuhM1Wp+v18UI7NVByfcIETSsKma+jN6GunmH5vZMiq8xb
         2XkoSC7T3ntj3r1ELFyVnvnThVv9kyg/H59v0XtjkvUao8wRKWBr/KZBYUpQ0UJHgbKJ
         pY1xbx9gralqUwLbXi1wyERRawpucmFuYlfp/6cgHsg2xDKgiOwg9X3rzhbVckmAIHcR
         8Z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1tUkMsxqX+EmvRrvz0z84bC2IgPMV2uqRkretCUGwiQ=;
        b=BaSg72Ke5DnTW6obA0cNTSMX/z3a/m/p92s952Q2h2yFIed/ALKXxIMa9pXTpYmZGY
         7jMd6A4GuWBTIHaRzW0lBbARHxxsy7C9pPVqhy9meAh1cWQtcQPRPLmoQR3QkK2a9Chh
         1mIxEsQXf8p9woCdhpxLTcvpO72yc0IAFcN7Bteq9lYSN82KhRYZzGCknfdPL4O0LPTS
         WCgvAfKT+criMdPx9sNjxtj6e46hNiujQ+DqIPAuyxZNDa/rYU/n4QbBpn6GvSp3sJ/3
         x1AeHpLhZbMv6pIYEd2Xb5LqaGIB7wzxA1bKzxxbRPg8epHNHxYKcWNRln+tnYLgxqiz
         YCtg==
X-Gm-Message-State: AOAM530ty+EMbS8NMrPyvFqAlOLgw5gZ+vA/BbWVoNpvfTgJcKLbjJRE
        lmeKbyQ3PrOaE2n+PadyhBY=
X-Google-Smtp-Source: ABdhPJzeDWymrCPJVQGGseKzqQGGkA79Su6T6BnnuBxUsnIU8yb3Ft7Lc0UMjmZqTp7y2AROzPerXQ==
X-Received: by 2002:a50:8881:: with SMTP id d1mr689496edd.306.1598947180775;
        Tue, 01 Sep 2020 00:59:40 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id qu11sm511021ejb.15.2020.09.01.00.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 00:59:40 -0700 (PDT)
Date:   Tue, 1 Sep 2020 09:59:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/29] Warn on orphan section placement
Message-ID: <20200901075937.GA3602433@gmail.com>
References: <20200821194310.3089815-1-keescook@chromium.org>
 <202008311240.9F94A39@keescook>
 <20200901071133.GA3577996@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901071133.GA3577996@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Kees Cook <keescook@chromium.org> wrote:
> 
> > On Fri, Aug 21, 2020 at 12:42:41PM -0700, Kees Cook wrote:
> > > Hi Ingo,
> > > 
> > > Based on my testing, this is ready to go. I've reviewed the feedback on
> > > v5 and made a few small changes, noted below.
> > 
> > If no one objects, I'll pop this into my tree for -next. I'd prefer it
> > go via -tip though! :)
> > 
> > Thanks!
> 
> I'll pick it up today, it all looks very good now!

One thing I found in testing is that it doesn't handler older LD 
versions well enough:

  ld: unrecognized option '--orphan-handling=warn'

Could we just detect the availability of this flag, and emit a warning 
if it doesn't exist but otherwise not abort the build?

This is with:

  GNU ld version 2.25-17.fc23

Thanks,

	Ingo
