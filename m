Return-Path: <linux-arch+bounces-2722-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74017866F4F
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 10:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834551C2488D
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1D01CD0B;
	Mon, 26 Feb 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kQ+m0W7z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rQmGyXxQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA71CAA2;
	Mon, 26 Feb 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939247; cv=none; b=pPSR/9nntoNlAEnHEfZ7mjgbVuZufjfrWBSr97yWvdskgtXoINNXrlzPuv1p7GZEr3z6lNjm6VInz1TnLvMmF2Ug36SqPxr2TpuY5sqH3T2XgJCW1Gys28ly9fyrACrW5mH0zpcIZ+T3Zx8xFKoAhmiVjWEYeyOQKgcX+RJqzDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939247; c=relaxed/simple;
	bh=BT73DzwF8BYHn1ZbEVpzLAQxP4EnKf2E6Gpk1A8BIW4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=g3oEx/64+QlzGxY1KV3vVpUM4vNdtyuTQSKD4DL7mGRB65XU9C2LaYCpVyi8CVo1py968G6yqTxJr3T/CNyW605bengKwn22C81eCrtRvkf1jz4NhXHo8p9WCFFkqqOSK/wAFpiNWF4FByLgUaLllatxghUrE+sLOk4WFG2Hwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kQ+m0W7z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rQmGyXxQ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6E80613800AB;
	Mon, 26 Feb 2024 04:20:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 26 Feb 2024 04:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708939244;
	 x=1709025644; bh=l9cJpJuziz4YkNOWdtCdbO8uHXbn75mByh0b7Q58ycw=; b=
	kQ+m0W7zYLgn3auQBF5aFv8LcVQdCcLYMQO5y/aa+Wsi+/2nqR3SHFNEDEFXZu1v
	UQ+at3K6MozBRK7czOCaEfcCetXlkehyymEdA1cmAa30B1Mu8j/y1E9ErtWDfUwO
	CiUGiyaunM2J4d8SqliLKFMwmSNERtDIGcQRWa2F9ed4zDvgF2UgdWqbYkcUAOcH
	XJGvvd5yOdMKC6JcmcetXggbKEpLGEim0teDSmWyYkuDu0ox1JOGTsDtvFVedx8T
	Kv+tusy2l6m5VA9P9Bz28KRWQ0hWzJ496rd4tJykAZe+Zt9CBPTKoPMhmCa+JHjo
	QcNA0yfHIFPVvbAUT5QUzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708939244; x=
	1709025644; bh=l9cJpJuziz4YkNOWdtCdbO8uHXbn75mByh0b7Q58ycw=; b=r
	QmGyXxQk2Tc271z2kSJQrp+TYlN/jUBXuYoN2gb6BI9RNmnV+nLTKWxsQ2zJfFOq
	JknJ/YHExF4U8mhTn2XbVyvVFZVB0f0ozGTKHWhsYVx5yfjxE5535YGMVl3oRZW9
	VICa+6GUQeOF93s1AFR7ZkVabYtSDViMp5mHBEFO7mHcaoy4B+dPUy4tqw2AVCcj
	6+4TiOwPOksh2/Y/UsFBajtiGZMZkEUfrCasbF0mxTuxW9jKNwJuJ1mvuLtkBVrx
	5/KdFBhJALrhT8dtEmL4/MHWVZbzNd7O0/GpG61KX5VfoXnZaph8j55Foqto4mY4
	6dWJZ689y9y1vI8cDwl7g==
X-ME-Sender: <xms:61fcZY1QqMq2JHAR9a-27Ia8oitlqYeJ0rc31mb_hFqfeetesbjQcg>
    <xme:61fcZTEW-1EuwSjaQTWZEj2fTLXt_x8nk-jMadBEGjtGjqM2n_RQ7ET6gz2uRfLve
    DASJXP4LvALlEoV4zk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:61fcZQ7RZGiYCG0f1hXOYzyQ1SMycoMqseifPmciE8PhOKQqPyTyUw>
    <xmx:61fcZR0DiyhX-wtgnc_9qP3VfqQIccj7Wz5fS865EZpUNrMVCWYteA>
    <xmx:61fcZbEl_GjVLetpkR3ImiVEoUw-Zh0qcIsIMJwZL5quxfjvdtcMOg>
    <xmx:7FfcZYfue5Dclb65Bxz4wqoDw5J2wWDYgrS8LGEpcxjRZP8gXHlGkg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9B532B6008D; Mon, 26 Feb 2024 04:20:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b9fb0de1-bfb9-47a6-9730-325e7641c182@app.fastmail.com>
