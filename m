Return-Path: <linux-arch+bounces-2716-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DB9862975
	for <lists+linux-arch@lfdr.de>; Sun, 25 Feb 2024 07:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A2CB2115C
	for <lists+linux-arch@lfdr.de>; Sun, 25 Feb 2024 06:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C3BD53B;
	Sun, 25 Feb 2024 06:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="eI+5MeRm"
X-Original-To: linux-arch@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03438D2E5;
	Sun, 25 Feb 2024 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708843908; cv=pass; b=WYqoIOGc+eAxPZGkZNZa9224avFXa5vZ0aUqYl8HDyx1AU1Nbxo9atjlmDiWzV4x/Kg8XuDgqp7ittckZZ7Wfb3+a6xGVWoWJ68wbLSVFlvnxZnaT3IJPckU4eSISsMJmcCGJCcBRCUUQbH1UFAMqOY4cgysuUBg4lMJ+elhydM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708843908; c=relaxed/simple;
	bh=jx8A+6qk9M52TPmO5VORSWR7NjQm1UNXTBRRmCxfeE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pOXQ5dZD2/4ayhW/FuUgUYwFDucFxzeD6wh6VVDCN4FJb8hvxP4FPFks3XQ41Q7Y7y1jDPZ5KhOFGj/tJHrF++4xuV60NxPglS3f6GaOZw0SSxH8yLBkun/4XsZTQvJ04FW/qmMUWs0z5Q78ifibxa7vkoEvifQ5tvoYG9Ur+d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=eI+5MeRm; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1708843872; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Nd740hxcMyhDsi/gek143O+hXjPm0QGoZR8xLfScTVJDQDVIfYn3FV2AeBw3qezj82Zb8UvBdbgIE1LfI9N4KUaFjmwMcFQUGBYiP1y61I4cdh4zXbo86/O8U6kTfWQ55OCan8jzeAlELua/mXwUN3xyaHridnRE3rZEle4kY+E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708843872; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jx8A+6qk9M52TPmO5VORSWR7NjQm1UNXTBRRmCxfeE0=; 
	b=GFSOdYj2NySST7l30ryLYVsyEWrWW3TcEzE15WvR0ZCq5IGe18v14g+5OlTnfo5h6EfW5ZXXLFKJzvimzSdAsiKMsI62L0bJn5yASSpA+eC63KPOJqHC07QRCjqJSc9/HU4mlVLrJ79TfIH6RKAs5RtecAezVcD7kZuWqd1B998=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708843872;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=jx8A+6qk9M52TPmO5VORSWR7NjQm1UNXTBRRmCxfeE0=;
	b=eI+5MeRm/okgPz13la2RFz8jGxlpKjeMIOJKzUHLHEtAOf+uwqu/UCe1GXJAZOV7
	xblx5AtaNBgZ3zeIhk3D3sTCTQd4QsFJ+0s1TfW1AuJGVPToy/uUMzwJ12i3d4vaX9W
	Ro5L7dlJD+A4vXWWbjtw0vBCGUfuL6KtR+A1cPbKNCXyMDIuRZAKeLQ4HATyjuZhV/Z
	YBVyIXC3+HTijMb+Ox8gZWRSCheJ4a2Of2TJsGDUuK2iBlqKk4zgGSeC8PwAeHjbflk
	ujyt5Wlds0zvIZYlAhr7/hpdUg1nw2Scu5qRXX1PvAgE66uK/rEj/PrAUoxecZJks4s
	jybuXkOa4g==
Received: from edelgard.fodlan.icenowy.me (112.94.103.221 [112.94.103.221]) by mx.zohomail.com
	with SMTPS id 1708843870885956.8294126820598; Sat, 24 Feb 2024 22:51:10 -0800 (PST)
Message-ID: <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep
 argument inspection again?
From: Icenowy Zheng <uwu@icenowy.me>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christian
 Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, Xuefeng Li
 <lixuefeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>, Xiaotian Wu
 <wuxiaotian@loongson.cn>, WANG Rui <wangrui@loongson.cn>, Miao Wang
 <shankerwangmiao@gmail.com>, "loongarch@lists.linux.dev"
 <loongarch@lists.linux.dev>, linux-arch <linux-arch@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 25 Feb 2024 14:51:05 +0800
In-Reply-To: <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
	 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2024-02-24=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 19:51 +0800=EF=BC=
