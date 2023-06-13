Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40DA72DACA
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 09:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbjFMH3M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 13 Jun 2023 03:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjFMH3L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 03:29:11 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D13AA;
        Tue, 13 Jun 2023 00:29:10 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bb2ffa1e235so5348185276.0;
        Tue, 13 Jun 2023 00:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686641350; x=1689233350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKEzJjzBKla4S0x8jxwIAxVSx314J/aF9PC4BBXNBUc=;
        b=O/Qgik+keNnu5W/ripF9MuXw5uie4lrFN7GFG0ipslGi3ZQee/TgWENlvdMee5Gpqo
         0+o31MhB6jqzNKVbgTiickkV71vfZbCYnr7kfGcuyUkfP9ZPGGZXxVKkKl6g4FR7GjN9
         lkfoKHdeLiVE976H1HTNyVI+jLeAsREXo678dQWLSFslceozZqf8rcXbzQQQgkz/fBYz
         yPojg2j9jHpPE8vkoTswAsvl9kQEpWMX6Z9R7Su60NwfLoJSuWIVCHGiNmYDCpDlOv/b
         iLZj1ATjunJm8lGaGq2Qi3npr4/R/Zmau1WE+dUPJ44FHMMtZPpF1cysRy25xngbMtGn
         RdGQ==
X-Gm-Message-State: AC+VfDxdvE1X10rWnv8Uu+OqfpsF0hWuZuuThD1NcrzycNc/SbxN562x
        iOUDikmDRR6YWpgq/pFjH9xd9KPAiDIt1Q==
X-Google-Smtp-Source: ACHHUZ4yyzfk2dKTO7/ChlMLJuq/byIx5/VbZj9Su9mWsasd4QMjz/UO+qc8km3I9JTUtbNCjoFjyA==
X-Received: by 2002:a25:420f:0:b0:bcd:7017:5893 with SMTP id p15-20020a25420f000000b00bcd70175893mr926167yba.24.1686641349766;
        Tue, 13 Jun 2023 00:29:09 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id r123-20020a25c181000000b00babd2eef59dsm2983215ybf.27.2023.06.13.00.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 00:29:08 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-56d378b75f0so17179997b3.1;
        Tue, 13 Jun 2023 00:29:08 -0700 (PDT)
X-Received: by 2002:a0d:d611:0:b0:56d:ddc:cdbb with SMTP id
 y17-20020a0dd611000000b0056d0ddccdbbmr1077781ywd.25.1686641348561; Tue, 13
 Jun 2023 00:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230612210423.18611-1-vishal.moola@gmail.com> <20230612210423.18611-26-vishal.moola@gmail.com>
In-Reply-To: <20230612210423.18611-26-vishal.moola@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Jun 2023 09:28:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUk2OM+j_j8XSkMxRnNqmKy3qwUA8Mq-RA+p+ByfY-+4g@mail.gmail.com>
Message-ID: <CAMuHMdUk2OM+j_j8XSkMxRnNqmKy3qwUA8Mq-RA+p+ByfY-+4g@mail.gmail.com>
Subject: Re: [PATCH v4 25/34] m68k: Convert various functions to use ptdescs
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 11:05 PM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
> As part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents, convert various page table functions to use ptdescs.
>
> Some of the functions use the *get*page*() helper functions. Convert
> these to use pagetable_alloc() and ptdesc_address() instead to help
> standardize page tables further.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
