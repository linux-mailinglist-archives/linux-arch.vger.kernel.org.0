Return-Path: <linux-arch+bounces-12561-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E2AF819E
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jul 2025 21:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AE21CA1F56
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jul 2025 19:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ADC2FE309;
	Thu,  3 Jul 2025 19:52:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F86C2F949F;
	Thu,  3 Jul 2025 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751572334; cv=none; b=tEl2Jjw0Qc8feRDivY9wkOMnofMu8bOu3kuikzdfRZGXia6AaA70AVh9uQ/jD+HwKI5KC62+Q56J2bUB1gVLZGaq8jpiAzcqcI1ifAtDlPHwIdczfGeHJLS0Mz93XdXv4IqFM3rYVAvzz+aNvNrLmZxIXo1jyE/xQXPmBf/xK5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751572334; c=relaxed/simple;
	bh=kmGeMCd6uwk5Ar5U06IT+mk5Ta8R9U2J6n03Gb/93pU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9pi0QtkEvP/ULsZkwjB7CfTL9CW2StDjigxfVufya3frFXBCvPglaUGHO3m2tOPFydlbBtKOusFfwsfPNUGlO/wtMJgi9aGbfAiWVRdzm7T0JMItZeHD7VRC8s1TAXoHbxVeC6R6m0HgShYEfXT1Rb53xSUyVfUOGisZ6H/uNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 44D081A0347;
	Thu,  3 Jul 2025 19:52:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 1AEDA2002B;
	Thu,  3 Jul 2025 19:52:00 +0000 (UTC)
Date: Thu, 3 Jul 2025 15:52:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Alexandre Ghiti <alex@ghiti.fr>,
 ChenMiao <chenmiao.ku@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH] ftrace: Make DYNAMIC_FTRACE always enabled for
 architectures that support it
Message-ID: <20250703155242.0475137c@gandalf.local.home>
In-Reply-To: <20250703154916.48e3ada7@gandalf.local.home>
References: <20250703115222.2d7c8cd5@batman.local.home>
	<CAHk-=wjXjq7wJM-xnTCcGCxg2viUcN6JfHBETpvD94HX7HTHFQ@mail.gmail.com>
	<20250703152643.0a4a45fe@gandalf.local.home>
	<20250703154916.48e3ada7@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1AEDA2002B
X-Rspamd-Server: rspamout02
X-Stat-Signature: 6e8fnmg5jq9ac7xqaqwyu5becmk7g9ge
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ytChGLKRRgt5KaCyFEEdkq2A72ZIbve4=
X-HE-Tag: 1751572320-954594
X-HE-Meta: U2FsdGVkX1+hNZ3b+VdcEzKl1YLC3PZQvzlrBqah60dL3uV/pxuwqTMwt5UlQ9z4u8zRAJ6cuujdCPaDDgbVgdjF1drA8cFDog5J4hL/k5tUf97bPj5KaDTqgITaSHF0byR+UCuApJUEUsmq5d7M79VcYjyCH0ezggCq3AN6Fe6m6vcFJnDbTSm62YZBZ7DSNTuBjmZAq8koLMsUbzpXrnA1/+g6VZY40MYS5zhk3vA3mB8L4GUdvN9aGLRcMXrcRH0tv1VreMsIZSwbmYZacuSrkSORJXiTe2avjlp+NYiYg8Sntq4o99fxKuuAUyFKP2zzGjCK/Fq5BJfjVpMatKefy4p2XEaGHXvAExZpnm4y9KAO6qqwPcNs6LfohBzG

On Thu, 3 Jul 2025 15:49:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
> index 515d2995672d..14efd8c027aa 100644
> --- a/include/linux/unwind_deferred.h
> +++ b/include/linux/unwind_deferred.h
> @@ -28,8 +28,8 @@ void unwind_deferred_cancel(struct unwind_work *work);
>  
>  static __always_inline void unwind_reset_info(void)
>  {
> -	if (unlikely(current->unwind_info.id))
> -		current->unwind_info.id = 0;
> +	if (unlikely(current->unwind_info.id.id))
> +		current->unwind_info.id.id = 0;
>  	/*
>  	 * As unwind_user_faultable() can be called directly and
>  	 * depends on nr_entries being cleared on exit to user,

Bah, I did this while fixing the unwind patches.

Oops!

-- Steve

