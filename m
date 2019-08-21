Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0E19707C
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 05:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfHUDov (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 23:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfHUDov (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 23:44:51 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10C682339D;
        Wed, 21 Aug 2019 03:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566359090;
        bh=5By/2PQuRdlPIlpzsaXsOgc4JfIVlhrhXv7f5LnEHKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QzyJdl7JfTokId/OZ05ag4GqyaLSc+97+Qr759zCC5F4lo9A+kAn6tXgReiG5wDqb
         9pWj84VWLn6SXcDisDg+y16+eHXAlhjk1Lji0fwC2q4ZAlj9bZ/jdBEEkv5SFjn4gE
         ar/mQNNErQoofDSufqvNxNs5c3QgEijheCaAXTx4=
Received: by mail-wr1-f43.google.com with SMTP id c3so567568wrd.7;
        Tue, 20 Aug 2019 20:44:49 -0700 (PDT)
X-Gm-Message-State: APjAAAXI4E5nHAPsVRZr2L9GtaHwqMAyRj/AUCPNXe7+ScQESy4y395w
        O1PAmVJ5QUHAr+OKJ0+/uTjtsMtUusaHjvYjvUA=
X-Google-Smtp-Source: APXvYqwpNARCWTRvG8bJmmduzy/ZlcmBCfJsdbgjHCLXGhjssnRv6bIS4UH1D85rlz959KH9WxXZJhI1IXymcFRCT9M=
X-Received: by 2002:a5d:66c8:: with SMTP id k8mr1028491wrw.7.1566359088581;
 Tue, 20 Aug 2019 20:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <1566304469-5601-1-git-send-email-guoren@kernel.org> <20190821021650.GA32710@infradead.org>
In-Reply-To: <20190821021650.GA32710@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 21 Aug 2019 11:44:37 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR196j8BPwZZLC3f--oKWnPYZFuY78efNgnRyhzrQR4Yw@mail.gmail.com>
Message-ID: <CAJF2gTR196j8BPwZZLC3f--oKWnPYZFuY78efNgnRyhzrQR4Yw@mail.gmail.com>
Subject: Re: [PATCH 1/3] csky: Fixup arch_get_unmapped_area() implementation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, douzhk@nationalchip.com,
        Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thx Christoph,

On Wed, Aug 21, 2019 at 10:16 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +/*
> > + * We need to ensure that shared mappings are correctly aligned to
> > + * avoid aliasing issues with VIPT caches.  We need to ensure that
> > + * a specific page of an object is always mapped at a multiple of
> > + * SHMLBA bytes.
> > + *
> > + * We unconditionally provide this function for all cases.
> > + */
>
> On something unrelated: If csky has virtually indexed caches you also
> need to implement the flush_kernel_vmap_range and
> invalidate_kernel_vmap_range functions to avoid data corruption when
> doing I/O on vmalloc/vmap ranges.

I'll give another patch for this issue

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
