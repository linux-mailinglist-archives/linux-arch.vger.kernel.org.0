Return-Path: <linux-arch+bounces-10978-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8846A69B33
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 22:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1781885E82
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 21:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01645213232;
	Wed, 19 Mar 2025 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QEhnGNi1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FrIE3W3B"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16E1DE2B8;
	Wed, 19 Mar 2025 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421024; cv=none; b=LEdrjUBC5sFnYM37KR1+SwFo18JUby6jJTFCuWES4+zUnVFHwYUrsMwb5pDD+9jfnljU5PDDW7nNLQMRx/seD4J9agCgUtS5/dHkzx9Klu7Mt/f2K/Qz/GekXLhBpD5DhsJNIHgvQqzhX+aSqm797udspX1vQ8+BiwzZWoPRnpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421024; c=relaxed/simple;
	bh=OA2OuBazFxyuH70X8/HWVXMN3X6BULDgocEPEJ0iJdg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=g5bOnlJLeYkVxXqvvQhuzbM2m6CsNXVKtvdHLkJ0G2cdTQpqVzDdtrs28UGeQoEIVLEfjxdecrovBCebtcA1wrDXm4ptdrKIOJAmZnYcxD6zwYmxxc1q3o7+XFOMf5T4Q1xkjUYXzMru8sR5KR3iwjP/Oc8qYv6bbiPT9UEk73s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QEhnGNi1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FrIE3W3B; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 382A711400EC;
	Wed, 19 Mar 2025 17:50:22 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 19 Mar 2025 17:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742421022;
	 x=1742507422; bh=WfKJMezWqc+nSdhVQn3eKqAC+DlMem0afV5xnH1fPhs=; b=
	QEhnGNi1M+zgofeg+Yvb5pS5Af5xFoQ5wv/VpID9XUdfThbqRJhy4G04Mzkzoz7i
	opKuvx5GKytYSq98eB5CtktenwKjEPjMNQCPeoxqQdBA2JgJTsjBNZuDHDxJjYep
	msqvG5qbJlnjJlkG9/i+OKdAI0fajrcFOisMSKrmBMo3jK6FtjWCt4yzXQvqZiam
	NDgncv4XwccqGvtoK+0er8UOvAi9qwHInamwyass80eOvP/7UoDtIc3ASs7F/PNk
	BqbXDQX+b1xySx8hokyekXVXki7jp70pvBee+2aqNceSU+Dvqx67uxLCb9uNFkmg
	nnPa9sqdQrSyIq74KaEGYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742421022; x=
	1742507422; bh=WfKJMezWqc+nSdhVQn3eKqAC+DlMem0afV5xnH1fPhs=; b=F
	rIE3W3BnFNfV9MEQcWY+tc+5XIZvTEoDBq4KXLVC2DNpr2hW9ewpIQLqnQ01AXX/
	XZzCKqRLoGMUi4x9K7APM95RI3cYVSRnlf0QVg6bxJNVilq+kg5h7QFH0+rBgITa
	piSppB2By2lMz2mlZVY9GB3hSlCyfU852n5MkUtgljqM8eo016apgMd5QWiIdCpa
	tzvLkoWG7KzLSCff6zQtnQnABW06URn6FDSL9OQEbH4G19v5pDD/uWP265FxNBAl
	0Hp/tXcd16alZJ7qiTI/rGi+ZKwqaZI08b9cznMubpTZMiMbEz8ubTlGFcCCIfgr
	y1nHiidtmS5gEI5hn7KNQ==
X-ME-Sender: <xms:HTzbZ4YISa3tXZnJMLbbntX_3bIUQWsB0idtTGl3U6KIlom8q5yGlQ>
    <xme:HTzbZzYhP73lp-jkb0PB4NTb7S2Yk2ig2Ln8LDwmiWWVsQlWfa_6pH9vLTQGgQ1yg
    Gv33hwnM_MMyYkbOJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghlmhgvrhesuggrsggsvg
    hlthdrtghomhdprhgtphhtthhopegrlhgvgiesghhhihhtihdrfhhrpdhrtghpthhtohep
    iihhihhhrghnghdrshhhrghordhishgtrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epihhgnhgrtghiohesihgvnhgtihhnrghsrdgtohhmpdhrtghpthhtohepsghjohhrnhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehskhhhrghnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhdqmhgvnhhtvggvsheslhhi
    shhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:HTzbZy8A4LQKrfGEy0FNdDSsQltJ7sY46nzls3TIbSlsACctFKz1Qw>
    <xmx:HTzbZyq6wXVf1AvrLFgjc3nvxn2WlKic6OQk_5i5t3NdOVFCLm2NAg>
    <xmx:HTzbZzrEuXeKSO1g7Z4Cdjprre8yHxgWTHBQVHcD5edRNK0PTaQfEA>
    <xmx:HTzbZwRFw5J29nH6KcAW5mrV_U9qrcYlzx2ILAoyXt2eJIni-TPsbw>
    <xmx:HjzbZ8SghM61MZuaTbhUjCASxZQHEi-qw2XAKzoWwzfv7SzijGL4wL05>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 77B0B2220072; Wed, 19 Mar 2025 17:50:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T04d17f90b906d792
Date: Wed, 19 Mar 2025 22:49:57 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ignacio Encinas" <ignacio@iencinas.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Alexandre Ghiti" <alex@ghiti.fr>
Cc: "Eric Biggers" <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Zhihang Shao" <zhihang.shao.iscas@gmail.com>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <07b8051b-9d5e-440e-b74d-1ca97402fe2a@app.fastmail.com>
In-Reply-To: <4d45df0c-d44e-4bb6-8daa-0dba1b834bc4@iencinas.com>
References: <20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com>
 <20250319-riscv-swab-v2-1-d53b6d6ab915@iencinas.com>
 <2afab9dc-e39c-4399-ac5a-87ade4da5ab0@app.fastmail.com>
 <4d45df0c-d44e-4bb6-8daa-0dba1b834bc4@iencinas.com>
Subject: Re: [PATCH v2 1/2] include/uapi/linux/swab.h: move default implementation for
 swab macros into asm-generic
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Mar 19, 2025, at 22:37, Ignacio Encinas Rubio wrote:
> On 19/3/25 22:12, Arnd Bergmann wrote:
>> On Wed, Mar 19, 2025, at 22:09, Ignacio Encinas wrote:
>>> Move the default byteswap implementation into asm-generic so that it can
>>> be included from arch code.
>>>
>>> This is required by RISC-V in order to have a fallback implementation
>>> without duplicating it.
>>>
>>> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
>>> ---
>>>  include/uapi/asm-generic/swab.h | 32 ++++++++++++++++++++++++++++++++
>>>  include/uapi/linux/swab.h       | 33 +--------------------------------
>>>  2 files changed, 33 insertions(+), 32 deletions(-)
>>>
>> 
>> I think we should just remove these entirely in favor of the
>> compiler-povided built-ins.
>
> Got it. I assumed they existed to explicitly avoid relying on
> __builtin_bswap as they might not exist. However, I did a quick grep and
> found that there are some uses in the wild.

Right, I do remember when we had a discussion about this maybe
15 years ago when gcc didn't have the builtins on all architectures
yet, but those versions are long gone, and we never cleaned it up.

> I couldn't find compiler builtins for ___constant_swahb32 nor 
> ___constant_swahw32, so I guess I'll leave them as they are.

Correct. There are also 24-bit and 48-bit swap functions
in include/linux/unaligned.h that have no corresponding builtins.

      Arnd

