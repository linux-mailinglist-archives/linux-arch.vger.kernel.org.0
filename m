Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4543995C
	for <lists+linux-arch@lfdr.de>; Mon, 25 Oct 2021 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhJYO53 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhJYO51 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Oct 2021 10:57:27 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA461C061745;
        Mon, 25 Oct 2021 07:55:04 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id v17so10549907qtp.1;
        Mon, 25 Oct 2021 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKouswC43XOGWPvotgpf5KMpVHojldx0dHk0FjnaE8k=;
        b=CVG/MBauiqpsOb6WuGNMogtuUFYssT+Jn/LmMsxuZvWR6/tAuaWBi+kJzVPZLgUPmi
         TV++3vybNwhMvIT5oA+9Jbdd6OmKeoHXReFSuSKbGbtSQJEtC9pPcdwBKeum2RnYmg2h
         O8xLt/4GZks2AYbjUL0XI5k2hnZuR+0T99JYHjJYEBVdSo5P9RD4Bcu3LPGmuw/EtpvK
         JW4NUTvugs6HFrTnADbtRkNLnx0uKajbLrCtGkgiwrhRVoDG/T3SwIZ6S0Gw73R5cwmt
         jIqzbKvo0KD/EpueXgSK0NPSn91NNdZbjTyRX1K2PKBVve0i9+pLscvYmttUuOXxXb/X
         AndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKouswC43XOGWPvotgpf5KMpVHojldx0dHk0FjnaE8k=;
        b=bS1rmQeoMRb38K5/jmsDg3ZZlvJOPw84TPPR5Wmr8vJ9FqKaRKcyMTB5YjA7sYDZQz
         0pGzPRcR5XFmiBZ0QdipQHI2eMga0pjOj29ibrLcTjbV5RvEdk8Gpxrs7wEW5VnefBX0
         ziJxiinO/Vi7LT7PyyXmwjT5RjVavcUVEC5h/8ZjGU95vdz6ncWhElSrTs8RjxbKWuzP
         oGoYZz0Yf1nymZgM8zD3nGq4KREvBK7M/+rA7Lfbe572lY57KBXdyP+rLAcT+tAUjBo2
         udZV3BM8MrtT9RFGYDjOzYvKy/NInp0CVSwea3emj+kiCoAPl7WE0Ra1wiCj1LoKVEMF
         GfRw==
X-Gm-Message-State: AOAM530pK8yzFtsjbMtzCy0FQ/0VHurXQdnJIOuB+hiQQQfcmKyCGyzR
        H2zoN+T6WFVbmHqoLbjNZjI=
X-Google-Smtp-Source: ABdhPJx5m8ClFS4H/PJcpyOhGClIoVaeTqR0yS+bRJsrlqjq3uTZ7acAsvjRHvPXJ3vk+t7FhAY0nQ==
X-Received: by 2002:a05:622a:13:: with SMTP id x19mr18040304qtw.83.1635173704053;
        Mon, 25 Oct 2021 07:55:04 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id bp40sm9195000qkb.114.2021.10.25.07.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:55:03 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 80BF427C0054;
        Mon, 25 Oct 2021 10:55:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 25 Oct 2021 10:55:01 -0400
X-ME-Sender: <xms:RMV2YZ7qmfb8nhPk-0sps-OlCToy5vkIeBSnqwSspAlk8dbUUPOQVw>
    <xme:RMV2YW718N0GzkvUWsS7KDa2pxXImPDrd70uXXyspzv3e43RdXjPBoY-BSzCkpOxf
    RtWfkg63kGj2zOfig>
X-ME-Received: <xmr:RMV2YQes4Zh8CEg6uPDoJkCDrvhqzRTzfNMJ8ZmB-XT4YljxGNUWfys-ecLB3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvffufffkofgjfhgggfes
    tdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnh
    hgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeekjeekkedukeeiveeuudef
    hfduieehvedvvddttdevffetgedvheeuledtudfhueenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghe
    dtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhes
    fhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:RMV2YSL1-8V1_Gvw1bIei79pX9pFFE-L8nMnYdbikZzc71ykt9JlYA>
    <xmx:RMV2YdKvH15BUCkWE5gc6hLMYs38khx1kEfriAn2Ccu8KPn-oYX_UA>
    <xmx:RMV2Ybwk8z3hY3i5qmnSBDCSNZPRvuW-qpum6W364wyMRG-j7AKLdQ>
    <xmx:RcV2Yd6rHrYccg_82dm-Wg7PGApdU_ae4FDU9ycC-RL8I99tscaCGYvGYBs>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 10:54:59 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Paul E . McKenney " <paulmck@kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au,
        Jonathan Corbet <corbet@lwn.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [RFC v2 1/3] tools/memory-model: Provide extra ordering for unlock+lock pair on the same CPU
