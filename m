Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317BF25AB60
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 14:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgIBMrj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 08:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgIBMrh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Sep 2020 08:47:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D75C061244;
        Wed,  2 Sep 2020 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R5emDCN9N+tW0SHI20K3hMIZd+UDNfkLh7iRsInsea8=; b=B7mS5Yxdq0lOp/JdxuBG2tf0d5
        c/h+WDVvE7ES/O7GnGA8tH4moh+pjEdRhSrwSzMxz4ufJKcMC0CfwcaK3mEH1TMqYtnjvJKuuFLXY
        8yBXXwZfaXkugcfom75sM2ogbzidgzxx1i9gAPt1peE33bhXpp2amdmUlCFfbT2Rh46nyNuZctJBj
        /W69r8SQ2N/M2a7VedMWmqVeMLupoWzcm0MxyS2kXb7zPS7BLFE1FZ0gEwE23nf5miRRSdT60Vqlv
        QGsKbcqUP1oArmBTq43iLXi+rK6aPBJvFtLO5NQlm3CoQKx/r7Xukhzyb4xpaltHN5kvmOaT7gZRr
        XpX6oIAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDSAh-0003qC-3I; Wed, 02 Sep 2020 12:47:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 893843011C6;
        Wed,  2 Sep 2020 14:47:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7979F23D3D72C; Wed,  2 Sep 2020 14:47:25 +0200 (CEST)
Date:   Wed, 2 Sep 2020 14:47:25 +0200
From:   peterz@infradead.org
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 6/9] tools/memory-model: Expand the cheatsheet.txt
 notion of relaxed
Message-ID: <20200902124725.GF1362448@hirez.programming.kicks-ass.net>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-6-paulmck@kernel.org>
 <20200902035448.GC49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200902101412.GC1362448@hirez.programming.kicks-ass.net>
 <20200902123715.GD49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902123715.GD49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 02, 2020 at 08:37:15PM +0800, Boqun Feng wrote:
> On Wed, Sep 02, 2020 at 12:14:12PM +0200, peterz@infradead.org wrote:

> > > To be accurate, atomic_set() doesn't return any value, so it cannot be
> > > ordered against DR and DW ;-)
> > 
> > Surely DW is valid for any store.
> > 
> 
> IIUC, the DW colomn stands for whether the corresponding operation (in
> this case, it's atomic_set()) is ordered any write that depends on this
> operation. I don't think there is a write->write dependency, so DW for
> atomic_set() should not be Y, just as the DW for WRITE_ONCE().

Ah, just shows I can't read I suppose ;-) I thought we were talking of
the other side of the depency.
