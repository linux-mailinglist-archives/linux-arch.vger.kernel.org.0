Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3722EE7F1
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jan 2021 22:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbhAGVvq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jan 2021 16:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbhAGVvp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jan 2021 16:51:45 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC16C0612F6
        for <linux-arch@vger.kernel.org>; Thu,  7 Jan 2021 13:51:05 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b5so4897446pjl.0
        for <linux-arch@vger.kernel.org>; Thu, 07 Jan 2021 13:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yYl0v+xaEIAu5r6/bYBSilTtfXXwd7aNC1GvRalHHZo=;
        b=Ve/7Nd5INnaEy8CbPNdKMJtPRPO9+pgspz1Y9n4YGnNTDagRFwC9JAeZesbIgkY0CY
         K7lTK6VzA9sgb2tzfHvxcjddJuJb5Pf5JprdA3W1L/QOW+tZhGsXRrqxHYl04UdthbX1
         sh6t+OvYBaxi65UWj5ZWyvLCHLY0m4LAc8ypI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yYl0v+xaEIAu5r6/bYBSilTtfXXwd7aNC1GvRalHHZo=;
        b=huxi4xG3IR9U2f+USnXaolP0WqJqbqGOiDfPTp+/y+wAZAOhKHGmdSULKVBmN7frvt
         /x6OQAd0myU9D91W8e2E06GMYv4s1PYus+ypRRtx26lsl6n+ishW37ne12NfWc5CS3M+
         Yv3SlYeTER6L+npNg29/BLOq5BCOu9MHa2UnuF+7ZHl+WgmB+34pkkT6g0jOBAbIEr+p
         cJlydmhwUhuNCsYDeZEPBCQcpTsKAJ13shPnNcEDVFyUkcBv127BFUjg2LctsXsY/z4p
         gxBlG5eFdXJfCDY4RTeae5psKGt1jm9oGdxhLNyMsS02+oOC1A/HOsPQdvzGtMeHjT06
         deYw==
X-Gm-Message-State: AOAM532nHORO9lVMc7UkX5lPxVLxnbij2Gt7f06134t23dDPQXhXW52T
        jnVa4ojWOUZrtm0Er6+CZMum+g==
X-Google-Smtp-Source: ABdhPJxYv+lP//sBpYmfkVMn1iS79fb/o6RV6xjZzmCD1ZIixlRuX7X1PLyc5ytcCwwArwa3XEcOow==
X-Received: by 2002:a17:902:be11:b029:da:ba30:5791 with SMTP id r17-20020a170902be11b02900daba305791mr788751pls.13.1610056265144;
        Thu, 07 Jan 2021 13:51:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v1sm7737287pga.63.2021.01.07.13.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:51:04 -0800 (PST)
Date:   Thu, 7 Jan 2021 13:51:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Pei Huang <huangpei@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Corey Minyard <cminyard@mvista.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, stable@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v4 mips-next 6/7] vmlinux.lds.h: catch compound literals
 into data and BSS
Message-ID: <202101071350.B643907EE@keescook>
References: <20210107123331.354075-1-alobakin@pm.me>
 <20210107132010.463129-1-alobakin@pm.me>
 <20210107132010.463129-3-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132010.463129-3-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 07, 2021 at 01:20:55PM +0000, Alexander Lobakin wrote:
> When building kernel with LD_DEAD_CODE_DATA_ELIMINATION, LLVM stack
> generates separate sections for compound literals, just like in case
> with enabled LTO [0]:
> 
> ld.lld: warning: drivers/built-in.a(mtd/nand/spi/gigadevice.o):
> (.data..compoundliteral.14) is being placed in
> '.data..compoundliteral.14'
> ld.lld: warning: drivers/built-in.a(mtd/nand/spi/gigadevice.o):
> (.data..compoundliteral.15) is being placed in
> '.data..compoundliteral.15'
> ld.lld: warning: drivers/built-in.a(mtd/nand/spi/gigadevice.o):
> (.data..compoundliteral.16) is being placed in
> '.data..compoundliteral.16'
> ld.lld: warning: drivers/built-in.a(mtd/nand/spi/gigadevice.o):
> (.data..compoundliteral.17) is being placed in
> '.data..compoundliteral.17'
> 
> [...]
> 
> Handle this by adding the related sections to generic definitions
> as suggested by Sami [0].
> 
> [0] https://lore.kernel.org/lkml/20201211184633.3213045-3-samitolvanen@google.com
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Suggested-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