Date:   Mon, 25 Oct 2021 22:54:14 +0800
Message-Id: <20211025145416.698183-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025145416.698183-1-boqun.feng@gmail.com>
References: <20211025145416.698183-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A recent discussion[1] shows that we are in favor of strengthening the
ordering of unlock + lock on the same CPU: a unlock and a po-after lock
should provide the so-called RCtso ordering, that is a memory access S
po-before the unlock should be ordered against a memory access R
po-after the lock, unless S is a store and R is a load.

The strengthening meets programmers' expection that "sequence of two
locked regions to be ordered wrt each other" (from Linus), and can
reduce the mental burden when using locks. Therefore add it in LKMM.

[1]: https://lore.kernel.org/lkml/20210909185937.GA12379@rowland.harvard.edu/

Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com> (RISC-V)
---
 .../Documentation/explanation.txt             | 44 +++++++++++--------
 tools/memory-model/linux-kernel.cat           |  6 +--
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 5d72f3112e56..394ee57d58f2 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1813,15 +1813,16 @@ spin_trylock() -- we can call these things lock-releases and
 lock-acquires -- have two properties beyond those of ordinary releases
 and acquires.
 
-First, when a lock-acquire reads from a lock-release, the LKMM
-requires that every instruction po-before the lock-release must
-execute before any instruction po-after the lock-acquire.  This would
-naturally hold if the release and acquire operations were on different
-CPUs, but the LKMM says it holds even when they are on the same CPU.
-For example:
+First, when a lock-acquire reads from or is po-after a lock-release,
+the LKMM requires that every instruction po-before the lock-release
+must execute before any instruction po-after the lock-acquire.  This
+would naturally hold if the release and acquire operations were on
+different CPUs and accessed the same lock variable, but the LKMM says
+it also holds when they are on the same CPU, even if they access
+different lock variables.  For example:
 
 	int x, y;
-	spinlock_t s;
+	spinlock_t s, t;
 
 	P0()
 	{
@@ -1830,9 +1831,9 @@ For example:
 		spin_lock(&s);
 		r1 = READ_ONCE(x);
 		spin_unlock(&s);
-		spin_lock(&s);
+		spin_lock(&t);
 		r2 = READ_ONCE(y);
-		spin_unlock(&s);
+		spin_unlock(&t);
 	}
 
 	P1()
@@ -1842,10 +1843,10 @@ For example:
 		WRITE_ONCE(x, 1);
 	}
 
-Here the second spin_lock() reads from the first spin_unlock(), and
-therefore the load of x must execute before the load of y.  Thus we
-cannot have r1 = 1 and r2 = 0 at the end (this is an instance of the
-MP pattern).
+Here the second spin_lock() is po-after the first spin_unlock(), and
+therefore the load of x must execute before the load of y, even though
+the two locking operations use different locks.  Thus we cannot have
+r1 = 1 and r2 = 0 at the end (this is an instance of the MP pattern).
 
 This requirement does not apply to ordinary release and acquire
 fences, only to lock-related operations.  For instance, suppose P0()
@@ -1872,13 +1873,13 @@ instructions in the following order:
 
 and thus it could load y before x, obtaining r2 = 0 and r1 = 1.
 
-Second, when a lock-acquire reads from a lock-release, and some other
-stores W and W' occur po-before the lock-release and po-after the
-lock-acquire respectively, the LKMM requires that W must propagate to
-each CPU before W' does.  For example, consider:
+Second, when a lock-acquire reads from or is po-after a lock-release,
+and some other stores W and W' occur po-before the lock-release and
+po-after the lock-acquire respectively, the LKMM requires that W must
+propagate to each CPU before W' does.  For example, consider:
 
 	int x, y;
-	spinlock_t x;
+	spinlock_t s;
 
 	P0()
 	{
@@ -1908,7 +1909,12 @@ each CPU before W' does.  For example, consider:
 
 If r1 = 1 at the end then the spin_lock() in P1 must have read from
 the spin_unlock() in P0.  Hence the store to x must propagate to P2
-before the store to y does, so we cannot have r2 = 1 and r3 = 0.
+before the store to y does, so we cannot have r2 = 1 and r3 = 0.  But
+if P1 had used a lock variable different from s, the writes could have
+propagated in either order.  (On the other hand, if the code in P0 and
+P1 had all executed on a single CPU, as in the example before this
+one, then the writes would have propagated in order even if the two
+critical sections used different lock variables.)
 
 These two special requirements for lock-release and lock-acquire do
 not arise from the operational model.  Nevertheless, kernel developers
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 2a9b4fe4a84e..d70315fddef6 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -27,7 +27,7 @@ include "lock.cat"
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
 let po-rel = [M] ; po ; [Release]
-let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
+let po-unlock-lock-po = po ; [UL] ; (po|rf) ; [LKR] ; po
 
 (* Fences *)
 let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
@@ -70,12 +70,12 @@ let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
 let to-r = addr | (dep ; [Marked] ; rfi)
-let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
+let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = (rfe ; [Marked])? ; r
 let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
-	po-unlock-rf-lock-po) ; [Marked]
+	po-unlock-lock-po) ; [Marked]
 let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
 	[Marked] ; rfe? ; [Marked]
 
-- 
2.33.0

