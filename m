Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EF26D26B2
	for <lists+linux-arch@lfdr.de>; Fri, 31 Mar 2023 19:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjCaRcD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Mar 2023 13:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjCaRcC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Mar 2023 13:32:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251E01DF90;
        Fri, 31 Mar 2023 10:32:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so15848168wmq.4;
        Fri, 31 Mar 2023 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680283919; x=1682875919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JgfNIm0/b0S1WJTNKx0RJfqBlqbq2Is5rY0BnBfIYgI=;
        b=HxTYUrxQFyfr2IFr3t/oz+cV+7dwpjSUNvJg7TA/5z4etdrS42cWV9DAjKZwQ9wTIz
         MLQn3RcTY6zgcx2XAlZwF5CzNRNaOevF6l6L/q+6B3QQvvr81uJmt22IH0/EO8iLehyA
         DeW9mWb0fdpuoQxuyPieF9yLwLF5EXId2ef1Llm4KtWMJmrlbGABHFsLlnqnvHj9XF8M
         VDjmORYD1o7I5yJHiUzH7/3HZxKE2JQSC2WdlFRwNypYDx9k51pDSHM5rkgnAs1cTZ5k
         0z+lk4nwrwicd5388RkmwjZTv06viZuldB2TsK3kpm9KtH1beEanT7Jd5kCSRqjdfHaV
         ABHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680283919; x=1682875919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgfNIm0/b0S1WJTNKx0RJfqBlqbq2Is5rY0BnBfIYgI=;
        b=hhThJY9nEYLgNtMqWuGDYEkg/dMzSlPdi9zg6808uvJjCK5NLZB8TiUXguZhA65SGE
         86G35WJn02pniEpBPWgsz5Beiyp0UUlWZ4jxvTNVnwZAHNwSUACQkNC7U4Qp9cggrt0Q
         YbV+fvEOuztAty5wNlBAoplhG+tGxA3Iq/QeSX04bi37Y5MbzWEqIu3X++Vs/YGaMa3o
         2XkrePTj1fN1Zjmt+M+nrZRQL8mLvu/yp4O695xkmMy3a4G/jFRNe9IeccBNJHpy7YeC
         1U9NddIIkmS1AY5LYx0sznV/HhXHS19NK0eZ+ctXUpbJBfwsCFScgGtVfan9o3VJ4EjH
         A0ug==
X-Gm-Message-State: AO0yUKXSGiPaE71DlY3GW3ljATh1KkKBDQ+WVLciOd4mog9VAgWwZAOK
        Zwi1JzdNTxIzzcWn1juakgw=
X-Google-Smtp-Source: AK7set8GLYgYWDweiiQubwdK8pBuq6rDyJKMVzE3Ht6dxeyx7PB1WmnUe+Ysn61PqU2HeB53ilbwRQ==
X-Received: by 2002:a1c:7206:0:b0:3ed:2352:eebd with SMTP id n6-20020a1c7206000000b003ed2352eebdmr21386687wmc.11.1680283919518;
        Fri, 31 Mar 2023 10:31:59 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c311300b003ee74c25f12sm10411423wmo.35.2023.03.31.10.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:31:58 -0700 (PDT)
Date:   Sat, 1 Apr 2023 02:31:58 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH 5/6] docs: move openrisc documentation under
 Documentation/arch/
Message-ID: <ZCcZDn9Rbqx+47MX@antec>
References: <20230323221948.352154-1-corbet@lwn.net>
 <20230323221948.352154-6-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230323221948.352154-6-corbet@lwn.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 23, 2023 at 04:19:47PM -0600, Jonathan Corbet wrote:
