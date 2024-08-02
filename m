Return-Path: <linux-arch+bounces-5934-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01F945F03
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 16:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E69C5B2347F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E30111CB8;
	Fri,  2 Aug 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG/BvCXv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1265258;
	Fri,  2 Aug 2024 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607219; cv=none; b=hC2H6zK2aSdNnZOoAWKi9ePoxWXIzg9OHmqfqh/kxxH3ySEd46gg/vzp1Inndd5eVqVvFPCOdmuKYXScjxK6aiV104ZkuH+f2WdA868YWNHZyW/KjO2ZE4qcpMedszl3R7rCSDLWM2xpY7xGoaLpv7SgW7/CVBCKjIIumeYeQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607219; c=relaxed/simple;
	bh=mUHev5+wVFteh2AXlxax3nVXkSA/YXwRUNjtnJNhS/0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XRjQQYPm6tWr3OvgFYHGGtl/mXMLuqINzTMLRWJN+vOHBBCT7gdAH8V4EG+EwD6cn5uExeAMbMG6jwgmbwoVHP0EBa5y36MBUEnFU1tvOHlAW30ceyFdJN/yJIjWpZNA3X7gXMIAvGFKACUEBxrENxlICM5rTHcJhlVHDpBqFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IG/BvCXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556C3C32782;
	Fri,  2 Aug 2024 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722607219;
	bh=mUHev5+wVFteh2AXlxax3nVXkSA/YXwRUNjtnJNhS/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IG/BvCXvY0pdD/1jBt6YyxN2brYe0X1adt7Np3EwFJ8nm46pkhcnBRggFGuyOZQhv
	 C8MAMSXe7ax1l9oVlSsCJQeOu5o5uc1dt3UWxhRPnSiCWwgFh7hqLUktgkNkg99o20
	 T5/uHc6VbTNQ1zLLp2y5bPokkNUdkNBpYYTlwsdTBx6moQKAj4h5pbmtPTpHD+1tzJ
	 J280i2hmY/UiyY3yYYA/3Z+VyPWqxaCfMtPZAM76vTz9xDea4k4ETaj8+m+sUWdajO
	 9wMz+36Rs98K64/mUDIkWtYNtI41hNg7StHK5+dSmMGqYG6FQyHJ3LrSiqgKTccy96
	 jUGwKzcGODu+Q==
Date: Fri, 2 Aug 2024 23:00:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, x86@kernel.org, "Jiri Olsa"
 <jolsa@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 guoren <guoren@kernel.org>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Kees Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "H.J. Lu" <hjl.tools@gmail.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "Oleg Nesterov" <oleg@redhat.com>, "Andrii Nakryiko" <andrii@kernel.org>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-riscv@lists.infradead.org
Subject: Re: [RFC] uretprobe: change syscall number, again
Message-Id: <20240802230012.938e42a56ff2d0f09ca8100b@kernel.org>
In-Reply-To: <6662ea26-9850-48fd-a67c-01daf412dc2e@app.fastmail.com>
References: <20240730154500.3155437-1-arnd@kernel.org>
	<20240802181437.29b439e26608561f1289892a@kernel.org>
	<6662ea26-9850-48fd-a67c-01daf412dc2e@app.fastmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 Aug 2024 15:18:52 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Fri, Aug 2, 2024, at 11:14, Masami Hiramatsu wrote:
> > On Tue, 30 Jul 2024 17:43:36 +0200 Arnd Bergmann <arnd@kernel.org> wrote:
> >> ---
> >> I think we should fix this as soon as possible. Please let me know if
> >> you agree on this approach, or prefer one of the alternatives.
> >
> > OK, I think it is good. But you missed to fix a selftest code which
> > also needs to be updated.
> >
> > Could you revert commit 3e301b431b91 ("selftests/bpf: Change uretprobe
> >  syscall number in uprobe_syscall test") too?
> 
> I folded the change that Jiri suggested now.

Thanks Jiri and Arnd for fix that!

> 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thanks,
> 
>      Arnd
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

