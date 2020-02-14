Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CECC15D0CA
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 05:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgBNEBu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 23:01:50 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36009 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgBNEBu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 23:01:50 -0500
Received: by mail-qk1-f193.google.com with SMTP id w25so8003826qki.3;
        Thu, 13 Feb 2020 20:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNB8Gpihvk/j601Ucwiu8D5ntYO/tUOJnzddLwCbtN4=;
        b=YLJdH+tOXxCQADy5b+VlV3LgWgQ1/t1ukHgO1xDUS3M8z7Pn5ykJizCNaBIaGgZxFv
         jkok0Yazq9fusyeaygJJR52n/FssFMCzuRWZrGs4lcYXDxQA2Yw0AXUOuNp22lvQy4zx
         9bFWhsel3ddAaTJdUkriB0PZRtMpkBJHeYXBuOqKpOouaaeZ7LmzNwAMaSYSj43uE2hq
         m5S/hOzoYAYeIG0xbjTxYhzVEOBU+xW/0x/G6NcmOw9P15m0zdluEp3Uu3lv42xvIlr4
         px15m3kyJNiWbDEla1p/hNrrp9MNJkPcO52gm0A1gdriyHfXXa5arV/Ke0tMePOmi9QB
         Clkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNB8Gpihvk/j601Ucwiu8D5ntYO/tUOJnzddLwCbtN4=;
        b=RlkoN7XVLA7oQ7lmCcUZz/XUo4bYLuDfZuLbOzbwiNlPDu1LLa3XFPtiYxFy3iRZRz
         wtAxKeo0KA/uEiNgHEJmEwk0fg4O0eKOizY4pwMon5PUJFNL/FRE1A9loROwCFfWGV/9
         Dr7BxRt8+5WK5Sew7xdvtoRF949qrQeoxVBJSOSha1sNoY380MwFOHkP6+coBHiN27wR
         XJg+l0+wg9xWYWEtr6uR/TTLGBnTZyAkqfZ/M9PnM6NshTRqIy4SyqzMLlDvRjHUolC4
         cPNFlOp7ThMXI7/bhhOO5fSNsWsMJi0teMOFQEkZZ1fSMNFx0DLDczjP8UDRCkJJQvvO
         F6rQ==
X-Gm-Message-State: APjAAAV9vO7HLnGTfy8Pp9IEQf8ZwRzKUB4T+tfuI5/yKLqtbU4GS3K+
        dRRVVx2ksgS1oXkJjASNy8Q=
X-Google-Smtp-Source: APXvYqwVNJ9mTIOuoV4na5s8plcZVON50gTNA5d+Lw6C/fkrWumzfqx+MH1NyHYDj7Nv0iTH6dacfQ==
X-Received: by 2002:a05:620a:90d:: with SMTP id v13mr758541qkv.332.1581652909370;
        Thu, 13 Feb 2020 20:01:49 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p2sm671195qkg.102.2020.02.13.20.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 20:01:48 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id C4AEE2219C;
        Thu, 13 Feb 2020 23:01:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Feb 2020 23:01:46 -0500
X-ME-Sender: <xms:ohtGXkDJcPDgINp3DxBPTuxODk69eGNIXahTScRNHzs89YPGfrT4hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieelgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpihhnrhhirgdrfhhrnecukfhppeeh
    vddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrg
    hilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ohtGXoCZpgVZgXDfXcgSf9nrBhZQkzgJ-UuwLB5WVDoQm0-4SfWjKQ>
    <xmx:ohtGXsK659sLFivB4G6kQ7a5SGNjqddoeJtyzA9Re-RELwa_EOuxFg>
    <xmx:ohtGXqR6Pt7iODxjTGPObsuvoI0-uQPLK3CgxGv17Tcqq8oP-8UAkA>
    <xmx:qhtGXtRxlM60i2Zw1LxixRAHsr4jcoA9cN4fwjW4jOc0xaly-15KLywamaI>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 243633280064;
        Thu, 13 Feb 2020 23:01:37 -0500 (EST)
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
Subject: [RFC 0/3] tools/memory-model: Add litmus tests for atomic APIs
Date:   Fri, 14 Feb 2020 12:01:29 +0800
Message-Id: <20200214040132.91934-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A recent discussion raises up the requirement for having test cases for
atomic APIs:

	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/

, and since we already have a way to generate a test module from a
litmus test with klitmus[1]. It makes sense that we add more litmus
tests for atomic APIs into memory-model.

So I begin to do this and the plan is to add the litmus tests we already
use in atomic_t.txt, ones from Paul's litmus collection[2], and any
other valuable litmus test we come up while adding the previous two
kinds of tests.

This patchset finishes the first part (adding atomic_t.txt litmus
tests). I also improve the atomic_t.txt to make it consistent with the
litmus tests.

One thing to note is patch #2 requires a modification to herd and I just
made a PR to Luc's repo:

	https://github.com/herd/herdtools7/pull/28

, so if this patchset looks good to everyone and someone plans to take
it (and I assume is Paul), please wait until that PR is settled. And
probably we need to bump the required herd version because of it.

Comments and suggesions are welcome!

Regards,
Boqun


[1]: http://diy.inria.fr/doc/litmus.html#klitmus
[2]: https://github.com/paulmckrcu/litmus/tree/master/manual/atomic

*** BLURB HERE ***

Boqun Feng (3):
  Documentation/locking/atomic: Fix atomic-set litmus test
  tools/memory-model: Add a litmus test for atomic_set()
  tools/memory-model: Add litmus test for RMW + smp_mb__after_atomic()

 Documentation/atomic_t.txt                    | 14 ++++-----
 ...+mb__after_atomic-is-strong-acquire.litmus | 29 +++++++++++++++++++
 .../Atomic-set-observable-to-RMW.litmus       | 24 +++++++++++++++
 tools/memory-model/litmus-tests/README        |  8 +++++
 4 files changed, 68 insertions(+), 7 deletions(-)
 create mode 100644 tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
 create mode 100644 tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus

-- 
2.25.0

