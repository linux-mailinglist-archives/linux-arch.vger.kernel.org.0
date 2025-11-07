Return-Path: <linux-arch+bounces-14563-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5F3C40217
	for <lists+linux-arch@lfdr.de>; Fri, 07 Nov 2025 14:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F57189BC0F
	for <lists+linux-arch@lfdr.de>; Fri,  7 Nov 2025 13:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EE42D5A14;
	Fri,  7 Nov 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FTwDlunp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ORo5NbN6"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304B62E62A4;
	Fri,  7 Nov 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522418; cv=none; b=QhaahoZqPPwW0YMY3KR3foaVs+WjmlHZgbq9quN6XIUyOOBHx/7oqelMHxpMY7yUEmkTZTMokLzR9txGFD19RhZsDEOj/2oDuXaG87qEe3Uei+JAtvJX4vrhB1Jt9PpibabGCJgUsdiGl6BxSh3V01bj9sqLWS0l82Ukh0ine+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522418; c=relaxed/simple;
	bh=vR1IF9ZdNx9S88huKWq1DbNssn94QpmUI57Qw30wnUU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=F/+monwpedRykG6v6TtLTqsP6P5n7nTYxBaN8gJ9l/dSwLXT8jNis3sXY9bqVRuKqEg2qLONp2zdgWxBBpkA6egqCMzzNlx08gbmJoYbmSGbhLU1Hgslm+A2tACc1jksdEKSnVhInLNL7iwQKDTgdB6c85FqiI0+eSc/r3fQsf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FTwDlunp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ORo5NbN6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 31B07EC0217;
	Fri,  7 Nov 2025 08:33:35 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 07 Nov 2025 08:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762522415;
	 x=1762608815; bh=qoNTBri6BFoATER30Out59sX4XhuNxOT0sEiKlWHhZ0=; b=
	FTwDlunpfj+SJA80kY3vwi0QtIDIq6L+Is5CGmfWNH8y19dz+eUlaqLjH4ruYTbe
	gT0s7Hk+m+/GmQhqLUstFXZUNiWilFAq73kVOBrK6t4ifO9/R0mPBghcph17QJy0
	hAQk28Ut/WoRo6qfDtdpeC2ZIEmy82H6IWOs5Woo2tMlwixQQj1a2L7UNf/8X0c6
	AZHGPtxfy6FZx4CU0UHYJY9/2b8Apg4KZ7Azxjf0LMlMDlklVLRSyw4EZHoLtFAV
	TZhkcEJjG6bNW2NxXi5fHMBqmBOrBxTmOoVqwN28fstG4Y0hAm1choDBfN+LIsJ5
	7sVfpx7QUNL5RN1SMTaA1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762522415; x=
	1762608815; bh=qoNTBri6BFoATER30Out59sX4XhuNxOT0sEiKlWHhZ0=; b=O
	Ro5NbN6H+XulPdb2sFyYcTqSZuypntzCF9ZwxRPtuosbpaBPXAQ4CKehfT8vYnUp
	vZzbV/jeMPVywZQ9iQ7diea8FZp7vBTBZXVK7OHT32e+b2qO7TCl1gEUvy7K0fiO
	lZZKSpWYuP+pCyFBFiB+UULLXqKnCAaz3OSuV1A7CKxY3JRAivQRXTdgmuK3jwC0
	gCYc8RtVtnSFNxs2R7HnMkXpoIMcDOr0soOXXptIttgIikHj6j2jp/XxkqsXvloC
	1e0NHUKrlZUNfIzyCr6i64EpzgLIwGzjmcibcWT22VDy+YN6AHCtMTOnXveI9kvu
	0CZZgGHjzoOq88zUhhNDw==
X-ME-Sender: <xms:LPUNadRqk_rPMn1hC4PXa7X-2lmMEiH19pqmrO2zsLKTwFS9nWWOXg>
    <xme:LPUNaRnIvVGpXMcYJXJw0ZqScKHRawWPf75el4LHyHruTHS_p_qqItnA_p-icVxV1
    CDVtnEeLjSi7qYrVGHqb34ctM8MLQ-YiasX2z_BtWRqUePowAqC8SI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeljeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhope
    iiudeihedvtdejgeegfedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrshgrhhhi
    rhhohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgr
    uggvrggurdhorhhgpdhrtghpthhtohepihesmhgrshhkrhgrhidrmhgvpdhrtghpthhtoh
    eprhhonhgsohhgohesohhuthhlohhokhdrtghomhdprhgtphhtthhopehlgidvgeesshht
    uhdrhihnuhdrvgguuhdrtghnpdhrtghpthhtohepfhgrlhgtohhnsehtihhnhihlrggsrd
    horhhg
X-ME-Proxy: <xmx:LPUNafhSVId5La2hoscRcYirzK6FithUJUQZaUQGQMEpiGwk78vZQg>
    <xmx:LPUNaYaj8i5_foyx7RioDe7mwbUfrAlkeugyV4mJE-zZsXLTQ4GEyg>
    <xmx:LPUNaTiVfTLz2adn1QX1_2WkS5b0HdNuufR2eGK6ZcrNY_k2aXI-mA>
    <xmx:LPUNaabtXfqp0Kx7yFtlaHs-KvqUZZdo_Q3BIS8KP--KNahFYFmpAA>
    <xmx:L_UNaX3xt1pHAgxJ5zDXSx9oglQ3DipmYV0h4djnA9p2AEwfMwXUfIkQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C8D5270006B; Fri,  7 Nov 2025 08:33:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-HrBBL8x6OF
