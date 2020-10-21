Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6432954C6
	for <lists+linux-arch@lfdr.de>; Thu, 22 Oct 2020 00:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506686AbgJUWZI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 18:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506684AbgJUWZI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Oct 2020 18:25:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7786DC0613CE
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2020 15:25:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a200so2320359pfa.10
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2020 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G8CEok3vbung1AhO88Lhvw62MF/+SVjC5VIcNaMPw5U=;
        b=BK+E+wakdfwRJnfLmhs+U8gNDHtfVkmV8MwmMTNQBCrrzVDkj7VhHf17LARBZFuEb3
         E0ScuwvnzzhWRNSRmXbt7TxDtSs+coXad7+mfzEn+yXG3JO8v1tLcnQpfzLw7cOhDofY
         LJnTlvzhlD/YDRok08DlAFHJsccc8D8N4FL0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G8CEok3vbung1AhO88Lhvw62MF/+SVjC5VIcNaMPw5U=;
        b=i8htKmteg1JUopHyvxPE/KtJjIeLxrGOR/Y18HvwKufBpvcVOZRYpr4CO/o5f/CU55
         /5z5DB4MJqcoA3h+iLTWT9o+QBTeVOkEe8K91RVUaNu/snjNGvppFHVqDy/KZsgF9VfW
         ozySgJf+HwcLPsWBJvT6EDAeRKbC1sNy5f4tJxArEF/ztFfkyx9KKpw5Wz+Jn4Yeovcy
         bQXFywf6I1A9dRQKCQNu56VDByrH6fUIqIBaV8qqY4rNSbsUfvXwJ4n4MgPXCv048hDl
         kt4IWz2h3uud0aIfhvYJ/3g5wo7AejFLtF0pKjVCJ2JNdWAJpmSzhcnj2wic/uf6tvHK
         maTw==
X-Gm-Message-State: AOAM531icKH7WYv7dqBJI6E8fQnNNQBXP38DTGkER+aQi9fNXwu4riRt
        QkPBUS71Y9cgXnUZrs7Srewynw==
X-Google-Smtp-Source: ABdhPJzWSs3xtfa1F0UBSrMOTHHa9ICC8KdPaaqaPc5Uxe5EBdyA9sAepRMnw6mmT4BKn2PgWqIMaA==
X-Received: by 2002:a05:6a00:15d1:b029:155:5c2c:c28e with SMTP id o17-20020a056a0015d1b02901555c2cc28emr83051pfu.3.1603319108059;
        Wed, 21 Oct 2020 15:25:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z20sm3126932pfn.39.2020.10.21.15.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 15:25:07 -0700 (PDT)
Date:   Wed, 21 Oct 2020 15:25:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vmlinux.lds.h: Keep .ctors.* with .ctors
Message-ID: <202010211523.EC217C9@keescook>
References: <20201005025720.2599682-1-keescook@chromium.org>
 <202010211303.4F8386F2@keescook>
 <20201021222215.GC4050@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021222215.GC4050@zn.tnic>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 22, 2020 at 12:22:15AM +0200, Borislav Petkov wrote:
> On Wed, Oct 21, 2020 at 01:04:35PM -0700, Kees Cook wrote:
> > [thread ping: x86 maintainers, can someone please take this?]
> 
> $ ./scripts/get_maintainer.pl -f include/asm-generic/vmlinux.lds.h
> Arnd Bergmann <arnd@arndb.de> (maintainer:GENERIC INCLUDE/ASM HEADER FILES)
> ...
> 
> so that's Arnd's AFAICT.

It was a fix for the series Ingo took, so I seemed sensible to keep it
together. Though at this point, I don't care who takes it. :)

Arnd, do you have a tree that'll go to Linus before -rc1?

-- 
Kees Cook
