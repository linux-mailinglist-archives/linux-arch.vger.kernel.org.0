Return-Path: <linux-arch+bounces-9412-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4A39F407D
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2024 03:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC20161D88
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2024 02:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D9D13E02E;
	Tue, 17 Dec 2024 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kz/3TXCd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDBD13DBB6;
	Tue, 17 Dec 2024 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402005; cv=none; b=s1Y8N43O4RUVzvQoTrdedprgNyb0jvM7BL/E8SPsRxLCe0umsjRKfD6lLBZZlWzgig3sTWedNtycwibedXuSMeOWc9dIPe2MwmVjyMIXwofPrtCUhPH/WA/wkme+KW3DYIvDXayADo4aQ7Xec9OlNVbesuHCRZQcIlreQVyF2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402005; c=relaxed/simple;
	bh=Zot6Em4Di0coBiKxeXdbs2tjclcZ+C2YYQ9nbTfTr1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CviQ0J+194sxaI9jvFoHPPcE0iq5+MQWkN1weNKVdFVif6hUylb/eQvaEWyEqaIfZTL86sYAxbSBy/MiIoYcPmfH+LZy/EizFk1lX2MfRhgCQyI4khkTI6/NNQtU190cdTqQlDEqfem1KDbcZzMF8s+9uJlZlbzSfaBKdRFmquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kz/3TXCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74D2C4CED7;
	Tue, 17 Dec 2024 02:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734402003;
	bh=Zot6Em4Di0coBiKxeXdbs2tjclcZ+C2YYQ9nbTfTr1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kz/3TXCdt7zW6TZfim1b5SYJT7miZdxCADSIFvfT0ueZUZGHVmogm60J2VQjjKBb5
	 H1sNBY+MZFuzYHo2GUOud4pyBf9TP3SBDqAjoHWFd41tL5naAQerd+G4KapQxSwmtK
	 wO0EhLSQjOO0IzydHsiaFWYPnQi0HuKPpVV3CAOQYObJCd9v6o66OP4ohjdHTl3WsH
	 aTndzfU7Dvh/9TVOhha1lqsgyvwkxCypDH/2iU0Tpt+ncBk6C5l4jNQd1sfDcWRnr0
	 J69VPS5ZzcuFLpBTIGCLSPMK2hpG1vEYSrnG6fx4+FR2SdwHJ2KD18w+cK/goDwtfX
	 X+3CGwtRNqzbg==
Date: Mon, 16 Dec 2024 18:20:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com, idosch@idosch.org, horms@kernel.org,
 dsahern@kernel.org, linux-can@vger.kernel.org, socketcan@hartkopp.net,
 mkl@pengutronix.de, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 tsbogend@alpha.franken.de, kaiyuanz@google.com,
 James.Bottomley@HansenPartnership.com, richard.henderson@linaro.org,
 arnd@arndb.de, almasrymina@google.com, asml.silence@gmail.com,
 linux-mips@vger.kernel.org, andreas@gaisler.com, mattst88@gmail.com,
 kerneljasonxing@gmail.com, sparclinux@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, deller@gmx.de,
 vadim.fedorenko@linux.dev, linux-parisc@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/4] sock: Introduce SO_RCVPRIORITY socket
 option
Message-ID: <20241216182001.557e2c19@kernel.org>
In-Reply-To: <20241213084457.45120-5-annaemesenyiri@gmail.com>
References: <20241213084457.45120-1-annaemesenyiri@gmail.com>
	<20241213084457.45120-5-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 09:44:57 +0100 Anna Emese Nyiri wrote:
> Add new socket option, SO_RCVPRIORITY, to include SO_PRIORITY in the
> ancillary data returned by recvmsg().
> This is analogous to the existing support for SO_RCVMARK, 
> as implemented in commit <6fd1d51cfa253>
> ("net: SO_RCVMARK socket option for SO_MARK with recvmsg()").

Could you follow up with a test? The functionality is pretty
straightforward but it'd nonetheless be good to exercise it,
even if it's a trivial C program which sends a UDP packet to 
itself over loopback?

