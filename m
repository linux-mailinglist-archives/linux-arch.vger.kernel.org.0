Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4C51FE77B
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jun 2020 04:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgFRClO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jun 2020 22:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgFRBM2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jun 2020 21:12:28 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43B76214DB;
        Thu, 18 Jun 2020 01:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442747;
        bh=mGN9DdKaAmVEzpdoVTQ/AB/ixfkCHEhhjiWmQ+Z00rI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xzsVrD7akKySIWhvQD55PtUN2F05SgqEIQ0FBQXyrmbiBXLTK2KyYj2xCXvEORWGJ
         zHQBhVJ/v3Ymfwxra4LefSoKABPvCGyUpIX2mfrGWICi+aprnskbSySUBLb4WoAVep
         rvWsIseXqFcwnil5YImRepnntj/Wze4KPlhO8R3c=
Date:   Wed, 17 Jun 2020 18:12:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     peterz@infradead.org, jroedel@suse.de,
        Andy Lutomirski <luto@kernel.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        manvanth@linux.vnet.ibm.com, linux-next@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, hch@lst.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Move p?d_alloc_track to separate header file
Message-Id: <20200617181226.ab213ea1531b5dd6eca1b0b6@linux-foundation.org>
In-Reply-To: <20200609120533.25867-1-joro@8bytes.org>
References: <20200609120533.25867-1-joro@8bytes.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue,  9 Jun 2020 14:05:33 +0200 Joerg Roedel <joro@8bytes.org> wrote:

> From: Joerg Roedel <jroedel@suse.de>
> 
> The functions are only used in two source files, so there is no need
> for them to be in the global <linux/mm.h> header. Move them to the new
> <linux/pgalloc-track.h> header and include it only where needed.
> 
> ...
>
> new file mode 100644
> index 000000000000..1dcc865029a2
> --- /dev/null
> +++ b/include/linux/pgalloc-track.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PGALLLC_TRACK_H
> +#define _LINUX_PGALLLC_TRACK_H

hm, no #includes.  I guess this is OK, given the limited use.

But it does make one wonder whether ioremap.c should be moved from lib/
to mm/ and this file should be moved from include/linux/ to mm/.

Oh well.
