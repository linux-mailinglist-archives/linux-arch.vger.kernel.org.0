Return-Path: <linux-arch+bounces-221-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B6B7EB793
	for <lists+linux-arch@lfdr.de>; Tue, 14 Nov 2023 21:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154D51C20ACE
	for <lists+linux-arch@lfdr.de>; Tue, 14 Nov 2023 20:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D67C35F00;
	Tue, 14 Nov 2023 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HXbNj79h"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252D21CABB;
	Tue, 14 Nov 2023 20:14:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3694CD9;
	Tue, 14 Nov 2023 12:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5uS+7I/hdEi/j2d0v3U0nBW/3e8OdQbcjBLfaqo5fyE=; b=HXbNj79hUL/5Ub5itbEm9PybKB
	NCqN7/gz0LISFlHa5/xxpoB7CU0TLhU++Ja7zjWOUu2G/Q5QDEUDHO3lshLpJy0dmtsmf3YxNs2pF
	swsw9Pg9udmdl60h+A0dDCR0eOHWD0hgWsqvmLy/ez75SyMfZALCemr7C6blMD7pae14rso/vLK5j
	wzz3unbnayfDGsKpEP8Nc8nkCarWpeY8qac5Oimq5G+0jrETK2P1BsyAqVhJID0j4gFVjixX5e4vV
	bOfmoueLJ04Q/LIiOojemprgSKSYxEsLpW2B2ofbl2hEdBrTdGLccG1q0Khc7925jo+4psSm6A/QB
	H9Bg9jRQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r2znO-002hgP-2v;
	Tue, 14 Nov 2023 20:14:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7D811300581; Tue, 14 Nov 2023 21:14:02 +0100 (CET)
Date: Tue, 14 Nov 2023 21:14:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Xi Ruoyao <xry111@xry111.site>, libc-alpha@sourceware.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: Several tst-robust* tests time out with recent Linux kernel
Message-ID: <20231114201402.GA25315@noisy.programming.kicks-ass.net>
References: <4bda9f2e06512e375e045f9e72edb205104af19c.camel@xry111.site>
 <d69d50445284a5e0d98a64862877c1e6ec22a9a8.camel@xry111.site>
 <20231114153100.GY8262@noisy.programming.kicks-ass.net>
 <20231114154017.GI4779@noisy.programming.kicks-ass.net>
 <87ttpowajb.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttpowajb.fsf@oldenburg.str.redhat.com>

On Tue, Nov 14, 2023 at 05:43:20PM +0100, Florian Weimer wrote:
> * Peter Zijlstra:
> 
> >> diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
> >> index b5379c0e6d6d..1a1f9301251f 100644
> >> --- a/kernel/futex/futex.h
> >> +++ b/kernel/futex/futex.h
> >> @@ -17,7 +17,7 @@
> >>   * restarts.
> >>   */
> >>  #ifdef CONFIG_MMU
> >> -# define FLAGS_SHARED		0x01
> >> +# define FLAGS_SHARED		0x10
> >>  #else
> >>  /*
> >>   * NOMMU does not have per process address space. Let the compiler optimize
> >
> > Just the above seems sufficient.
> 
> There are a few futex_wake calls which hard-code the flags argument as
> 1:
> 
> kernel/futex/core.c=637=static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
> --
> kernel/futex/core.c-686-         * this.
> kernel/futex/core.c-687-         */
> kernel/futex/core.c-688-        owner = uval & FUTEX_TID_MASK;
> kernel/futex/core.c-689-
> kernel/futex/core.c-690-        if (pending_op && !pi && !owner) {
> kernel/futex/core.c:691:                futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
> kernel/futex/core.c-692-                return 0;
> kernel/futex/core.c-693-        }
> kernel/futex/core.c-694-
> kernel/futex/core.c-695-        if (owner != task_pid_vnr(curr))
> kernel/futex/core.c-696-                return 0;
> --
> kernel/futex/core.c-739-        /*
> kernel/futex/core.c-740-         * Wake robust non-PI futexes here. The wakeup of
> kernel/futex/core.c-741-         * PI futexes happens in exit_pi_state():
> kernel/futex/core.c-742-         */
> kernel/futex/core.c-743-        if (!pi && (uval & FUTEX_WAITERS))
> kernel/futex/core.c:744:                futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
> kernel/futex/core.c-745-
> kernel/futex/core.c-746-        return 0;
> kernel/futex/core.c-747-}
> kernel/futex/core.c-748-
> kernel/futex/core.c-749-/*

Urgh, thanks!

Confirmed, the below cures things. Although I should probably make that
FLAGS_SIZE_32 | FLAGS_SHARED against Linus' tree.

Let me go do a proper patch.

---
 kernel/futex/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index d1d7b3c175a4..e7793f0d5757 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -687,7 +687,7 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 	owner = uval & FUTEX_TID_MASK;
 
 	if (pending_op && !pi && !owner) {
-		futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
+		futex_wake(uaddr, FLAGS_SHARED, 1, FUTEX_BITSET_MATCH_ANY);
 		return 0;
 	}
 
@@ -740,7 +740,7 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 	 * PI futexes happens in exit_pi_state():
 	 */
 	if (!pi && (uval & FUTEX_WAITERS))
-		futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
+		futex_wake(uaddr, FLAGS_SHARED, 1, FUTEX_BITSET_MATCH_ANY);
 
 	return 0;
 }

