Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99C7B109563
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2019 23:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfKYWHW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Nov 2019 17:07:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33952 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYWHV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 17:07:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so20071078wrr.1
        for <linux-arch@vger.kernel.org>; Mon, 25 Nov 2019 14:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhRJfC42Zy9yh+o0cz+bGXWAytZm/gsembohKgd7C0M=;
        b=Rv2c1m4VasDNY7QavJ8UGtdRPm21rpDCDn4wlaYRoqezXbbv3S0zKiZs9bgIDzNm/9
         wwmrPwZp75toICUvSLVlHJeELvXzJhK5xvkgpXbsdu0oo9i7zEsF8YnVCTvL3r4k5trV
         mU0/oYu1j75rO2Vyda7m6hCEJlt3h2aVwQM1kSElsxsi5ermabL8Gurzh0ilY2WwEdch
         nzJDBy6g5M0CxkAh3eX57+Sop5ZLg3pQkMtky89mSjmOQoKXHYRC2emdHsMNQJ9OAJDV
         7DXh6+cMiHaC+4i3Y1XP+VKQcE2wGcF8Qomb6FP4o4wMRy888HK95VW7lrg8Nsw4t6GQ
         nMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhRJfC42Zy9yh+o0cz+bGXWAytZm/gsembohKgd7C0M=;
        b=Ke0EUV9hCeejLssogdtl26Yw/+MCYbLrM54ngJJsAlUZm6KgyW+cH99XZMvnhKUuxp
         GBvANxn+2V74sNyynJnrquxsBRxVi8YUeWeDgDFVG9+ixPklAcoqgdc1RVAJ0phJxpLu
         b5QDu4lqsWxXxEMlcvV8TKs1Ire1ykpkhl4eyHqNIFcJpPAeW1Valhas4OJ2zriAZx1+
         ophj9HNQ0OBUv+3I/1fQaKegQ2lGsWkw5C0fcR12nOKPnObBZZNet7Cji7+Yt/jL5zL+
         QNyJB/kdjhR05r4laDvcCukrT8UEmS78GpWhlXcQAf4Luyy+2luhlt6EDmDkNMvWsqXB
         pOMA==
X-Gm-Message-State: APjAAAXsOEWFuiuMXYXpnrRjSRoVsKhDeLtbusYuX0hAZdIp0Kcsog5D
        JuzAYpmPBzb0H9i0LQCeaDnyuGT8TxjxLs0zWYc=
X-Google-Smtp-Source: APXvYqzDf4XZFKNVFfRylQQCZAkytmjoNRSXyQZ6ZF9o9MRS3qQePu6vCJFAg6p5j92Gh5wFNvkilhG5N22mDN3ygPY=
X-Received: by 2002:adf:de0a:: with SMTP id b10mr33969770wrm.268.1574719640469;
 Mon, 25 Nov 2019 14:07:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com> <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com>
In-Reply-To: <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 25 Nov 2019 23:07:09 +0100
Message-ID: <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com>
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Conrad Meyer <cem@freebsd.org>,
        Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        Yuan Liu <liuyuan@google.com>,
        Patrick Collins <pscollins@google.com>,
        linux-kernel-library@freelists.org,
        Michael Zimmermann <sigmaepsilon92@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> Add helpers for implementing host virtio devices. It uses the memory
> mapped I/O helpers to interact with the Linux MMIO virtio transport
> driver and offers support to setup and add a new virtio device,
> dispatch requests from the incoming queues as well as support for
> completing requests.
>
> All added virtio devices are stored in lkl_virtio_devs as strings, per
> the Linux MMIO virtio transport driver command line specification.

Did you checkout arch/um/drivers/virtio_uml.c?
Why is this driver needed?

Virtio support is rather new in UML, we definitely need a common
code base for LKL and UML regarding to virtio.

-- 
Thanks,
//richard
