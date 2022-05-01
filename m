Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6825162A5
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 10:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244197AbiEAIXC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 04:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbiEAIXA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 04:23:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF67165B5;
        Sun,  1 May 2022 01:19:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id h1so10177680pfv.12;
        Sun, 01 May 2022 01:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ht4OT46ig/EoBxOChlTP61FKZFFqQrZnU4j/ancIN4w=;
        b=RaUHoOs4IxM7ZejCqv2Mm0/t+Kj/zIoPdDO/KoYKDaMzekxBRZMVaXZc5jP3KpwQtO
         FsjhpotpWJdP8DRQZ6jhqY1n1puCZA4A6k/jM7NmLzo+iYxpBpIWe1YomRovG5dF4SVK
         CWLiwCSM0AUT9AYfKcEttIDmqAv3aDLku29KvIdK/dam5MKaxd/Y5dJFUfiPMKX/Iawj
         Eqjg91hTM5AITg4Vl92S8PnyxsY7zqK/wQQI1DgTP40qpPQfb8B0BUw8CJwZl5zBDQoK
         1VByqLpPkF8Lj+Ug+QugNh3LJvgrUGwYb/HRRElxr4fSOPxFj1zUMgj/wWapabSBZ9Q4
         eAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ht4OT46ig/EoBxOChlTP61FKZFFqQrZnU4j/ancIN4w=;
        b=zHZkjHZ0BkQ9ndwwSr8ZeR7ZK+WzHBt4Qmgahz4RXOeOpv2TfD5++E68FMQ3vpwc1H
         EcB68HWXetoctWo7OPFdj2jXbNxZHuVEljVHXVugNWJXCynggXDYfARBDJyKEMJgFhoj
         YgBzrAsRLTdl97ylUE2f3r6M14FLX+UV8gRvreZC8fKxqXr92uehSTN02pb19Xg8WiTc
         xvbQJgsnBcELLhRLHNmBdP0HMUBE/TeWJu/caDxedfA/C1CJCSrsQryJ7glN9/ZlNChN
         MOFmsLyyjt8qUfND96jPhNXEYAl68GTbCe4tZGtCssq4FzZ9OVIqh0StyFpHwYB047ne
         cU6A==
X-Gm-Message-State: AOAM531rJd8c76z51b6sEjKhcZnY1pvqw68wBMRC7mGOUs3BF/AB+NCc
        WlYdAoumdlVZvk0lLxE3mnM=
X-Google-Smtp-Source: ABdhPJz4tKdxnHrISm1J9ZdG5TTXqgLhMjlP15t9o+ZFvO/yHSlN2lzkjC11Jv7dDdvTnTlBFfKWDg==
X-Received: by 2002:a63:40c7:0:b0:39d:8c29:2f57 with SMTP id n190-20020a6340c7000000b0039d8c292f57mr5541298pga.202.1651393175716;
        Sun, 01 May 2022 01:19:35 -0700 (PDT)
Received: from localhost (subs10b-223-255-225-231.three.co.id. [223.255.225.231])
        by smtp.gmail.com with ESMTPSA id n9-20020a170903110900b0015e8d4eb1c1sm2515905plh.11.2022.05.01.01.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 01:19:35 -0700 (PDT)
Date:   Sun, 1 May 2022 15:19:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V9 00/22] arch: Add basic LoongArch support
Message-ID: <Ym5ClK4vg4nodfYV@debian.me>
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430090518.3127980-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 30, 2022 at 05:04:54PM +0800, Huacai Chen wrote:
> Huacai Chen(24):
>  Documentation: LoongArch: Add basic documentations.
>  Documentation/zh_CN: Add basic LoongArch documentations.
>  LoongArch: Add elf-related definitions.
>  LoongArch: Add writecombine support for drm.
>  LoongArch: Add build infrastructure.
>  LoongArch: Add CPU definition headers.
>  LoongArch: Add atomic/locking headers.
>  LoongArch: Add other common headers.
>  LoongArch: Add boot and setup routines.
>  LoongArch: Add exception/interrupt handling. 
>  LoongArch: Add process management.
>  LoongArch: Add memory management.
>  LoongArch: Add system call support.
>  LoongArch: Add signal handling support.
>  LoongArch: Add elf and module support.
>  LoongArch: Add misc common routines.
>  LoongArch: Add some library functions.
>  LoongArch: Add PCI controller support.
>  LoongArch: Add VDSO and VSYSCALL support.
>  LoongArch: Add efistub booting support.
>  LoongArch: Add zboot (compressed kernel) support.
>  LoongArch: Add multi-processor (SMP) support.
>  LoongArch: Add Non-Uniform Memory Access (NUMA) support.
>  LoongArch: Add Loongson-3 default config file.
> 

I have skimmed through patch descriptions, and I see patch 05-24/24 use
descriptive mood (This patch adds what...). Please write them in
imperative mood instead.

-- 
An old man doll... just what I always wanted! - Clara
