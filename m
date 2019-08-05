Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15986824AC
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2019 20:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfHESJd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Aug 2019 14:09:33 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44634 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727830AbfHESJd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Aug 2019 14:09:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 83E5B8EE1D4;
        Mon,  5 Aug 2019 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1565028570;
        bh=TeqIzmbi+PMBY1Q0mh6iJWLlzVgp3VODPSmCagIjMw8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vK3ym3VKOS0Di2akSCuaLL3r6BbUJXZFvV+dY5vQZNW23eG9yQQRta4V37hctfXJ3
         yhBRcpyFC1QZaURqdvufX17P6/Xnte1DYQ1iZq60SR3jPJ894GlB/E7weUTTT9a4bd
         1DHfZ0b0elHq78wo9zGtqT6HisrJIrGVj73hw2A4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dMRTeZY_Q80E; Mon,  5 Aug 2019 11:09:30 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.71.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 662EC8EE079;
        Mon,  5 Aug 2019 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1565028569;
        bh=TeqIzmbi+PMBY1Q0mh6iJWLlzVgp3VODPSmCagIjMw8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZRWVV8UpYXAIQqlQFFN/gLhwVQXHsjQAtZISwXskPwEQLBMk50h2//zezUIr37EqP
         EmaxA3hD8skwxhzDEl9oU898Qh65YGpCHHcca7UHBXd1F9Ie4fVgYixHdeEhl5hmbH
         0kto3V6Q5r9zo4XDdAu2/eRN3Z6TtqKaML2Tcqjc=
Message-ID: <1565028568.15050.7.camel@HansenPartnership.com>
Subject: Re: [PATCH] MAINTAINERS: Update e-mail address for Andrea Parri
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     paulmck@linux.ibm.com
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>
Date:   Mon, 05 Aug 2019 11:09:28 -0700
In-Reply-To: <20190805174355.GJ28441@linux.ibm.com>
References: <20190805121517.4734-1-parri.andrea@gmail.com>
         <76010b66-a662-5b07-a21d-ed074d7d2194@gmail.com>
         <20190805151545.GA1615@aparri>
         <1565018618.3341.6.camel@HansenPartnership.com>
         <20190805174355.GJ28441@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2019-08-05 at 10:43 -0700, Paul E. McKenney wrote:
> On Mon, Aug 05, 2019 at 08:23:38AM -0700, James Bottomley wrote:
> > On Mon, 2019-08-05 at 17:15 +0200, Andrea Parri wrote:
> > > > Why don't you also add an entry in .mailmap as Will did in
> > > > commit
> > > > c584b1202f2d ("MAINTAINERS: Update my email address to use
> > > > @kernel.org")?
> > > 
> > > I considered it but could not understand its purpose...  Maybe
> > > you can explain it to me?  ;-) (can resend with this change if
> > > needed/desired).
> > 
> > man git-shortlog gives you the gory detail, but its use is to
> > "coalesce together commits by the same person in the shortlog,
> > where their name and/or email address was spelled
> > differently."  The usual way this happens is that people have the
> > name that appears in the From field with and without initials.
> 
> New one on me, thank you!  So I should have a line in .mailmap like
> this?
> 
> Paul E. McKenney <paulmck@linux.vnet.ibm.com> <paul.mckenney@linaro.o
> rg> <paulmck@linux.ibm.com>

Well, you could, but there's no need.  As long as your email has 'Paul
E. McKenney' as the text prefix, git-shortlog will do the correct
aggregation without any need for a .mailmap entry.  However, if, say,
your linaro email had been

Paul McKenney <paul.mckenney@linaro.com>

Then you would need one because git-shortlog would think 'Paul
McKenney' and 'Paul E. McKenney' were two different people.

James

