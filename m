Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4085233A6C
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jul 2020 23:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbgG3VUm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jul 2020 17:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbgG3VUl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jul 2020 17:20:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1EAC061575
        for <linux-arch@vger.kernel.org>; Thu, 30 Jul 2020 14:20:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c10so2794860pjn.1
        for <linux-arch@vger.kernel.org>; Thu, 30 Jul 2020 14:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=T9TN+IiG05axbq9DvASXkbUWMclW/1L5ezZkeAERv5E=;
        b=UM7q/hh3+ycXamy6DmVDsqTeyGwToom5lGdDqRMu9nAmBIv9chtjGOtptQGetwvOLM
         dsbPN8u5TFZ4QxDmLlK2Qc8xKyIcI/Q4NYjbUuaSrkkEI6pidokfHVungFblJBmjzoz6
         m8k0/Kw7NxtrkfSYNWkXwhoqyaNZZ6d/gv+ZRsx9H+ofRvhogUmbxCvbEb9ELRr/ntEr
         seYQhSQhj4IkcOY/BiB6K++rUFLn5u5hKFGYT3+Q79YBWK/qBEMpIgkbhzctmN/Qmqqt
         CMP9i25xSEC9So5qlz7pEJooph+gaPlzD40QmetOhYuvq0Tc5Ft0hUd0GDEKws4bGMMs
         xBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=T9TN+IiG05axbq9DvASXkbUWMclW/1L5ezZkeAERv5E=;
        b=hsI2mekmrNOfxO42+AU3cGETo3fmo3lVS/mhKazM1TmwPcYBFxjhcGvbb5EOyoqLXZ
         ichjbljofsyVe2Dx+9/ebKkOQqn/KDISNGJd7Ul4AnQVBINglDB/ml4lhH1tlFtGvvXM
         O1a/Vx1sirhIrdYsO+ftttEsx0CwKBcW35srY2kbH3v0EtLcFfJOEjVh4wEEe28nqCVq
         wDoVwILOc2fzshAhqCab80071t3buOLQquRuNHa7oG4sGdsJ3faJFA435Fqj9g1uTVFL
         4yUcEmLfWFW4IhHWjTaLU+4Prdnl6cI//tjf/IVegO6ukUUhH/IkmRRI78RvIkW7bZvG
         dYjQ==
X-Gm-Message-State: AOAM530MgWkfyP2q6cWorEWcjCFf4bzePunyVtUpldWImEJGigs2HIpW
        F1BtI49ZLjh6u+5UrbIIDeXifKhOYEc=
X-Google-Smtp-Source: ABdhPJzjBOdzPpZw2Zy8gz/U2wDGlNr+GQCGfyGI52RbMq/aPY97IjWGN5aeZxp17vggsWF8JUIiGw==
X-Received: by 2002:a63:5b55:: with SMTP id l21mr813118pgm.348.1596144040321;
        Thu, 30 Jul 2020 14:20:40 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d9sm7277389pgv.45.2020.07.30.14.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 14:20:39 -0700 (PDT)
Date:   Thu, 30 Jul 2020 14:20:39 -0700 (PDT)
X-Google-Original-Date: Thu, 30 Jul 2020 14:20:34 PDT (-0700)
Subject:     Re: [PATCH 17/24] riscv: use asm-generic/mmu_context.h for no-op implementations
In-Reply-To: <20200728033405.78469-18-npiggin@gmail.com>
CC:     linux-arch@vger.kernel.org, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     npiggin@gmail.com
Message-ID: <mhng-5c1b7324-11f8-4334-bfc4-6fc1920aeaa3@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 27 Jul 2020 20:33:58 PDT (-0700), npiggin@gmail.com wrote:
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/riscv/include/asm/mmu_context.h | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
> index 67c463812e2d..250defa06f3a 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -13,34 +13,16 @@
>  #include <linux/mm.h>
>  #include <linux/sched.h>
>
> -static inline void enter_lazy_tlb(struct mm_struct *mm,
> -	struct task_struct *task)
> -{
> -}
> -
> -/* Initialize context-related info for a new mm_struct */
> -static inline int init_new_context(struct task_struct *task,
> -	struct mm_struct *mm)
> -{
> -	return 0;
> -}
> -
> -static inline void destroy_context(struct mm_struct *mm)
> -{
> -}
> -
>  void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	struct task_struct *task);
>
> +#define activate_mm activate_mm
>  static inline void activate_mm(struct mm_struct *prev,
>  			       struct mm_struct *next)
>  {
>  	switch_mm(prev, next, NULL);
>  }
>
> -static inline void deactivate_mm(struct task_struct *task,
> -	struct mm_struct *mm)
> -{
> -}
> +#include <asm-generic/mmu_context.h>
>
>  #endif /* _ASM_RISCV_MMU_CONTEXT_H */

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

I'm assuming this is going in along with the others.  Thanks!
