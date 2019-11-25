Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11454109574
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2019 23:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfKYWOI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Nov 2019 17:14:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33803 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYWOI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 17:14:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so20089590wrr.1
        for <linux-arch@vger.kernel.org>; Mon, 25 Nov 2019 14:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnocSK9XyUn0ZqlRMZJ3ltGSG/toAyjUkuU9NoNKaus=;
        b=iqKrqJ467f0yKnyUk2TEn7njBaXQRj8M0Rc/aiVW6T+ie+T8RsfiYEC/b24uI03x+K
         d4eMcHF5Q3VuQTSvaN6z+JJ4GTJaOkzM1o2Wk7Pi8x6YOXguasuFUA9uUiNGJ+kLZI52
         yNHiTW2kFN5GVkaw6WDD6LvojEoWIdVRCJncWIRjCVdZstoS3Eci6Vcf8KsIFMtYg7Kv
         YBs7A5D4cPhZ1fgT+FVsHHd9gUO8QS1suwko/fcaK9m1d15i1X+eM+TklmEN8IQxhXUt
         ELuEqrqXpsc6quoQQeq50wNtSu2CQ0tmJ9gQ9Si/P25T0+fw6c/DztYozjKYxVfH9O8u
         h/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnocSK9XyUn0ZqlRMZJ3ltGSG/toAyjUkuU9NoNKaus=;
        b=t/45yE3gKl5U1Zw0gRBH8NgNM4LASALiwUoNedY6Gwotbd0US0aysLkiG1KYHJwoe3
         3sZL9iYjJxyNLSux+PAjwCUju1KKkaX1CSDYfs60OKcoqeJbUmupeZDLEnARK5qT+D9S
         zkxCBxNFB+wS72YZJ3J74WIHAASVsBjFxhSn9nzcFxGxJdbPVCWlC1ZubC1vQr/d6UDW
         4uYV4x1SPgyhad+yKJmhIFhxQ6bm9hlXD6YVU63/iwOPYtL+f0IEvjEftG/TcpA4LkZu
         K1cJR/EH01leEqvhvnDf1to3WeWMDyq3N5ryaWWfk70ElD57oNvebbJlgd+ZEm0IIbp7
         BVLQ==
X-Gm-Message-State: APjAAAUjrMrtudBRcK0FPPtXv5nxk0ZC8DcILAeF/pzI1wc9dVXOFu4Q
        WwrWkGuFs2pzFyQ8zZdA+FQT2f60KjtHxARbJrsvRxLikDE=
X-Google-Smtp-Source: APXvYqw+SM8WZpl4YyskjYCiWihobJQJUzJayThi9uiNUzS6AIGMAqFkbfBfF/nWqznjg+i0hGz/etrio18EQLRbYUA=
X-Received: by 2002:adf:de0a:: with SMTP id b10mr33987695wrm.268.1574720046298;
 Mon, 25 Nov 2019 14:14:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com> <567fd4d5c395e2279e86ca0bfca544ad2773a31d.1573179553.git.thehajime@gmail.com>
In-Reply-To: <567fd4d5c395e2279e86ca0bfca544ad2773a31d.1573179553.git.thehajime@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 25 Nov 2019 23:13:55 +0100
Message-ID: <CAFLxGvxytmS4WSFj2ibyJKCuR5TbspdNf6MvHNvzh9dtKx2rJg@mail.gmail.com>
Subject: Re: [RFC v2 07/37] lkl: interrupt support
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org,
        Michael Zimmermann <sigmaepsilon92@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> Add APIs that allows the host to reserve and free and interrupt number
> and also to trigger an interrupt.
>
> The trigger operation will simply store the interrupt data in
> queue. The interrupt handler is run later, at the first opportunity it
> has to avoid races with any kernel threads.
>
> Currently, interrupts are run on the first interrupt enable operation
> if interrupts are disabled and if we are not already in interrupt
> context.
>
> When triggering an interrupt, it uses GCC's built-in functions for
> atomic memory access to synchronize and simple boolean flags.
>
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
> ---
>  arch/um/lkl/include/asm/irq.h             |  13 ++
>  arch/um/lkl/include/uapi/asm/irq.h        |  36 ++++
>  arch/um/lkl/include/uapi/asm/sigcontext.h |  16 ++
>  arch/um/lkl/kernel/irq.c                  | 193 ++++++++++++++++++++++

Like I said before, this also something to unify with UML.
I'm aware that this is easily said but we cannot have too much duplication.

Feel free to ask if UML internals give you headache. :-)

--
Thanks,
//richard
