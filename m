Return-Path: <linux-arch+bounces-14914-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D38EC6F68C
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A48438558D
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBBD325724;
	Wed, 19 Nov 2025 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ea4bojU3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A1E30FC07
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562714; cv=none; b=NT4UXxYHaNgwoxfzo1S5Cd/o0xnHknuUezKm/v6BhbASyiBt4Io4DOyjPxwqxipQxG+vQVrREv42kpy/8bu61+maJiDo498rEM6P0BQ23TpSunhORpWDK/4yO0ck2Zk7GOFJQ5TkpL0H9QkK+jvipMUZZJ47O1FLp+hOfqioF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562714; c=relaxed/simple;
	bh=t7JHEvub1bQJal+g6fm+oWNxS6WRDvkPwGmxdErav44=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bdV0FctDUZNhYbNZnPxgeVwSB7XNzWG3GXxuC58KjR8zHTtVpu9ZoHg1ydQOTLgGjQDT1D9UtLbJE/qQsV4wT2+BOwrN5m3em6LRwwPdpTCM8vah4B8Nxtt/bVeiHtMyeAtcAK4EAArbK6aya8iZ2rGxZr3n9Pprm81H9JHSSqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ea4bojU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E319EC2BCB0;
	Wed, 19 Nov 2025 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763562714;
	bh=t7JHEvub1bQJal+g6fm+oWNxS6WRDvkPwGmxdErav44=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Ea4bojU3b4uuNYkYVwnmXHYKrqlrEyIaRN7/uuLqQ0tjPkP+0CBl8L7OWP74jMhkR
	 6BEZWebMdOXDsVMaFdTA/3c4Ol/FfmWfZJ7I77nIstjY/8MxmX60jwnojnAv9c5OB6
	 yiaxqYjeyx5Rbc+bcCTpfw9nnAVkEBGMQ7n8TQ68Sdv8V0/fXWca/2aZJ+PdDOCe1Z
	 fgqUw43kE8xbSlEr9OaiWF6IUiQPM10iJQo0m7vG74uwaC7eKHKSOTyPWFK+IxX8Cr
	 NCsa459K8S2l9VNSLvncI+/+4fDDtvhtPnwSSP5VIBtd53subUnkzEeGp3uNl9yo2f
	 QaAOeHd7myqGw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 560CFF4008D;
	Wed, 19 Nov 2025 09:31:51 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 19 Nov 2025 09:31:51 -0500
X-ME-Sender: <xms:19Qdaap8BjsJbFtssqDUjnsMU_LQS_YP23cqGo1hqasAALMZnLH2Jw>
    <xme:19QdaTekCirxoT8xxcC2RnapN71lsrezhBKHk9cWFJTrytiWHrCnoOSQ_WG25jLgz
    VLVYir4VtevPFlszmb_dX0zPBndPMUq9wQrH4t08wLIbtcqw1mEIP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeggeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepjeejvddvtdehffdtgfejjeefgefgjeeggfeuteeiuedvtefgfffhvdej
    iefguedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudekheei
    fedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrd
    hluhhtohdruhhspdhnsggprhgtphhtthhopeegkedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhgsrghrohhnsegrkhgrmhgrihdrtghomhdprhgtphhtthhopegsphesrg
    hlihgvnhekrdguvgdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthht
    ohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmrghthhhivg
    hurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthhopegsohhq
    uhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehurhgviihkihesghhmrg
    hilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhr
    tghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:19QdaSQxr3HQaS5D5svYtdioLzJ9DrcJWaaCXygndJcKZTp8DQA1XQ>
    <xmx:19QdaRuKJfSzLCcUvQaFs6zUjI1C5yzQpwXIrnbakBUBZf6Go7P5Dw>
    <xmx:19QdaRsZ04AgZVVF3BYyQvlnngCHXui5cx1xuooIBwrJs48FrjqOhQ>
    <xmx:19QdaZdxW-cnpAjF52S13LU5nKqG8Kl70x0BiZJ1Wz-zYL2XACcj4g>
    <xmx:19QdaU7njPzMtRawVt5wHwKl1sfmi7DCVtIMkE__tcglxZK-V1ApZbUe>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1FAFE700054; Wed, 19 Nov 2025 09:31:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2ZwPDH9FoLc
Date: Wed, 19 Nov 2025 06:31:30 -0800
From: "Andy Lutomirski" <luto@kernel.org>
To: "Valentin Schneider" <vschneid@redhat.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, rcu@vger.kernel.org,
 "the arch/x86 maintainers" <x86@kernel.org>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Arnd Bergmann" <arnd@arndb.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Jason Baron" <jbaron@akamai.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Josh Triplett" <josh@joshtriplett.org>,
 "Boqun Feng" <boqun.feng@gmail.com>,
 "Uladzislau Rezki" <urezki@gmail.com>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Mel Gorman" <mgorman@suse.de>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Han Shen" <shenhan@google.com>, "Rik van Riel" <riel@surriel.com>,
 "Jann Horn" <jannh@google.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Oleg Nesterov" <oleg@redhat.com>, "Juri Lelli" <juri.lelli@redhat.com>,
 "Clark Williams" <williams@redhat.com>,
 "Yair Podemsky" <ypodemsk@redhat.com>,
 "Marcelo Tosatti" <mtosatti@redhat.com>,
 "Daniel Wagner" <dwagner@suse.de>, "Petr Tesarik" <ptesarik@suse.com>,
 "Shrikanth Hegde" <sshegde@linux.ibm.com>
Message-Id: <65ae9404-5d7d-42a3-969e-7e2ceb56c433@app.fastmail.com>
In-Reply-To: <20251114151428.1064524-9-vschneid@redhat.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <20251114151428.1064524-9-vschneid@redhat.com>
Subject: Re: [RFC PATCH v7 29/31] x86/mm/pti: Implement a TLB flush immediately after a
 switch to kernel CR3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Nov 14, 2025, at 7:14 AM, Valentin Schneider wrote:
> Deferring kernel range TLB flushes requires the guarantee that upon
> entering the kernel, no stale entry may be accessed. The simplest way =
to
> provide such a guarantee is to issue an unconditional flush upon switc=
hing
> to the kernel CR3, as this is the pivoting point where such stale entr=
ies
> may be accessed.
>

Doing this together with the PTI CR3 switch has no actual benefit: MOV C=
R3 doesn=E2=80=99t flush global pages. And doing this in asm is pretty g=
ross.  We don=E2=80=99t even get a free sync_core() out of it because IN=
VPCID is not documented as being serializing.

Why can=E2=80=99t we do it in C?  What=E2=80=99s the actual risk?  In or=
der to trip over a stale TLB entry, we would need to deference a pointer=
 to newly allocated kernel virtual memory that was not valid prior to ou=
r entry into user mode. I can imagine BPF doing this, but plain noinstr =
C in the entry path?  Especially noinstr C *that has RCU disabled*?  We =
already can=E2=80=99t follow an RCU pointer, and ISTM the only style of =
kernel code that might do this would use RCU to protect the pointer, and=
 we are already doomed if we follow an RCU pointer to any sort of memory.

We do need to watch out for NMI/MCE hitting before we flush.

