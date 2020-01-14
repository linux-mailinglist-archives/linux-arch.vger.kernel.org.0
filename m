Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF4F13B48E
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 22:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgANVjR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 16:39:17 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33237 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANVjR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 16:39:17 -0500
Received: by mail-pf1-f201.google.com with SMTP id c72so9560259pfc.0
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2020 13:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ogwhwUXjz2D7m/McSi2ptUkkZ3HC7rjK02YCOSGV8GE=;
        b=OhW4irqszOSJyDSvCfs5rVBGVRl1LZh4zh4uVXI73J5klWOhLw/5SDmpqhDOKCnM2X
         NGos6pYg0iLuzFx3qJueCMUI1/L11oDhEn/FYXQuc8gdgfAmVRk4YpHcQUI67TUzTXj/
         4lJM/xG1EBxMa5+lehOz78N6V9Y8s+gW7uCIfcwox73+wxv1FgiA1DXCJSPIVGhB5gXY
         7AlKOIg1lTrxmm5r2M6gy+KxRQmbuZKjXMrQM4YPYOIwCS/TrJiIV1zPpiLTp1Q7MOK7
         hboocq7wQmlGwoz5x1UopoCo+SNAP8fRSgZygJXJ0lAslC3tt407KsUlCSKfFTA4GcMB
         kgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ogwhwUXjz2D7m/McSi2ptUkkZ3HC7rjK02YCOSGV8GE=;
        b=LXL8STR5fFUd6n8hbTbniSwrTPJLZLcG9WVRL4O+BHQ8/thwMfAXDHJGpqpKGhSTPw
         rU1ZdWdFdPA5tqNJxUvx7ZIwKD0eu2BkyIZu31/aoUn2eRYDOKfqWj+md0PoSnaYcL8d
         i+N00x+cVPMNcCj2NTHy7kmWH9I2+Hnopr5eUE2vK+nhWeXC1tIlRZEo7WX336CmZ9bK
         3IsV7ArdI+2AZkOkaE+hKilBTwTHnSnn69nZAmHQRxMoF6FKa1b1DM/hbcsPkpXzMbWG
         cJnCSmVE55Ic/Ysy0I7X1tDUi6Do2LEiD1oKRGdk9I7eVSaCyet1tZaFi04jepsHWC0P
         c7UA==
X-Gm-Message-State: APjAAAWqOhp1UL8hWNlh5iCY2G5ZaRPpx9DmVDHVRz+FZe44iuJhSNNm
        Kre15Yt3YpGUlKb1lq/XAoFEiWB3g+pYyKnG9g0=
X-Google-Smtp-Source: APXvYqwzOvBXrG1xFJQFoXWEGTfW6FOLv6mPSRufxWiMXQB9cMwFuAmW+oQTtfPbyjsX4FNOAHEp5TVIiY7QhB3ebB4=
X-Received: by 2002:a63:201d:: with SMTP id g29mr30212874pgg.427.1579037956432;
 Tue, 14 Jan 2020 13:39:16 -0800 (PST)
Date:   Tue, 14 Jan 2020 13:39:14 -0800
In-Reply-To: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
Message-Id: <20200114213914.198223-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: Re: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     arnd@arndb.de
Cc:     borntraeger@de.ibm.com, kernel-team@android.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        luc.vanoostenryck@gmail.com, mpe@ellerman.id.au,
        peterz@infradead.org, segher@kernel.crashing.org,
        torvalds@linux-foundation.org, will@kernel.org,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 10, 2020 at 06:35:02PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
> >
> > Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
> > discarding the 'volatile' qualifier:
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> >
> > We've been working around this using some nasty hacks which make
> > READ_ONCE() both horribly complicated and also prevent us from enforcing
> > that it is only used on scalar types. Since GCC 4.8 is pretty old for
> > kernel builds now, emit a warning if we detect it during the build.
> 
> No objection to recommending gcc-4.8, but I think this should either
> just warn once during the kernel build instead of for every file, or
> it should become a hard requirement.

Yeah, hard requirement sounds good to me. Arnd, do you have stats on which
distros have which versions of GCC (IIRC, you had some stats for the GCC 4.6
upgrade)? This allows us to clean up more cruft in the kernel (grep for
GCC_VERSION).

Will, Documentation/process/changes.rst should also be modified.

Android is still using GCC 4.9 (which is more like GCC 4.8 plus patches), but
I've been actively moving them (to Clang) over the past 2 years. I'll check
with our other internal distro's and give them a heads up.
