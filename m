Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53D82EFF49
	for <lists+linux-arch@lfdr.de>; Sat,  9 Jan 2021 12:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAIL4U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Jan 2021 06:56:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbhAIL4U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 9 Jan 2021 06:56:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C80C423A3C
        for <linux-arch@vger.kernel.org>; Sat,  9 Jan 2021 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610193339;
        bh=u3NbI55l4MsFTvpxJ3mJbsQRiePIoGilb3r9FUpSqig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FSjGoSu3Q2y0Il8BWa+1W5ql/1AlkcOwqcoNg32WJv4m+l3ZukNS+ui/DylOg18EJ
         II8uQTLQ33xIuX1mFHxp8r/T6+YslrcAGNQB2+gS92o/WYELtOPO6v7C1cdTkHY2z7
         3gx4w/KNpDk0TpFIGoECd28FCLfUpoGWuhmMIPvulBwmVKdmQug7A5inF+il/RpSfL
         xOe5BeMg01TgahWFL81dY6lXhBPpVtB6FmeTtwABltmPOHjdjaHHMdUHMGCjEzxt4l
         rJggKfihy/OE037gR0pTGEnMRPAdofBKdSLgiGYGkGwD+EL4mt7pCYcF30osRAPudv
         gVddkBYc0ioNA==
Received: by mail-oi1-f182.google.com with SMTP id q25so14596731oij.10
        for <linux-arch@vger.kernel.org>; Sat, 09 Jan 2021 03:55:39 -0800 (PST)
X-Gm-Message-State: AOAM531dQQ9he5FXRx1IwTqHQEjJQRjk6YzGsSW9eCCStvcry4MMYMpi
        nFjaIE83ld2L1hcilvkR50Yy4L6GRcqb1VuNcGY=
X-Google-Smtp-Source: ABdhPJx1kiCIkKhFfwfsPZ1GXmRRt4NoAoeyEo5M8rl4oGVRLIfAHaAJqPv2/VZYPKkrIdlcmeE83zljGVwmZlQDgZA=
X-Received: by 2002:aca:44d:: with SMTP id 74mr5090984oie.4.1610193339178;
 Sat, 09 Jan 2021 03:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20210109065828.1528262-1-yangerkun@huawei.com>
In-Reply-To: <20210109065828.1528262-1-yangerkun@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 9 Jan 2021 12:55:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3dQfmTKGA-i4izmCt=4opOs-YWnpYNudeqzncnkvKxAw@mail.gmail.com>
Message-ID: <CAK8P3a3dQfmTKGA-i4izmCt=4opOs-YWnpYNudeqzncnkvKxAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] syscalls: add comments show the define file for aio
To:     yangerkun <yangerkun@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 9, 2021 at 7:58 AM yangerkun <yangerkun@huawei.com> wrote:
>
> fs/aio.c define the syscalls for aio.
>
> Signed-off-by: yangerkun <yangerkun@huawei.com>

This is obviously correct.

However, as Christoph Hellwig suggested the last time this came up
for include/linux/syscalls.h, let's maybe just remove all those comments
altogether.

What I really want to do with this file though, is to completely remove
it altogether and replace it with a syscall.tbl file as we have it in the
architectures that do not use the generic table.

If you or someone else wants to help out with that, I can point
you to the last version of the proposed patches for that from
a few years ago, and guide you through what else needs to be
done before it can get merged.

       Arnd
