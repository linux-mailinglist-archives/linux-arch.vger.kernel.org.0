Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437074747EE
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbhLNQZV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbhLNQYH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:24:07 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DA1C061792
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:48 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id f13-20020adfe90d000000b001a15c110077so92640wrm.8
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DRsUBze0TCq/8OPjxRo856aiOc30zNOBN3bl6uBcnGs=;
        b=pb+BQoZ+20k4jQn45XqB5EEUKM9VUAj9iuAHLbPgyXtF8+YsW/fWdE2vL6sFEFEoyK
         tWCv5yjZsXSeiLNcRp7Ukw9zJKfdtRTRck34pTDgR3eAKHXUMHwrxvmjrt0vnrCi9Ntj
         VcSfevLftX/8QebdbsT2/yyELtFYLs0K5L5GeCrGFcj/LwYUDawmOOwWa5lI+UYiUV6d
         aDd+xSGh3C+3mSWHyY145Tmd8x8T+UjCaGtCtAdmAUcJGTsJ04N7Px5YHgXcZ0IIbHVR
         KHuCXm+v9/dfHaUfRJl4TuJQOxWAjETiKDDAkBqZM45Aiw8oYXWucw0t068DlQk8Wo5C
         zofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DRsUBze0TCq/8OPjxRo856aiOc30zNOBN3bl6uBcnGs=;
        b=t3aDBibhTAA/yKqxKY0ILDkPs19bBoDXnUNTzDkFflQw2s4HfBdfXvlumCUiayX3bH
         8lRTN9MmFMj/Y91CZkLgAY2Y6F8johTq/z1oLXPuG1plvq3dZOKUNysZTVvguYp6d0ei
         U5+BxRJFnrHRFOBVjccscFa+K32E5nG1383FJWhfMW+YPWvoHcJBQDuCVbyXxyv44ex4
         ItMLXnGw4QDhxXpui+nj+ct0vf4fjTmLGxM9dFFk7x5BcDJ5iV4DM1BgqiX0E5nsf7Hz
         Om3I7xvqKIixDWSz/MBhWBDV0SOWCQ6OX6aKizPZ7Thciu6AREjBdSdZR6I77xUHATQU
         Tkdg==
X-Gm-Message-State: AOAM532tdKkprHg/12eeIesTyq/EMWzPnAvz8lRYkGy4YYRykHAOFwOi
        R6R1qbJdeNWh5Gsi9PfFE//XbNrWhi0=
X-Google-Smtp-Source: ABdhPJzbEf5lWlF6RWfh8Re9EBCpxKO3TumG/VSHFoE+dz+wF3Gg0ijQABT1lDRRxNcQr8YrfKX8rhC5/wo=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a5d:644f:: with SMTP id d15mr6736523wrw.662.1639499027200;
 Tue, 14 Dec 2021 08:23:47 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:49 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-43-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 42/43] objtool: kmsan: list KMSAN API functions as uaccess-safe
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

KMSAN inserts API function calls in a lot of places (function entries
and exits, local variables, memory accesses), so they may get called
from the uaccess regions as well.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I242bc9816273fecad4ea3d977393784396bb3c35
---
 tools/objtool/check.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 21735829b860c..9620b5224754e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -937,6 +937,25 @@ static const char *uaccess_safe_builtin[] = {
 	"__sanitizer_cov_trace_cmp4",
 	"__sanitizer_cov_trace_cmp8",
 	"__sanitizer_cov_trace_switch",
+	/* KMSAN */
+	"kmsan_copy_to_user",
+	"kmsan_report",
+	"kmsan_unpoison_memory",
+	"__msan_chain_origin",
+	"__msan_get_context_state",
+	"__msan_instrument_asm_store",
+	"__msan_metadata_ptr_for_load_1",
+	"__msan_metadata_ptr_for_load_2",
+	"__msan_metadata_ptr_for_load_4",
+	"__msan_metadata_ptr_for_load_8",
+	"__msan_metadata_ptr_for_load_n",
+	"__msan_metadata_ptr_for_store_1",
+	"__msan_metadata_ptr_for_store_2",
+	"__msan_metadata_ptr_for_store_4",
+	"__msan_metadata_ptr_for_store_8",
+	"__msan_metadata_ptr_for_store_n",
+	"__msan_poison_alloca",
+	"__msan_warning",
 	/* UBSAN */
 	"ubsan_type_mismatch_common",
 	"__ubsan_handle_type_mismatch",
-- 
2.34.1.173.g76aa8bc2d0-goog

