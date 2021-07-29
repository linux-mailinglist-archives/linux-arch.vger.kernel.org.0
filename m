Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD0C3DA25B
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhG2LoC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 07:44:02 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42157 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhG2LoC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jul 2021 07:44:02 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MfI21-1moS0b0Bxb-00gsOo; Thu, 29 Jul 2021 13:43:58 +0200
Received: by mail-wm1-f45.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so3824085wmd.3;
        Thu, 29 Jul 2021 04:43:57 -0700 (PDT)
X-Gm-Message-State: AOAM532warOa1r2ZI+rvjck7n4+3nSMJXaK2FyRIr+n/AV94aWMWgMqp
        N09coDnNGrrFXdKdYXvQFuv6r8yqFvWrYpwcUbg=
X-Google-Smtp-Source: ABdhPJxbppc/JPPZnVXIJRhSL3wkyGUoLrN10oQdMb92u/LFvTxbI6h5V4i9grXrLQRAisKA2AJVJvfij5OI1JtTHOU=
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr14185233wmk.84.1627559037719;
 Thu, 29 Jul 2021 04:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210729093003.146166-1-wangrui@loongson.cn> <20210729095551.GE21151@willie-the-truck>
In-Reply-To: <20210729095551.GE21151@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Jul 2021 13:43:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ru0VSYLohoFOd=P=Fjb8BS=1qpMGSf4jdxF4oxmH-ag@mail.gmail.com>
Message-ID: <CAK8P3a3ru0VSYLohoFOd=P=Fjb8BS=1qpMGSf4jdxF4oxmH-ag@mail.gmail.com>
Subject: Re: [RFC PATCH v3] locking/atomic: Implement atomic{,64,_long}_{fetch_,}{andnot_or}{,_relaxed,_acquire,_release}()
To:     Will Deacon <will@kernel.org>
Cc:     Rui Wang <wangrui@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rui Wang <r@hev.cc>, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PSd/ZKkm0Owrv69gRb7RozUkEsniD7dBmfYhgnfNlHML70dbmK5
 4dpC8socb6Mo7NahTBtqxjFxWJdrx5s4AbspJvB0gNVtNt0l3IW4DCj7+Hmf0CKODoinQAd
 IX6EZgUi1DdWJlXqlzpOBvqzBB2NgOqNxkZPoqREgcI3vtkWz4aGwTqqi0dleE9AqoAdQqY
 lBXPghoiiU2tyis5cENQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ycsMeSeDWD0=:MF/GyuibULUA0ncJVim/S7
 Rzz3cAKMNB5D+IjQOG2OV2QwtWqSyfRVoTozxbUVPxhC15VIX1qwLKR5m6c5qCCgrRD5DD9Ok
 ij24tjsqiCbIptNK+fUWAAgxzgarWAEQxdDLHDUJ2+2efHmgN0RrE+JT/1w/S7BpHD9sLJihW
 L9bkXqumCmhmM9lz/FYTNeUsgXJr6R1ojMe3D4ZkwtI1kvrxGvfXzzPzdsEluDOCubVFyObbB
 bLNWsb60cNjT+FBaKl/UAu7CjTxQu/JsTNwO66sGTRjnk9aRY2EmUit0BuiWbL+nqTCQzoG0V
 H5UYWGdWcQkH8KLABPxV32IQ3J3/FKeZ4eTFSFLxzJ2z/qLMJzVwYEcdI5NZvVeqGesYHip5/
 zZW/3uRL/p8L7RBQIbKWlnx+kDFO6aG4MLiVJ+k9EN4GY4kU2nhQP4t3ThCv3KKcxx/xn0cdo
 UGqx1E4Z4IY3/71unYEmWJbuwtu5osnin84GkffE262tQPEixoKjpu0Jqsf0n6WRq4ZJMJnQo
 Q2skttKr7luh1558MwZ0qLCPSsPvYU7hyGHPmcVURKhfkNafnr5RV7+ieNxC1Db197YSYswW/
 lIsxn6mE3NX40PB1A8vwGEL35XgvkTOmr+YGx57c6qFXI6cTGNdhcahyGsx1cE/64bWRJCo+m
 17AZMCFx0BVRyKgHPuQdrpL6UjmRY2i381T9GdRMyocFhHxYwd5K5Yxsp8XDIzUa3SNcG7dKa
 gqYGWToqSgWfomDQ+ayfimSn56zpRaD26SygUeoTq55JK7CTDTGON4bLnh1fRR8GLgCKMwna5
 Hz+gOtkMKwF3AvsIpBFMVmGjBK4IEsHrLR7NUjGj1tw1BTHemp22DIoeVo36mWuszb0zTJCLm
 IgsVU8aCxSrWkbBInkEMMfTuLw9x4ooPhoxdT6NrykNlbOB4DSNQBBPKpO756myD/gsIppJyl
 CXQJZ7pbPXSY+HgE2cXxXoI1JkD5ZPkhKjF2Mt62M+2KGfWfoxaLo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 29, 2021 at 11:56 AM Will Deacon <will@kernel.org> wrote:
> On Thu, Jul 29, 2021 at 05:30:03PM +0800, Rui Wang wrote:
> > This patch introduce a new atomic primitive andnot_or:
>
> Please see my other comments on the other patches you posted:
>
> https://lore.kernel.org/r/20210729093923.GD21151@willie-the-truck
>
> Overall, I'm not thrilled to bits by extending the atomics API with
> operations that cannot be implemented efficiently on any (?) architectures
> and are only used by the qspinlock slowpath on machines with more than 16K
> CPUs.

Wouldn't this also help improve set_mask_bits()? That one at least has
a handful of users in the kernel.

       Arnd
