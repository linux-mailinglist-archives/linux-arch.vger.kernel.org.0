Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721536DD528
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 10:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjDKIV4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 11 Apr 2023 04:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjDKIVb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 04:21:31 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4311440D1;
        Tue, 11 Apr 2023 01:20:23 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-54ee17a659bso145692187b3.4;
        Tue, 11 Apr 2023 01:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681201215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOXdqLxEHLBZ7hy/2mM/9REbA1X5ZreSZtF+7etv6Sw=;
        b=0iG9RzYMgEOTW+MRirY8tCfK6rpiSQCy2il7J6ptrHPhkhDKMaPjU8WOVFqgz7F876
         ZIjqDi1aE1NMRaoJIYNLs6RR6QHB5tEiFn5Vhghsnc/YV2Hz4M40NYOYnwAEzcY9m2l7
         TeyF5gPttiiXGEQBT6iqJbpKg/YLNecva2rDNwjFR+MZosdS12kEDT3vRx0PG7MuGGBV
         YuYZk4NDVMzLHOOx45+wXHgrkiDUFpWXOkRtfbRDsWxqY0KcpUGlq5P8i/fOBM+Ar+D9
         3w8O11FFTHPWVesziw6aefuLniatjfakJd4g2VgZDRoJyV1coUS2RLpm7xURmZks9CxV
         vKVQ==
X-Gm-Message-State: AAQBX9fUKMTVVqyQPRbiq7UYaZ9xESruPkGLjlrdyrd2HX/oxHxpCpVN
        NSlNsr8RxujpKP+jnzrxKlO33KFl6JjKyg==
X-Google-Smtp-Source: AKy350Y7EQFkQbSZA8SAtnnSPk/NknwPKAitFGCqkgGdgtkwcxLQiQgb0Iv6Zv/nOSM40z0Y9lDDBw==
X-Received: by 2002:a81:5b86:0:b0:541:9464:40f1 with SMTP id p128-20020a815b86000000b00541946440f1mr1359319ywb.18.1681201214845;
        Tue, 11 Apr 2023 01:20:14 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id y76-20020a81a14f000000b005460e4170e4sm3337593ywg.129.2023.04.11.01.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 01:20:13 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id q5so10018292ybk.7;
        Tue, 11 Apr 2023 01:20:13 -0700 (PDT)
X-Received: by 2002:a25:d447:0:b0:b75:9519:dbcd with SMTP id
 m68-20020a25d447000000b00b759519dbcdmr960089ybf.12.1681201212819; Tue, 11 Apr
 2023 01:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230406143019.6709-1-tzimmermann@suse.de> <20230406143019.6709-9-tzimmermann@suse.de>
In-Reply-To: <20230406143019.6709-9-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Apr 2023 10:20:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVmZ2GRKqEnZgQKzJ1-Hy-Cz8yoUOhD0TMMqZriH82-tQ@mail.gmail.com>
Message-ID: <CAMuHMdVmZ2GRKqEnZgQKzJ1-Hy-Cz8yoUOhD0TMMqZriH82-tQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/19] arch/m68k: Implement <asm/fb.h> with generic helpers
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     arnd@arndb.de, daniel.vetter@ffwll.ch, deller@gmx.de,
        javierm@redhat.com, gregkh@linuxfoundation.org,
        linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 6, 2023 at 4:30 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Replace the architecture's fb_is_primary_device() with the generic
> one from <asm-generic/fb.h>. No functional changes.
>
> v2:
>         * provide empty fb_pgprotect() on non-MMU systems
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
