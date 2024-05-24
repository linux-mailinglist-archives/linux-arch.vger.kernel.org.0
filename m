Return-Path: <linux-arch+bounces-4511-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4FA8CDF36
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 03:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B721C215CE
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 01:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA7D8F5A;
	Fri, 24 May 2024 01:38:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id CB27879C8
	for <linux-arch@vger.kernel.org>; Fri, 24 May 2024 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716514694; cv=none; b=ayUUuCvdRYctVP8ld21ZNCmOoyJ45XmkdSPxILFVeRG9fnH5BkupDSwVDyRWJ+AwHLlqthafWbq1NTRUdU/cgzUcqEG73o2UHnVeYTxIziM7v/8UMxmrnBc8C9qm5jZHwRdRR0t9SbTm3b5kn5QaRXPw2mQPcaYioipo4Oi/1cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716514694; c=relaxed/simple;
	bh=ktrOGz4jaFDISDmSHOKX/oWCftbzkGJXeQ+Rov6/IaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5xb+CHfycLBjCrIBdjZC+EVnGUJP5kwnpYSzZ6oYiZOZGm3g05pVLDI2VQWubk1Y/29olUcrqzQTnHB2Cw+Z7tIBc122UKnG03cgQAJjc6mHeThJa0VYFBW+NndiQ8WXMnNIGH8z54eU/B3AfmR+MU64fwWrT6GPSpuIvhhDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 559173 invoked by uid 1000); 23 May 2024 21:38:05 -0400
Date: Thu, 23 May 2024 21:38:05 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
  Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
  "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
  j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <da5241f5-0ae3-40dd-a2fb-8f5307d31dba@rowland.harvard.edu>
References: <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>
 <35b3fd07-fa85-4244-b9cb-50ea54d9de6a@rowland.harvard.edu>
 <a25f9654-e681-1bad-47ae-ddc519610504@huaweicloud.com>
 <Zk9dXj-f4rANxPep@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk9dXj-f4rANxPep@Boquns-Mac-mini.home>

On Thu, May 23, 2024 at 08:14:38AM -0700, Boqun Feng wrote:
> Besides, I'm not sure this is a good idea. Because the "{mb}, {once},
> etc" part is a syntax thing, you write a cmpxchg(), it should be
> translated to a cmpxchg event with MB tag on. As to failed cmpxchg()
> doesn't provide ordering, it's a semantics thing, as Jonas showed that
> it can be represent in cat file. As long as it's a semanitc thing and we
> can represent in cat file, I don't think we want herd to give a special
> treatment.

I don't really understand the distinction you're making between 
syntactic things and semantic things.  For most instructions there's no 
problem, because the instruction does just one thing.  But a cmpxchg 
instruction can do either of two things, depending on whether it 
succeeds or fails, so it makes sense to tell herd7 how to represent 
both of them.

> What you and Jonas looks fine to me, since it moves the semantic bits
> from herd internal to cat file.

Trying to recognize failed RMW events by looking for R events with an mb 
tag that aren't in the rmw relation seems very artificial.  That fact 
that it would work is merely an artifact of herd7's internal actions.  I 
think it would be much cleaner if herd7 represented these events in some 
other way, particularly if we can tell it how.

After all, herd7 already does generate different sets of events for 
successful (both R and W) and failed (only R) RMWs.  It's not such a big 
stretch to make the R events it generates different in the two cases.

Alan

