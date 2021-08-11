Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372593E8B16
	for <lists+linux-arch@lfdr.de>; Wed, 11 Aug 2021 09:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhHKHcN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Aug 2021 03:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbhHKHcN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Aug 2021 03:32:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3899760EBD;
        Wed, 11 Aug 2021 07:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628667110;
        bh=mtgL+TewTjL/J591sAI5LQuP3blpaY9K05ufSeoRX3c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vBnUFgyOZV7R3876Hz4qqRSAKIzZv5GUoL0iXtaRswPijBl9kdYA+6OXr+1GtA1Lo
         Y25TKCFD9QNj8Y+IEWgkpNCNLAbpyS6wN6HjeoHPdpddukcvgYWgWmZuVA1qZVY1ta
         /JYbPYE+jljCzg3bjRZJg9PE+vzaRXOP01qxwucvbpHKv1EmQ8jZuCliBoVwv29Zzs
         jtwOHgFQGVYA/CjgX1hW010/O5D/aDI9nx5ehVZWlSf8/uC9oLvWhLt31jY6mK3C3W
         I5sXEXLnQFFVr98IG1Z6hLRTAHsG/3TQO5w9rIlJT4hzRnTUNmm76Hi09ThCWqpY6p
         ASLqIKWW1FvrA==
Received: by mail-wm1-f48.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso3684318wmg.4;
        Wed, 11 Aug 2021 00:31:50 -0700 (PDT)
X-Gm-Message-State: AOAM532rxiG3SsTjlA6YLuZtvaFbDofBthrBMVaynvPpCswa4kVOG5I8
        /tbrFjPlGkOOPNU7V9/Y6RuF9P/Bbkrr6JllZGo=
X-Google-Smtp-Source: ABdhPJza5YqWz118KynNjbnjYQmGJ2D0uhOBcFej6fVLAMreII/eTgUTKqnvy0Wr0EmnqDHjvEU+iQ9kbXB7xdMaDtk=
X-Received: by 2002:a05:600c:3b08:: with SMTP id m8mr8472833wms.84.1628667108840;
 Wed, 11 Aug 2021 00:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210726141141.2839385-1-arnd@kernel.org> <YRNwmGL2b52dQUuv@infradead.org>
In-Reply-To: <YRNwmGL2b52dQUuv@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 11 Aug 2021 09:31:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3aCgy5z4sNWO_xbV2PwdrW1c6eavRYeMT3WE91eG65rw@mail.gmail.com>
Message-ID: <CAK8P3a3aCgy5z4sNWO_xbV2PwdrW1c6eavRYeMT3WE91eG65rw@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] ARM: remove set_fs callers and implementation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 11, 2021 at 8:39 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> From my high-level perspective this looks great and I'd love to see it
> merged:
>
> Acked-by: Christoph Hellwig <hch@lst.de>

Thank you for taking another look, and for the reminder. I've now added the
series to Russell's patch tracker.

       Arnd
