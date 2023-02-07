Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D28C68DDA9
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 17:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjBGQMY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Feb 2023 11:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjBGQMI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2023 11:12:08 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B794E056;
        Tue,  7 Feb 2023 08:11:55 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id c2so17246490qtw.5;
        Tue, 07 Feb 2023 08:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKpFmPELNxMbbdNEgrdFiGaCVQckx4xSvoILv5TiVp4=;
        b=zUbLIzpwACjD4TI60pRcwCL0xg9USvn8eHQV371WhQdZhlZHWeo3WlShjLsF3tgud+
         wqlouuAcEj34p/N65XAvWyhJ3KmXbU7B4A8sDgxORoHU2W7GEElG4IS1LHTJc+OG7E60
         NTRSUt+ENcYpl60UjlkB9k8etiFUuuizxs6YgGn89IGlPRhAf7ZgWt3eMtnf7BeqO+zn
         SdS9o+jrzb83yURgIk/LFymYM/KSKldkU8Aq+zkbxj+U+68WJ0tDw3/Osx7VdZ71Olfy
         3b7ZFNBiOt6Vjj6NsePoByu/wxG9IUHXJkWv4YkpNjQev3RVhnQkzDpaG5stVWtDR5su
         ZHMw==
X-Gm-Message-State: AO0yUKWFvPh9HDhLtCqOy15jVHIhwY5LxAOYYvt/caNHiJp8F7WqQPCN
        QfwDnYoT1RsZinqmDDTZ8FkegYFz49MDiQ==
X-Google-Smtp-Source: AK7set8aKxLwZwlyl1iNj3yvD+11ovSLP8b1YJ8Dz8j785mko9MntkgmA+ZkfFrSwJrZz9vBkXhfGg==
X-Received: by 2002:a05:622a:1804:b0:3b1:4a8:4665 with SMTP id t4-20020a05622a180400b003b104a84665mr6093586qtc.62.1675786314242;
        Tue, 07 Feb 2023 08:11:54 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id bi15-20020a05620a318f00b006e99290e83fsm9721333qkb.107.2023.02.07.08.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 08:11:53 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-4b718cab0e4so201604057b3.9;
        Tue, 07 Feb 2023 08:11:53 -0800 (PST)
X-Received: by 2002:a0d:f444:0:b0:526:78ad:bb15 with SMTP id
 d65-20020a0df444000000b0052678adbb15mr382260ywf.47.1675786312866; Tue, 07 Feb
 2023 08:11:52 -0800 (PST)
MIME-Version: 1.0
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9l02DvS6CYThTEG@ZenIV>
In-Reply-To: <Y9l02DvS6CYThTEG@ZenIV>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Feb 2023 17:11:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVQusKr_W4dnQzVSWbav7vooCHbiyOQHbnraJCL16bsDQ@mail.gmail.com>
Message-ID: <CAMuHMdVQusKr_W4dnQzVSWbav7vooCHbiyOQHbnraJCL16bsDQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] riscv: fix livelock in uaccess
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 31, 2023 at 9:07 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> riscv equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
> If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
> end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
> to page tables.  In such case we must *not* return to the faulting insn -
> that would repeat the entire thing without making any progress; what we need
> instead is to treat that as failed (user) memory access.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
