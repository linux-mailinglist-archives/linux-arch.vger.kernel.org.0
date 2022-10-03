Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8739B5F2FC2
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJCLjN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 07:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJCLjH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 07:39:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CC81233A2;
        Mon,  3 Oct 2022 04:39:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2460139F;
        Mon,  3 Oct 2022 04:39:12 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.80.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 285553F67D;
        Mon,  3 Oct 2022 04:39:02 -0700 (PDT)
Date:   Mon, 3 Oct 2022 12:38:59 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zouyipeng@huawei.com,
        bigeasy@linutronix.de, David.Laight@aculab.com,
        chenzhongjin@huawei.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH V6 04/11] compiler_types.h: Add __noinstr_section() for
 noinstr
Message-ID: <YzrJ0wQxWfjWCxhQ@FVFF77S0Q05N>
References: <20221002012451.2351127-1-guoren@kernel.org>
 <20221002012451.2351127-5-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002012451.2351127-5-guoren@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 01, 2022 at 09:24:44PM -0400, guoren@kernel.org wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> And it will be extended for C entry code.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  include/linux/compiler_types.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 4f2a819fd60a..e9ce11ea4d8b 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -227,9 +227,11 @@ struct ftrace_likely_data {
>  #endif
>  
>  /* Section for code which can't be instrumented at all */
> -#define noinstr								\
> -	noinline notrace __attribute((__section__(".noinstr.text")))	\
> -	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
> +#define __noinstr_section(section)				\
> +	noinline notrace __section(section) __no_profile	\
> +	__no_kcsan __no_sanitize_address __no_sanitize_coverage
> +
> +#define noinstr __noinstr_section(".noinstr.text")

One thing proably worth noting here is that while KPROBES will avoid
instrumenting `.noinstr.text`, that won't happen automatically for other
__noinstr_section() sections, and that will need to be inhibited through other
means (e.g. the kprobes blacklist, explicit NOKPROBE_SYMBOL() annotation, or
otherwise).

Thanks,
Mark.
