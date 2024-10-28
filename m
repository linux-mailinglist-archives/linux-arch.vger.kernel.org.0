Return-Path: <linux-arch+bounces-8667-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D489B3D30
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 22:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 309F5B240EC
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 21:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8A61F7572;
	Mon, 28 Oct 2024 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FHfEQtgA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oZ4N/NCk"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6041F4FB4
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152166; cv=none; b=Skckc3krqOOvHeFqJLscPgcyxmu/r9spujADPaYb3tRHonMQN7T3PVGYiMuB07EPLnIwB5k+3zw7zYzkAnRhf3VEhJWrqxnXWnk2NQhvOMX8Kan3go4BG/5bHm6fZx+Izg8DUx6hpEON3t3uFXfSKU3GDaozZLw6FrAxEmcqd6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152166; c=relaxed/simple;
	bh=PCzfrCyAn1USlTYlC0D7NCX/Zih1P57LfgHFt/Wa2KA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fz4pzr9EbQuhERK7qkrHDktP3XEsbh9Zl0lyzgK/ab5pcaTGp6o3VsVo32ABgUXhrpaK7yl757vuvKOxgP6WDNlkkpMpxqCRszngdXTdmoBBOxCRhC0x5aJg0ORZ5LfxrAluxUazkcll1RvcyR2+HZ1QjX2b6DMLL2wplBg4MVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FHfEQtgA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oZ4N/NCk; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id F0B8B1140149;
	Mon, 28 Oct 2024 17:49:20 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 28 Oct 2024 17:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730152160;
	 x=1730238560; bh=xLLPqQtJaYi7ueH0VqsE3g/+OJvjtkRFF3i/MFHsu9w=; b=
	FHfEQtgAgM8tIk+Yj25BW6pYoj962TNd0MmNMuAC2H+xx0hZA+Nf7zL1NV+SAvgn
	HvwW0ESFG6+B/nuzfAdgP8TKyHpE5ZdShrjji4UOeYo5ue+JKp78UFDw2cf0qKWc
	lI235EJjRH5Uz8GdMN80taeEYGWTKDyGKaXyNaD+R+GTvWd4oYovJdusxxLPts0z
	bsgKg3cFGy/isNrjnDgjj8KrzjWQplACi+2DPtk2eltdC94cnUIvlyysZVW6zGME
	G6YHiZeVDHCjfrJGlei96Z/6WQZ7ZZ2ZhaIOM5PZYpZjt+4OPhsaxlbUOTO5XWM8
	3TzZillXIbbZ05XpZNKpNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730152160; x=
	1730238560; bh=xLLPqQtJaYi7ueH0VqsE3g/+OJvjtkRFF3i/MFHsu9w=; b=o
	Z4N/NCk1gzTHv72e4ojEFsXUyMGC/UWJC0SYAtFj4Tl2YRtkHhVqdq9HZA9lilQS
	g6PVQ+SdGcr2xgePR1q+Sa9b/3PVZ4xy21Nt+ht96K0Hrfiv3gdoWRs3NF8iHx0A
	CLuLF0+/SLc/D6ppkIR2w9sF9OZelBZzBfMIhvxNKlBPDOXsj3QsecJrbHcK9DN4
	OnKBl7K01N4BYTc/Zeyqvr8GjvdYKNF2CHLDI7HzM2eDqaD3JONkZi1tvHgi78kb
	WbPypd2ljC5SaUAAaKh4fPmeh2CO9teVQzxI4YcgAkBnRNpPIRlmbIB/LmLu/q0N
	YxIupHuAG0zU2+ws89HWw==
X-ME-Sender: <xms:4AYgZ3SE7GUvPLohUNmdrNtKjHGIlwcZ55sZe5R5l0jNIxOEwMtMdA>
    <xme:4AYgZ4y5mt9yzQwiEKaOGQmfKh1Jiy-1dfgq87GYpCzW-7hkVwNjeygO5m13AF5EO
    ac5OSedkwTTgYRi7ek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeehkedtueetuefgveduvddtieekffdtveektedu
    leejffffieekveeffeeifefhgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddtud
    drohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoh
    epiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhkphesihhnthgvlhdrtgho
    mhdprhgtphhtthhopehjvhgvthhtvghrsehkrghlrhgrhihinhgtrdgtohhmpdhrtghpth
    htohephihsihhonhhnvggruheskhgrlhhrrgihihhntgdrtghomhdprhgtphhtthhopehl
    lhhvmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehovgdqkhgsuhhilh
    guqdgrlhhlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidq
    rghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4AYgZ80gBaShwMU8DAn5SYLlBBezjTfv8UNb2NYwJ2V23_cPmJSMdg>
    <xmx:4AYgZ3CRhrlwflb0sCItqQRivSM5VknVEk9ZBRHnFullErbS6fhGyg>
    <xmx:4AYgZwhRelTbWGOfuS6Sht3sN3c6IE8Nd6lS8lr7i43jboNwhkuxAw>
    <xmx:4AYgZ7pMKAETUnV7qh3juIRS90c8gMgQz02_335GoXdq4NzgP0nQdA>
    <xmx:4AYgZ6ZHBCMvHrk-amXAG_tA4W-8huUab0Jym_ttSb_AENOYZK3Sc3Bc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 66F2D2220072; Mon, 28 Oct 2024 17:49:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 21:48:58 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "kernel test robot" <lkp@intel.com>,
 "Julian Vetter" <jvetter@kalrayinc.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "Yann Sionneau" <ysionneau@kalrayinc.com>
Message-Id: <52a1eda2-1daa-4f2f-b722-7dcc65c686b1@app.fastmail.com>
In-Reply-To: <202410290137.rHycxdZj-lkp@intel.com>
References: <202410290137.rHycxdZj-lkp@intel.com>
Subject: Re: [arnd-asm-generic:master 14/17] lib/iomem_copy.c:10:10: fatal error:
 'linux/unaligned.h' file not found
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 28, 2024, at 17:20, kernel test robot wrote:
> tree:   
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git 
> master
> head:   e6a5255d009d8427b6609b25c729048f894e9d60
> commit: 4030decf42ca0da176fc1d5c556fc3f0035df6c9 [14/17] New 
> implementation for IO memcpy and IO memset
> config: x86_64-kexec 
> (https://download.01.org/0day-ci/archive/20241029/202410290137.rHycxdZj-lkp@intel.com/config)
> compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 
> 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
> reproduce (this is a W=1 build): 
> (https://download.01.org/0day-ci/archive/20241029/202410290137.rHycxdZj-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: 
> https://lore.kernel.org/oe-kbuild-all/202410290137.rHycxdZj-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> lib/iomem_copy.c:10:10: fatal error: 'linux/unaligned.h' file not found
>       10 | #include <linux/unaligned.h>
>          |          ^~~~~~~~~~~~~~~~~~~
>    1 error generated.
>

Thanks for the report, the header only became avaialable in 6.12-rc2,
so I now rebased the entire tree on top of that to avoid any
backmerges or conflicts.

      Arnd

