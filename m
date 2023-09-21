Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBAE7A9F69
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 22:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjIUUVq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 16:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjIUUVU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 16:21:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CD69038;
        Thu, 21 Sep 2023 10:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=yq6smcRh9Lt9PMXVlulhUee9kIX8B6TjEGtSPSAL3jI=; b=MFTg6cMl019oUQu6rDJgts+aeg
        6Z+T8mLRp+uO7oQYQZw8Sm7/bPEVJfCOG+aED2yludqPec99o8HNyZPS/UwxNUu5ybxaL1HEhSQAn
        dbGtduFHWOeo64tStINJ7gZdIll94CL1nBUWrJCIh7duiDqXpGEwJDGf9UmYQHjclLEG2htYks1j2
        k3TT1ZVJmPhNPbii9Vmr15VGN96F+S0BqQB8o5Be51SKNksVDbNp+cdAzrwSIkN9YnEHdQHtiZs0o
        FsdMmqM6DHVtTYVFoqyyPUjpMHPB4elIcHz6Lly3U5MtaUc3UieSMAgJP1uokBuXVd99H5hXDY8TC
        QnNwNEBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjHQJ-00FJvh-0q;
        Thu, 21 Sep 2023 11:00:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id E37B2300513; Thu, 21 Sep 2023 13:00:42 +0200 (CEST)
Message-Id: <20230921105247.828934099@noisy.programming.kicks-ass.net>
User-Agent: quilt/0.65
Date:   Thu, 21 Sep 2023 12:45:09 +0200
From:   peterz@infradead.org
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v3 04/15] futex: Validate futex value against futex size
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-futex2-enforce-bits.patch
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ensure the futex value fits in the given futex size. Since this adds a
constraint to an existing syscall, it might possibly change behaviour.

Currently the value would be truncated to a u32 and any high bits
would get silently lost.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex/futex.h    |   10 ++++++++++
 kernel/futex/syscalls.c |    3 +++
 2 files changed, 13 insertions(+)

Index: linux-2.6/kernel/futex/futex.h
===================================================================
--- linux-2.6.orig/kernel/futex/futex.h
+++ linux-2.6/kernel/futex/futex.h
@@ -85,6 +85,16 @@ static inline bool futex_flags_valid(uns
 	return true;
 }
 
+static inline bool futex_validate_input(unsigned int flags, u64 val)
+{
+	int bits = 8 * futex_size(flags);
+
+	if (bits < 64 && (val >> bits))
+		return false;
+
+	return true;
+}
+
 #ifdef CONFIG_FAIL_FUTEX
 extern bool should_fail_futex(bool fshared);
 #else
Index: linux-2.6/kernel/futex/syscalls.c
===================================================================
--- linux-2.6.orig/kernel/futex/syscalls.c
+++ linux-2.6/kernel/futex/syscalls.c
@@ -209,6 +209,9 @@ static int futex_parse_waitv(struct fute
 		if (!futex_flags_valid(flags))
 			return -EINVAL;
 
+		if (!futex_validate_input(flags, aux.val))
+			return -EINVAL;
+
 		futexv[i].w.flags = flags;
 		futexv[i].w.val = aux.val;
 		futexv[i].w.uaddr = aux.uaddr;


