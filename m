Return-Path: <linux-arch+bounces-4963-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8AD90DA0C
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 18:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8D51C21FB9
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 16:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2514D2AC;
	Tue, 18 Jun 2024 16:54:02 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBAD13BC35;
	Tue, 18 Jun 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729642; cv=none; b=WbfDJbUxUmKba5ZrcBBBiD4SV+vcOQF0DFhWd9pDH1N85asQUQ0kyjKHvwfnwa+rfXJT0xGUHTNNNxiXgRnNXnyA49HEFYh2jZwwrp66oYv/2ytp9golcU9BIQYlm9c91cpd35v2Sqqr2AjPF7St94muNJ8u5ff8rGUUoFTuWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729642; c=relaxed/simple;
	bh=MNkGRu9GKer6t/McohMZFDGB7NdhMCoyNOLnBy33Rus=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SJ4ln9VwnAsGkM4NiQWVUgZNeQYrAD6HoLnfXiBlEGmhWf43J9YYS8A+yuDJkcItBI1i3p24VRCxDWj7noTVXjk8N2Q0AgszTDIFhaEBlnC0dClri88ZBHDaOlvUIjdy3yz8T6cOGSa9XHxqyXdP/duqnYrlqLGkWX24bFvL3og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 7804B401EF; Tue, 18 Jun 2024 09:53:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 76EAF401CA;
	Tue, 18 Jun 2024 09:53:53 -0700 (PDT)
Date: Tue, 18 Jun 2024 09:53:53 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Peter Zijlstra <peterz@infradead.org>
cc: tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
    mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net, 
    andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>, 
    urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com, 
    Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, 
    linux-mm@kvack.org, linux-arch@vger.kernel.org, malteskarupke@web.de
Subject: Re: [PATCH v1 11/14] futex: Implement FUTEX2_NUMA
In-Reply-To: <20240612174432.GK8774@noisy.programming.kicks-ass.net>
Message-ID: <b476aa71-37ec-a4ee-6a8a-3a28811bb87c@linux.com>
References: <20230721102237.268073801@infradead.org> <20230721105744.434742902@infradead.org> <9dc04e4c-2adc-5084-4ea1-b200d82be29f@linux.com> <20240612174432.GK8774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 12 Jun 2024, Peter Zijlstra wrote:

> I read this like: I tested it and it works for me. Is that a correct
> reading of your statement?

We tested it and it works as we expected.

Which in turn raises the issue if this could be done to other large 
system hashes as well.

