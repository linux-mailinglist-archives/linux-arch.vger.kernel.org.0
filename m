Return-Path: <linux-arch+bounces-8098-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140B899D584
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 19:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD91F285066
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 17:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263201B85E4;
	Mon, 14 Oct 2024 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="UDeAXkOh"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1371BDABD;
	Mon, 14 Oct 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926448; cv=none; b=p6OaTnB9rbXFE452f3vYm+rkj1xIgVtwMGonUqxvM/knTUcdynHZvdpKPa7i048FfP7U9/clvt0/5C3rKlIgLEGIoRo41Om0A2JsqXOxHCMXn2luEJehBYFWamOvGE3qnDx52nuUD4RrYSGvlwNgtwwtlZB2/93QOAP1BSVl/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926448; c=relaxed/simple;
	bh=x8pf8dv6TsP8JXdYfzHDLKge5Sr1VNwRTlf5smWntyw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sOt6dWUva/NSjSr+1R522I73w2cXqEdXXVp6ognKsp0r7t7ZzQ8f6mO8YgyxoLx7WASNp1Ryp9z0blG3Ji57JvxVaSo850X1AwCy1aDnXazOOCnYZ9N5ltntTdYbzqcro0G9wuPJE5kjtLhExmH1rySC1detiI7Aem6MqhNLI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=UDeAXkOh; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1728924621;
	bh=x8pf8dv6TsP8JXdYfzHDLKge5Sr1VNwRTlf5smWntyw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=UDeAXkOhC34P/2l1RSU7AY+bCJpczEZhKjdHGbeEmaF/xWT8iZpAPJIciPsJ+Iabi
	 Zf3bTpAO7c/Md9XExJpUfQLL2+CD4MuwJ6SWAToxHIbFFYT2MbTaRt5FkNkyX6FfMD
	 RONlruABvmO0uB9Gq9q5ARnHkbQm4I/2gdZje5xc=
Received: by gentwo.org (Postfix, from userid 1003)
	id 2DFA44040C; Mon, 14 Oct 2024 09:50:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 2BD01401C9;
	Mon, 14 Oct 2024 09:50:21 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:50:21 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ryan Roberts <ryan.roberts@arm.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Anshuman Khandual <anshuman.khandual@arm.com>, 
    Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
    Catalin Marinas <catalin.marinas@arm.com>, 
    David Hildenbrand <david@redhat.com>, Dennis Zhou <dennis@kernel.org>, 
    Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>, 
    Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>, 
    Miroslav Benes <mbenes@suse.cz>, Tejun Heo <tj@kernel.org>, 
    Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 02/57] vmlinux: Align to PAGE_SIZE_MAX
In-Reply-To: <20241014105912.3207374-2-ryan.roberts@arm.com>
Message-ID: <0e7c6bd0-b4a0-4afe-22ff-73239bd86943@gentwo.org>
References: <20241014105514.3206191-1-ryan.roberts@arm.com> <20241014105912.3207374-1-ryan.roberts@arm.com> <20241014105912.3207374-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 14 Oct 2024, Ryan Roberts wrote:

> Increase alignment of structures requiring at least PAGE_SIZE alignment
> to PAGE_SIZE_MAX. For compile-time PAGE_SIZE, PAGE_SIZE_MAX == PAGE_SIZE
> so there is no change. For boot-time PAGE_SIZE, PAGE_SIZE_MAX is the
> largest selectable page size.

Can you verify that this works with the arch specific portions? This may
also allow to to reduce some of the arch dependent stuff.

