Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7D176FBEB
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 10:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjHDI0W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 04:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbjHDI0Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 04:26:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CF830C4;
        Fri,  4 Aug 2023 01:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=kq8uP/RsR+7bhx2IAz3Uus90BPpjASz0BJ8o6o6e7xE=; b=SNGpYDKg1GXgROFtj1qyUocW3P
        DzcvRBVkASTUm6mXfZdgI3BUnzEiHK/Q+AEKzO5zToLgvHE+HqjW9bvreC63GMRO1b7tjWmZvAiMz
        /CaRLE+JSwa/qCAhTdHSUHMn1hrJyVBiKWLdKAICfk8Qt2NMTrVOk8Z282jbj6iNUZosKzJbrGaj1
        aOVheZ9mqZFSL0FPM44NEnhGTCy/6Kg5d8Xw8Hbxf3s1wWEP6x+rww4kA+Lq8QmiOITY5pkVHe4ol
        v555T12C38JxBrNGeAKdxqqvPWMDbTBAyOmXllytT/bGYC01oqcehuHJnI7EuMBraHqoov81MTB+/
        KNIiPj3Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRq7o-000EKt-1D;
        Fri, 04 Aug 2023 08:25:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA22F30007E;
        Fri,  4 Aug 2023 10:25:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7AF42107C443; Fri,  4 Aug 2023 10:25:31 +0200 (CEST)
Date:   Fri, 4 Aug 2023 10:25:31 +0200
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
Message-ID: <20230804082531.GL212435@hirez.programming.kicks-ass.net>
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210514200743.3026725-4-alex.kogan@oracle.com>
 <ZMrjPWdWhEhwpZDo@gmail.com>
 <20230803085004.GF212435@hirez.programming.kicks-ass.net>
 <CAJF2gTQFZEpHK45hd9HXxHxJc4gaCuDQ4wZ2adDzHwGQjA6VFw@mail.gmail.com>
 <20230803115610.GC214207@hirez.programming.kicks-ass.net>
 <CAJF2gTQkZ_dVgrdyxRjb=HHgMkBxCkJy0cX_C-FF_ZSQ1ODj-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTQkZ_dVgrdyxRjb=HHgMkBxCkJy0cX_C-FF_ZSQ1ODj-g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 04, 2023 at 09:33:48AM +0800, Guo Ren wrote:
> On Thu, Aug 3, 2023 at 7:57 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > CNA should only show a benefit when there is strong inter-node
> > contention, and in that case it is typically best to fix the kernel side
> > locking.
> >
> > Hence the question as to what lock prompted you to look at this.
> I met the long lock queue situation when the hardware gave an overly
> aggressive store queue merge buffer delay mechanism. See:
> https://lore.kernel.org/linux-riscv/20230802164701.192791-8-guoren@kernel.org/

*groan*, so you're using it to work around 'broken' hardware :-(

Wouldn't that hardware have horrifically bad lock throughput anyway?
Everybody would end up waiting on that store buffer delay.

> This also let me consider improving the efficiency of the long lock
> queue release. For example, if the queue is like this:
> 
> (Node0 cpu0) -> (Node1 cpu64) -> (Node0 cpu1) -> (Node1 cpu65) ->
> (Node0 cpu2) -> (Node1 cpu66) -> ...
> 
> Then every mcs_unlock would cause a cross-NUMA transaction. But if we
> could make the queue like this:

See, this is where the ARM64 WFE would come in handy; I don't suppose
RISC-V has anything like that?

Also, by the time you have 6 waiters, I'd say the lock is terribly
contended and you should look at improving the lockinh scheme.
