Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E563B167F27
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBUNuk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:50:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45540 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgBUNuk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=SKWUMBjFXunYZktv3+PwsTSKyH9hFj1H3mSFlJw71rk=; b=O/PpAFrMCSLa6/ZWKy82GufWPu
        yg2jaXTm6OaoPCGOw8Pv9uwwWGnn0YapFAWHIPisIplZZaKEPIVe3XuIekUKy9thKTI4mSFt80xfT
        LdsxNORHiMMOZDNP7l+fGoziLk5kRJZBxXJR/LPLpQiw5u5ok4BF8htn7gKQSJON/2sMV/H7coN6K
        6uRP+0V82wdNmmyQL8NFrEXmlbFARdfU6G7KT/QMpanZns1UUpwVkHLChXdoxAJlyoCR+fTo+zvW+
        avDX4fijN0KzQvq7qw/Wtp5EIa3afNRb51Twger/reBbBvkhGv8pxZyGTQ4pre9BuM8uBX8WFmw+x
        SNWSEHaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gw-0006VH-IG; Fri, 21 Feb 2020 13:50:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8906930783F;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3B01829D740B7; Fri, 21 Feb 2020 14:50:01 +0100 (CET)
Message-Id: <20200221134216.690116768@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 24/27] x86/int3: Avoid atomic instrumentation
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use arch_atomic_*() and READ_ONCE_NOCHECK() to ensure nothing untoward
creeps in and ruins things.

That is; this is the INT3 text poke handler, strictly limit the code
that runs in it, lest we inadvertenly hit yet another INT3.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -960,9 +960,9 @@ static struct bp_patching_desc *bp_desc;
 static __always_inline
 struct bp_patching_desc *try_get_desc(struct bp_patching_desc **descp)
 {
-	struct bp_patching_desc *desc = READ_ONCE(*descp); /* rcu_dereference */
+	struct bp_patching_desc *desc = READ_ONCE_NOCHECK(*descp); /* rcu_dereference */
 
-	if (!desc || !atomic_inc_not_zero(&desc->refs))
+	if (!desc || !arch_atomic_inc_not_zero(&desc->refs))
 		return NULL;
 
 	return desc;
@@ -971,7 +971,7 @@ struct bp_patching_desc *try_get_desc(st
 static __always_inline void put_desc(struct bp_patching_desc *desc)
 {
 	smp_mb__before_atomic();
-	atomic_dec(&desc->refs);
+	arch_atomic_dec(&desc->refs);
 }
 
 static __always_inline void *text_poke_addr(struct text_poke_loc *tp)


