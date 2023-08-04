Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393217707C0
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 20:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjHDSYW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 14:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjHDSYS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 14:24:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D044C01;
        Fri,  4 Aug 2023 11:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0S9jBZoz5bVwPhGhUBlZgDmYofssuRkGRdTGWffFA4k=; b=DVWPLaFocHBV5YdbyIOimrmowF
        MqVimBeKhGRdAHpQGr3/dLOQeBvqub4KHNCFY4yXVywZzWyJ0yt8+IEhDsHnsSU3YuwEpt5Du8J/A
        g2GkkllBEBpJRWbnRwmg8RNa4AOGnFOSYkkDsTkte3XMeo/TXANopLvnpPu0Ks/PF3W5A1zJMlvog
        oahqJAzmJIXc9lXRVJDngbidVjZV412I8FzqP1yulLdcUSzCRvMnlDgJqw1R7m561SVm9cuuutGvy
        HkQS0bBdRhhj7PCQq8UVH1f5WXahPN+nPbpbM4i6MIxROtLGPienYbmWak8dY43B1SSHB8nNujUoL
        8rQhHX0Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRzSD-00BMx5-JC; Fri, 04 Aug 2023 18:23:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB097300235;
        Fri,  4 Aug 2023 20:23:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F7EC21FA7B4A; Fri,  4 Aug 2023 20:23:12 +0200 (CEST)
Date:   Fri, 4 Aug 2023 20:23:12 +0200
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
Message-ID: <20230804182312.GO212435@hirez.programming.kicks-ass.net>
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210514200743.3026725-4-alex.kogan@oracle.com>
 <ZMrjPWdWhEhwpZDo@gmail.com>
 <20230803085004.GF212435@hirez.programming.kicks-ass.net>
 <CAJF2gTQFZEpHK45hd9HXxHxJc4gaCuDQ4wZ2adDzHwGQjA6VFw@mail.gmail.com>
 <20230803115610.GC214207@hirez.programming.kicks-ass.net>
 <CAJF2gTQkZ_dVgrdyxRjb=HHgMkBxCkJy0cX_C-FF_ZSQ1ODj-g@mail.gmail.com>
 <20230804082531.GL212435@hirez.programming.kicks-ass.net>
 <CAJF2gTQ77R1embGm4kR5THcYnzk0zOJ9LOn1z=z2g7FuFN239g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQ77R1embGm4kR5THcYnzk0zOJ9LOn1z=z2g7FuFN239g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 04, 2023 at 10:17:35AM -0400, Guo Ren wrote:

> > See, this is where the ARM64 WFE would come in handy; I don't suppose
> > RISC-V has anything like that?
> Em... arm64 smp_cond_load only could save power consumption or release
> the pipeline resources of an SMT processor. When (Node1 cpu64) is in
> the WFE state, it still needs (Node0 cpu1) to write the value to give
> a cross-NUMA signal. So I didn't see what WFE related to reducing
> cross-Numa transactions, or I missed something. Sorry

The benefit is that WFE significantly reduces the memory traffic. Since
it 'suspends' the core and waits for a write-notification instead of
busy polling the memory location you get a ton less loads.

