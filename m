Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46DF7A98D
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2019 15:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfG3N3z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jul 2019 09:29:55 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41004 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfG3N3z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jul 2019 09:29:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id v22so46568314qkj.8;
        Tue, 30 Jul 2019 06:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAg4Am9X4yo26M1BZarqg6D+4kRvHZB3qRHqer+jaXM=;
        b=FwOzihKo4iQq27B05NpZE8zc1p9tjiU9Z7fGQX6O8Y7Horj6yjOg61r1CpEI4QsD5B
         w2HcBhS7ws6aJfYExKD91krl1j86x5D91OEq4wbO0uLq5qOBKh0+3KnoXyfBgWbiqU1+
         ufZOxnQhL2qwcvSxd2nLurVUNKv77Z5RrvKnGstpOAZY3o2eCKxEELBePdy6wnXQuBpI
         56mPVGF1jg8mEE8ond1kAyV+LRZVcVfz51SEz2vl518NLCsyVEcpaXM3h8cG1/fXehuo
         7ySC8VxLSA5oRPS+HfoCCVdan6QZVjSTNPwj2Y/DSG3bldP87B552P4IP1nhk3U2TTdz
         7O0w==
X-Gm-Message-State: APjAAAVZd5T/sPD/AqqIIeDtBM1yhkN94wEsOTLDXf8BI29Fl31VoaVF
        QaAHiir/l7+3jKZyUYNg4o6t5i8sbkUsObMONa0bCtKd
X-Google-Smtp-Source: APXvYqyxtFUvmdvb26Ngz9rBg9K5p3xBe/SoFc4hciPltmdnSmvl/LpUwagyRclAJwfu9ZQGiLRooWXyG4QSGZRe6eA=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr74039470qka.138.1564493394364;
 Tue, 30 Jul 2019 06:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1564488945-20149-1-git-send-email-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 15:29:38 +0200
Message-ID: <CAK8P3a03tXXHQ00QEGg=7p17mmseuJqRhuumWKzS8dCYvXHkBg@mail.gmail.com>
Subject: Re: [PATCH 1/4] csky: Fixup dma_rmb/wmb synchronization problem
To:     Guo Ren <guoren@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com,
        zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com,
        zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 30, 2019 at 2:15 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <ren_guo@c-sky.com>
>
> If arch didn't define dma_r/wmb(), linux will use w/rmb instead. Csky
> use bar.xxx to implement mb() and that will cause problem when sync data
> with dma device, becasue bar.xxx couldn't guarantee bus transactions
> finished at outside bus level. We must use sync.s instead of bar.xxx for
> dma data synchronization and it will guarantee retirement after getting
> the bus bresponse.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

This change looks good to me, but I think your regular barriers
(mb, rmb, wmb) are still wrong: These are meant to be the superset
of dma_{r,w}mb and smp_{,r,w}mb, and synchronize
against both SMP and DMA interactions.

I suspect you can drop the '.s' for non-SMP builds. What I don't
see is whether you might need to add '.i' for dma_wmb() or
dma_rmb().

       Arnd
