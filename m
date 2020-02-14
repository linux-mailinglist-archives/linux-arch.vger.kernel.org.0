Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F52715D0D3
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 05:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgBNECA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 23:02:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38123 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgBNEBw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 23:01:52 -0500
Received: by mail-qk1-f196.google.com with SMTP id z19so7982072qkj.5;
        Thu, 13 Feb 2020 20:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yknKVlNQwUI6dUMkFYithHZ6HnaPfn7u59ijVpemNQM=;
        b=Zg92sSP7gDACRfvrM/iWZdX7Uht6GkDfcIzaO7uvMbqf4HTevYbqbmEVOto2UtK4nb
         XIleeuSufLYEGPgSsZtEOvR9Km9K7+dnYs0WGk8KO1t5OmJXIoW+TTuQIQppUrhz0KBs
         cTqKGxb+r49zSWv1bWWhpi5Yf92zDZqOTW9QANvniEaXk/uzOFBKRsfZ32Z5sPhVCHbN
         puOdv/UxVda8Pfm4I/7BL2XrztMaVt8kSkaJvBG68oJMor3IWDhJh0Rs6taEkmJN17hA
         7H8O3QmOXYogcK+VF4H+zmEZyKEJJWPvLWAbBJ8/3LDbTinxD4S5T7CQ4nkk68OCmNlU
         VOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yknKVlNQwUI6dUMkFYithHZ6HnaPfn7u59ijVpemNQM=;
        b=E+kMJgcenuyLdcP/ODi7Z4BWd/xFmDeUmuYjRSpOzDgpmdV31sR5qCnrw8m+u0zKUU
         3s2RbWd/7WN9yuUzdZwAQuXaiNqBnIf/fH5G/yr99dD7Iz1PlRqaFGQ/kkfKAhDC211D
         NFN55gXLYnY+HH7OYwjfic4cH3XZ42XfXYhVr31VcfH5Zp7WH1m0QIoRCC3WLubLUqhC
         OOinoPhDSBB5z2tiJHrNuud2bCHZzSzZv45CW7GH8i0uljOFwD6IMfWr0vU+CGI+bbrc
         F6oPsoPFm4qzytjunD26QpoMDW4QXG7g23tczmIGFT03GsHA3hwkWh2mNH5K0Uff/IQA
         rMIg==
X-Gm-Message-State: APjAAAV+Au3GSKk+d1O6ZZx49toh1tzWbcnp0T30N7iPwpjm5ctzI60Q
        d/VL7cNKPgVkqE8gBTLS9xA=
X-Google-Smtp-Source: APXvYqyaH0Fwo2EG77Hr8mgRUar/MVsrg9xgTrXSuncizoiByQeg/BkqHxvhcNW6AFWwljmayF/Ijg==
X-Received: by 2002:ae9:e210:: with SMTP id c16mr713180qkc.334.1581652909953;
        Thu, 13 Feb 2020 20:01:49 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s26sm2615823qkj.24.2020.02.13.20.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 20:01:48 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id C4B25221AD;
        Thu, 13 Feb 2020 23:01:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 13 Feb 2020 23:01:46 -0500
X-ME-Sender: <xms:phtGXuBYd1G46L8rktzp_QIQXixCJiQmE1Jnqbfr1bnpLCWS85U-kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieelgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:phtGXrJWH6xTqWnf417-9qen_q3Txk3sHK0PIKLOGOXXndc9NDC-5w>
    <xmx:phtGXhGEbRNZIi84s5mneklQ_cRq-DjTzKJgjXNKCHQMbuabOkJrkQ>
    <xmx:phtGXuF0etdtW7DKVvg70OZ5jc4TXbZ1vfJBv78txWqKA7sAwg8Rvw>
    <xmx:qhtGXmOAKug2i9jraZVMufI8DnPaDXsUnVFvU7p6WYx0t7p5eYgbGS8EWiE>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3C2FD3060D1A;
        Thu, 13 Feb 2020 23:01:42 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [RFC 2/3] tools/memory-model: Add a litmus test for atomic_set()
Date:   Fri, 14 Feb 2020 12:01:31 +0800
Message-Id: <20200214040132.91934-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214040132.91934-1-boqun.feng@gmail.com>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We already use a litmus test in atomic_t.txt to describe the behavior of
an atomic_set() with the an atomic RMW, so add it into the litmus-tests
directory to make it easily accessible for anyone who cares about the
semantics of our atomic APIs.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 .../Atomic-set-observable-to-RMW.litmus       | 24 +++++++++++++++++++
 tools/memory-model/litmus-tests/README        |  3 +++
 2 files changed, 27 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus

diff --git a/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus b/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus
new file mode 100644
index 000000000000..4326f56f2c1a
--- /dev/null
+++ b/tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus
@@ -0,0 +1,24 @@
+C Atomic-set-observable-to-RMW
+
+(*
+ * Result: Never
+ *
+ * Test of the result of atomic_set() must be observable to atomic RMWs.
+ *)
+
+{
+	atomic_t v = ATOMIC_INIT(1);
+}
+
+P0(atomic_t *v)
+{
+	(void)atomic_add_unless(v,1,0);
+}
+
+P1(atomic_t *v)
+{
+	atomic_set(v, 0);
+}
+
+exists
+(v=2)
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 681f9067fa9e..81eeacebd160 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -2,6 +2,9 @@
 LITMUS TESTS
 ============
 
+Atomic-set-observable-to-RMW.litmus
+	Test of the result of atomic_set() must be observable to atomic RMWs.
+
 CoRR+poonceonce+Once.litmus
 	Test of read-read coherence, that is, whether or not two
 	successive reads from the same variable are ordered.
-- 
2.25.0