> Architecture-specific documentation is being moved into Documentation/arch/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.  Move
> Documentation/openrisc into arch/ and fix all in-tree references.
> 
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/arch/index.rst                                  | 2 +-
>  Documentation/{ => arch}/openrisc/features.rst                | 0
>  Documentation/{ => arch}/openrisc/index.rst                   | 0
>  Documentation/{ => arch}/openrisc/openrisc_port.rst           | 0
>  Documentation/{ => arch}/openrisc/todo.rst                    | 0
>  Documentation/translations/zh_CN/arch/index.rst               | 2 +-
>  .../translations/zh_CN/{ => arch}/openrisc/index.rst          | 4 ++--
>  .../translations/zh_CN/{ => arch}/openrisc/openrisc_port.rst  | 4 ++--
>  Documentation/translations/zh_CN/{ => arch}/openrisc/todo.rst | 4 ++--
>  MAINTAINERS                                                   | 2 +-
>  10 files changed, 9 insertions(+), 9 deletions(-)
>  rename Documentation/{ => arch}/openrisc/features.rst (100%)
>  rename Documentation/{ => arch}/openrisc/index.rst (100%)
>  rename Documentation/{ => arch}/openrisc/openrisc_port.rst (100%)
>  rename Documentation/{ => arch}/openrisc/todo.rst (100%)
>  rename Documentation/translations/zh_CN/{ => arch}/openrisc/index.rst (79%)
>  rename Documentation/translations/zh_CN/{ => arch}/openrisc/openrisc_port.rst (97%)
>  rename Documentation/translations/zh_CN/{ => arch}/openrisc/todo.rst (88%)
> 
> diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
> index 792f58e30f25..65945daa40fe 100644
> --- a/Documentation/arch/index.rst
> +++ b/Documentation/arch/index.rst
> @@ -17,7 +17,7 @@ implementation.
>     ../m68k/index
>     ../mips/index
>     ../nios2/index
> -   ../openrisc/index
> +   openrisc/index
>     ../parisc/index
>     ../powerpc/index
>     ../riscv/index
> diff --git a/Documentation/openrisc/features.rst b/Documentation/arch/openrisc/features.rst
> similarity index 100%
> rename from Documentation/openrisc/features.rst
> rename to Documentation/arch/openrisc/features.rst
> diff --git a/Documentation/openrisc/index.rst b/Documentation/arch/openrisc/index.rst
> similarity index 100%
> rename from Documentation/openrisc/index.rst
> rename to Documentation/arch/openrisc/index.rst
> diff --git a/Documentation/openrisc/openrisc_port.rst b/Documentation/arch/openrisc/openrisc_port.rst
> similarity index 100%
> rename from Documentation/openrisc/openrisc_port.rst
> rename to Documentation/arch/openrisc/openrisc_port.rst
> diff --git a/Documentation/openrisc/todo.rst b/Documentation/arch/openrisc/todo.rst
> similarity index 100%
> rename from Documentation/openrisc/todo.rst
> rename to Documentation/arch/openrisc/todo.rst
> diff --git a/Documentation/translations/zh_CN/arch/index.rst b/Documentation/translations/zh_CN/arch/index.rst
> index aa53dcff268e..7e59af567331 100644
> --- a/Documentation/translations/zh_CN/arch/index.rst
> +++ b/Documentation/translations/zh_CN/arch/index.rst
> @@ -11,7 +11,7 @@
>     ../mips/index
>     ../arm64/index
>     ../riscv/index
> -   ../openrisc/index
> +   openrisc/index
>     ../parisc/index
>     ../loongarch/index
>  
> diff --git a/Documentation/translations/zh_CN/openrisc/index.rst b/Documentation/translations/zh_CN/arch/openrisc/index.rst
> similarity index 79%
> rename from Documentation/translations/zh_CN/openrisc/index.rst
> rename to Documentation/translations/zh_CN/arch/openrisc/index.rst
> index 9ad6cc600884..da21f8ab894b 100644
> --- a/Documentation/translations/zh_CN/openrisc/index.rst
> +++ b/Documentation/translations/zh_CN/arch/openrisc/index.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
>  
> -:Original: Documentation/openrisc/index.rst
> +:Original: Documentation/arch/openrisc/index.rst
>  
>  :翻译:
>  
> diff --git a/Documentation/translations/zh_CN/openrisc/openrisc_port.rst b/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
> similarity index 97%
> rename from Documentation/translations/zh_CN/openrisc/openrisc_port.rst
> rename to Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
> index b8a67670492d..cadc580fa23b 100644
> --- a/Documentation/translations/zh_CN/openrisc/openrisc_port.rst
> +++ b/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
> @@ -1,6 +1,6 @@
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
>  
> -:Original: Documentation/openrisc/openrisc_port.rst
> +:Original: Documentation/arch/openrisc/openrisc_port.rst
>  
>  :翻译:
>  
> diff --git a/Documentation/translations/zh_CN/openrisc/todo.rst b/Documentation/translations/zh_CN/arch/openrisc/todo.rst
> similarity index 88%
> rename from Documentation/translations/zh_CN/openrisc/todo.rst
> rename to Documentation/translations/zh_CN/arch/openrisc/todo.rst
> index 63c38717edb1..1f6f95616633 100644
> --- a/Documentation/translations/zh_CN/openrisc/todo.rst
> +++ b/Documentation/translations/zh_CN/arch/openrisc/todo.rst
> @@ -1,6 +1,6 @@
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
>  
> -:Original: Documentation/openrisc/todo.rst
> +:Original: Documentation/arch/openrisc/todo.rst
>  
>  :翻译:
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf4eb913ea12..64ea94536f4c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15638,7 +15638,7 @@ S:	Maintained
>  W:	http://openrisc.io
>  T:	git https://github.com/openrisc/linux.git
>  F:	Documentation/devicetree/bindings/openrisc/
> -F:	Documentation/openrisc/
> +F:	Documentation/arch/openrisc/
>  F:	arch/openrisc/
>  F:	drivers/irqchip/irq-ompic.c
>  F:	drivers/irqchip/irq-or1k-*

This all looks ok to me.

Acked-by: Stafford Horne <shorne@gmail.com>
