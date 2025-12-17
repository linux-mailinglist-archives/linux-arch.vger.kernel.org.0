Return-Path: <linux-arch+bounces-15487-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A705ECC95A2
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 20:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBF22303919A
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 19:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7460F25B305;
	Wed, 17 Dec 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b="C83ZiJlL"
X-Original-To: linux-arch@vger.kernel.org
Received: from pmxout1.rz.tu-bs.de (pmxout1.rz.tu-bs.de [134.169.4.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160DE257852
	for <linux-arch@vger.kernel.org>; Wed, 17 Dec 2025 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.169.4.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765998336; cv=none; b=J/Hz/c3RqAsMb7LAD96KLEzYWEfqAVUfp8aawDH6O/owtrb8VFvcjjK5OjJqnK45LiwnpxkG5mpYkr+fJ9kYrapn3q+RLrkYGTzhzvuungV/WWY+EFuP+XugzSpD4/6xSdDUkreWaGo3W98eDiTl42VLTmlnZj/kZaL2obYQwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765998336; c=relaxed/simple;
	bh=+O5opAMvMYw9gbQqcIzmESWpm5bE6wHXpQKRfAChMl4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=JpprPNqcaHEuyOUG8BJKXZzbHMRUavQcPfCH6fPOsu3d/QwmOCGMg/GDZOxhJHeToKlziE3cMt5eiDD0vBdAcvtZgofB29ovADqSBQLarxX2C69hJb63MkdinRyJFAcJk0lu8b9vCWlp8JgsdTsmIhalAzmkk8UqOWkU2gGNIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de; spf=pass smtp.mailfrom=tu-braunschweig.de; dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b=C83ZiJlL; arc=none smtp.client-ip=134.169.4.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-braunschweig.de
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoibGludXgtYXJjaEB2Z2VyLmtlcm5lbC5vcmcifQ==
DKIM-Signature: v=1; a=rsa-sha256; d=tu-bs.de; s=exchange_neu; c=relaxed/relaxed;
	bh=d0brvDdV879BtZDkbJRmN93ySaqMZ4lI+qtZFdHyR7E=;
	h=from:from:reply-to:subject:subject:date:date:to:to:cc:cc:resent-date:
		resent-from:resent-to:resent-cc:in-reply-to:in-reply-to:references:
		references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
		list-owner:list-archive; t=1765998324;
	b=C83ZiJlLIcxG5s1DllG50ijOIFAlu3w3kfKe3ONDZAkn3rVCFLodZK34iLmPVRH/msXbTiPEl
	mmC/jJFEwLwLTLrurPiZb71+ZSx1aTW2+ZC7ihZEcAu2kWtir68PFeoOMJkBOjnHh1MlFLvhKNz
	AZocgkzPSApjA419uGPPrFJUsUtG3exLS9wKIw9fWMI0Jd+iRrN+gwKY+4d6fcetF5J+E/fZEHF
	SjJcCdTddyiL/qK/Wo/xYsAz6kN20Hg57gkq904WLHbyQbTVxntJQe+Txo6JMYAiV/yIksmEx7g
	fLKrtAx7h6rZR066BZUi+L2FH5hW9Ysr8ksannbq7vog==;
Received: from pegasus01.ad.tu-bs.de (134.169.4.141)
  by kumo1.rz.tu-bs.de (KumoMTA 134.169.4.163) 
  with ESMTPS (TLSv1_2:TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384)  id 57ca229edb7b11f0a3247edee6c2bcb2 for <linux-arch@vger.kernel.org>;
  Wed, 17 Dec 2025 19:05:24 +0000
Received: from Pegasus02.ad.tu-bs.de (2001:638:602:f012::3) by
 Pegasus01.ad.tu-bs.de (2001:638:602:f012::2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 17 Dec 2025 20:05:24 +0100
Received: from [192.168.178.23] (134.169.9.110) by Pegasus02.ad.tu-bs.de
 (2001:638:602:f012::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 17 Dec
 2025 20:05:23 +0100
Message-ID: <0f7f3317-7a96-44f2-a3e7-a49f75bcd6aa@tu-bs.de>
Date: Wed, 17 Dec 2025 20:05:23 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
From: Thomas Haas <t.haas@tu-bs.de>
To: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri
	<parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin
	<npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave
	<j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E.
 McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, "Daniel
 Lustig" <dlustig@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<lkmm@lists.linux.dev>
CC: <hernan.poncedeleon@huaweicloud.com>, <jonas.oberhauser@huaweicloud.com>,
	"r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
Content-Language: en-US
In-Reply-To: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Pegasus08.ad.tu-bs.de (2001:638:602:f012::9) To
 Pegasus02.ad.tu-bs.de (2001:638:602:f012::3)

On 12.06.25 16:55, Thomas Haas wrote:
> We have been taking a look if mixed-size accesses (MSA) can affect the 
> correctness of qspinlock.
> We are focusing on aarch64 which is the only memory model with MSA 
> support [1].
> For this we extended the dartagnan [2] tool to support MSA and now it 
> reports liveness, synchronization, and mutex issues.

--- cut off ---

ARM has recently fixed the issue on their side by strengthening the 
memory model (see 
https://github.com/herd/herdtools7/commit/2b7921a44a61766e23a1234767d28af696b436a0)

With the updated ARM-MSA model, Dartagnan does no longer find violations 
in qspinlock. No patches needed :)

With best regards,
Thomas




