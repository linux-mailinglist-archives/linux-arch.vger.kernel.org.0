Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313834B4A0C
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 11:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbiBNKC6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 05:02:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345833AbiBNKB4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 05:01:56 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC28F21809;
        Mon, 14 Feb 2022 01:48:18 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id i27so461787vsr.10;
        Mon, 14 Feb 2022 01:48:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVctF2TLthiqqvEqHlD1AtmIxo0t7StGx/mG39a8KA8=;
        b=Omicg4dZeiSI5ckDJ3d/jOfQKgyohi7mVaiN8Zryu69Vp55HDWzwHGtZrKndX/LJ3e
         aO4ViHztGz5QtOJnNProV1T1Kj7Rcj6JLjYb7w7yWLf/pUo5bn1nFTboWJVToOoGLnyx
         NibK1BvOEsZn4Ak6mnjvfdwqpm+0jPRAEn8m1X5tTPQbiWqcKOxmYx7xATz807zJsBov
         XzQsO3zvEZyjcj2zeXJagmMEvVyvCRh+ZcvF0O9jW7Kl98L+jzfHz4sZzxVLHCRPDRYS
         iyxjtkYdVtLzoMOkBNOtoeOByE1j3sCtlskdEhdgktis3Xh5wdPjX0bBfBEfBzXvFB8m
         2ELg==
X-Gm-Message-State: AOAM531JK2SXFV0Yg+iK4hC8G8/g6pVH56ckJooxv1QWlOr9LEYPF3/i
        GKjJNXzcId0C2em9JZqXvoO+wWhWG1J0tA==
X-Google-Smtp-Source: ABdhPJxK1yoGjORC2jMYqIjSeLaQXh0GndnYrnTpHuyh84ceIWoMDuE38NCVZBSsbnQyGfxUF+YD6A==
X-Received: by 2002:a05:6102:3e90:: with SMTP id m16mr3348863vsv.4.1644832097754;
        Mon, 14 Feb 2022 01:48:17 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id p196sm78903vke.27.2022.02.14.01.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 01:48:17 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id g21so5359152vsp.6;
        Mon, 14 Feb 2022 01:48:17 -0800 (PST)
X-Received: by 2002:a05:6102:440d:: with SMTP id df13mr981415vsb.5.1644832097058;
 Mon, 14 Feb 2022 01:48:17 -0800 (PST)
MIME-Version: 1.0
References: <1644805853-21338-1-git-send-email-anshuman.khandual@arm.com> <1644805853-21338-31-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1644805853-21338-31-git-send-email-anshuman.khandual@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Feb 2022 10:48:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVqeyFhzJHLvE+erA4dO+eqpqzx8hVUj9LDk0iPwR1ByQ@mail.gmail.com>
Message-ID: <CAMuHMdVqeyFhzJHLvE+erA4dO+eqpqzx8hVUj9LDk0iPwR1ByQ@mail.gmail.com>
Subject: Re: [PATCH 30/30] mm/mmap: Drop ARCH_HAS_VM_GET_PAGE_PROT
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anshuman,

On Mon, Feb 14, 2022 at 7:54 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> All platforms now define their own vm_get_page_prot() and also there is no
> generic version left to fallback on. Hence drop ARCH_HAS_GET_PAGE_PROT.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks for your patch!

> -       select ARCH_HAS_VM_GET_PAGE_PROT

So before, all architectures selected ARCH_HAS_VM_GET_PAGE_PROT...

> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -81,7 +81,6 @@ static void unmap_region(struct mm_struct *mm,
>                 struct vm_area_struct *vma, struct vm_area_struct *prev,
>                 unsigned long start, unsigned long end);
>
> -#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT

... hence the block below was not included.

>  /* description of effects of mapping type and prot in current implementation.
>   * this is due to the limited x86 page protection hardware.  The expected
>   * behavior is in parens:
> @@ -102,8 +101,6 @@ static void unmap_region(struct mm_struct *mm,
>   *                                                             w: (no) no
>   *                                                             x: (yes) yes
>   */
> -#endif /* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
> -

So shouldn't the whole block be removed instead?
Do I need more coffee??

>  static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
>  {
>         return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
