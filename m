Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FCB719404
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 09:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjFAHUY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 1 Jun 2023 03:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFAHUX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 03:20:23 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64666134;
        Thu,  1 Jun 2023 00:20:21 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-bacf685150cso535509276.3;
        Thu, 01 Jun 2023 00:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604020; x=1688196020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uahBQ1+NZ4LtBmJlKuzSeHMKUQpvPqnHtI00z7d7Eg4=;
        b=Xd2hjhEnmU0jiZwo64AgQKvaEBzw6kMBKlLRa9C8EVQpBlSngee8i8WHYGyYnSpj+Y
         DmWnR89W9g8GJemJcdDkKkub24yv/Q6P1bQYrf850HRFFiMduGrza6eY65H2qg6sIvit
         UJ274SA7vKtTfXw1qIhMkDTzOlWCaVG56XyzGoDx05oyQj8vL9EDZ0J3H3svJRPLODQu
         d3p5997O5+UMw17hGoXB4yjCjWWdxsmxFd0Ad6+ym6y2Lf3iqMYnBPRDDkRA1lU+AGve
         BJf947B/Nx+sY0tpFty7qxV+odUv0MVbdWrUPGXvEKjtb/dR/oTO0p7uUpuO/MOUdDRf
         ndTA==
X-Gm-Message-State: AC+VfDxusOa5o4o7QMhAgJ4Lh8hoIInOR68flpAA/nsBmYtSisbHQSlY
        eLTETar/eHRNCZeh+rN4/XHsuQc5l5GiTw==
X-Google-Smtp-Source: ACHHUZ4xfWPAEf5iziXWIIsITBRttepqIdZGJ3xuKjrKeNaXqebMzIadB0gLp59Xnx74LdjP0sMt1w==
X-Received: by 2002:a25:2d0a:0:b0:ba9:6b90:e551 with SMTP id t10-20020a252d0a000000b00ba96b90e551mr9197872ybt.50.1685604020185;
        Thu, 01 Jun 2023 00:20:20 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id n18-20020a259f12000000b00ba89afced65sm4668890ybq.46.2023.06.01.00.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 00:20:18 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-b9a7e639656so556825276.0;
        Thu, 01 Jun 2023 00:20:18 -0700 (PDT)
X-Received: by 2002:a25:6891:0:b0:ba8:7122:2917 with SMTP id
 d139-20020a256891000000b00ba871222917mr10052062ybc.0.1685604018484; Thu, 01
 Jun 2023 00:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230531213032.25338-1-vishal.moola@gmail.com> <20230531213032.25338-31-vishal.moola@gmail.com>
In-Reply-To: <20230531213032.25338-31-vishal.moola@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Jun 2023 09:20:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
Message-ID: <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
Subject: Re: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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

On Wed, May 31, 2023 at 11:33 PM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents. Also cleans up some spacing issues.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
