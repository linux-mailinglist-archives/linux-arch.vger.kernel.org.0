Return-Path: <linux-arch+bounces-15128-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07214C9ED1D
	for <lists+linux-arch@lfdr.de>; Wed, 03 Dec 2025 12:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53F23A3B06
	for <lists+linux-arch@lfdr.de>; Wed,  3 Dec 2025 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CBC2F2916;
	Wed,  3 Dec 2025 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hOul+9t2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QyaXp01v"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3B2F2603;
	Wed,  3 Dec 2025 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764760418; cv=none; b=YLoIUuUKEsFMnf4QYlzVbN0NQF/W8UMt7SsjAaj2xO9o43Z/leeiXCF6SBSywK+QsvALI0ahX72xsIMtBQNhFtYl21tPvi6HxOud3I3uhADRYvdyLxIIv5s8dbJ6EtX2toZJY2wuOs1MkEl3KAyXuhU87J84LjWBjySVMbPdhxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764760418; c=relaxed/simple;
	bh=azUpzl+Mqi5qm3YAX05S5bGyelHtcHA+mU5T8o4tLW0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Txd7U4u+T2VWGT9Nar7yBxv6b0veWZT9jm2Cw2H844JIPxvgljXTR2KbYRwTiyUAybo9/wwlnr5I1SFzRJB20FpvUjZD/zK3tNMTSrLmZHZ5gK7KxMByJuz92Q/0oCeoYlraR0P2gpwIJhbRNANGKjz4ttP2DrQpEBmgIg2XfWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hOul+9t2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QyaXp01v; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EA7237A0081;
	Wed,  3 Dec 2025 06:13:34 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Wed, 03 Dec 2025 06:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764760414;
	 x=1764846814; bh=YKdb+8l66UjAcBrgpOrU8WrV1sdDB8wuszrMqADbfnA=; b=
	hOul+9t2G80f86fgU8sGmcdIY5wqNogHFkF8Z0Qeh0K+aWKykIBu22ww60hoiLz4
	CLZPphxX1BNL4tTlPgXbYJbTFKOMoEe/7Df1a0rQZFOVv4zNxNKnmov5nTso80BL
	YMPVvJH/qR5gpazJy4GxBLdESJewhqTLir4LBvCKlisKaADXhb5NUg830qNX4HAI
	pcNAFjmD3vZpdjZcoliAox7NEMkzHIDhmk2JAVWuToRjjpq6FUAfjZXlZFBKreQb
	yOLEafyOJQ3/Hyd7D++OejL1u0L5HHS46YFTZWAc8dv+2ICnLgDSSubq5/KEfr03
	+sim0ijaxpKphTCiWSUjUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764760414; x=
	1764846814; bh=YKdb+8l66UjAcBrgpOrU8WrV1sdDB8wuszrMqADbfnA=; b=Q
	yaXp01vW+rIQiAuCf/F6CoSsyPENi2feziGzqixEbt2ijbgLGKI6TKzsaKJqAXTG
	DREqKGMrqPuXag77xY1ygVVwOFRPgt+PMGd7Owp4qpbycpNM8klSJOVyN70tX9iA
	yJygrLvWfQko4DPZwX7TbcBhud1FFYfwIyuMHUJMIbZ1FYJ/3UnZO8jMeAqYDzFw
	6xzWv69PDUDa/4v6A3CRPLPqvR8zK3JjYkCqr0kGVbRndDiq9yB/BFbpL0CkAAfq
	xK4ygm2ln+VNVlDy3B9QEW5JfZRyidXbSAF+sfXIFvmtDmSg+lWJTezRVUGSxK94
	D+SI/3nVzoRb/FeroZAHg==
X-ME-Sender: <xms:XRswaciQ4wo2K084QLdm4NSTc9hQWMdItx4ZYbKwgFDBcnj8ZRb_sQ>
    <xme:XRswaf0o59o4spJrvLSp7ImMGxmemqhVS4ECKg6wcBUo68GpXd5Fk2uW_RqotrTO8
    JnEiJKtsmznTeGKw_y6O2SFfNxXYwaav8TL_biGcGz447T_NRJSYVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epffdttefhleekvedvvedtvdfghfdvvdeftdehudekkedvffdukedthfefffefkeeunecu
    ffhomhgrihhnpehprghsthgvsghinhdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrlhhmvghrse
    gurggssggvlhhtrdgtohhmpdhrtghpthhtohepiiduieehvddtjeeggeefvdesghhmrghi
    lhdrtghomhdprhgtphhtthhopehmrghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hisehmrghskhhrrgihrdhmvgdprhgtphhtthhopehrohhnsghoghhosehouhhtlhhoohhk
    rdgtohhmpdhrtghpthhtoheplhigvdegsehsthhurdihnhhurdgvughurdgtnhdprhgtph
    htthhopehfrghltghonhesthhinhihlhgrsgdrohhrgh
X-ME-Proxy: <xmx:XRswaaz_U52lCjzKHgfAa9rca3rlw9dtenhZ3Sy0mIhcv8J-GdZ6Wg>
    <xmx:XRswaSrk6I8MZIxo95ScFD41TYeMdhzv9i_z5OVjiiC7i0R10X3EUw>
    <xmx:XRswaQxzmoiK2XDugHJsxMLX5Zg1a1W-PkUhG3F7U26ln_f3O33OYA>
    <xmx:XRswaerYZOsg4ztJES2hQIthPhk1lIhauI-Wv90oxPoLG9QeH94xHg>
    <xmx:XhswadEUk7yIgiRsemgLUJMs_IT7XNVbx7p-6djBcnbL6W6_Z-vZQNKx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 043BFC40054; Wed,  3 Dec 2025 06:13:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-HrBBL8x6OF
