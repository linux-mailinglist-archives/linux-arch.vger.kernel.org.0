Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08276270A82
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 06:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgISEQC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 00:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISEQB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 00:16:01 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B46BC0613CE;
        Fri, 18 Sep 2020 21:16:01 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h4so9303508ioe.5;
        Fri, 18 Sep 2020 21:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MKEE3yp5Rcc/md7pG2bSGfj9ZsRwTbcCIHn5InN/kNw=;
        b=aGlESU91VLGmqPRG+xHbjCgsyyg5neN9y2SNkYDvUeQ/ri6kC1WlyggLSeUQowP2o3
         MJ5NU1bEu8TBm/7t2TfhQcrZd4HxQLTHSmRvaNfRYBlCa6N3rg+Lt/9tFIFKogS8UkgA
         GHeyEaQ3o28fInNlpcYGcX7+tlb0eBwcl+FIh5XCCx5SImQO5UV6LDiEY93RUahk0DuI
         DU41E/43MjV31NeVL4Dou3FBVxJ/gksWyph1xvb0WoYr8TbCqfpEUBnBmsDFdN/7xj9X
         tLwwWLvSCL/lInFUsxJakhgPfUhwqb93IYkschuRk9FWmDUQioeCrf4gKAXvQH66XarW
         RcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKEE3yp5Rcc/md7pG2bSGfj9ZsRwTbcCIHn5InN/kNw=;
        b=BBbvrpXjUhM6KxYy1rw2kmwuiPEFz189jCrXc4KhH2Xf96xghDp09VbTuJZzsMtz54
         jxJlnTWdoHSvhMREPqQPTHEB6brXIZv6OkRev0coneyobROmmYwVAq5nPSUZPp1fsGMb
         WVc5aL6hcY4Px4HMLoXji2++YBZ7ZMNHc7JcvBeEJ86QhGHmxE7v2mxAkrnB0yQSkHSp
         VoWdZfP/d4ObogNwSsEsRj8rwf34iSA5bsbiBdnrEOiQVnSiYy+BRAkyfUoPonupF23A
         OM2Z5ZbwFUFymw0v4fQeEoyJkMKz8kkOOXrLsxzUCBRUAfXV3zHs4Tmqywa/c/4HYDwO
         FOIw==
X-Gm-Message-State: AOAM531XG9oE4fsn8whqES6MO9KqhYZ7q3BTBZM5Ny2Pb/jJC250hr2H
        hucBG3c2HVI4QQtKBWUwo3jJsJS9VUW3t2uA5JMg08ohyos=
X-Google-Smtp-Source: ABdhPJwKnTGflf3OjRpTv6fCq3h03LLJfNJI6RfNDUunk5g2o2wcmnT9KK1bw3XsjwKQAmkTA2xcwBBV8pBnPKwMV/8=
X-Received: by 2002:a5d:8a04:: with SMTP id w4mr29941997iod.68.1600488960801;
 Fri, 18 Sep 2020 21:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200916074214.995128-1-Tony.Ambardar@gmail.com>
 <20200917000757.1232850-1-Tony.Ambardar@gmail.com> <87363gpqhz.fsf@mpe.ellerman.id.au>
 <CAK8P3a3FVoDzNb1TOA6cRQDdEc+st7KkBL70t0FeStEziQG4+A__37056.5000850306$1600351707$gmane$org@mail.gmail.com>
 <87h7rw321o.fsf@igel.home>
In-Reply-To: <87h7rw321o.fsf@igel.home>
From:   Tony Ambardar <tony.ambardar@gmail.com>
Date:   Fri, 18 Sep 2020 21:15:50 -0700
Message-ID: <CAPGftE__Mh2Fp_v=Vhm3cQ1PHNFETMsXET6raTpLav-BbVQvbw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: fix EDEADLOCK redefinition error in uapi/asm/errno.h
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Rosen Penev <rosenp@gmail.com>, bpf <bpf@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 17 Sep 2020 at 07:34, Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Sep 17 2020, Arnd Bergmann wrote:
>
> > The errno man page says they are supposed to be synonyms,
> > and glibc defines it that way, while musl uses the numbers
> > from the kernel.
>
> glibc also uses whatever the kernel defines.
>
That's right, and from my investigation this isn't a libc issue. The
various libc flavours simply try to follow POSIX and the PPC ABI and
aren't doing anything wrong.

See errno.h for example (https://man7.org/linux/man-pages/man3/errno.3.html):
  EDEADLK: Resource deadlock avoided (POSIX.1-2001).
  EDEADLOCK: On most architectures, a synonym for EDEADLK.  On some
architectures (e.g., Linux MIPS, PowerPC, SPARC), it is a separate
error code "File locking deadlock error".

The root cause is unique to the Linux PPC code in
arch/powerpc/include/uapi/asm/errno.h:
  >/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
  >#ifndef _ASM_POWERPC_ERRNO_H
  >#define _ASM_POWERPC_ERRNO_H
  >
  >#include <asm-generic/errno.h>
  >
  >#undef  EDEADLOCK
  >#define EDEADLOCK       58      /* File locking deadlock error */
  >
  >#endif  /* _ASM_POWERPC_ERRNO_H */

It includes "<asm-generic/errno.h>" to pull in various definitions but
has the side-effect of redefining EDEADLOCK to a non-ABI value which
conflicts with the libc errno.h, as I outline in the patch
description. Other arches which also use different EDEADLOCK and
EDEADLK values (mips,sparc) do not do this. They define EDEADLOCK
*once*, with an ABI-consistent value, and don't have the same issue.

The problem goes back a ways (as Arnd points out), affecting current
stable and all LTS branches, so would be nice to get this sorted out.
I'm certainly interested if there's a better way than proposed in this
patch.

> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
