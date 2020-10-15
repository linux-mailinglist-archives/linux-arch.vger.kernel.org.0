Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AF328F036
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 12:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgJOKa6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Oct 2020 06:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgJOKa6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Oct 2020 06:30:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCF1C061755;
        Thu, 15 Oct 2020 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O4GUwatL/SA++hNZdmVAzix9x94iEcyufXftp4wfECg=; b=1uV0QwkzVV+ezKEwvYO3W9UF7C
        RCxyegvTcG/n2iZ381RyIkaoU6hOhoNmeBOxlZGKueJyiK3zedu3tQzTmgYWlSIf0l9uYTFAobcE3
        ICBa7t9ciZCT8km35dDhRmLxv26P+OFLigFmW898f24MbBa8wJCtkhrALUkry5u7pI4pgP04cUuJE
        RkwmX6GX8SBFvbmidj8IY2gc6ADjrE1QriwybXqAE8qAWbIt5rQ5vtkP/rNUhi/fbDJf/DInBw7gi
        L4EPrrCHLr63K1Z8SqXUY9LAvi+iXKPX7WlsnGxF0mlXLP7Y4cCW3MA0HPCwN5SBBU1uCwY+U7tF7
        l+wmFk0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT0X1-00086c-1m; Thu, 15 Oct 2020 10:30:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43D0A300DAE;
        Thu, 15 Oct 2020 12:30:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3179020325EC4; Thu, 15 Oct 2020 12:30:45 +0200 (CEST)
Date:   Thu, 15 Oct 2020 12:30:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/24] tools: docs: memory-model: fix references for
 some files
Message-ID: <20201015103045.GC2611@hirez.programming.kicks-ass.net>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <44baab3643aeefdb68f1682d89672fad44aa2c67.1602590106.git.mchehab+huawei@kernel.org>
 <20201013163354.GO3249@paulmck-ThinkPad-P72>
 <20201013163836.GC670875@rowland.harvard.edu>
 <20201014015840.GR3249@paulmck-ThinkPad-P72>
 <20201014185720.GA28761@paulmck-ThinkPad-P72>
 <20201015071518.5d9f8dc1@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015071518.5d9f8dc1@coco.lan>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 15, 2020 at 07:15:18AM +0200, Mauro Carvalho Chehab wrote:
> I guess there might be some misunderstanding here. My fault. The plan
> is to have zero doc warnings for 5.10[1].

I'd be glad to help and convert all the documentation under my
maintainership to .txt files for you.
