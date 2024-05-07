Return-Path: <linux-arch+bounces-4237-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08418BE1FD
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 14:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08E51C21D7F
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BEF15B13C;
	Tue,  7 May 2024 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ifBw5NT9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PkvduBUX"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580C15B122;
	Tue,  7 May 2024 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084573; cv=none; b=RPNyeDXKZ+n2lhZIJFGOmkw7+XV0v1aMwkZvnVjWF3Yd4GZqc92CsNgARc6NkDRvIzPM2sSWQbTeDnYO7kjSzKijJh6BZRbEAoH5edpL4Qw5sow+wKswiVqYgg91o4CUKLuZm9DRmItiKMfKsw1sSWvGME8ZAeS0+z51VBL3K1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084573; c=relaxed/simple;
	bh=y8VaN2C2Lb/zwvs3WI8QGM2GRDqxMN19nU16yC+sBBY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Dc3balR/HHysIcu/M7rjIuh894DbadPueamBu2KF86RpKYT99QJv2kk/ZwvdpzSFeTcJkZjbrwQ5oBs8DWWWKsGGcxWdzZWzMYMg2Amd7UOoFmVyd8z65c04MTXNWeRAhYpd/bhT40oP6ug6zLI/IuAoplxuEp0kmTR6Kns1jj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ifBw5NT9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PkvduBUX; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 0987E1C00147;
	Tue,  7 May 2024 08:22:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 07 May 2024 08:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715084569; x=1715170969; bh=FSinqpKIaF
	60W78nt3gDdxMV8XkuEU2I/rFx5MeDR5w=; b=ifBw5NT9jIIvAaFOaI8vH/kFHZ
	ko5fDWZ71aq4Nhw3rhSwsNXxlrlR9XRv4LMJxiE52CdZbI/b8bnVzk6hA8j14/3C
	KlCtOodftCo72BMI7yYqr4CYz9pxlpOSePny5SV713tfM788qXo4o2dZNrCciXPH
	ul+0qITGiMd0xGLXqi+5PR//ZURar9b0ExzAlgK0Durcn1yGxUSOfxI3gPsk+Q43
	wOXu0LETczPUtj8BY6+Ipq9uex0NSK59ya442VJ7skNwQ1uvxRV3L0Mq8Hzekwzz
	vicdhPHaAoaDeZeJFK4K3rAI01Wsdola75sMx94inl1SYCDmcUZiM00IQNlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715084569; x=1715170969; bh=FSinqpKIaF60W78nt3gDdxMV8Xku
	EU2I/rFx5MeDR5w=; b=PkvduBUXlm/oqR55+wHQBugx+Vkaq2l17SVOoWH7zV5k
	eq4VU3VLKnIoSnaUmefuqnQ8t7eebADu+WHshG0xpQWVN/c5GwaE5NWmxXSxrorO
	QPQrdUd3PbcYYeav66oGydr0z72VAW8pgEa/Q2/wjAMXHcaapdRFG8/n9gKxIAJL
	qiqQmFWL//EghKg0bO8iOSegdfZ2Qjc+9Hos1Vhs3sRuD1/D74yEskFZBwO9syEm
	JDpGjr9Hh1uZWY1vwEAzw1+CEQMZl215fOf8Y2z4yLz6vbVQN7fcd1M4a5Ja5SBI
	Ct345sFYHQ5uTKWfe9nRa66fCOwETxVYaXMg/CKzhA==
X-ME-Sender: <xms:GR06Zj4Sj_r2obgH6pPBYbPowGVAAjgobVGZsdNWFPOJtF-sxegQ-g>
    <xme:GR06Zo6UbBapwGj6PWtqcZGSgQPrxC106B4Pvka_8g__ENUzHhWJ9Btmpw5wQDhAr
    az41wgj7UzYWMRlgaU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvkedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:GR06Zqcs-yfC7VPBJ--_tbScsUFfqL7Yg8H2ZUhn3N8xr4lJE2PIgw>
    <xmx:GR06ZkJ55_AY2WqRN_6nwNucz_z388hIxcoonfdXEMIkFiu3vw_7wg>
    <xmx:GR06ZnKxm8qnZLmdhf6IBiUA7fWNH2zUQDIUr_lbKgRHUg7qumpnWA>
    <xmx:GR06ZtyVtRcMLlnoYJtHyAWK8eTMWI8-fx7BFtHHhVQFrj7mzjVNNA>
    <xmx:GR06ZuW6jAG8v2SHIl1d1BZH08O9wPzuK2u-7xFy97LtX4tfylDDkoAk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 638EEB6008F; Tue,  7 May 2024 08:22:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9d6ff3c1-752a-48ce-be28-00146f323dab@app.fastmail.com>
In-Reply-To: <3E99B315-844D-4B5D-BD5B-CFC18EFE304D@toblux.com>
References: <20240412135406.155947-2-thorsten.blum@toblux.com>
 <3E99B315-844D-4B5D-BD5B-CFC18EFE304D@toblux.com>
Date: Tue, 07 May 2024 14:22:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thorsten Blum" <thorsten.blum@toblux.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bug: Improve comment
Content-Type: text/plain

On Tue, May 7, 2024, at 12:17, Thorsten Blum wrote:
> On 12. Apr 2024, at 15:54, Thorsten Blum <thorsten.blum@toblux.com> wrote:
>> 
>> Add parentheses to WARN_ON_ONCE() for consistency.
>
> Hi Arnd,
>
> could you add this trivial patch to your tree?

Merged now, I missed this earlier.

   Arnd

