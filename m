Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0861443995E
	for <lists+linux-arch@lfdr.de>; Mon, 25 Oct 2021 16:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhJYO5a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 10:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbhJYO52 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Oct 2021 10:57:28 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7530EC061767;
        Mon, 25 Oct 2021 07:55:06 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id b12so10532242qtq.3;
        Mon, 25 Oct 2021 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3IC2Fp9uyTBJeEiyczuSLfAZqOpe9E03onqE9MPljAg=;
        b=jlwIJ9iUNiBewSD9HjOyTmP23oN9WiNM1iXsEzhp7xQ2OfkBnhVvZFxbwcDPUjBD07
         GuBaUt/o2Q0QDf9rrJtYu5QNqZpyp7KNYQLX8bkubSzcksh8E9DRhAQIX28h/4LhIsms
         7N9R5UyQ0TA2KKRnTi4QdE2s0FW9zz2SewKg3vF1U2VBA5pIQD6wNVtVMFS0bFg0bNlY
         dv8pJpwBh1k0ydzzqIPnzv7v40gUAgpPmVXbudVoud5qOhGT4dcPzjqJyGlLJ0ps9nOo
         O/Q9b2+EN/NgIyD0lG/uxt++q2asZKuTqC8icKRknm5ppcjEWW5uvrwDoqPH6UMQ/PaL
         /W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3IC2Fp9uyTBJeEiyczuSLfAZqOpe9E03onqE9MPljAg=;
        b=2qVN9jZhHUVK1UnwOD+HNIpMbmrPcbfuUPFad0qZoAc4S/BMtC5EHHX4aNP/QfHMY7
         H+/P+8oIDoXPthw4Z/MJpIWNAALopcmPty712yoXoIigHtvTgHlpLV/sbJF+rrppy8p+
         SZTRgdpajQu6Vh8R57HVimFvUg9dQBFN36Bjtio+eVwgkCTOOQt+n7HCSlkY7d3GVzqE
         BaGdxKsKwYzk5KEVd/K95xJV0X4vP1JoaAa1ZEg/FJcIVyKp6JlyFLyEPu07yYI9yxY0
         ZDu20KW0ZDN6JRyDiMC3e+lIbkRsXyPV1CqUARfKTWXg2TajJuYflfHJf+X09I7E9Nr3
         cTAw==
X-Gm-Message-State: AOAM532s8mJrkIJVSKLTKB6tQHrCuzQTFtWvgBA9geE3v3+5nifdFWOk
        IclP7qqr9E7RMTnqsY6AIE4=
X-Google-Smtp-Source: ABdhPJytzcz7gflRWd5zT9HX1yizuIccdk0JMj+RSZulBQSmZEEBKHa+SycJ1+Ik5r3IXJlg88UPtA==
X-Received: by 2002:ac8:7d46:: with SMTP id h6mr17952663qtb.93.1635173705713;
        Mon, 25 Oct 2021 07:55:05 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j23sm8466067qtr.23.2021.10.25.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:55:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id B453A27C005A;
        Mon, 25 Oct 2021 10:55:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 25 Oct 2021 10:55:03 -0400
X-ME-Sender: <xms:RsV2YWwW330LDmjl2aOH1YGnOwi386vwvtPFU8TJ7IFpiZBX8SKhJg>
    <xme:RsV2YSSwp6Gl3kueKu6A7Vk9q-qlY_p6hLcDgxKUc6GgDGYyqL-n7gOExXQEBjUIj
    7XOEs3vX1PbA_XHIA>
X-ME-Received: <xmr:RsV2YYWvNg0FG0M8wCDT_Apf2zVDaRc0esGFSm6yN-dmutXJgRWTsJlPROLulg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvffufffkofgjfhgggfes
    tdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnh
    hgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvteeuueffueeivedvheet
    udejtdevfeegleevjeduhfdtveduvdekvedufeelteenucffohhmrghinhepghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghe
    dtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhes
    fhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:RsV2YcileSsaOCFjFBDcYHP0RCXLDlIqrZzHt0wDFlm5uyMgDK9Lxg>
    <xmx:RsV2YYAKYU7ZACvsRjIWAL5e_9oKn5DmEh9Ejz_CLiw3ODdeaxylMA>
    <xmx:RsV2YdIUp700QF7lTujir87J0BPq2pI-XXNeMpDZfPs1ohnpBfZfZw>
    <xmx:R8V2YfClZaMvn0AOmrecnuymcdX74J5qbHAepgvQ950IuJV8cCUy-xEtrKo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 10:55:02 -0400 (EDT)
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
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v2 2/3] tools/memory-model: doc: Describe the requirement of the litmus-tests directory
Date:   Mon, 25 Oct 2021 22:54:15 +0800
Message-Id: <20211025145416.698183-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025145416.698183-1-boqun.feng@gmail.com>
References: <20211025145416.698183-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It's better that we have some "standard" about which test should be put
in the litmus-tests directory because it helps future contributors
understand whether they should work on litmus-tests in kernel or Paul's
GitHub repo. Therefore explain a little bit on what a "representative"
litmus test is.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/memory-model/README | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 9a84c45504ab..9edd402704c4 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -195,6 +195,18 @@ litmus-tests
 	are listed in litmus-tests/README.  A great deal more litmus
 	tests are available at https://github.com/paulmckrcu/litmus.
 
+	By "representative", it means the one in the litmus-tests
+	directory is:
+
+		1) simple, the number of threads should be relatively
+		   small and each thread function should be relatively
+		   simple.
+		2) orthogonal, there should be no two litmus tests
+		   describing the same aspect of the memory model.
+		3) textbook, developers can easily copy-paste-modify
+		   the litmus tests to use the patterns on their own
+		   code.
+
 lock.cat
 	Provides a front-end analysis of lock acquisition and release,
 	for example, associating a lock acquisition with the preceding
-- 
2.33.0