Date: Fri, 07 Nov 2025 14:33:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yuan Tan" <tanyuan@tinylab.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, linux-kbuild@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 i@maskray.me, "Zhangjin Wu" <falcon@tinylab.org>, ronbogo@outlook.com,
 z1652074432@gmail.com, lx24@stu.ynu.edu.cn
Message-Id: <73010511-a804-4cf4-a5c1-1d08e3f324c5@app.fastmail.com>
In-Reply-To: 
 <0BF8B2E83B6154B6+f17f32b4-f6ff-4184-917d-4b27fb916eae@tinylab.org>
References: <30C972B6393DBAC5+cover.1760463245.git.tanyuan@tinylab.org>
 <33333fdd-2aa2-4ce0-8781-92222829ea12@app.fastmail.com>
 <0BF8B2E83B6154B6+f17f32b4-f6ff-4184-917d-4b27fb916eae@tinylab.org>
Subject: Re: [PATCH v2 0/8] dce, riscv: Unused syscall trimming with PUSHSECTION and
 conditional KEEP()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025, at 03:21, Yuan Tan wrote:

>> Sorry for the late reply =E2=80=94 this patchset really wore me out, =
and I only just
>> recovered.  Thank you very much for your feedback!

Sorry to hear this has been stressful for you. It's an unfortunate
aspect of the way we work that sometimes=20

> On 10/15/2025 12:47 AM, Arnd Bergmann wrote:
>> On Wed, Oct 15, 2025, at 08:16, Yuan Tan wrote:
>> Thanks a lot for your work on this. I think it is indeed valuable to
>> be able to optimize kernels with a smaller subset of system calls for
>> known workloads, and have as much dead code elimination as possible.
>>
>> However, I continue to think that the added scripting with a known
>> set of syscall names is fundamentally the wrong approach to get to
>> this list: This adds complexity to the build process in one of
>> the areas that is already too complicated, and it duplicates what
>> we can already do with Kconfig for a subset of the system calls.
>>
>> I think the way we should configure the set of syscalls instead is
>> to add more Kconfig symbols guarded by CONFIG_EXPERT that turn
>> classes of syscalls on or off. You have obviously done the research
>> to come up with a list of used/unused entry points for one or more
>> workloads. Can you share those lists?
>
> Regarding your suggestion to use Kconfig to control which system calls=
 are
> included or excluded, perhaps we could take inspiration from systemd's
> classification approach. For example, systemd groups syscalls into cat=
egories
> like[1]:
>
> @aio @basic-io @chown @clock @cpu-emulation @debug @file-system
>
> and so on.

I think many of the categories already naturally align with the
structure of the kernel source code, so maintaining them naturally comes
out of the build system.

More importantly, turning off parts of the kernel on a per-file
basis tends to work better for eliminating the entire block
of code because only removing the syscall entry still leaves
references to functions and global data structures from initcalls
and exported functions.

> However, if we go down this route, we would need to continuously maint=
ain and
> update these categories whenever Linux introduces new system calls. I'=
 m not
> sure whether that would be an ideal long-term approach.

If we can (at least roughly) align the categories between the kernel and=
 the
systemd classification, that would at least make it easier to maintain
the systemd ones.

> For reference, here is the list of syscalls required to run Lighttpd.
>
> execve set_tid_address mount write brk mmap munmap getuid getgid getpid
> clock_gettime getcwd fcntl fstat read dup3 socket setsockopt bind list=
en
> rt_sigaction rt_sigprocmask newfstatat prlimit64 epoll_create1 epoll_c=
tl pipe2
> epoll_pwait accept4 getsockopt recvfrom shutdown writev getdents64 ope=
nat close
>
> We've tested it successfully on QEMU + initramfs, and I can share the
> deployment script if anyone would like to reproduce the setup.

Thanks for the list! Is this a workload you are interested in actually
optimizing for deployment, or just something you used as a simple test
environment?

I see three types of syscalls in your list above:

1. essential ones that are basically always needed
2. socket interfaces (already optional)
3. epoll (already optional)

The first two sets are clearly going to have more syscalls in
them that are usually used in combination with the others:
If we provide read, write and writev, we should also provide readv,
and if we provide socket/bind/listen/recvfrom, we also likely want
accept/connect/sendto and probably recvmsg/sendmsg.

Starting with your set of syscalls and those closely related
ones, as well as the set of syscalls that already have a
Kconfig option, we should be able to find the set of syscalls
that are unconditionally enabled but could be optional.
If you have the chance, could you compile that list?
I might also have a list, but probably not in the next week.

The next step after that I think is to measure the impact
of turning off those remaining ones in a configuration that
has the existing symbols (e.g. sysvipc, futex, compat_32bit_time,
...) disabled already.

Side note: I'm a  bit surprised to see fstat() in the list, since riscv
should only really support newfstat().

> Also, I noticed that there haven't been any comments so far on the lat=
er
> patches introducing the PUSHSECTION macro.=C2=A0 I' m a bit concerned =
about how
> people perceive this part.

I don't have a strong opinion on this part.

     Arnd

