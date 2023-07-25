Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33790760BC3
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jul 2023 09:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjGYHaB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 25 Jul 2023 03:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjGYH3V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 03:29:21 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AE73A84;
        Tue, 25 Jul 2023 00:27:30 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d074da73c7dso3653655276.1;
        Tue, 25 Jul 2023 00:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690270046; x=1690874846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioy1kxmrdx2KVxh015qsP5Np9ymNlgvZ2VyP0SjWBss=;
        b=WGDSSYt8Fq9zbzU4HWEeXOjz38UDwZ779nGcKSINb7l/yp/2d5iuo2UuJOxBuddAsS
         p7AiFED2nrBnApeSwd/A0TgWFSRbq0KiWCxinI9tCwak3EkNF0yR79PIzEah8hSvoDf6
         GREh9lWCJzIHmE+LthTHm5i6VtNdF8JiAvupIJr/3e4raAVFZfb/QZdCa1dwLILgpobF
         Q02kADLinCOV1n2xfhqKCxyR8MSASMCsJiYf7UqMP//lx15pn7MtlmV1R2sp2l3waFnc
         2LH0LtPxk7zEU6m/8TvLo1NMj59xxEKtAuWYUCDMvkt/2SgoTd7LelouvULQvHwT3fPw
         HiuA==
X-Gm-Message-State: ABy/qLaQ1MaMKemZNiV3wo1W0QZOu70Pye12ixswR/s57dJadXnoCswT
        n4nCHC5ukgJmuGYz3vIEytaclyVP2d5qeg==
X-Google-Smtp-Source: APBJJlHiRVU0ipvkO3HgVFvrbUkvSCvRionxutfu78b8lHIEcWqXkIrJd0LJnFkBFoWKZ8Puj97VJg==
X-Received: by 2002:a81:6643:0:b0:583:5b22:856f with SMTP id a64-20020a816643000000b005835b22856fmr12145348ywc.50.1690270046522;
        Tue, 25 Jul 2023 00:27:26 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id y21-20020a02c015000000b0042b358194acsm3234664jai.114.2023.07.25.00.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 00:27:26 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-77acb04309dso293828539f.2;
        Tue, 25 Jul 2023 00:27:26 -0700 (PDT)
X-Received: by 2002:a0d:d595:0:b0:576:a0b8:eb06 with SMTP id
 x143-20020a0dd595000000b00576a0b8eb06mr9295958ywd.52.1690269740552; Tue, 25
 Jul 2023 00:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230721102237.268073801@infradead.org> <20230721105744.022509272@infradead.org>
In-Reply-To: <20230721105744.022509272@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 09:22:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWq19xEQbk7pqMZ8NKqWLig47bbG93f8+a-1pNCR60Uww@mail.gmail.com>
Message-ID: <CAMuHMdWq19xEQbk7pqMZ8NKqWLig47bbG93f8+a-1pNCR60Uww@mail.gmail.com>
Subject: Re: [PATCH v1 05/14] futex: Add sys_futex_wake()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21, 2023 at 1:03 PM Peter Zijlstra <peterz@infradead.org> wrote:
> To complement sys_futex_waitv() add sys_futex_wake(). This syscall
> implements what was previously known as FUTEX_WAKE_BITSET except it
> uses 'unsigned long' for the bitmask and takes FUTEX2 flags.
>
> The 'unsigned long' allows FUTEX2_64 on 64bit platforms.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

>  arch/m68k/kernel/syscalls/syscall.tbl       |    1

For adding the syscall:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

For the actual number, you have to take the Big Syscall Lock ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
