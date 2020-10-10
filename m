Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7453289D00
	for <lists+linux-arch@lfdr.de>; Sat, 10 Oct 2020 03:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgJJBVD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 21:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgJJBDw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 21:03:52 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E46C0613D9
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 18:03:51 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c141so5902608lfg.5
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 18:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7OwKgWi2gSxmEp/hYxtSzWSpApJcXjT+OdSqNt7VYU=;
        b=Wf1q2lnubIrbXjk14tkrYxXcbBXmzq9qYbXL1Q2p8EB+0CvkKSqF+3HlgfvaB+X8S6
         SG17cHHpnVFX880L11ZWENbR0ebhET03jaC+x724GDZbfQvjLR0+JYp1fVD8FDqLvksZ
         kRBaHY97weaJ2iFk9krv7PVK7ymwvLjzNkwFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7OwKgWi2gSxmEp/hYxtSzWSpApJcXjT+OdSqNt7VYU=;
        b=nVtbN3+q5H4k8TWu7Srzj/1BNiperLrU2EWGiNi3oodQhKHztDRfd2FSTQgwhZitMG
         p0mFqurF/80fBGmTzs2mNNXBCD6aIctdYc8glm7Jx60pbVYQnVOYU6g9ud/Pz/biFkho
         wCvPUWIEutgFSyc54AgY3fJvAefiRzz1kkkehWjRu1SQe0rrV39Yj9tis4TxYVf4J2Ay
         KqEqONBb4UGNvKovDTwdW45N6vtpQbAy+uxXcexKdFBL+PVyUg5OfcrDSSL77n6CjwnM
         R9ZhA0w0eaNJs0Pl3B4VgTt2h++7FZua7Nh4y2mpUR/W6x0PHpJvkgz3NlEDqzqstB6n
         VRpA==
X-Gm-Message-State: AOAM532yS3FWMZFRe2O1VbfOxyNePQeE0p0HzxMprTCrnvrgRrFNzrKC
        YLbH0prUJ+ZH4jG77rnFV/Becc1WZQBjxw==
X-Google-Smtp-Source: ABdhPJyW58+RTcYCST0/2XP5VaEoXY/gH1C1OyYjKonosxZ8j/KxMZ1rO8cjfWTbp4tOPbQm71LE4g==
X-Received: by 2002:ac2:4216:: with SMTP id y22mr4566868lfh.61.1602291829595;
        Fri, 09 Oct 2020 18:03:49 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id m8sm1706533lfh.258.2020.10.09.18.03.47
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 18:03:48 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id a5so11235868ljj.11
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 18:03:47 -0700 (PDT)
X-Received: by 2002:a2e:2202:: with SMTP id i2mr5735571lji.70.1602291827290;
 Fri, 09 Oct 2020 18:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de> <20200903142242.925828-6-hch@lst.de>
 <20201001223852.GA855@sol.localdomain> <20201001224051.GI3421308@ZenIV.linux.org.uk>
 <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com> <20201009220633.GA1122@sol.localdomain>
In-Reply-To: <20201009220633.GA1122@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Oct 2020 18:03:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcEzYjkqdpZciHh+iAdUttvfWZYoiHiF67XuTXB1YJLw@mail.gmail.com>
Message-ID: <CAHk-=whcEzYjkqdpZciHh+iAdUttvfWZYoiHiF67XuTXB1YJLw@mail.gmail.com>
Subject: Re: [PATCH 05/14] fs: don't allow kernel reads and writes without
 iter ops
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 9, 2020 at 3:06 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> It's a bit unintuitive that ppos=NULL means "use pos 0", not "use file->f_pos".

That's not at all what it means.

A NULL ppos means "this has no position at all", and is what we use
for FMODE_STREAM file descriptors (ie sockets, pipes, etc).

It also means that we don't do the locking for position updates.

The fact that "ki_pos" gets set to zero is just because it needs to be
_something_. It shouldn't actually ever be used for stream devices.

                  Linus
