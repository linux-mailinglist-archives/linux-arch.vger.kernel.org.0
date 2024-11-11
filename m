Return-Path: <linux-arch+bounces-9025-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEEE9C49BA
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 00:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F296F1F2250E
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 23:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE97E15887C;
	Mon, 11 Nov 2024 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="jHeGS14M"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out.freemail.hu (fmfe20.freemail.hu [46.107.16.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D7118871F;
	Mon, 11 Nov 2024 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731367930; cv=none; b=cCLqQHuyFnW2Q7ZGO6s563BT7qsqgDN8CSBHF93ZQR3np0Cdxz6PFRpI1Ny+N6ot4tPCLt/n8oBoY5W1cms/5DG2c2Rjj4jcQJqeRtz0rWxNjS8PBGVbMervpnbvjvAul0uNVJyHU7hYQestmjHbjMwnotHMfJUKmY0EILyJ7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731367930; c=relaxed/simple;
	bh=PZN8H+nCNm6d6eEGz6KZqWH4rX1zk/SeUw4msKerftI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsJ0BRwOO76zI8JcFrUYClIksZPIbAuP478UafsjPsEnHhU7dSuSIMLp9HWoHK5fCnV7VeWAJ4s2mvUghrQhb2Jsztb9iecRcYiiCHL5/qWyvMpLABB2Xa/2f8feOxfOLsHjTywi+EAnn6Pz5IoDGQWD10QNK59z6o4OE+Iaua4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=jHeGS14M reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4XnQYJ4X6mzC5t;
	Tue, 12 Nov 2024 00:21:56 +0100 (CET)
Message-ID: <705daf58-dd30-4935-9864-6489b9b90a35@freemail.hu>
Date: Tue, 12 Nov 2024 00:21:51 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
 will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
 npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
 luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
 joel@joelfernandes.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, lkmm@lists.linux.dev
References: <20241111164248.1060-1-egyszeregy@freemail.hu>
 <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
 <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
 <CAHk-=wiEuh613GjBefTRe-_Eha1X1GoU=1nLt65uccSBC8Ne=A@mail.gmail.com>
Content-Language: hu
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <CAHk-=wiEuh613GjBefTRe-_Eha1X1GoU=1nLt65uccSBC8Ne=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1731367317;
	s=20181004; d=freemail.hu;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=1846; bh=YKWGWpohuX4Fzq7p1VLZ81e0IBXFrbXOkVkl0oiKp58=;
	b=jHeGS14MPHGxHqJ6u7G+KxtAcAClfSMwnUbsQM5tmT4KOlQce3l21TWCljprC/hO
	gD9Ajtw5gUOZCRZPH8rz2gY+xIY2CTBl39C2FMj0TEA8hMCIF+L925jI6dDwumps4rn
	32E3GsNyaymUhW5EGKEtoQBvz0nyXDMCID9rk85LGEy4zTiRGhnagwMmJ4FeyDTkcfZ
	iIv5enA6C4lKrbyp7neiHsZULlRkPNg4110dGJ251SnA/qO6v8PmMOtaarkS+eN56uv
	Hf8UK+Fd1u5aBKPE9KGIQqkwmg9ThZpMRz598HI4JR4TU+DC1EkpgnZxsTEj07w7MWb
	AOm7KdXbBQ==

2024. 11. 11. 23:00 keltezéssel, Linus Torvalds írta:
> On Mon, 11 Nov 2024 at 13:15, Szőke Benjamin <egyszeregy@freemail.hu> wrote:
>>
>> There is a technical issue in the Linux kernel source tree's file naming/styles
>> in git clone command on case-insensitive filesystem.
> 
> No.
> 
> This is entirely your problem.
> 
> The kernel build does not work, and is not intended to work on broken setups.
> 
> If you have a case-insensitive filesystem, you get to keep both broken parts.
> 
> I actively hate case-insensitive filesystems. It's a broken model in
> so many ways. I will not lift a finger to try to help that
> braindamaged setup.
> 
> "Here's a nickel, Kid. Go buy yourself a real computer"
> 
>               Linus


In this patch my goal is to improve Linux kernel codebase to able to edit/coding 
in any platform, in an IDE which has a modern GUI.

Chillout, i am not so stupid to compile kernel on this "braindamaged setup", I 
just like to edit the code and manage it by git commands.

So, this is a tipical Braindamaged setup in 2024 for Generation of a half of Y 
(like me), Z and Alpha developers.

Windows or MacOS system
- Visual Studio Code for coding
     - Git for manage kernel source
     - IntelliSense in coding
     - Live coding with other developers

Linux remote server
- Visual Studio Code remote SSH extension/connection for Linux server
     - Sync kernel workdir with remote Ubuntu/Debian/RHEL Linux server
     - Remote SSH compile for X86_64, ARM64 etc ...
     - Download the build result

Instead of Visual Studio Code it can be possible to use JetBrains, Eclipse and 
so on any other modern IDE. The actual limitation is only, that there is a 
filename issue in the Linux kernel source with 
"Z6.0+pooncelock+poonceLock+pombonce.litmus", why git clone is failed to work 
well in this case-insensitive OSs.

