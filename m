Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93BD640CC8
	for <lists+linux-arch@lfdr.de>; Fri,  2 Dec 2022 19:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiLBSD3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 13:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbiLBSDZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 13:03:25 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAB260B6C
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 10:03:24 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id n3so1337636pfq.10
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 10:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Fj/GOmrzncgAG1HwiGCIj6uObETJ2A+WRaEGkSptgo=;
        b=fIdthOwAqz6rz4ph0qN2N5M8ImkazzFm8W3RM7IIh70xntOL1pP7mfPNyBUCnegxFH
         dwdRVH092Q/RsgF2xSXkKQJM+6+9V1QOBPhnaitJFsNkcWJL4wUuLpohsMEXKuSnaWBu
         kp+wTia6DbZGzzB2a2DGc2ZNYvhewKWVBOIourDOWPuhYjhUj+gDKH4o7ovOk4NSkK5a
         ZL+VE7WSOClVj2/p08efPZPfHfoqWChsY1BomaI4n1xxIuUhzZOT8HI87Dq7tNOzB4M3
         xWTvFDLZQ5qdDQDcd4tnxGKFQZWsVfsadritMvCGliMHfMNQZ+PaZzy94VLxDg/LvwNw
         1S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Fj/GOmrzncgAG1HwiGCIj6uObETJ2A+WRaEGkSptgo=;
        b=aWV98ERBV5oehTgYjOGHL2BIyLSmemphydNKbRjmq0//S0hhAbQkqU0ZIcSb60qISS
         7TTUkpO8YSZK1vAzxkyO6TgvEYBlnuveErKLdHa/xMQsd/sIPM6vlXCOsiTMonXT+cA8
         xEEt3ZCxfowN1Bde/zOc+W4oFQo8Y/v5rkf2c/k2GWv6Oke32pUYMozx9m8Z0Aa2Vt+/
         Q1YZVs5Mf8SUcoeB2EUqtA2tkrpfpcoPnKYjC2bsNsDHt9NESNMZWm8wdWlyHVpDNiem
         yMEzH88ZhH02+bp5NZ5sidZXRynEV6peu3DTXuvOrHgaZiCOokd6MAR6an6Z61jXZtl/
         B+yQ==
X-Gm-Message-State: ANoB5pmsRA6mtNmRflNyo526wAEehgGSMNOuxHoukSuxUWYpk/weG2k5
        QF8kMcZviAspj2N75GPmFmRF0w==
X-Google-Smtp-Source: AA0mqf6OKlfF860xpvjuMskcHd4UtSYgsGvzT6gTPKffFg+HpkwWymVJj1rCSlnbaq2p434WklJIgg==
X-Received: by 2002:a63:4b0f:0:b0:439:3b80:615d with SMTP id y15-20020a634b0f000000b004393b80615dmr47409964pga.255.1670004203619;
        Fri, 02 Dec 2022 10:03:23 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id j9-20020a654d49000000b0046ae5cfc3d5sm4331272pgt.61.2022.12.02.10.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:03:23 -0800 (PST)
Date:   Fri, 02 Dec 2022 10:03:23 -0800 (PST)
X-Google-Original-Date: Fri, 02 Dec 2022 10:03:08 PST (-0800)
Subject:     Re: [PATCH V2] selftests/vDSO: Add riscv getcpu & gettimeofday test
In-Reply-To: <20221103080451.1642500-1-guoren@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, guoren@kernel.org, shuah@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        haocheng.zy@linux.alibaba.com, han_mao@linux.alibaba.com,
        guoren@linux.alibaba.com, Paul Walmsley <paul.walmsley@sifive.com>,
        enh@google.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org, skhan@linuxfoundation.org
Message-ID: <mhng-d689ac9f-1a92-43a7-91b4-2be89c388e8d@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 03 Nov 2022 01:04:51 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@kernel.org>
>
> Enable vDSO getcpu & gettimeofday test for riscv. But only riscv64
> supports __vdso_gettimeofday and riscv32 is under development.
>
> VERSION
> {
>         LINUX_4.15 {
>         global:
>                 __vdso_rt_sigreturn;
>                 __vdso_gettimeofday;
>                 __vdso_clock_gettime;
>                 __vdso_clock_getres;
>                 __vdso_getcpu;
>                 __vdso_flush_icache;
>         local: *;
>         };
> }
>
> Co-developed-by: haocheng.zy <haocheng.zy@linux.alibaba.com>
> Signed-off-by: haocheng.zy <haocheng.zy@linux.alibaba.com>
> Suggested-by: Mao Han <han_mao@linux.alibaba.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Elliott Hughes <enh@google.com>
> ---
>  tools/testing/selftests/vDSO/vdso_test_getcpu.c       | 4 ++++
>  tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 3 +++
>  2 files changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
> index fc25ede131b8..1df5d057d79f 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_getcpu.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
> @@ -14,7 +14,11 @@
>  #include "../kselftest.h"
>  #include "parse_vdso.h"
>
> +#if defined(__riscv)
> +const char *version = "LINUX_4.15";
> +#else
>  const char *version = "LINUX_2.6";
> +#endif
>  const char *name = "__vdso_getcpu";
>
>  struct getcpu_cache;
> diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
> index 8ccc73ed8240..e411f287a426 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
> @@ -27,6 +27,9 @@
>  #if defined(__aarch64__)
>  const char *version = "LINUX_2.6.39";
>  const char *name = "__kernel_gettimeofday";
> +#elif defined(__riscv)
> +const char *version = "LINUX_4.15";
> +const char *name = "__vdso_gettimeofday";
>  #else
>  const char *version = "LINUX_2.6";
>  const char *name = "__vdso_gettimeofday";

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Looks like Shauh usually takes patches for this vdso selftest, but happy 
to take it through the RISC-V tree if that's easier.  Either way's fine 
with me, I'm leaving it in patchwork for now as a reminder.

Thanks!
