Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E601EF6AE
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jun 2020 13:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgFELrA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Jun 2020 07:47:00 -0400
Received: from foss.arm.com ([217.140.110.172]:54068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgFELrA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Jun 2020 07:47:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2D672B;
        Fri,  5 Jun 2020 04:46:59 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FB4D3F305;
        Fri,  5 Jun 2020 04:46:57 -0700 (PDT)
Date:   Fri, 5 Jun 2020 12:46:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 1/7] mm: Add functions to track page directory
 modifications
Message-ID: <20200605114654.GD31371@gaia>
References: <20200515140023.25469-1-joro@8bytes.org>
 <20200515140023.25469-2-joro@8bytes.org>
 <20200605100813.GA31371@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605100813.GA31371@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 05, 2020 at 11:08:13AM +0100, Catalin Marinas wrote:
> This patch causes a kernel panic on arm64 (and possibly powerpc, I
> haven't tried). arm64 still uses the 5level-fixup.h and pud_alloc()
> checks for the empty p4d with pgd_none() instead of p4d_none().

Ah, should have checked the list first
(https://lore.kernel.org/linux-mm/20200604074446.23944-1-joro@8bytes.org/).

Please ignore my patch then.

-- 
Catalin
