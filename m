Return-Path: <linux-arch+bounces-7664-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E6A98F435
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 18:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A89D281308
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582D519F42F;
	Thu,  3 Oct 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VlXUoyhp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA9616C453;
	Thu,  3 Oct 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972747; cv=none; b=qsD59aVJhYAWJg5m5oT6kPwHwQTyKwEQ1nVGp2wpU2tr+kg+Mmd3Vrw7vxBpMox4ImAw5WHYSrL2ZLcSjOP2tRzwFl9RLgIpLWG3am0v8YPEXh4R7e5j/4zC6VOvPPgGhoLPPim2hhsdLMUvx9CBrz1RDqlzWE+PDx2VyO2ztmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972747; c=relaxed/simple;
	bh=USLEweTGJymXhXv7eBQulPevX7CEgY2+fgwzsN1iPoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBKn5PyvdyNki8JTJNXVqNfx7yHhcSmvU03dSYVbLsPqReOxmiRBdcvXLUbUFLQRcL7WP1EPpf0CYoBw+aeJu57CrMeNNmNC75YlvznrHfj8DwhGMP0Hv31jVEO10Wkl+7wF3lDsCx7P4uhNJbxikkYhH/LkXYiRZ9kdt91FPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=VlXUoyhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EF2C4CEC5;
	Thu,  3 Oct 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VlXUoyhp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727972741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClYl+eTvQokHZH+ZMdhMwgOv5mTOoQLSWRaEYaDXOqk=;
	b=VlXUoyhpJEZPsB8PYiwgkqdtpT4Rsh9pLuzEOl4VA62I5ksk85lHczrTDitXIzX36bN4XK
	BlntSrY6sWiYO8rjWUARzd4f750kzpUGoGX35qhKI5SpbZX5XG/MLq7JndYdxjQQKWpzrC
	A9c1FXilE1h+uldeiFRu+5cMvFldxa0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2fcd18b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Oct 2024 16:25:40 +0000 (UTC)
Date: Thu, 3 Oct 2024 18:25:36 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 0/2] vdso: Use only headers from the vdso/ namespace
Message-ID: <Zv7FgA2IsROBNqky@zx2c4.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003152910.3287259-1-vincenzo.frascino@arm.com>

On Thu, Oct 03, 2024 at 04:29:08PM +0100, Vincenzo Frascino wrote:
> The series has been rebased on [1] to simplify the testing. 
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git master

Just FYI, tglx is doing some heavy vDSO work this cycle, so if this is
to land, it'll most likely go via his tip tree, not my random tree.

