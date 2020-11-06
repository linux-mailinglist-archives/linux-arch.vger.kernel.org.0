Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289532A92D9
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 10:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgKFJgV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 04:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgKFJgV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2020 04:36:21 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD88C0613D2
        for <linux-arch@vger.kernel.org>; Fri,  6 Nov 2020 01:36:20 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id o13so672575ljj.11
        for <linux-arch@vger.kernel.org>; Fri, 06 Nov 2020 01:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q326GXxs8YkWuvBRrekt++B5YyugaqPURgSA3otIq6U=;
        b=XOdrV8ei8AtuxGdV1ULzurTDZi9h0STRi4e6h9KSaQcs9JaVCAn0s20MSYRGsfiFhS
         cAQ5HcxJvNf0bcm1aZwo8OiJ6W0Fup+vqbs+neWVychssgU12cZHqou2LvwZxZ5+zw/O
         UbY+h3caECgBTLExtoKALN2LeSJxBz6tIItFeB7JXnns2q5n4Um4KSY+uNaYOmCdF167
         NJtEYQhcNGeAodeU/Pg9ZM0jYbX3UIxHAPtpN3fZkoLi9Yo0dKHqYBv2dMTK3YUSmFaA
         IfnlybJGiKErfJm73wIsfRzvHBwMNHy3ybeANKJ4joxvD1nWgm+PtNMAh5sXYCS5e7k8
         xGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q326GXxs8YkWuvBRrekt++B5YyugaqPURgSA3otIq6U=;
        b=PMug+A8ghpyDLuQlHpRCp4ur9rweqsqv8JZFJAAoi0NaGLz7O13Mu5HxOKsnHNsqcN
         bnkmUo712fm4V7TETRkK6ku/YXPCjSo48DqqtQt7enqwuIT2oHJ9smSdDqyT28wAlbKU
         FWsLCa6qiF4Vf4Kgz1pmTzAgRfpP08yJDIqPDxeDpVk22PopAq+910gDjSsf7aagniUn
         9c1erzUb9I9ohv+VVT3NGPL6zOAM2fXr7AYgTMRaQGnWuRydRz2Hy6s2KZj20T2JDFFt
         ILDd1a8oi3k4b0PamI41Sk5MEDithd9Bru6fU46CpFrUteUqbefeEFfEYA9b2nwglLLl
         XUJg==
X-Gm-Message-State: AOAM530V1Ixu3AKZrlfe+NXuOQpOlRBPUZOmxSv+R+QMOn35OsmZduuk
        yXC2zODi2+B/2sl7lrEz8krVLGYLpH+EdjdUpPsAJA==
X-Google-Smtp-Source: ABdhPJzROlV5g3M3Pzjhr+1raVc/1hLidCyn5chZ4duWrpT16uo1Ir8x1bNuTAoV3x713D+qUJtWOjkKrtVhYQnc/ao=
X-Received: by 2002:a2e:80d2:: with SMTP id r18mr465456ljg.286.1604655379127;
 Fri, 06 Nov 2020 01:36:19 -0800 (PST)
MIME-Version: 1.0
References: <20201030154519.1245983-1-arnd@kernel.org>
In-Reply-To: <20201030154519.1245983-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 6 Nov 2020 10:36:07 +0100
Message-ID: <CACRpkdauAb+Rss7XU5tNyi8BwhSdPiTJwy+YL08dkf6VnNkd-g@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] ARM: remove set_fs callers and implementation
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 30, 2020 at 4:45 PM Arnd Bergmann <arnd@kernel.org> wrote:

> This is the rebased version of my ARM set_fs patches on top of
> v5.10-rc1, dropping the TASK_SIZE_MAX patch but leaving everything
> else unchanged.
>
> I have tested the oabi-compat changes using the LTP tests for the three
> modified syscalls using an Armv7 kernel and a Debian 5 OABI user space.

I tested this patch set on the ARM Footbridge (SA110) with an ages old
Red Hat Linux OABI userspace.

It works.

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
