Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106B376E781
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 13:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbjHCL52 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Aug 2023 07:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbjHCL50 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Aug 2023 07:57:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567FD2D71;
        Thu,  3 Aug 2023 04:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=cO/uLPmilqipGwZoOwvAvBoyxkuyIOj2yUkU6KfTz7s=; b=qHllbgqNWzBcNIH4ZGYGaAGIW0
        khm+1RvfI+4PbyLkbFmvrTIC6/VmgVC27qgb4qIxoElmksURq9oAYXYRuiXQl/Q7iyZyqCiI0+JHj
        UJccFnJTHT5Ssw0mFm7Xmqew0JTIPqTMLGbDD7VCy5DuXp5BFcGCRaUX5MWCXPWk51/JxORUVVoLp
        N9/eUDaTN447e2aA8Grnwx1BKJaLdkYs6wjwkyRR4c+EXbxQ8celhv9RvoAZKTLB1Lr86D9gSoAHV
        qi9SNsSrgkap72uU35CGStE4sBIQdmLWFwphElzj2Gu9nx3poPpnTx1Aa5O6keODRFYciXB43NUfJ
        tnrt6g6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRWw8-00GnqP-1a;
        Thu, 03 Aug 2023 11:56:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A774300301;
        Thu,  3 Aug 2023 13:56:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F21A6205EA3E6; Thu,  3 Aug 2023 13:56:10 +0200 (CEST)
Date:   Thu, 3 Aug 2023 13:56:10 +0200
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
Message-ID: <20230803115610.GC214207@hirez.programming.kicks-ass.net>
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210514200743.3026725-4-alex.kogan@oracle.com>
 <ZMrjPWdWhEhwpZDo@gmail.com>
 <20230803085004.GF212435@hirez.programming.kicks-ass.net>
 <CAJF2gTQFZEpHK45hd9HXxHxJc4gaCuDQ4wZ2adDzHwGQjA6VFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTQFZEpHK45hd9HXxHxJc4gaCuDQ4wZ2adDzHwGQjA6VFw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 03, 2023 at 06:28:51PM +0800, Guo Ren wrote:
> On Thu, Aug 3, 2023 at 4:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Aug 02, 2023 at 07:14:05PM -0400, Guo Ren wrote:
> >
> > > The pv_ops is belongs to x86 custom frame work, and it prevent other
> > > architectures connect to the CNA spinlock.
> >
> > static_call() exists as a arch neutral variant of this.
> Emm... we have used static_call() in the riscv queued_spin_lock_:
> https://lore.kernel.org/all/20230802164701.192791-20-guoren@kernel.org/

Yeah, I think I saw that land in the INBOX, just haven't had time to
look at it.

> But we met a compile problem:
> 
>   GEN     .vmlinux.objs
>   MODPOST Module.symvers
> ERROR: modpost: "__SCK__pv_queued_spin_unlock" [arch/riscv/kvm/kvm.ko]
> undefined!
> ERROR: modpost: "__SCK__pv_queued_spin_unlock"
> [kernel/locking/locktorture.ko] undefined!
> ERROR: modpost: "__SCK__pv_queued_spin_unlock" [mm/z3fold.ko] undefined!
> ERROR: modpost: "__SCK__pv_queued_spin_unlock"
> [fs/nfs_common/grace.ko] undefined!
> ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/quota/quota_v1.ko] undefined!
> ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/quota/quota_v2.ko] undefined!
> ERROR: modpost: "__SCK__pv_queued_spin_unlock"
> [fs/quota/quota_tree.ko] undefined!
> ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/fuse/virtiofs.ko] undefined!
> ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/dlm/dlm.ko] undefined!
> ERROR: modpost: "__SCK__pv_queued_spin_unlock" [fs/fscache/fscache.ko]
> undefined!
> WARNING: modpost: suppressed 839 unresolved symbol warnings because
> there were too many)
> /home/guoren/source/kernel/linux/scripts/Makefile.modpost:144: recipe
> for target 'Module.symvers' failed
> 
> Our solution is:
> EXPORT_SYMBOL(__SCK__pv_queued_spin_unlock);
> 
> What do you think about it?

Could be you're not using static_call_mod() to go with
EXPORT_STATIC_CALL_TRAMP()

> > > I'm working on riscv qspinlock on sg2042 64 cores 2/4 NUMA nodes
> > > platforms. Here are the patches about riscv CNA qspinlock:
> > > https://lore.kernel.org/linux-riscv/20230802164701.192791-19-guoren@kernel.org/
> > >
> > > What's the next plan for this patch series? I think the two-queue design
> > > has satisfied most platforms with two NUMA nodes.
> >
> > What has been your reason for working on CNA? What lock has been so
> > contended you need this?
> I wrote the reason here:
> https://lore.kernel.org/all/20230802164701.192791-1-guoren@kernel.org/
> 
> The target platform is: https://www.sophon.ai/
> 
> The two NUMA nodes platform has come out, so we want to measure the
> benefit of CNA qspinlock.

CNA should only show a benefit when there is strong inter-node
contention, and in that case it is typically best to fix the kernel side
locking.

Hence the question as to what lock prompted you to look at this.
