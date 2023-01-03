Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD7A65CA73
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jan 2023 00:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbjACXjr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 18:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbjACXjm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 18:39:42 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48956167C9
        for <linux-arch@vger.kernel.org>; Tue,  3 Jan 2023 15:39:34 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-45ef306bd74so457456027b3.2
        for <linux-arch@vger.kernel.org>; Tue, 03 Jan 2023 15:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KJI36WUyX3/lg5q+41u1VLOHfo9VaH4c9Ww4np9pMVE=;
        b=C0Mv/9IL2kuCPPdWA8msop6QpZ3EpuOLH1kfR1zVpw/f4AUbyJBD+6G/iANVtk22ds
         hu5duuhrQjxm+1Kp4nKH6+kqp9XMhdkuQv3ErYIW7UH7XgBdnhBAn/M9ORQcscUmKxsQ
         YKQl+Y2WcFCcO/NKx0eYOqQf3MKFdo1QloKx5psY6iMcrO+/NTuvhAHB2hpKlW55yHXD
         ABIkQWJYkDINemtlyOBeLXVmwbXTOByw6YXnv1VfjGrBnOKwaFyEDMunh+tiQj/hgoat
         k9t1e0q1Cg4EIWuUG6Vuqs9jd9SCiXm/BoDYSI12xTkYfSTIxWWueNsZ1JVWJX5WEnWJ
         p9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJI36WUyX3/lg5q+41u1VLOHfo9VaH4c9Ww4np9pMVE=;
        b=Eix57XZrhemzjlSyW9gcq07jFJm+q2HSSwzFDb9Ef7xF4ZqHb32VRt4ClVdnOaKwHU
         +9o5FHRwSIz0SHkELaeeF4TNcK0RF7dN3eMjBXJSh3MyAB66Ka33Pu4bKwLknnBypMoQ
         ILBeHLALnh117nCUEG8KPAIeb2dgNV2LHMsXOJtZpGQY0AmqdrMBVwT4VTCMkVIZmdnw
         JRhAJPsldazK4TN9Cr5BfOOKKy6h2gPN4rRUSlkpGGOYKreNY6fZ6xCmFFVEDXtodK7r
         Rd/I1srA0TtBfr25o3HlU1C9IEIoLVIfKXWsAW81WVKrowJEIXQyB8ZZu16LTZ5rcMzi
         XcBw==
X-Gm-Message-State: AFqh2kqvi9Ez/zY4jwSY1zDLzOX0IVT7PJw3pSIE2x8UJx6mA/ahBLfH
        mfLnOvZvRIea9pfHotWplGE+5hhRyKmCQVAZwJnYmA==
X-Google-Smtp-Source: AMrXdXvx+mmANx48xLrOqbQThKhH6zIY5rRl2OxAt8bBN55Sv7hiEKHnG69rb1VP2Uv9FiN2mXvWkniEDvOJav50QZw=
X-Received: by 2002:a81:5c85:0:b0:461:49a3:db6a with SMTP id
 q127-20020a815c85000000b0046149a3db6amr3875030ywb.185.1672789174162; Tue, 03
 Jan 2023 15:39:34 -0800 (PST)
MIME-Version: 1.0
References: <20230102210850.25320-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230102210850.25320-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Jan 2023 00:39:22 +0100
Message-ID: <CACRpkdYw+J2cPfMrRtUC1KNLyWn__8Q3uk5j=WP_JN-Hm2AALg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Remove unused and obsoleted gpio_export_link()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arch@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 2, 2023 at 10:08 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> gpio_export_link() is legacy and unused API, remove it for good.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Good riddance.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
