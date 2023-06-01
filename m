Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B27191FB
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 06:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjFAEsg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 00:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjFAEsa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 00:48:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A0A189;
        Wed, 31 May 2023 21:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7712964096;
        Thu,  1 Jun 2023 04:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34F8C4339E;
        Thu,  1 Jun 2023 04:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685594905;
        bh=bpqEso1iBcRwWgH0EcZm9MZonL+OTWvGWjN3oOqfL1w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gKakW1h8oa90rkF3M7EI+9OBVEuVcjWWSjlavShvaKptFWd2NUCt6pqOZBbSb4MKZ
         RIBZQkeb1qnxSVKEhVRFKJnhXoYotMkI+71hTqw46FgNbgJTgktrKzrjWwHZgwAl9Q
         /R8IFbydSpO/spodcjO2FQPYuJ9F/7shbrERilMdX173I+kmt+wbG3H7yaxFVYr6oj
         Qb1I645gOVRnJpY24i14hvjeuUNuPsQhp4nWFHghze9va3PVvjuhVk7vaSWDd58erD
         3iW+2Efke6L3vxQuXi8dU/9nJumrMLOCh9mwf3UccuUiCaxI5AG/gqMhZosptji/HC
         IVazESpNVRHcw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f3edc05aa5so325794e87.3;
        Wed, 31 May 2023 21:48:25 -0700 (PDT)
X-Gm-Message-State: AC+VfDw0uHwehbIWl5YOH6YNDHA3w1z8H2zP9GR/dPcuNMkKw+2CnAEI
        j1cvQJTkXXMrp4gMuuW923FLqUTZvCU7lTkMirQ=
X-Google-Smtp-Source: ACHHUZ5nc8fnsEt7aFp9LSrVOxwu3lhK/EnxOMe/+pP9nT7UCS7gXmjq9GCIqt+nrEMUYCCVLZtKNU5xYwooOCJttK8=
X-Received: by 2002:a2e:9ed3:0:b0:2af:2231:94b0 with SMTP id
 h19-20020a2e9ed3000000b002af223194b0mr3332988ljk.19.1685594903793; Wed, 31
 May 2023 21:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230523165502.2592-1-jszhang@kernel.org> <20230523165502.2592-2-jszhang@kernel.org>
In-Reply-To: <20230523165502.2592-2-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 1 Jun 2023 12:48:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT4=i+SQi7ODCuyndTQWJjm8hWwBxEOE_C_iSXyRfDfGA@mail.gmail.com>
Message-ID: <CAJF2gTT4=i+SQi7ODCuyndTQWJjm8hWwBxEOE_C_iSXyRfDfGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] riscv: move options to keep entries sorted
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 24, 2023 at 1:10=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> Recently, some commits break the entries order. Properly move their
> locations to keep entries sorted.
Acked-by: Guo Ren <guoren@kernel.org>

>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 348c0fa1fc8c..8f55aa4aae34 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -101,6 +101,11 @@ config RISCV
>         select HAVE_CONTEXT_TRACKING_USER
>         select HAVE_DEBUG_KMEMLEAK
>         select HAVE_DMA_CONTIGUOUS if MMU
> +       select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPOR=
TS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
> +       select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> +       select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> +       select HAVE_FUNCTION_GRAPH_TRACER
> +       select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
>         select HAVE_EBPF_JIT if MMU
>         select HAVE_FUNCTION_ARG_ACCESS_API
>         select HAVE_FUNCTION_ERROR_INJECTION
> @@ -110,7 +115,6 @@ config RISCV
>         select HAVE_KPROBES if !XIP_KERNEL
>         select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>         select HAVE_KRETPROBES if !XIP_KERNEL
> -       select HAVE_RETHOOK if !XIP_KERNEL
>         select HAVE_MOVE_PMD
>         select HAVE_MOVE_PUD
>         select HAVE_PCI
> @@ -119,6 +123,7 @@ config RISCV
>         select HAVE_PERF_USER_STACK_DUMP
>         select HAVE_POSIX_CPU_TIMERS_TASK_WORK
>         select HAVE_REGS_AND_STACK_ACCESS_API
> +       select HAVE_RETHOOK if !XIP_KERNEL
>         select HAVE_RSEQ
>         select HAVE_STACKPROTECTOR
>         select HAVE_SYSCALL_TRACEPOINTS
> @@ -142,11 +147,6 @@ config RISCV
>         select TRACE_IRQFLAGS_SUPPORT
>         select UACCESS_MEMCPY if !MMU
>         select ZONE_DMA32 if 64BIT
> -       select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPOR=
TS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
> -       select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> -       select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> -       select HAVE_FUNCTION_GRAPH_TRACER
> -       select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
>
>  config CLANG_SUPPORTS_DYNAMIC_FTRACE
>         def_bool CC_IS_CLANG
> --
> 2.40.1
>


--=20
Best Regards
 Guo Ren
