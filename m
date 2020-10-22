Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94842964FE
	for <lists+linux-arch@lfdr.de>; Thu, 22 Oct 2020 21:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369877AbgJVTFN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Oct 2020 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369855AbgJVTFG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Oct 2020 15:05:06 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6634C0613D9
        for <linux-arch@vger.kernel.org>; Thu, 22 Oct 2020 12:05:04 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y1so1456536plp.6
        for <linux-arch@vger.kernel.org>; Thu, 22 Oct 2020 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ob2vCJvO6llStuDKjUpnqeOT2ObygH+mOzcnW04eANY=;
        b=KQqTFOK8RfeQlRsCMQ+rOlUOsaIw3aFT2tl0EvIIitPh93BRypnBq10dbZ1VQInVA9
         YBqadNAg8WpA2s2M51/9SZIy6oP0pnbbWbfMb7wIWJV2snjJBMbyo5oSDcHw4N1zr7/S
         VZLvINfglpSloiYKbOwAZRZgsEq5EwVd6j156C6w/ZUnsQNcPlNYKpHJP5uI2nd5y9vn
         Eb462d8qlKbplpH5u1WCwEWQN9mxoYO0QRuuyd1KRKvAJJWpZKPK5rzGEmieFY4kQrsm
         FHET+zmyltpbQH7fuqtpyH09Ge3zLiQZSD5eVuK163dQLFMNQGhprwY4hoqO0xWMFeFJ
         fZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ob2vCJvO6llStuDKjUpnqeOT2ObygH+mOzcnW04eANY=;
        b=P0um3WW7LPURZ/fVMREW8gCgFTexbiC76DJeFBtdokFaXwOe4ocOMgW60Id65gk/4C
         /Gi3PAb8iBIQZsqHZMmLRBuAy2TOIpW+TY5vy6iPbo7D5TF+ZD+R/OstHwQLSkJsFczM
         FKWHrqq3tfcH41J0WgJnI7AXqt+4QmrlpKBw+sU0sbQ0b4kw3sSwPErXuthdbWNX743X
         BC05FuMF/ciwMIPasiyCAcyFqLWqiA3Fw8xcK4WYn9nBmHm4rRvJ+wuJwzPEg6cRCBO1
         w5wi8Fj+dlyKxYFtoWTKVTVKrwEutjs/ctjELDl1ObkVnXpcCGv5g+AOV/8vNGEqhDTg
         EEcg==
X-Gm-Message-State: AOAM533mI5vfM1s2EPcPqT0MSyTaSuAPhpo9kwePSYa1TVX58iaJacTw
        nzlO2WKHGBgysQjs8Ke7ply8FJVlvI0icUBu2fcFEA==
X-Google-Smtp-Source: ABdhPJywMCKq0vfUuAKWQ9RLmH3NxEeoaMuMMn+wDHsffqxkAqXyKJ4o6MiCnyTmuBnnGxJWFn5poUUGRnshTJa4lRY=
X-Received: by 2002:a17:902:c40b:b029:d3:def2:d90f with SMTP id
 k11-20020a170902c40bb02900d3def2d90fmr3608595plk.29.1603393503931; Thu, 22
 Oct 2020 12:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201021233914.GR3576660@ZenIV.linux.org.uk> <20201022082654.GA1477657@kroah.com>
 <80a2e5fa-718a-8433-1ab0-dd5b3e3b5416@redhat.com> <5d2ecb24db1e415b8ff88261435386ec@AcuMS.aculab.com>
 <df2e0758-b8ed-5aec-6adc-a18f499c0179@redhat.com> <20201022090155.GA1483166@kroah.com>
 <e04d0c5d-e834-a15b-7844-44dcc82785cc@redhat.com> <a1533569-948a-1d5b-e231-5531aa988047@redhat.com>
 <bc0a091865f34700b9df332c6e9dcdfd@AcuMS.aculab.com> <5fd6003b-55a6-2c3c-9a28-8fd3a575ca78@redhat.com>
 <20201022132342.GB8781@lst.de> <8f1fff0c358b4b669d51cc80098dbba1@AcuMS.aculab.com>
 <CAKwvOdnix6YGFhsmT_mY8ORNPTOsN3HwS33Dr0Ykn-pyJ6e-Bw@mail.gmail.com> <CAK8P3a3LjG+ZvmQrkb9zpgov8xBkQQWrkHBPgjfYSqBKGrwT4w@mail.gmail.com>
In-Reply-To: <CAK8P3a3LjG+ZvmQrkb9zpgov8xBkQQWrkHBPgjfYSqBKGrwT4w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 22 Oct 2020 12:04:52 -0700
Message-ID: <CAKwvOdnhONvrHLAuz_BrAuEpnF5mD9p0YPGJs=NZZ0EZNo7dFQ@mail.gmail.com>
Subject: Re: Buggy commit tracked to: "Re: [PATCH 2/9] iov_iter: move
 rw_copy_check_uvector() into lib/iov_iter.c"
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 22, 2020 at 11:13 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 22, 2020 at 7:54 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > On Thu, Oct 22, 2020 at 9:35 AM David Laight <David.Laight@aculab.com> wrote:
> > >
> > > Which makes it a bug in the kernel C syscall wrappers.
> > > They need to explicitly mask the high bits of 32bit
> > > arguments on arm64 but not x86-64.
> >
> > Why not x86-64? Wouldn't it be *any* LP64 ISA?
>
> x86-64 is slightly special because most instructions on a 32-bit
> argument clear the upper 32 bits, while on most architectures
> the same instruction would leave the upper bits unchanged.

Oh interesting, depends on the operations too on x86_64 IIUC?

>
> > Attaching a patch that uses the proper width, but I'm pretty sure
> > there's still a signedness issue .  Greg, would you mind running this
> > through the wringer?
>
> I would not expect this to change anything for the bug that Greg
> is chasing, unless there is also a bug in clang.
>
> In the version before the patch, we get a 64-bit argument from
> user space, which may consist of the intended value in the lower
> bits plus garbage in the upper bits. However, vlen only gets
> passed down  into import_iovec() without any other operations
> on it, and since import_iovec takes a 32-bit argument, this is
> where it finally gets narrowed.

Passing an `unsigned long` as an `unsigned int` does no such
narrowing: https://godbolt.org/z/TvfMxe (same vice-versa, just tail
calls, no masking instructions).
So if rw_copy_check_uvector() is inlined into import_iovec() (looking
at the mainline@1028ae406999), then children calls of
`rw_copy_check_uvector()` will be interpreting the `nr_segs` register
unmodified, ie. garbage in the upper 32b.

>
> After your patch, the SYSCALL_DEFINE3() does the narrowing
> conversion with the same clearing of the upper bits.
>
> If there is a problem somewhere leading up to import_iovec(),
> it would have to in some code that expects to get a 32-bit
> register argument but gets called with a register that has
> garbage in the upper bits /without/ going through a correct
> sanitizing function like SYSCALL_DEFINE3().
>
>       Arnd



-- 
Thanks,
~Nick Desaulniers
