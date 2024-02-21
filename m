Return-Path: <linux-arch+bounces-2545-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8FF85D03E
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 07:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47E81C23846
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 06:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADDE39FE7;
	Wed, 21 Feb 2024 06:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="kVdlN9Zu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD739FCC;
	Wed, 21 Feb 2024 06:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.28.160.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708495811; cv=none; b=C5c0wmnnIuOPyVnR6Ywz2cKlad2ssX9sUnEYPqEYql4BneKisLN72pAXCNrVRVnlC2WbimVVcqEr1N3ZygESuTzbP2CqSlrK78PxSVEIpSOeIy1DEWXcrMlmDnUyAJchEWNcoH2WcsbGxggF8pjvSH42L0T/php3AqsihpznkUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708495811; c=relaxed/simple;
	bh=XmxTxuBUd9bgDZbvvAv4A9s2A785jmsYFz56RLFl97A=;
	h=Message-ID:Date:MIME-Version:From:Subject:Cc:To:Content-Type; b=iy7XzS1E9Kx53rTa92+2nIMzotuNgvo8jG227jQylTLtg46HrqOl3wy0ANdlpixYWDvPmJ9UWl1h9fn/SNDhLoRc8QUN5P7LGnxn9Tp64w+azecEM3fsRDnXFoceOQePCnolBUpJX7KdmOcR/sXg8dHQyQZue6+hKcNIwTAK+1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name; spf=pass smtp.mailfrom=xen0n.name; dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b=kVdlN9Zu; arc=none smtp.client-ip=115.28.160.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen0n.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
	t=1708495800; bh=XmxTxuBUd9bgDZbvvAv4A9s2A785jmsYFz56RLFl97A=;
	h=Date:From:Subject:Cc:To:From;
	b=kVdlN9ZuAQzFRahzf/zHop19IBrMMspDOw4JQJCYvj50AH7aSNfic2qr1ItfIWonE
	 ig5UFgdZjQ/Ng2tXL3cLvUGG5ZUo2eO5+hBX+yxYx3M30GeqzS75fZcmuaMe1tDJiQ
	 gEkLKrX7UzVqG6hP4zznt4WFoBYZxH6BpEYjqxyA=
Received: from [IPV6:240e:388:8d00:6500:8954:615d:4577:1f21] (unknown [IPv6:240e:388:8d00:6500:8954:615d:4577:1f21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailbox.box.xen0n.name (Postfix) with ESMTPSA id A96D160094;
	Wed, 21 Feb 2024 14:09:59 +0800 (CST)
Message-ID: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
Date: Wed, 21 Feb 2024 14:09:59 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: WANG Xuerui <kernel@xen0n.name>
Subject: Chromium sandbox on LoongArch and statx -- seccomp deep argument
 inspection again?
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 Kees Cook <keescook@chromium.org>, Huacai Chen <chenhuacai@kernel.org>,
 Xuefeng Li <lixuefeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Xiaotian Wu <wuxiaotian@loongson.cn>, WANG Rui <wangrui@loongson.cn>,
 Miao Wang <shankerwangmiao@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 linux-arch <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Language: en-US
To: linux-api@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Recently, we -- community LoongArch porters -- have noticed a problem 
where the Chromium sandbox apparently wants to deny statx [^1] so it 
could properly inspect arguments after the sandboxed process later falls 
back to fstat. The reasoning behind the change was not clear in the 
patch; but we found out it's basically because there's currently not a 
"fd-only" version of statx, so that the sandbox has no way to ensure the 
path argument is empty without being able to peek into the sandboxed 
process's memory. For architectures able to do newfstatat though, the 
glibc falls back to newfstatat after getting -ENOSYS for statx, then the 
respective SIGSYS handler [^2] takes care of inspecting the path 
argument, transforming allowed newfstatat's into fstat instead which is 
allowed and has the same type of return value.

But, as loongarch is the first architecture to not have fstat nor 
newfstatat, the LoongArch glibc does not attempt falling back at all 
when it gets -ENOSYS for statx -- and you see the problem there!

Actually, back when the loongarch port was under review, people were 
aware of the same problem with sandboxing clone3 [^3], so clone was 
eventually kept. Unfortunately it seemed at that time no one had noticed 
statx, so besides restoring fstat/newfstatat to loongarch uapi (and 
postponing the problem further), it seems inevitable that we would need 
to tackle seccomp deep argument inspection; this is obviously a decision 
that shouldn't be taken lightly, so I'm posting this to restart the 
conversation to figure out a way forward together. We basically could do 
one of below:

- just restore fstat and be done with it;
- add a flag to statx so we can do the equivalent of just fstat(fd, 
&out) with statx, and ensuring an error happens if path is not empty in 
that case;
- tackle the long-standing problem of seccomp deep argument inspection (!).

Obviously, the simplest solution would be to "just restore fstat". But 
again, in my opinion this is not quite a solution but a workaround -- we 
have good reasons to keep just statx (mainly because its feature set is 
a strict superset of those of fstat/newfstatat), and we're not quite in 
a hurry to resolve this. Because one of the prerequisites for a new 
Chromium port is "inclusion in Debian stable" -- as the loong64 port 
[^4] is progressing and the next Debian release would not happen until 
2025, we still have time for a more "elegant" solution.

Alternatively, we could also introduce a new flag for statx, maybe named 
AT_STATX_NO_PATH or something like that, so that statx would ignore the 
path altogether or error on non-empty paths if called with flags 
containing AT_EMPTY_PATH | AT_STATX_NO_PATH. This way a seccomp policy 
could allow statx calls only with such flags (that are passed via 
register and accessible) and maintain the same level of safety as with 
fstat. But there is also disadvantage to this approach: the flag would 
be useful only for sandboxes, because in other cases there's no need to 
avoid reading from &path. This is also more of a workaround to avoid the 
deep argument inspection problem.

Lastly, should we decide to go the hardest way, according to a previous 
mail [^5] (about clone3) and the LPC 2019 discussion [^6] [^7], we 
probably would try the metadata-annotation-based and piece-by-piece 
approach, as it's expected to provide the most benefit and involve less 
code changes. The implementation, as I surmise, will involve modifying 
the generic syscall entrypoint for early copying of user data, and 
corresponding changes to seccomp plumbing so this information is 
properly exposed. I don't have a roadmap for non-generic-entry arches 
right now, and I also haven't started designing the new seccomp ABI for 
that. As a matter of fact, members of the LoongArch community (myself 
included) are still fresh to this area of expertise, so a bit more of 
your feedback will be appreciated.

Thanks to Miao Wang from AOSC for doing much of the investigation.

[^1]: https://chromium-review.googlesource.com/c/chromium/src/+/2823150
[^2]: 
https://chromium.googlesource.com/chromium/src/sandbox/+/c085b51940bd/linux/seccomp-bpf-helpers/sigsys_handlers.cc#355
[^3]: 
https://lore.kernel.org/linux-arch/20220511211231.GG7074@brightrain.aerifal.cx/
[^4]: https://wiki.debian.org/Ports/loong64
[^5]: https://lwn.net/ml/linux-kernel/201905301122.88FD40B3@keescook/
[^6]: https://lwn.net/Articles/799557/
[^7]: 
https://lpc.events/event/4/contributions/560/attachments/397/640/deep-arg-inspection.pdf

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list:https://lore.kernel.org/loongarch/


