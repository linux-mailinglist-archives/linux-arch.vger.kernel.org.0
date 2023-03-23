Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF06C5B7F
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 01:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCWAnW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 20:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCWAnV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 20:43:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BED35B5;
        Wed, 22 Mar 2023 17:43:21 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id l14so12176643pfc.11;
        Wed, 22 Mar 2023 17:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679532201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryXXnmIeAtrWfMN7Ri1B53r6iw4ZKcLWFN/AVr6shlQ=;
        b=BDwRp2yXM3s6qg8QiWi2RAo18onjprMVNuzzF8fFzrj3rQOuhHHVLZ3GZMyJvzfzan
         cUwoEOeul2KaacLewByJ68nIpY5AiWyGx6hKe2wk/W7OHDA9l8Fq82nQQjvaK3qNTPD2
         VKMrlOgtbVeGv7IQZJP7310M+smRR8UD+RCkWF0WyBB8okjTi4dhQc68Hj1YoT/Z77v3
         4AZOQCVp5NikmgEz8D9MVXMCc0+cs7tvrs7rzLcV5n9m3C1MaqEx8B+JUU8T3gOpyRxL
         bgoalYgoUu9vxCK3qJVius2pWYEsmbdKjwceUtXkrHczHAo9gnZH/1O1oqjgxd1r+ax/
         Wh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679532201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryXXnmIeAtrWfMN7Ri1B53r6iw4ZKcLWFN/AVr6shlQ=;
        b=ciNyFZ/PBpYUDWCrqZ1or89jzDDcxaOYvKAcNPLSFQ7vxnaXWDtXCieNo0JUBJRkIR
         Y1VC+e/ID2tBusK+TaD9RH1fjjnPcRrBRUqAylMfX1pzxqhY+5tC38EP7rAjIU9p2j+y
         9y74X8DQ8Q9TmGQ0u4ooiyln90WsyW8lCNwa+YJMbjYoPjMqIjibEL+j/8ymG3o5WADd
         xhEkHv51EXp1Sz/QqHcfKnJbiPewsZFJ2ZfNNsAdVlIXTT4ez14Nuu1iYh/0V9D5zYdI
         AhkiKHd5m7TGZadp7Fdijsmizg1cxJ9OPBLEi1NZa2mybSqoPb5CZkcbNnV3gXlJzs7E
         5RZQ==
X-Gm-Message-State: AO0yUKU5ApQG2rHc0TbhPNtE2qrU2JH0FFWdmRcZt2s7cBHXSJrYHQUj
        TYk8A8eegsTgL9Hkzo68nDA9W3LDtG7nrzfVva8=
X-Google-Smtp-Source: AK7set/d2aevsj9G+8nYaIRCWaQtHIS0zZn1kqp5FZKOqqzsARfgQDeB6WHYCSX2yGF2uQmpFy2app9LeJUPZJkI95A=
X-Received: by 2002:a65:4509:0:b0:503:4a2c:5f0 with SMTP id
 n9-20020a654509000000b005034a2c05f0mr1375140pgq.9.1679532200648; Wed, 22 Mar
 2023 17:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230222033021.983168-1-guoren@kernel.org> <20230222033021.983168-2-guoren@kernel.org>
In-Reply-To: <20230222033021.983168-2-guoren@kernel.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 23 Mar 2023 08:43:08 +0800
Message-ID: <CAJhGHyCAZT+NMpSvUaL0fASnD+HMu-zUsT4Emr9h_VFgYHowVQ@mail.gmail.com>
Subject: Re: [PATCH -next V17 1/7] compiler_types.h: Add __noinstr_section()
 for noinstr
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, palmer@dabbelt.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 22, 2023 at 11:56=E2=80=AFAM <guoren@kernel.org> wrote:
>
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> Using __noinstr_section() doesn't automatically disable all
> instrumentations on the section. Inhibition for some
> instrumentations requires extra code. I.E. KPROBES explicitly
> avoids instrumenting on .noinstr.text.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> Tested-by: Jisheng Zhang <jszhang@kernel.org>
> Tested-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>

Hello

The change has been made upstream as a part of the commit
2b5a0e425e6e(objtool/idle: Validate __cpuidle code as noinstr).

https://lore.kernel.org/r/20230112195540.373461409@infradead.org

Thanks
Lai

> ---
>  include/linux/compiler_types.h | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_type=
s.h
> index 7c1afe0f4129..0a2ca5755be7 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -231,12 +231,19 @@ struct ftrace_likely_data {
>  #define __no_sanitize_or_inline __always_inline
>  #endif
>
> -/* Section for code which can't be instrumented at all */
> -#define noinstr                                                         =
       \
> -       noinline notrace __attribute((__section__(".noinstr.text")))    \
> -       __no_kcsan __no_sanitize_address __no_profile __no_sanitize_cover=
age \
> +/*
> + * Using __noinstr_section() doesn't automatically disable all instrumen=
tations
> + * on the section.  Inhibition for some instrumentations requires extra =
code.
> + * I.E. KPROBES explicitly avoids instrumenting on .noinstr.text.
> + */
> +#define __noinstr_section(section)                             \
> +       noinline notrace __section(section) __no_profile        \
> +       __no_kcsan __no_sanitize_address __no_sanitize_coverage \
>         __no_sanitize_memory
>
> +/* Section for code which can't be instrumented at all */
> +#define noinstr __noinstr_section(".noinstr.text")
> +
>  #endif /* __KERNEL__ */
>
>  #endif /* __ASSEMBLY__ */
> --
> 2.36.1
>
