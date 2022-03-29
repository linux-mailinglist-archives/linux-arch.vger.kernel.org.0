Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE224EAD97
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiC2Mtv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbiC2MsN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:48:13 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D40325ECB6
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:46 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id d28-20020a50f69c000000b00419125c67f4so10954303edn.17
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BxrNv7I9TyEaPnGly7TdSY5yHzK/Q3Z4xNLrOUnkClQ=;
        b=F1YYot40OfwHFlJIBEjvvi7+vEf+sISqzpxyEMm9RXg7yBeYOovpz1ifEVjxkb+8Tp
         ug846iZxjLR7LfZGindUZ5W5ZYWx9SXUM/LIzPff3L9xOwWnmqR34pPLPPicL7EpVaWh
         BceAVU1QYjQ33h5UnMxF7NMbTCP79zz+hCjBe7DzaqQKiuOmpo0Q92dqE8k4H4xhYPJ5
         8QBDPgbSjW2Dxw8rRJh4j124haAPk3WZ7kH3MZRK7aTRX+53Kfdw+whZ5Qh3OkEuEe4V
         /YzlCDf1dkIQcIX6qS1kNTRw9/AS3wlsNX6fJ044mUGy/rWkdQ4G5sXgY/2nnNeFCaLN
         ovQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BxrNv7I9TyEaPnGly7TdSY5yHzK/Q3Z4xNLrOUnkClQ=;
        b=IUIznVE40TcyKZzFPhlgeVO/CC+iy1ivoHYLcK0aDp6XDX0FkOtRJFQFdZpnzOF+7U
         pLRirwDqAaE2uaMWjxDafyVz80oIiDXhh8PZgkd/QFVM+Eq05geyLWECuSAYf+E+CiNl
         RYMFcBVm8B/TSepfTC/P39PCcs4aWloZsC31YSrTWSq9mCz2T7vM4+rcIdFFioutpTS7
         wCGdyFQo4Gk97d1zlQWUsXNS+EAVkBRgIfu75wrR0z235ZmTbIMgYF8flDeCGOsD+LOb
         xT2B8IfWIZLfNQl160ohPdXtOAAVs1Iy5/GpZE2cX88JiIb1ig9H0cr9wv2XS3jM6ctK
         MlBQ==
X-Gm-Message-State: AOAM530ZYtPg9aB47Z+bptT7PVZmQpCB6AFKdNGjCCic3uD14Qbsu2r9
        at44EMM+hfShuLFeT47pWDwOAUlXGt0=
X-Google-Smtp-Source: ABdhPJwCpxSBAahtijoWXTLXmqk0cIsPTNznjrswrMwUWM6rymRvh0IEM+UvEt2qc+MfcoyqAjf1DJp1rgo=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:c1c6:b0:6d5:cc27:a66c with SMTP id
 bw6-20020a170906c1c600b006d5cc27a66cmr35151648ejb.650.1648557756848; Tue, 29
 Mar 2022 05:42:36 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:17 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-49-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 48/48] x86: kmsan: enable KMSAN builds for x86
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make KMSAN usable by adding the necessary Kconfig bits.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I1d295ce8159ce15faa496d20089d953a919c125e
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 646a7849be4cf..1c4601e198d5c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -165,6 +165,7 @@ config X86
 	select HAVE_ARCH_KASAN			if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC		if X86_64
 	select HAVE_ARCH_KFENCE
+	select HAVE_ARCH_KMSAN			if X86_64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
-- 
2.35.1.1021.g381101b075-goog

