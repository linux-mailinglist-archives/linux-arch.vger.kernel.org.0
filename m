Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5E634A09C
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 05:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhCZEfO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 00:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhCZEfD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2021 00:35:03 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB3FC0613DE
        for <linux-arch@vger.kernel.org>; Thu, 25 Mar 2021 21:35:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 32so3797208pgm.1
        for <linux-arch@vger.kernel.org>; Thu, 25 Mar 2021 21:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o6ZYIXdd1/vAExcYXFT6dANx8GnJNuATCIGW/s9Pah8=;
        b=EgADIZi7ayX4VsRKHlpPjC8PmfC1eA96LzdW+fEKlUeEcGISxNIPEefy6IgU17jWkb
         TL5UUqttP2GINo0lHOW6LYzOTm46xj04MRSK0+ETn9w4VQhoFNvSZ1IC6mTECf/Ohmun
         M/ZXjbRfr5A+Jm36wv4xIXSdlfdyBR1izqmz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o6ZYIXdd1/vAExcYXFT6dANx8GnJNuATCIGW/s9Pah8=;
        b=VtUKooHVmjqKnzp7P72yqsa+xGzbnTVkDsI8Nwz/tVes1SUnRu9GIeeEQb7kMk+/xZ
         Yt7GXXP6tePTCTnhHoDuApDbqGHEb+bwQza3iQtP8tloKmMOsQOG7y4RmpoxCmkP+5IV
         GikmsDtROs1XGpRtl1NBCi/lZHzSYk0Itg+7p5xrhy+/4iX20a4cG9dRd1U6NK9lrl7L
         tIpi7bj/RO7rmGses6340gRD9YtzLxrObMLCEcohoRRKt/bD1qRvlbTUvAK3TrKWqVlF
         rod/Vq0eqlVuvdcp03hF5fR9sEymUTW5n49pxaJwU4IoJeCMtBYs4D7xxZ2VvM2zjWga
         f4tA==
X-Gm-Message-State: AOAM530L9yJXKHc1spCBrPCbg9+jf1gBJSJ0ATAq0qkSpbRjv4dA7x7l
        W24ACRRi79FVl8/0F30faDHSLQ==
X-Google-Smtp-Source: ABdhPJyx+C6gTpwCe49uMztK4X6wt+I8l9KdCax1Eia8cag9mJ0mh/5Csm5HLJjBwIAOAJCT/Ew/PQ==
X-Received: by 2002:aa7:86d9:0:b029:1ef:4f40:4bba with SMTP id h25-20020aa786d90000b02901ef4f404bbamr10920480pfo.54.1616733302846;
        Thu, 25 Mar 2021 21:35:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l22sm7520464pjl.14.2021.03.25.21.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 21:35:02 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:35:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/17] kthread: use WARN_ON_FUNCTION_MISMATCH
Message-ID: <202103252134.BCC32ECC9@keescook>
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323203946.2159693-7-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 23, 2021 at 01:39:35PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, a callback function passed to
> __kthread_queue_delayed_work from a module points to a jump table
> entry defined in the module instead of the one used in the core
> kernel, which breaks function address equality in this check:
> 
>   WARN_ON_ONCE(timer->function != ktead_delayed_work_timer_fn);
> 
> Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
> when CFI and modules are both enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
