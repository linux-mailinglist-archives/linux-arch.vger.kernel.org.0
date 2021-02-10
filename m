Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1BC3169D0
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 16:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhBJPMS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 10:12:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhBJPMP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Feb 2021 10:12:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF2D364E8A;
        Wed, 10 Feb 2021 15:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612969894;
        bh=hPXyaQSE16HS4JjkXDjB+KDzgBNn+pb7fdb5Az3QmIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JdBtByfhY5z2xzcHBsPMzh/Y7zogtHZws7c+QoiG4ExOuP/PqU8H6T5EVRnw0nMiu
         eldOEwRHFkh91TIZwmomWGOr1c3v4I4fnQLixDLgDu77i3kS+NVNe4ZRnH1iGCuh4J
         cPNfnVThCPiy9HNSnIwsG+U/qJwiYBZmwrmuM7zb4sVUAV/g3/qEfYsRgex4NAHfxd
         pW6dbjpG7H/OD3fJSw8qyW12izVQpdfPafYHEbuEwEZBcXwV5vWZnnXhNI2FDnkl5W
         rS3bhw5qn68yi7ZUucDgJn5ImAkJ+WUBmaWci7ECV1aOuwl9aCQ6pE0vaq+/sjIwlC
         JrGf54GnMSpqg==
Received: by mail-ot1-f49.google.com with SMTP id 100so2086243otg.3;
        Wed, 10 Feb 2021 07:11:34 -0800 (PST)
X-Gm-Message-State: AOAM533OeFFV769PMOSsF4lAIx6LoVjOlRNmi6yegyghs0bp+u0xp4Vu
        QksV/8KKqzor7WiImuFhtY01xgYAs6F6r2B3ifo=
X-Google-Smtp-Source: ABdhPJyxw25d4unAcUUXFmXp8RTny23ZJk4/Xuro9GkNCZIQ812tY8p2lZe8wiaU7n6ICxfP0MXLC6g8BwPVLEWfNdc=
X-Received: by 2002:a05:6830:18e6:: with SMTP id d6mr2448540otf.251.1612969894126;
 Wed, 10 Feb 2021 07:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20210210141140.1506212-1-geert+renesas@glider.be> <20210210141140.1506212-4-geert+renesas@glider.be>
In-Reply-To: <20210210141140.1506212-4-geert+renesas@glider.be>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 10 Feb 2021 16:11:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2qt0CpQ+o36Zz73_uap4ms8W0UAXS8Cd9BRoKMTCGL_A@mail.gmail.com>
Message-ID: <CAK8P3a2qt0CpQ+o36Zz73_uap4ms8W0UAXS8Cd9BRoKMTCGL_A@mail.gmail.com>
Subject: Re: [PATCH 3/4] asm-generic: div64: Remove always-true __div64_const32_is_OK()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Russell King <linux@armlinux.org.uk>,
        Michal Simek <monstr@monstr.eu>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 10, 2021 at 3:11 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Since commit cafa0010cd51fb71 ("Raise the minimum required gcc version
> to 4.6"), the kernel can no longer be compiled using gcc-3.
> Hence __div64_const32_is_OK() is always true, and the corresponding
> check can thus be removed.
>
> While at it, remove the whitespace error that hurts my eyes, and add the
> missing curly braces for the final else statement, as per coding style.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/asm-generic/div64.h | 14 ++++----------

Acked-by: Arnd Bergmann <arnd@arndb.de>
