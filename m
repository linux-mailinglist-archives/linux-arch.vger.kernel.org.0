Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C3F6F71BD
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 20:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEDSHG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 14:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDSHF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 14:07:05 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620E830C2;
        Thu,  4 May 2023 11:07:03 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-61b5a6865dfso6679466d6.3;
        Thu, 04 May 2023 11:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683223622; x=1685815622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V535/fMfcjeqLiO2/vab+SRrcLiLBAaen1OstfXBeK8=;
        b=ZmkM8UcRuviiMSd7Q8VM/zaA3XhH1eQ52DzTlNTkbYGYPSMfQT+BcyIRlS6e9FyYf7
         2iAdw29CgKH6JHvEq9j7HF0ArgFb0AViqHKpYMRkrSXKs3VNl/vivRBBdeRWU7rnshMt
         DLviYcsJBnIVtlSJnW/X91bwcbujOCiVjBUhKQXZBV8LgQPDrp0iKz6e6m//U7H2eUK7
         d3026LWjbVuYqrsFAlDznctGJl0/SzIBtwcADaUxafkeAwLU/1cTB8SEu+DDIZxoPK/f
         sWfVWOw9ABvWwk/CcuMDcv7XPp3brZeWZIPyKMTDwP8JAXHj+Q/3rTUKFS2QL84QgKQp
         k9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683223622; x=1685815622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V535/fMfcjeqLiO2/vab+SRrcLiLBAaen1OstfXBeK8=;
        b=WYEjJ992GjzegBDCVcrQ1HIgOtOvF5q78Q1rykyCQyamgTazTe913W1KJuJ4n70g+4
         DGYr0fPIAJLAC/b0cF78FvsgmqLwei8kqBBDmdb8fsBGFtBnB1UotPo5QbrEBpmAcvLY
         lYEZ/DOD6JJvbFlTfpywAs+MpfQcTHxrVGFRPgMHOCBKoMQHXFZh+xNHX1Dv4Z+QTTBV
         v47q9PvuWtO60gWwNMZ8BN8D9T1nNMMcUTRlcWQZe0/5jMe3Ytp6wfqyQ2Dh+LkyuHlT
         esFPItdl5LgVpyBocxv7hV/N/a3uw9hD1bU89pKbpl/boo6uAQlcZaUKtUiSDtZ1OPrb
         CcDQ==
X-Gm-Message-State: AC+VfDwtW5OUU9BjnemUZ5TKJN+lJakN+NQz7Y6xwNRxLvoT6bvPQGe6
        OcyALAr5g5lsyYmnSY65b7/VlRE2DTTJDDZu9T12dHL7/GhWPQ==
X-Google-Smtp-Source: ACHHUZ4diJ2WJC49P78EhjIm9s71+L2giKPw2hIr18KuA4zbtBNSjYIf+qmkj0b5DqNSh8DaUowYRWzsY035Obqzo1k=
X-Received: by 2002:ad4:5bcc:0:b0:5ac:fb9a:67a1 with SMTP id
 t12-20020ad45bcc000000b005acfb9a67a1mr14751083qvt.47.1683223622413; Thu, 04
 May 2023 11:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230503013608.2431726-1-nphamcs@gmail.com> <20230503013608.2431726-3-nphamcs@gmail.com>
 <CAMuHMdWUtb_A-uhXrBg6kC9L2zbC_q3m8oCZoq80ZSJvk6mUAA@mail.gmail.com>
