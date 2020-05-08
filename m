Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AEA1CB7D4
	for <lists+linux-arch@lfdr.de>; Fri,  8 May 2020 20:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgEHS61 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 May 2020 14:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHS61 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 May 2020 14:58:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8924D2083B;
        Fri,  8 May 2020 18:58:25 +0000 (UTC)
Date:   Fri, 8 May 2020 14:58:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 6/7] mm: Remove vmalloc_sync_(un)mappings()
Message-ID: <20200508145822.07fcc32b@gandalf.local.home>
In-Reply-To: <20200508144043.13893-7-joro@8bytes.org>
References: <20200508144043.13893-1-joro@8bytes.org>
        <20200508144043.13893-7-joro@8bytes.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri,  8 May 2020 16:40:42 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> From: Joerg Roedel <jroedel@suse.de>
> 
> These functions are not needed anymore because the vmalloc and ioremap
> mappings are now synchronized when they are created or teared down.
> 
> Remove all callers and function definitions.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
>

You'll need to fold this into this patch, as my patch has already hit
Linus's tree.

But I applied your whole series and I'm not able to reproduce the bug.

Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 29615f15a820..1424a89193c6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8526,19 +8526,6 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 	 */
 	allocate_snapshot = false;
 #endif
-
-	/*
-	 * Because of some magic with the way alloc_percpu() works on
-	 * x86_64, we need to synchronize the pgd of all the tables,
-	 * otherwise the trace events that happen in x86_64 page fault
-	 * handlers can't cope with accessing the chance that a
-	 * alloc_percpu()'d memory might be touched in the page fault trace
-	 * event. Oh, and we need to audit all other alloc_percpu() and vmalloc()
-	 * calls in tracing, because something might get triggered within a
-	 * page fault trace event!
-	 */
-	vmalloc_sync_mappings();
-
 	return 0;
 }
 
