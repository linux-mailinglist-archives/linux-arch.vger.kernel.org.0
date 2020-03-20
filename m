Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7849C18C7BE
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 07:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgCTG4F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 02:56:05 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42428 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgCTG4E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 02:56:04 -0400
Received: by mail-qv1-f66.google.com with SMTP id ca9so2427681qvb.9
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2020 23:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+ruBW5svJNNwK4T7b3xChy9UrVEHEFAmhNhDXoWMas=;
        b=pTi+8LzaXbYs3NcLg4xVWXEHAL9IX0yIf9lreQDveNQ4bSrq0MscW4/7QgDD3uh0zg
         ErePlzUufo4lP4yOjUv4DUy74pcv56BHTiUn80LtQ142v30fAehrRYxhTOcO14ZqMIus
         w3YLPQCbSNpoV8cbe/hG6GL1gfRWkCFRH6x30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+ruBW5svJNNwK4T7b3xChy9UrVEHEFAmhNhDXoWMas=;
        b=bkqajIxG7dWpSar/gRS7NNt9pxOBl2AiGY5DTNHKqd3LBMFkGTR94vu82tGXuKLp2R
         85i9vEO/woocIuCAoipvxYlv9Tr4W/pIcsbDzTxQqS9CW1ZVmxMhYHzpPk3NcVaWEa7y
         DqzrJzefLJaDB6Ov59xyy4rB/WMFsVdakFYsVteXNdzIsOjS3oh/6gYjcFTBfpjhRvUI
         h9VqkvR/OpEyMksl/H+3TbA/Hr+4v6nYJ0YLFpZ/jtYf74DPYBpz27GMnzeS6ixaY30Q
         5cGmi4zCqlBfkHeYTBsSkgMC2TkWyumhzlJOyf5Ikpvvnui/RBh+zMyUOmm+yLgE7FNR
         F4SQ==
X-Gm-Message-State: ANhLgQ0ijbfhpa1Zu36lfi+oumisYoF8KWJRmKWRP8i/u+0/cc64G9m+
        z49YaRyZ3MpdGC8i694m21ci+A==
X-Google-Smtp-Source: ADFU+vvRPyWcUWODGO5eNkoJj05BokJuOxVUJV3+JfcFX1K7jPiU9mxjLxXe8jg8Hmr5JHstH1mFUw==
X-Received: by 2002:a05:6214:885:: with SMTP id cz5mr355723qvb.43.1584687362509;
        Thu, 19 Mar 2020 23:56:02 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m15sm419985qkk.26.2020.03.19.23.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 23:56:02 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 3/3] LKMM: Rename MP+onceassign+derefonce for better clarity
Date:   Fri, 20 Mar 2020 02:55:52 -0400
Message-Id: <20200320065552.253696-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200320065552.253696-1-joel@joelfernandes.org>
References: <20200320065552.253696-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For better consistency with RCU examples, rename MP+onceassign+derefonce
to RCU+MP+onceassign+derefonce.

I plan to add more RCU related litmus tests, so we could use this
convention if that's Ok.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 ...sign+derefonce.litmus => RCU+MP+onceassign+derefonce.litmus} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename tools/memory-model/litmus-tests/{MP+onceassign+derefonce.litmus => RCU+MP+onceassign+derefonce.litmus} (94%)

diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/RCU+MP+onceassign+derefonce.litmus
similarity index 94%
rename from tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
rename to tools/memory-model/litmus-tests/RCU+MP+onceassign+derefonce.litmus
index 97731b4bbdd8e..f9bfe0fd42e4d 100644
--- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
+++ b/tools/memory-model/litmus-tests/RCU+MP+onceassign+derefonce.litmus
@@ -1,4 +1,4 @@
-C MP+onceassign+derefonce
+C RCU+MP+onceassign+derefonce
 
 (*
  * Result: Never
-- 
2.25.1.696.g5e7596f4ac-goog

