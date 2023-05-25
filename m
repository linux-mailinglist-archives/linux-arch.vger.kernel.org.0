Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D95C7118A7
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 23:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbjEYVBP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 17:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjEYVBI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 17:01:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B961B6;
        Thu, 25 May 2023 14:01:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53f448cde66so263a12.1;
        Thu, 25 May 2023 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685048461; x=1687640461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+zfwXmZs7on+rhgyTI9s9jH0CR5rkGZ9aJZCDn5M88=;
        b=mU7K5hQEZ44NsT0+5VXofyw6qEDSPgD8wBkX7n613X0GzbWLqpmZC3VJfMwNx6m/tq
         nnfiSAnDqXg2POPsu6CCB/gzZ0hd00mUuaPE+wCpcwaSz8z7oc89KKDtJz7qu8LL0mFn
         S+jgvx9ju/DapGofobgM+AK3Axd4+Sc4U5KjNwRTJHheCODSmqZjtYzqbwgiWlD2FgMF
         srcMN9K8JH7pV8rjvzbVKic2ZONIx6t1veprRCepvX3TDcKPRo9Y07bOKmCyV0LvyjJw
         gbGeTnFOlGb6asM++1XIHud54i9VTyzPItSSun7x2eo35b2AKXgtMS5KXFv8bAflCIg7
         ysIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685048461; x=1687640461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+zfwXmZs7on+rhgyTI9s9jH0CR5rkGZ9aJZCDn5M88=;
        b=Plew69F6gnqLSoJ/bbamJq5mgfBLeVEz9Rdy5MwzAohMxJ9piwR8FFzFcpyjGmW5Fp
         u9AtrakaxQq1r2CE/ghuzCMdlZWMsb6qsuKdZQcGyCjH6bEaQSCQjOcSi9SlZ0C3jQH4
         GxUSQD/quw7iE39aL8w4RV+Wpro6NUsq4B378ECBxsahe6IsldWaZdHuVKkzfiyoE9k+
         J8lLG2s09IzXJgHqHI5IJhvyRtIUdns80X2XsgH4LvbFICQ9/xPM5CjQtIS7JpwA7jfK
         P6yp6tDKGcme+UK+bmXQwwODiBhL9IcWhfUrOJ9s8cpKsmnqNAgRcqry3XxQhTSgg2mb
         7HsQ==
X-Gm-Message-State: AC+VfDxGyW/Ww9ig3e/9e5AF/wXqL8nUQW1SV6uuHeRoObIf1K+n/5GK
        KpsMqRxNS+jw/7zUVxADnK8=
X-Google-Smtp-Source: ACHHUZ7dglrnNdSeCZIQSBsgjYjSTe3LSjFgTqSJchshPoXy4Vr4Jx151LniJF1AA47jpF5mynMU7w==
X-Received: by 2002:a17:902:e810:b0:1ac:5c90:23e with SMTP id u16-20020a170902e81000b001ac5c90023emr71805plg.7.1685048460660;
        Thu, 25 May 2023 14:01:00 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001ae8587d60csm1807673plj.265.2023.05.25.14.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:01:00 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-um@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Borislav Petkov" <bp@alien8.de>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 3/3] lib: Allow traceing of usercopy, xarray, iov_iter, find_bit
Date:   Thu, 25 May 2023 14:00:40 -0700
Message-Id: <20230525210040.3637-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525210040.3637-1-namit@vmware.com>
References: <20230525210040.3637-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

There is no reason not to allow the use of ftrace for usercopy, xarray
and iov_iter.  Enable tracing for these compilation unit.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 lib/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/Makefile b/lib/Makefile
index 876fcdeae34e..00450e1cc97d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -27,6 +27,9 @@ KASAN_SANITIZE_string.o := n
 CFLAGS_string.o += -fno-stack-protector
 endif
 
+CFLAGS_xarray.o += $(CC_FLAGS_FTRACE)
+CFLAGS_iov_iter.o += $(CC_FLAGS_FTRACE)
+
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 maple_tree.o idr.o extable.o irq_regs.o argv_split.o \
@@ -42,6 +45,8 @@ lib-$(CONFIG_SMP) += cpumask.o
 lib-y	+= kobject.o klist.o
 obj-y	+= lockref.o
 
+CFLAGS_usercopy.o += $(CC_FLAGS_FTRACE)
+CFLAGS_find_bit.o += $(CC_FLAGS_FTRACE)
 obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
 	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
-- 
2.25.1

