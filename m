Return-Path: <linux-arch+bounces-7353-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F33D697BB84
	for <lists+linux-arch@lfdr.de>; Wed, 18 Sep 2024 13:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01E61F22D7E
	for <lists+linux-arch@lfdr.de>; Wed, 18 Sep 2024 11:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804F617B401;
	Wed, 18 Sep 2024 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="Evnv6eIb"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5A817C9B8;
	Wed, 18 Sep 2024 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658441; cv=none; b=ub5BEqX6sTbDH6Notrpmglekvgx30XJ7y9RDzQKr4VRyTn0tDPmVqGuJuis3T3eYle5svn/QMRvWACm/WlasfpmNCMD+qCejJDPak/58+R3i8tjydNAPv8xkmfRzzXc99iiwN3l2TUuzLz2ncyMyYg4tDv48FP3bCTYfzbe8jlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658441; c=relaxed/simple;
	bh=KqLB8e9EUW+MpxLtVXJvY2jaJ164ff1tjKpFXCU/+r4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=la5kGDpxkcTttoGQfD9y2ZbN3CvU2I6YYGgcHlF6ewRA3usMXlxtWHiJei2E/r3tbt0bPtiO7cugfxfaV+mWyvRaKvT5Ckm9S5/am5f2OOydwFVEvlE5SmHLKS4nN1GGm8yC9Bb7P51dyW0LBVZTkrsd7bJQQNPTmutEg6eNnJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=Evnv6eIb; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1726657899;
	bh=KqLB8e9EUW+MpxLtVXJvY2jaJ164ff1tjKpFXCU/+r4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Evnv6eIbn3pBYG8rWAXPRpm7UYLtdwojpT2lTbcEjx1joY02r1d/ecH27eUCcs0FH
	 1KelXHQToPhtrgkfGZ8qA/alKTv61nexuuITNdRVLARUUla0k8alPPFpajexhWBfUx
	 GliRtT65tiskXtBoLLZ98a2tRWmbWPzmh1Iyuf60=
Received: by gentwo.org (Postfix, from userid 1003)
	id 6CBE3401CF; Wed, 18 Sep 2024 04:11:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 6BC79401C5;
	Wed, 18 Sep 2024 04:11:39 -0700 (PDT)
Date: Wed, 18 Sep 2024 04:11:39 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
In-Reply-To: <87o74m1oq7.ffs@tglx>
Message-ID: <420432ae-a738-97df-2d59-c36deadd70f4@gentwo.org>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org> <87o74m1oq7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Sep 2024, Thomas Gleixner wrote:

> We ....
>
> Please write changelogs using passive voice. 'We' means nothing here.

Done using active voice.

