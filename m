Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071AB4268A0
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 13:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbhJHLYE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 07:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbhJHLYD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Oct 2021 07:24:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB24C061570
        for <linux-arch@vger.kernel.org>; Fri,  8 Oct 2021 04:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=yKKSjQPEnCfcZmt5gUs0/OGmQc6HpFW+TX3lGOKtFIA=; b=k+IHGVPAZOqkcmZukn/zWFMXoM
        ZsHwklLO0eb9YmTp01zAApO+oBahjAfNKIU0CZLwIC6/FO3hAj0BnhJ/TfRLSHyqcenNgte4mqfec
        yU6uhUkPeQFTaJrkjYYAys2ay9C+yaxEjdOWlVYSZuEZY4Vi73F6mZLlDg5RkutOH8p4eW2cxKZkM
        JQfP2TQIE0NDBdAQeDXiSFUN84Gwjvnn+dg2n5Y5JNLzrjgq3YHPk7jkCN9Elu1hT0GtvjwPumNfr
        3odHdRZfcSHYbVEZcBq2Cj5889IAyLJcMuWLOzcR2JwijoywebOohtOYny5+RenAJuwX8bx99OuHR
        4/3N+GJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYnsH-0032ft-KN; Fri, 08 Oct 2021 11:17:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06BCD302A13;
        Fri,  8 Oct 2021 13:17:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D699F2DB84A66; Fri,  8 Oct 2021 13:17:07 +0200 (CEST)
Message-ID: <20211008111626.151570317@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Oct 2021 13:15:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com,
        mark.rutland@arm.com, axboe@kernel.dk, metze@samba.org,
        laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, jpoimboe@redhat.com,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net
Subject: [PATCH 2/7] leaking_addresses: Always print a trailing newline
References: <20211008111527.438276127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

For files that lack trailing newlines and match a leaking address (e.g.
wchan[1]), the leaking_addresses.pl report would run together with the
next line, making things look corrupted.

Unconditionally remove the newline on input, and write it back out on
output.

[1] https://lore.kernel.org/all/20210103142726.GC30643@xsang-OptiPlex-9020/

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/leaking_addresses.pl |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -455,8 +455,9 @@ sub parse_file
 
 	open my $fh, "<", $file or return;
 	while ( <$fh> ) {
+		chomp;
 		if (may_leak_address($_)) {
-			print $file . ': ' . $_;
+			printf("$file: $_\n");
 		}
 	}
 	close $fh;


