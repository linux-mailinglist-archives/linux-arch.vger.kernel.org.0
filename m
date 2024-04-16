Return-Path: <linux-arch+bounces-3728-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4CA8A6E76
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06AD282A8F
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D91E12C7E8;
	Tue, 16 Apr 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fGmNj4lL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC011CAA6;
	Tue, 16 Apr 2024 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278122; cv=none; b=pxFz11x/SG6StjXxLE/g5YaFSDN5nOlyg0D3dlbb1h3h6oLenRYEVby3oNPDWgFyDTJ/66/We0zNS7y3oMEvkb1OV2jKitpVam+VQayhFvqloTSmb4I1zrqgF3iAf+skAHRGvL5zLxRRAGvh+y0IDUyHDFmBOyBBUpI6WIXZnRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278122; c=relaxed/simple;
	bh=Ny7bREgebSey8yrqgmDqsKUa8GrfP9MN5joKmG/2kP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mO3DjJw/TbQgXQTS71Xus7/qT99nB9HK7VP49dXpXpccAtrW4d3QC5TN7ISekFA9cgaxkl0B0Vd+IfpoCKlKAukx7lSeAZT9dz7IHxk+f0zXNHMk6NwUjnLlelWeKlnr9ArUgRpNRwFV+Uj+YvMJjixf+wdwlCxMgp7ZxD9pr9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=fGmNj4lL; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1713278115;
	bh=Ny7bREgebSey8yrqgmDqsKUa8GrfP9MN5joKmG/2kP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fGmNj4lLvW1m/TDfOEYNR8p0KPZH7PzExxSJEe2JH4h0XpFxRpWBE4LozH2qyEBGa
	 yt+U6CsAwJ+WqOcmOY+oPmVhr+koSnPfEjRNCr+K2Kl0uJ3Nab4PJyz6xObQxNXTJU
	 Hi4JAsh9mgPkdJcZ5E9YNJt/FLNJCwMIgTZA3S6f+dqoR0GITkhxDRJY2OsabFG844
	 JX/cTwfoEZIuwTfLOkRkynogiabk4/4auYXLYz6EIf/lkkj0GNeQ23tSdbQgrKVUrr
	 gmlUzLJojWO0lKZc3wW4tqm7o56YzJJB8o5pFLiJZD8oYRZSMhNmVACXeIoWd/6IdN
	 Oog5ejWza7yRA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4VJmm32YTczvxK;
	Tue, 16 Apr 2024 10:35:15 -0400 (EDT)
Message-ID: <f9ba99e8-195a-4674-8177-c2ba6c3c4cff@efficios.com>
Date: Tue, 16 Apr 2024 10:35:17 -0400
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] sched: rseq mm_cid updates
To: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, "levi . yun"
 <yeoreum.yun@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 Aaron Lu <aaron.lu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
References: <20240415152114.59122-1-mathieu.desnoyers@efficios.com>
 <Zh5tTmwmWauIajeB@gmail.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Zh5tTmwmWauIajeB@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-16 08:21, Ingo Molnar wrote:
[...]
>>
>> Mathieu Desnoyers (2):
>>    sched: Add missing memory barrier in switch_mm_cid
>>    sched: Move mm_cid code from sched.h to core.c
> 
> I've applied the first patch to tip:sched/urgent, and will queue up the
> code movement patch in the scheduler tree for v6.10, thanks Mathieu!

Thanks for reviewing and queuing those patches!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


