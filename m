Return-Path: <linux-arch+bounces-14957-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B577C707FE
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 18:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DC9B35ACE7
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D22A30FF24;
	Wed, 19 Nov 2025 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdqOuymp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B011364EB3;
	Wed, 19 Nov 2025 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763573522; cv=none; b=K948AjLfV2z0cTWQpSBx2plwO91gH6ToBmiwOZ+/Lc27SM7wexaZ/VTnUbWuMc+wqoGOCwt1e3Na/ob6bh9JNR3Yax5ZjQIpAFC5Mt0o8dxozqA4PUWI6VlK0eqEhWQ0nGZKxfDy6g59t26yY7Dnr3v4BDqrXKJbefhTW++d6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763573522; c=relaxed/simple;
	bh=/t2oTQtncuM/mvzgreWw/hJ7gSFNgj07SaGnfOfObKg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Mt5yQ48DZIrERZtBs2l6Iw38fka5Gh80NG7/Fxq1TTkqE+CNCizRvLyCnvpV1+0yZaNJ44/Q00GLgrwK08/vkgmLAGe7jbpW/3HKg0Oyoy0FTn7MnFtsMojLl8E/zGz6GYX3vlLtY9e0DPGdv86gjcrM4DzKOJERZdaLz+s0wdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdqOuymp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51471C116C6;
	Wed, 19 Nov 2025 17:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763573521;
	bh=/t2oTQtncuM/mvzgreWw/hJ7gSFNgj07SaGnfOfObKg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=KdqOuympGFQjKVKxCMIy8G0GAxGGFh55JJngpEAScQHQGWRysLKwPaRaPGp4qCDc1
	 8btnkJMxNykpl0kqln4Hku4Rl7Wl6/H+ZbSDO9x3qt7/BMn8RhxRLMyNCYFiQ1dFGj
	 F5bg0iS4PkrQC2NupcpUKMQJhzkMg4j1Ut1JLm54fGbqMQlfMv8aGSw8ofIhj60/6k
	 LiWxVlRPgCl2E0x3jG55+VQjf7Lo24Qok6kiHWDwrJlVZJNvbPc6FJwfRvWJuarmi8
	 h25G+4xIYjDKJYHN9BIr4was3SRjf1u+E/4z6iCp01yeGHECgheE+ihNjFtF4ocDTl
	 c7OkIUzT+g7Iw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 15FF1F4006F;
	Wed, 19 Nov 2025 12:31:59 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 19 Nov 2025 12:31:59 -0500
X-ME-Sender: <xms:Dv8daYw8V6oCHt7IdscAKP7ZmNBGAa5l2QAwxtemNAhqmc86Cvmz2w>
    <xme:Dv8daXFjKfxoLeyJ2tQ-LMwJMhCMviHudxhtJj_7W7G9StSFxeNFWZzqbW4KphyxD
    U3EneA33cqOoXiVDgcMLskQ2oHKFwMim-OnIq2k97GUUcvqh4MgBwbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdegkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhephffgieeuueevvddvffehiedtteduveejtefhuedtteehfffgieehhfeg
    ffehvddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluhhtoh
    eppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhushdpnhgspghrtghpthht
    ohepgeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjsggrrhhonhesrghkrg
    hmrghirdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohep
    rghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofh
    htrdhnvghtpdhrtghpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhi
    tghiohhsrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhho
    shhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehjrghnnhhhsehgohhogh
    hlvgdrtghomh
X-ME-Proxy: <xmx:Dv8daRCKxEiK-0E-MKjf5NWUbib5nldBL-kYR9iWEijS3CsfVa89kg>
    <xmx:D_8daX6x1rtaemMXGl1UUQ-GckmNeRG7S9C0cE8st-Pfk6O6QPlNqQ>
    <xmx:D_8daW0MQGOGXibaGRTJmbXnHuAS5PAeFiV8Msmu0BCYqd_QjRTjZA>
    <xmx:D_8daQVCyt9OWVjQ8WbjKcJmpn9xIBLHN3rVEdTmsuxpWYuoTd_HUQ>
    <xmx:D_8daTkZEglornIN3N4-CtsqujdAUXdXlIbQgLT3HNoWB_wXN4CqSIGu>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D1DC6700063; Wed, 19 Nov 2025 12:31:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2ZwPDH9FoLc
Date: Wed, 19 Nov 2025 09:31:37 -0800
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
Message-Id: <91702ceb-afba-450e-819b-52d482d7bd11@app.fastmail.com>
In-Reply-To: <xhsmhecpukowa.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <20251114151428.1064524-9-vschneid@redhat.com>
 <65ae9404-5d7d-42a3-969e-7e2ceb56c433@app.fastmail.com>
 <xhsmhecpukowa.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Subject: Re: [RFC PATCH v7 29/31] x86/mm/pti: Implement a TLB flush immediately after a
 switch to kernel CR3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Wed, Nov 19, 2025, at 7:44 AM, Valentin Schneider wrote:
