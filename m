Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5745620C86
	for <lists+linux-arch@lfdr.de>; Tue,  8 Nov 2022 10:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiKHJmX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Nov 2022 04:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiKHJl7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2022 04:41:59 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93CD27176;
        Tue,  8 Nov 2022 01:41:56 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id hh9so8319034qtb.13;
        Tue, 08 Nov 2022 01:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0xAJLxS4jYE+47ZWAmS8AWJyvD2QxuXvjLK3DII+Ys=;
        b=yKsxjt4zmALu9n8wxgnDPE8jybXjoVlsJkLD9sD6eDOOrubRDnp17vx1K1o87qS5q7
         faSqWlRwMSoCSoaafaL0lLX1QCDaX2FcU4wzHaBHqDqIKzs79AIf7l0xaJuGX72iXGq6
         A9ZvtPvIRZpndJwLflV+D0pXh26XORfySNfcDjHGycAOB4sxf5+5SLxTghmjHdYM2bFW
         VKTgsCZKasQfgqK39HuLkbVP2wNpXwezm4eZc0ziWRePHfptemsKfOKMlDnbrDJFqTq0
         85IXvbHfOj8q5QQfDOCG67UkkQoiLYS2AnBCi+0pqgKiRIpDc87S4zw3573IwzyBhQr0
         0FDA==
X-Gm-Message-State: ACrzQf3RZ8Kp2HkpbYvOvt/VWSGLjHooSELXXUM3jWmX/eqKjCrn2oWT
        hhBt8dh+wyxmkIc+f9cOVRBt8E+vk9BBxQ==
X-Google-Smtp-Source: AMsMyM5HZAPaJZVamqxiZOYz8th/Oulr55msK790pV9yVVcIHYx+8mz5n0WgCdX6Txas7njtsD9SEQ==
X-Received: by 2002:ac8:5a16:0:b0:39c:efc6:b370 with SMTP id n22-20020ac85a16000000b0039cefc6b370mr42168014qta.374.1667900515787;
        Tue, 08 Nov 2022 01:41:55 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id q22-20020a05620a0d9600b006fafaac72a6sm2364272qkl.84.2022.11.08.01.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 01:41:55 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-36cbcda2157so128441707b3.11;
        Tue, 08 Nov 2022 01:41:55 -0800 (PST)
X-Received: by 2002:a81:9c49:0:b0:34a:de:97b8 with SMTP id n9-20020a819c49000000b0034a00de97b8mr51653454ywa.384.1667900514891;
 Tue, 08 Nov 2022 01:41:54 -0800 (PST)
MIME-Version: 1.0
References: <Y120X8dWqe15FPPG@ZenIV> <20221029231850.3668437-1-viro@zeniv.linux.org.uk>
 <20221029231850.3668437-7-viro@zeniv.linux.org.uk>
In-Reply-To: <20221029231850.3668437-7-viro@zeniv.linux.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 10:41:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX010izuMLJ8me2WMLOHZ52FxyaGfA31oCekkwjriyBvA@mail.gmail.com>
Message-ID: <CAMuHMdX010izuMLJ8me2WMLOHZ52FxyaGfA31oCekkwjriyBvA@mail.gmail.com>
Subject: Re: [PATCH 07/10] [elf][non-regset] uninline elf_core_copy_task_fpregs()
 (and lose pt_regs argument)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 30, 2022 at 1:20 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> Don't bother with pointless macros - we are not sharing it with aout coredumps
> anymore.  Just convert the underlying functions to the same arguments (nobody
> uses regs, actually) and call them elf_core_copy_task_fpregs().  And unexport
> the entire bunch, while we are at it.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

>  arch/m68k/kernel/process.c       |  3 +--

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
