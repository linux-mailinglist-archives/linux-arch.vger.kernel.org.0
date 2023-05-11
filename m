Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C92C6FF23A
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbjEKNLY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 11 May 2023 09:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbjEKNLB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 09:11:01 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B643440ED;
        Thu, 11 May 2023 06:10:57 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-55a00da4e53so153651357b3.0;
        Thu, 11 May 2023 06:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683810657; x=1686402657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFpq6TfFDkhgvBTK4lDV32kTv2wLv5jHDb1iGqYi2iA=;
        b=SYJrVUjqVBrvmAiE0paABwMvCIR57g9q8r/1uuOaS6oW+wejYfYSJaYJre8lx1Utoo
         1s2PvAqooBs15dRB7NhlkcX56nyntFeeT3kVYbPMDYEcn7XIyMvBihskHrKiiAKITdY5
         GNwUupMQJVvcEi6tc2wsp9BDTYdXRobXr/H7HMmZIEqhTgbJxrjgXuYyeAt7Fi4rXBGC
         6WtjyqDw7AyWJVviow57c9BYe6taGvTOkQ9LNXSye4Iy3viISQCtAcvyxAPQf16sCNsb
         e9lrV6Q60ZaFzjnlh1dbiYzKPaL3k9Yaz8ekb59jOg7UrFwiPKDYF6GQE2ZZTNaHIbw4
         VbIg==
X-Gm-Message-State: AC+VfDx1WMqIveGhONIvPKrGcM2fP0UHMU+1PaWy55OYiLMMkJVzh/Hb
        GajYp5IebsSld1GzGQjg59R41LEmuo+9oA==
X-Google-Smtp-Source: ACHHUZ4xoBrFJrG29LJfzdFL3U0IPY913sxscaao7G6y2auDH+vr1IkUtjGXEFsnOWBo+VIQ4wBiMg==
X-Received: by 2002:a81:5b54:0:b0:559:f52b:7c5f with SMTP id p81-20020a815b54000000b00559f52b7c5fmr21667863ywb.17.1683810656706;
        Thu, 11 May 2023 06:10:56 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id d201-20020a0ddbd2000000b0055a777e3c50sm4841077ywe.62.2023.05.11.06.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 06:10:54 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-b9e2b65d006so12577616276.3;
        Thu, 11 May 2023 06:10:54 -0700 (PDT)
X-Received: by 2002:a25:3792:0:b0:ba1:e7bb:a3a6 with SMTP id
 e140-20020a253792000000b00ba1e7bba3a6mr17227303yba.18.1683810654067; Thu, 11
 May 2023 06:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230510110557.14343-1-tzimmermann@suse.de> <20230510110557.14343-2-tzimmermann@suse.de>
 <0e13efbf-9a48-6e70-fdf3-8290f28c6dc7@189.cn> <a2315b9a-0747-1f0f-1f0a-1c6773931db4@suse.de>
 <15fe1489-f0fa-bbf6-ec08-a270bd4f1559@gmx.de>
In-Reply-To: <15fe1489-f0fa-bbf6-ec08-a270bd4f1559@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 May 2023 15:10:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX8piLhEbV+pcWvdn1OEGH9N5FwDOQcqNcEjBx3=ThjXA@mail.gmail.com>
Message-ID: <CAMuHMdX8piLhEbV+pcWvdn1OEGH9N5FwDOQcqNcEjBx3=ThjXA@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] fbdev/matrox: Remove trailing whitespaces
To:     Helge Deller <deller@gmx.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <15330273260@189.cn>, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net, arnd@arndb.de,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
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

Hi Helge,

On Thu, May 11, 2023 at 3:05 PM Helge Deller <deller@gmx.de> wrote:
> On 5/11/23 09:55, Thomas Zimmermann wrote:
> > But the work I do within fbdev is mostly for improving DRM.
>
> Sure.
>
> > For the
> > other issues in this file, I don't think that matroxfb should even be
> > around any longer. Fbdev has been deprecated for a long time. But a
> > small number of drivers are still in use and we still need its
> > framebuffer console. So someone should either put significant effort
> > into maintaining fbdev, or it should be phased out. But neither is
> > happening.
>
> You're wrong.
>
> You don't mention that for most older machines DRM isn't an acceptable
> way to go due to it's limitations, e.g. it's low-speed due to missing
> 2D-acceleration for older cards and and it's incapability to change screen
> resolution at runtime (just to name two of the bigger limitations here).
> So, unless we somehow find a good way to move such drivers over to DRM
> (with a set of minimal 2D acceleration), they are still important.

DRM can change resolution at runtime, just not through the fbdev API.

Or do you mean the resolution of the text console, akin to
"fbset <mode>"? I have to admit I do not know if there is a command
line tool to do that...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