In-Reply-To: <CAMuHMdWUtb_A-uhXrBg6kC9L2zbC_q3m8oCZoq80ZSJvk6mUAA@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 4 May 2023 11:06:51 -0700
Message-ID: <CAKEwX=PPVoX0EDU8LQQomg3tnLooyZFy2MZhyTyfwV07E_-59A@mail.gmail.com>
Subject: Re: [PATCH v13 2/3] cachestat: implement cachestat syscall
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 4, 2023 at 10:26=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Nhat,
>
> On Wed, May 3, 2023 at 3:38=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> > There is currently no good way to query the page cache state of large
> > file sets and directory trees. There is mincore(), but it scales poorly=
:
> > the kernel writes out a lot of bitmap data that userspace has to
> > aggregate, when the user really doesn not care about per-page
> > information in that case. The user also needs to mmap and unmap each
> > file as it goes along, which can be quite slow as well.
> >
> > Some use cases where this information could come in handy:
> >   * Allowing database to decide whether to perform an index scan or
> >     direct table queries based on the in-memory cache state of the
> >     index.
> >   * Visibility into the writeback algorithm, for performance issues
> >     diagnostic.
> >   * Workload-aware writeback pacing: estimating IO fulfilled by page
> >     cache (and IO to be done) within a range of a file, allowing for
> >     more frequent syncing when and where there is IO capacity, and
> >     batching when there is not.
> >   * Computing memory usage of large files/directory trees, analogous to
> >     the du tool for disk usage.
> >
> > More information about these use cases could be found in the following
> > thread:
> >
> > https://lore.kernel.org/lkml/20230315170934.GA97793@cmpxchg.org/
> >
> > This patch implements a new syscall that queries cache state of a file
> > and summarizes the number of cached pages, number of dirty pages, numbe=
r
> > of pages marked for writeback, number of (recently) evicted pages, etc.
> > in a given range. Currently, the syscall is only wired in for x86
> > architecture.
> >
> > NAME
> >     cachestat - query the page cache statistics of a file.
> >
> > SYNOPSIS
> >     #include <sys/mman.h>
> >
> >     struct cachestat_range {
> >         __u64 off;
> >         __u64 len;
> >     };
> >
> >     struct cachestat {
> >         __u64 nr_cache;
> >         __u64 nr_dirty;
> >         __u64 nr_writeback;
> >         __u64 nr_evicted;
> >         __u64 nr_recently_evicted;
> >     };
> >
> >     int cachestat(unsigned int fd, struct cachestat_range *cstat_range,
> >         struct cachestat *cstat, unsigned int flags);
> >
> > DESCRIPTION
> >     cachestat() queries the number of cached pages, number of dirty
> >     pages, number of pages marked for writeback, number of evicted
> >     pages, number of recently evicted pages, in the bytes range given b=
y
> >     `off` and `len`.
> >
> >     An evicted page is a page that is previously in the page cache but
> >     has been evicted since. A page is recently evicted if its last
> >     eviction was recent enough that its reentry to the cache would
> >     indicate that it is actively being used by the system, and that
> >     there is memory pressure on the system.
> >
> >     These values are returned in a cachestat struct, whose address is
> >     given by the `cstat` argument.
> >
> >     The `off` and `len` arguments must be non-negative integers. If
> >     `len` > 0, the queried range is [`off`, `off` + `len`]. If `len` =
=3D=3D
> >     0, we will query in the range from `off` to the end of the file.
> >
> >     The `flags` argument is unused for now, but is included for future
> >     extensibility. User should pass 0 (i.e no flag specified).
> >
> >     Currently, hugetlbfs is not supported.
> >
> >     Because the status of a page can change after cachestat() checks it
> >     but before it returns to the application, the returned values may
> >     contain stale information.
> >
> > RETURN VALUE
> >     On success, cachestat returns 0. On error, -1 is returned, and errn=
o
> >     is set to indicate the error.
> >
> > ERRORS
> >     EFAULT cstat or cstat_args points to an invalid address.
> >
> >     EINVAL invalid flags.
> >
> >     EBADF  invalid file descriptor.
> >
> >     EOPNOTSUPP file descriptor is of a hugetlbfs file
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>
> This should be wired up on each and every architecture.
> Currently we're getting
>
>     <stdin>:1567:2: warning: #warning syscall cachestat not implemented [=
-Wcpp]
>
> in linux-next for all the missing architectures.
Hi Geert,

I saw that there are several instances where we have separate
patches to wire up a syscall to these architectures, so I was doing
something similar.

For e.g:

ARM: wire up process_vm_writev and process_vm_readv syscalls
(e5489847d6fc0ff176048b6e1cf5034507bf703a)

MIPS: Hook up process_vm_readv and process_vm_writev system calls.
(8ff8584e51d4d3fbe08ede413c4a221223766323)

As for these non-x86 architecture wiring patches, I can give it a shot
and cross-compile to see if it builds, but I have limited abilities for
runtime tests as I don't have machines with these architectures. I
would really appreciate it if there are arch people that could help
wire it up.

(cc-ing linux-arch as well)


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
