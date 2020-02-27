Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3025170D76
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 01:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgB0AsM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 19:48:12 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32884 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgB0AsL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 19:48:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id h4so1577926qkm.0;
        Wed, 26 Feb 2020 16:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gr+D98EMRaRIJKN/JWg/ytMLQclg5vcpIgvUjBahKFw=;
        b=mFNgTWxSG0BZzVRNZWK+XeIyD5Be19QfNA+007QbPsQj85rI73YDpTHFH7AxBtcFE9
         CjWO7tfJOWPJphs43zGynDj9ejms0wCl1HKsiWJ2MtJ2m4GPTZsKoazVPuE+81TabdyK
         WLzpA+9n7nhcgp++K6avHmtvS+eYmeVH3XcasEndKFPdSca59EI1kRs+xgIJfODxlTPU
         1DvbXp2nZYI9WOZeePLPMPCNq79SrYXmhwGTYRIJ8VY6Uj6g/pHtzz99kdPtTfzMS7vq
         fo4N1f7Xngb0LfwCMpPaWR9+Y4sC3mCYlcDF5lP6xQEZ3+DzyVHjBWz8Kr05R/0jeH9n
         WqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gr+D98EMRaRIJKN/JWg/ytMLQclg5vcpIgvUjBahKFw=;
        b=Jr9Hyvi3hhziEA2dHGNaJ+oMNXgEnau4yQgeKQW/WD3Q04HpNjNMb6OQFHI3yMxnir
         OG1pBfRHA5IPlCfzUUWCTn1kx4P5P8JsVIXS1K9u/RvilvGUTclV2Y3lAZIN0Btp+qiJ
         oBCLTHRA1i3DLLPOH2NqRQ4hpOGX7IPibv7ohRiBQ+uhSAIyVS3+ewbaTZrbSU3Cio2S
         CkLnYR5poHrNCS6NbHrRUCF2h+RF33YXvqZoytGkZK1321U4VipfFuq7JuWJxFG1488e
         BtwCcfSX7lBb/QUcaedhYyrNIzxlXPbX0lZ4Ve5oczXRQPdHBAx6dL+Lpq+yJ5Jp3s1M
         ifZg==
X-Gm-Message-State: APjAAAUX4t94GFraRGDDNB2Goru5pgYqMh/cat+f0Eg0Xuf9uU2xY9g9
        kuOonQzsg2WoaDtJIlwQ/uHKz+8l4E8=
X-Google-Smtp-Source: APXvYqyhdCN1wifCOHvDfb4k//7u4CpgetuW3MDqY7fF8a9PUzxLymX7b8kaKkNV3mYT7HWieyPQ5Q==
X-Received: by 2002:ac8:4659:: with SMTP id f25mr1726677qto.273.1582764062492;
        Wed, 26 Feb 2020 16:41:02 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id l184sm2077416qkc.107.2020.02.26.16.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 16:41:01 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id EA18021F82;
        Wed, 26 Feb 2020 19:41:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Feb 2020 19:41:00 -0500
X-ME-Sender: <xms:HBBXXvbCTTK_UjhpVYH7mVeGHkLR0bRyKTbWWpaM__TyyN7EtZ7SYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleehgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgpdhinhhrihgrrdhfrhenucfkphephedvrdduheehrdduuddurdej
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:HBBXXvobr3L1vCf8vIPiu-0nb_oyR_IZp2b_EE8jppvGLEKn-oUZZg>
    <xmx:HBBXXgqHDVyuFsibrsdb9PvLmP6GvQ0ddeIuQ90OKjd7yeUHTehicw>
    <xmx:HBBXXnucsHPA3_Nj4vmhtRxq5YJl6inTho9WPKGIqX-pMnSCD53i3w>
    <xmx:HBBXXoq3adymewn2X4V08gmnHAU3bENxuKoqE9khMCZ3cN4QcHbdNKl9ukI>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9D30D328005A;
        Wed, 26 Feb 2020 19:40:59 -0500 (EST)
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
Subject: [PATCH v3 0/5] Documentation/locking/atomic: Add litmus tests for atomic APIs
Date:   Thu, 27 Feb 2020 08:40:44 +0800
Message-Id: <20200227004049.6853-1-boqun.feng@gmail.com>
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
tests for atomic APIs. And based on the previous discussion, I create a
new directory Documentation/atomic-tests and put these litmus tests
here.

This patchset starts the work by adding the litmus tests which are
already used in atomic_t.txt, and also improve the atomic_t.txt to make
it consistent with the litmus tests.

Previous version:
v1: https://lore.kernel.org/linux-doc/20200214040132.91934-1-boqun.feng@gmail.com/
v2: https://lore.kernel.org/lkml/20200219062627.104736-1-boqun.feng@gmail.com/

Changes since v2:

*	Change from "RFC" to "PATCH".

*	Wording improvement in atomic_t.txt as per Alan's suggestion.

*	Add a new patch describing the usage of atomic_add_unless() is
	not limited anymore for LKMM litmus tests.

My PR on supporting "(void) expr;" statement has been merged by Luc
(Thank you, Luc). So all the litmus tests in this patchset can be
handled by the herdtools compiled from latest master branch of the
source code.

Comments and suggestions are welcome!

Regards,
Boqun

[1]: http://diy.inria.fr/doc/litmus.html#klitmus

Boqun Feng (5):
  tools/memory-model: Add an exception for limitations on _unless()
    family
  Documentation/locking/atomic: Fix atomic-set litmus test
  Documentation/locking/atomic: Introduce atomic-tests directory
  Documentation/locking/atomic: Add a litmus test for atomic_set()
  Documentation/locking/atomic: Add a litmus test smp_mb__after_atomic()

 ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
 ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++
 Documentation/atomic-tests/README             | 16 ++++++++++
 Documentation/atomic_t.txt                    | 24 +++++++-------
 MAINTAINERS                                   |  1 +
 tools/memory-model/README                     | 10 ++++--
 6 files changed, 92 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
 create mode 100644 Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
 create mode 100644 Documentation/atomic-tests/README

-- 
2.25.0

