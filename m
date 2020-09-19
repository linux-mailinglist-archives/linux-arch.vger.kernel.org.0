Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9725D270FDB
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 19:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgISRp4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 13:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgISRp4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 13:45:56 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186C6C0613CE;
        Sat, 19 Sep 2020 10:45:56 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v8so3976484iom.6;
        Sat, 19 Sep 2020 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqIvwdnOSjAHddCU85P/HSWVpvwA3NGs8Q6mRONCYtU=;
        b=tNG/7qgfSv3KJKzY+MtjBYmgHCdp8UBgqNItDe5F7FDIKPe9kRM9dYX/wgxXsNeKo8
         hvT7jE5V1Z2gTTVHOX9IbUL0r3c+bFPouhMS8i0S2Hww2xsCe5QUx8/3hWfvFbLyYkhM
         Zae2R0aP+aMy8+LWGHImo5PHglLppa7IT4FZbWFEGn/vetxq4vLC8MOPaN8blQqjCBqY
         urMyvw6jy5CONCdw/aKWal0YXgq0H2g1qUBUo9OLGICTcy7ANwD8JqNteW5w7WKfYARV
         CS6LRAFQoUr8/66nYQScOHKrJ37vlpX/p5EOjhSTfM2i9DmebqlqqMvFwu8r1y04VDM3
         sCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqIvwdnOSjAHddCU85P/HSWVpvwA3NGs8Q6mRONCYtU=;
        b=bScuHlT6NtQOSBcFOeKPr8Nk1dfFY0Sxx6AQHbnonEdvfaKZizCZNs/WyIKle0Y8Cq
         Ly3LGcLOgEWnvEtYaCcrPn+CCq5UtseVqyFIeogm7X7cKJ6jNPrfFJMSBThC3ohViCzr
         uMxqq7dRYutt/l4onHL4SzzdSr3TyyOICkwET3uSA6Z7RedRdfPiH/Xw9KaWtsn7OVcZ
         0q3OrWkN3ixkny40HaqjQQL7yTTlO8rnaXh0xxXnVrqu9bXW5s+DHUKxxM4Sgf3579W0
         NwdW3n3XdT1JSuMeeStdMlDHPb0//vdxk8y2kI5MTjHGeQ9c6Rhup/NQ/wejo/OrW6GT
         BUFA==
X-Gm-Message-State: AOAM533oTo7ILI+RwimIUSpknrOq0LZWRfbsuCIskLnrUIos/vWOxkFr
        d9b9yAFD/wW+z0GcI7sVTloOjP2RS02ylw+L6g==
X-Google-Smtp-Source: ABdhPJy/+swOxx+O/gjUkATrtV+0W+I/532k4HwgKzgpB8LaS3UpaasFbGc1h4Q07NmdRoupikU1hHQEg5Ygt1lOBVI=
X-Received: by 2002:a6b:6c0c:: with SMTP id a12mr24437450ioh.40.1600537554347;
 Sat, 19 Sep 2020 10:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200918132439.1475479-1-arnd@arndb.de> <20200918132439.1475479-2-arnd@arndb.de>
 <20200919053514.GI30063@infradead.org> <CALCETrVDqHG2chDsLWBHF39SXh6vjzE_xcEs+AWgOg5531BLuQ@mail.gmail.com>
 <85F32523-4E9E-443A-A150-10A9E5EB0CE3@zytor.com>
In-Reply-To: <85F32523-4E9E-443A-A150-10A9E5EB0CE3@zytor.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sat, 19 Sep 2020 13:45:43 -0400
Message-ID: <CAMzpN2jircsR81ZLdq7r3UTVrM9Bp-PL7h=V+k5B93oJx26G-w@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86: add __X32_COND_SYSCALL() macro
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

An alternative to the patch I proposed earlier would be to use aliases
with the __x32_ prefix for the common syscalls.

--
Brian Gerst

On Sat, Sep 19, 2020 at 1:14 PM <hpa@zytor.com> wrote:
>
> On September 19, 2020 9:23:22 AM PDT, Andy Lutomirski <luto@kernel.org> wrote:
> >On Fri, Sep 18, 2020 at 10:35 PM Christoph Hellwig <hch@infradead.org>
> >wrote:
> >>
> >> On Fri, Sep 18, 2020 at 03:24:36PM +0200, Arnd Bergmann wrote:
> >> > sys_move_pages() is an optional syscall, and once we remove
> >> > the compat version of it in favor of the native one with an
> >> > in_compat_syscall() check, the x32 syscall table refers to
> >> > a __x32_sys_move_pages symbol that may not exist when the
> >> > syscall is disabled.
> >> >
> >> > Change the COND_SYSCALL() definition on x86 to also include
> >> > the redirection for x32.
> >> >
> >> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Adding the x86 maintainers and Brian Gerst.  Brian proposed another
> >> problem to the mess that most of the compat syscall handlers used by
> >> x32 here:
> >>
> >>    https://lkml.org/lkml/2020/6/16/664
> >>
> >> hpa didn't particularly like it, but with your and my pending series
> >> we'll soon use more native than compat syscalls for x32, so something
> >> will need to change..
> >
> >I'm fine with either solution.
>
> My main objection was naming. x64 is a widely used synonym for x86-64, and so that is confusing.
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
