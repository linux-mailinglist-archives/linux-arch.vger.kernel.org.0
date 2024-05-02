Return-Path: <linux-arch+bounces-4137-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220AE8B9BD8
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 15:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FDD283F0A
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C451B13C698;
	Thu,  2 May 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PykGU7vn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABD17441E;
	Thu,  2 May 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657612; cv=none; b=r6k4L6MHNj/i0y14P+tw0veHisHU9laiL+0qiqfyrpeWZOcUxJ8yKLoJuNrlQ057+SzMKGQzcCWPExUSYPSrgj+JUmKUrJ4inReKBNZm0Oyp9cqxcoH3JJftG8URa2YbmxrIHdUMpdJuM7O3RA2uB4i3be9pZmLTDluBoIJ6vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657612; c=relaxed/simple;
	bh=IONxS2MV99UWId/MVeBPRqTGzlP+W3rWxNDFzSj3JFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8q4fYtNH9erlWYemijiEsX7UOTBppd6UEkLUbiNEmS/nyaid9BxypzlVb2DKh9LlK3vr0cNqXrS5yQS2LH7tAok5FUt+rK4YNRK7CJ8QxpG8ZuGq7pyTG1ZEWxEbeBbHan0k8NgpI4BzN5PcxWPYS6uSyEJa2K06659sQC5Q0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PykGU7vn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19926C113CC;
	Thu,  2 May 2024 13:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714657612;
	bh=IONxS2MV99UWId/MVeBPRqTGzlP+W3rWxNDFzSj3JFQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PykGU7vnyHMayFGxMOXv2KxaZvMm/tou9NngIaVxJd00riuQATuV4L0T13NrBLSGA
	 sjFHm1ycaYjmZGuGZbaJRB1IS2z0J/LCGjmbRjUt9rzoAf2sN4di7nZRTtvnvobdVC
	 VhSGMIWfQf4RyTwyP/SnjC0jYPPSUOasatLL/dP25xeMK69iNPN6aSdSEOYhYHGKWW
	 ZeihCslBBJ5Qjk9VnLQcAWPwAJBOozsC5Ui8TnVkHewmLBZhMCreEmV7H01TRF8Ox7
	 Cw90j1HvK/1MMwYRftT7wzNrVPhyZ05U+zVY0OxOWqvefz01oWcKKHQk88vsjBFVmF
	 ooBfjV0Uvdgjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BBAE3CE0A32; Thu,  2 May 2024 06:46:51 -0700 (PDT)
Date: Thu, 2 May 2024 06:46:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
	will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH v2 memory-model 0/3] LKMM updates for v6.10
Message-ID: <0a2d40c8-5bb2-4505-b9e1-21e9c1b6127b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <8550daf1-4bfd-4607-8325-bfb7c1e2d8c7@paulmck-laptop>
 <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
 <ZjNes3y88guG2vZc@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNes3y88guG2vZc@andrea>

On Thu, May 02, 2024 at 11:36:51AM +0200, Andrea Parri wrote:
> > This series contains LKMM documentation updates:
> > 
> > 1.	Documentation/litmus-tests: Add locking tests to README.
> > 
> > 2.	Documentation/litmus-tests: Demonstrate unordered failing cmpxchg.
> > 
> > 3.	Documentation/atomic_t: Emphasize that failed atomic operations
> > 	give no ordering.
> > 
> > 4.	Documentation/litmus-tests: Make cmpxchg() tests safe for klitmus.
> 
> For the series,
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thank you!  I will apply on my next rebase.

							Thanx, Paul

