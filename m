Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5D825CDD9
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 00:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgICWnG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 18:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbgICWm7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 18:42:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E606C061246
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 15:42:59 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m5so3264520pgj.9
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QrnbZATBHBxQZ7fajeBTKOWCmjpG/tdsnBaMo8RMsl0=;
        b=arGEoVNcgRk6SvvgwhWybl2yTQQ/41JitWigdBdGhFS95Gmb9SWRyyuaVbLozcxhlL
         y6JEOwrroo7lJUf2OLWmcs3N8AyWgT7zx61RPK1c7lAmQb6YFg/HrUMlem7+hTwvS/bi
         td4g7TX1ItoN+b7bfyXxlkOCNCh28KvNVjWIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QrnbZATBHBxQZ7fajeBTKOWCmjpG/tdsnBaMo8RMsl0=;
        b=Rzg96XI/PoyyL9PXHUmAF1Vjcsg0At0sZFWnA3oE8JfXLtnlmwYvyHcpY/4jqD5E3k
         Gi/hoAHgLEkuar+nN8Bl0ILw0ba1l/Cr5i/TVutNpJKGsF6OULfU0Z4ghPZCuuSV3zJj
         KYEIwpjJ+PbY1ng6Q59qa9DJLaf3D1HTmZndaCd9N4hhk4ilntd9xRDe1h2LZW/O1hQX
         D0DoByA/nwXXAvq/kjS2xAZVnKN5vt+7opx+YYgLqUMr4fk4+5ksseUtRfGoAf35UkyQ
         rvqXeop7KHZzMFLAz6C1nEHq9UpJNjaZyJz+mlyEHoRTVarRQeFjXxqh/za96i1QGbxe
         90/A==
X-Gm-Message-State: AOAM530eLRPrA6GyrcjhUS+bXTOGpRS9nTX8cvzNerSQxpHzy2gvtE4+
        LWKYsPszP8ZoJIBXffjZwijTFw==
X-Google-Smtp-Source: ABdhPJy5mdmPjJfruWrIY+6IxKRglw5a/F5w2SGFD8qLkoS56YGpVx+oFe/zdag2OFqeajEXIFLqFA==
X-Received: by 2002:a17:902:9a45:: with SMTP id x5mr6151434plv.208.1599172978633;
        Thu, 03 Sep 2020 15:42:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r7sm4305639pfl.186.2020.09.03.15.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:42:57 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:42:56 -0700
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
Subject: Re: [PATCH v2 18/28] modpost: lto: strip .lto from module names
Message-ID: <202009031542.1F8B3012FD@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-19-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-19-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:43PM -0700, Sami Tolvanen wrote:
> With LTO, everything is compiled into LLVM bitcode, so we have to link
> each module into native code before modpost. Kbuild uses the .lto.o
> suffix for these files, which also ends up in module information. This
> change strips the unnecessary .lto suffix from the module name.
> 
> Suggested-by: Bill Wendling <morbo@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
