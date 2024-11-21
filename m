Return-Path: <linux-arch+bounces-9149-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B789D4C12
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2024 12:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E88D1F21032
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2024 11:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C249A1CACF7;
	Thu, 21 Nov 2024 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+I3rVhZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DFE1C3046;
	Thu, 21 Nov 2024 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188988; cv=none; b=g+l7dRUGBI5cbefGihKSFv/+G3Nfne3Ubj8jtLkLa4LF8ne3vPxhAHu6oxB0Uov0l2MgeXARCR8D1wXGj52+g5V4QvjVzEAZzaKHEU7m36LLMyiwV8zNBp8ruYzyjZWedksmD7C96OhU2ZWm0G/RQAjp341Wo9bddARhZtoRVHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188988; c=relaxed/simple;
	bh=cM8frLWLkX23eGShDOZ4lAAKAr+0zQogfii33AqdZsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdHLzGi+V1+C2XVG+WYqzOI5gXkjfwyp7qQRFWQvCbm732I2AzoR6CpyJoNyNr2yZ5/+LI1+oi/oTTs8ERV43YKFPvVXsLdUKm8BdzNowbrljvYzYaIlEtU1WatHd0DELDVKoW84WCgSJm/MbTpD0mRH8lJuGFcM6xrGfyZNqQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+I3rVhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8C6C4CECC;
	Thu, 21 Nov 2024 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732188988;
	bh=cM8frLWLkX23eGShDOZ4lAAKAr+0zQogfii33AqdZsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+I3rVhZ37SjdeoKWrZhZpMBlCRFcw22QerkKPTF4jjlgbM8OlqnOJemB4sEzwVt9
	 hjIAYMxk84m/hVT9nQDLsXoWfwid4fyRrcdSdTDLkv1sgZVyEYqlWIAWmmbKSGtyrj
	 Qa0Y1aWORZuhRaIMc723hLtoItMQxaTSFNarDNkGxkWIBb1dGJ3IVo4SpQZiuDfeHe
	 1q0z+H4S75pweRBGIBOfcSnRA+E9OctiEYlIUZnZ3bDxlhe4wTgH2l/ABn8DkECjaM
	 WadnPqRcjB7IoPn5+0HFlhZ08iKybW/wGeAmklmjBjfpp34n5VyLWAdTMfkkWvJVIw
	 XpI5lkniQMdQw==
Date: Thu, 21 Nov 2024 12:36:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Revert "delay: Rework udelay and ndelay"
Message-ID: <Zz8bOYgVrFEBPRrd@localhost.localdomain>
References: <20241121095542.3684712-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121095542.3684712-1-wenst@chromium.org>

Le Thu, Nov 21, 2024 at 05:55:38PM +0800, Chen-Yu Tsai a écrit :
> This reverts commit 19e2d91d8cb1f333adf04731f2788ff6ca06cebd.
> 
> Journald was recently observed to continuely crash at startup, causing
> the system to not be able to finish booting. This was observed locally
> on my MT8195 based Chromebook while doing development, and on KernelCI
> on a MT8192 based Chromebook [1].
> 
> A bisect found this commit to be the first bad commit. Reverting it
> seems to have fixed the issue.
> 
> [1] https://lava.collabora.dev/scheduler/job/16123429
> 
> Fixes: 19e2d91d8cb1 ("delay: Rework udelay and ndelay")
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Ah wait, can you please try this instead?

diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
index 76cf237b6e4c..03b0ec7afca6 100644
--- a/include/asm-generic/delay.h
+++ b/include/asm-generic/delay.h
@@ -75,11 +75,11 @@ static __always_inline void ndelay(unsigned long nsec)
 {
 	if (__builtin_constant_p(nsec)) {
 		if (nsec >= DELAY_CONST_MAX)
-			__bad_udelay();
+			__bad_ndelay();
 		else
 			__const_udelay(nsec * NDELAY_CONST_MULT);
 	} else {
-		__udelay(nsec);
+		__ndelay(nsec);
 	}
 }
 #define ndelay(x) ndelay(x)


Thanks!

