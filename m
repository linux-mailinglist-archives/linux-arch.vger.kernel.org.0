Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA424395550
	for <lists+linux-arch@lfdr.de>; Mon, 31 May 2021 08:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEaGTZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 May 2021 02:19:25 -0400
Received: from verein.lst.de ([213.95.11.211]:48223 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhEaGTY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 May 2021 02:19:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9EC5667373; Mon, 31 May 2021 08:17:42 +0200 (CEST)
Date:   Mon, 31 May 2021 08:17:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     guoren@kernel.org
Cc:     anup.patel@wdc.com, palmerdabbelt@google.com, arnd@arndb.de,
        hch@lst.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V5 2/3] riscv: Add ASID-based tlbflushing methods
Message-ID: <20210531061742.GB824@lst.de>
References: <1622393366-46079-1-git-send-email-guoren@kernel.org> <1622393366-46079-3-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622393366-46079-3-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, May 30, 2021 at 04:49:25PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Implement optimized version of the tlb flushing routines for systems
> using ASIDs. These are behind the use_asid_allocator static branch to
> not affect existing systems not using ASIDs.

I still think the code duplication and exposing of new code in a global
header here is a bad idea and would suggest the version I sent instead.
