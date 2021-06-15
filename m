Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BEE3A7D68
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 13:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFOLoK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 07:44:10 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:38807 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhFOLoJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 07:44:09 -0400
Received: by mail-vs1-f45.google.com with SMTP id x8so9599058vso.5;
        Tue, 15 Jun 2021 04:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6cLFWPwpottSL5NyBrmyH12rIdn1diKeLgL8Kz1B3hs=;
        b=XbgzFv/0XAiDJFknqvh7iiqPXKU9CathZ6CLVdj9Iw6K63UYemCwpGJlVUJf0vU7/E
         QUUYhyx6J6YulCWEE7l1E6LzfM8iCrZiLDehzqH/Daqxr222qDQ6v5RSeNSxZkDfNXij
         kb29Oaj4TO6+nNfCeTubbNvqBU/VOgKH/1dZs/Bb2AJ8ISk1XjpKp+jQ2ImGxTL156Ii
         YoVgblU5nPJw2lrgzmGZM4zNqd6x5FDCxzZxQgXwZxaVhWL25Bl74d9Z9r02ynXGUqrk
         mkaWxW5TGNjSMghed6CHgY5zzOuiHghXvdX42nhFxlavyblluZ2PjOFw6glcliIhcmQk
         8fLQ==
X-Gm-Message-State: AOAM532LxrpEHenRDCCogw+Lt6SAeCdolhSiyd8nKVyDRjkgAxpfs2yX
        dvie72/uohvrGbYluTfmQ4Xa7v4xGywXIDmJNjaX9dp1FF8=
X-Google-Smtp-Source: ABdhPJznuEjA8rihIMbbzhrVXLV05AmmQE+goCl46rfP2wIOnP/fUciGjhBT/1Kzp4dchtm5tTMtBoSZNwhqYUvmAU8=
X-Received: by 2002:a67:3c2:: with SMTP id 185mr4432436vsd.42.1623757324455;
 Tue, 15 Jun 2021 04:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210615110859.320299-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20210615110859.320299-1-aneesh.kumar@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Jun 2021 13:41:53 +0200
Message-ID: <CAMuHMdVdG10w4mUP_nLpPkDCP-tb3waPg_AOSJPch9b7AsLGsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: rename pud_page_vaddr to pud_pgtable and make
 it return pmd_t *
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 15, 2021 at 1:32 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
> No functional change in this patch.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

>  arch/m68k/include/asm/motorola_pgtable.h     | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