Date: Wed, 03 Dec 2025 12:13:11 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yuan Tan" <tanyuan@tinylab.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, linux-kbuild@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 i@maskray.me, "Zhangjin Wu" <falcon@tinylab.org>, ronbogo@outlook.com,
 z1652074432@gmail.com, lx24@stu.ynu.edu.cn
Message-Id: <bd1e8856-2dbe-4dcf-beb6-9c52437fb01a@app.fastmail.com>
In-Reply-To: 
 <921F22AF0D7D10F0+3a743e26-ae83-40e8-b266-ccffe478d2c7@tinylab.org>
References: <30C972B6393DBAC5+cover.1760463245.git.tanyuan@tinylab.org>
 <33333fdd-2aa2-4ce0-8781-92222829ea12@app.fastmail.com>
 <0BF8B2E83B6154B6+f17f32b4-f6ff-4184-917d-4b27fb916eae@tinylab.org>
 <73010511-a804-4cf4-a5c1-1d08e3f324c5@app.fastmail.com>
 <921F22AF0D7D10F0+3a743e26-ae83-40e8-b266-ccffe478d2c7@tinylab.org>
Subject: Re: [PATCH v2 0/8] dce, riscv: Unused syscall trimming with PUSHSECTION and
 conditional KEEP()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025, at 07:02, Yuan Tan wrote:
> On 11/7/2025 5:33 AM, Arnd Bergmann wrote:
>> On Tue, Nov 4, 2025, at 03:21, Yuan Tan wrote:
>>> For reference, here is the list of syscalls required to run Lighttpd.
>>>
>>> execve set_tid_address mount write brk mmap munmap getuid getgid get=
pid
>>> clock_gettime getcwd fcntl fstat read dup3 socket setsockopt bind li=
sten
>>> rt_sigaction rt_sigprocmask newfstatat prlimit64 epoll_create1 epoll=
_ctl pipe2
>>> epoll_pwait accept4 getsockopt recvfrom shutdown writev getdents64 o=
penat close
>>>

...

>>
>> Side note: I'm a  bit surprised to see fstat() in the list, since ris=
cv
>> should only really support newfstat().
>
>
> The syscall list comes from a simple test environment rather than a
> workload I intend to optimize for deployment.
>
> The list I posted was generated using strace on RISC-V QEMU. I was
> looking at the ABI names, not the actual kernel syscall names.=C2=A0 O=
ne
> question here: for syscall trimming, should we discuss everything in
> terms of syscall ABI names or the actual kernel syscall function names?
> I would like to confirm your preference before I continue with the
> updated list.

Right, we clearly need to come up with a consistent naming here.
Unfortunately both the function names and the macro names can
be confusing here.

> For now, I'll continue the discussion in terms of syscall ABI names.

Ok

> Following your suggestion, I started by taking the syscall list requir=
ed
> for the Lighttpd workload and expanded it into the corresponding
> functional groups.
>
> Here is a very preliminary draft of the syscall grouping, based on the
> systemd classification.
>
> https://pastebin.com/raw/Yx92bb3m
>
> Then, I wrote a small script that classifies each syscall from lighttpd
> into its category and then enumerates all syscalls belonging to those
> categories.
>
> It addresses two of the items you asked for
>
> - Identifying the syscall families related to my minimal Lighttpd
> =C2=A0 workload
>
> - Enumerating which syscalls appear in those categories and could
> =C2=A0 potentially become optional
>
> ```
> Categories present in lighttpd_syscalls.txt:
> =C2=A0 @basic-io: 5 / 16
> =C2=A0 @clock: 1 / 8
> =C2=A0 @default: 9 / 30
> =C2=A0 @file-system: 6 / 47
> =C2=A0 @io-event: 3 / 7
> =C2=A0 @ipc: 1 / 23
> =C2=A0 @mount: 1 / 13
> =C2=A0 @network-io: 8 / 18
> =C2=A0 @signal: 2 / 14
> Total unique categories: 9
> Total categories defined: 30

Thanks for compiling the list, this is very useful!

It's clear that the systemd categories have a someone different
purpose, which does mean that some of the categories pull in
way more syscalls than we need for your testcase:

- ipc is mostly for sysvipc (controlled by CONFIG_SYSVIPC, but not used
  in your workload), but it also includes pipe2, which you do use.

- network-io includes all the socket interfaces, and I think
  that makes sense as a category (CONFIG_NET).

- clock contains all the posix clock and timer support, but you
  only use clock_gettime(). We have CONFIG_POSIX_TIMERS, which
  you can disable to get close to what you want here.

- The 'mount' category has gained a lot of non-optional syscalls
  over the past few years, but you only use the traditonal
  'mount'. Since the general idea is to move away from the mount
  syscall to the newer ones, I'm not sure it makes sense to
  have additional options here, but that depends a bit on the
  amount of space savings and may be worth trying.

> This produces a list of 176 syscalls across 9 categories that are
> relevant to the workload. The output also shows which categories do not
> appear in this workload (21 categories with 0 syscalls used).
>
> If the categorization works this way, it's actually quite surprising
> that even such a simple workload would pull in as many as 176 syscalls.
> I'm not sure yet what the actual trimming impact will look like after
> building, but I will test that next.

Sounds good. See if you can disable CONFIG_SYSVIPC and
CONFIG_POSIX_TIMERS in those tests, in addition to the ones from
categories you list as being unused.

      Arnd

