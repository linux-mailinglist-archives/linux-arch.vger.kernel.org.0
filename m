Return-Path: <linux-arch+bounces-4855-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00883905C7C
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 22:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74A61F237EB
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 20:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5EF25762;
	Wed, 12 Jun 2024 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bdracif+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eX9bv4hL"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514165025E;
	Wed, 12 Jun 2024 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222594; cv=none; b=atuftryeIQw2ySi5KM0CCZZt27mWvtkB1Ke2/4foas5e/4ICea8j5c2FHswGrMMeaHT6Us/GbP/+TDFgMuUuhR3XAt4eEkNAqHvwaGaVdlBTkSdcQrcx065e9Bc8GE0kiE4HGysC9Y2POh5UIzfyuU1mpeqdEp72uxnfUVvlDwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222594; c=relaxed/simple;
	bh=eDHqA85Z2rvfYj1BKRq7EcTMlaC7d4L2JpS6byQL4tc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=qjecl2vXS5q4ESfyygwuHBK2JhwIx9kqnx0i9FKTS8quX6OMjFtE1POQ2jjAfa/bZPXYdVrtC0egEz6o+8w0o0v5PXmzgn6RG+RixRRO36FR/PgjiUzYMsQTn+teB1L9sTZ6AO58fsw8H/Ws7lk77nutzSs85MSFruzXRJ9bJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bdracif+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eX9bv4hL; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 635B41380094;
	Wed, 12 Jun 2024 16:03:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 16:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718222591; x=1718308991; bh=eDHqA85Z2r
	vfYj1BKRq7EcTMlaC7d4L2JpS6byQL4tc=; b=bdracif+6Oclj0KIBUZFAt+CB7
	exErJOai5mjL4Neqf4q7OsiFw0WAUDksfzHhHkU70285bw5zVvhpCWmozIydRXvg
	FlUc1zXQMOhmAi3A8KpBYGFLkAUqGOQ+jBko3PJvMYWb8Yk8gP0nhY50JJe3ue/Y
	0fAgVxSACjHC6jpgRMSJcgiIP2vmoseDiNLgg9OwagisvvURaTIj/XsODLBopOfH
	zBq+EsMa1XTA8vX0jWywkVud6IQMqL48NDlb2kZTaTcYMUfCFueXnwuv92IvG2z+
	k3G4y8I6TphHNizAGCIUpdvoOYsMmutZLMCh9SfFSaSTWmDPs+1kajPqGTzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718222591; x=1718308991; bh=eDHqA85Z2rvfYj1BKRq7EcTMlaC7
	d4L2JpS6byQL4tc=; b=eX9bv4hL3MFv4oTDfL4B6wWacg87KjSHyV9TxOs9sdiv
	3K+oYZ2uej7uqvaW/GWqeh39F52u7a1JhBnugU405vl9KAFaYOCS1VhcprXdZYc9
	TRQFPzz+xBR6JwrRm27SHvnynATqjjICgI/u1kKfYFk1sGeTALG5k+t62EtxPljv
	eYeJ2KZtGWeAWZ481ZBVdYUES9+oCvZU7l9JimAxflMkQ5+AXeo2gyNdY9sd2cIP
	54r3d2gq7n6oy0SIJiOoG+9OUXiAi/y2QJRLr14QnTyM6ToYhWgktHsjVeXaD8gB
	otiaNf9DI0q/K3VR5O9z1Y99qc6htdsYrI27gE/VgQ==
X-ME-Sender: <xms:__5pZmtm4UKP1S7K5zU1GcPPMfh1vVxUzJGkCMM7OVmWYSrU10_Lwg>
    <xme:__5pZrfZlnhhxbQKiU3UyXq5R5xe03_96QJUdNQyeeVMs_PytX14ph6rstVOXD8aA
    3Kd7cQ5C35wL3xU2G8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:__5pZhx16T38Gc-lKXSw9kn_Gkl6b_7ukmKQsXtCe_6KilD-Td86OA>
    <xmx:__5pZhNxUZ5gq7XmaXgqPlsjEPwxF5lKeGJd6i6LWVG0y_rBLtHGhQ>
    <xmx:__5pZm_7C4jicZUyKxkEXJTdHnrCsKNeC43nRUCffqf2MMIBjr-lYQ>
    <xmx:__5pZpVkOj4MiFlzdTNFdKj3a9pWTlyGJRXbLBdengBOj1-1de9Rgg>
    <xmx:__5pZoJni_9sYcxUGm86Ruo2h_BcS8XQ26p3Ud_v-2Q1FGu-66gZKHrZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 08BD7B6008D; Wed, 12 Jun 2024 16:03:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7f258a4c-6048-4718-851d-4768789bc5e1@app.fastmail.com>
In-Reply-To: <20240612160038.522924-1-steven.price@arm.com>
References: <20240612160038.522924-1-steven.price@arm.com>
Date: Wed, 12 Jun 2024 22:02:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Steven Price" <steven.price@arm.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixmap: Remove unused set_fixmap_offset_io()
Content-Type: text/plain

On Wed, Jun 12, 2024, at 18:00, Steven Price wrote:
> The macro set_fixmap_offset_io() was added in commit f774b7d10e21
> ("arm64: fixmap: fix missing sub-page offset for earlyprintk") but then
> commit 8ef0ed95ee04 ("arm64: remove arch specific earlyprintk") removed
> the file causing the only user to be removed when the two commits were
> merged. Since this has never been used again since the v3.15 release
> remove it.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> This came up because for Arm CCA there is a need to override
> set_fixmap_io() [1] and rather than also update set_fixmap_offset_io() I
> thought it would be better to just drop the unused macro.
>
> [1] https://lore.kernel.org/lkml/20240605093006.145492-6-steven.price@arm.com/

I assume you want to keep this with your other patch, so

Acked-by: Arnd Bergmann <arnd@arndb.de>

