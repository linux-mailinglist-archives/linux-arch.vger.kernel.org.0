Return-Path: <linux-arch+bounces-8196-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910C999FC96
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 01:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D4E1F25CCB
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 23:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9101D63DA;
	Tue, 15 Oct 2024 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjFwOzi2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019621E3D9;
	Tue, 15 Oct 2024 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036050; cv=none; b=l8AfOruZWja4OA3mveG/3eF4kAiQVNTNyjhc9ag+G+UpiLHyIsM5lfOxLa/bMVc2WzG95Nh9VF8v2ruqMBCqzT5b6NzBjU+DPT/6CaSLoGrTXA+FQ7Dro8kw7GRdJBbJzKH1puyfumvBFl2ad05nSWjLWsOf1B3kpVHOsa/K2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036050; c=relaxed/simple;
	bh=OvwqGNg+FxCMd+bUiVx6t9oUkTAZwabidrToATtsBZo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dCJGqJNGWVndaWvaliAE/a1JsB+nusIE5nDmEyaVqMqNVZVJnQsYR43FoNTj/5gTBUyEf+V5eLtsTVVi6DXU/xcmz0+kpz/Vs/7CHdVv/vwOmIj/az66e/K0eD87SoYyS2J3TWWtlFtIwhaMNy+KTpUmUoo3PYp+ovEkpFf7bQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjFwOzi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10305C4CEC6;
	Tue, 15 Oct 2024 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729036049;
	bh=OvwqGNg+FxCMd+bUiVx6t9oUkTAZwabidrToATtsBZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XjFwOzi2BliEFHr+mGq0ODCDL238vAdqMfZ+s41eKB2FB5V7KXhajAwS2L46Rfper
	 ZodWMS1neWVUueTnfBkkObZ+M93Vq5sG6dJSNb0vYXnwnOV4pRu4+Gj37Fdh65lKby
	 /rpVuutyVVxt8YRTdZYlC+8y+WjDIs4gDi7U+YTcPwV5K7I5khODfpX1POmHrWZTCM
	 Yol/TGyYVmS2T9RvM1MPr/V4e10Rod/3W2+pofvPUgXLWe0ifC2M+It4RXbNxVcGO0
	 z3MqRNYDsCqDm/ZfS8jzEM4Jyq5Oq/daHmM1OeAkBjA4DdJukTb0HfcdxJiwgZDcS1
	 btQhbLNgy8rZA==
Date: Wed, 16 Oct 2024 08:47:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v16 04/18] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-Id: <20241016084720.828fefb791af4bcf386aac91@kernel.org>
In-Reply-To: <20241015183906.19678-B-hca@linux.ibm.com>
References: <172895571278.107311.14000164546881236558.stgit@devnote2>
	<172895575716.107311.6784997045170009035.stgit@devnote2>
	<20241015183906.19678-B-hca@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 20:39:06 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> That would make things much simpler... e.g. your new patch is also
> writing r3 to fregs, why? 

BTW, according to the document [1], r3 is for "return value 1", isn't it
used usually?

[1] https://www.kernel.org/doc/Documentation/s390/Debugging390.txt

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

