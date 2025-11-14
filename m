Return-Path: <linux-arch+bounces-14795-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF1AC5F2F8
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 21:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A1FB4E1EDD
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 20:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45676342517;
	Fri, 14 Nov 2025 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YK9eEZEa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Zyc6PyP"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDBA2D9780;
	Fri, 14 Nov 2025 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150799; cv=none; b=Y1ZBp32yerfegZLLfojCvRdsovyoOc8A9V+SP5zPdt/jKENRXEevivHljmNQpN8eMiA2eC/uNWElK9i4CCfbVMNFTX8cNS94Lh1eZaV/XLdjJStVpfGxNmA0aJ6nqIB+YjE15v5fZtwtquuYHRyNN7DTeo1rR5ngvOEH1YxTuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150799; c=relaxed/simple;
	bh=TIDmqQudIf68egjfbjX/UD1YyPYjDAPME3UzGD537xw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=szcw/NSupN6GUcignlwU+iokAdXyDQ5uOWC1sO79o/6a4PTuLQVftZDRpR/PPCFBxXP21Za7NjN44RNu4ONZzCft3wYwzObx1OSyy8vYMBvcLq0rlH3a/cLisFZDYh+KfnRDOP/s4esQh7KivB3vcWnHlUpJdEBA/dKdIhGoG3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YK9eEZEa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Zyc6PyP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763150795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOqB4C/lS20t6tPC5FIrQm+ReT0eGwkkWKV6KUVlY+c=;
	b=YK9eEZEalWaKmf+x8aV4nBEexkqfsmiKreG3Y2jkPgAgLWTY9R8IBAqeSpkzvcfTlK/5vT
	+O81wGsZ0UIeJ5jBhUw4Eoayfv/X/R8/YAkUQfbLySwBD+nR9giKh2lTUX2IuXR2sbXviX
	FoDaeDfQYEVnADDuXPIQ/3NYR3mHOmWH0metLgocPmrm5KlONkA2MI+xuHLeh3MThztb1A
	kXnDdCaO2sDMKHkhrx9itHQBX0xVNdyadNovuurLFgsetAEAqd8BZzCxmcKF/5SsAQ1SuC
	9Fvj3cEHnJH7K5iz+x8gAJ7PDgm0830h9iPB4luicMqudfO8UPSUoF00Q35K7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763150795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JOqB4C/lS20t6tPC5FIrQm+ReT0eGwkkWKV6KUVlY+c=;
	b=1Zyc6PyPyhUajFuS2x9XsSMHMGTgSzQMRTnNoHUVo4zlrqPxJr60WPV70Jazg4G37kJhwh
	jOcgXkNRpr6vopAw==
To: Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, rcu@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd
 Bergmann <arnd@arndb.de>, Frederic Weisbecker <frederic@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 "David S. Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH v7 00/31] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <1a911310-4ca5-45a4-b9bf-5f37c6ab238e@app.fastmail.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <c4768cf3-f131-44e6-9b25-ebeb633f32ee@app.fastmail.com>
 <beb46a02-b902-438b-8b6d-b5f0d7ad0ae6@app.fastmail.com>
 <89398bdf-4dad-4976-8eb9-1e86032c8794@paulmck-laptop>
 <1a911310-4ca5-45a4-b9bf-5f37c6ab238e@app.fastmail.com>
Date: Fri, 14 Nov 2025 21:06:34 +0100
Message-ID: <87zf8o9y5x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 14 2025 at 10:45, Andy Lutomirski wrote:
> But I did that test on a machine that would absolutely benefit from
> the IPI suppression that the OP is talking about here, and I think it
> would be really quite nice if a default distro kernel with a more or
> less default distribution could be easily convinced to run a user
> thread without interrupting it.  It's a little bit had that NO_HZ_FULL
> is still an exotic non-default thing, IMO.

Feel free to help with getting it over the finish line. Feeling sad/bad
(or whatever you wanted to say with 'had') does not change anything as
you should know :)

Thanks,

        tglx

