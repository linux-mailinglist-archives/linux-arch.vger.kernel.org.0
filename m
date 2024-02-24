Return-Path: <linux-arch+bounces-2714-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE97A8624BF
	for <lists+linux-arch@lfdr.de>; Sat, 24 Feb 2024 12:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503DE1F2244F
	for <lists+linux-arch@lfdr.de>; Sat, 24 Feb 2024 11:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCCF364CF;
	Sat, 24 Feb 2024 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agbs7gFA"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429BE2D600;
	Sat, 24 Feb 2024 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775523; cv=none; b=HuGZFXLbjWTAv7dIWQSHHpgQLxtvTwGbHc64r28k58cAIAdIDFffV9i3K3wEuozO8583Dlq+6FNteyrTMH3cTDsphVpljMOgqD7VM2bxx++TxN35CmOmiAv6ZFFDer+dPc6E57E98qaAlo7XTkmM3iMOmZA9ZUIRglxFw01o6rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775523; c=relaxed/simple;
	bh=4g8OwjNOEQC7wKeKC4V5VNwyJsG+w5py00LgSr9YfqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uU/ALjpfTLmZKRqy6/CryNze7/offc1VSNWN4jrbJmuAqmmFwG7xFY0FfhnBuxYzW5XrnLqE7GzrOIjZdlGxbi7cyOceUMrBqDZ3oAeAmPXjJYNqUQZzNmPJKrgrdYX3YBV5scZ0gYq+EbJHIkflpi662+LCz/e8KPylGfz1rRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agbs7gFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09BCC43390;
	Sat, 24 Feb 2024 11:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708775522;
	bh=4g8OwjNOEQC7wKeKC4V5VNwyJsG+w5py00LgSr9YfqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=agbs7gFAyla56tBPuCfbNw8TO2S01CJ8grnKmz0vPfnAnuHWBO5Hlgu/KxG7Vm4ZS
	 A1irkLaUpDzZ3Cq5wYRdoFhwyh3JDECSWFCjYsov/I6it4AESlKgm2CEEdPMMskqGL
	 6MurRVQSXAVrl7Y4mgYkyz+68pfSmrsT1PGv1Q0WnGKChgT0+Obd2ekvv+1c4ltd68
	 1CfLxmDkNxXWQj8BdVfIgn0f9WaJMTlS8Jp743SGy8bfp9r67ji7hN17S4iwkkqPQU
	 ULMyK0Fkdo+6aV5W5X6Ud2voWyOG/3wfg+/+pp7LbtbpRcEykJv4pGPXcol1o+uTe1
	 hh3rp65PhhBwA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso228116266b.1;
        Sat, 24 Feb 2024 03:52:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULIWdd0r3ubrKC4+5YU53U5cB+8osYdBnA6lLJen9au4QKEwzQ8g84lEyxkr2/OF32zNprDZx4GFwfp3M+K3/L9fl03RWlSLaL3eKF+lOOblQw7CmBJ9XMaXMIVZ9GSU8KQ1NDfMBh2Q==
X-Gm-Message-State: AOJu0YyzUwjD7rHYUWLeaeGTkpL/Hd+pQiuQk23yZ7CcIb5HsbV+wr8m
	gfM8jpypDY4xqVCbcsmuHn4bR0Z2HoTnrZ4oCJw3+FcAKnntfiX4IiTuCmlsnC2m83hq3vm2rq9
	c58cYE5h/+9VobfWnPExaUMxQelQ=
X-Google-Smtp-Source: AGHT+IGGKv6kscJ4vtVEndiPQAxbP/arG0Xopt3YmHVKjPUXL1Cq6f7gsckyyXg0V/Ja/ym6gzJZ51NIwcPJPPQI0ms=
X-Received: by 2002:a17:906:354d:b0:a3e:b57f:2b8a with SMTP id
 s13-20020a170906354d00b00a3eb57f2b8amr1929029eja.10.1708775521113; Sat, 24
 Feb 2024 03:52:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
In-Reply-To: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 24 Feb 2024 19:51:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
Message-ID: <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep argument
 inspection again?
To: WANG Xuerui <kernel@xen0n.name>
Cc: linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Xuefeng Li <lixuefeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
	Xiaotian Wu <wuxiaotian@loongson.cn>, WANG Rui <wangrui@loongson.cn>, 
	Miao Wang <shankerwangmiao@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, linux-arch <linux-arch@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Xuerui,

