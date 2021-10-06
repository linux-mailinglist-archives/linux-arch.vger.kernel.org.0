Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF98D424ABF
	for <lists+linux-arch@lfdr.de>; Thu,  7 Oct 2021 01:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbhJFX5F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Oct 2021 19:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239879AbhJFX5B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Oct 2021 19:57:01 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BC0C061755
        for <linux-arch@vger.kernel.org>; Wed,  6 Oct 2021 16:55:08 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id h4so3021569uaw.1
        for <linux-arch@vger.kernel.org>; Wed, 06 Oct 2021 16:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B4ajeKSZ6zrl/IB0WedwC0S+wNiZoyctPpDLShCHEUM=;
        b=pIkhDmGWJeYEN9fozHPXeTyvKCn9+mj6A8+OKhxD40jL7FUgp+QxIQ0LU2F+yaI90z
         6fbnqUSm/2gq38m9Z4M25MdzgOq4dm82QZddyXCbBeaR+zYgT0C+GHNvPqAcyiQnsPe0
         Omvtdyfqq08gQNMOY/uNV2o275Bj5B/jKTcMBRRoN3M7BpIN7zwCs5FakFet9DyaA5GI
         5hokhIbDCDmBQgnd4HnY2p8NuRvEp6xN5VtAg44SmHpx/wVvFAk3a9w/8uL8kA5CfQ8U
         BYIjblUJYfAkr1LHx+7MT6v5UNeyH4vzcdbBcNfL01MZn2CZDZHyyCS4IkViriSGLU/D
         xEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4ajeKSZ6zrl/IB0WedwC0S+wNiZoyctPpDLShCHEUM=;
        b=WPqiIN9H8gy/GsaAJHngWdfqYQRgvKkBVKGSiKrjwa4e5Spjv8PuH4LMNUJLHty7Ou
         ornnCEfVkP/k0/oSAV1PqQaR8ZxnNKQjXcRtybdVaQgKgiEp01iYRsRJflGxERIG+X3v
         GyXRkAxqp/Ii/WE10TdSuqFs70rQoj0IwTvXCWVgh15SfLMQCS1KgwDtTK/cnr+hSKzV
         0umQdMrtRKE/bZIBO4PcaOK2jwz9bgWaM76anPLKJrr3YFaICvEgR75qnR2wlSB1SZvQ
         Qw6Axn6rWyaPIlk1Cp7Ew7TFld5+ES/DYMQePDhS4mgPuyEpNLDHcr0BETq0/W0jIEFl
         w0fA==
X-Gm-Message-State: AOAM5311gQpVU0yK+E0HGWNIiuBaePA08eOROLeeEw7MoEGlMUOQ3Tta
        w7Kjq95CuGeSoQV0NbJmXimy41TBfyYsL01QeSWL3Q==
X-Google-Smtp-Source: ABdhPJw+X6oiB/9ybWUt6uVNGwcJLEY3tJcxy/XsK7WUZQomWvE5wc821nETpGDf4vcZdPvCt7q2BiwTgv5maa+DMGo=
X-Received: by 2002:ab0:540e:: with SMTP id n14mr1569319uaa.73.1633564507507;
 Wed, 06 Oct 2021 16:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211006224311.26662-1-ramjiyani@google.com> <YV4nnko8rmWAWj2+@gmail.com>
 <CAKUd0B-9ifaMBAxhaUZjppks8PCy4oCy=erRNnPBjrRxOGKUxQ@mail.gmail.com> <YV4yevOZqSJJVuVJ@gmail.com>
In-Reply-To: <YV4yevOZqSJJVuVJ@gmail.com>
From:   Ramji Jiyani <ramjiyani@google.com>
Date:   Wed, 6 Oct 2021 16:54:56 -0700
Message-ID: <CAKUd0B8ycmPuV31VoULyENuK74W8ZE-hC08LTbwv+Az9R4c2mA@mail.gmail.com>
Subject: Re: [PATCH v3] aio: Add support for the POLLFREE
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     arnd@arndb.de, viro@zeniv.linux.org.uk, bcrl@kvack.org, hch@lst.de,
        kernel-team@android.com, linux-aio@kvack.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Jeff Moyer <jmoyer@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 6, 2021 at 4:34 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Oct 06, 2021 at 04:28:23PM -0700, Ramji Jiyani wrote:
> > Should the Fixes tag refer to Commit bfe4037e722e ("aio: implement
> > IOCB_CMD_POLL") [2] in this case?
> >
> > [1] https://lore.kernel.org/lkml/20180110155853.32348-32-hch@lst.de/
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/fs/aio.c?h=v4.19.209&id=bfe4037e722ec672c9dafd5730d9132afeeb76e9
>
> That's the commit that introduced this bug, right?  The binder change was
> earlier.  So it seems the answer is yes.
>
> - Eric

Thanks Eric. I'll send the v4 with exact commit where the issue start
manifesting in aio with updated description and Fixes tag.

~ Ramji
