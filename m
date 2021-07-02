Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B113BA467
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 21:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhGBTpt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jul 2021 15:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhGBTps (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jul 2021 15:45:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C290C061764
        for <linux-arch@vger.kernel.org>; Fri,  2 Jul 2021 12:43:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f30so20056781lfj.1
        for <linux-arch@vger.kernel.org>; Fri, 02 Jul 2021 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfx5fSmOdgY90FoUlA/sfF9P5clz6NRu1yzH0lQXy18=;
        b=A/SegpDPvGpVDgVFaqmM0GXMqPsQ/YHD1gkkXyAN6+ZudmMV3Oj69yFt8Zsw66RCuG
         K3vuuTgR1a5B67XiC6xopZzPFZV+4QKrQ620iRpmYgken8P2VG5mnpN5IKG785/EDPoz
         m6WWZRkWp8qmJ7M/20I+XPw9h9fKWKKZgpaXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfx5fSmOdgY90FoUlA/sfF9P5clz6NRu1yzH0lQXy18=;
        b=S8kHzf4xykv9rrdpKszsYuz6gYIl0zvhuWJNpwB177Ibl+mmay/YXUzwfVvJgAf0j+
         lsWscHw+r7m8oDXiZmbyZcE16EfKAel6OUjODykgbfgL2LKTbAheQ1rRCbq1+2eUI2bt
         oSgCimy/rhYad9K6B3zVKnTCmAb61qXpAMMOm3FqVM00ix7svrcqGiJOD2xrIw7Dunb7
         oLyqc2RTGCW2UCyGz10qPMviVJ1lUhVnx6vFEuODwfRc1G8PtfzfhPI1uX1zcRKMcDXo
         Dotw/cYbjadk/in6B6rd9pVbGvspgCwvwrJ1cEFEgYMWdcCS5Abrmew0rPx0X+OPW4Wu
         JVeQ==
X-Gm-Message-State: AOAM531IDCE8Qj9uIAu6wY39I9dqjoEKaSNddplfom8ZsaT74wQfCAkT
        VzGOpZKVZo2OCAmlXPzhzYhs3yLs3NIFK+C3Qg0=
X-Google-Smtp-Source: ABdhPJxBNlWDJyVm4ABP+DTwgsyJwTJ2NNDQF87dxgtZU4D8a6AuTd/G7GTL9jhz/wPZh9cpmoN+NA==
X-Received: by 2002:a05:6512:489:: with SMTP id v9mr873403lfq.199.1625254994374;
        Fri, 02 Jul 2021 12:43:14 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id b14sm355518lfb.132.2021.07.02.12.43.13
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 12:43:13 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id r26so2543420lfp.2
        for <linux-arch@vger.kernel.org>; Fri, 02 Jul 2021 12:43:13 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr866325lfs.377.1625254993210;
 Fri, 02 Jul 2021 12:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
In-Reply-To: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jul 2021 12:42:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
Message-ID: <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 2, 2021 at 6:48 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> A rework for PCI I/O space access from Niklas Schnelle:

I pulled this, but then I ended up unpulling.

I don't absolutely _hate_ the concept, but I really find this to be
very unpalatable:

  #if !defined(inb) && !defined(_inb)
  #define _inb _inb
  static inline u8 _inb(unsigned long addr)
  {
  #ifdef PCI_IOBASE
        u8 val;

        __io_pbr();
        val = __raw_readb(PCI_IOBASE + addr);
        __io_par(val);
        return val;
  #else
        WARN_ONCE(1, "No I/O port support\n");
        return ~0;
  #endif
  }
  #endif

because honestly, the notion of a run-time warning for a compile-time
"this cannot work" is just wrong.

If the platform doesn't have inb/outb, and you compile some driver
that uses them, you don't want a run-time warning. Particularly since
in many cases nobody will ever run it, and the main use case was to do
compile-testing across a wide number of platforms.

So if the platform doesn't have inb/outb, they simply should not be
declared, and there should be a *compile-time* error. That is
literally a lot more useful, and it avoids this extra code.

Extra code that not only doesn't add value, but that actually
*subtracts* value is not code I really want to pull.

                     Linus
