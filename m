Return-Path: <linux-arch+bounces-2386-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773B6855C37
	for <lists+linux-arch@lfdr.de>; Thu, 15 Feb 2024 09:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAC01C21B25
	for <lists+linux-arch@lfdr.de>; Thu, 15 Feb 2024 08:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E2513AFB;
	Thu, 15 Feb 2024 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI2mOhZe"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026F911184
	for <linux-arch@vger.kernel.org>; Thu, 15 Feb 2024 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985108; cv=none; b=miid6TbpW0ZPm+AwFY3vLaBWpzml7TFQwHH2RSDQqKSDakREbbW4FojV//a2XBwBUWaSteF0buZ81KvNPB3uzHcLOyV+GTQXEb3d84P64jO1y8tw2pTW33DTfier4D024Xf+AZzc4XyyQReotsK4oEfh8sytabWOBUlboInf7oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985108; c=relaxed/simple;
	bh=NEWD24GsuqxxNTq5YzGqWj/5Tc8Dg9+/4oyhQh0vAoc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=tdq1KNG90Jcbm4NEs2xYJpGnNwi8FJjx0SEGgsfiP3nLkeStVHvt09IjYssVFvU29IK+RC2tEoe9QLYS5X5Ar2MLq56xrEdeOpyBvJSsBpB3STk2+h5o59x4zHQRMDPmlEBi4SFkW1SesCjw3F6eVVvG9wQjOw+WEJboiPXmEBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI2mOhZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435BFC43390;
	Thu, 15 Feb 2024 08:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707985107;
	bh=NEWD24GsuqxxNTq5YzGqWj/5Tc8Dg9+/4oyhQh0vAoc=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=RI2mOhZerlcJeWdxcgS9GAF0WVcFz0gTdhizDRZrhvX7nbJ0dQmULNaS5IMxZ60vB
	 Ho0x0k6qUX3D2khqcpIUoijc/1NtJulkMAMThldsJz8dUmJWUfogSDYu0Y1cl67Tqs
	 7X7AWDGj2xVaFuCQTiF5+drthE+6VOuRi0EA+7+tOEgX5w4oFqTatq9MR8stbYWTT0
	 YYtzze+07Kuq+lcTk2tBRl8T6oPHuxMnEYr53fLML3ZJivwuPtTSUQ8YflXSBVReen
	 Qf3jkSEp6svCGEHxSK9k0amZcgDoKC65zD3xZQGsGhC1JEKataG+bIdVSKLx+fdvKk
	 +AdFi8ftPfenQ==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1E8601200043;
	Thu, 15 Feb 2024 03:18:26 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 15 Feb 2024 03:18:26 -0500
X-ME-Sender: <xms:0cjNZfYo_g1Ix0DrwBz4KuX7VjNNIZyEdOV6Xg3RnAP2TyhBT5pFYg>
    <xme:0cjNZeaQwqznnRtCmDDh24_BwM7Kf5pxIbgz4hgSQd21fJCsBfQwvJO2n6uwLAMd3
    2e0XmzLvthFrjGKiL0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvveeigfetudegveeiledvgfevuedvgfetgeefieeijeejffeggeehudeg
    tdevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudejtddv
    gedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusgdrug
    gv
X-ME-Proxy: <xmx:0cjNZR-ublyObQJz1iE8rnJF74bbYQ7RrcFM5O85-96YzrmfeMPsBg>
    <xmx:0cjNZVppB3c9IEdcIGGyixY2tNCgZafVkxRPMRL-3GbB6GaPOLkg-w>
    <xmx:0cjNZap7Cr7HWUYchY1gQBGq7Bamp5hrrltYjxZkvcN5MNtbzKJtuA>
    <xmx:0sjNZaIgKj11PS-xose-909MYx-2SKodFSPRK6cLQkXBEsMkT3Caf031sI0>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8DEBCB6008D; Thu, 15 Feb 2024 03:18:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aa657f01-7cb1-43f4-947e-173fc8a53f1f@app.fastmail.com>
In-Reply-To: <a406b535-dc55-4856-8ae9-5a063644a1af@linux.ibm.com>
References: <a406b535-dc55-4856-8ae9-5a063644a1af@linux.ibm.com>
Date: Thu, 15 Feb 2024 09:16:29 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Peter Bergner" <bergner@linux.ibm.com>, linux-api@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
 "Szabolcs Nagy" <szabolcs.nagy@arm.com>, "Nick Piggin" <npiggin@au1.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux vector, entries
Content-Type: text/plain

On Wed, Feb 14, 2024, at 23:34, Peter Bergner wrote:
> The powerpc toolchain keeps a copy of the HWCAP bit masks in our TCB for fast
> access by the __builtin_cpu_supports built-in function.  The TCB space for
> the HWCAP entries - which are created in pairs - is an ABI extension, so
> waiting to create the space for HWCAP3 and HWCAP4 until we need them is
> problematical.  Define AT_HWCAP3 and AT_HWCAP4 in the generic uapi header
> so they can be used in glibc to reserve space in the powerpc TCB for their
> future use.
>
> I scanned through the Linux and GLIBC source codes looking for unused AT_*
> values and 29 and 30 did not seem to be used, so they are what I went
> with.  This has received Acked-by's from both GLIBC and Linux kernel
> developers and no reservations or Nacks from anyone.
>
> Arnd, we seem to have consensus on the patch below.  Is this something
> you could take and apply to your tree? 
>

I don't mind taking it, but it may be better to use the
powerpc tree if that is where it's actually being used.

If Michael takes it, please add

Acked-by: Arnd Bergmann <arnd@arndb.de>

      Arnd

