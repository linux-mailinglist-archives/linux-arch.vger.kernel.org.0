Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D7C949D8
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfHSQ25 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 12:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbfHSQ25 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Aug 2019 12:28:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C42A22CE3;
        Mon, 19 Aug 2019 16:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566232136;
        bh=eGKGObceNP/kBZluizhrqLdVLBQt/wNSMAHMZmxEDOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwzNiAfhnewbiG7/94zFyMyWxOYy2jaAbbx/TiuA7BkmAjNiX30pWMXGbanURYxcl
         WW3UE+Hgcwaqdc+jhX57DWGiL3zbXF6acU7H8oYCHdK71zo4ewOodc+BlJ8ZyWYmnB
         a4pYRaJb4GsCKA3HbUTeAqCAYOqpXLBvoRxUl2bU=
Date:   Mon, 19 Aug 2019 17:28:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        akpm@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v8 1/5] mm: untag user pointers in mmap/munmap/mremap/brk
Message-ID: <20190819162851.tncj4wpwf625ofg6@willie-the-truck>
References: <20190815154403.16473-1-catalin.marinas@arm.com>
 <20190815154403.16473-2-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815154403.16473-2-catalin.marinas@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 15, 2019 at 04:43:59PM +0100, Catalin Marinas wrote:
> There isn't a good reason to differentiate between the user address
> space layout modification syscalls and the other memory
> permission/attributes ones (e.g. mprotect, madvise) w.r.t. the tagged
> address ABI. Untag the user addresses on entry to these functions.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  mm/mmap.c   | 5 +++++
>  mm/mremap.c | 6 +-----
>  2 files changed, 6 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Andrew -- please can you pick this patch up? I'll take the rest of the
series via arm64 once we've finished discussing the wording details.

Thanks,

Will
