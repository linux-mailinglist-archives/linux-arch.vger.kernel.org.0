Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF2828D828
	for <lists+linux-arch@lfdr.de>; Wed, 14 Oct 2020 03:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgJNB6l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Oct 2020 21:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgJNB6l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Oct 2020 21:58:41 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F0C721D7F;
        Wed, 14 Oct 2020 01:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602640720;
        bh=gsQXg/Wr/5qYlMS+P7kGnf949bK69OfahNw1f6kbQn0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zXiI++IfkMkVnClheHjnLnr8M7OJtmmt3kckkVfr5t+aCUbVnldusWFt7GWUWEhsJ
         ScIVUlvbp2RY5bmXCpWpBmSabId2HAYMWriDZBOZc81eNi2hsejhRUpUCFdZNFBbRV
         BASo2ZuLHbPvKnd1Xr9kzNLYcKuzZORI/5gY3qus=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5725335229EE; Tue, 13 Oct 2020 18:58:40 -0700 (PDT)
Date:   Tue, 13 Oct 2020 18:58:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/24] tools: docs: memory-model: fix references for
 some files
Message-ID: <20201014015840.GR3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <44baab3643aeefdb68f1682d89672fad44aa2c67.1602590106.git.mchehab+huawei@kernel.org>
 <20201013163354.GO3249@paulmck-ThinkPad-P72>
 <20201013163836.GC670875@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013163836.GC670875@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 13, 2020 at 12:38:36PM -0400, Alan Stern wrote:
> On Tue, Oct 13, 2020 at 09:33:54AM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 13, 2020 at 02:14:29PM +0200, Mauro Carvalho Chehab wrote:
> > > - The sysfs.txt file was converted to ReST and renamed;
> > > - The control-dependencies.txt is not at
> > >   Documentation/control-dependencies.txt. As it is at the
> > >   same dir as the README file, which mentions it, just
> > >   remove Documentation/.
> > > 
> > > With that, ./scripts/documentation-file-ref-check script
> > > is now happy again for files under tools/.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > 
> > Queued for review and testing, likely target v5.11.
> 
> Instead of changing the path in the README reference, shouldn't 
> tools/memory-model/control-dependencies.txt be moved to its proper 
> position in .../Documentation?

You are of course quite right.  My thought is to let Mauro go ahead,
given his short deadline.  We can then make this "git mv" change once
v5.10-rc1 comes out, given that it should have Mauro's patches.  I have
added a reminder to my calendar.

							Thanx, Paul
