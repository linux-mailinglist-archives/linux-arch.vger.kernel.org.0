Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E332D1CB9BC
	for <lists+linux-arch@lfdr.de>; Fri,  8 May 2020 23:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEHVYj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 May 2020 17:24:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:33532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgEHVYh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 May 2020 17:24:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B95B6AE2A;
        Fri,  8 May 2020 21:24:37 +0000 (UTC)
Date:   Fri, 8 May 2020 23:24:32 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 6/7] mm: Remove vmalloc_sync_(un)mappings()
Message-ID: <20200508212432.GS8135@suse.de>
References: <20200508144043.13893-1-joro@8bytes.org>
 <20200508144043.13893-7-joro@8bytes.org>
 <20200508145822.07fcc32b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508145822.07fcc32b@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 08, 2020 at 02:58:22PM -0400, Steven Rostedt wrote:
> You'll need to fold this into this patch, as my patch has already hit
> Linus's tree.

Yeah, have it on my todo-list already when I rebase this.

> But I applied your whole series and I'm not able to reproduce the bug.
> 
> Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks a lot for testing!


	Joerg

