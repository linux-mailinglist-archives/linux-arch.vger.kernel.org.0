Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D292526276E
	for <lists+linux-arch@lfdr.de>; Wed,  9 Sep 2020 08:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgIIGxx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 02:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgIIGxw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2020 02:53:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A3C061573;
        Tue,  8 Sep 2020 23:53:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so864163pjr.3;
        Tue, 08 Sep 2020 23:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6zWy4lH4b2dEVceEOO8yhdbZx8/mmSKLfa/zQwZrYQ=;
        b=qaSkRPZWfq4tjfOrzbBTpQETTCEmyk0wMD6qO5Jd2zcNyqbL5iRwVGP63w8eG4pJTc
         kbyg5vqiAtvYdGfloGnWTspvCTnUYdYqFv7nOZgv43AEgcTqrclX+4GBrodBy7vvPDZ7
         tL3CZbuC+J2Ouwxnp+br4zDVOw6NPAebxa15XMrQUviGIN7SPg3RZjvqT8O/fX7O4W28
         ue1j7bfoAzOMm+liOuCONzSHBCsQxBipHxsA0EOePmEM0XDCNJlaMb0FKUswDCHD2eEj
         eFqb9uiGx4IM/N00p39Cn32dpcG23rb4sXWSW2GxfSEpnO1skASdABzF+I/fTgf9uCuh
         uwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6zWy4lH4b2dEVceEOO8yhdbZx8/mmSKLfa/zQwZrYQ=;
        b=T2FyEZrXxFWTJXgymFjDNprUUoVElFRh21BM8KGhij5+mOv2pwnJvPvQrJ9f42hCxZ
         Wyeb0fRxKmsMMpXV5KE29uQSr+YL2DVN8RDwpc+35fsRzNWluGHE+N6RNyt3o7sWNAjc
         H3TXOx/G+ruy2KO7aIbxdePaiCLB6J5dsKmiMmc5oqWSBlRrXuSIpxm+fJ8gkQo3y4HS
         TftEEFbMnu1xtdZ3liHcjbLu634jWFJ6+RaBqoUNCBa0nkZBu7Xhg4rAPunDWW76xOwk
         c/JDyqRLd6IjZYioUNyg8QdJ5dLmosWmInbUGBDYUbwWdUkiBwHTSEQ7ggY+fGHvZ8iV
         mGjA==
X-Gm-Message-State: AOAM533kwG1OIC7OkbwuOF1Wdn5E4/A+5kr3AineGzExGe/rsCxl/X6t
        rO+ab4yM1g6IcUy6BaHYnzs=
X-Google-Smtp-Source: ABdhPJwHLBe0p7esA/xRQ6bmbG5hA3yWNwHOP3viC+Q2TNIDqX1FAZ9zbRvGzhmIL6pUA0CWRtFu3g==
X-Received: by 2002:a17:90a:c781:: with SMTP id gn1mr2296315pjb.151.1599634431230;
        Tue, 08 Sep 2020 23:53:51 -0700 (PDT)
Received: from localhost.localdomain (cl-ubuntu-kdev.xen.prgmr.com. [71.19.148.84])
        by smtp.gmail.com with ESMTPSA id e14sm1219552pgu.47.2020.09.08.23.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 23:53:50 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@kernel.org, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, corbet@lwn.net
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH] docs/memory-barriers.txt: Fix a typo in CPU MEMORY BARRIERS section
Date:   Wed,  9 Sep 2020 14:53:40 +0800
Message-Id: <20200909065340.118264-1-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit 39323c6 smp_mb__{before,after}_atomic(): update Documentation
has a typo in CPU MEORY BARRIERS section:
"RMW functions that do not imply are memory barrier are ..." should be
"RMW functions that do not imply a memory barrier are ...".

This patch fixes this typo.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/memory-barriers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 96186332e5f4..20b8a7b30320 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1870,7 +1870,7 @@ There are some more advanced barrier functions:
 
      These are for use with atomic RMW functions that do not imply memory
      barriers, but where the code needs a memory barrier. Examples for atomic
-     RMW functions that do not imply are memory barrier are e.g. add,
+     RMW functions that do not imply a memory barrier are e.g. add,
      subtract, (failed) conditional operations, _relaxed functions,
      but not atomic_read or atomic_set. A common example where a memory
      barrier may be required is when atomic ops are used for reference
-- 
2.25.1

