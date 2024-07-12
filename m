Return-Path: <linux-arch+bounces-5381-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7B292F862
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 11:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A7ECB23120
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2D142629;
	Fri, 12 Jul 2024 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BryiJl3/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mKW/aPEL"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEAB17BB6;
	Fri, 12 Jul 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777924; cv=none; b=XXeuJJLYFQRlHVAFMuqnV55R4JyMGW+vUz36b9hVlqqywayXjvkgIc/yXSmPBIExhIDRMVZ17BAgt12Wa+TgAGZ6wmHVb/Ki/SOIDGzlbJ/++1vY6pUgxWD2kIVl60HLotafcZ6EsHxlYae4EakbAHDtZS9DWM1tIaTidWsM7Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777924; c=relaxed/simple;
	bh=qnwmKA1E77dU3/Siq976FhjiJYE//apcHV6ykvuw28g=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=EoySB0l+IaL8vJaD+HAxtXCBi6FuRqVA/O6IU0WkNBlaYPBCMc7owXWt+nzoDJqKO6nqjits8Eh6xwE7Fxz6LmCKkfZ1QxhUddVhk2/Rn6zZvIrhMDmimIYKtKlOqlYNYZemkvhZriksyYj+cbqGbLmON0ybtmzEOGtYYZgDUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BryiJl3/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mKW/aPEL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8B8671144813;
	Fri, 12 Jul 2024 05:52:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 12 Jul 2024 05:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720777921;
	 x=1720864321; bh=1i/vtDPCq+ba017V3YOHCPsm2lCK+3guf6JFMXq0RyM=; b=
	BryiJl3/LeVnnYFdHpoPCySMaI2nQ0N9aTak6myPMZ/SpBJI79xI19jV+NWlOZ/z
	VtKZ/uE62ZoxIyUmFMlG3pMDW1DZMsBQsetdpvTc2SULUjJOb5vtjt0Zrv1EY9+J
	pE7nQFXZDCa/NbNYCRWYE6kp0635Xi9kKh111aVivrEWx6jqeaSmkJhLN3UmD90L
	meb2VdT5oWq3H+lVxTc6R7EIJJjPpIxzPXbxCvhd6TPkZI/boR9OoDqd0Xhw0R9Z
	Bly/zCXJca3ia9fngzeT1VAUN0vxipsampUrtWpSUfrgyRbJ0gPAS/sRqOrga3Xg
	m6W+pKalUpsbQRW70GYJ+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720777921; x=
	1720864321; bh=1i/vtDPCq+ba017V3YOHCPsm2lCK+3guf6JFMXq0RyM=; b=m
	KW/aPELPox1MQtH5P/ZEPY7vSavQVzUfjDwjXyQHh4HWwE94syilyoFuOAhsbK5r
	eCBX35owLoxxbcPMVI03LTZfLKepw2THRDLthNe4C/avTn48Cek5P234wQ44yT81
	qPpCkAsAjEzn91m5RkSzEHT1tsbskEn18u50+u5YgRsYoID6/4hC/4plO9f49NxV
	khiFwUEBjy5/Ib9l6OJFPMu24dydw+dLCctmBCLJL4z7VkSjmAyDGtruvtu8pU18
	0Zc/CXmDSqC90lXGAboG86keD2on/th6I8ZZJ/XKlSf1Fru91j7L/cLV6YA+Zvu5
	FiOqsCkp3vxTlmrK1yHgQ==
X-ME-Sender: <xms:wPyQZj0y9QPTem1RXtyhRyIa0I8B1Sxt1CjvG-wKc9md4F1-IaZuDA>
    <xme:wPyQZiFOu3g8WwmwqQ4h4apvxKXIOmOxbnm1IAxwwxQHYwTWJS7zNP4wy568mIjPf
    nNZkFFtKk-g381X2no>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnuges
    rghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpeegfeejhedvledvffeijeeijeeivd
    dvhfeliedvleevheejleetgedukedtgfejveenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:wPyQZj5Cvkvn-18UIBtVc5StNpUruuckhhcwQYHvtRfloaTFs0XfnQ>
    <xmx:wPyQZo1UkUm-DbrKid-G4csibAFm03UIie2r3gyHuQy6cvarAGCjXg>
    <xmx:wPyQZmFyF1mINj0dNhWl9mjHq-7VtihI1t1ycPvHRmeGzRwA6Smtnw>
    <xmx:wPyQZp91ERAWvRpw3s6lmOHg1ELMmZX8k-U00HQIedceW6XnV25OzA>
    <xmx:wfyQZrQK4I9a2pd-C2GeXNJl4A98NLd_5hbUPwyIF0zdcmt7SDM3jriG>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 60055B6008D; Fri, 12 Jul 2024 05:52:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7351db74-fb04-4d0f-93ae-d3a3a3a310ff@app.fastmail.com>
In-Reply-To: <20240712093524.905556-2-u.kleine-koenig@baylibre.com>
References: <20240712093524.905556-2-u.kleine-koenig@baylibre.com>
Date: Fri, 12 Jul 2024 11:51:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UAPI/ioctl: Improve parameter name of ioctl request definition
 helpers
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024, at 11:35, Uwe Kleine-K=C3=B6nig wrote:
> The third parameter to _IOR et al is a type name, not a size. So the
> parameter being named "size" is irritating. Rename it to "argtype"
> instead to reduce confusion.
>
> There is a very minor chance that this breaks stuff. It only hurts
> however if there is a variable (or macro) in userspace that is called
> "argtype" *and* it's used in the parameters of _IOR and friends. IMHO
> this is negligible because usually definitions making use of these
> macros are provided by kernel headers (i.e. us) or if they are
> replicated in userspace code, they are replicated and so supposed to
> match the kernel definitions (e.g. to make them usable by programs
> without the need to update the kernel headers used to compile the
> program).
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>
> if there are doubts about using "argtype": Would "_argtype" be better?

The patch looks good to me, and I think using 'argtype'
is fine. I would apply it directly, but not with the current
timing just ahead of the merge window.

If there are no other comments, how about I take this after -rc1?
You may have to remind me about it.

      Arnd

