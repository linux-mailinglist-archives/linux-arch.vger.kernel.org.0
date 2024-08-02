Return-Path: <linux-arch+bounces-5932-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59063945E91
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 15:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10090284985
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 13:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E31E4851;
	Fri,  2 Aug 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="epIVo00W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kldSn2t2"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A881E3CD9;
	Fri,  2 Aug 2024 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722604889; cv=none; b=stEAiPLXCAITbeLDzpiLtf/+l4x4xYUXww1MYZ9K7Sh9dk2pScJNWTGPsZHqatPu5kdMCuaTdhvACPzWmkTLtUTlD1jMQOiW5POwldaKMmYkK7ykRgNVH2iFpjrjEKDwc9RGE++qSn3PH+Zwae/6vsIYR32pALxdo7xOwpgb+mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722604889; c=relaxed/simple;
	bh=cSLJlId3048xUDzDzETlQq2kyFOAUGRX9QnBxR7627Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CquXCPPJmRAVuiEPVOqQM6J0r4toYo8T67xX7OfOD6n2a2pq1DkC+Ti0wr83Lircc07orTPkmXkkwKCt4z9EIKVYIJtQYNeWxgslSA7Q8NJOeMfH2Wx5zXgWoQrAHaxGLX8jf2imuNbis6+rYHXIzet7fot5Ux2fqYb6Dzk3/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=epIVo00W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kldSn2t2; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.nyi.internal (Postfix) with ESMTP id 91C96200DFC;
	Fri,  2 Aug 2024 09:21:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Fri, 02 Aug 2024 09:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722604886;
	 x=1722612086; bh=R0DqKzGqX1xbFZH9FuQ/nKBXdcQF/KmOifqz6blhFYM=; b=
	epIVo00Wp9YMmgC8ttebh96AyyWJ0vAYt35/n8Ah1/6GY9ca74EgslxUxVYBy6F/
	alDG1oRu77WQKa12vLryeyas4G0q4g6y1pbWWehUQFT5jc4vNYNmMF1n/QeyjKk8
	jyIgz90MQxO8Px0o9f3CDEWWv9n42BZHqCsEJvkyzXbDHwcY67PX8j0cvQ+8XuFD
	L/FahPp3Y36o2t4UNs4ukx7quF/xJeQNFt670ItFWoqKvWlUnaLZcmsHV2n8+zCQ
	qul3z/SWL2uqUBNwpRyPuCYAvJndGN8bHvzeSHYAL87Gon937cjshMhTmnUwtvNZ
	Mz833tOZb04f9SOf+zhaMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722604886; x=
	1722612086; bh=R0DqKzGqX1xbFZH9FuQ/nKBXdcQF/KmOifqz6blhFYM=; b=k
	ldSn2t2FtBUOpOcVK5o8ITMmEbXPZEsoi6QwwoYGucMAGz6/sqnNsZ90q/7ovktm
	kqQTg8WttPN+yB/iKLzFb/lCGRysoCblxcVN5h8AgIHS9YGJ/IhOphNwAk6Mikqe
	uXppIuQPHd+TGUg0z9XtAejATk5V8+Ldru7JghIHVEVg1xGIEG1hUFaBd/eR92pn
	2+y3apg4bWfv1nI6D2F3irjTxiQ+742zop0DEI77juuhyKdaHNw/rYyHOaT0/yhK
	JFlC0a480YQmdJTGtMKn4cbe2dVLMOJBCMHzl8bbOLkTUp3nR7wxe0TQtLD++MMA
	c+lQGI31lnfeSQb+abfCg==
X-ME-Sender: <xms:Vd2sZtIPksSVLwqVWP20KQPBb6WAsqKVG5PBBve_xYkoQUfuqDvxaQ>
    <xme:Vd2sZpKE9eWo0CbVEPoIiV5zMut6irh_xZyEUaU4QGpx9QDWmKK5cGhpdAbRgyeqA
    UojwRIMa_FLJSzK9ec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkedtgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdv
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:Vd2sZlv2nEgNMtIrDfuarcE-IsCX971gYvIrlSwicWxEgcc1EaTjJQ>
    <xmx:Vd2sZuYS8jqkM2Nc_Ebdow8iPW5fOox28yQNpQONjcw_7H5-XhMhrw>
    <xmx:Vd2sZkZ0WLLb9ySlLDZ2kXhAqDFNpLMUjgspUwm0AnjzbCSf_sATZg>
    <xmx:Vd2sZiACj81lIx51y_lXAxSLVckwPu-xI6Shd0DP_sgO0Ls0NGt-fA>
    <xmx:Vt2sZkNqje0BCjj3jKuDa5CPjs_vBlOJJ6Xug-0-GnuQbN9FKiLzJ5aC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B96AFB60092; Fri,  2 Aug 2024 09:21:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Aug 2024 15:18:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Jiri Olsa" <jolsa@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 guoren <guoren@kernel.org>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Kees Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "H.J. Lu" <hjl.tools@gmail.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "Oleg Nesterov" <oleg@redhat.com>, "Andrii Nakryiko" <andrii@kernel.org>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-riscv@lists.infradead.org
Message-Id: <6662ea26-9850-48fd-a67c-01daf412dc2e@app.fastmail.com>
In-Reply-To: <20240802181437.29b439e26608561f1289892a@kernel.org>
References: <20240730154500.3155437-1-arnd@kernel.org>
 <20240802181437.29b439e26608561f1289892a@kernel.org>
Subject: Re: [RFC] uretprobe: change syscall number, again
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 2, 2024, at 11:14, Masami Hiramatsu wrote:
> On Tue, 30 Jul 2024 17:43:36 +0200 Arnd Bergmann <arnd@kernel.org> wrote:
>> ---
>> I think we should fix this as soon as possible. Please let me know if
>> you agree on this approach, or prefer one of the alternatives.
>
> OK, I think it is good. But you missed to fix a selftest code which
> also needs to be updated.
>
> Could you revert commit 3e301b431b91 ("selftests/bpf: Change uretprobe
>  syscall number in uprobe_syscall test") too?

I folded the change that Jiri suggested now.

> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

     Arnd

