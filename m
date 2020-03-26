Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 140DC19360F
	for <lists+linux-arch@lfdr.de>; Thu, 26 Mar 2020 03:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgCZCku (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Mar 2020 22:40:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36032 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgCZCku (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Mar 2020 22:40:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id m33so4147771qtb.3;
        Wed, 25 Mar 2020 19:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymOtg1zY13/0gvEuEv8PYty/GwrY16D/sS/lvSTOBKg=;
        b=A+lTHgkvL6IQV2vhGnqWuyJSOMgPPT41ZEW/gMH3jYzlThqIQR7Mba7GpNsIBCA6Tl
         gfUriisjXlyGpJUYHPCt7WKeQvs1n9ev7Y1mACqavbq9XUxV/BPIMGS1lB6lVZ3hzTlb
         Vm/4R9OIy6qPVluf0WIANdvNXZSDJDz89hLq1euun7qFkWH5wd59YBGpXM0E5Q9qcSML
         ClOkJue5bSF7yhnBZ7cALVCZSdOBlECvAnKUa96sOBbAFwkUvMVZCWwYoQbyjlTXF6B6
         72OwG0Gvwr6o5HjIHC5D6DDtDIlO5jD9i8CvdDbyZNMgCz+jJLnxFaXP2wHljdwDkc8c
         F31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymOtg1zY13/0gvEuEv8PYty/GwrY16D/sS/lvSTOBKg=;
        b=jL60/jTkNxM9Q/+XeTMMAL5F43jSchQNfTPp98/vT1usAVHa/2VMasAipaXAXBQM6n
         JtwU5BcyxFtwkjEOAf9KqiMFdl+neROa7Q1LdtpkveaXU1ZxYM36+f+2cPVBKvH4a/CH
         RlMYwyHZ7IOYCHsX3o9MdRh0NX5F1ZofT4Evcda9m+BsZ87Q7CLZuHSHmgnJsUcV15oX
         9jw8IvaEqzX2xdwIKNnzRqPFkiLP7w45vijmPDetEQAKRvxbI6hM4Dd1Q0SlAMtqXw6x
         KkQG6zdZBG5vGZc1WlZN7hdophzjwwcEjW8/yPGVpmv+IkBIO/1y2L/gmBgSd7bgLf52
         aSvQ==
X-Gm-Message-State: ANhLgQ3q+cNsC6P0qQg2STGnZIgxAq3yJ4SgzSKVl4AlERR8ULchK2d5
        w2Pfhd/UGvwjIuwERu+kMhQ=
X-Google-Smtp-Source: ADFU+vvqu6Oc5Lvz+hNS1j/pYRoEZ0WdkdBFrSuLGkJb1hbfunbCls7GF1rTZY8fL810+etLbY2Vnw==
X-Received: by 2002:ac8:7a72:: with SMTP id w18mr6004923qtt.260.1585190449103;
        Wed, 25 Mar 2020 19:40:49 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id f201sm518969qke.119.2020.03.25.19.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 19:40:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A824127C0054;
        Wed, 25 Mar 2020 22:40:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Mar 2020 22:40:47 -0400
X-ME-Sender: <xms:LxZ8XjyXfZdteMYXVlH-i_US2S7bjjQ0Utitsx9rc-_cMICyUGEOnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehhedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeehvd
    drudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghi
    lhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:LxZ8Xmzfu2xIzZF5XB5itoBipk72YRpv7wn8FqIznBeLMybrFomuzQ>
    <xmx:LxZ8XjxT6ju9ZzINVhBejnWmLduhYAZ27g1ZG_mSmziLqRnDuVGHzw>
    <xmx:LxZ8XoYV8wGRbLsEiU5GKtEwQSXD8nc4hxebjDBbLcdLfgtphIoSPg>
    <xmx:LxZ8XmrHZSNBbuyxkRK2HHbYxlJTaCh1i-eEgRnhwh884AY0XbZ_T_13IR0>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 242CC328005A;
        Wed, 25 Mar 2020 22:40:46 -0400 (EDT)
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
        Joel Fernandes <joel@joelfernandes.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 2/4] Documentation/litmus-tests: Introduce atomic directory
Date:   Thu, 26 Mar 2020 10:40:20 +0800
Message-Id: <20200326024022.7566-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326024022.7566-1-boqun.feng@gmail.com>
References: <20200326024022.7566-1-boqun.feng@gmail.com>
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

Therefore, introduce the atomic directory for this purpose. The
directory is maintained by the LKMM group to make sure the litmus tests
are always aligned with our memory model.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
---
 Documentation/litmus-tests/atomic/README | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 Documentation/litmus-tests/atomic/README

diff --git a/Documentation/litmus-tests/atomic/README b/Documentation/litmus-tests/atomic/README
new file mode 100644
index 000000000000..ae61201a4271
--- /dev/null
+++ b/Documentation/litmus-tests/atomic/README
@@ -0,0 +1,4 @@
+This directory contains litmus tests that are typical to describe the semantics
+of our atomic APIs. For more information about how to "run" a litmus test or
+how to generate a kernel test module based on a litmus test, please see
+tools/memory-model/README.
-- 
2.25.1

