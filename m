Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5077F6344F2
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 20:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbiKVTyt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 14:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbiKVTyW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 14:54:22 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C81A3403;
        Tue, 22 Nov 2022 11:54:20 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y10so13489262plp.3;
        Tue, 22 Nov 2022 11:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RI1x4addaxeSG0Ueh/t7m47u+roOJv2baaQ7rL2Moo=;
        b=kc07iCXUBXT3CNeUNFgib2mQbobrmSlPnkO4hN7UDBjXdC593YuLhpAL+DvPmXFPHb
         ffu3DQ6vyxfbPxVHXCSQm2IAXJFMQuRCUahdFTR9xRFILUYT373IjzHdYc2+AP+YbxU5
         fX607CPAdRphk1/UEff3UfGp1v/Madb3BUV1xh+t8qys49zCgEOqZe3PbbBZRXXGyv+j
         2dLRm6aPOlxoXIBXIGtJXS8/G2hOqqmL57XCoCY5hZ8Zv6LLflyp7vIMbXfNBD93QMi4
         8eWzyhXMrbTTXHUV60Q9/OxTaQJOi+iEV1mFypFCLCZT89646tZ6q3b3DkpmRQ8LoYFx
         2JwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RI1x4addaxeSG0Ueh/t7m47u+roOJv2baaQ7rL2Moo=;
        b=a7g46kqkT5MnL2FfaNziZQR7ZgMTQILt/9dNvJJSxmmS4jMdDbUiYhEHju9NmjW7cx
         Z+LXeawuFEEMW3ucDrLvmXEcuGYCsJe2FJCzzqsWBEE7F1uhD2Vvd9mbl7r1YQYM0ren
         ady/s7lL883wJgSZmA1hkIJJ1FEdxMl/YdWiVFWu7F0N6Ua6F+udEipK9m7WeUZCA0EO
         ljbrYChu4/mCrE2QJHUgWkVjmEt1iBEpn1oM7AxhR+2gkTfoVshIB6OYOtUDXdgAlek+
         DE8Bb04SqwG2HO7BaxFWxm92yZcSxfyfL2UmRU0pWAhYT5OulIYXuwVpnoLveZ66pB89
         kAKw==
X-Gm-Message-State: ANoB5pnX2oVQbTE3T5FIIPUzu4n3qE0lVO94VT+g2wSkR7oP1PAZDVbx
        YT8cBn5DHFqkyIeeMOQD1sY=
X-Google-Smtp-Source: AA0mqf64VILhA5gP/coNKXRf4/fdbaKs5HD5f2gWeXuO6VasjLJvoWakA+MEzWWgzt/ZUovXPCAy/w==
X-Received: by 2002:a17:902:ab4b:b0:186:7b95:f773 with SMTP id ij11-20020a170902ab4b00b001867b95f773mr6266579plb.152.1669146860203;
        Tue, 22 Nov 2022 11:54:20 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id a8-20020a63d408000000b00460fbe0d75esm9699252pgh.31.2022.11.22.11.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:54:19 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 2/3] lib/usercopy: Allow traceing of usercopy, xarray, iov_iter
Date:   Tue, 22 Nov 2022 11:53:28 -0800
Message-Id: <20221122195329.252654-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122195329.252654-1-namit@vmware.com>
References: <20221122195329.252654-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 lib/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/Makefile b/lib/Makefile
index 59bd7c2f793a..32766aa26670 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -27,6 +27,8 @@ KASAN_SANITIZE_string.o := n
 CFLAGS_string.o += -fno-stack-protector
 endif
 
+CFLAGS_xarray.o += $(CC_FLAGS_FTRACE)
+CFLAGS_iov_iter.o += $(CC_FLAGS_FTRACE)
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 maple_tree.o idr.o extable.o irq_regs.o argv_split.o \
@@ -42,6 +44,7 @@ lib-$(CONFIG_SMP) += cpumask.o
 lib-y	+= kobject.o klist.o
 obj-y	+= lockref.o
 
+CFLAGS_usercopy.o += $(CC_FLAGS_FTRACE)
 obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
 	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
-- 
2.25.1

