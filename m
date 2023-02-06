Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEA668BC72
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 13:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjBFMKG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 07:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjBFMKC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 07:10:02 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B0422DEC;
        Mon,  6 Feb 2023 04:09:38 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id x10so5418889qtr.2;
        Mon, 06 Feb 2023 04:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SQkBcRxxCrTEFDwcET99BwrKIGZJp4wu6h4t2bWjyk=;
        b=RyJeKtkupo3JkR7X29Tx3qWo/Mp9JnEuOfWtphPI76vT1Yhy5a502iSbB/k3dnj0z+
         HIwUP7iqtkO1XdjOQuz7IEQNaHo5BoKZ5v2kmT8H40+o65nVhLQf6TN0VqgP7T08brbM
         lympZeW3fUSapkhnC+/EM0EZtglXmyKqt3BLcY9fGS/CaynazeHcvCxPSHEseVQY2PJm
         AfYmnlxNp45dsdJjhC/n0u0hpTVIfMYBhxBi11Fe2Wyi7NAQiSz4WWnMOpW31Ru6yMEV
         uA3IyoclQ2XvrQsSYVjkPyKDh0LnFo871aqJbUyKlg6fSv87tk6/b8C3574beu2YgP2c
         1kdg==
X-Gm-Message-State: AO0yUKW9nhjxQVVae4wepvzEWOy3uAqyNVGrlrRmlW1ogAJFRGPgCnph
        Uysw7X2zYynLdlBHDbRuVpBSxdc18iK9XA==
X-Google-Smtp-Source: AK7set8UMMjEL+OFiNrgy+UFFYC5k1rwGZRxHoq3fuhMTBpS3WBD12gUXdW7rGZ2ZuZLjBe/OINO2w==
X-Received: by 2002:ac8:5e13:0:b0:3ba:123d:aba0 with SMTP id h19-20020ac85e13000000b003ba123daba0mr11075378qtx.17.1675685352255;
        Mon, 06 Feb 2023 04:09:12 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id s25-20020a05620a16b900b0072ed644bb0dsm6440695qkj.97.2023.02.06.04.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 04:09:11 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-526f0b3d8d9so86465317b3.3;
        Mon, 06 Feb 2023 04:09:11 -0800 (PST)
X-Received: by 2002:a81:89c1:0:b0:52a:7537:98a6 with SMTP id
 z184-20020a8189c1000000b0052a753798a6mr259978ywf.384.1675685351335; Mon, 06
 Feb 2023 04:09:11 -0800 (PST)
MIME-Version: 1.0
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9l0aBPUEpf1bci9@ZenIV>
In-Reply-To: <Y9l0aBPUEpf1bci9@ZenIV>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Feb 2023 13:08:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWcNcn7R6MMeg51SUkmpZZ+HpdsMtiOE55EbQ1coc10AQ@mail.gmail.com>
Message-ID: <CAMuHMdWcNcn7R6MMeg51SUkmpZZ+HpdsMtiOE55EbQ1coc10AQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] m68k: fix livelock in uaccess
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

On Tue, Jan 31, 2023 at 9:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> m68k equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
> If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
> end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
> to page tables.  In such case we must *not* return to the faulting insn -
> that would repeat the entire thing without making any progress; what we need
> instead is to treat that as failed (user) memory access.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
