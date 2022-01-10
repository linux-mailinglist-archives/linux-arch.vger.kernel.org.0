Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110594899A1
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 14:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiAJNOE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 08:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiAJNOD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 08:14:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C7EC06173F
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 05:14:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 253CC612B5
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 13:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877A8C36AE9
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641820442;
        bh=cAexxOlfTT/Fp0dj+z1yi67GAYJ7Wh3qXVGNP3f/Cn8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YMplQEe1TOz79qGgu496txihEhZvc+njCbikDdiUQWOVgbP3z/GFAb3QJEoc3tTBA
         IHtEiqb5wiQqMuZdFXUtSQZ+s3/kR1JEIVyzzROp7LHyzL2IcKa1IztDpUIo+LH+bp
         qhzKdhE9WvuHtjprzcX/PVq4JVlp/o4IfBcETJJrAGiNmgfsO8FLMa9jo44pasTuJf
         Z1XuypKSdIHaewWv2FRcX3a3yHruPYgMf0JZp61LEC+ckKWttpWaRhqOIfkScdOn28
         jMN6NBg2TGWWlL4DZGT4OLHR9e+VRetFSKqAiqOzWFYjd3iXeRgSjVddvj6ES7VWsT
         XtRgYqp1mnKAg==
Received: by mail-wm1-f45.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso9694780wmc.3
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 05:14:02 -0800 (PST)
X-Gm-Message-State: AOAM531+/Ju3bYHF8Zz8QW0w5Tf909L52ND2UN3ew1ic1STvxRKHMKxm
        RnANjh16I4aCOmzk82B3TsKFub+XKeK3yYFstTQ=
X-Google-Smtp-Source: ABdhPJzBs7NsHJeWpdRiEP3QbnYZp9X7AFP97Cz7nYonV9f6H8q3BB5BTyL7xCjm0E6HmcEVUec2meLGdI3FHnyLdjs=
X-Received: by 2002:a05:600c:35cf:: with SMTP id r15mr22091081wmq.106.1641820440859;
 Mon, 10 Jan 2022 05:14:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641659630.git.luto@kernel.org> <3efc4cfd1d7c45a32752ced389d6666be15cde56.1641659630.git.luto@kernel.org>
In-Reply-To: <3efc4cfd1d7c45a32752ced389d6666be15cde56.1641659630.git.luto@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 Jan 2022 14:13:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEJU9zLJaSN05rJcxJ7mQj_OiAOHwpbqYmGAZRmRWC45A@mail.gmail.com>
Message-ID: <CAMj1kXEJU9zLJaSN05rJcxJ7mQj_OiAOHwpbqYmGAZRmRWC45A@mail.gmail.com>
Subject: Re: [PATCH 19/23] x86/efi: Make efi_enter/leave_mm use the
 temporary_mm machinery
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, x86@kernel.org,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 8 Jan 2022 at 17:44, Andy Lutomirski <luto@kernel.org> wrote:
>
> This should be considerably more robust.  It's also necessary for optimized
> for_each_possible_lazymm_cpu() on x86 -- without this patch, EFI calls in
> lazy context would remove the lazy mm from mm_cpumask().
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/platform/efi/efi_64.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index 7515e78ef898..b9a571904363 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -54,7 +54,7 @@
>   * 0xffff_ffff_0000_0000 and limit EFI VA mapping space to 64G.
>   */
>  static u64 efi_va = EFI_VA_START;
> -static struct mm_struct *efi_prev_mm;
> +static temp_mm_state_t efi_temp_mm_state;
>
>  /*
>   * We need our own copy of the higher levels of the page tables
> @@ -461,15 +461,12 @@ void __init efi_dump_pagetable(void)
>   */
>  void efi_enter_mm(void)
>  {
> -       efi_prev_mm = current->active_mm;
> -       current->active_mm = &efi_mm;
> -       switch_mm(efi_prev_mm, &efi_mm, NULL);
> +       efi_temp_mm_state = use_temporary_mm(&efi_mm);
>  }
>
>  void efi_leave_mm(void)
>  {
> -       current->active_mm = efi_prev_mm;
> -       switch_mm(&efi_mm, efi_prev_mm, NULL);
> +       unuse_temporary_mm(efi_temp_mm_state);
>  }
>
>  static DEFINE_SPINLOCK(efi_runtime_lock);
> --
> 2.33.1
>
