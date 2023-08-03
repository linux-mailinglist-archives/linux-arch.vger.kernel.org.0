Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44B876E39B
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 10:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjHCIus (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Aug 2023 04:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjHCIur (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Aug 2023 04:50:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9393FEA;
        Thu,  3 Aug 2023 01:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Bkf1eqstwa5u7IuR/ir8LatugZOUdwgShvLIz5Uv3I=; b=hIVtD9Otlp2gKLttDQGNytCrfX
        4SFxgkulD9iABSeDR7gRbTHicg3RFD0zx0p66Wuj1LV+8AfQKxog31nlOwx8QkIZe3wu/QP7yA2f8
        ZYISM/I5Z6t1D4I1SlfS2Pf57VhYcR1gOp2W/+ruh0NzQFFLVmwsMrx/3iOGiBW+kpZiqqnFlvkNB
        tY/Twau+TVEgJZr29pi5Cehf77JtxFjpsI/8dL48w04zGIQqhHyy3gQLR2PjVT9HkrVzhaEJBFzRx
        MfS1jNywhbEndtqkCwHNstGEOwwjzvfn7W+0pPla9+tHGOeoFgB8U+dIjIyNKHxoIm15P2ozdCI4+
        ugRL7dgA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRU21-002bDp-P8; Thu, 03 Aug 2023 08:50:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03D7030007E;
        Thu,  3 Aug 2023 10:50:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE2B4205963BA; Thu,  3 Aug 2023 10:50:04 +0200 (CEST)
Date:   Thu, 3 Aug 2023 10:50:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Subject: Re: [PATCH v15 3/6] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20230803085004.GF212435@hirez.programming.kicks-ass.net>
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210514200743.3026725-4-alex.kogan@oracle.com>
 <ZMrjPWdWhEhwpZDo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMrjPWdWhEhwpZDo@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 02, 2023 at 07:14:05PM -0400, Guo Ren wrote:

> The pv_ops is belongs to x86 custom frame work, and it prevent other
> architectures connect to the CNA spinlock.

static_call() exists as a arch neutral variant of this.

> I'm working on riscv qspinlock on sg2042 64 cores 2/4 NUMA nodes
> platforms. Here are the patches about riscv CNA qspinlock:
> https://lore.kernel.org/linux-riscv/20230802164701.192791-19-guoren@kernel.org/
> 
> What's the next plan for this patch series? I think the two-queue design
> has satisfied most platforms with two NUMA nodes.

What has been your reason for working on CNA? What lock has been so
contended you need this?
