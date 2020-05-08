Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F4D1CB7F9
	for <lists+linux-arch@lfdr.de>; Fri,  8 May 2020 21:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEHTLP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 May 2020 15:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEHTLO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 May 2020 15:11:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C5AC061A0C;
        Fri,  8 May 2020 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tUWbBKI5h7qcIWqn7V5B9OOroJpHaOkMQ99gt8+paWg=; b=ZFIdwDhlPQCBP+06Xc6FGc6o8R
        j4DJhPCH38rngf1Il0cTp/VUfH9Np0uLsnYfo0MGHwHFjmQyAvch8XUco4wEhUDgfDrulWKfm7+Y8
        xOyo+9JvgR/pioiJwmMKz6uTB92VX0IPpurv9wUvNpcHWJ0YXO9AOqYdWkGgm0G/K8QQvqdigrrSX
        c6eQ0hynD5RgDcm832/SyKns3BR3ugOKv9sbjDy13tg7Vr/hc8rAd8LrsD5WWUIEPsUhOXmLwZuAL
        vfoywGZ8lH8pQY55bkkXAQI3eCvfk5jVYrJ/CbTotVTJtQvLk9bb9NhVMlWBrpLuonmfu3eZEk0zP
        TI82M9Ng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX8OZ-0001Qe-1C; Fri, 08 May 2020 19:10:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7FB2F301DFC;
        Fri,  8 May 2020 21:10:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AECD203CB697; Fri,  8 May 2020 21:10:48 +0200 (CEST)
Date:   Fri, 8 May 2020 21:10:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/7] mm/vmalloc: Track which page-table levels were
 modified
Message-ID: <20200508191048.GA2957@hirez.programming.kicks-ass.net>
References: <20200508144043.13893-1-joro@8bytes.org>
 <20200508144043.13893-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508144043.13893-3-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 08, 2020 at 04:40:38PM +0200, Joerg Roedel wrote:

> +/*
> + * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
> + * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
> + * needs to be called.
> + */
> +#ifndef ARCH_PAGE_TABLE_SYNC_MASK
> +#define ARCH_PAGE_TABLE_SYNC_MASK 0
> +#endif
> +
> +void arch_sync_kernel_mappings(unsigned long start, unsigned long end);


> +	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> +		arch_sync_kernel_mappings(start, end);

So you're relying on the compiler DCE'ing the call in the 'normal' case.

Works I suppose, but I went over the patches twice to look for a default
implementation of it before I figured that out ...
