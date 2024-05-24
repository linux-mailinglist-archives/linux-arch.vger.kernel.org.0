Return-Path: <linux-arch+bounces-4524-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A638CE6BF
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 16:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F729B21983
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECF12C46D;
	Fri, 24 May 2024 14:14:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4FBD712C47A
	for <linux-arch@vger.kernel.org>; Fri, 24 May 2024 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560069; cv=none; b=sgIE1/fiQ1nhjaYnK/vckTQ0Z5Lk6D/VVBUigI80KJUtKIS1WOi5X1M0iRFEp6hcOhoKHHZYvanp10XFJ20CyoeXz4SqqaaY0lnN4V81qyPUQlPITWWP8R5g0IlFOlK03kRQn2Pb6yxjzSrEIbfpE+zsBukNRahuHhRKAGSRQx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560069; c=relaxed/simple;
	bh=W/QFZgZjVK4PgDuIaqIeI+JhOty3H64BskYsUZZh49w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6+cueFHtfm0TMYjUN/oTTPa6Ko5AqYpKyd6KqVMrQj879pXsmVgykmgTXSr5v0UcKNWz8+gK1xNltYhN2S05zJtJrKztHYyjRsSyAHywlt7ZP04490MkD+9TKS+rkvyOtFpMqmnaAfDEyYonBpIJxq1MF+9Cx+XEH06z7ypL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 575113 invoked by uid 1000); 24 May 2024 10:14:25 -0400
Date: Fri, 24 May 2024 10:14:25 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
  Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
  "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
  j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <9256f95a-858b-435f-b40a-a4508a1096c9@rowland.harvard.edu>
References: <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>
 <35b3fd07-fa85-4244-b9cb-50ea54d9de6a@rowland.harvard.edu>
 <a25f9654-e681-1bad-47ae-ddc519610504@huaweicloud.com>
 <Zk9dXj-f4rANxPep@Boquns-Mac-mini.home>
 <da5241f5-0ae3-40dd-a2fb-8f5307d31dba@rowland.harvard.edu>
 <ZlAAY-BuXSs9xU0m@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlAAY-BuXSs9xU0m@Boquns-Mac-mini.home>

On Thu, May 23, 2024 at 07:50:11PM -0700, Boqun Feng wrote:
> On Thu, May 23, 2024 at 09:38:05PM -0400, Alan Stern wrote:
> > On Thu, May 23, 2024 at 08:14:38AM -0700, Boqun Feng wrote:
> > > Besides, I'm not sure this is a good idea. Because the "{mb}, {once},
> > > etc" part is a syntax thing, you write a cmpxchg(), it should be
> > > translated to a cmpxchg event with MB tag on. As to failed cmpxchg()
> > > doesn't provide ordering, it's a semantics thing, as Jonas showed that
> > > it can be represent in cat file. As long as it's a semanitc thing and we
> > > can represent in cat file, I don't think we want herd to give a special
> > > treatment.
> > 
> > I don't really understand the distinction you're making between 
> > syntactic things and semantic things.  For most instructions there's no 
> 
> Syntax is how the code is written, and semantic is how the code is
> executed (in each execution candidate). So if we write a cmpxchg{mb}(),
> and in execution candiates, it could generates a read{MB} event and a
> write{MB} event (succeed case), or a read{MB} event (fail case), "{MB}"
> here doesn't mean it's a full barrier, it only means the event comes
> from a no suffix API. Here "{MB}" only has syntactic meaning (no
> semantic meaning).

Okay, I get it.  Then you might agree that it probably would be better 
to use a different tag here, because the mb tag is already in use with 
other instructions (like smp_mb()) where it does always mean there's a 
full barrier.

> Not really, RMW events contains all events generated from
> read-modify-write primitives, if there is an R event without a rmw
> relation (i.e there is no corresponding write event), it's a failed RWM
> by definition: it cannot be anything else.

Not true.  An R event without an rmw relation could be a READ_ONCE().  
Or a plain read.  The memory model uses the tag to distinguish these 
cases.

> > that it would work is merely an artifact of herd7's internal actions.  I 
> > think it would be much cleaner if herd7 represented these events in some 
> > other way, particularly if we can tell it how.
> > 
> > After all, herd7 already does generate different sets of events for 
> > successful (both R and W) and failed (only R) RMWs.  It's not such a big 
> > stretch to make the R events it generates different in the two cases.
> > 
> 
> I thought we want to simplify the herd internal processing by avoid
> adding mb events in cmpxchg() cases, in the same spirit, if syntactic
> tagging is already good enough, why do we want to make herd complicate?

Herd7 already is complicated by the fact that it needs to handle 
cmpxchg() instructions in two ways: success and failure.  This 
complication is unavoidable.  Adding one extra layer (different tags for 
the different ways) is an insignificant increase in the complication, 
IMO. And it's a net reduction when you compare it to the amount of 
complication currently in the herd7 code.

Also what about cmpxchg_acquire()?  If it fails, it will generate an R 
event with an acquire tag not in the rmw relation.  There is no way to 
tell such events apart from a normal smp_load_acquire(), and so the .cat 
file would have no way to know that the event should not have acquire 
semantics.  I guess we would have to rename this tag, as well.

Alan

