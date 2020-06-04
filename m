Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AE51EEC1E
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jun 2020 22:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgFDUgY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Jun 2020 16:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbgFDUgY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Jun 2020 16:36:24 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6040206E6;
        Thu,  4 Jun 2020 20:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591302983;
        bh=6tdvI6hVT12tR559Y0x/YhFiPVzayDyW2O1N/hc9g6c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qq+Vitsm0LE8dgUTqTQ0PJt10JogRLNno17Te9gJX7oxFW7ATDBP35tpCOhVoRSDf
         ZLU6bXMm6yBmbq5o/AWzp33kWB8jss/xeVh6VQgYho6GvCdUNO06ShJ+VY6nDm9gw3
         UwiCaH4RqhPdb2XgCFpWNw4rgGS2KH5U7jjAZFbI=
Date:   Thu, 4 Jun 2020 13:36:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, peterz@infradead.org,
        jroedel@suse.de, Andy Lutomirski <luto@kernel.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        manvanth@linux.vnet.ibm.com, linux-next@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linuxppc-dev@lists.ozlabs.org, hch@lst.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Fix pud_alloc_track()
Message-Id: <20200604133622.c23b365066af0b14a9f04961@linux-foundation.org>
In-Reply-To: <20200604164814.GA7600@kernel.org>
References: <20200604074446.23944-1-joro@8bytes.org>
        <20200604164814.GA7600@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 4 Jun 2020 19:48:14 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> On Thu, Jun 04, 2020 at 09:44:46AM +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > The pud_alloc_track() needs to do different checks based on whether
> > __ARCH_HAS_5LEVEL_HACK is defined, like it already does in
> > pud_alloc(). Otherwise it causes boot failures on PowerPC.
> > 
> > Provide the correct implementations for both possible settings of
> > __ARCH_HAS_5LEVEL_HACK to fix the boot problems.
> 
> There is a patch in mmotm [1] that completely removes
> __ARCH_HAS_5LEVEL_HACK which is a part of the series [2] that updates
> p4d folding accross architectures. This should fix boot on PowerPC and
> the addition of pXd_alloc_track() for __ARCH_HAS_5LEVEL_HACK wouldn't be
> necessary.
> 
> 
> [1] https://github.com/hnaz/linux-mm/commit/cfae68792af3731ac902ea6ba5ed8df5a0f6bd2f
> [2] https://lore.kernel.org/kvmarm/20200414153455.21744-1-rppt@kernel.org/

That patchset is stacked up behind many other patches, including all
the powerpc stuff in linux-next :(

As it's a big bug fix, I'll pull those patches forward, hopefully send it
all Linuswards later today...