On Wed, Feb 21, 2024 at 2:10=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> Hi,
>
> Recently, we -- community LoongArch porters -- have noticed a problem
> where the Chromium sandbox apparently wants to deny statx [^1] so it
> could properly inspect arguments after the sandboxed process later falls
> back to fstat. The reasoning behind the change was not clear in the
> patch; but we found out it's basically because there's currently not a
> "fd-only" version of statx, so that the sandbox has no way to ensure the
> path argument is empty without being able to peek into the sandboxed
> process's memory. For architectures able to do newfstatat though, the
> glibc falls back to newfstatat after getting -ENOSYS for statx, then the
> respective SIGSYS handler [^2] takes care of inspecting the path
> argument, transforming allowed newfstatat's into fstat instead which is
> allowed and has the same type of return value.
>
> But, as loongarch is the first architecture to not have fstat nor
> newfstatat, the LoongArch glibc does not attempt falling back at all
> when it gets -ENOSYS for statx -- and you see the problem there!
>
> Actually, back when the loongarch port was under review, people were
> aware of the same problem with sandboxing clone3 [^3], so clone was
> eventually kept. Unfortunately it seemed at that time no one had noticed
> statx, so besides restoring fstat/newfstatat to loongarch uapi (and
> postponing the problem further), it seems inevitable that we would need
> to tackle seccomp deep argument inspection; this is obviously a decision
> that shouldn't be taken lightly, so I'm posting this to restart the
> conversation to figure out a way forward together. We basically could do
> one of below:
>
> - just restore fstat and be done with it;
> - add a flag to statx so we can do the equivalent of just fstat(fd,
> &out) with statx, and ensuring an error happens if path is not empty in
> that case;
> - tackle the long-standing problem of seccomp deep argument inspection (!=
).
From my point of view, I prefer to "restore fstat", because we need to
use the Chrome sandbox everyday (even though it hasn't been upstream
by now). But I also hope "seccomp deep argument inspection" can be
solved in the future.


Huacai

>
> Obviously, the simplest solution would be to "just restore fstat". But
> again, in my opinion this is not quite a solution but a workaround -- we
> have good reasons to keep just statx (mainly because its feature set is
> a strict superset of those of fstat/newfstatat), and we're not quite in
> a hurry to resolve this. Because one of the prerequisites for a new
> Chromium port is "inclusion in Debian stable" -- as the loong64 port
> [^4] is progressing and the next Debian release would not happen until
> 2025, we still have time for a more "elegant" solution.
>
> Alternatively, we could also introduce a new flag for statx, maybe named
> AT_STATX_NO_PATH or something like that, so that statx would ignore the
> path altogether or error on non-empty paths if called with flags
> containing AT_EMPTY_PATH | AT_STATX_NO_PATH. This way a seccomp policy
> could allow statx calls only with such flags (that are passed via
> register and accessible) and maintain the same level of safety as with
> fstat. But there is also disadvantage to this approach: the flag would
> be useful only for sandboxes, because in other cases there's no need to
> avoid reading from &path. This is also more of a workaround to avoid the
> deep argument inspection problem.
>
> Lastly, should we decide to go the hardest way, according to a previous
> mail [^5] (about clone3) and the LPC 2019 discussion [^6] [^7], we
> probably would try the metadata-annotation-based and piece-by-piece
> approach, as it's expected to provide the most benefit and involve less
> code changes. The implementation, as I surmise, will involve modifying
> the generic syscall entrypoint for early copying of user data, and
> corresponding changes to seccomp plumbing so this information is
> properly exposed. I don't have a roadmap for non-generic-entry arches
> right now, and I also haven't started designing the new seccomp ABI for
> that. As a matter of fact, members of the LoongArch community (myself
> included) are still fresh to this area of expertise, so a bit more of
> your feedback will be appreciated.
>
> Thanks to Miao Wang from AOSC for doing much of the investigation.
>
> [^1]: https://chromium-review.googlesource.com/c/chromium/src/+/2823150
> [^2]:
> https://chromium.googlesource.com/chromium/src/sandbox/+/c085b51940bd/lin=
ux/seccomp-bpf-helpers/sigsys_handlers.cc#355
> [^3]:
> https://lore.kernel.org/linux-arch/20220511211231.GG7074@brightrain.aerif=
al.cx/
> [^4]: https://wiki.debian.org/Ports/loong64
> [^5]: https://lwn.net/ml/linux-kernel/201905301122.88FD40B3@keescook/
> [^6]: https://lwn.net/Articles/799557/
> [^7]:
> https://lpc.events/event/4/contributions/560/attachments/397/640/deep-arg=
-inspection.pdf
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list:https://lore.kernel.org/loongarch/
>

