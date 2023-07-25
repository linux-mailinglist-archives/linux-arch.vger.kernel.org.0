Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2F3760BA9
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jul 2023 09:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjGYH1Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 25 Jul 2023 03:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjGYH0b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 03:26:31 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4A41BD3;
        Tue, 25 Jul 2023 00:23:43 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d18566dc0c1so377084276.0;
        Tue, 25 Jul 2023 00:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690269822; x=1690874622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mM+h5ztuUofGY0wWX9Y451p0KqwfLDA50x+yTuRtNGU=;
        b=Bn9rA0ZVaNPLbEQLGUxWl+53YXkEuLkfMkPQX6W6ypNiSSl0fkiE+gGnMU20AC4DLG
         qa08KMt6VPAButmOt+m05pt7EuQQs31/58QrDH2eDTcdczU9fqfGfOJCWD5aJqGyYwi+
         5nh/WDNLB3bK8LLrkVt6LKNtsFkx71tyFt6u3keuePqCgbPKQz2SYBNvf19CygJy3yBV
         XOkEbUx/c8/RU+8d5nrWWEW0rrKFmI5Vbzh+UTUO0xu98SLMOBB+4h9dm4LwBeEzbGcJ
         3/4aynhHanAuoWU9ALKJ5M6OSz8o790vfUaZfzCpbXG3megugIXfo4m++LWPjH68stHp
         B+bA==
X-Gm-Message-State: ABy/qLaOFUcNHk8I4ND7e0qmQ1IZeAzp4W9weCvXTI/yAksyVDHzqrfF
        PBi8aZ4fh55IhnWwciM7wdObQccGlnfSNA==
X-Google-Smtp-Source: APBJJlEYIUlyQrFGR0ATNncBC0ddBbLD0A/Hv6qwyhTm4V3GEveW4zWJN/PhQ8hGpNv55k6Qi3gXGA==
X-Received: by 2002:a25:40cd:0:b0:d05:e325:6d19 with SMTP id n196-20020a2540cd000000b00d05e3256d19mr8674822yba.63.1690269822297;
        Tue, 25 Jul 2023 00:23:42 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id c2-20020a5b0142000000b00c832ad2e2eesm2707490ybp.60.2023.07.25.00.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 00:23:41 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d10354858e8so2029426276.2;
        Tue, 25 Jul 2023 00:23:41 -0700 (PDT)
X-Received: by 2002:a25:4ed5:0:b0:c37:f0b4:4062 with SMTP id
 c204-20020a254ed5000000b00c37f0b44062mr8317164ybb.0.1690269821600; Tue, 25
 Jul 2023 00:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230721102237.268073801@infradead.org> <20230721105744.298661259@infradead.org>
In-Reply-To: <20230721105744.298661259@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 09:23:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVr7d1QZYaRtAxafD3aJp7GMwKNVqe7HUDykoDjU+OdQg@mail.gmail.com>
Message-ID: <CAMuHMdVr7d1QZYaRtAxafD3aJp7GMwKNVqe7HUDykoDjU+OdQg@mail.gmail.com>
Subject: Re: [PATCH v1 09/14] futex: Add sys_futex_requeue()
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21, 2023 at 1:11 PM Peter Zijlstra <peterz@infradead.org> wrote:
> Finish of the 'simple' futex2 syscall group by adding
> sys_futex_requeue(). Unlike sys_futex_{wait,wake}() it's arguments are
> too numerous to fit into a regular syscall. As such, use struct
> futex_waitv to pass the 'source' and 'destination' futexes to the
> syscall.
>
> This syscall implements what was previously known as FUTEX_CMP_REQUEUE
> and uses {val, uaddr, flags} for source and {uaddr, flags} for
> destination.
>
> This design explicitly allows requeueing between different types of
> futex by having a different flags word per uaddr.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

>  arch/m68k/kernel/syscalls/syscall.tbl       |    1

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
