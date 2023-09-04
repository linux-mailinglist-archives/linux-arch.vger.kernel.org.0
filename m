Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB2E79119D
	for <lists+linux-arch@lfdr.de>; Mon,  4 Sep 2023 08:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbjIDGuP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 4 Sep 2023 02:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjIDGuO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Sep 2023 02:50:14 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71B2109;
        Sun,  3 Sep 2023 23:50:11 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-58cd9d9dbf5so15252247b3.0;
        Sun, 03 Sep 2023 23:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693810211; x=1694415011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rK9iNlhM9qm2dLN2U9ruHBYs+JWxgylVxpO0f1W8IM=;
        b=EnQw6OPmlxZD5Z0kW5XnJqBecMlspYL4JVu1kmCzuxVSIbHzWNui761SedU8kNWUQW
         gxcHdvLd/e8lBbmGtA4SSho8FW0J+ObjbVvduRaJhdMgz5+CJEWKBsDLE2DVbrm+Z6Qw
         FfqazM6ng2k/72qaGd0hRnlfHO6afWCD7RQE570GM0zKS6m6vGsJuhga3Axu1nV1REnO
         od/toa6p+PUfFCvsOvaAywkdO0o0ZIsHPejZNzMviHgxFxlbq7YDLBKPJb7UAtiE09At
         Ly5WXaddH6gM8EWGHqFd+/cqPLIHMxSHrpJNzXOXClvDDPIzS/LUpily77qP9XolDsKB
         QewQ==
X-Gm-Message-State: AOJu0YwiiHkdIuEZgHof7OvnSKnIb6u7lH8mtoLSkbdXjZ6OQgOw2KKY
        JgBWsShNgrGLMy4ULAAd+EsCKoqvjrvWhw==
X-Google-Smtp-Source: AGHT+IFEi632q5pwab44tv3exkUF3p7vca5QHIZ6OdcFpzEOX5ggp25JIQD9KB+Wjv6+/iXKKagxZw==
X-Received: by 2002:a81:9a14:0:b0:583:7564:49de with SMTP id r20-20020a819a14000000b00583756449demr1154630ywg.3.1693810210726;
        Sun, 03 Sep 2023 23:50:10 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id v184-20020a8185c1000000b005843155e284sm2518573ywf.49.2023.09.03.23.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 23:50:09 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d7bae413275so2754423276.0;
        Sun, 03 Sep 2023 23:50:09 -0700 (PDT)
X-Received: by 2002:a25:a1a9:0:b0:d7b:a78e:6b2d with SMTP id
 a38-20020a25a1a9000000b00d7ba78e6b2dmr12488603ybi.20.1693810209384; Sun, 03
 Sep 2023 23:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230901142659.31787-1-tzimmermann@suse.de> <20230901142659.31787-5-tzimmermann@suse.de>
In-Reply-To: <20230901142659.31787-5-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Sep 2023 08:49:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV+0P40QpPcLeuSAd0HJ_Z2uPpmhyBKXnxoOQibtGAVFg@mail.gmail.com>
Message-ID: <CAMuHMdV+0P40QpPcLeuSAd0HJ_Z2uPpmhyBKXnxoOQibtGAVFg@mail.gmail.com>
Subject: Re: [PATCH 4/4] fbdev: Replace fb_pgprotect() with fb_pgprot_device()
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        arnd@arndb.de, deller@gmx.de, linuxppc-dev@lists.ozlabs.org,
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 2, 2023 at 11:13 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Rename the fbdev mmap helper fb_pgprotect() to fb_pgprot_device().
> The helper sets VMA page-access flags for framebuffers in device I/O
> memory. The new name follows pgprot_device(), which does the same for
> arbitrary devices.
>
> Also clean up the helper's parameters and return value. Instead of
> the VMA instance, pass the individial parameters separately: existing
> page-access flags, the VMAs start and end addresses and the offset
> in the underlying device memory rsp file. Return the new page-access
> flags. These changes align fb_pgprot_device() closer with pgprot_device.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

>  arch/m68k/include/asm/fb.h           | 19 ++++++++++---------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
