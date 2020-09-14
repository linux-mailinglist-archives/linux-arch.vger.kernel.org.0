Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A20F269008
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgINPeN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 11:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgINPdi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Sep 2020 11:33:38 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92EA0206E9;
        Mon, 14 Sep 2020 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600097617;
        bh=o9KePnSTPTTSMAAlgYgUwisQmlD3kkeuo6nOwFKBhA0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cX/wS9p49mN58z8Ntf3z45/1k9U3k6YQ4FRTak5KWm+3eVajZFRKOjg1X2wTeeL7z
         qAY8jWKaNYrz62BgkkukK+er/r7n6KGvQ9sgPRDmLGDGg51Iixye77lfTI/IdntEmy
         +Czgrlr8hFWeHIr/26lZ62Jn+a6uaD1842P5Y3BI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5E0943522BA0; Mon, 14 Sep 2020 08:33:37 -0700 (PDT)
Date:   Mon, 14 Sep 2020 08:33:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Fox Chen <foxhlchen@gmail.com>, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] docs/memory-barriers.txt: Fix a typo in CPU MEMORY
 BARRIERS section
Message-ID: <20200914153337.GZ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200909065340.118264-1-foxhlchen@gmail.com>
 <20200911140218.GB19961@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911140218.GB19961@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 11, 2020 at 03:02:19PM +0100, Will Deacon wrote:
> On Wed, Sep 09, 2020 at 02:53:40PM +0800, Fox Chen wrote:
> > Commit 39323c6 smp_mb__{before,after}_atomic(): update Documentation
> > has a typo in CPU MEORY BARRIERS section:
> > "RMW functions that do not imply are memory barrier are ..." should be
> > "RMW functions that do not imply a memory barrier are ...".
> > 
> > This patch fixes this typo.
> > 
> > Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> > ---
> >  Documentation/memory-barriers.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index 96186332e5f4..20b8a7b30320 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -1870,7 +1870,7 @@ There are some more advanced barrier functions:
> >  
> >       These are for use with atomic RMW functions that do not imply memory
> >       barriers, but where the code needs a memory barrier. Examples for atomic
> > -     RMW functions that do not imply are memory barrier are e.g. add,
> > +     RMW functions that do not imply a memory barrier are e.g. add,
> >       subtract, (failed) conditional operations, _relaxed functions,
> >       but not atomic_read or atomic_set. A common example where a memory
> >       barrier may be required is when atomic ops are used for reference
> 
> The document remains unreadable, but this is still worth fixing!
> 
> Acked-by: Will Deacon <will@kernel.org>

Queued for v5.11, thank you both!

							Thanx, Paul