> On 19/11/25 06:31, Andy Lutomirski wrote:
>> On Fri, Nov 14, 2025, at 7:14 AM, Valentin Schneider wrote:
>>> Deferring kernel range TLB flushes requires the guarantee that upon
>>> entering the kernel, no stale entry may be accessed. The simplest wa=
y to
>>> provide such a guarantee is to issue an unconditional flush upon swi=
tching
>>> to the kernel CR3, as this is the pivoting point where such stale en=
tries
>>> may be accessed.
>>>
>>
>> Doing this together with the PTI CR3 switch has no actual benefit: MO=
V CR3 doesn=E2=80=99t flush global pages. And doing this in asm is prett=
y gross.  We don=E2=80=99t even get a free sync_core() out of it because=
 INVPCID is not documented as being serializing.
>>
>> Why can=E2=80=99t we do it in C?  What=E2=80=99s the actual risk?  In=
 order to trip over a stale TLB entry, we would need to deference a poin=
ter to newly allocated kernel virtual memory that was not valid prior to=
 our entry into user mode. I can imagine BPF doing this, but plain noins=
tr C in the entry path?  Especially noinstr C *that has RCU disabled*?  =
We already can=E2=80=99t follow an RCU pointer, and ISTM the only style =
of kernel code that might do this would use RCU to protect the pointer, =
and we are already doomed if we follow an RCU pointer to any sort of mem=
ory.
>>
>
> So v4 and earlier had the TLB flush faff done in C in the context_trac=
king entry
> just like sync_core().
>
> My biggest issue with it was that I couldn't figure out a way to instr=
ument
> memory accesses such that I would get an idea of where vmalloc'd acces=
ses
> happen - even with a hackish thing just to survey the landscape. So wh=
ile I
> agree with your reasoning wrt entry noinstr code, I don't have any way=
 to
> prove it.
> That's unlike the text_poke sync_core() deferral for which I have all =
of
> that nice objtool instrumentation.
>
> Dave also pointed out that the whole stale entry flush deferral is a r=
isky
> move, and that the sanest thing would be to execute the deferred flush=
 just
> after switching to the kernel CR3.
>
> See the thread surrounding:
>   https://lore.kernel.org/lkml/20250114175143.81438-30-vschneid@redhat=
.com/
>
> mainly Dave's reply and subthread:
>   https://lore.kernel.org/lkml/352317e3-c7dc-43b4-b4cb-9644489318d0@in=
tel.com/
>
>> We do need to watch out for NMI/MCE hitting before we flush.

I read a decent fraction of that thread.

Let's consider what we're worried about:

1. Architectural access to a kernel virtual address that has been unmapp=
ed, in asm or early C.  If it hasn't been remapped, then we oops anyway.=
  If it has, then that means we're accessing a pointer where either the =
pointer has changed or the pointee has been remapped while we're in user=
 mode, and that's a very strange thing to do for anything that the asm p=
oints to or that early C points to, unless RCU is involved.  But RCU is =
already disallowed in the entry paths that might be in extended quiescen=
t states, so I think this is mostly a nonissue.

2. Non-speculative access via GDT access, etc.  We can't control this at=
 all, but we're not avoid to move the GDT, IDT, LDT etc of a running tas=
k while that task is in user mode.  We do move the LDT, but that's quite=
 thoroughly synchronized via IPI.  (Should probably be double checked.  =
I wrote that code, but that doesn't mean I remember it exactly.)

3. Speculative TLB fills.  We can't control this at all.  We have had ac=
tual machine checks, on AMD IIRC, due to messing this up.  This is why w=
e can't defer a flush after freeing a page table.

4. Speculative or other nonarchitectural loads.  One would hope that the=
se are not dangerous.  For example, an early version of TDX would machin=
e check if we did a speculative load from TDX memory, but that was fixed=
.  I don't see why this would be materially different between actual use=
rspace execution (without LASS, anyway), kernel asm, and kernel C.

5. Writes to page table dirty bits.  I don't think we use these.

In any case, the current implementation in your series is really, really=
, utterly horrifically slow.  It's probably fine for a task that genuine=
ly sits in usermode forever, but I don't think it's likely to be somethi=
ng that we'd be willing to enable for normal kernels and normal tasks.  =
And it would be really nice for the don't-interrupt-user-code still to m=
ove toward being always available rather than further from it.


I admit that I'm kind of with dhansen: Zen 3+ can use INVLPGB and doesn'=
t need any of this.  Some Intel CPUs support RAR and will eventually be =
able to use RAR, possibly even for sync_core().

