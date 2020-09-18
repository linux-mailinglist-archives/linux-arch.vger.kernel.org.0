Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF56270843
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 23:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIRV3j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 17:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgIRV3j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 17:29:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB5EC0613CF
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 14:29:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f1so3633146plo.13
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 14:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GaeOhHfh8L1DCmfaELuYzcrF6n6HIXLIYRNTzqsV79Y=;
        b=W+/RKJ9pTVfHlLkwso1szh6HtM1ljwgfll2m1S7UpWBfhGNOhcAgS0vcics0UCB6P6
         dN86cdQ1w9MJuw6LvS3fM80dVq9dvH5tMXxpAqqbGZHk658zN870WIKFcsCTayCfDtNQ
         T7NafpHvlBEzNZ5MQFycOCV7aKSjbwjKdKCPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GaeOhHfh8L1DCmfaELuYzcrF6n6HIXLIYRNTzqsV79Y=;
        b=THiARfU1pqBSwtX6b1HkTqSj9pFPhVpqwhb0bhE6i/YuQiLCxPpm/kLCtXdVrdaAsG
         9USK+ENfcVeyG95Py6Aoi56k0t/dg+7q3v0jdN7EgXhjkgmqkbz+NZG3hdnZKIACZhSa
         47zt8ONBUqSVT4584AyRyP1szdDvMtH9i9ycsAGUu2XZtFTt3Pkrto3aRne8nxaaqQ2O
         lD5GP59SEbh5c0d8bh8uAYwy33pThoE8v67yw4kPINp/a1MoGtYc4ePfAkTWG9WTDxlf
         Yr6Eo8fJFEqgwJEwseA+Ln1wdKUK4LOH7Duix56Lpka8KpedZeaf6ckcbdpwxxzGxiyq
         3aCg==
X-Gm-Message-State: AOAM530y1H7EOtEXFEIUTClpJIV3Up3o7HYoI4JogMGbUqtiaLuumJ+d
        MQN4jSMloWBVR/+F4fXC/hAzRQ==
X-Google-Smtp-Source: ABdhPJyRQsmmFdjwcGkpqBzOOW1CFrolZnNpgZgaeJg1rXVSbKFTb9+lQpAZIZvZVlks1h2iMqNz4w==
X-Received: by 2002:a17:90a:ad48:: with SMTP id w8mr14636473pjv.179.1600464578722;
        Fri, 18 Sep 2020 14:29:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l188sm4167409pfl.200.2020.09.18.14.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:29:37 -0700 (PDT)
Date:   Fri, 18 Sep 2020 14:29:37 -0700
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
Subject: Re: [PATCH v3 17/30] init: lto: ensure initcall ordering
Message-ID: <202009181428.3C45B57DA@keescook>
References: <20200918201436.2932360-1-samitolvanen@google.com>
 <20200918201436.2932360-18-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918201436.2932360-18-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 01:14:23PM -0700, Sami Tolvanen wrote:
> With LTO, the compiler doesn't necessarily obey the link order for
> initcalls, and initcall variables need globally unique names to avoid
> collisions at link time.
> 
> This change exports __KBUILD_MODNAME and adds the initcall_id() macro,
> which uses it together with __COUNTER__ and __LINE__ to help ensure
> these variables have unique names, and moves each variable to its own
> section when LTO is enabled, so the correct order can be specified using
> a linker script.
> 
> The generate_initcall_ordering.pl script uses nm to find initcalls from
> the object files passed to the linker, and generates a linker script
> that specifies the same order for initcalls that we would have without
> LTO. With LTO enabled, the script is called in link-vmlinux.sh through
> jobserver-exec to limit the number of jobs spawned.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Thanks for the update; using jobserver-exec looks much better for
controlling the build resources. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
