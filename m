Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA33D5BEBB
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jul 2019 16:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfGAOwq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jul 2019 10:52:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35560 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfGAOwq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jul 2019 10:52:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id l128so11201955qke.2;
        Mon, 01 Jul 2019 07:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8vmjDkKg4IO+8ZBKSp4zM+NgMMD++q8FkxpBsbCpHA=;
        b=j4xH4CAu5xGO+AZyyrmksvTACmb22FpmkabHdf7ctqbJHHH0MyxfatqxIIwO8RPDjw
         QzeDTDeLpFiQkUmQKIB2M6+AiTsxPsrMFrQ+UcD84Rw5EZY/o53H430Z2Osm5+JuSMVI
         C29IIO9CRaJEpRPzzdnrNl43TfCJk+4yIfI8vY2SIe7B4HFzNkNs2o33WxKGYvURZumz
         /8IjicnRpl4prtP01P1qXCrPYkDb0J08Thg6K8aLIklQ4w+ynqd6CBgaIEOdBwbV/uih
         qr+kLKRR7lfe4lgtj26zWoUlbqEq2B4xWZgojcCss8VNJOekub+Xuql8VLz6yE/HHwzb
         wlJQ==
X-Gm-Message-State: APjAAAXWRmkP3TD+pPiACC/Gi4DrfGcqJSxHinz6YOmdPX6r4yczxnn0
        4WrN/Z9nDbDu/wwGixyqlAq/4LHDF1y7YhAjnuoAUOtQ
X-Google-Smtp-Source: APXvYqyiqLQH0FwzeWVQkplQlVrAvIzjMLfIwmR9uTToLvNIvv3bXEo3v/9IswaUESv3fV1Bm2DVGDnlusTREN9Aujo=
X-Received: by 2002:a37:ad12:: with SMTP id f18mr20637160qkm.3.1561992765583;
 Mon, 01 Jul 2019 07:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <1561786601-19512-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1561786601-19512-1-git-send-email-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Jul 2019 16:52:29 +0200
Message-ID: <CAK8P3a0F5-wtJHbLvEwUXE8EnALMpQb5KeX4FK3S90Ce81oN-Q@mail.gmail.com>
Subject: Re: [PATCH] csky: Improve abiv1 mem ops performance with glibc codes
To:     Guo Ren <guoren@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 29, 2019 at 7:36 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <ren_guo@c-sky.com>
>
> These codes are copied from glibc/string directory, they are the generic
> implementation for string operations. We may further optimize them with
> assembly code in the future.
>
> In fact these code isn't tested enough for kernel, but we've tested them
> on glibc and it seems good. We just trust them :)

Are these files from the architecture independent portion of glibc or
are they csky specific? If they are architecture independent, we might
want to see if they make sense for other architectures as well, and
add them to lib/ rather than arch/csky/lib/

Should the SPDX identifier list the original LGPL-2.1 license instead
of GPL-2.0?

       Arnd
