Return-Path: <linux-arch+bounces-6822-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6272965065
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 21:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF911F248AD
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 19:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04F61BA288;
	Thu, 29 Aug 2024 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Uj62fJaO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="smnTD1qI"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6487D1B5813;
	Thu, 29 Aug 2024 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961446; cv=none; b=W7BibrBHHFGpJMHhbZ/oHO5qOuG/cNGbkbfSAA6Jyv6CvfySk93+Eo5UC7RvxcczlEXzWo5szRi48OEyo0B1lqyGgBw1BwMjFbgSJXM+Ba5DUS5R1yOGiisB6oSRXDSGqVGo1TioD7Li5NBhirScDftXPsKE/HjoYJPn3Aiy9qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961446; c=relaxed/simple;
	bh=w5h0FOioO/iwBrzuMZxmdnXFQ//IzHTfU2X2gorK1b0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NrU4gWsUqS+mgiCRldrKSaHWC6UaR7NfKUvua7RYBsTzRe1UPujgkFOQlEUUeQYFqfye18z+rjxmddhGd+e93BAj7BModr4OpzWKLPmuQZFBAX+aB4X8yKhbLzVPaTVVbzhwD0oD5d1UbOEAEhtB1ORvz8bCVvhYNSb/hyBziIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Uj62fJaO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=smnTD1qI; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6FC9C1383A46;
	Thu, 29 Aug 2024 15:57:23 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Thu, 29 Aug 2024 15:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724961443;
	 x=1725047843; bh=6e+N05Fhw7yeM+JJ3iUAtFs9O+udW7eiEJhW+TG7NNU=; b=
	Uj62fJaOkFjK7yY1wwRmwTzei2hA2EIOwznWBBPHdDNDn2uqLnmjwryRPKwYgYhb
	Og+8jwMDsfF4+xF2i/XnCNROU9Aehbj+C5wBPTd/CeK3/OxIzuULWWvf1PX0K4JV
	/EUkthXUWX1OQJ4Bu8K1s09EV5LZVrPyvDz1H+lY0xYmLOhzrHx83hovg6DUE/xz
	ynOUcWkAXPNFc6sEdaZSEoKoYBoeAZ9ozQIavb3kt28cubvPhTfVGlVx2+mIFj3G
	4atPenoBuKlC/FmUIpWKpXWlcWQ9sey+OK8eFFQkvl+ZdvgrA0JttAU6k1BtgVWC
	24CEPQW1Nd2rIxpD5reBfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724961443; x=
	1725047843; bh=6e+N05Fhw7yeM+JJ3iUAtFs9O+udW7eiEJhW+TG7NNU=; b=s
	mnTD1qIHE0QQTy63dO4iDSKHq6j/yzaMDAuyqZFKYAxq9WMjGxX421SOs3urIMgp
	JeVyBb+LBwVy89HDlBzT2P4fnOLYca0YgoBnfJyPFv0vjA3W05cTR/fIuu2HhiQo
	azFfuuVK9g1rwZezRMecw7+zzCxVisH2oJ5R+i8jMdcIF6qSUSp5BrzqbzUE1iql
	IWiH+4V2/OuZHov0Lsa1ezMRWyEKjn3dugJENChaY3J6bzx5kqoaI0LdD5WMLRm4
	GUVTJRqcczg+RfuklNq1fdC7To2wnXd6ySs2U9xBTMUZd3VWzDgzzstWVnhU2vEt
	axwpjq4x9uoNcW/KSsjQA==
X-ME-Sender: <xms:o9LQZps_sigBReXozr8vNHfPsXnB2gKzg0OoU8uWFlAnbW9ZMZSgBg>
    <xme:o9LQZidz5M2PgF_l6CpXpzK1wUH989tvgcCuk9TVrBIbrZg_ZzYB83xBAp-AVSz2o
    sqlbUxeETaTrxxwEBc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:o9LQZsxpDtuMz6AUISdH3kkNkpuIc3esJiYvfjrS630UdTYnMNqd8w>
    <xmx:o9LQZgPAI-3iAOyyDB5fAyROXe3OuHP9Su4eAh8EqNWCIc9N1BitaA>
    <xmx:o9LQZp83w-8IgKksnaRdNbBsvC0MhdGz3VKy6v_Ggmx-8qkEikkJyQ>
    <xmx:o9LQZgUlkiPm7mCgNvrDmeTvaYAa1rIFWE5A9amAA6-I2ivphNNDTg>
    <xmx:o9LQZrL5e68Eppbw4SGy-aGhXZF-CMj4O5gzJLEcagZ6YEWoJpVCPmKI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2E054222006F; Thu, 29 Aug 2024 15:57:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 29 Aug 2024 21:56:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <f209bf4d-1d14-404b-8bff-8d6d2854d704@app.fastmail.com>
In-Reply-To: <1bb58d8d-4a2a-4728-a8f3-9295145dbbb0@paulmck-laptop>
References: <3ca4590a-8256-42d1-89ca-f337ae6f755c@paulmck-laptop>
 <b3512703-bab3-4999-ac20-b1b874fcfcc3@app.fastmail.com>
 <289c7e10-06df-435b-a30d-c2a5bc4eea29@paulmck-laptop>
 <9242c5c2-2011-45bf-8679-3f918323788e@app.fastmail.com>
 <1bb58d8d-4a2a-4728-a8f3-9295145dbbb0@paulmck-laptop>
Subject: Re: 16-bit store instructions &c?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 29, 2024, at 15:37, Paul E. McKenney wrote:
> My plan is to submit a pull request for the remaining three 8-bit
> cmpxchg() emulation commits into the upcoming merge window.  In the
> meantime, I will create similar patches for 16-bit cmpxchg() and perhaps
> also both 8-bit and 16-bit xchg().  I will obviously CC both you and
> Russell on the full set.  And if there are hardware-incompatibility
> complaints, we can deal with them, whether by dropping the offending
> pieces of my patches or by whatever other adjustments make sense.
>
> Does that seem like a reasonable approach, or is there a better way?

There is one thing I'd really like to see happen here, and that is
changing the architectures so they only define the fixed-length
__arch_xchg{8,16,32,64} and __arch_cmpxchg{8,16,32,64} helpers,
ideally as inline functions to have type checking on the pointer.

If we make the xchg()/cmpxchg() functiuons handle all sizes
across architectures, that just ends up cementing the type
agnostic macros, so I feel it would be better to have
fixed-size helpers as the generic API so we can phase out the
use of the existing macros on smaller-than-u32 arguments.

The macro is still needed to allow dealing with both integer
and pointer objects, as well as a mix of 'int' and 'long'
arguments on 64-bit, but for normal fixed-size objects I
think we can best use the same method as the current
xchg64()/cmpxchg64().

    Arnd


