Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EE0426413
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 07:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbhJHFcj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 01:32:39 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:34983 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJHFci (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Oct 2021 01:32:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HQcGk6lRDz4xbZ;
        Fri,  8 Oct 2021 16:30:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1633671043;
        bh=sIw4jn1DGB6yOiTwilUDw2qffK2Q341CIcdtPOKj5Po=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FKp5UO7ZC6skkgQ2Tt6jAF94wz89h0MsDiMUGuhEywIvFzcQugqo7vWSKIFxvEXSG
         Jsfao0sP2XO5Qq+98Nx1fiy+XthiDkIYz6vxz+EQlTBxWptCmCdbnIkjE37llYLCu7
         wktpY9nJkK7VjYa8e4lSgDoMocZwlcvZ6UoFNR95d0+NB0ETT6fYZwKqNxkZOc5pqp
         cpOIgk6ZJDqUDsMskYZodOpJPtAuBs4Wz7+loNH1kqKUQW01xe9oPGOYUs5IQwWXzj
         UvYRymTFi3shsVMQlQ4dh1BSQwJTC7N6Fr6JdYi7bGSE2Et3NFSukg0NkMieThWql5
         kVyKdmvbT/wJw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, Alan Stern <stern@rowland.harvard.edu>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model: Provide extra ordering for
 unlock+lock pair on the same CPU
In-Reply-To: <YVZiGdWXfbsHs2xa@boqun-archlinux>
References: <20210930130823.2103688-1-boqun.feng@gmail.com>
 <YVZiGdWXfbsHs2xa@boqun-archlinux>
Date:   Fri, 08 Oct 2021 16:30:37 +1100
Message-ID: <878rz4nkw2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Boqun Feng <boqun.feng@gmail.com> writes:
> (Add linux-arch in Cc list)
>
> Architecture maintainers, this patch is about strengthening our memory
> model a little bit, your inputs (confirmation, ack/nack, etc.) are
> appreciated.

Hi Boqun,

I don't feel like I'm really qualified to give an ack here, you and the
other memory model folk know this stuff much better than me.

But I have reviewed it and it matches my understanding of how our
barriers work, so it looks OK to me.

Reviewed-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
