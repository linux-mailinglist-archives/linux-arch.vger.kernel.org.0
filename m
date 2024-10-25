Return-Path: <linux-arch+bounces-8575-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB53E9B1041
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 22:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE951C21985
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 20:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1047721E638;
	Fri, 25 Oct 2024 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="tKnIU9yL"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C9221E612;
	Fri, 25 Oct 2024 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888877; cv=none; b=LSWjhFvshjNVmGbgLCd5g6mX6FO746FwHseUleglt83qK6MXBy9dqdLZHlQM7GP0yLYfpy8OCt2U8U9bGjVyHU0AcTJMawmy/9aiyIYvd1lF9IB2ZAd5XTyxOUYFtL7QmNHUK4FnVDgqtVXU7itXQMNZOHENgt5KgRjBtc+p/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888877; c=relaxed/simple;
	bh=ePBCrXDkYFx/2MDEBoHUpjfoxbGRLqNpKAELJMFiw1s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rYLpF3ERRjX5YOJYDVqjo8FjT4tkX6GG/vZV6LFDRRXBu7igRZ0KbDI13rPhDoELZByAqnTUA/ut5TMd+2bbQEqtrcGeoKDkr6uEcZiUp8Qgiwl060HKaCUGcBi41ZIWTyICa3eUScPdmUpRC2QWkmkcii9Y2hwWVI12ugSftos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=tKnIU9yL; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1729884632;
	bh=ePBCrXDkYFx/2MDEBoHUpjfoxbGRLqNpKAELJMFiw1s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=tKnIU9yLNT99wXsnGjwNZKVelKMhdVUWjq8L2OltJ89liNws7uTd5XHNZ/dh7Rdtg
	 +Zr9Z+y8LnEli7a/gbrQJZYA2kf7gb6EO0kEY37+chasBXZ/XiOFFk3TAxP8V6lETj
	 dTN0G6HxplP2egvSeFaopp1BBhME+m3fnTR0OwS4=
Received: by gentwo.org (Postfix, from userid 1003)
	id 38560409C6; Fri, 25 Oct 2024 12:30:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 3716240681;
	Fri, 25 Oct 2024 12:30:32 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:30:32 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
    Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, 
    Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
In-Reply-To: <20241025074244.GB14555@noisy.programming.kicks-ass.net>
Message-ID: <797cf697-83b2-7f45-4865-2ee394887dc8@gentwo.org>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org> <20240917071246.GA27290@willie-the-truck> <4b546151-d5e1-22a3-a6d5-167a82c5724d@gentwo.org> <CAHk-=wgw3UErQuBuUOOfjzejGek6Cao1sSW4AosR9WPZ1dfyZg@mail.gmail.com>
 <CAHk-=wjdOX0t45a7aHerVPv_WBM3AmMi3sEp8xb19jpLFnk0dA@mail.gmail.com> <20241023194543.GD11151@noisy.programming.kicks-ass.net> <e9fd5ba0-bd84-76a8-a96e-1378c66d0774@gentwo.org> <20241025074244.GB14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Oct 2024, Peter Zijlstra wrote:

> > atomic_inc_release(&seqcount)
>
> It would not be, making the increment itself atomic would make the whole
> thing far more expensive.

True. I was too much taken by a cool hw feature on ARM.


