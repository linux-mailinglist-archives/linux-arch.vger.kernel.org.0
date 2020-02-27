Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F5F170D58
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 01:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgB0AlL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 19:41:11 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42685 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgB0AlJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 19:41:09 -0500
Received: by mail-qt1-f194.google.com with SMTP id r5so1024187qtt.9;
        Wed, 26 Feb 2020 16:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hXaVpGqqToiZNRZTnPuTvkrof7XCekzeFTv2omJ7ql0=;
        b=nkdkXloivKU173/MWNM6WK/cxC4RDEdhnqox7q0e4paup7yzZXhSS/dtIqZeo092ZO
         lEM6C19TxUOGKyXCwRzfMsk+JvVhJjshkAdbcyrU2GnIs4qxH1wBr27QC8H3V76TzJfu
         pO0fveZc4PIBymtccnGRP6kk3bzZdsX9PJCOHHbDWMzv1vxQYBFMCpD52r3yYGGpISnw
         g+mSjEjPUXUZWGUBOkTU2zb7u5TmHcnXAgfAxXx5KqIrJAfLpG1mtMxGVh8+OYzAcpaF
         T9+c93TeFIcAkB4F60P66lnCDCdMokKVLtAGXlLDcRIpPQ02AjGx5lPNwQkE7D6DRULg
         M5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hXaVpGqqToiZNRZTnPuTvkrof7XCekzeFTv2omJ7ql0=;
        b=AedjYmn7hE/p3uDD7QiWuT1toSoLsgkPvFTzo3oZ68CKmeo5PhIHspiMFWKrRULXVF
         OM7raBtNL55YpnbjmD9kFn0SS9u/aznrHeOaUG+RxKAKCJi37x+ZGez6e/DkVOHfrcA8
         MzUncnQvW1RrusNLnCQPlsts8NZagVQYi5DuK+k8jB9sTUC4Vv8Waud1y5nHPPSar48b
         iuxRnVitr0DFj2sbmqPE94JOlnYYvCY6W1YJKhsFi4THU5joKE8EN/EiYq4maWUqmyn5
         Z+n52fbO03kmEt3H6VbE9tUDC5UjPO7sCK///FCwMLFHBMyOCA/vSU94az/kWSgQpta9
         KBiw==
X-Gm-Message-State: APjAAAWm4Os9h8fDqarTob9bq4WJnyEhJIFLhMWURT1Sv8mxAtD91fhK
        2NRHoA60ZvYyrgrhi7mVpo8=
X-Google-Smtp-Source: APXvYqw5pvVvN7mOL2p4Pk8A/0lk2PPcd8yX9vRcB+kKAVZnu1D4pBVV2urj4dhqVjohZuR29FnWGQ==
X-Received: by 2002:ac8:4e43:: with SMTP id e3mr1879990qtw.129.1582764067329;
        Wed, 26 Feb 2020 16:41:07 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i14sm1991310qtm.60.2020.02.26.16.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 16:41:06 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 24F7B210B8;
        Wed, 26 Feb 2020 19:41:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Feb 2020 19:41:06 -0500
X-ME-Sender: <xms:IhBXXnawAJTaFggTdUfktB0k9HKWod9G2w5kmE9gffK4ZJidNUDexw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleehgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheeh
    vddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:IhBXXut_bnYXHtu5GuNp2ENNjesUnfVEtzQUi0aNAYtKlExABxVQRA>
    <xmx:IhBXXgE9gNVuLXhkD54A4IDgo50AwenxnyEWmdsR3dLCE1DtWiBcQg>
    <xmx:IhBXXqwJpRpXaNnwQF0hfDkgTY1S_8f1CqzX4rFc935lVSoy7ovmrg>
    <xmx:IhBXXnlq7AGNF3Q8yLXGZ88SCtKxhka2rRDyRYmz7Bn98hBjxEvRVpEZ4RU>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9680B328005D;
        Wed, 26 Feb 2020 19:41:05 -0500 (EST)
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
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v3 3/5] Documentation/locking/atomic: Introduce atomic-tests directory
Date:   Thu, 27 Feb 2020 08:40:47 +0800
Message-Id: <20200227004049.6853-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227004049.6853-1-boqun.feng@gmail.com>
References: <20200227004049.6853-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Although we have atomic_t.txt and its friends to describe the semantics
of atomic APIs and lib/atomic64_test.c for build testing and testing in
UP mode, the tests for our atomic APIs in real SMP mode are still
missing. Since now we have the LKMM tool in kernel and litmus tests can
be used to generate kernel modules for testing purpose with "klitmus" (a
tool from the LKMM toolset), it makes sense to put a few typical litmus
tests into kernel so that

1)	they are the examples to describe the conceptual mode of the
	semantics of atomic APIs, and

2)	they can be used to generate kernel test modules for anyone
	who is interested to test the atomic APIs implementation (in
	most cases, is the one who implements the APIs for a new arch)

Therefore, introduce the atomic-tests directory for this purpose. The
directory is maintained by the LKMM group to make sure the litmus tests
are always aligned with our memory model.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 Documentation/atomic-tests/README | 4 ++++
 MAINTAINERS                       | 1 +
 2 files changed, 5 insertions(+)
 create mode 100644 Documentation/atomic-tests/README

diff --git a/Documentation/atomic-tests/README b/Documentation/atomic-tests/README
new file mode 100644
index 000000000000..ae61201a4271
--- /dev/null
+++ b/Documentation/atomic-tests/README
@@ -0,0 +1,4 @@
+This directory contains litmus tests that are typical to describe the semantics
+of our atomic APIs. For more information about how to "run" a litmus test or
+how to generate a kernel test module based on a litmus test, please see
+tools/memory-model/README.
diff --git a/MAINTAINERS b/MAINTAINERS
index ffc7d5712735..ebca5f6263bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9718,6 +9718,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
 F:	tools/memory-model/
 F:	Documentation/atomic_bitops.txt
 F:	Documentation/atomic_t.txt
+F:	Documentation/atomic-tests/
 F:	Documentation/core-api/atomic_ops.rst
 F:	Documentation/core-api/refcount-vs-atomic.rst
 F:	Documentation/memory-barriers.txt
-- 
2.25.0

