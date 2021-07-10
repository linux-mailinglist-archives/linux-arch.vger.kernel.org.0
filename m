Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9235E3C36F0
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jul 2021 23:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhGJVd4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Jul 2021 17:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhGJVd4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 10 Jul 2021 17:33:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 318D661353;
        Sat, 10 Jul 2021 21:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1625952670;
        bh=BhBrfVjiyW6tp+kvAEQqA+E6E0jDxEmrABGM+LD2iDE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YumewwPz/9BP0RTGzpUxeqL4PJJ4OfJkwnfq1BY5RJzjIZuRPzCzTJQlke7FWeRex
         l+9/3WdNu6ozxDiKthf+6mHMStX4b4pkvnMW+/rCy5B1+t+v2Mx78IXMh809uXo2zb
         CslWQUnTE4guJikE8f/uBeNbhimRkTvWYDzXUYmY=
Date:   Sat, 10 Jul 2021 14:31:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Nick Kossifidis <mick@ics.forth.gr>,
        Guo Ren <guoren@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Drew Fustini <drew@beagleboard.org>,
        linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/3] lib/string: optimized mem* functions
Message-Id: <20210710143109.fd5062902ef4d5d59e83f5bb@linux-foundation.org>
In-Reply-To: <20210702123153.14093-1-mcroce@linux.microsoft.com>
References: <20210702123153.14093-1-mcroce@linux.microsoft.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri,  2 Jul 2021 14:31:50 +0200 Matteo Croce <mcroce@linux.microsoft.com> wrote:

> From: Matteo Croce <mcroce@microsoft.com>
> 
> Rewrite the generic mem{cpy,move,set} so that memory is accessed with
> the widest size possible, but without doing unaligned accesses.
> 
> This was originally posted as C string functions for RISC-V[1], but as
> there was no specific RISC-V code, it was proposed for the generic
> lib/string.c implementation.
> 
> Tested on RISC-V and on x86_64 by undefining __HAVE_ARCH_MEM{CPY,SET,MOVE}
> and HAVE_EFFICIENT_UNALIGNED_ACCESS.
> 
> These are the performances of memcpy() and memset() of a RISC-V machine
> on a 32 mbyte buffer:
> 
> memcpy:
> original aligned:	 75 Mb/s
> original unaligned:	 75 Mb/s
> new aligned:		114 Mb/s
> new unaligned:		107 Mb/s
> 
> memset:
> original aligned:	140 Mb/s
> original unaligned:	140 Mb/s
> new aligned:		241 Mb/s
> new unaligned:		241 Mb/s

Did you record the x86_64 performance?


Which other architectures are affected by this change?
