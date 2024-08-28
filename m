Return-Path: <linux-arch+bounces-6715-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C06F396293D
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 15:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3ABB1C213EE
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 13:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8761F16CD06;
	Wed, 28 Aug 2024 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VthyfXne";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="em5bzErH"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F01EB3D;
	Wed, 28 Aug 2024 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852945; cv=none; b=LWCFfEEGZb19+aiNWKFQCyTnmbkHn4tuHWaGqJgVQsZwSxx6UiQs1mZvrspQ5m26v06x5A08P/cuGfQTy3xbhxlSJRQSV08/FU2Jj8wIu6xXYk4wXzfcUGJecBp5kG2gZZjcs/EFbXzy+2tivVQZYSCEy+2rCmXlLRaYPyDg/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852945; c=relaxed/simple;
	bh=OYorvbavpIzB4tCMgAp76XG3IeqGaSzUi1L2iqOdkwg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MqUWHqh5aHdIBL/VPNKtuLNS1uDYv/93+2q5snIEkO5ml6Z9EF1QT3DtETFGUlJgasvkjp7OmW+tuuCrWgTisiBeP70vFCmzE+u64rIJHdNE7/QkimvM4epNO8ALdcTOoNFuG8lJk5TehK0h01iti4YukGts0+5tLEcNOA+wCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VthyfXne; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=em5bzErH; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6BEE1138FF21;
	Wed, 28 Aug 2024 09:49:02 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Wed, 28 Aug 2024 09:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724852942;
	 x=1724939342; bh=spkJIQn60uBLOli5zEVF98cUm3cSDPA78s7enFv/a5E=; b=
	VthyfXneUZjp4Jut7qKbS8VOKRMzNfCK4LOwOvE4JAJi+L8OaEbk2gvieiSOwMkp
	WS+Dhbvl4nS8wRCEGLZr1mr26iNNtK9gODEu69OjsV22HAL4IXcFPUFhKYGzief9
	+wUPUCTYUUiQW6Yu8wNC2xly95oVUVC81yXOyDRtKDbeM2gn//vI4nzDNu1x0HS1
	rS3WszDryZ6r3E8ykIWq5p4ATDEMzpEoTaue41CdGNYIlMgPL9CfR6YaFw53BxZf
	EQOpeoONTC8s/h7kzbm+BHleBi6+iBGQXB+BpTsbDhb9umLZKnHWI7WNeisIh7Hr
	+ZI1zaIMSCpUhH+pt3sscA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724852942; x=
	1724939342; bh=spkJIQn60uBLOli5zEVF98cUm3cSDPA78s7enFv/a5E=; b=e
	m5bzErHTBiONcITuhN9bZFXO/SA8p47sWbapwWsUeyoBWlIXz9BWFz2K+gGXwLTU
	i/qqxxBbkZG4wFowwtm3SyT3EJF5y9AAK1abUx/G0YpOkYrqZbfTFvUrZKNdCz0n
	yUWWpt/cD8tkWQ6ko0+3YeFiukoVUKw6lDxec+EOdFBkHBueN59zX/EcfOLMbujp
	CiegSmGnrog1XyheBRZK5IZt3bFC49umAufBmD2KZgShU76EWx/PL4MKMl0wYa1i
	Qm4jlZwP+iowwWeRzJhpzzKO8y0maNeQUzKDXpywY2zbh8vJTxMa0oHQhztlX+EO
	CuQOdMVl25bVPByq7tHNg==
X-ME-Sender: <xms:zirPZu7GVn63jThrCfqjeNjyvbRN3BWTpdk4zmShMUg_4jR-0c_fuQ>
    <xme:zirPZn6jCtHI5xrGy6J3j79Qyqxwj5lj_8Q9PnPIWW_fhCoDAf-HZ79DsIhWkVM8b
    dCnrfSYi1BOSzoya0U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:zirPZtco84MM-73O1enCE0iJxW2psQ4bcWzgzqbdqWSWXxbfyNZG_g>
    <xmx:zirPZrL5UALh175XxtZri7NU_QNjX2Ox5niInwr8BvGgGs2FNQ6iIw>
    <xmx:zirPZiIBLIUj66USMnRjltFybb9o6d-JrWHJy4WlS0Hvye94TX779w>
    <xmx:zirPZsyj_0RmNXri9zDg0EMDByDEfkVot7EGyP3TbBqMCJwkCKvQpA>
    <xmx:zirPZpVQFYRAAGBR_9TtfLzsy7IKVV0wv49f1jS0QgsPj5HzlH5e1Tyl>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3A358222006F; Wed, 28 Aug 2024 09:49:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Aug 2024 13:48:41 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <b3512703-bab3-4999-ac20-b1b874fcfcc3@app.fastmail.com>
In-Reply-To: <3ca4590a-8256-42d1-89ca-f337ae6f755c@paulmck-laptop>
References: <3ca4590a-8256-42d1-89ca-f337ae6f755c@paulmck-laptop>
Subject: Re: 16-bit store instructions &c?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 28, 2024, at 13:11, Paul E. McKenney wrote:
> Hello, Arnd,
>
> You know how it goes, give them an inch...
>
> I did get a request for 16-bit xchg(), but last I checked, Linux still
> supports some systems that do not have 16-bit store instructions.
>
> Could you please let me know whether this is still the case?

Hi Paul,

The only one I'm aware of that can't do it easily
is a configuration on 32-bit ARM that enables both 
CONFIG_CPU_V6 and CONFIG_SMP, but I already wrote
a patch that forbids that configuration for other
reasons. I just need to send that patch.

There is a related problem with ARM RiscPC, which
uses a kernel built with -march=armv3, and that
disallows 16-bit load/store instructions entirely,
similar to how alpha ev5 and earlier lacked both
byte and word access.

Everything else that I see has native load/store
on 16-bit words and either has 16-bit atomics or
can emulate them using the 32-bit ones.

However, the one thing that people usually
want 16-bit xchg() for is qspinlock, and that
one not only depends on it being atomic but also
on strict forward-progress guarantees, which
I think the emulated version can't provide
in general.

This does not prevent architectures from doing
it anyway.

      Arnd

