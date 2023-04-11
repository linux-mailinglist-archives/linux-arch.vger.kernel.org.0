Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FE76DD4CE
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 10:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjDKIK0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 11 Apr 2023 04:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDKIKY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 04:10:24 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1609626AB;
        Tue, 11 Apr 2023 01:10:20 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id a13so7202626ybl.11;
        Tue, 11 Apr 2023 01:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681200619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKyKsR4WjWkIQ4662w2UQ58EahuI+KkHYModkQblq2M=;
        b=xnxuPJe+aU3CjxA4a/n+E3sIL9eZEhhFDq0v48AJ2zUVxgWkqUvjhiW2FghGBfgfB7
         IHRg9ujbr15RIiXx9RG9XrylRsjkkHupqz7Wa7LkeiBeouw/CKrNzHCsFhEb9kpG1V0j
         8OGZNBRT1K1bpTxoTSKRJN6ixqzVdUUSDOgIf9YtkoI9zC7XQ8HpmpjndxSxcullKYte
         ZxZMzt0xTjsY8qDnfjaS0HrWYJAp5ae8+AyN5CQud0cY8gvG98sIiwUDMd/UO4tvyG7f
         V+A3lGFCc/2K0HRpDd0hKf5rPRz4mz+y84IRtFOVRoG7xtCtXidGuzvZNhxTgPOIJu7u
         5RXw==
X-Gm-Message-State: AAQBX9d38NhnVDPNNSXvFboksEYIjRPEI6mYzXfuFMBe0MCtVI2OYMxL
        K08hQpGXtQED+oDbWubLLhJCkh/V0cvO2w==
X-Google-Smtp-Source: AKy350YpaOU1SfXHwpvFzyOHcgvSJ4n/gI7t5hJkCVVzTnI0X4VlFGyhb7Lp0nAbm1k21Zu4Ru5Hiw==
X-Received: by 2002:a25:1381:0:b0:8e8:b849:f716 with SMTP id 123-20020a251381000000b008e8b849f716mr7201171ybt.57.1681200619039;
        Tue, 11 Apr 2023 01:10:19 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 130-20020a250888000000b00b7767ca748asm3484858ybi.39.2023.04.11.01.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 01:10:17 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-54c12009c30so251205697b3.9;
        Tue, 11 Apr 2023 01:10:16 -0700 (PDT)
X-Received: by 2002:a81:bc08:0:b0:54e:e490:d190 with SMTP id
 a8-20020a81bc08000000b0054ee490d190mr1216128ywi.4.1681200616792; Tue, 11 Apr
 2023 01:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230406143019.6709-1-tzimmermann@suse.de> <20230406143019.6709-8-tzimmermann@suse.de>
In-Reply-To: <20230406143019.6709-8-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Apr 2023 10:10:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWY2KdnpuunRqADjDjt_vnEdyD_yfwJySTi4s5N+A1ZgA@mail.gmail.com>
Message-ID: <CAMuHMdWY2KdnpuunRqADjDjt_vnEdyD_yfwJySTi4s5N+A1ZgA@mail.gmail.com>
Subject: Re: [PATCH v2 07/19] arch/m68k: Merge variants of fb_pgprotect() into
 single function
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 6, 2023 at 4:30 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Merge all variants of fb_pgprotect() into a single function body.
> There are two different cases for MMU systems. For non-MMU systems,
> the function body will be empty. No functional changes, but this
> will help with the switch to <asm-generic/fb.h>.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
