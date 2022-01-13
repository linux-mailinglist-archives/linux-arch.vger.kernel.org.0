Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A1D48D685
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jan 2022 12:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiAMLPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jan 2022 06:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiAMLPK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jan 2022 06:15:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA67C06173F;
        Thu, 13 Jan 2022 03:15:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 364F961203;
        Thu, 13 Jan 2022 11:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99751C36AF4;
        Thu, 13 Jan 2022 11:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642072508;
        bh=tmokVRuMXpkRXv8oyzytWI3owOE0aSeiLqaiU0qB/+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F/jx0aBe8ep2hAZigf+cBZzT5PCjEoM6TUCokq1sCt6wGpHi8Au3IqVQrAmWU0IzB
         7/nQh7AA/oTI3LZIWixmZbLTfKU6QgoMURzFf+10m9VhA7c7bEFErwuYBmu7SjmdMx
         LmxgkVX8OCtZkDdEuNRQMjcsEbeGsJQl3lL8W0g4tfDTwiKf+jzPBj8Y6cyLH9Cwkq
         2WiPrUlDRfuOwe/noRrmCVAIXrDSue6P+PyOtIB1yU936ZcwGoslCx1DLXMYLG0MQY
         9bGyqoXCC0E/2dmEUGkpqH7M/A7tq4wSX4hL1nFB3UxK1QcsQkqC/aRQ5hv1bu0kge
         iY6bBlzU20uSQ==
Received: by mail-wm1-f42.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso3389830wmd.5;
        Thu, 13 Jan 2022 03:15:08 -0800 (PST)
X-Gm-Message-State: AOAM533EArxmwq4ADz6ZzYiIXW5RP6s3hL6EypH5Tx4w1ZyYmP/sgmdy
        D5OQPpV1x/hCJYlDvVFy4KXEZQBl+E6tUwk8h3s=
X-Google-Smtp-Source: ABdhPJwst+Tin12ujQYauaQcgLDiP82T5o8Qz/3cNaqDiW6X+iWOz0mouWb+fJ3aWoJYBb323ZOOm+CRoGY0Ep7lBUY=
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr10512756wmf.173.1642072506896;
 Thu, 13 Jan 2022 03:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20210726141141.2839385-1-arnd@kernel.org> <20210726141141.2839385-9-arnd@kernel.org>
 <Yd8P37V/N9EkwmYq@wychelm> <Yd8ZEbywqjXkAx9k@shell.armlinux.org.uk> <20220113094754.6ei6ssiqbuw7tfj7@maple.lan>
In-Reply-To: <20220113094754.6ei6ssiqbuw7tfj7@maple.lan>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 13 Jan 2022 12:14:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0=OkFcKbL+utDPTPf+RskFNdR8Vt-3BEWkO9g_FqSj5w@mail.gmail.com>
Message-ID: <CAK8P3a0=OkFcKbL+utDPTPf+RskFNdR8Vt-3BEWkO9g_FqSj5w@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] ARM: uaccess: add __{get,put}_kernel_nofault
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
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

On Thu, Jan 13, 2022 at 10:47 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> On Wed, Jan 12, 2022 at 06:08:17PM +0000, Russell King (Oracle) wrote:
>
> > The kernel attempted to access an address that is in the userspace
> > domain (NULL pointer) and took an exception.
> >
> > I suppose we should handle a domain fault more gracefully - what are
> > the required semantics if the kernel attempts a userspace access
> > using one of the _nofault() accessors?
>
> I think the best answer might well be that, if the arch provides
> implementations of hooks such as copy_from_kernel_nofault_allowed()
> then the kernel should never attempt a userspace access using the
> _nofault() accessors. That means they can do whatever they like!
>
> In other words something like the patch below looks like a promising
> approach.

Right, it seems this is the same as on x86.

> From f66a63b504ff582f261a506c54ceab8c0e77a98c Mon Sep 17 00:00:00 2001
> From: Daniel Thompson <daniel.thompson@linaro.org>
> Date: Thu, 13 Jan 2022 09:34:45 +0000
> Subject: [PATCH] arm: mm: Implement copy_from_kernel_nofault_allowed()
>
> Currently copy_from_kernel_nofault() can actually fault (due to software
> PAN) if we attempt userspace access. In any case, the documented
> behaviour for this function is to return -ERANGE if we attempt an access
> outside of kernel space.
>
> Implementing copy_from_kernel_nofault_allowed() solves both these
> problems.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