=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> Hi, Xuerui,
>=20
> On Wed, Feb 21, 2024 at 2:10=E2=80=AFPM WANG Xuerui <kernel@xen0n.name>
> wrote:
> >=20
> > Hi,
> >=20
> > Recently, we -- community LoongArch porters -- have noticed a
> > problem
> > where the Chromium sandbox apparently wants to deny statx [^1] so
> > it
> > could properly inspect arguments after the sandboxed process later
> > falls
> > back to fstat. The reasoning behind the change was not clear in the
> > patch; but we found out it's basically because there's currently
> > not a
> > "fd-only" version of statx, so that the sandbox has no way to
> > ensure the
> > path argument is empty without being able to peek into the
> > sandboxed
> > process's memory. For architectures able to do newfstatat though,
> > the
> > glibc falls back to newfstatat after getting -ENOSYS for statx,
> > then the
> > respective SIGSYS handler [^2] takes care of inspecting the path
> > argument, transforming allowed newfstatat's into fstat instead
> > which is
> > allowed and has the same type of return value.
> >=20
> > But, as loongarch is the first architecture to not have fstat nor
> > newfstatat, the LoongArch glibc does not attempt falling back at
> > all
> > when it gets -ENOSYS for statx -- and you see the problem there!
> >=20
> > Actually, back when the loongarch port was under review, people
> > were
> > aware of the same problem with sandboxing clone3 [^3], so clone was
> > eventually kept. Unfortunately it seemed at that time no one had
> > noticed
> > statx, so besides restoring fstat/newfstatat to loongarch uapi (and
> > postponing the problem further), it seems inevitable that we would
> > need
> > to tackle seccomp deep argument inspection; this is obviously a
> > decision
> > that shouldn't be taken lightly, so I'm posting this to restart the
> > conversation to figure out a way forward together. We basically
> > could do
> > one of below:
> >=20
> > - just restore fstat and be done with it;
> > - add a flag to statx so we can do the equivalent of just fstat(fd,
> > &out) with statx, and ensuring an error happens if path is not
> > empty in
> > that case;
> > - tackle the long-standing problem of seccomp deep argument
> > inspection (!).
> From my point of view, I prefer to "restore fstat", because we need
> to
> use the Chrome sandbox everyday (even though it hasn't been upstream
> by now). But I also hope "seccomp deep argument inspection" can be
> solved in the future.

My idea is this problem needs syscalls to be designed with deep
argument inspection in mind; syscalls before this should be considered
as historical error and get fixed by resotring old syscalls.

>=20
>=20
> Huacai
>=20
> >=20
> > Obviously, the simplest solution would be to "just restore fstat".
> > But
> > again, in my opinion this is not quite a solution but a workaround
> > -- we
> > have good reasons to keep just statx (mainly because its feature
> > set is
> > a strict superset of those of fstat/newfstatat), and we're not
> > quite in
> > a hurry to resolve this. Because one of the prerequisites for a new
> > Chromium port is "inclusion in Debian stable" -- as the loong64
> > port
> > [^4] is progressing and the next Debian release would not happen
> > until
> > 2025, we still have time for a more "elegant" solution.
> >=20
> > Alternatively, we could also introduce a new flag for statx, maybe
> > named
> > AT_STATX_NO_PATH or something like that, so that statx would ignore
> > the
> > path altogether or error on non-empty paths if called with flags
> > containing AT_EMPTY_PATH | AT_STATX_NO_PATH. This way a seccomp
> > policy
> > could allow statx calls only with such flags (that are passed via
> > register and accessible) and maintain the same level of safety as
> > with
> > fstat. But there is also disadvantage to this approach: the flag
> > would
> > be useful only for sandboxes, because in other cases there's no
> > need to
> > avoid reading from &path. This is also more of a workaround to
> > avoid the
> > deep argument inspection problem.
> >=20
> > Lastly, should we decide to go the hardest way, according to a
> > previous
> > mail [^5] (about clone3) and the LPC 2019 discussion [^6] [^7], we
> > probably would try the metadata-annotation-based and piece-by-piece
> > approach, as it's expected to provide the most benefit and involve
> > less
> > code changes. The implementation, as I surmise, will involve
> > modifying
> > the generic syscall entrypoint for early copying of user data, and
> > corresponding changes to seccomp plumbing so this information is
> > properly exposed. I don't have a roadmap for non-generic-entry
> > arches
> > right now, and I also haven't started designing the new seccomp ABI
> > for
> > that. As a matter of fact, members of the LoongArch community
> > (myself
> > included) are still fresh to this area of expertise, so a bit more
> > of
> > your feedback will be appreciated.
> >=20
> > Thanks to Miao Wang from AOSC for doing much of the investigation.
> >=20
> > [^1]:
> > https://chromium-review.googlesource.com/c/chromium/src/+/2823150
> > [^2]:
> > https://chromium.googlesource.com/chromium/src/sandbox/+/c085b51940bd/l=
inux/seccomp-bpf-helpers/sigsys_handlers.cc#355
> > [^3]:
> > https://lore.kernel.org/linux-arch/20220511211231.GG7074@brightrain.aer=
ifal.cx/
> > [^4]: https://wiki.debian.org/Ports/loong64
> > [^5]:
> > https://lwn.net/ml/linux-kernel/201905301122.88FD40B3@keescook/
> > [^6]: https://lwn.net/Articles/799557/
> > [^7]:
> > https://lpc.events/event/4/contributions/560/attachments/397/640/deep-a=
rg-inspection.pdf
> >=20
> > --
> > WANG "xen0n" Xuerui
> >=20
> > Linux/LoongArch mailing list:https://lore.kernel.org/loongarch/
> >=20


