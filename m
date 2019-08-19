Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FF8948E4
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 17:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfHSPrR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 11:47:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46008 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbfHSPpu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 11:45:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id w26so1378029pfq.12
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtYpFyhBgTCiaGChS6+kaxar4vStZcnCYRWo71+/RtE=;
        b=lkS0EhBoToJ8+dJ5+nnxpdrWvVmMHHZI7bNv0YOTEttc921AvasCizSuRflFNbq1Xj
         Lpzl84ZZA2OQ6Fl0mVnvOJyIXEqYXu5ps1wPAfD33F9fSphuk4sFgI4SIKqe5ey5Tr57
         G8XUL4SKezAspF0tskCc378nq+6tOXS5v2s6iY1fnPR8AmhGw3iI/NsuI0cW+A20hgEk
         y05U8D//d6jldI/IInc3BskYQojRq9cgHqOL/Sxxioz1XALAEdpp/8OiQun/RJSUXJyo
         GJMLBdsjaVvdZjcjp2MQ4TMMJwlzyVeEF08ndFUH3hSYiwHwBHn4nNJfq4wngD77uKww
         /CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtYpFyhBgTCiaGChS6+kaxar4vStZcnCYRWo71+/RtE=;
        b=VDMP9yDEvJoKTB0/SPE2K6uwuV82WdgTWnPpBBQI4z4pZWXNUpjSGHtODqkYllpL0w
         ApTXcam+eYSH6sq00kvL9APXveSX3hz5IiKmLGOQYvEzekSIIT8kjTCQUIvv9yb+hSkE
         MIxwqipymKiIYHD6NcfdXtu/NkTj7tuk3NxLMZqphL19pTZJvK1YkjTbdBkhroVUd8Z2
         J+wPvwmbndjP8X12Cv2eUBcafNfOrsoyBI5OzB3MyzQExL9E7up3vzH4ceTcbYlZtUJ9
         BqpVIsSUta/ZiSutMfAT0Qx5Xgt6GTFRboE5juJFt9njDTm5nRO2Ap0Fvsz2RTC/lZ2x
         +xzQ==
X-Gm-Message-State: APjAAAUNZUoU96qsV6onUZiiaNFWp+8wG5Z6NXRaWR18Gc8Zk1LomRPo
        uM9OmCQLrjabrIffXRekuYhkVXk0hm7i1bEH9yoWcw==
X-Google-Smtp-Source: APXvYqz6VTqoLf1MfWlpYT4kff14E1OwztGKr414bguuFTgjh6si0OD8mf+UDVjfdzyW4l952foknf+zoYxofSvLevs=
X-Received: by 2002:aa7:9790:: with SMTP id o16mr25133292pfp.51.1566229549716;
 Mon, 19 Aug 2019 08:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190815154403.16473-1-catalin.marinas@arm.com> <20190815154403.16473-2-catalin.marinas@arm.com>
In-Reply-To: <20190815154403.16473-2-catalin.marinas@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 19 Aug 2019 17:45:38 +0200
Message-ID: <CAAeHK+z6y4_rSH8b8Q=yMmNZYd_bsmMo2XPP0DO-74+=XPPrMg@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] mm: untag user pointers in mmap/munmap/mremap/brk
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 15, 2019 at 5:44 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> There isn't a good reason to differentiate between the user address
> space layout modification syscalls and the other memory
> permission/attributes ones (e.g. mprotect, madvise) w.r.t. the tagged
> address ABI. Untag the user addresses on entry to these functions.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Andrey Konovalov <andreyknvl@google.com>

> ---
>  mm/mmap.c   | 5 +++++
>  mm/mremap.c | 6 +-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7e8c3e8ae75f..b766b633b7ae 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -201,6 +201,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>         bool downgraded = false;
>         LIST_HEAD(uf);
>
> +       brk = untagged_addr(brk);
> +
>         if (down_write_killable(&mm->mmap_sem))
>                 return -EINTR;
>
> @@ -1573,6 +1575,8 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
>         struct file *file = NULL;
>         unsigned long retval;
>
> +       addr = untagged_addr(addr);
> +
>         if (!(flags & MAP_ANONYMOUS)) {
>                 audit_mmap_fd(fd, flags);
>                 file = fget(fd);
> @@ -2874,6 +2878,7 @@ EXPORT_SYMBOL(vm_munmap);
>
>  SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
>  {
> +       addr = untagged_addr(addr);
>         profile_munmap(addr);
>         return __vm_munmap(addr, len, true);
>  }
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 64c9a3b8be0a..1fc8a29fbe3f 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -606,12 +606,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>         LIST_HEAD(uf_unmap_early);
>         LIST_HEAD(uf_unmap);
>
> -       /*
> -        * Architectures may interpret the tag passed to mmap as a background
> -        * colour for the corresponding vma. For mremap we don't allow tagged
> -        * new_addr to preserve similar behaviour to mmap.
> -        */
>         addr = untagged_addr(addr);
> +       new_addr = untagged_addr(new_addr);
>
>         if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
>                 return ret;
