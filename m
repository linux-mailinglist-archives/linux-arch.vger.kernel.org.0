Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB92B410DAB
	for <lists+linux-arch@lfdr.de>; Mon, 20 Sep 2021 00:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhISWqg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Sep 2021 18:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhISWqe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Sep 2021 18:46:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F266C061574
        for <linux-arch@vger.kernel.org>; Sun, 19 Sep 2021 15:45:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g41so26074780lfv.1
        for <linux-arch@vger.kernel.org>; Sun, 19 Sep 2021 15:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdZeP2xX0S2UdP1hcknPJBktnrJVqMJYYM7DRzCb5y4=;
        b=gm8yU0GuFzvPX4PVSuYIwfVUnYMeX5j4bo9iUSfow/cjvg1txrH9AK90QgRfPVDbsB
         30SMQL3352w12g4R6OllVZbd2DFL8eKLsAIug2/QIn2xBsM+ZuVrFvVNrenFP3qTeLfX
         SgQ2vOtq/DCw3RNS4/IJhwjh5T+Dt0cnfBPss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdZeP2xX0S2UdP1hcknPJBktnrJVqMJYYM7DRzCb5y4=;
        b=35PEMnJX8cUkrdEr+7v1glJHfnknftnx9WU62w1/RRoISFsfh2mVlmlSZRxTd46+I5
         vTKTQpRDBZ+pCkBWdhhCEGNZbhVcRzky/EkQcK5rOiLla9n4DsSXDOPBp9uvyTwz1Rfi
         vxAWPqMldQgC/ipaSUvs311D2McX+OrKFQs96x8fAfummDneAaATuq+ZNgOC+N/bmAoZ
         gTdFVAQn4+lv5XTPlYkJcrc0iG2/smgJZSqsX0Q2DMI/3cuToxvqkmQjUh1qn6CqD2kJ
         YWrrjhWK+ECpofNu4Tc8dF2Gv3fSoqnFQTrU1yK3ty7rw12OiZ+0FNtdyZkY2ustQE5G
         2FQA==
X-Gm-Message-State: AOAM531T5IFzVjl4XypBX5OuKIUlwDrXdYc4wpaXQiIQkbY/HT8lIptO
        2ztwJYkcIgjbD4rGEZ2a9EEsKEZrVRujKYmS
X-Google-Smtp-Source: ABdhPJyhEqCIScVwAMjZy7PKCIT1dxwBLnvXtFQvHCC3pFtKfUOFj2hmHWoi3LZy9mTWEJSsP853Pg==
X-Received: by 2002:a19:491e:: with SMTP id w30mr8761557lfa.121.1632091505877;
        Sun, 19 Sep 2021 15:45:05 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id u22sm443367lfi.104.2021.09.19.15.45.05
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 15:45:05 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id i4so59583716lfv.4
        for <linux-arch@vger.kernel.org>; Sun, 19 Sep 2021 15:45:05 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr7791775ljc.249.1632091504930;
 Sun, 19 Sep 2021 15:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjRrh98pZoQ+AzfWmsTZacWxTJKXZ9eKU2X_0+jM=O8nw@mail.gmail.com>
 <YUdti08rLzfDZy8S@ls3530> <CAHk-=wgKc5TY-LiAjog5VKNUQ84CSZyPu+FQekMHDar=kdSW=Q@mail.gmail.com>
 <YUeriU9EIJ5hiFjL@archlinux-ax161> <CAHk-=wgNfaf03Dw78q1qLLZs6G=iJjfo5ZTcnyXgSk3w1tp0yg@mail.gmail.com>
In-Reply-To: <CAHk-=wgNfaf03Dw78q1qLLZs6G=iJjfo5ZTcnyXgSk3w1tp0yg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Sep 2021 15:44:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirqeqb59bbFjCQ9L9BiVOQFqD=JbUEG+hU2bF4BDWqVg@mail.gmail.com>
Message-ID: <CAHk-=wirqeqb59bbFjCQ9L9BiVOQFqD=JbUEG+hU2bF4BDWqVg@mail.gmail.com>
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

On Sun, Sep 19, 2021 at 3:27 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>   --- a/include/asm-generic/io.h
>   +++ b/include/asm-generic/io.h
>   @@ -1047,7 +1047,7 @@ extern void ioport_unmap(void __iomem *p);
>   -#ifndef CONFIG_GENERIC_IOMAP
>   +#ifndef CONFIG_GENERIC_PCI_IOMAP
>
> let me go test, I do have an arm64 build environment for this all, but
> for that commit I had only done parisc, alpha and x86-64.

Hah. That conditional makes a lot more sense that way, but doing that
sensible thing exposes more oddities.

In particular, both arm and arm64 do

        select GENERIC_PCI_IOMAP

so they get the bog-standard pci_iomap() from lib/pci_iomap.c. All
good and sensible.

But is there a pci_iounmap() in lib/pci_iomap.c? No. The default
pci_iounmap() is in lib/iomap.c, which arm and arm64 do *not* use,
because they don't have GENERIC_IOMAP.

So those architectures depended on the header file copy, and with that
sane oneliner, the compile part of the build works fine, but then it
ends with

    undefined reference to `pci_iounmap'

because that didn't work out at all.

The fix seems to be to just move that odd code from the header file to
lib/pci_iomap.c, and that should make it all JustWork(tm).

That would at least make some of this make more sense. But this is all
a maze of random odd architecture things, so I'll have to look some
more at it.

            Linus
