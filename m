Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3DC44565D
	for <lists+linux-arch@lfdr.de>; Thu,  4 Nov 2021 16:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhKDPdz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Nov 2021 11:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhKDPdz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Nov 2021 11:33:55 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6EFC06127A
        for <linux-arch@vger.kernel.org>; Thu,  4 Nov 2021 08:31:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s24so10117215lji.12
        for <linux-arch@vger.kernel.org>; Thu, 04 Nov 2021 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QAo7m/CHBig/gC/gJf3MNUDBsTpRnbUruOTSeeBqwY=;
        b=DaYc6Oru//OTng13euyJtXLjP+RvfN1sUp8v8a7RPiP8x+esGv2tIX5Jo2TqzJmu5o
         P2cHfPwbTfu4VwimsMLpflnkeXymZj/6cAq0WvglsWDx90FAFzo8kBZm1TFzgPn4GsZ3
         fkKTnJt7NIae0wBqwyykR8nNBuLUqTFHb9KrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QAo7m/CHBig/gC/gJf3MNUDBsTpRnbUruOTSeeBqwY=;
        b=L7Cf2hGhY9YpQCwQw2xqojK4U3b4DoAyRPwZLzOjUFJ6pZL8bl9zzsHVfHPJ7eNfFU
         d6h38rOMpNsFQQGIbmQK+Ac+MtZ6E7NZEUeMDNREkhU7MppISNMomxAUB6/A3mumPjzO
         OIzkH9VFMpvO9dDFjGY9yU7EpvURdztv3cItpR9tcMewcypImqpZzmpKbtH31Ttift4v
         BcWFNLNvp/Nk+z3negZOD0M/1juCBJGDSA5w0Dy8pBS2kjbo0oIAEh7Y5NKC0qOrtczc
         Rt/027t2LsGkHFgGcEPgUTlctwxo3imy4LN0sJ2J2D0KSevQYvapDRX4tRNiS7tCzP7r
         aPtQ==
X-Gm-Message-State: AOAM532WBcwDO/VdP6zTZPFxwrDukmYkGjEpqjfG1OPRZVLvb11HUPLe
        FmcLZghd5V2Hw4KBVAlQzm2x9tjLA6hL7rYp
X-Google-Smtp-Source: ABdhPJyEYKYkDh37pPThDRSmmulSVY1vFIBCcuOBy+VoOSca20ZhuPonKTzHj86cyPhOwji+gkSBvw==
X-Received: by 2002:a2e:b6d1:: with SMTP id m17mr52614717ljo.468.1636039873650;
        Thu, 04 Nov 2021 08:31:13 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id bt20sm502386lfb.47.2021.11.04.08.31.11
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 08:31:11 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id r10so8999792ljj.11
        for <linux-arch@vger.kernel.org>; Thu, 04 Nov 2021 08:31:11 -0700 (PDT)
X-Received: by 2002:a05:651c:113:: with SMTP id a19mr9236128ljb.249.1636039871361;
 Thu, 04 Nov 2021 08:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <YYP1lAq46NWzhOf0@casper.infradead.org>
In-Reply-To: <YYP1lAq46NWzhOf0@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Nov 2021 08:30:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
Message-ID: <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
Subject: Re: flush_dcache_page vs kunmap_local
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 4, 2021 at 8:03 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Linus offers the opinion that kunmap calls should imply a
> flush_dcache_page().  Christoph added calls to flush_dcache_page()
> in commit 8dad53a11f8d.  Was this "voodoo programming", or was there
> a real problem being addressed?

I don't think anybody actually uses/cares about flush_dcache_page() at
all, and pretty much all uses are random and voodoo.

No sane architecture uses pure virtual caches, and the insane ones
haven't been an issue for a long time either.

But if there are still systems with pure virtual caches, and they need
manual cache flushing, then I do think that kunmap is one of the
points that needs it, since that's the "I'm done accessing this data
through this virtual address" place.

End result: I really don't think anybody cares any more (and only
truly broken architectures ever did). I'd personally be perfectly
happy just saying "we might as well drop support for non-coherent
caches entirely".

But as long as we have those random odd "flush dcache manually"
things, I think kunmap() is one of the places that probably should
continue to do them.

Of course, the kunmap case is _doubly_ irrelevant, because we should
certainly hope that not only are those noncoherent pure virtual caches
a thing of the past, highmem itself should be going away.

Why did this come up? Do you actually have some hardware or situation
that cares?

                   Linus
