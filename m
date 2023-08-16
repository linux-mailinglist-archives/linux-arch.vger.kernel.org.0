Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D888677E44A
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 16:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245597AbjHPO4Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 16 Aug 2023 10:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343874AbjHPO4G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 10:56:06 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8691F272D;
        Wed, 16 Aug 2023 07:56:02 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6bcae8c4072so4570559a34.1;
        Wed, 16 Aug 2023 07:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692197761; x=1692802561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWptNDRMUs2ZAaEq3Zc4y6Na38OgEqP5UG5bQfgs1Ds=;
        b=Gnbmq5NW89cQWQJeLGu0ug/M7e8UAr4sWshKv4b0THkz0VpZOnpoi6YwaLhiXPQ2dL
         02/l/Brf23WEGgp624YfIIXiCMsRA4wzLeUaUAgdtdkBfhqjJDWAJ6/fl+BuzCS9/yQG
         J1s1A5m1TfXtWd/lEM/7ygd8jxFFSOfj7mdPS/8+EOpiFQd631QAt7xik0jv/pbre1SN
         nFpLc4+YM4iz3PAtZyEtyRT2pwjavnqjNA1Hy1vEqQfwBlXumc1u/kecnhLuWEnpRx5a
         +X/ArzZtyalfapmS69nbb8Wm9bnZBKptqkK+CPMxA64z8cjIbC2HWIxPUAVpIiCqwqMB
         PNig==
X-Gm-Message-State: AOJu0YxCETPgKlnhdf9g4e/mpaS59J277hT4ntomap4/yvKtqcnHrgbk
        ugVJIfSxKPN+by4x6Ad4InQHntA7TdzN3Q==
X-Google-Smtp-Source: AGHT+IENGBuAlF/G+wJ9MAnku8l5MC5rYetIOjV3QbRtQDb9I2ZJaZdBCjJKMfRNRQkwrNXmT340Xg==
X-Received: by 2002:a05:6830:18b:b0:6b9:c5b5:6a96 with SMTP id q11-20020a056830018b00b006b9c5b56a96mr1873533ota.6.1692197761631;
        Wed, 16 Aug 2023 07:56:01 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id j2-20020a056830014200b006b8b55297b5sm6272775otp.42.2023.08.16.07.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 07:56:01 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6bd0c953fd9so4553875a34.3;
        Wed, 16 Aug 2023 07:56:01 -0700 (PDT)
X-Received: by 2002:a05:6358:6f1b:b0:135:499b:a68c with SMTP id
 r27-20020a0563586f1b00b00135499ba68cmr1098840rwn.8.1692197760871; Wed, 16 Aug
 2023 07:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230807153654.997091-1-masahiroy@kernel.org> <20230807153654.997091-2-masahiroy@kernel.org>
In-Reply-To: <20230807153654.997091-2-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 16:55:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWqXKZOFAemsYB=5d+eOZdANh=KYhiE18otKPLPp4pP6Q@mail.gmail.com>
Message-ID: <CAMuHMdWqXKZOFAemsYB=5d+eOZdANh=KYhiE18otKPLPp4pP6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: remove <asm/export.h>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 7, 2023 at 5:37 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> All *.S files under arch/m68k/ have been converted to include
> <linux/export.h> instead of <asm/export.h>.
>
> Remove <asm/export.h>.
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
