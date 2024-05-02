Return-Path: <linux-arch+bounces-4142-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08FF8BA143
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 22:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F011F2302E
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 20:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E8C17F38D;
	Thu,  2 May 2024 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I/dHtSPd"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388017333B;
	Thu,  2 May 2024 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680119; cv=none; b=B4j9PDtjjojKb1gXGgh/YDj+Khs0p8ROILsRTLiVFeZLl4G9VtC4v8q5wRssF4iaFhZzetKMsunZxJk636+4sDrEfC9SmdAqd7geNvAW1WF3fMh3ektN3gQ7fqX31UU2HjTmbfLdpUGTtcBC23saeVLaanq7egBa+zX4D2o5cvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680119; c=relaxed/simple;
	bh=cns1XvQCJNXaVm0DDz0wgIIDmDGGc7d0RGxe5VrtVaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPim8naSOPVr0ZTNCK4z7Jro7LlUkRX4mCR2h0MwcqWQqxTT8j9V08EtsmSEHv+kUAV57TU4DZujSlr5lhOx+4OirmmTcIAiQKdMxyY0wcyOYYtbYeqjfzo0M8aR5v0mj85v2sEuc0nasZTjYRLIsXPGj9xD0xfylpigJb9stXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I/dHtSPd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KAJKrCaKKiEnCrHucvHJ9CHtLAzdjNiKdzAYMK92RUo=; b=I/dHtSPdKkAeD5bKJa1S8qSIvG
	6qxa2N7rH++FKfP7iGmsN1/nYs9CMqh1GIDjbYivZzySag/Jw9MUt1O6/T/yif1MgEK1DT0cgrS2o
	c4pPbn4fq7tRxNulTGlfw81STx8p1hrrv3dtwuW/jTP3NtwFq8LxheEAZWrNYq6Ue6gjkFIeR/ySG
	kKZwm2Ihjhj8MkU2HhSk1c3+fWZY4Lhj4FU/UZLHopFrhR9B37nTWg/jEqhWhQe8xQh1MgW9j89Mw
	mQoaxoXzrHmm99JAgR65yx971fYObzfY1ZRtBM1cx6Val6bZNIs6U2UvkKEhcxsyCQ0g+55kxWpgF
	G2idCUYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2ccr-009hjC-0p;
	Thu, 02 May 2024 20:01:53 +0000
Date: Thu, 2 May 2024 21:01:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	torvalds@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 cmpxchg 0/8] Provide emulation for one--byte cmpxchg()
Message-ID: <20240502200153.GJ2118490@ZenIV>
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
 <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 01, 2024 at 03:58:14PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This v2 series provides emulation functions for one-byte cmpxchg,
       ^^
...

> Changes since v2:
                ^^

