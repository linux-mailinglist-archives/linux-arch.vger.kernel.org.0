Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0629667DDAB
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jan 2023 07:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjA0Gk3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Jan 2023 01:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjA0GkV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2023 01:40:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA216B98D;
        Thu, 26 Jan 2023 22:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SUwH1LDQIw4JkT2EOAlWQFQIElPYczSWfrxh+QtUfJM=; b=n2NwzsXUlSrzYDF2M7V7nL9e7o
        mGfvprTGQXuHivvlde99vYK2OXmJG9VJf8wbuqk5NSLKnGP+nQlO9ZkvEhsFwq8uIN9yf27O6mrjA
        ZVxZ90FwkJfELZRnAmAkFdAWt402Ji55upCJNEBGb+aLl75gz/1eHLFposdfg3Nf9AtOEpjwxMjMr
        r5J63NDiePPLTrU7Nz5uCoUbb9nC49nY5HkgEpuiI0d+na6NY4IrR45QtiQolGXhIWZ0K8p6PHdb+
        uAP11QNzIhFkdwV5s78mCMJZDqeoPvTl9fSJpw/KxXJjiwlFqA3SutkcW+/9PLO+AR2sMSdvT+KGO
        RPUjL57Q==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPJ-00DM0u-1J; Fri, 27 Jan 2023 06:40:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 15/35] Documentation: litmus-tests: correct spelling
Date:   Thu, 26 Jan 2023 22:39:45 -0800
Message-Id: <20230127064005.1558-16-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Correct spelling problems for Documentation/litmus-tests/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-arch@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/litmus-tests/README |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -9,7 +9,7 @@ a kernel test module based on a litmus t
 tools/memory-model/README.
 
 
-atomic (/atomic derectory)
+atomic (/atomic directory)
 --------------------------
 
 Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
