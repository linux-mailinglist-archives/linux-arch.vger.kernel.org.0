Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D7B5B9E6F
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiIOPL6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiIOPKL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:10:11 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F1F9E0F5
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:06:24 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id i17-20020a05640242d100b0044f18a5379aso13463781edc.21
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=y7GARGHGPpfPMqaRIp9ae7D7QgvYSCiDFPeV4nzQ3Rk=;
        b=Ebn9L6x3k72Uf16Z2sPPbKumL6GMhSFgPt5NQNEYRWzTnLrilf1HFYWiSYnGpWzKmW
         FEA3UcFlSfNBEEl2K81EZ6eD7aiI4y5Lge5FU9eykMyCjFPvzA0OERI5NU1y7iIqzH4v
         c4bqIf2YXdWDqpJ7Z98p9HtPqrsdglQg7fUxhuQ3RQxCmBMtL3Ay3m/RSRRMUnT3krI/
         r/DchyRFkiNefRiT2e63g4k5RSo2Hy1Ol6ONeQh8mlWGT0TsG9D5zangksZzjs93TeC9
         m0QqPsGp0C4MAjpxPDWCraRdWM3NGQnNaRKZeuadbrgwNxMDa2D0sDAXU9zdGMOwMd5p
         3N+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=y7GARGHGPpfPMqaRIp9ae7D7QgvYSCiDFPeV4nzQ3Rk=;
        b=S8q5bRKqfsf7zwHDNE1XxOUXw0hHK6hx0rbLikWDoth88wvoF/cjAoakWH5Z2fvAzF
         FSEapolV9VxvRwNgVRGWJXNVVZfCMoQlRVDB00Tk9WFGSKGohKg7da8e8bpwZ48raHGB
         WehmvP0ni7YGudWj0WCzHgzzy+ROj8pjEeabe4DadHq8csVVo0Q+3QmFFo6DLqQHwbnf
         VYxNHJjYboDu1KiOOickVAUxV9RZpgSBSyFTrpZLF4R5+/texoL5y+YPZJHlYr6DAquS
         u3JKveal4VVTzXvoABnoibEhE5S2RT5BFigJ/GNW1nZec5RVPX2p72ySAzH7UhMokp4m
         7CjQ==
X-Gm-Message-State: ACrzQf3GKTLMwHjCN6tnn2PgrH66z+qLDc6NEYH20hFOifwRxpYooUhf
        sBAtbRCzoIXa6TfqGJuCzpBqd+mnkkM=
X-Google-Smtp-Source: AMsMyM7TbJseKEuaq1ed2Qlb9dHi6cPdzHSmcROd4iSHRPNQzeNqnCIZX7H+dXJZfaek8LGd/2MCvKxWIXM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a17:907:75ee:b0:77b:c559:2bcc with SMTP id
 jz14-20020a17090775ee00b0077bc5592bccmr266153ejc.537.1663254382083; Thu, 15
 Sep 2022 08:06:22 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:04:12 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-39-glider@google.com>
Subject: [PATCH v7 38/43] x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

dentry_string_cmp() calls read_word_at_a_time(), which might read
uninitialized bytes to optimize string comparisons.
Disabling CONFIG_DCACHE_WORD_ACCESS should prohibit this optimization,
as well as (probably) similar ones.

Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I4c0073224ac2897cafb8c037362c49dda9cfa133
---
 arch/x86/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 33f4d4baba079..697da8dae1418 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -128,7 +128,9 @@ config X86
 	select CLKEVT_I8253
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
-	select DCACHE_WORD_ACCESS
+	# Word-size accesses may read uninitialized data past the trailing \0
+	# in strings and cause false KMSAN reports.
+	select DCACHE_WORD_ACCESS		if !KMSAN
 	select DYNAMIC_SIGFRAME
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
-- 
2.37.2.789.g6183377224-goog

