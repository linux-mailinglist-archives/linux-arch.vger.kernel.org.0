Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773D33383EA
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 03:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhCLCrH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 21:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhCLCqd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Mar 2021 21:46:33 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A1BC061765
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 18:46:32 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so10348900pjb.0
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 18:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EkKsbT/Be7JGL+mLJvho9bTta6ZuIDt4k2VfVYUMdas=;
        b=RAWK+vGcMZyK9BG6AxoJ0QzqwZIszAK9x1UrTKvNkNwXGVrYgWz8709/k2si8eBj1W
         qQrtwxdfwT+VTa3J8I5zf0r4FiHh18mN89nA+qArQh8jHq5MKYponYw4RmZRp77LRLoY
         uRCsSXXIj7eyg+c6rlvuq9CK91J3pIa9ABX44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EkKsbT/Be7JGL+mLJvho9bTta6ZuIDt4k2VfVYUMdas=;
        b=fd/wGUMBkz2+NTsFKsZ2y17z7SnUA+bS2UJ9/7+Setq8Z7YwcGA4Q1T5//dhEXG85X
         /QdrKnXIdV4TWXMobaZzczqJhispDZxtE+42/wHpg7foBHi1tysNpvTi1tjTGPOzJLJz
         uVGP2DHWrs0iqgdwC2w0p6lhtgFUfBOJqFu+wdLLQXXxh0vGdnOWwJPkzH8fSowA76jd
         ayKFaebESnMxhzOxeBh9tpmPpPgwo9JDMAhhQsiNkVGu/fzajUJGKtn0FZ7ZUhHc7fCi
         LmpNUbjqNteRJz0EplyTUayH3+k6ox7TQdiBBdQo7De+ryof/Gwx2p8AF1u7UkfUh3KC
         doUA==
X-Gm-Message-State: AOAM531OwUu87RmxgHrcLxt4KTTJzZZQyjcD8/LWi10ERg2lkAo+nWIy
        5+RRufFyE86dPFfokU/1IYr/kg==
X-Google-Smtp-Source: ABdhPJy0U15bZZKnq24TxTodYpzvMU/ZPG0N12wONWG2T01eoVgkhya4x6f+sSafSsZdieWkf5PVjQ==
X-Received: by 2002:a17:90b:284:: with SMTP id az4mr2741623pjb.12.1615517191648;
        Thu, 11 Mar 2021 18:46:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v126sm3540349pfv.163.2021.03.11.18.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:46:31 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:46:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/17] arm64: use __pa_function
Message-ID: <202103111846.49925C94E@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-14-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-14-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:15PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function address
> references with the address of the function's CFI jump table
> entry. This means that __pa_symbol(function) returns the physical
> address of the jump table entry, which can lead to address space
> confusion as the jump table points to the function's virtual
> address. Therefore, use the __pa_function() macro to ensure we are
> always taking the address of the actual function instead.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
