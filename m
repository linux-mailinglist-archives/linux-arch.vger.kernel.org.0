Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC4264D08
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 20:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIJSdU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 14:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIJS3m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Sep 2020 14:29:42 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F2CC0613ED
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 11:29:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fa1so439958pjb.0
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wjAWuNbVBoEPyXn+QBzLMnCnG3b1YEYkoDZS6EgQpPI=;
        b=UCp+FppW+25RCEWuidrdmD2H7oNwJWAPscXMA2ljdT7Hwfc6emJQQRXJKlonqRXwCr
         ZNZwT1diexj1oIPFx0vZRCKp8ePiBMfI0fNJK+PDlwitnt2/pXVXXfcmv7xMHDx85MGD
         jjgpGgVOnGdOdetQ71hUdu1jBGb560fU84u+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wjAWuNbVBoEPyXn+QBzLMnCnG3b1YEYkoDZS6EgQpPI=;
        b=ZmfY4uBIAbAm1fqqcpPSveBHITMG6m9uwaNK464v+yGQ80zuQH7viqsrC29RPlaI/B
         LiLJUCtb382G3NAZEHVstsQu8Ce+P8Y6kLmNP95RgYu8wCvDRAlDgvnkA/d3QGz8MDbJ
         YFXcl4rn+chcFqeHAdGyGOdn/6LBuPcm0t9JVwWmNMUqmXbAsk37ugVIheffPxbrb4Zr
         cVki2Cn9sT/LAAp9caWKJT72OmAfgA72bdRXCEwgAKjQYSLwaVDCo1ncL8AGkNtW8yun
         XV5zaLih94OGp8D6Bbtqh5MoUE0NDUtKqZCOamenSlLR1hAtvcvQM4CM1UWrCSHw8rCA
         fEFQ==
X-Gm-Message-State: AOAM530cndgsE2ID6zORuezkX5bzaCy3bcTFAO9hk/+vHOvJtpC9ZUh5
        X75h9V850Je4YbaKL+VClTkqfw==
X-Google-Smtp-Source: ABdhPJwQHia5IxoItB0v8TFyFBQYaMjt9d9oEodKfnuR8Fqxq3O6+WSooIjqvBiG9AzcqTroMIMGDQ==
X-Received: by 2002:a17:90b:3717:: with SMTP id mg23mr1229702pjb.42.1599762580221;
        Thu, 10 Sep 2020 11:29:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm6606733pfk.118.2020.09.10.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:29:39 -0700 (PDT)
Date:   Thu, 10 Sep 2020 11:29:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>, peterz@infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH v2 05/28] objtool: Add a pass for generating __mcount_loc
Message-ID: <202009101127.28B4414D2A@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-6-samitolvanen@google.com>
 <202009031450.31C71DB@keescook>
 <CABCJKueF1RbpOKHsA8yS_yMujzHi8dzAVz8APwpMJyMTTGhmDA@mail.gmail.com>
 <20200904093104.GH1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904093104.GH1362448@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 04, 2020 at 11:31:04AM +0200, peterz@infradead.org wrote:
> On Thu, Sep 03, 2020 at 03:03:30PM -0700, Sami Tolvanen wrote:
> > On Thu, Sep 3, 2020 at 2:51 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Thu, Sep 03, 2020 at 01:30:30PM -0700, Sami Tolvanen wrote:
> > > > From: Peter Zijlstra <peterz@infradead.org>
> > > >
> > > > Add the --mcount option for generating __mcount_loc sections
> > > > needed for dynamic ftrace. Using this pass requires the kernel to
> > > > be compiled with -mfentry and CC_USING_NOP_MCOUNT to be defined
> > > > in Makefile.
> > > >
> > > > Link: https://lore.kernel.org/lkml/20200625200235.GQ4781@hirez.programming.kicks-ass.net/
> > > > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > >
> > > Hmm, I'm not sure why this hasn't gotten picked up yet. Is this expected
> > > to go through -tip or something else?
> > 
> > Note that I picked up this patch from Peter's original email, to which
> > I included a link in the commit message, but it wasn't officially
> > submitted as a patch. However, the previous discussion seems to have
> > died, so I included the patch in this series, as it cleanly solves the
> > problem of whitelisting non-call references to __fentry__. I was
> > hoping for Peter and Steven to comment on how they prefer to proceed
> > here.
> 
> Right; so I'm obviously fine with this patch and I suppose I can pick it
> (and the next) into tip/objtool/core, provided Steve is okay with this
> approach.

Hello Steven-of-the-future-after-4000-emails![1] ;)

Getting your Ack on this would be very welcome, and would unblock a
portion of this series.

Thanks! :)

[1] https://twitter.com/srostedt/status/1303697650592755712

-- 
Kees Cook
