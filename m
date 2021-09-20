Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5D41184A
	for <lists+linux-arch@lfdr.de>; Mon, 20 Sep 2021 17:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbhITPd3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Sep 2021 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241681AbhITPd1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Sep 2021 11:33:27 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D429C061764
        for <linux-arch@vger.kernel.org>; Mon, 20 Sep 2021 08:32:00 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id i26-20020a4ad09a000000b002a9d58c24f5so76817oor.0
        for <linux-arch@vger.kernel.org>; Mon, 20 Sep 2021 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CB4E7Uec90Q5gOJuJi7VZbKdpw+MEcmL5hq6X916kSQ=;
        b=aVQlPVwPJlTIAY6iEKClX7TDHAAT3Hp0xQz2TiDpFBOfaWKv7PSPI6gUjStNJUNvy7
         E2SCWa43A7V5y0QWWKlUONhFqAkqeRyieYoWJ2d0zHroyZ9/1XtAhTfU5DuIQOa3kUHJ
         pI/NT7ssWsYXFNWcIFv4YXrCBxpebiO6DRcCOC6teomcua3878IXYJVjW8MffDrOvAFw
         Rb/Ht/BmRSdHwLiHjixBRKWc/Xm1Hk311PVbNyExhBR8ws2K+lZGGUWpU8B+hD8gHE8h
         8bVR6DAlICB7Q2JPM+j3d7DfD+Wu5xX2oTFqVthY6R15xUoZJJXzcsawHc8FDsy9LmiU
         gCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CB4E7Uec90Q5gOJuJi7VZbKdpw+MEcmL5hq6X916kSQ=;
        b=HPmO4WhXqq+GzJeSTk6wOJmtg4LXJUtUIsr+cj3ZMchZF0yLue6MzzZiSikouYRi+b
         oD+LYsuTdnkTImTNMGB8LIWtswcv66p45eGRv5Vo/Xd/rmx+dEeHgMiAcRMnmOIk9vmB
         ri/83GDibmorWMHeJGTJ+ndtj500DigERNzBNJrTK2H2U9/oze+LhahHgCUI9yDBtupW
         3VRjvIvzuncO8uDc35jaYboSmI9uM6rWD9zZU9+l0hqYBiv54L4A32WBXsj1i9rqpY4s
         iZo2gUDQ7VYxOzUgfiKiVbXTQyGM45wbZFNZSIwnRvCgj2DQdSFq7ynZtOI6Ls7yFfbG
         0CLg==
X-Gm-Message-State: AOAM531LjrLMSTRHyubBOPDruAcFg/Ls5/uigk+gNS/v03hW/vzuQhl6
        loO8IhNGvFNutO83gdEPuak=
X-Google-Smtp-Source: ABdhPJwb4iLiO89JepBAqEHZA7/uZCTf2HObn7/9c+IN7ak+Ni2RjwtT0em2lEe73Qgrxfnd9ab/Hw==
X-Received: by 2002:a4a:d5d2:: with SMTP id a18mr20075424oot.43.1632151913904;
        Mon, 20 Sep 2021 08:31:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i19sm3669270ooe.44.2021.09.20.08.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:31:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Sep 2021 08:31:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Ulrich Teichert <krypton@ulrich-teichert.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        llvm@lists.linux.dev
Subject: Re: Odd pci_iounmap() declaration rules..
Message-ID: <20210920153151.GA3739191@roeck-us.net>
References: <CAHk-=wjRrh98pZoQ+AzfWmsTZacWxTJKXZ9eKU2X_0+jM=O8nw@mail.gmail.com>
 <YUdti08rLzfDZy8S@ls3530>
 <CAHk-=wgKc5TY-LiAjog5VKNUQ84CSZyPu+FQekMHDar=kdSW=Q@mail.gmail.com>
 <YUeriU9EIJ5hiFjL@archlinux-ax161>
 <CAHk-=wgNfaf03Dw78q1qLLZs6G=iJjfo5ZTcnyXgSk3w1tp0yg@mail.gmail.com>
 <CAHk-=wirqeqb59bbFjCQ9L9BiVOQFqD=JbUEG+hU2bF4BDWqVg@mail.gmail.com>
 <CAHk-=wgzc8EUcH=V7P0GoxVYw4bQ7URJvQVZ7_5pODQmrSkAnw@mail.gmail.com>
 <YUia9zfbiertRRNR@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUia9zfbiertRRNR@archlinux-ax161>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 20, 2021 at 07:30:15AM -0700, Nathan Chancellor wrote:
> On Sun, Sep 19, 2021 at 05:44:03PM -0700, Linus Torvalds wrote:
> > On Sun, Sep 19, 2021 at 3:44 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > The fix seems to be to just move that odd code from the header file to
> > > lib/pci_iomap.c, and that should make it all JustWork(tm).
> > 
> > I'm not 100% happy about the end result, and in particular I think
> > that the new generic pci_iounmap() function for the
> > ARCH_WANTS_GENERIC_PCI_IOUNMAP case should do the "iounmap(p)" thing
> > even if ARCH_HAS_GENERIC_IOPORT_MAP wasn't true, but I tried to keep
> > the old rules, even if they seemed broken.
> > 
> > arm and arm64 build for me, as did sparc64 and alpha. At least in the
> > configs I tested.
> > 
> > And the code _does_ make a bit more sense than it used to. It still
> > has crazy corners, but moving the pci_iounmap() code out of the header
> > file should make it easier to fix up in the future.
> 
> Thanks, I can confirm that all of my build tests pass without any
> issues now.
> 
I still see build failures for sparc64:allnoconfig and sparc64:tinyconfig.

Guenter
