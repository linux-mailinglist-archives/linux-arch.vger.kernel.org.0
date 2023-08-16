Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5BD77E446
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 16:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbjHPOzw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 16 Aug 2023 10:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343841AbjHPOzW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 10:55:22 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86EB26BD;
        Wed, 16 Aug 2023 07:55:17 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3a7d402fc6fso4873754b6e.2;
        Wed, 16 Aug 2023 07:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692197717; x=1692802517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tf06pj+19UjpKnAon6148kouUgaKWETT51HYndVh5do=;
        b=ZECO5ZMCF97LSUYdT6EMnWdqVUouypgDTo59JtWHemu+TYxXZKHtMv5+SIEIQQLHQK
         LWFtDaRRvbb0bpHf9MVbtTQY9UiR2hil5THte8eLWHYn0OCOo9KjziyhQqcfB7oIeLXq
         8NjNMoIsr0ixdjP8PxC8Ox5sBXFUUG1KNgMBLxJbMohfJuVxyjm7KKhkF8F8G3qzCRF/
         TFwVA8Gde7Ue2feGqEG5e3aAAoNsLMrbdvOp49HVwK4F0GCC3ftrE1IAFG1BrDxP2tiv
         2Q+8CSbTJeezAzMYq3/GNEBew+ewQ5J/mwmtJWK1UcccvIlYqTxthW/MxfMD2k7rENZ5
         2dDA==
X-Gm-Message-State: AOJu0YyiGEhBtKfPe5mQulvAWJHhydm8kt1+hGtKONzmCt4v5JDMlyuu
        sb4TPylJ6h2FQH8b0LZW0DZo4vCyD7r5+A==
X-Google-Smtp-Source: AGHT+IG5EVUP7JSZEPrYVwZbVZOOIzW737LEicQ71yzl+0+hJmYQ/2wJaKOrW/942kzr5I5CJixYQA==
X-Received: by 2002:a05:6870:73d4:b0:1bf:2ad9:8dac with SMTP id a20-20020a05687073d400b001bf2ad98dacmr2223732oan.52.1692197717100;
        Wed, 16 Aug 2023 07:55:17 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id dd8-20020a056871c80800b0019e6b96f909sm7414342oac.22.2023.08.16.07.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 07:55:16 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6bcf2fd5d69so5839836a34.1;
        Wed, 16 Aug 2023 07:55:16 -0700 (PDT)
X-Received: by 2002:a05:6830:1bee:b0:6bd:603:797f with SMTP id
 k14-20020a0568301bee00b006bd0603797fmr1895493otb.37.1692197716644; Wed, 16
 Aug 2023 07:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230807153654.997091-1-masahiroy@kernel.org>
In-Reply-To: <20230807153654.997091-1-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 16:55:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1gXTNsy2+wXo4v19fE9yUtCXdh21wJsfH-Pcppf3tPw@mail.gmail.com>
Message-ID: <CAMuHMdX1gXTNsy2+wXo4v19fE9yUtCXdh21wJsfH-Pcppf3tPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] m68k: replace #include <asm/export.h> with #include <linux/export.h>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
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

On Mon, Aug 7, 2023 at 5:37 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> deprecated <asm/export.h>, which is now a wrapper of <linux/export.h>.
>
> Replace #include <asm/export.h> with #include <linux/export.h>.
>
> After all the <asm/export.h> lines are converted, <asm/export.h> and
> <asm-generic/export.h> will be removed.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.6 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
