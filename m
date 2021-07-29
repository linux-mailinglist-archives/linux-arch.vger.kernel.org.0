Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E13DA336
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 14:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhG2MfI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 08:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234459AbhG2MfH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jul 2021 08:35:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1021C60524;
        Thu, 29 Jul 2021 12:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627562104;
        bh=sRfRKZYPWQwBLW4Rc0HdvJ0nfqBQaHG2p4hcPRYVEpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r8Sx51IHcjfP3tVgBOhUAr86PlbvWHz6rBy931V4Tva6vdwL5acBLdXR27pmPMSue
         tFdp9CKkIqOHH0XVDNs6UuTT2LLFCur9Tf9g6FcJKwSaKrzdULbVbNQr4O9JOwFOQI
         oQSQHaOQCs47ojvGnGJ7J6h7CHh0bOXgq7YR135RSq0p31hozA61xPupflIMRkmWgJ
         t9OrK9r4LmDFP+6r7fqeT38CRYKZT6lYn6czPc9xwUTrVaFzdhcPHX6tiMoPz17vpd
         oJ4smWBgkfrmW1HA2+hu9qYdhKaU+lDLC1xUZSkKTXRxMOBVBji2p0E6K+aYw6ZWqB
         iZ68D8t1ol9QA==
Date:   Thu, 29 Jul 2021 13:34:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rui Wang <wangrui@loongson.cn>, Ingo Molnar <mingo@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Wang <r@hev.cc>, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        kernel test robot <lkp@intel.com>
Subject: Re: [RFC PATCH v3] locking/atomic: Implement
 atomic{,64,_long}_{fetch_,}{andnot_or}{,_relaxed,_acquire,_release}()
Message-ID: <20210729123458.GA21766@willie-the-truck>
References: <20210729093003.146166-1-wangrui@loongson.cn>
 <20210729095551.GE21151@willie-the-truck>
 <YQKNu3WeMA/eJrLj@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQKNu3WeMA/eJrLj@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 29, 2021 at 01:15:07PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 29, 2021 at 10:55:52AM +0100, Will Deacon wrote:
> 
> > Overall, I'm not thrilled to bits by extending the atomics API with
> > operations that cannot be implemented efficiently on any (?) architectures
> > and are only used by the qspinlock slowpath on machines with more than 16K
> > CPUs.
> 
> My rationale for proposing this primitive is similar to the existence of
> other composite atomic ops from the Misc (and refcount) class (as per
> atomic_t.txt). They're common/performance sensitive operations that, on
> LL/SC platforms, can be better implemented than a cmpxchg() loop.
> 
> Specifically here, it can be used to implement short xchg() in an
> architecturally neutral way, but more importantly it provides fwd
> progress on LL/SC, while most LL/SC based cmpxchg() implementations are
> arguably broken there.

Well, assuming the CPU provides forward progress for LL/SC which is _very_
rare (i.e. Power). If you implement LL/SC in your L1 it's really hard to
get forward progress guarantees once your micro-architecture starts being
aggressive about speculation.

For arm64, I would prefer the CAS loop to the LL/SC version, but we actually
have short xchg() so I would much prefer that people used that! So my worry
is that we start seeing users of this new thing crop up all over the place
and it's not at all obvious that it's much worse than xchg().

Will
