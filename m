Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF477057EB
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 21:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjEPTux (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 15:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEPTuw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 15:50:52 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3627C13E
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 12:50:51 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64ab2a37812so8158547b3a.1
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684266650; x=1686858650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TjEfwC4BQR+GS22Wca+vT5WtBn9fGmf7/EZ2q1dtZMk=;
        b=mVOfXQRV6bjs8gq5rt74ZVwe61gaISUNUVI2bRt4Bn63HY/BAd2eBtKecdcAuW4sBz
         kvSstpNFeZUheLutSv33n8Y6st90GoDfhqbtO6h0Y2T7Cn1c+0ifOrENnrR6mlvVJInW
         QNBevqLjz1JHYM6RD7yhtV3rnVYaKH2qAXLhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684266650; x=1686858650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjEfwC4BQR+GS22Wca+vT5WtBn9fGmf7/EZ2q1dtZMk=;
        b=FHa/AkLbYTxS/p+FUAbnSqbIenMuKxxoex7yhTAbRbqv1szmU39f+BJbbTUxIgPV9q
         uBBP6mvO5rxT2zEffEG2klHRtIQyBAm1Or7WV4dbiihjEnz0ICxKwj2juKSBF//o3nm6
         GwFJhkWYvs48AcI5sURepA07zUxLFCkDLYu2gU1QNuRDYe06yolWrsemtDauE/QhuDpU
         ZveTOnC/hQpoAlgNqrijGepMPICbsYt6/2nLO/YJqB/OXUev5CA++h4O6lwcNpENtb4f
         XuYOC12Z19pnzjtBz1Zb+EMoRpQ8cjvjAtuFbsLsN+BHTiXwXdc8yWw5Ves5FyLl4tH7
         frLA==
X-Gm-Message-State: AC+VfDxglaUwOaQ7tTEC3NpxG4jMZuYiQEQPHEfVAyFOI1ao9nlYqvXf
        XPuQqWSCpw4annPma6k4BJtU0cXlRXpo3kk619o=
X-Google-Smtp-Source: ACHHUZ6Nid4X0bOpHze3dnwaToIV2KnMDGeriyBrLdzzKp60aiWhcdLhmVYyFl9h9ZjEkLntZih3TA==
X-Received: by 2002:a17:902:ed43:b0:1a6:6bd4:cd8c with SMTP id y3-20020a170902ed4300b001a66bd4cd8cmr35820803plb.25.1684266650670;
        Tue, 16 May 2023 12:50:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001a800e03cf9sm15876986plk.256.2023.05.16.12.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 12:50:50 -0700 (PDT)
Date:   Tue, 16 May 2023 12:50:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RFC PATCH] kallsyms: Avoid weak references for kallsyms symbols
Message-ID: <202305161248.F0B3D1D@keescook>
References: <20230504174320.3930345-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504174320.3930345-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 04, 2023 at 07:43:20PM +0200, Ard Biesheuvel wrote:
> kallsyms is a directory of all the symbols in the vmlinux binary, and so
> creating it is somewhat of a chicken-and-egg problem, as its non-zero
> size affects the layout of the binary, and therefore the values of the
> symbols.
> 
> For this reason, the kernel is linked more than once, and the first pass
> does not include any kallsyms data at all. For the linker to accept
> this, the symbol declarations describing the kallsyms metadata are
> emitted as having weak linkage, so they can remain unsatisfied. During
> the subsequent passes, the weak references are satisfied by the kallsyms
> metadata that was constructed based on information gathered from the
> preceding passes.
> 
> Weak references lead to somewhat worse codegen, because taking their
> address may need to produce NULL (if the reference was unsatisfied), and
> this is not usually supported by RIP or PC relative symbol references.
> 
> Given that these references are ultimately always satisfied in the final
> link, let's drop the weak annotation, and instead, provide fallback
> definitions in the linker script that are only emitted if an unsatisfied
> reference exists.
> 
> While at it, drop the FRV specific annotation that these symbols reside
> in .rodata - FRV is long gone.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Fangrui Song <maskray@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h |  9 +++++++
>  kernel/kallsyms.c                 |  6 -----
>  kernel/kallsyms_internal.h        | 25 +++++++-------------
>  3 files changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index d1f57e4868ed341d..dd42c0fcad2b519f 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -460,6 +460,15 @@
>   */
>  #define RO_DATA(align)							\
>  	. = ALIGN((align));						\
> +	PROVIDE(kallsyms_addresses = .);				\
> +	PROVIDE(kallsyms_offsets = .);					\
> +	PROVIDE(kallsyms_names = .);					\
> +	PROVIDE(kallsyms_num_syms = .);					\
> +	PROVIDE(kallsyms_relative_base = .);				\
> +	PROVIDE(kallsyms_token_table = .);				\
> +	PROVIDE(kallsyms_token_index = .);				\
> +	PROVIDE(kallsyms_markers = .);					\
> +	PROVIDE(kallsyms_seqs_of_names = .);				\

Perhaps add comments here and in kernel/kallsyms_internal.h to correlate
this list and the externs? "This list is needed because ..., see the
externs in kallsyms_internal.h." or similar?

Otherwise, yeah, looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
