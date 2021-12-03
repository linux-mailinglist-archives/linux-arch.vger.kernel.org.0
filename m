Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A30467053
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 03:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378239AbhLCC7g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 21:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243536AbhLCC7g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Dec 2021 21:59:36 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045D1C06174A;
        Thu,  2 Dec 2021 18:56:13 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id j2so5098181ybg.9;
        Thu, 02 Dec 2021 18:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mcSwEVV3L74Lz8W1o09yWpvzHlz/Zarr/lRvwobBgv4=;
        b=QA5ip1sD9KRTeBlMRjccMu2+IABtf5sPX1Xhpxh2K72/sosAAtrD9u/IV0H0OtOKpN
         u7aEH45MfrSWZwKr+ZnUVi4VgvldmBcsiTUgfNqSFV3Ydcjncm9fW+KKg7YpzvAItaur
         JJf3YzmGhM63u5VOs19lscKauc1m8yETEpFo3EvIuviEOXtotat2OnF2Rsy8Dyj9k5af
         9fqjnrDkRQ+3MJVObZYqAv7Ipnui37x3oyOkn7941WY1pe8FyghVgdhMxnupSjLfCu+0
         ZTwejZVURODPXC9eCd7+zt0TwLp02Mm3h1DPOuNYBfIbfwzriYCkiWdFQwTzDNePk+22
         IaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mcSwEVV3L74Lz8W1o09yWpvzHlz/Zarr/lRvwobBgv4=;
        b=uKRDWZjK7LQpPApyoU1oq7s9z09HIw8YRMZM3q0dlB4xKpgZtJYus/0bXMzbKB8zLy
         uU5hGuRL6IcBKAlsWdzdsBvOAixjEUwiuWU1R/V95dWBJcrjO+zTyiv0fzTnybv6DIha
         DPB2jAhwjcta47ZWfjZQUyjeZI/7QPWVvPKcU48aaznpi7m3lq8ZHSm2J9Dx/B4n35Gv
         BLVIbgLsZv1Gk9uZfBBU7IzM8tm1PcQQyCgsmnWkOJ0STZUN2vj9SqWXCOMc/eCWRFUm
         nn2HYf2d8oomJPRzIFyYnIzpyXKEcKSbDr4/HnDYGJDAZabcCJWrkbZjNPVIQ2BZ4W62
         3x/g==
X-Gm-Message-State: AOAM533DhcI5krspbMltEhIud6RbHRajDjhnz0JZiZrF9jvtht8sCn+2
        LqknfSt6QaqbUNfQC6AHod4MqpgU+K3SZOsc51U=
X-Google-Smtp-Source: ABdhPJyLBuv05Oy+ZYvBEP47D87Mpu7YWaNwh/EB1PjyCee/KHFindJezAJ26cGW5ntY28aM9IDsR4HLYC2N82xaHYQ=
X-Received: by 2002:a25:aba3:: with SMTP id v32mr18414629ybi.358.1638500172177;
 Thu, 02 Dec 2021 18:56:12 -0800 (PST)
MIME-Version: 1.0
References: <CAMgLiBskDz7XW9-0=azOgVJ00t8zFOXjdGaH7NLpKDfNH9wsGQ@mail.gmail.com>
 <673c5628-da97-83d3-028f-46219f203caf@redhat.com>
In-Reply-To: <673c5628-da97-83d3-028f-46219f203caf@redhat.com>
From:   fei luo <morphyluo@gmail.com>
Date:   Fri, 3 Dec 2021 10:56:02 +0800
Message-ID: <CAMgLiBsGcTq8yoa1Rud0-qiRk11uChyS=CU8+5KTw35c2YmyBw@mail.gmail.com>
Subject: Re: [RFD] clear virtual machine memory when virtual machine is turned off
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, xiaofeng.yan2012@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

David Hildenbrand <david@redhat.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=882=E6=
=97=A5=E5=91=A8=E5=9B=9B 20:47=E5=86=99=E9=81=93=EF=BC=9A
>
> >
> > Although this part of memory will be cleared before being reused by
> >
> > user-mode programs , But the sensitive data staying in the memory
> >
> > for a long time will undoubtedly increase the risk of information leaka=
ge,
> >
> > so I wonder whether it is possible to add a flag (like MAP_UNMAPZERO)
> >
> > to the mmap(2) system call to indicate that the mapped memory needs
> >
> > to be cleared zero when unmap called or when the program exits.
> >
>
> it's not immediately clear to me why data of user space program #1
> should be more important than data of user space program #2 and why the
> program should make that decision.
>

What I mean here is that by adding a flag to the mmap(2) system call to
indicate that this memory will be cleared after munmap() called or
the process exits, and no sensitive data will be left in the system memory,
so as to avoid information leakage after the process exits.And the task
of clearing memory needs to be done in the kernel

> >
> > Of course, the page clear operation not only occurs when unmap called
> >
> > or program exits, but also need to consider scenes such as page migrati=
on,
> >
> > swap, balloon etc.
>
> What about page migration (who clears the old memory location?),
> swapping (who clears the swap space, also considering zram?), writeback
> (who clears file storage)? Also, as you indicate, MADV_DONTNEED,
> MADV_FREE, FALLOC_FL_PUNCH_HOLE would need care ...
>
> To disable swapping you can use mlock(). To handle file storage ...
> don't use files. You'd still have to handle any cases where physical
> memory locations might be freed and land in the buddy, and for that we
> do have ...
>

Yes, this feature needs to consider when page migration, the content
of the old page needs to be cleared, and the swap space needs to
be cleared before swap. Of course, for security reasons, swap can be
prohibited. Here I just listed some of the changes involved, not all
aspects. This feature is mainly aimed at clearing the memory of
the virtual machine after shutdown, so it is more aimed at anonymous
mapping and huge page mapping

> >
> >
> > When reusing the page that has been cleared, there is no need to clear =
it
> >
> > again, which also speeds up the memory allocation of user-mode programs=
.
> >
> >
> > Is this feature feasible?
>
> "init_on_free=3D1" for the system as a whole, which might sounds like wha=
t
> might tackle part of your use case.
>

This feature is mainly to prevent the used memory information from leaking,
not to clear the memory before use.

--
Thanks
