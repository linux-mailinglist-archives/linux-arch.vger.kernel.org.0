Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7193012F5
	for <lists+linux-arch@lfdr.de>; Sat, 23 Jan 2021 05:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbhAWENe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jan 2021 23:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbhAWENM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jan 2021 23:13:12 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8690BC06178B
        for <linux-arch@vger.kernel.org>; Fri, 22 Jan 2021 20:12:32 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q7so5193239pgm.5
        for <linux-arch@vger.kernel.org>; Fri, 22 Jan 2021 20:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=rfxqzONqLpenH9bMcTSEoRtSy4r+OTMclT611uQQPw0=;
        b=VYOj8q7y3B1Ci/zXV0TKKQdP+Hr4DW7yRsr1E+oiVJMPmFipjS5UZ8xLl2xoHoz/6B
         jkpCwgPiLIZPoGfOi1wN88wt16jBRvoyvro7VvrIPcH4RTJznQoHQmoB2t8HyrxAaJdZ
         HBhFM+SE5uT3rPuNDZ63XGBOHfrbXdGCrMh+WmJzIou1s39XhI+QRXq2zuC7lcQ0WAEq
         +J2EBBfVHpHbKs6R2YJuQHl6VFRabnTwOH35OE4IYc02CQ9CIGb17Ob6QmJQaoizK2CX
         qmyOJqbeCl8AsonG5sk05tyhobY+J8YKqRp8zWdSTNaaYU7FnZoryWgNkEnc2zVWMeFD
         MIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=rfxqzONqLpenH9bMcTSEoRtSy4r+OTMclT611uQQPw0=;
        b=g3ujzRnR4xvymkIxsVXIiqD5RSlKScC2ldB3p04lM2LHJQL72KYFTUwQ5vJP818Z5p
         R8hODi0tgMFY+0bhtqSo5Lt6CU7ZU3eb+GjhOCdGCa83dodTv9B6Tb8Y/GRjekoEmX/L
         xeMhzW6gbBucoBmeTOCkGTLTRJRIDaUTMEkFsj9gRCjNgpU+5FV/Z0v84PREhpX9oXsJ
         IvSLRqbx8cr6kQTqF5pUhH5UXTtkQsWROqPGQzGaprqr/177FfoPiPiBTxgn/9P96n/m
         QGcgRd0WUb4uXRu84/zHOKPdCMr8F5fPQ01r0Zl7jIdMzfdxGk6o5R3BpHsO3wG1x5GN
         Pfmg==
X-Gm-Message-State: AOAM531kBRvCTcQKQwh9gRC7O2YY+7xFSGWYuJPh0QGT3w8SV3U5i/Jg
        4H+abPnEJQPcYHSO7xWvUpx4Ng==
X-Google-Smtp-Source: ABdhPJz23uPwWexptJVrp5X0oeJBb+aQPxkhO88fX4JWNnDnVCTuobkNxuBQWZrcK1ekbZ/uQmCkcQ==
X-Received: by 2002:a62:2aca:0:b029:1bb:4349:f889 with SMTP id q193-20020a622aca0000b02901bb4349f889mr8177532pfq.26.1611375151785;
        Fri, 22 Jan 2021 20:12:31 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f15sm10628173pja.24.2021.01.22.20.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 20:12:30 -0800 (PST)
Date:   Fri, 22 Jan 2021 20:12:30 -0800 (PST)
X-Google-Original-Date: Fri, 22 Jan 2021 20:12:28 PST (-0800)
Subject:     Re: [PATCH v15 03/11] riscv/Kconfig: make direct map manipulation options depend on MMU
In-Reply-To: <20210120180612.1058-4-rppt@kernel.org>
CC:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        luto@kernel.org, Arnd Bergmann <arnd@arndb.de>, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, david@redhat.com,
        elena.reshetova@intel.com, hpa@zytor.com, mingo@redhat.com,
        jejb@linux.ibm.com, kirill@shutemov.name, willy@infradead.org,
        mark.rutland@arm.com, rppt@linux.ibm.com, rppt@kernel.org,
        mtk.manpages@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        peterz@infradead.org, rick.p.edgecombe@intel.com, guro@fb.com,
        shakeelb@google.com, shuah@kernel.org, tglx@linutronix.de,
        tycho@tycho.ws, will@kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, lkp@intel.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rppt@kernel.org
Message-ID: <mhng-5cbc9b30-ac9a-4748-bf12-8f0de4c89f79@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 20 Jan 2021 10:06:04 PST (-0800), rppt@kernel.org wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> ARCH_HAS_SET_DIRECT_MAP and ARCH_HAS_SET_MEMORY configuration options have
> no meaning when CONFIG_MMU is disabled and there is no point to enable them
> for the nommu case.
>
> Add an explicit dependency on MMU for these options.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  arch/riscv/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d82303dcc6b6..d35ce19ab1fa 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -25,8 +25,8 @@ config RISCV
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_MMIOWB
>  	select ARCH_HAS_PTE_SPECIAL
> -	select ARCH_HAS_SET_DIRECT_MAP
> -	select ARCH_HAS_SET_MEMORY
> +	select ARCH_HAS_SET_DIRECT_MAP if MMU
> +	select ARCH_HAS_SET_MEMORY if MMU
>  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

LMK if you want this to go in via the RISC-V tree, otherwise I'm going to
assume it's going in along with the rest of these.  FWIW I see these in other
architectures without the MMU guard.

Thanks!
