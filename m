Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C043D8ECA
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 15:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbhG1NRT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 09:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbhG1NRS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 09:17:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE02CC061757
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JrvGjfPAcBIp389ohn/pC99ba/JbmExoS2klLMmDpek=; b=amrCCDAdYSizLReXxHNpwYbOl7
        SdTeGjWXZ6Z0BEv8u4PktY6zsbDiYZY4Eu3owcyp/Z2UgApmn4+F66wj5YjQonJ+/JRxui9nc3rP7
        ZPODKxgAb3Dru7nTlfzIHflopDdwforoTs9EVeZO4xrH3d59dcwYaBEi8MaJN62zkSjZINMTgbqc+
        iuab+a5Z/YjotlPFAm2m0GxqiTtwEJQhi4L8k3jz9qejwNFh/rjVKwCrD8OWxKfDFpGQi/uudIbiL
        nlnuXczWIXEDCw/8HUWJpzdJsIrPXOQX6o8439PRh+eti1fqFk5hmBvE8oJ+ey49ThcWyFvmmZJ6K
        8foh0bWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8jQe-003j1O-9u; Wed, 28 Jul 2021 13:16:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3FBA8300056;
        Wed, 28 Jul 2021 15:16:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F062021071BFE; Wed, 28 Jul 2021 15:16:54 +0200 (CEST)
Date:   Wed, 28 Jul 2021 15:16:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rui Wang <wangrui@loongson.cn>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, hev <r@hev.cc>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
Message-ID: <YQFYxr/2Zr7UclaN@hirez.programming.kicks-ass.net>
References: <20210728114822.1243-1-wangrui@loongson.cn>
 <YQFUe+QsHfBIgQev@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQFUe+QsHfBIgQev@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 28, 2021 at 02:58:35PM +0200, Peter Zijlstra wrote:
> The below isn't quite right, because it'll use try_cmpxchg() for
> atomic_andnot_or(), which by being a void atomic should be _relaxed. I'm
> not entirely sure how to make that happen in a hurry.
> 
> ---

This seems to do the trick.

diff --git a/scripts/atomic/atomics.tbl b/scripts/atomic/atomics.tbl
index fbee2f6190d9..3aaa0caa6b2d 100755
--- a/scripts/atomic/atomics.tbl
+++ b/scripts/atomic/atomics.tbl
@@ -39,3 +39,4 @@ inc_not_zero		b	v
 inc_unless_negative	b	v
 dec_unless_positive	b	v
 dec_if_positive		i	v
+andnot_or		vF	v	i:m	i:o
diff --git a/scripts/atomic/fallbacks/andnot_or b/scripts/atomic/fallbacks/andnot_or
new file mode 100644
index 000000000000..995d80db8578
--- /dev/null
+++ b/scripts/atomic/fallbacks/andnot_or
@@ -0,0 +1,23 @@
+local try_order=${order}
+
+if meta_has_ret "${meta}"; then
+	:;
+else
+	try_order="_relaxed"
+fi
+
+cat <<EOF
+static __always_inline ${ret}
+arch_${atomic}_${pfx}andnot_or${sfx}${order}(${atomic}_t *v, ${int} m, ${int} o)
+{
+	${retstmt}({
+		${int} N, O = atomic_read(v);
+		do {
+			N = O;
+			N &= ~m;
+			N |= o;
+		} while (!arch_${atomic}_try_cmpxchg${try_order}(v, &O, N));
+		O;
+	});
+}
+EOF
diff --git a/scripts/atomic/fallbacks/fetch_andnot_or b/scripts/atomic/fallbacks/fetch_andnot_or
deleted file mode 100644
index e69de29bb2d1..000000000000
