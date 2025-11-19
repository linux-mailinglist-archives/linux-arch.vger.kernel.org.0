Return-Path: <linux-arch+bounces-14961-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDA9C70A9C
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 19:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E23E84E1FC8
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C7F2C2353;
	Wed, 19 Nov 2025 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oj6dh3QF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7A316912
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577238; cv=none; b=rcNSpTX4MUVwOMdDjm8FRUHxRFRrLdPTvMuYNicbat4dvmMM8BwW4HXuVXt9N5m8Gnd9qTYrUTjCfv10yfII2QZxj2+i6mlJRxtFqmlmvz/a4VXOO6PUjrvsjMLgWA0A76BzYieRgR0TgXoC7SWKh3t33Q1lRrKJAjNc8PPPNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577238; c=relaxed/simple;
	bh=isuSe0vHAL4pBqh4kPYeDqNJgvukP3SkbC0ClCMHi/U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dNZYyqiDB8qSiI8PHqiv/4BDhX3N/9XCokamk8WP+I2r7JFjzcc4HNSccObgYArzyZh3o7zUmvubaX2eNSLkRDAOInexWOJ9MkOH99EetmFMLGT1G7ZxUHSKTxOzx1WqNRI+t16343f/sbKXkd1MCSKT+9E7D6rmWFaNHqDfhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oj6dh3QF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AEEC4CEF5;
	Wed, 19 Nov 2025 18:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763577238;
	bh=isuSe0vHAL4pBqh4kPYeDqNJgvukP3SkbC0ClCMHi/U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Oj6dh3QF2+yqHgZl00hjnXzhiNz+Kd5gYv4Mj4vHnoLuipqptSvCQU/ENuPdlJrkM
	 QCZqRhvmmZXjGd/NFfGhOlECLddt5EAF6gsnDbdre02U3ZehF2T2bdHQYrvGRRjZRI
	 KIUnyGtdsfnJYxILq0DcK0YYT7H1xJuQ214CUgOUoDfVAz3tSQPe6BZ8jeuzAcBm1p
	 wXft2yGvOtlxxVS/f2uFljuXnVnBuAEiQdQEuRS49EJQ/cQJ3m8lwZTWNnHhaozgGs
	 apJhTg7BHqj7YbEppl1GoT03u3M/p2wK2rr8z7Rl1f58PwIPr+i0ClaOfchr52lQVa
	 yxyq/528F3qvw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8AE21F40084;
	Wed, 19 Nov 2025 13:33:55 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 19 Nov 2025 13:33:55 -0500
X-ME-Sender: <xms:kw0eaXtHW_hPzTjGGcVhcydgSpeOMQsuqt-CDQ2ce8lXwh_2XkBDew>
    <xme:kw0eaTTFCCwjUA8kF8nkRRywEr7igPyQ-OlA6aLIu76kha6OTU-uEILXGlFKbpWmH
    l1XsdpwdhUBo5Q6bK0a2g_fD9owfX20pc_Ddgru3Du8XugMOTSVRBE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepjeejvddvtdehffdtgfejjeefgefgjeeggfeuteeiuedvtefgfffhvdej
    iefguedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudekheei
    fedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrd
    hluhhtohdruhhspdhnsggprhgtphhtthhopeegledpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhgsrghrohhnsegrkhgrmhgrihdrtghomhdprhgtphhtthhopegsphesrg
    hlihgvnhekrdguvgdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthht
    ohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmrghthhhivg
    hurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthhopegsohhq
    uhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehurhgviihkihesghhmrg
    hilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhr
    tghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:kw0eaUKcvBX6ZqDb2Zfz2lS6ZTPn-nXSDUpeDQirQ9WsFITs37m1FA>
    <xmx:kw0eadq2-jmwILaPpoRuPfN2N1yM3Y8zfKpCUT6xaUllbcz1l4r_ww>
    <xmx:kw0eaY_jsr-_Ab2g_NL1wFjttUgbqyW25dTE8Gwsk4BL2Ms0a7Nw1g>
    <xmx:kw0eaY-o7o-_VANLMjD5K5xLI3aUCtOQ36zJ9mu52nOwG5c_vbE8HA>
    <xmx:kw0eaT6PvxdLshew8G6EsocVLck8YE1dY0HQ7jptKjjUdBShZ13KNOpC>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4771A700054; Wed, 19 Nov 2025 13:33:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1wO5D87xXUg
Date: Wed, 19 Nov 2025 10:33:35 -0800
From: "Andy Lutomirski" <luto@kernel.org>
To: "Dave Hansen" <dave.hansen@intel.com>,
 "Valentin Schneider" <vschneid@redhat.com>,
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
Message-Id: <292ebf6a-4a7a-43b2-a670-ea53728f2c06@app.fastmail.com>
In-Reply-To: <bad9eaaa-561a-498a-90d1-fe3a3ab8ba37@intel.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <20251114151428.1064524-10-vschneid@redhat.com>
 <bad9eaaa-561a-498a-90d1-fe3a3ab8ba37@intel.com>
Subject: Re: [RFC PATCH v7 30/31] x86/mm, mm/vmalloc: Defer kernel TLB flush IPIs under
 CONFIG_COALESCE_TLBI=y
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Nov 19, 2025, at 10:31 AM, Dave Hansen wrote:
> On 11/14/25 07:14, Valentin Schneider wrote:
>> +static bool flush_tlb_kernel_cond(int cpu, void *info)
>> +{
>> +	return housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE) ||
>> +	       per_cpu(kernel_cr3_loaded, cpu);
>> +}
>
> Is it OK that 'kernel_cr3_loaded' can be be stale? Since it's not part
> of the instruction that actually sets CR3, there's a window between wh=
en
> 'kernel_cr3_loaded' is set (or cleared) and CR3 is actually written.
>
> Is that OK?
>
> It seems like it could lead to both unnecessary IPIs being sent and for
> IPIs to be missed.

I read the code earlier today and I *think* it=E2=80=99s maybe okay. It=E2=
=80=99s quite confusing that this thing is split among multiple patches,=
 and the memory ordering issues need comments.

The fact that the big flush is basically unconditional at this point hel=
ps. The fact that it=E2=80=99s tangled up with CR3 even though the curre=
nt implementation has nothing to do with CR3 does not help.

I=E2=80=99m kind of with dhansen though =E2=80=94 the fact that the impl=
ementation is so nasty coupled with the fact that modern CPUs can do thi=
s in hardware makes the whole thing kind of unpalatable.

>
> I still _really_ wish folks would be willing to get newer CPUs to get
> this behavior rather than going through all this complexity. RAR in
> particular was *specifically* designed to keep TLB flushing IPIs from
> blipping userspace for too long.

