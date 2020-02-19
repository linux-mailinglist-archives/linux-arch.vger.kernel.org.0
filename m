Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB54163D0B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 07:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgBSG0z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 01:26:55 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42270 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgBSG0m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 01:26:42 -0500
Received: by mail-qv1-f65.google.com with SMTP id dc14so10324674qvb.9;
        Tue, 18 Feb 2020 22:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hXaVpGqqToiZNRZTnPuTvkrof7XCekzeFTv2omJ7ql0=;
        b=aTGJxfGaQguG/6WoGHY8BrKiu17y3QOpcCYo76xvmyaS/GSok2dRM6n59tD8pavXWj
         f+V0zsR/stnq5zPkngYrYCjvtH2CRDnugF1neZiMHEtSamCv1ZZRijR6wI1l8dpG0kGW
         6JYlpj1Bq0u7dkfpM5AFpfEkh1pZOTVrsY5HgmKfCdWAL24uuiM8u8UMlToBKpUFcOrF
         fJIeENfBZMjRxwhCp41/Lr1hKQLZ1MpOaC3eLqbH4E/Nygwx6CST/oMNCA8YsBlmTRds
         pC4nc/ZS1I5Wpyi+Jvodp1DCKKxx+lFaxsKZr7Hv9OwqxSqVj4ToVvu/bcSZ79wx2NsC
         JDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hXaVpGqqToiZNRZTnPuTvkrof7XCekzeFTv2omJ7ql0=;
        b=UkOdQbfUEGjbR0k3HH4GEiDWry/VjMitArrm7QO7aXSnPyl9cEh20fo3hB5JmORjnT
         VQYIMffLxFp+DhEZGdam1DLiGTDLFkdBk8DpOtGT2rtbszouNJmx9ZyH9sQem9yrkStn
         kN8abPi/COzHlP/a5M61VtWo8w9v8S5v9QX2s/OSYJ+2K9ra+LwuqaMSCwPsGSbmVLxV
         iy6legj25x6Kg88I1xi8/1bOBpMRF+YNh5utRyxdafUxlXHmRT7lEFCqQ8cHajBMSyNc
         4oMmgsBl7tMp48h3eynIJUcUwAsJvf8zGEmLKopB0D2OJjR7Hb4qykZYkt1WXRKXkpo3
         0j0A==
X-Gm-Message-State: APjAAAUucx/AL9RFKFYeAB3SIkTu/cdnzLfHW6MBjgvUmch2jZ9e6SsZ
        63VWpuJ4TlpOch0Frz36Btw=
X-Google-Smtp-Source: APXvYqwxOz7TcqcZHlxZvIwAhRTMOv71Kh2lq5ds/sJrRN+gLo3gAg1qrBsMDgHGW+J5GHFRBrZ/nw==
X-Received: by 2002:a0c:e453:: with SMTP id d19mr231732qvm.217.1582093601083;
        Tue, 18 Feb 2020 22:26:41 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id o55sm499907qtf.46.2020.02.18.22.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 22:26:39 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7B4442205E;
        Wed, 19 Feb 2020 01:26:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 19 Feb 2020 01:26:38 -0500
X-ME-Sender: <xms:HNVMXp7LrrTPuhN0Igae75mS0dN9wZdr28TqfaqxQ_aqRcq_2TE_tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeelgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheeh
    vddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:HNVMXnc9lW4f6OV-RucTKrFWMmhqgp7eESkidpAVBHz1KgM1KAIBfw>
    <xmx:HNVMXhokVVojT3ZkuVyNXETW7xskL3mpX_8v04OZEjFuVH4TW5wbag>
    <xmx:HNVMXr3P4KQQCXxN2aWDWPEtZmpi9T6cB8GS5-gz9Fpvad5pGwy2PQ>
    <xmx:HtVMXoyH-1ADIS0oWXhEiwfArNuM0HIQW9F9iGvdMgSVgjPclSYKcJRiz3E>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC32D328005E;
        Wed, 19 Feb 2020 01:26:35 -0500 (EST)
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
Subject: [RFC v2 2/4] Documentation/locking/atomic: Introduce atomic-tests directory
Date:   Wed, 19 Feb 2020 14:26:25 +0800
Message-Id: <20200219062627.104736-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219062627.104736-1-boqun.feng@gmail.com>
References: <20200219062627.104736-1-boqun.feng@gmail.com>
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

