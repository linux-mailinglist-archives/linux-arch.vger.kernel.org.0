Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FAA1F0414
	for <lists+linux-arch@lfdr.de>; Sat,  6 Jun 2020 03:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgFFBBT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Jun 2020 21:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgFFBBS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Jun 2020 21:01:18 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA287206A2;
        Sat,  6 Jun 2020 01:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591405277;
        bh=Gyeok/N2XeIirYf4qpDfR5nkHdIHhB9yRdTBcnOBxlU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y5y+gFTH6+kErKJnfOvjHoR2SLZ8cPf/bNZXOh70Hzyk/fNOWUS9ByZnIL+ZJbAqJ
         BcZ53nV5l0yY0/DAeSCmQWk2k0PBd5PLgjQbkszO7mmt+k8rfNas4U4lgT8o/e+zd9
         yR142U/GuFaL+gPPih6t4GsptIpLGBI9xlHXW11c=
Date:   Fri, 5 Jun 2020 18:01:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 1/7] mm: Add functions to track page directory
 modifications
Message-Id: <20200605180116.196116ea218df55f3252af57@linux-foundation.org>
In-Reply-To: <20200605114654.GD31371@gaia>
References: <20200515140023.25469-1-joro@8bytes.org>
        <20200515140023.25469-2-joro@8bytes.org>
        <20200605100813.GA31371@gaia>
        <20200605114654.GD31371@gaia>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 5 Jun 2020 12:46:55 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Fri, Jun 05, 2020 at 11:08:13AM +0100, Catalin Marinas wrote:
> > This patch causes a kernel panic on arm64 (and possibly powerpc, I
> > haven't tried). arm64 still uses the 5level-fixup.h and pud_alloc()
> > checks for the empty p4d with pgd_none() instead of p4d_none().
> 
> Ah, should have checked the list first
> (https://lore.kernel.org/linux-mm/20200604074446.23944-1-joro@8bytes.org/).
> 

Sorry about that.

Can you confirm that the merge of Mike's 5level_hack zappage has fixed
the arm64 wontboot?

