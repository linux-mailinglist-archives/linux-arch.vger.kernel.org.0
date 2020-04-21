Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BDC1B2ADF
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 17:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgDUPP6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 11:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgDUPP5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 11:15:57 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85933206D9;
        Tue, 21 Apr 2020 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587482157;
        bh=uklg+mgdxavZLV9+AiizuXXNfarJAGtL7/umiBXuknU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtXWGwjz6I5F+kGQ68k8ayw0bI65bZkP8kaAXCi7THCQM0ukdXRHZFQ5nt3vugjHP
         JTXFMatja5sk2QZwu5bcp5B7kZ5jF4h5S1YzFiIRYfc4nCPITF+uSbS2SV/P/+6Fin
         IpsAHA5kZmqqwLGJUw4Wn18mTeQlp2dujZroH6FM=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v4 04/11] fault_inject: Don't rely on "return value" from WRITE_ONCE()
Date:   Tue, 21 Apr 2020 16:15:30 +0100
Message-Id: <20200421151537.19241-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421151537.19241-1-will@kernel.org>
References: <20200421151537.19241-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It's a bit weird that WRITE_ONCE() evaluates to the value it stores and
it's different to smp_store_release(), which can't be used this way.

In preparation for preventing this in WRITE_ONCE(), change the fault
injection code to use a local variable instead.

Cc: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 lib/fault-inject.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 8186ca84910b..ce12621b4275 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -106,7 +106,9 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
 		unsigned int fail_nth = READ_ONCE(current->fail_nth);
 
 		if (fail_nth) {
-			if (!WRITE_ONCE(current->fail_nth, fail_nth - 1))
+			fail_nth--;
+			WRITE_ONCE(current->fail_nth, fail_nth);
+			if (!fail_nth)
 				goto fail;
 
 			return false;
-- 
2.26.1.301.g55bc3eb7cb9-goog

