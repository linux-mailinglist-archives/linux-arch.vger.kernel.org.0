Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83821308F1C
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 22:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhA2VNE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 16:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhA2VNC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 16:13:02 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AFDC061574;
        Fri, 29 Jan 2021 13:12:22 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id j2so5844266pgl.0;
        Fri, 29 Jan 2021 13:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vg06EYb42M3hpCfx5u7kHIys3A9k6t2mg9qHTWyzE3w=;
        b=uss+hVCZDE3oRNcwh9eYfuy7m6VRQNYdgkoDVQImrhh57a/UlNuWWuuDgaosrP8ciq
         +DwO0j1ysvGh4cUVVQ9CYyYjHZ4DZPQB5CBsDqi9mO6wbebhs6alezYxQHCVQzW9IFek
         Rp06X5zmEh3kGZ8SkaurfmrsL/Lm8u5X/pl6pCXcjMXj/klvxIG7ISbTgElODiWfTVJv
         yEFrgh0LoPRyxL4VnNIwminFNaJVpY6Tvjl2Bnc7jIoqk7cItGHZzr/w39c+0dgAUC2A
         6jq/fWWg6kNZP3tfNSxGlO9oBcYqA0/FePKfkHG5v0QZFeMmCw5B0COX5RbUoovgO/MN
         zSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vg06EYb42M3hpCfx5u7kHIys3A9k6t2mg9qHTWyzE3w=;
        b=dC8xe6yBaho557HFd1K3ZRVy/DZhL+1hJAdZOfa8SCa9B/t5jIVpRLVgnIC+Vdsfqw
         kL0CdmO/8oM5xsfX+NGQI9iMG0DRgQe+hH84/nJXOt8A4/+2WD5BHolfX2gsZOD/hCGj
         6Cy6KPmRJwFW+5lO7icBOyyOoKCBZ/p/iSazxGzCIgh+jE5wWxrYQadjK3PJ2+ta91+y
         +6exUJX0DdRwfkoFTlBqLz3iHSXRvfcFV+cVygB43Vcwr/2DHrTeADx9uhjIZELbV3TB
         DzGm9gCdhbvGrqqV3P/b+5rA34z42d2DLx0wxgAf4QWec6vcSsZjxfWVxSrpkYTcJKhS
         R+EA==
X-Gm-Message-State: AOAM532fdC3+r3xadOfgvgCiFmpB6wnhxS/dLFrNxDipIzLOtCp6Lxyo
        E8Ed7BPVp5DhtN6uuPw1lgfBEOvlqLsiod6otU0=
X-Google-Smtp-Source: ABdhPJzhasacDYoAPPOBBF8yQuC912YJpL6AW+IIK81jaA5iP/L3pxdDxPg5ljkrbUC+zNtJxfkDyiQtXR2kowiCXsE=
X-Received: by 2002:a63:fc56:: with SMTP id r22mr6374949pgk.203.1611954742023;
 Fri, 29 Jan 2021 13:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20210129204528.2118168-1-yury.norov@gmail.com> <CAAH8bW8cZYG0HxqVAK4HxZDP3abxkHXsqfhSzJ-amQ_S6yDY_w@mail.gmail.com>
In-Reply-To: <CAAH8bW8cZYG0HxqVAK4HxZDP3abxkHXsqfhSzJ-amQ_S6yDY_w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jan 2021 23:12:06 +0200
Message-ID: <CAHp75VdkMGBKnyq4B+cckDUGh0ag3bGq26_SJp-K=jQd43pP-Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] lib/find_bit: fast path for small bitmaps
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 10:54 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Fri, Jan 29, 2021 at 12:45 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Bitmap operations are much simpler and faster in case of small bitmaps, whicn
> > fit into a single word. In linux/bitmap.h we have a machinery that allows
> > compiler to replace actual function call with a few instructions if bitmaps
> > passed into the function is small and its size is known at compile time.
> >
> > find_*_bit() API lacks this functionality; despite users will benefit from it
> > a lot. One important example is cpumask subsystem, when NR_CPUS <= BITS_PER_LONG.
> > In the very best case, the compiler may replace a find_*_bit() call for such a
> > bitmap with a single ffs or ffz instruction.
> >
> > Tools is synchronized with new implementation where needed.
>
> Sorry for the broken enumeration . If it's too confusing, please let me know
> and I'll resend.

Yeah, please resend with a bumped version and respective changelog.

-- 
With Best Regards,
Andy Shevchenko