In-Reply-To: <6f7a8e320f3c2bd5e9b704bb8d1f311714cd8644.camel@xry111.site>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
 <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
 <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
 <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>
 <3c396b7c-adec-4762-9584-5824f310bf7b@app.fastmail.com>
 <6f7a8e320f3c2bd5e9b704bb8d1f311714cd8644.camel@xry111.site>
Date: Mon, 26 Feb 2024 10:20:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Xi Ruoyao" <xry111@xry111.site>, "Icenowy Zheng" <uwu@icenowy.me>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>
Cc: linux-api@vger.kernel.org, "Christian Brauner" <brauner@kernel.org>,
 "Kees Cook" <keescook@chromium.org>, "Xuefeng Li" <lixuefeng@loongson.cn>,
 "Jianmin Lv" <lvjianmin@loongson.cn>, "Xiaotian Wu" <wuxiaotian@loongson.cn>,
 "WANG Rui" <wangrui@loongson.cn>, "Miao Wang" <shankerwangmiao@gmail.com>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep argument
 inspection again?
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024, at 08:09, Xi Ruoyao wrote:
> On Mon, 2024-02-26 at 07:56 +0100, Arnd Bergmann wrote:
>> On Mon, Feb 26, 2024, at 07:03, Icenowy Zheng wrote:
>> > =E5=9C=A8 2024-02-25=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 15:32 +080=
0=EF=BC=8CXi Ruoyao=E5=86=99=E9=81=93=EF=BC=9A
>> > > On Sun, 2024-02-25 at 14:51 +0800, Icenowy Zheng wrote:
>> > > > My idea is this problem needs syscalls to be designed with deep
>> > > > argument inspection in mind; syscalls before this should be
>> > > > considered
>> > > > as historical error and get fixed by resotring old syscalls.
>> > >=20
>> > > I'd not consider fstat an error as using statx for fstat has a
>> > > performance impact (severe for some workflows), and Linus has
>> > > concluded
>> >=20
>> > Sorry for clearance, I mean statx is an error in ABI design, not fs=
tat.
>
> I'm wondering why we decided to use AT_EMPTY_PATH/"" instead of
> "AT_NULL_PATH"/nullptr in the first place?

Not sure, but it's hard to change now since the libc
implementation won't easily know whether using the NULL
path is safe on a given kernel. It could check the kernel
version number, but that adds another bit of complexity in
the fast path and doesn't work on old kernels with the
feature backported.

> But it's not irrational to pass a path to syscall, as long as we still
> have the concept of file system (maybe in 2371 or some year we'll use a
> 128-bit UUID instead of path).
>
>> The problem I see with the 'use use fstat' approach is that this
>> does not work on 32-bit architectures, unless we define a new
>> fstatat64_time64() syscall, which is one of the things that statx()
>
> "fstat64_time64".  Using statx for fstatat should be just fine.

Right. It does feel wrong to have only an fstat() variant but not
fstatat() if we go there.

> Or maybe we can just introduce a new AT_something to make statx
> completely ignore pathname but behave like AT_EMPTY_PATH + "".

I think this is better than going back to fstat64_time64(), but
it's still not great because

- all the reserved flags on statx() are by definition incompatible
  with existing kernels that return -EINVAL for any flag they do
  not recognize.

- you still need to convince libc developers to actually use
  the flag despite the backwards compatibility problem, either
  with a fallback to the current behavior or a version check.

Using the NULL path as a fallback would solve the problem with
seccomp, but it would not make the normal case any faster.

>> was trying to avoid.
>
> Oops.  I thought "newstat" should be using 64-bit time but it seems the
> "new" is not what I'd expected...  The "new" actually means "newer than
> Linux 0.9"! :(
>
> Let's not use "new" in future syscall names...

Right, we definitely can't ever succeed. On some architectures
we even had "oldstat" and "stat" before "newstat" and "stat64",
and on some architectures we mix them up. E.g. x86_64 has fstat()
and fstatat64() with the same structure but doesn't define
__NR_newfstat. On mips64, there is a 'newstat' but it has 32-bit
timestamps unlike all other 64-bit architectures.

statx() was intended to solve these problems once and for all,
and it appears that we have failed again.

      Arnd

