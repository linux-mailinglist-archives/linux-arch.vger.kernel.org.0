Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA733DA338
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 14:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbhG2Mfb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 08:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234459AbhG2Mfb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jul 2021 08:35:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15F6660F21;
        Thu, 29 Jul 2021 12:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627562128;
        bh=3KRHUqD5tTAbGUtRwXGy3nWnwX1DW8ZKVlajObp0w/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYcP23TLOiS1pwzjzKq+/uFaLnhPxGyL+QBUpFVF3q6V+YkBSf9FbM6sB5xwQkliL
         AbquoFA8FSvFETbO6xGbIxc1jU4P/dVR5IMxAVqh/THdKq5mddhEC1C21GxrkXarrm
         TSj/z1aQJTKZmDcx0wDl0saz4BgdjDzDck4FwRzBCmkdG8478B/q8kdx0zH89IiOb6
         ZtFrK1SkGjQEv/CqKPedKbqjLemv8HXEdiS1esZf6dnEf055UyX733v1rmUfHrc1fJ
         LDq1yZgZqE65eF855iyn4TuPKhzRy/VUpwZE5IxwoEN/4hA/Wbr6IVTg5hm3+mXAyF
         YzusFlKb1jilw==
Date:   Thu, 29 Jul 2021 13:35:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rui Wang <wangrui@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rui Wang <r@hev.cc>, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        kernel test robot <lkp@intel.com>
Subject: Re: [RFC PATCH v3] locking/atomic: Implement
 atomic{,64,_long}_{fetch_,}{andnot_or}{,_relaxed,_acquire,_release}()
Message-ID: <20210729123522.GB21766@willie-the-truck>
References: <20210729093003.146166-1-wangrui@loongson.cn>
 <20210729095551.GE21151@willie-the-truck>
 <CAK8P3a3ru0VSYLohoFOd=P=Fjb8BS=1qpMGSf4jdxF4oxmH-ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3ru0VSYLohoFOd=P=Fjb8BS=1qpMGSf4jdxF4oxmH-ag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 29, 2021 at 01:43:41PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 29, 2021 at 11:56 AM Will Deacon <will@kernel.org> wrote:
> > On Thu, Jul 29, 2021 at 05:30:03PM +0800, Rui Wang wrote:
> > > This patch introduce a new atomic primitive andnot_or:
> >
> > Please see my other comments on the other patches you posted:
> >
> > https://lore.kernel.org/r/20210729093923.GD21151@willie-the-truck
> >
> > Overall, I'm not thrilled to bits by extending the atomics API with
> > operations that cannot be implemented efficiently on any (?) architectures
> > and are only used by the qspinlock slowpath on machines with more than 16K
> > CPUs.
> 
> Wouldn't this also help improve set_mask_bits()? That one at least has
> a handful of users in the kernel.

For pure LL/SC architectures, yes, but I don't think it helps anybody else.

Afaict, an architecture can already override set_mask_bits, so why do we
need to add this primitive to the atomic API?

Will
