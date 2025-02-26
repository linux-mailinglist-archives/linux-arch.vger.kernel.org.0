Return-Path: <linux-arch+bounces-10379-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E75A460AA
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 14:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6429018998DB
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 13:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA38221574;
	Wed, 26 Feb 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkECZJmp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47CD221559;
	Wed, 26 Feb 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576191; cv=none; b=ZepnzgLb7swCzMXVc9SAqrKanorLMWyYtsyq10UHiWp4nP5U1jOzNidq5EoK0/wYWtzmR89U8sax0X9DKILt8Nj7hvV7Opel7NNHe/Zvio1+EcbhKz94K2K4SrlZhB/MCdgKKWOB0Gm/j+doQ+GmrohKkNnfk+RosRsm2Wh30Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576191; c=relaxed/simple;
	bh=jp+L3EEqUZilFyzTlCkcQPWm08dxgvd2umLQ5g78EOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfGq9RP3ST7MEp/pdrbSMCrBD1Z+gp1HzeikK3HkSS7gR3Lm4C03MaKNz7/zJyiXMTwehq+pICxefV9Md93S7qamSHxq21wW4CafFbP0oJ5Q/2B1gOZd1Eo7X/QzO24KnriV8eQ7DLbOQZhEZK2u/GumvuV8TYiDot9e+T0kU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkECZJmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1F9C4CEE9;
	Wed, 26 Feb 2025 13:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740576191;
	bh=jp+L3EEqUZilFyzTlCkcQPWm08dxgvd2umLQ5g78EOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkECZJmpQ5FtsegftLysD8xfz7G0DFh0TmuCy7MPfs2ABM4y5cfjhJbBzXNXHoXtD
	 vRySXb0kcQjiCdn5a5bO2r3tlJszbVVPu53nRX9Hp4qGoihkQbNcT668cukq/FtZ5a
	 ZidvZV4WLk32YqnICphiGO8wNzaDIyXnQgmC5S9PnN6BoyPWDvKbKmOC5OnpP71vZV
	 DPvQia7UAZ3rfJiQLelgwaugPyl9dg28FrwKUigUC+oAI4ta4XRF0+u1BQiEO4hiWN
	 +ff5pjWqDEicckbrmnHiXx7kOtM3I+Z/R4oDppD96lqpFpDasgWtqvbhuJ/H7FUaa9
	 OhROKKLRMO47g==
Date: Wed, 26 Feb 2025 14:23:03 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-arch@vger.kernel.org, linux-um@lists.infradead.org,
	x86@kernel.org, briannorris@chromium.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH 3/3] x86: avoid copying dynamic FP state from init_task
Message-ID: <Z78Vt8yCcPrFQeqo@gmail.com>
References: <20241217202745.1402932-1-benjamin@sipsolutions.net>
 <20241217202745.1402932-4-benjamin@sipsolutions.net>
 <Z78SVdv5YKie-Mcp@gmail.com>
 <159a83bf5457edbabcc1e88ee5ab98cf58ca6cb0.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159a83bf5457edbabcc1e88ee5ab98cf58ca6cb0.camel@sipsolutions.net>


* Benjamin Berg <benjamin@sipsolutions.net> wrote:

> > Note that this patch, while it still applies cleanly, crashes/hangs 
> > the x86-64 defconfig kernel bootup in the early boot phase in a KVM 
> > guest bootup.
> 
> Oh, outch. It seems that arch_task_struct_size can actually become 
> smaller than sizeof(init_task) if the CPU does not have certain 
> features.
> 
> See fpu__init_task_struct_size, which does:
> 
>   int task_size = sizeof(struct task_struct);
>   task_size -= sizeof(current->thread.fpu.__fpstate.regs);
>   task_size += fpu_kernel_cfg.default_size;
> 
> I'll submit a new version of the patch and then also switch to use
> memcpy_and_pad.

Thank you!

	Ingo

