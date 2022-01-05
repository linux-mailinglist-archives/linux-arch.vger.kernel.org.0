Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573EF485663
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 17:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbiAEQDm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 11:03:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241799AbiAEQDj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 11:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641398618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hkde+7eKZjv80qwsVvmCX2T7y8AoaKGRyE5+tZVJ4q0=;
        b=d7hC1Bv8Bb4kAcDERBZpTj2AXxYLebcQynRF+LNjm0ytJKRdfxWyvNy30B8A1hec4BaEeK
        6YWjEnpgWXD8URu2OOWuJUI8FAuo7bGG7vsq9XPgiF4SYjAHZ1XvHo5kvJ+RIbKNGiq9Pz
        l6RG80bzULj32AHlFQJOUK+uDJxHVlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-b7RAR5SOOa-mxTpn4XvsZw-1; Wed, 05 Jan 2022 11:03:33 -0500
X-MC-Unique: b7RAR5SOOa-mxTpn4XvsZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C27F8196E6C6;
        Wed,  5 Jan 2022 16:03:20 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79BBF7DE2F;
        Wed,  5 Jan 2022 16:03:17 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Andy Lutomirski" <luto@kernel.org>
Cc:     linux-arch@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>,
        linux-x86_64@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, "the arch/x86 maintainers" <x86@kernel.org>,
        musl@lists.openwall.com, <libc-alpha@sourceware.org>,
        <linux-kernel@vger.kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Kees Cook" <keescook@chromium.org>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH v3 2/3] selftests/x86/Makefile: Support per-target $(LIBS)
 configuration
In-Reply-To: <3a1c8280967b491bf6917a18fbff6c9b52e8df24.1641398395.git.fweimer@redhat.com>
References: <3a1c8280967b491bf6917a18fbff6c9b52e8df24.1641398395.git.fweimer@redhat.com>
X-From-Line: 54ae0e1f8928160c1c4120263ea21c8133aa3ec4 Mon Sep 17 00:00:00 2001
Message-Id: <54ae0e1f8928160c1c4120263ea21c8133aa3ec4.1641398395.git.fweimer@redhat.com>
Date:   Wed, 05 Jan 2022 17:03:15 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

And avoid compiling PCHs by accident.

Signed-off-by: Florian Weimer <fweimer@redhat.com>
---
v3: Patch split out.

 tools/testing/selftests/x86/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 8a1f62ab3c8e..0993d12f2c38 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -72,10 +72,12 @@ all_64: $(BINARIES_64)
 EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
 
 $(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
-	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
+	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $(filter-out %.h, $^) \
+		$(or $(LIBS), -lrt -ldl -lm)
 
 $(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h
-	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
+	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $(filter-out %.h, $^) \
+		$(or $(LIBS), -lrt -ldl -lm)
 
 # x86_64 users should be encouraged to install 32-bit libraries
 ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),01)
-- 
2.33.1


