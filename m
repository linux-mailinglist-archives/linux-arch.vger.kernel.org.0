Return-Path: <linux-arch+bounces-1059-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0718813B7C
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 21:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2391F2167E
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 20:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FA369795;
	Thu, 14 Dec 2023 20:26:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EBE675CD;
	Thu, 14 Dec 2023 20:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AE4C433C8;
	Thu, 14 Dec 2023 20:26:53 +0000 (UTC)
Date: Thu, 14 Dec 2023 15:27:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Linux Arch
 <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3] ring-buffer: Remove 32bit timestamp logic
Message-ID: <20231214152740.24d01893@gandalf.local.home>
In-Reply-To: <20231214151911.2df9f845@gandalf.local.home>
References: <20231214125433.03091e5e@gandalf.local.home>
	<CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
	<20231214151911.2df9f845@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 15:19:11 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> For this issue of the 64bit cmpxchg, is there any config that works for any
> arch that do not have a safe 64-bit cmpxchg? At least for 486, is the
> second half of the if condition reasonable?
> 
> 	if (IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_X86_CMPXCHG64)) {
> 		if (unlikely(in_nmi()))
> 			return NULL;
> 	}

Ignore this, I'm now reading your other email. I'll have more questions there.

-- Steve

