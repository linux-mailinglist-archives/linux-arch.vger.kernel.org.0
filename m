Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD2E25CCC4
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 23:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgICVvQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 17:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgICVvN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 17:51:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03118C061244
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 14:51:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k15so2203517pji.3
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qXpu71ctdlh3mEQbznjWlLLlQUw5P2bBw2F3vq4Wzjo=;
        b=ZyZZKeIpcpI80+hejxzxlgql178wdYHMLgxxEcNsZP5DgNheiVVnTG3N+eHQ6nQdTA
         Niu4Mm24mQzd8zXiPCHvu1WgPl9pvcZLM7dK+CVMgSnMSoSLzj6aaeKFz4fN5yjD378D
         otR7uM4FcmoQ6MxJYzFRJSwnOdQ8bNb3OFeq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qXpu71ctdlh3mEQbznjWlLLlQUw5P2bBw2F3vq4Wzjo=;
        b=f9c1PMK3PRnlV3mkk6Oqm6NVPMk7Z6t4/TNESQex5KOKncNmBcwWVD0vqLIehIWyWL
         hDzSJ4SV1ouL9XU+//9Vl4Ez658mfm1LoCqFu5NCtVQZ4YcPMDF0aHcLDTn/QrKE6anq
         IAeWQaBV/eKQMgrG+jVbsQpYUFuKFTLZKcuHDA8jB9p0oymq5ED/Bzt0WeKbvmd9Su9g
         b1//rh9eI4IKBXDhhx/SpuzKCjotqTMqDSxILA1fs21i5CSQpTNjUm9JEP9W3YFHwdIg
         c3d7VCwXza7lw9ZRuU5kk5VLJEzy+1RDMkW3zzOMciN04zNpRRuZLOGTwJbHX91fNe6I
         GpUQ==
X-Gm-Message-State: AOAM5339X2R02jigBxMXSjrKCTSl0/694zfc8WI08gzcvuMn3w1P1yn6
        UkPlD5Ce308zw5yjqwWhUV7LZA==
X-Google-Smtp-Source: ABdhPJykQhA773Y/RsqqBh6IkXbjxUAGr+2WNPNkmamwrqnCASrzuPNLdRBsNJk4iZWq6CDQhSD6fA==
X-Received: by 2002:a17:90a:950a:: with SMTP id t10mr5013648pjo.107.1599169872611;
        Thu, 03 Sep 2020 14:51:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h15sm3019108pfo.23.2020.09.03.14.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 14:51:11 -0700 (PDT)
Date:   Thu, 3 Sep 2020 14:51:10 -0700
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
        x86@kernel.org
Subject: Re: [PATCH v2 05/28] objtool: Add a pass for generating __mcount_loc
Message-ID: <202009031450.31C71DB@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-6-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-6-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:30PM -0700, Sami Tolvanen wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Add the --mcount option for generating __mcount_loc sections
> needed for dynamic ftrace. Using this pass requires the kernel to
> be compiled with -mfentry and CC_USING_NOP_MCOUNT to be defined
> in Makefile.
> 
> Link: https://lore.kernel.org/lkml/20200625200235.GQ4781@hirez.programming.kicks-ass.net/
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>

Hmm, I'm not sure why this hasn't gotten picked up yet. Is this expected
to go through -tip or something else?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
