Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0D376A107
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 21:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGaTUg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 15:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGaTUf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 15:20:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE561713;
        Mon, 31 Jul 2023 12:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7kEonDGMduTbFsCil+eszqrNrb5nrnY+6n0LGU5HhHA=; b=Wz6DDGLEoUvHSzKosfdPLNuAx6
        pXzK5fDBMLzFxdrzFewsUb1Lr3/dW14cR14Wa3XBkxzL+dYZGrYJ7gWZhgWVr7Q5I5Tl6WWpv/w+7
        45Zrya0kQ+Bi7L5Pe2IpLcc6aUA+qJYMpb+nBBo/j+Sj2OS9zTqo3Jo2zk4AdNTiIBj//QH61/SvS
        7sNEHNYkvPMNtO67KQNvk54Nq9kcR140qlDdm1ebt67M/ZqM6voGTbaa61kZ9iE/MCYWR61O5smiT
        S0kZfVowlGQpc9n4WuK3UsLH7XkISpISXB5SUfVdmKjJmcKJRrguPeCEYo74GlgveOrKsdlTeUixB
        DQclJDog==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQYRB-003LT8-T5; Mon, 31 Jul 2023 19:20:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3951A3002CE;
        Mon, 31 Jul 2023 21:20:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07A8E203C783E; Mon, 31 Jul 2023 21:20:13 +0200 (CEST)
Date:   Mon, 31 Jul 2023 21:20:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 02/14] futex: Extend the FUTEX2 flags
Message-ID: <20230731192012.GA11704@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.819362688@infradead.org>
 <87edkonjrk.ffs@tglx>
 <87mszcm0zw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mszcm0zw.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 31, 2023 at 07:42:11PM +0200, Thomas Gleixner wrote:

> Aargh. This is really nasty to make FUTEX2_64 0x3 and abuse it to test
> the flags for validity. Intuitive and obvious is something else.

Like so then?

--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -57,6 +57,8 @@
 			/*	0x40 */
 #define FUTEX2_PRIVATE		FUTEX_PRIVATE_FLAG
 
+#define FUTEX2_SIZE_MASK	0x03
+
 /* do not use */
 #define FUTEX_32		FUTEX2_32 /* historical accident :-( */
 
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -183,7 +183,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
 	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 
-#define FUTEX2_MASK (FUTEX2_64 | FUTEX2_PRIVATE)
+#define FUTEX2_MASK (FUTEX2_SIZE_MASK | FUTEX2_PRIVATE)
 
 /**
  * futex_parse_waitv - Parse a waitv array from userspace
@@ -208,11 +208,11 @@ static int futex_parse_waitv(struct fute
 			return -EINVAL;
 
 		if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
-			if ((aux.flags & FUTEX2_64) == FUTEX2_64)
+			if ((aux.flags & FUTEX2_SIZE_MASK) == FUTEX2_64)
 				return -EINVAL;
 		}
 
-		if ((aux.flags & FUTEX2_64) != FUTEX2_32)
+		if ((aux.flags & FUTEX2_SIZE_MASK) != FUTEX2_32)
 			return -EINVAL;
 
 		futexv[i].w.flags = aux.flags;
