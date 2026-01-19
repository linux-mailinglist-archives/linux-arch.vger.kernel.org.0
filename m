Return-Path: <linux-arch+bounces-15865-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE1D3A6E1
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 12:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B8C130AC068
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 11:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6AF31065B;
	Mon, 19 Jan 2026 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QeSVRoaz"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4CA311949;
	Mon, 19 Jan 2026 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768822072; cv=none; b=Hl8lT7lxGFrh7dYzx9e28ZvjRfMqFv/lOyGb7szgddJfX/6lFp5I8EAL1xUM+fGZLNVwgEbTTQ4HV8zzFu//b3zsxVJ7yyp5mB1T79sf9FZ0c0DSAOn3gOyBSuCX/3mWIJBj6JFc5+Nw3cge1+5V8XFwnzhyMp7amXCqYrhFeMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768822072; c=relaxed/simple;
	bh=jSbNB4ds1ceaQ88Aw50QftnOFSHl9kf+tTIXQ06JH7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L15stpEwnTRciI+ZuT4308hrvfy5tZ45HmmOLEHV1sxRBLm43XwYfqFfCdmhAApyXe6JRwwHAnRV7gMmdxIKCX1ZZfsnkgpSKBhlrtGd3NCEAmNrc/N2q2qCZdX3kZCWbMSUUkd5LqOkQM6AMg2geneFC63TtpLngYLPNVWsbfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QeSVRoaz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YOewk0NEEXR/v+gR4OrHXKnFlpeB2f+BEwqv9LtWkxI=; b=QeSVRoazA8zR6vYlOhe+RrEtkY
	2RnotFnZZ6AD+OC2/IhaBL0lKXeO553ipC4n2lJaJ3JQ0uyJtVCBhjS4VdRnO/uqd6vhDVtdKeR8j
	j/i2P8klcv22QyfJGHwb0u0W8ElxeX+kCuvo7FhC94YYvu7RVy3l5CUdIRO9NHamMPlPfbCvrdzXw
	7jEE0MjlpIlYQKYDsZxrVW591ueFMfvOlYQRsNuNcwwqzVZa6bVOUuPa5kzTPuT7ZIT7foU0C4+4X
	ntxmoxewDbM+7dkqbPVJQc9vcUK0U5dskYRQt1LBC7/URhj/ov8fL1lQ1b9v7ziudFU3BsqiGRDJM
	iTeqznJA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhnQ3-0000000By2n-00gv;
	Mon, 19 Jan 2026 11:27:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8AD98300754; Mon, 19 Jan 2026 12:27:38 +0100 (CET)
Date: Mon, 19 Jan 2026 12:27:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>,
	"carlos@redhat.com" <carlos@redhat.com>,
	Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
Message-ID: <20260119112738.GH1890602@noisy.programming.kicks-ass.net>
References: <d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com>
 <87jyyjbclh.ffs@tglx>
 <225b9868-4ab7-4a90-8acb-8d965626f6a7@efficios.com>
 <87ldi4gjm3.ffs@tglx>
 <lhua4yhcc0d.fsf@oldenburg.str.redhat.com>
 <45fd706a-86be-42b8-879e-11bbe262e159@efficios.com>
 <20260119102138.GQ830755@noisy.programming.kicks-ass.net>
 <5d2f428d-4fdc-486d-90e1-474f3ee9f54f@efficios.com>
 <20260119110300.GR830755@noisy.programming.kicks-ass.net>
 <840016ad-9188-4df4-904e-b7462b2cfd81@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <840016ad-9188-4df4-904e-b7462b2cfd81@efficios.com>

On Mon, Jan 19, 2026 at 12:10:27PM +0100, Mathieu Desnoyers wrote:

> > struct rseq vs struct rseq_data. I don't think that slice field is
> > exposed on the user side of things.
> 
> Yes it is. (unless I'm missing something ?)

*sigh*, I was looking on the wrong machine, that didn't have the patches
applied :-(

I need to go wake up or something...

