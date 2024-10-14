Return-Path: <linux-arch+bounces-8126-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1D399DA5E
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 01:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CBD1F22960
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 23:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A52F1D26F7;
	Mon, 14 Oct 2024 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNRIBMNF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222951E4A6;
	Mon, 14 Oct 2024 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950082; cv=none; b=JWoPg6trbxuwtv4Ldi2yFYpLs0Ufv0isvF+W8C6DibzD52KLiWpJwVfE4BtyiSfc6hkC+l1229+r5eiFHkWILaSz1PVgJOWdlyiWIZxvhA84TNxXSycmVnp1fJOYp7mTjUmMtiwkvtQ6pZx4O7Dn6qI7OaVokr9xBaUBoZO3E04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950082; c=relaxed/simple;
	bh=YowjbaWlK7+JmdK2cSGCF0LIn51aTIpLQu82ZA9VRKQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qwqGtACKMcSbHVW3iYZp35pWxHBN9efNtexSXIruO6B2G+Idcla28D+77E1kv2OhSTuOpoRem+yAoM/F9q4R1Cg8AbX/f115No6FBmZO28u9oXdC9XrgHypB00L69qvGUsgAFCv0OU69WQtpsPtx46Zvkqh7owj2U4sGcjiILrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNRIBMNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EC9C4CEC3;
	Mon, 14 Oct 2024 23:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728950081;
	bh=YowjbaWlK7+JmdK2cSGCF0LIn51aTIpLQu82ZA9VRKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VNRIBMNFuX6xKvfrbvnhLyVxuHRrQcyQ0C4i5H2qTWFhIeGafSBmwi7AAs7vDsF6A
	 HthD42Bt8Flv1P9Of0vgkhgyJ5L+OgDaOvQJPzy7xf08fhlxA+48lpk5Hg9H5Nfy5T
	 7444VfKA1vZZionXjH/4EYJgMyPz9BAsoMsixQD2Imd0GbL/PetRf7hchMKeMvK/DB
	 Hioc83ipFRHM/zjAIPgMdRnGXiePSLxbxm1bOkzqYXSaGjZ59maOCx5H3PHsWE9BDV
	 8SSHdGmF2+wycbC4JV4jWiqlDP/ixPWVbrgA9cfOJRB0rbzZl/mKRf4WZjQDs7e/bZ
	 R6q10zaw/Q7yg==
Date: Tue, 15 Oct 2024 08:54:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, <linux-arch@vger.kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, Will Deacon <will@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Catalin
 Marinas <catalin.marinas@arm.com>
Subject: Re: [for-next][PATCH 4/4] ftrace: Consolidate ftrace_regs accessor
 functions for archs using pt_regs
Message-Id: <20241015085434.afeaac72d7cae61bf00af3b5@kernel.org>
In-Reply-To: <20241011132956.899228335@goodmis.org>
References: <20241011132941.339392460@goodmis.org>
	<20241011132956.899228335@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve,

I found one problem on this patch while debugging my series;

On Fri, 11 Oct 2024 09:29:45 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> -#define ftrace_regs_get_argument(fregs, n) \
> -	regs_get_kernel_argument(&arch_ftrace_regs(fregs)->regs, n)

As you can seem most arch uses "arch_ftrace_regs()" macro
for ftrace_regs_*() macros. This is because we are sure
this ftrace_regs is not fully compatible with pt_regs.


> +#define ftrace_regs_get_instruction_pointer(fregs) \
> +	instruction_pointer(arch_ftrace_get_regs(fregs))

However, these consolidated macros in ftrace_regs.h are
using "arch_ftrace_get_regs()" macro, which can return NULL
if FL_SAVE_REGS is not set.

So, those should use arch_ftrace_regs() as original code
does.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

