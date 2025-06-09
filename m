Return-Path: <linux-arch+bounces-12289-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D2FAD1C51
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 13:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA33167B94
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 11:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360D2255240;
	Mon,  9 Jun 2025 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fZh6DKH8"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF12512C8;
	Mon,  9 Jun 2025 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749467594; cv=none; b=stsa/e8VxQaP5v4SQSuSXUE9IZiBGIEAjtVyWG1mC42WTfJ2t9Z9cd6wQC0fqAynagx1MiHi5sDNwihos+N8IfwKo/4ehvEDeZV0Y+TyhPeJEzhc5m+slkSZspg6QczM6I7Q6UNWrwbngGCw6vHslisSzntTCLqVBn5MuHTbmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749467594; c=relaxed/simple;
	bh=fOlUQzc0rK5y3u+cQxNWsjug+fSjpRWjaVvkbAGN5l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtJG9LW+Y3Q3U2J/NsoljvmRrIOYz02ozs83SD4Pp8j/RCTXWfE0RylfBBPBfwI6B+QI8cdbHc3hT4Qj6ZOeShlZSdHXPed0jLlwzmx97+T0PJa9VBGAyfXZbxoidtUOVH2p7MK+lLDtnJzXJXPnQLVQKbK5FbyjySOk8vLdmVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fZh6DKH8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fOlUQzc0rK5y3u+cQxNWsjug+fSjpRWjaVvkbAGN5l8=; b=fZh6DKH8L0Xl5QNNfr6W1SavG/
	QyrVNZG47+gdqZ5hLKnqM3iHx4txTxaS9BWF0TVwWCKs8+DRFVaEHKn0s302556LIlRpRrEcOrZ+5
	n+t61EvkAkSkhJGiKZwSLJbX0xgC3tHfLrReAMgzeBZIkGs0knN13gooRrBqCLkKgC4FwBfx0we+0
	N0bad5jT40yjSby5ASCvOxI8yVrB7LsDReq/HN6SMbnNlOwcXXCcSsSFYxw6zNnjCeKx2tPy9vTmR
	e4Q4pMfyRTK7ViWODOH2mMXmjC1JrA+F77bndQAImAbqlOhqNxSEZDyX0lAlulfybhoATcUCn1I59
	rVsYrVyQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOaRA-00000001c3C-43zH;
	Mon, 09 Jun 2025 11:13:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5FEE530BBB4; Mon,  9 Jun 2025 13:13:07 +0200 (CEST)
Date: Mon, 9 Jun 2025 13:13:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 00/15] Implement CONFIG_DEBUG_BUGVERBOSE_DETAILED=y, to
 improve WARN_ON_ONCE() output by adding the condition string
Message-ID: <20250609111307.GA95151@noisy.programming.kicks-ass.net>
References: <20250515124644.2958810-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515124644.2958810-1-mingo@kernel.org>



Ingo, have you seen my recent WARN hackery? I'm thinking we can do tihs
on top of those much simpler.

