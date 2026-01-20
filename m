Return-Path: <linux-arch+bounces-15894-lists+linux-arch=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-arch@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDDoIo2tb2nxEwAAu9opvQ
	(envelope-from <linux-arch+bounces-15894-lists+linux-arch=lfdr.de@vger.kernel.org>)
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 17:30:05 +0100
X-Original-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DD1478BB
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 17:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F3E692A84C
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E9D42980D;
	Tue, 20 Jan 2026 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoV+ZHYi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9601A41B340;
	Tue, 20 Jan 2026 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917545; cv=none; b=IIPWsF3B4V/QZuQTTR7LRh+x0thtlGcToHEhu0utvtaQawA4FhF9wj9fulAN3B5j9tc2p6xohF9L3ZpxqR/pCmQ2djXhJ4wIIB1EZFqpoiGYSolucmEqmh8XWjMwUusUWj/oMhVLmqaHpohICAbGnkyw/iu/CuQf9hEldC7pq0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917545; c=relaxed/simple;
	bh=9051yFq57Xie5pjtJjoBq/HvBu5GE3EcHvOKur+xijo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbGntuKQErpvrUFU+TpOPZguGi3fdG3pqKWRPNWsJWb7DpSSASvu8pcQrK69kf/jAlu+4r8Q1SfHkZkaMR9IGX9txsAKpf6mV76UHS1OuAsfwxBLEZLKMY3rVH9Tz3FxvXd0VKxt5gkb83M1+dOq+zQYr3L/e1LfsRu2XYow1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoV+ZHYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B34C16AAE;
	Tue, 20 Jan 2026 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768917545;
	bh=9051yFq57Xie5pjtJjoBq/HvBu5GE3EcHvOKur+xijo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZoV+ZHYiLGqOe4NWfwMjBJu+d8Nl30ZgHgckXnZ5+4Dix/UB0LdlIn6fjHwSKWM1K
	 dwvGdy3JXj2FQ6/DunG343ZTszE2CKh5rBIljRUWiLjM0GYEGr5lXnTc5tk+tt2llS
	 T5uH1cP9oJulukrS8qlW8HNvtGYoJQ0w00MNZ/HhcfRL5Nlru7mbGOkQj7T7JBOa+J
	 j+FVJiWMl4bHHjEP4BCb9zpI4p5eovVAH+n3nga0pcPEdMpaypnwHbU0TD31BOvLTf
	 cDZgR62kgZFwdz4V2ZjMgRdc8TNRWFMUylQwBV2z69vLTCgBS5H/xBtUVPX6aNePpp
	 x2YFoC1FeMHkg==
Date: Tue, 20 Jan 2026 13:58:57 +0000
From: Will Deacon <will@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
	peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v8 04/12] arm64: support WFET in
 smp_cond_relaxed_timeout()
Message-ID: <aW-KIVQ_H1mVpGHx@willie-the-truck>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
 <20251215044919.460086-5-ankur.a.arora@oracle.com>
 <aWEOALG07jHC_oHC@willie-the-truck>
 <87wm1qmx90.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wm1qmx90.fsf@oracle.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15894-lists,linux-arch=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,arndb.de,arm.com,infradead.org,linux-foundation.org,amazon.com,gentwo.org,kernel.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,linux-arch@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-arch];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,arndb.de:email,arm.com:email]
X-Rspamd-Queue-Id: 11DD1478BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Jan 09, 2026 at 11:05:06AM -0800, Ankur Arora wrote:
> 
> Will Deacon <will@kernel.org> writes:
> 
> > On Sun, Dec 14, 2025 at 08:49:11PM -0800, Ankur Arora wrote:
> >> Extend __cmpwait_relaxed() to __cmpwait_relaxed_timeout() which takes
> >> an additional timeout value in ns.
> >>
> >> Lacking WFET, or with zero or negative value of timeout we fallback
> >> to WFE.
> >>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >> ---
> >>  arch/arm64/include/asm/barrier.h |  8 ++--
> >>  arch/arm64/include/asm/cmpxchg.h | 72 ++++++++++++++++++++++----------
> >>  2 files changed, 55 insertions(+), 25 deletions(-)
> >
> > Sorry, just spotted something else on this...
> >
> >> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> >> index 6190e178db51..fbd71cd4ef4e 100644
> >> --- a/arch/arm64/include/asm/barrier.h
> >> +++ b/arch/arm64/include/asm/barrier.h
> >> @@ -224,8 +224,8 @@ do {									\
> >>  extern bool arch_timer_evtstrm_available(void);
> >>
> >>  /*
> >> - * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
> >> - * for the ptr value to change.
> >> + * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
> >> + * __cmpwait_relaxed_timeout() for the ptr value to change.
> >>   *
> >>   * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
> >>   * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
> >> @@ -234,7 +234,9 @@ extern bool arch_timer_evtstrm_available(void);
> >>  #define SMP_TIMEOUT_POLL_COUNT	1
> >>
> >>  #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
> >> -	if (arch_timer_evtstrm_available())				\
> >> +	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
> >> +		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
> >> +	else if (arch_timer_evtstrm_available())			\
> >>  		__cmpwait_relaxed(ptr, val);				\
> >
> > Don't you want to make sure that we have the event stream available for
> > __cmpwait_relaxed_timeout() too? Otherwise, a large timeout is going to
> > cause problems.
> 
> Would that help though? If called from smp_cond_load_relaxed_timeout()
> then we would wake up and just call __cmpwait_relaxed_timeout() again.

Fair enough, I can see that. Is it worth capping the maximum timeout
like we do for udelay()?

Will

