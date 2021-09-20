Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E49F410E0A
	for <lists+linux-arch@lfdr.de>; Mon, 20 Sep 2021 02:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhITAps (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Sep 2021 20:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhITAps (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Sep 2021 20:45:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC7FC061574
        for <linux-arch@vger.kernel.org>; Sun, 19 Sep 2021 17:44:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z24so33903900lfu.13
        for <linux-arch@vger.kernel.org>; Sun, 19 Sep 2021 17:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZDLR9sdBnUFT4vrbA3jHn9fpeKh00IssMCqR/6wARc=;
        b=dShrzOELo+GoOEvGxj8VwqLJKX6iIREPkKDiKbgJHb9gqTnml7ifo87NOoJav4N9H/
         bF1ONsUNbBtaf9MGV+loX2EtITMx6oeh75OVLjAH1WPsQAHh7Qm7qVLl1FId4wQO0E2w
         psRW9Y+X7cI0APG3A9H5AcyA/5M63Di56eSpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZDLR9sdBnUFT4vrbA3jHn9fpeKh00IssMCqR/6wARc=;
        b=lEWm7ivp0hYn10fu3fGG2vt5P7s112jz+iVn6HFkoLveia8w16Ng3ieuvZZtZmHEY1
         JgypzLDB2+Zk65mxTYaqASBlueyS+C+fLlOeGS/xadFlmP0y1qc7Vj/pzxG7RYGHSGyJ
         wkpaKFwFMNqfBCqICgnnEzDnOH0QAXovkRVJci5U9AC4Qy3V/7pH4lsCzOnGQgj2+COM
         8KlkYVSaEbYksynmyP/IPPsjLCPoZGWHgvBl1UPjWDgfkuVNmBt9enYgYMdIHIcCe251
         6YmSQuGoKKbgCgGuGuEvCxagUpjL26N+J4usQp6xZaRPp3p5HFg9e14oNYAwSYgMxXg1
         1cKA==
X-Gm-Message-State: AOAM533GpkcqDP25AVlCijW8KYZcTQZpzuI/Lq10Pe43crfidrDT7LUD
        QhxBQJiQWY81T5h+utdaz8ypVZsj0Ukr1ez4
X-Google-Smtp-Source: ABdhPJxreOXUM5tw1z69IA5qwkiB38m1syTVTwzG76gCCQ7nmHs5g0frCYYIK5U3Zr5SguG8j6kGnw==
X-Received: by 2002:a2e:5455:: with SMTP id y21mr20092059ljd.304.1632098660128;
        Sun, 19 Sep 2021 17:44:20 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 5sm80565ljj.13.2021.09.19.17.44.19
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 17:44:19 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id i4so60497165lfv.4
        for <linux-arch@vger.kernel.org>; Sun, 19 Sep 2021 17:44:19 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr20190666ljp.494.1632098659363;
 Sun, 19 Sep 2021 17:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjRrh98pZoQ+AzfWmsTZacWxTJKXZ9eKU2X_0+jM=O8nw@mail.gmail.com>
 <YUdti08rLzfDZy8S@ls3530> <CAHk-=wgKc5TY-LiAjog5VKNUQ84CSZyPu+FQekMHDar=kdSW=Q@mail.gmail.com>
 <YUeriU9EIJ5hiFjL@archlinux-ax161> <CAHk-=wgNfaf03Dw78q1qLLZs6G=iJjfo5ZTcnyXgSk3w1tp0yg@mail.gmail.com>
 <CAHk-=wirqeqb59bbFjCQ9L9BiVOQFqD=JbUEG+hU2bF4BDWqVg@mail.gmail.com>
In-Reply-To: <CAHk-=wirqeqb59bbFjCQ9L9BiVOQFqD=JbUEG+hU2bF4BDWqVg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Sep 2021 17:44:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzc8EUcH=V7P0GoxVYw4bQ7URJvQVZ7_5pODQmrSkAnw@mail.gmail.com>
Message-ID: <CAHk-=wgzc8EUcH=V7P0GoxVYw4bQ7URJvQVZ7_5pODQmrSkAnw@mail.gmail.com>
Subject: Re: Odd pci_iounmap() declaration rules..
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Ulrich Teichert <krypton@ulrich-teichert.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 19, 2021 at 3:44 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The fix seems to be to just move that odd code from the header file to
> lib/pci_iomap.c, and that should make it all JustWork(tm).

I'm not 100% happy about the end result, and in particular I think
that the new generic pci_iounmap() function for the
ARCH_WANTS_GENERIC_PCI_IOUNMAP case should do the "iounmap(p)" thing
even if ARCH_HAS_GENERIC_IOPORT_MAP wasn't true, but I tried to keep
the old rules, even if they seemed broken.

arm and arm64 build for me, as did sparc64 and alpha. At least in the
configs I tested.

And the code _does_ make a bit more sense than it used to. It still
has crazy corners, but moving the pci_iounmap() code out of the header
file should make it easier to fix up in the future.

          Linus
