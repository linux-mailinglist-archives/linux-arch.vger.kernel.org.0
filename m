Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A6E25CE02
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 00:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgICWpj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 18:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbgICWpe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 18:45:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184FC061246
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 15:45:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p37so3280899pgl.3
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 15:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LpH2+c3Q5/rnXgDQMsrsJ9HiSsfoyzj1qvyyccEruIs=;
        b=Zx5KJ4dvVR2kYJ0RF1K2y79qhIcjc7yrsCRJoTz5s2zCxiKL8II6gShD3dRiuI5JuE
         CAqlIg/RCYIqxwgBTCdJCoxlCyAR33IC7dws/kSOZM0OWTmWQqku5KG5vBN3wHaXWX2J
         L3kWlvlx6YmS4Z9tOt3VwHxiD169ei5sQPoz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LpH2+c3Q5/rnXgDQMsrsJ9HiSsfoyzj1qvyyccEruIs=;
        b=ZYgPQ5y8GOMMyk6DtIkTuBDD0fKUFn2JTP/04cgCOt4cwl7CiK5VBtm8chXYGi5lE0
         Jjl4OY/cgywAfSa8Vjzj/OShM/7eC9vBe+Scd5rI4fd+GIK2T19Br29l/1WUU/0tfV4m
         ceAujYK2hQHYPmm0IHbaV2sYF1TNW/SKYldFC11O4zEadYHQQ6M/bVULPvdcoyhqPk90
         W5Z6JMM01b6YGmCoC7wauz9WkbOOM1VX+aODoOWSSQVFcIxzudGpVJmAVf+1D/GztE7F
         FmPN2Kx733ZhmcN5ON2rYn/NHQv31ihfZyPf1CTKQg90NmZKMFhhACQrdUEiMBo3Yc7O
         +W9A==
X-Gm-Message-State: AOAM532h0esXNxLJlt7+s8lvl1OOR4+1M67vk88OeuXUFEKpxT2NsTRh
        kGQClE82sdcqI5YkRpeEmqPLxw==
X-Google-Smtp-Source: ABdhPJw+gsOOUY6Clu21aqvi2zeFtbK32caDaCf93/U25KjvZIefQe4UypsHJhKhOKzenMYzI/0+7Q==
X-Received: by 2002:a17:902:82c7:: with SMTP id u7mr1398150plz.240.1599173133340;
        Thu, 03 Sep 2020 15:45:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r123sm4320262pfc.187.2020.09.03.15.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:45:32 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:45:31 -0700
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
Subject: Re: [PATCH v2 24/28] KVM: arm64: disable LTO for the nVHE directory
Message-ID: <202009031545.42ECDC8F7F@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-25-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-25-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:49PM -0700, 'Sami Tolvanen' via Clang Built Linux wrote:
> We use objcopy to manipulate ELF binaries for the nvhe code,
> which fails with LTO as the compiler produces LLVM bitcode
> instead. Disable LTO for this code to allow objcopy to be used.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
