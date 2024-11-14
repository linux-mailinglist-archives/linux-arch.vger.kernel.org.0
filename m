Return-Path: <linux-arch+bounces-9088-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6719C90B3
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 18:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F511F23393
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 17:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D07A185939;
	Thu, 14 Nov 2024 17:22:18 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F4189F2A;
	Thu, 14 Nov 2024 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604938; cv=none; b=JkFtFEyXqmvDaE+nh2iMYNzvqCklauyjQ7t1q8nSJItUCJyvOtly7TtS7WVQ8wALEKsAXE9/bE/e+01QS4HVcwmZZwIvQ8SRd8MIjV3ozim/jK538pd2ElrQWO7r0n06SCYGNdjAyJ1QERepQQZiixHXETLp4MuqZuJ8SCDNRiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604938; c=relaxed/simple;
	bh=t9ajE/VeX04xVGpQR7Zfzq53U0A1RsxE/6M4zIt9zZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/TYcmU03YyeJ0q8i2KYBbdbsgLOUZQhL5FD+LewcNBWZmjLQSrXdUNvwrPKo6VXtQMAmcpqNR19e6+9HAnrd2ZMudfBNSX72sD9Ahc7/ivSRYl8a1h27ZmmwB1WY3bKNqKBZX3gg91uXFQ57C40t4HZkx7XTF7WTDFzDubEado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD68F1474;
	Thu, 14 Nov 2024 09:22:44 -0800 (PST)
Received: from arm.com (RQ4T19M611.cambridge.arm.com [10.1.37.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBA8D3F6A8;
	Thu, 14 Nov 2024 09:22:09 -0800 (PST)
Date: Thu, 14 Nov 2024 17:22:07 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-pm@vger.kernel.org,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	pbonzini@redhat.com, vkuznets@redhat.com, rafael@kernel.org,
	daniel.lezcano@linaro.org, peterz@infradead.org, arnd@arndb.de,
	lenb@kernel.org, mark.rutland@arm.com, harisokn@amazon.com,
	mtosatti@redhat.com, sudeep.holla@arm.com, maz@kernel.org,
	misono.tomohiro@fujitsu.com, maobibo@loongson.cn,
	zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v9 01/15] asm-generic: add barrier
 smp_cond_load_relaxed_timeout()
Message-ID: <ZzYxv2RfDwegDMEf@arm.com>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
 <20241107190818.522639-2-ankur.a.arora@oracle.com>
 <9cecd8a5-82e5-69ef-502b-45219a45006b@gentwo.org>
 <87v7wy2mbi.fsf@oracle.com>
 <88b3b176-97c7-201e-0f89-c77f1802ffd9@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88b3b176-97c7-201e-0f89-c77f1802ffd9@gentwo.org>

On Fri, Nov 08, 2024 at 11:41:08AM -0800, Christoph Lameter (Ampere) wrote:
> On Thu, 7 Nov 2024, Ankur Arora wrote:
> > > Calling the clock retrieval function repeatedly should be fine and is
> > > typically done in user space as well as in kernel space for functions that
> > > need to wait short time periods.
> >
> > The problem is that you might have multiple CPUs polling in idle
> > for prolonged periods of time. And, so you want to minimize
> > your power/thermal envelope.
> 
> On ARM that maps to YIELD which does not do anything for the power
> envelope AFAICT. It switches to the other hyperthread.

The issue is not necessarily arm64 but poll_idle() on other
architectures like x86 where, at the end of this series, they still call
cpu_relax() in a loop and check local_clock() every 200 times or so
iterations. So I wouldn't want to revert the improvement in 4dc2375c1a4e
("cpuidle: poll_state: Avoid invoking local_clock() too often").

I agree that the 200 iterations here it's pretty random and it was
something made up for poll_idle() specifically and it could increase the
wait period in other situations (or other architectures).

OTOH, I'm not sure we want to make this API too complex if the only
user for a while would be poll_idle(). We could add a comment that the
timeout granularity can be pretty coarse and architecture dependent (200
cpu_relax() calls in one deployment, 100us on arm64 with WFE).

-- 
Catalin

