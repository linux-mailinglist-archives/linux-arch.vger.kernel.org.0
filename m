Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA54C6600
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 10:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiB1Jst (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 04:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbiB1Jss (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 04:48:48 -0500
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD73E1A825;
        Mon, 28 Feb 2022 01:48:10 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id e26so12336309vso.3;
        Mon, 28 Feb 2022 01:48:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3p3ZZVWCEeTXVcHY0hcD4DxrFdkv2OQcZeSBN/3hX5s=;
        b=KgqsYsBzJtNkw3zQUiGUkKDMvsUxfzBLwWnEgE3nbw9ul/O0uRhDovY9lfHRhC8L5J
         cUu3wc6UQj7wU7aRwPXvqVWGzjnidQ+H6/SpZr8rWc3MsmXt5L6LflrK1lZnD3OY9wWA
         Uw7q+MJwCO2odXE26lxCa0pEfSyVYKdIRn673nI39OcbvNCcrAa6AoETp0oTrWBZwxaH
         FSCZnABySMrz0LnqWMvEpg/pIGcCYBWbvanvBEWmVXSFSRlTLOL1h9Hm8cC8faYNcqZg
         zgk1/fBm+rzfTzk0A7OIc5/AAe5c5fHfdcN11gyRCfOoDyjh/lw7de5v4hYkZLPIp8V3
         oFsg==
X-Gm-Message-State: AOAM531O2JxdiOveIkL0ZziXrZuMxPAC82pcplPHWP/tgMaRG1SyCAit
        JLg7cuxKoVO+Z8ZRKgR++9uvDmLs7Bm/6w==
X-Google-Smtp-Source: ABdhPJyaGG5F6oSwF3azU2PFDi7lqB4d1+oSn82iFbhHST7IIXI8SLS/cXZUE5CJJYavCOuzJCdVaA==
X-Received: by 2002:a67:c30d:0:b0:31a:6796:141 with SMTP id r13-20020a67c30d000000b0031a67960141mr8101697vsj.27.1646041689756;
        Mon, 28 Feb 2022 01:48:09 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id v123-20020a1fde81000000b0032d8170fd77sm1747564vkg.27.2022.02.28.01.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:48:09 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id g21so12308237vsp.6;
        Mon, 28 Feb 2022 01:48:09 -0800 (PST)
X-Received: by 2002:a67:af08:0:b0:31b:9451:bc39 with SMTP id
 v8-20020a67af08000000b0031b9451bc39mr7159610vsl.68.1646041689307; Mon, 28 Feb
 2022 01:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20220227091024.207786-1-masahiroy@kernel.org>
In-Reply-To: <20220227091024.207786-1-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 10:47:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWO=CF8RKb1rUtHYedQ43AeeEEbVoyUdfmD9xOCXcB1SQ@mail.gmail.com>
Message-ID: <CAMuHMdWO=CF8RKb1rUtHYedQ43AeeEEbVoyUdfmD9xOCXcB1SQ@mail.gmail.com>
Subject: Re: [PATCH] arch: syscalls: simplify uapi/kapi directory creation
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sun, Feb 27, 2022 at 10:51 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> $(shell ...) expands to empty. There is no need to assign it to _dummy.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

>  arch/m68k/kernel/syscalls/Makefile       | 3 +--

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
