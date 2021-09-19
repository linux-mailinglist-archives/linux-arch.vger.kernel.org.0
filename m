Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136E6410CC5
	for <lists+linux-arch@lfdr.de>; Sun, 19 Sep 2021 20:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhISSHU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Sep 2021 14:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhISSHT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Sep 2021 14:07:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F529C061574
        for <linux-arch@vger.kernel.org>; Sun, 19 Sep 2021 11:05:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c8so57059267lfi.3
        for <linux-arch@vger.kernel.org>; Sun, 19 Sep 2021 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dt0bdr19C9tveZGxRDpZWZkwhwTc1xLEzCQ6ycqFREc=;
        b=QUPw4B4Z2u2NnyiTdXo6yX631GZyxkJFyi4+k/T0C1rSGK7VAZgzf/9Yi8h5CEk0w7
         zRDeYvhsnE4EXNBjshUWjylNOFi08Y+ETtZDqY0X8+PQv28O4PLRYTRB+XJBuin6i5f3
         aKjHvHchUaz9VTohQTc1oF9XEJi6T2X8v+Vt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dt0bdr19C9tveZGxRDpZWZkwhwTc1xLEzCQ6ycqFREc=;
        b=3P6csJvnRJnG1sPmelGnXtLAQOi5EFy9MFiLV/s7YyO1UrUm4c8gLws8A7lqCSlg9b
         Gy++OyYpNHMeCh8P02iqmcc/5zMt0bCgBBEEYslDTk3muFSagK1CHyLOq9WJHVmA8zo1
         ocWV8ab2XUdsKqvUicrcNKfqCWJmmHqAtJrn5r4nnwnM16L0vQVCai1tRw8y5Z17y38d
         5pJ+tYmEpkxX80646DIU4ZXExMGJ5X8Rhs+t0noAPB2H/yG9Q3UytP5N5L43Y2JPUbaW
         Iw8VEqnc+aMikPUeZcaLhE1PvEn39lX2CRZK3bZzH6zDeGYCEGbuQE2tkS9m2LPNu8/X
         iI1Q==
X-Gm-Message-State: AOAM530HhzFzM+tVZSFCRJQvusfVq3KisZwCJeffv/sgxYyhCt18YIVM
        p8D55Qmewp/GmKe4Tz3esgzs3+HxRDcdA/9gqTM=
X-Google-Smtp-Source: ABdhPJzfrQ6ZgYLmIuwD+1U/9CGqw403G4NMnGYRRCb4bbgCHr9GfjCH5hwoXiujuJpiRB8+Q4y/Fg==
X-Received: by 2002:a2e:9915:: with SMTP id v21mr18632638lji.108.1632074752097;
        Sun, 19 Sep 2021 11:05:52 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g28sm701995lfe.276.2021.09.19.11.05.51
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 11:05:51 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id g1so57724849lfj.12
        for <linux-arch@vger.kernel.org>; Sun, 19 Sep 2021 11:05:51 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr20081796ljg.68.1632074751024;
 Sun, 19 Sep 2021 11:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjRrh98pZoQ+AzfWmsTZacWxTJKXZ9eKU2X_0+jM=O8nw@mail.gmail.com>
 <YUdti08rLzfDZy8S@ls3530>
In-Reply-To: <YUdti08rLzfDZy8S@ls3530>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Sep 2021 11:05:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKc5TY-LiAjog5VKNUQ84CSZyPu+FQekMHDar=kdSW=Q@mail.gmail.com>
Message-ID: <CAHk-=wgKc5TY-LiAjog5VKNUQ84CSZyPu+FQekMHDar=kdSW=Q@mail.gmail.com>
Subject: Re: Odd pci_iounmap() declaration rules..
To:     Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
        Ulrich Teichert <krypton@ulrich-teichert.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 19, 2021 at 10:04 AM Helge Deller <deller@gmx.de> wrote:
>
> Can you test if it fixes your alpha build (with GENERIC_PCI_IOMAP=y) as
> well?

Yup. With this I can do that "enable GENERIC_PCI_IOMAP
unconditionally" thing on alpha, and the one off EISA/PCI driver now
builds cleanly without PCI.

I applied it directly (along with the alpha patch to GENERIC_PCI_IOMAP).

I have now looked at a number of drivers and architectures that I had
happily forgotten _all_ about long long ago.

It's been kind of fun, but I sure can't claim it has been really _productive_.

Thanks,

               Linus
