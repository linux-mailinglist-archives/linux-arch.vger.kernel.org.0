Return-Path: <linux-arch+bounces-4226-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF778BD553
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 21:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A765282F18
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 19:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA6158DC7;
	Mon,  6 May 2024 19:21:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 99E8D158A2B
	for <linux-arch@vger.kernel.org>; Mon,  6 May 2024 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023317; cv=none; b=bYsgwMk6Uptf+J/1ceMoXXpM4zoToVrf/bCb7OLycxMBDRs4k2Kd2ayY0FDWZePmza6h8OhqekeO562od/egXkXBQO055M+A9+SFy6oVp9eQRQZ4kH5UJoGW5Fk3qeWntjvfd7ncmhn5ZFnnIg6K7Ixw/+7Ad2DhM6VGGdLGwsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023317; c=relaxed/simple;
	bh=ecidPVblaFiHPOmvdtsNH/P/QiwhpZL5C6FM8X3FzSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ijbn7Oqlz5FGa6dOCJwL5FMu1PxcUl0pEonDHwwnkqaGkxpZnAMJY5oY/ymKtiqdMh3YZb6dHNEfXvKttxkbrkw/siKGBj3oPA09+F7Xqi8ngpsePp6dSnCNASGqU+XAee46Dlhn7KupHsW1ZjHurV7/Xu/DBoWudIvKrj4/fLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 888983 invoked by uid 1000); 6 May 2024 15:21:54 -0400
Date: Mon, 6 May 2024 15:21:54 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
  linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
  kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
  will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
  npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
  luc.maranget@inria.fr, akiyks@gmail.com,
  Frederic Weisbecker <frederic@kernel.org>,
  Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>,
  Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
  linux-doc@vger.kernel.org
Subject: Re: [PATCH memory-model 2/4] Documentation/litmus-tests: Demonstrate
 unordered failing cmpxchg
Message-ID: <c168f56f-dfae-4cac-bc61-fc5a93ee3aed@rowland.harvard.edu>
References: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
 <20240501232132.1785861-2-paulmck@kernel.org>
 <c97f0529-5a8f-4a82-8e14-0078d4372bdc@huaweicloud.com>
 <16381d02-cb70-4ae5-b24e-aa73afad9aed@huaweicloud.com>
 <2a695f63-6c9a-4837-ac03-f0a5c63daaaf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a695f63-6c9a-4837-ac03-f0a5c63daaaf@paulmck-laptop>

On Mon, May 06, 2024 at 11:00:42AM -0700, Paul E. McKenney wrote:
> On Mon, May 06, 2024 at 06:30:45PM +0200, Jonas Oberhauser wrote:
> > Am 5/6/2024 um 12:05 PM schrieb Jonas Oberhauser:
> > > Am 5/2/2024 um 1:21 AM schrieb Paul E. McKenney:
> > > > This commit adds four litmus tests showing that a failing cmpxchg()
> > > > operation is unordered unless followed by an smp_mb__after_atomic()
> > > > operation.
> > > 
> > > So far, my understanding was that all RMW operations without suffix
> > > (xchg(), cmpxchg(), ...) will be interpreted as F[Mb];...;F[Mb].

It's more accurate to say that RMW operations without a suffix that 
return a value will be interpreted that way.  So for example, 
atomic_inc() doesn't imply any ordering, because it doesn't return a 
value.

> > > barriers explicitly inside the cat model, instead of relying on implicit
> > > conversions internal to herd.

Don't the annotations in linux-kernel.def and linux-kernel.bell (like 
"noreturn") already make this explicit?  

I guess the part that is still implicit is that herd7 doesn't regard 
failed RMW operations as actual RMWs (they don't have a store part).

Alan

