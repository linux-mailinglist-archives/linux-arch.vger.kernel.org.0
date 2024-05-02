Return-Path: <linux-arch+bounces-4154-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E5E8BA3F2
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 01:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552FF1F20FC8
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 23:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48A11CD2A;
	Thu,  2 May 2024 23:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YJ8thX4O"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315E57C96;
	Thu,  2 May 2024 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692297; cv=none; b=l2jZDpKvNabBJ4wCntzouwEAudDSy4rBUp/cicqmyqMqtsR2UsfJffnLVNTCNEPZcQTEKDu3xyNOMZtkaJDF7yVaOgbzSsy8r5NS4VfJP5w0arx4C1r8TQ6/WukDvoTB9FQeXSFs+Z0sxlfaITk+9pPWqyBI28Axx5jjT/51mRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692297; c=relaxed/simple;
	bh=+xXyzedyVc48PF3hdyhKkxKsf7uulASRUcLk9rMpso8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJaYYeOiTfyxH02FYVkwZmJdyp4V4O3o3Im/CH4HEBWZnOsIt08tzlAW2+l82Fx1RrR1bnLIKwMmziYnpGvztgBUQ8GAA/1y6QrwdjAx1OLqWLPXuiGt//xEvDJbN5VTz3fxz3ep0b6WOWBUPTG51j9dQSar66yvpDExGVOLrNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YJ8thX4O; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i6JN4J2gFuUHV5idXz05AtG9Y1hW4HX4gS5b0NVqQAg=; b=YJ8thX4O/ALhTWziBUFMmV8YCH
	maFFLbdIt0u12R2wdolpQIpNqeQ1aUhuZ0ZutCMc7u88GcEzII1dS/+7/xr+ru9B5vUiiYNRZ5qil
	kxjtigSee/d3iVR2GMykTjSNSTrcLLT4nlJ7ubZyxJ4ynz6QJ3MGTtEqPY/8pKuddlnrUhC7A3h3x
	H9E8asOqGV/KkNW8YxR03I+jXWWcPBu6w/s6HMzADolIJaSAdfed0zdYfkQtERMV2ToPAL9cpOpux
	DnKRcLgwKnBtNduWU56QU9YY0qMCjp57/0j+E2U3Oc+9we3T1FVZPPwhxeVElFRMGEu/P319o/XFn
	XtveEmOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2fnD-009rGh-0p;
	Thu, 02 May 2024 23:24:47 +0000
Date: Fri, 3 May 2024 00:24:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
Message-ID: <20240502232447.GO2118490@ZenIV>
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-12-paulmck@kernel.org>
 <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
 <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
 <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop>
 <20240502205345.GK2118490@ZenIV>
 <0a429959-935d-4800-8d0c-4e010951996d@paulmck-laptop>
 <20240502220757.GL2118490@ZenIV>
 <3dac400c-d18f-4f4e-b598-cad6948362d6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dac400c-d18f-4f4e-b598-cad6948362d6@paulmck-laptop>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 02, 2024 at 04:12:44PM -0700, Paul E. McKenney wrote:

> > I'm probably missing your point, though - what mix of cmpxchg and
> > smp_store_release on 8bit values?
> 
> One of RCU's state machines uses smp_store_release() to start the
> state machine (only one task gets to do this) and cmpxchg() to update
> state beyond that point.  And the state is 8 bits so that it and other
> state fits into 32 bits to allow a single check for multiple conditions
> elsewhere.

Humm...  smp_store_release() of 8bit on old alpha is mb + fetch 64bit + replace
8 bits + store 64bit...

