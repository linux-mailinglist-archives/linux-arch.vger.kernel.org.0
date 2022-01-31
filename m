Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFB64A48BC
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 14:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241452AbiAaNxN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 08:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiAaNxM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 08:53:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A4FC061714;
        Mon, 31 Jan 2022 05:53:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DA31B82B2E;
        Mon, 31 Jan 2022 13:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FBEC340F9;
        Mon, 31 Jan 2022 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643637190;
        bh=ubnmPmWzE8WZHK6ZDIgiYDZ8V5Auo9sjXu6gY0DackM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tE6Azk07ef7p3PyY9nPWsvB4UG0ym7aIa7c0/Aq4ps9A01ne0MZvdOrWsFqal0AiU
         0P7V4TI/ZhF33PhVXme354y8saJj86gikF7RnUZvdvua8uDRQHsud7M0acourjCUn9
         zdR16D1WrF68aNJlsNa9P3qBuqWtesfv8rw5IF2hNE5wWlmhVz2+xC6JL/7OFxTrUu
         iYRe6d4g7Gbq/Qos37N0Q1pmKEbdxburfCFLWH+4ZWaTzMUR00B3+zFQtir0xTCFaf
         b1l+X6y8wEge0g7mMXhya3HjmyH2u/XnQNDpSggCfTYPXq4wmSCGpISV7WE9u1iTrZ
         WZsj7ejW6v9Gw==
Received: by mail-vs1-f47.google.com with SMTP id t20so11856012vsq.12;
        Mon, 31 Jan 2022 05:53:10 -0800 (PST)
X-Gm-Message-State: AOAM533xM7vLzjc1c+Jr/9SLC4MLJIS9l/ZE3ZEtR+Zx6Svsl29tEbKy
        cS7j7wNW7cKzT6P29gHs4G13w0D1UG6pIl3/EPw=
X-Google-Smtp-Source: ABdhPJwJr063nx9nXXC4e7XbyWpioW1G/tD5r4ayyBqg50Z49dU59MzIv8eNccq661nAVS/wEBLJ08MiD/T+S+t5NT0=
X-Received: by 2002:a67:e947:: with SMTP id p7mr7925194vso.59.1643637189058;
 Mon, 31 Jan 2022 05:53:09 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-4-guoren@kernel.org>
 <YffURrqD0pfXnEkV@infradead.org>
In-Reply-To: <YffURrqD0pfXnEkV@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 31 Jan 2022 21:52:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSQafQxzAyaD90n-O6pPo22RCDXdsrOn=csUJBur0u-Ew@mail.gmail.com>
Message-ID: <CAJF2gTSQafQxzAyaD90n-O6pPo22RCDXdsrOn=csUJBur0u-Ew@mail.gmail.com>
Subject: Re: [PATCH V4 03/17] asm-generic: compat: Cleanup duplicate definitions
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 31, 2022 at 8:21 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Jan 29, 2022 at 08:17:14PM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > There are 7 64bit architectures that support Linux COMPAT mode to
> > run 32bit applications. A lot of definitions are duplicate:
> >  - COMPAT_USER_HZ
> >  - COMPAT_RLIM_INFINITY
> >  - COMPAT_OFF_T_MAX
> >  - __compat_uid_t, __compat_uid_t
> >  - compat_dev_t
> >  - compat_ipc_pid_t
> >  - struct compat_flock
> >  - struct compat_flock64
> >  - struct compat_statfs
> >  - struct compat_ipc64_perm, compat_semid64_ds,
> >         compat_msqid64_ds, compat_shmid64_ds
> >
> > Cleanup duplicate definitions and merge them into asm-generic.
>
> The flock part seems to clash with the general compat_flock
> consolidation.  Otherwise this looks like a good idea.
Okay, In the next version, I would rebase on general compat_flock
consolidation v4.



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
