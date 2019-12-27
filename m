Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B2C12B429
	for <lists+linux-arch@lfdr.de>; Fri, 27 Dec 2019 12:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfL0LHn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Dec 2019 06:07:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfL0LHn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Dec 2019 06:07:43 -0500
Received: from rapoport-lnx (unknown [77.127.33.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE6B0208C4;
        Fri, 27 Dec 2019 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577444862;
        bh=q3rNVUgSWezoYAANYKGsbrCWgwXuaqppTl7vYxs9iNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lN3X80yFRbeuFoQmfp/quJMjc6g1P35Nd3ItKRERu2SWl/hRsqZmgVkvfHE7Tk67z
         APClLY9JxqmZg+AXtrjLysNdRFEketcEQbKYoo7+SocC8BQY6/X1O24poFBF0OTNWI
         fxV38Crf4Uw13HwjHkOakhB1dKlrCirZsH4KLOLM=
Date:   Fri, 27 Dec 2019 13:07:37 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 0/2] fix recent nds32 build breakage
Message-ID: <20191227110736.GA30363@rapoport-lnx>
References: <20191223110004.2157-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223110004.2157-1-rppt@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd,

Can you please take these via asm-generic tree?

On Mon, Dec 23, 2019 at 01:00:02PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> The kbuild robot reported build breakage of nds32 architecture [1] that
> happens with CONFIG_CPU_CACHE_ALIASING=n and CONFIG_HUGHMEM=y.
> 
> There are two issues: one with a missing macro during conversion of page
> folding and another one is a conflict between cacheflush.h definitions in
> arch/nds32 and asm-generic.
> 
> [1] https://lore.kernel.org/lkml/201912212139.yptX8CsV%25lkp@intel.com/
> 
> Mike Rapoport (2):
>   asm-generic/nds32: don't redefine cacheflush primitives
>   nds32: fix build failure caused by page table folding updates
> 
>  arch/nds32/include/asm/cacheflush.h | 11 ++++++----
>  arch/nds32/include/asm/pgtable.h    |  2 +-
>  include/asm-generic/cacheflush.h    | 33 ++++++++++++++++++++++++++++-
>  3 files changed, 40 insertions(+), 6 deletions(-)
> 
> -- 
> 2.24.0
> 

-- 
Sincerely yours,
Mike.
