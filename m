Return-Path: <linux-arch+bounces-12056-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA702ABFB3D
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 18:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C538C6DA6
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FB01714AC;
	Wed, 21 May 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mazIODrw"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D4A22D9ED
	for <linux-arch@vger.kernel.org>; Wed, 21 May 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844944; cv=none; b=Nu/z0ff0Y66aDWpd0LL3kK0GQhTedvC8Z1Q4kdU+EjcCu9h5NHaprjN6FZsBjLj7YZV29pQIICNDYRVyizWLc41Y/imV4OxD13ngprdAt3ebwAN/sXynqXLLCduosgyw5Y5o3yLX1rrrs0wwY8uuImDMwUHOv8JwXyhyROLE4ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844944; c=relaxed/simple;
	bh=MovtPJ97xgjLnkj7ZaiIdZH7WgUBe302vbJgYyVUqcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p87P1YVd7Efn0A8GjVPLQNAKxrAHfvPyVFfv84qMw65MOq+ps4p/mCceWAKUlgUi2cr1okIIxVVtqIe67qh7jpIJnrLx/PYSjS9sv5zB33jej4VDgbpwuIXj8GfOwddhGu+Fe2Koifx5+sJ92lZA/hs/xTlPBTSifJ83F9VH6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mazIODrw; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 May 2025 09:28:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747844930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BuCnyimXJYTBiSiJApNKXD2ocLe2FBL7gUkaHIDT7BI=;
	b=mazIODrw+IOz7VwSGL+2Xl8x5lJ5AmQuwHZRrF1eExMLwPp9jhqdHZFXztMu+Nnlk9eD4X
	3bhKJLX2NJSJlmA2RjfRDW/xymvAUgG6G1YZh1NGbngOI2fNMMulOtBRxsBJRsiVnplqHs
	ToeKyCI7sWH9vGiR7eqyxtfpyXrP7vo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <djdcvn3flljlbl7pwyurpdplqxikxy6j2obj6cwcjd4znr6hwj@w3lzlvdibi2i>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
X-Migadu-Flow: FLOW_OUT

On Wed, May 21, 2025 at 05:21:19AM +0100, Lorenzo Stoakes wrote:
> On Tue, May 20, 2025 at 03:02:09PM -0700, Shakeel Butt wrote:
> 
[...]
> 
> So, something Liam mentioned off-list was the beautifully named
> 'mmadvise()'. Idea being that we have a system call _explicitly for_
> mm-wide modifications.
> 
> With Barry's series doing a prctl() for something similar, and a whole host
> of mm->flags existing for modifying behaviour, it would seem a natural fit.
> 
> I could do a respin that does something like this instead.
> 

Please let's first get consensus on this before starting the work.

Usama, David, Johannes and others, WDYT?


