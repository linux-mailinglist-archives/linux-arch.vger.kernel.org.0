Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE5D89596A
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 10:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfHTI0n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 04:26:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfHTI0n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 04:26:43 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6387823A84;
        Tue, 20 Aug 2019 08:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566289602;
        bh=hdmanysHDb8PuQuXvQtksI870aVXPSFmN+iWwoWkq+c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DbMWsHnjPgOtGnoxKP4XdMnWoq3Z5bxRHRAVGMbkRxd6lVkhU92hGvtxZ0uMgaeUY
         HWW2nArujbR6SYFcu2y9nEzMTIup5daZJcu6WMQhkoqlJRG76XmtqJ2V1r8c1oVrBM
         qlT6hGr/0tYzbqAq1PmlGUXOaZW6AOXh1NyB0oxk=
Received: by mail-wr1-f46.google.com with SMTP id s18so11439933wrn.1;
        Tue, 20 Aug 2019 01:26:42 -0700 (PDT)
X-Gm-Message-State: APjAAAWcmPVqAyDXWL+k/s+lP6Ey9XfY7cY7zzvR4DdYG5uYSfmqSPoN
        KpRtW8LGjT5lUSibxajLORrFjzuTPem5X9I1jYc=
X-Google-Smtp-Source: APXvYqxJDOU2yCLgISh7MDluIUhar/3J/7PrIJCYuvKYjNhX/ZO57FI5BdiPFThETR6zIPsJ1GragQc3ypBJbA0H0S8=
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr32042773wrp.38.1566289599845;
 Tue, 20 Aug 2019 01:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <1565868537-17753-1-git-send-email-guoren@kernel.org>
 <20190816070348.GA13766@infradead.org> <CAJF2gTTBc3+SnKMbVU4A+tekyjkd_7XUmDCUfNCcA-CZf=JUyg@mail.gmail.com>
 <20190818182118.GA30141@infradead.org>
In-Reply-To: <20190818182118.GA30141@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 20 Aug 2019 16:26:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQhEHC-PUb0bORu2DLdgPOKh5kG7=mCi7=dMfCMZOUAcA@mail.gmail.com>
Message-ID: <CAJF2gTQhEHC-PUb0bORu2DLdgPOKh5kG7=mCi7=dMfCMZOUAcA@mail.gmail.com>
Subject: Re: [PATCH] csky: Fixup ioremap function losing
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, zhang_jian5@dahuatech.com,
        Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 19, 2019 at 2:21 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Aug 18, 2019 at 10:20:18AM +0800, Guo Ren wrote:
> > > > Also change flag VM_ALLOC to VM_IOREMAP in get_vm_area_caller.
> > >
> > > Looks generally fine, but two comments:
> > >
> > >  - do you have a need for ioremap_cache?  We are generally try to
> > >    phase it out in favour of memremap, and it is generally only used
> > >    by arch specific code.
> > Yes, some drivers of our customers use ioremap_cache to map phy_addr
> > which isn't belong to system memory.
>
> Which driver?  We should move it over to memremap instead of adding
> a new ioremap_cache.
The driver hasn't been upstreamed. OK, just remove ioremap_cache and
seems it's not a big problem.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
