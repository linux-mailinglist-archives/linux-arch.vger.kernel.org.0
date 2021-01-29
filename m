Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8677D308ED6
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 21:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhA2UxS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbhA2Uw0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 15:52:26 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B77C061574;
        Fri, 29 Jan 2021 12:51:43 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id m20so2217141ilj.13;
        Fri, 29 Jan 2021 12:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mMkNpB7P7wAGZeelGpg3x5YT9WR7p90psVnGkZ1+cMI=;
        b=tf3Bddwgv9t9fxK9tg/yvd75F/KodcmXzau36lm2p8Shxwuvn/R/due/oPAfAukohu
         CidEl+RDPDSEhc9nAKSGBTK+cIMFEsZsOb7thH0pgEn0LJWSRylqOtNj9F2Atat+6evM
         hllUbgpv3RgDobsO0gru7aiJgDtJmU13WPl+fMDn2Fk7R25iiskMrX1pfLd/omznVclR
         BeXg+tJieTc8gCGfcG91Xfi0xm/btTUjpNi/19Fn3kBb4fbH7QULWOY0FQWheUlZDpjz
         muLa+dN0ynK2eF2qM2y9Gf+gFA5GPgPQfah62ujljUo0AAhXNTgX41zvo5FlIibLk1cO
         eRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mMkNpB7P7wAGZeelGpg3x5YT9WR7p90psVnGkZ1+cMI=;
        b=FWyqyP0JV2L3MZbYja74aZeMo3r6eexZV6xElLsJXWbaq5puApCvRdoWERVPv6Bfyw
         tCiXAcXGM1+opjsSXq0TQfEuW0Q1SBAUDdsMkJb+87KPHxxJxtl4dKI0l84OLJx1SMUi
         BDX+BP1E1m8zEn4iX2yGAAk9pqbKL2fWE/2N+BlPVEjO/iYhxDm49Kfbev3bDrt7TiUc
         NedhslNJcsqKs0R6nM5AeMMKqGAkJ1PNEBcPnQus/m5saCbKQ6p9sAZ1Uj5tIItr65+Y
         2veUh1rfp+aP5CGOzT+gg+EKqc17Ba4PEAUhzPXew374YkWtPouNgV99ruWvDwVjqGxI
         zTUA==
X-Gm-Message-State: AOAM532WABjYQQZex8TRjWxnNplaX40WoJgX4Ck05OQwQfuV8kiajLJP
        lOEyoRlSNw+HfZprMzBIiBmd1Z7wnQTKDwUvY3I=
X-Google-Smtp-Source: ABdhPJw5Y5GTPIY1EISus1LdQ3B8aosCndj4hIpDKWbA8VFnRmkSAUW2Fj7uIN8KKLhwC/bnePlxrZV9SlFR+Ulem4c=
X-Received: by 2002:a05:6e02:cb:: with SMTP id r11mr5828814ilq.116.1611953503379;
 Fri, 29 Jan 2021 12:51:43 -0800 (PST)
MIME-Version: 1.0
References: <20210129204528.2118168-1-yury.norov@gmail.com>
In-Reply-To: <20210129204528.2118168-1-yury.norov@gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Fri, 29 Jan 2021 12:51:32 -0800
Message-ID: <CAAH8bW8cZYG0HxqVAK4HxZDP3abxkHXsqfhSzJ-amQ_S6yDY_w@mail.gmail.com>
Subject: Re: [PATCH 0/6] lib/find_bit: fast path for small bitmaps
To:     linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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

On Fri, Jan 29, 2021 at 12:45 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> Bitmap operations are much simpler and faster in case of small bitmaps, whicn
> fit into a single word. In linux/bitmap.h we have a machinery that allows
> compiler to replace actual function call with a few instructions if bitmaps
> passed into the function is small and its size is known at compile time.
>
> find_*_bit() API lacks this functionality; despite users will benefit from it
> a lot. One important example is cpumask subsystem, when NR_CPUS <= BITS_PER_LONG.
> In the very best case, the compiler may replace a find_*_bit() call for such a
> bitmap with a single ffs or ffz instruction.
>
> Tools is synchronized with new implementation where needed.

Sorry for the broken enumeration . If it's too confusing, please let me know
and I'll resend.
