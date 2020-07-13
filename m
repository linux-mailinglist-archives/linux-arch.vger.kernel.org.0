Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF94D21D5E6
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 14:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgGMM0l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 08:26:41 -0400
Received: from foss.arm.com ([217.140.110.172]:59566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729259AbgGMM0l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jul 2020 08:26:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78D3930E;
        Mon, 13 Jul 2020 05:26:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F05E3F887;
        Mon, 13 Jul 2020 05:26:38 -0700 (PDT)
Date:   Mon, 13 Jul 2020 13:26:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] uaccess: add force_uaccess_{begin,end} helpers
Message-ID: <20200713122636.GB51007@lakrids.cambridge.arm.com>
References: <20200710135706.537715-1-hch@lst.de>
 <20200710135706.537715-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710135706.537715-6-hch@lst.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 10, 2020 at 03:57:05PM +0200, Christoph Hellwig wrote:
> Add helpers to wraper the get_fs/set_fs magic for undoing any damange
> done by set_fs(KERNEL_DS).  There is no real functional benefit, but this
> documents the intent of these calls better, and will allow stubbing the
> functions out easily for kernels builds that do not allow address space
> overrides in the future.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/kernel/sdei.c         |  2 +-
>  arch/m68k/include/asm/tlbflush.h | 12 ++++++------
>  arch/mips/kernel/unaligned.c     | 27 +++++++++++++--------------
>  arch/nds32/mm/alignment.c        |  7 +++----
>  arch/sh/kernel/traps_32.c        | 18 ++++++++----------
>  drivers/firmware/arm_sdei.c      |  5 ++---
>  include/linux/uaccess.h          | 18 ++++++++++++++++++
>  kernel/events/callchain.c        |  5 ++---
>  kernel/events/core.c             |  5 ++---
>  kernel/kthread.c                 |  5 ++---
>  kernel/stacktrace.c              |  5 ++---
>  mm/maccess.c                     | 22 ++++++++++------------
>  12 files changed, 69 insertions(+), 62 deletions(-)

The perf core and arm64/sdei bits look sound. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
