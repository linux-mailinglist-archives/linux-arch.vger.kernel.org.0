Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F543384A8
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 05:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhCLEbN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 23:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhCLEbA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Mar 2021 23:31:00 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A6AC061761;
        Thu, 11 Mar 2021 20:31:00 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id by2so3695545qvb.11;
        Thu, 11 Mar 2021 20:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j5mqxb2fJvI18WxMVykNNWwtGK4f4IdAZVdlsREXq2A=;
        b=t3OnvI3+xdtmiQNGZYbtyw43YCbTK6k3T2/7/VrtGwPTvV6NVnEG5NcbH2zMkRl5SL
         rTpnEF0W91oi+A/6qWQjK6l4usDXIaVyR92Mo/bK+7+tAdCGg3vG1+fcMW+doVhm6/er
         gRzOrh/T9PwfECFY+lR/2AVyEF6ljzJiWPAh5guzrSg4XBFhb5+ywGA3hVFaC9ePhrRd
         tThT8zgVaCnOyFPSgIQQKgTn0mo7cLRrnrtmUaGY5ZdQeBOzok1dfKcnBwTQYqL4ZI9L
         jBACFbNcRpcwLZGli3Fz3xe9D4AOLMH7A0RJYsUV4ibIVEvDmO2TVa/5FZj1pMOuUcUP
         jRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j5mqxb2fJvI18WxMVykNNWwtGK4f4IdAZVdlsREXq2A=;
        b=b5KxpfEgGTWXUA4CGOjZW3GjspV9W0PLOOzA8SgK3WQBraXlXUoTtwPsBj1vtU5uOo
         XvzVchAdQ92CSl6KWnR/G6gsoyNX2pyC0VJ8r5eqKzeuuwwLUNnmyqByHN4u74v+saOU
         OxahhFqgre6iwFnpb0EghxZ0zNnXvZA+eU98tWE08f3UaQLdkBiQ6jBuDGJBG1HwDvGS
         /Ix44OR5hOjoW2/ztjdEDtmn/qHD0G9I8SnUZLZRgcAokKG19+RzA5qkeCDTpiEw2dRX
         gfTq2AYREclOnnOAIdY4nUhMVKtYyS9+giga1hZT6wuTQLHZ1oJG2NY5PpPcJrTIleEl
         T4vw==
X-Gm-Message-State: AOAM533ad/ZCkvqm6jzT13WNMNEQjOxORRkWZSAddrswhDOvOPpURei2
        MZVFwANiYpTr9he4EpljnurffO9cWR8=
X-Google-Smtp-Source: ABdhPJwa8RuHIuqTiEI8+dfw2OazKTk2V6cz9i/XK+FP+De8yfp3HLruKdvg5xzlrBrYGYVuw2pu3A==
X-Received: by 2002:a0c:8f1a:: with SMTP id z26mr10220826qvd.51.1615523459297;
        Thu, 11 Mar 2021 20:30:59 -0800 (PST)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id g7sm3263894qti.20.2021.03.11.20.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 20:30:58 -0800 (PST)
Date:   Thu, 11 Mar 2021 20:30:57 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 04/14] lib: introduce BITS_{FIRST,LAST} macro
Message-ID: <20210312043057.GA137474@yury-ThinkPad>
References: <20210218040512.709186-1-yury.norov@gmail.com>
 <20210218040512.709186-5-yury.norov@gmail.com>
 <b371c94c-7480-5af4-d2bd-481436f535eb@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b371c94c-7480-5af4-d2bd-481436f535eb@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 18, 2021 at 11:51:43PM +0100, Rasmus Villemoes wrote:
> On 18/02/2021 05.05, Yury Norov wrote:
> > BITMAP_{LAST,FIRST}_WORD_MASK() in linux/bitmap.h duplicates the
> > functionality of GENMASK(). The scope of there macros is wider
> > than just bitmap. This patch defines 4 new macros: BITS_FIRST(),
> > BITS_LAST(), BITS_FIRST_MASK() and BITS_LAST_MASK() in linux/bits.h
> > on top of GENMASK() and replaces BITMAP_{LAST,FIRST}_WORD_MASK()
> > to avoid duplication and increase the scope of the macros.
> > 
> 
> Please include some info on changes in generated code, if any. When the
> parameter to the macro is a constant I'm sure it all folds to a
> compile-time constant either way, but when it's not, I'm not sure gcc
> can do the same optimizations when the expressions become more complicated.

After applying all patches till "tools: introduce SMALL_CONST() macro",
there's no visible changes in code generation:

scripts/bloat-o-meter vmlinux.before vmlinux
add/remove: 1/2 grow/shrink: 2/0 up/down: 17/-16 (1)
Function                                     old     new   delta
ethtool_get_drvinfo                          900     908      +8
e843419@0cf2_0001309d_7f0                      -       8      +8
vermagic                                      48      49      +1
e843419@0d45_000138bb_f68                      8       -      -8
e843419@0cc9_00012bce_198c                     8       -      -8
Total: Before=26092016, After=26092017, chg +0.00%

The build is arm64, and the compilerr is:
aarch64-linux-gnu-gcc (Linaro GCC 7.3-2018.05) 7.3.1 20180425
