Return-Path: <linux-arch+bounces-9946-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2285FA21561
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2025 01:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68673A4A69
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2025 00:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B8A10957;
	Wed, 29 Jan 2025 00:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T4h6CXYH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D07FD;
	Wed, 29 Jan 2025 00:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738109501; cv=none; b=rmsMAd2k1xDvDYonmoqcgeYrlfHwDfzlvQqO8BlqGYiUqcgXD/xqZANeqEIVE6TYO8L/rx5BoH1u2ZlDbq2fWuQFa/bXua4nvx65EzOq2ThsqDhc7vvMAyCMrZR8hkmhVUtTg3jOBhHPd3Uv8TweUhd2AGmcxl39NFCiINx1tqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738109501; c=relaxed/simple;
	bh=oDL9bu5A99PSXDQzASaWVbm7QZ7H2YnOppQ3GGIXNSc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b17Jn3UKO9QSSmtSAOdi2lgR+FKV1lavPD5zYr7QWie6R6zVSnhdtxWMiGZf4SBcdtd5AyKc33uGzIdfJDbSB8Kv75o1zAggmoab5Jr0AFbCl7hXTdbt225CCtQorBsIgoPq2gcMOo9Tmkqo3+eV23L745VDpMbB4d4fyrjgroA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T4h6CXYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82739C4CED3;
	Wed, 29 Jan 2025 00:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738109500;
	bh=oDL9bu5A99PSXDQzASaWVbm7QZ7H2YnOppQ3GGIXNSc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T4h6CXYHlUCtKc2p3wto5pCh3/b8fItepEGM7fmiS11/zZMl287R7zDRts/GeSoQ8
	 On7MVAvE5mIqAvtrVG36tfLSOde9QRu0+qWJbjnrPcCES5BotvSxWLbEdSLb4x+UyK
	 tcRgyCjLjxhCAhZAdeNSkJRrXNHi2VrxFH22fIvk=
Date: Tue, 28 Jan 2025 16:11:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
 david@redhat.com, khalid@kernel.org, jthoughton@google.com, corbet@lwn.net,
 dave.hansen@intel.com, kirill@shutemov.name, luto@kernel.org,
 brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
 catalin.marinas@arm.com, mingo@redhat.com, peterz@infradead.org,
 liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 tglx@linutronix.de, cgroups@vger.kernel.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
 rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
 pcc@google.com, neilb@suse.de, maz@kernel.org
Subject: Re: [PATCH 00/20] Add support for shared PTEs across processes
Message-Id: <20250128161138.066f6c27d0d941609ba1c1c9@linux-foundation.org>
In-Reply-To: <20250124235454.84587-1-anthony.yznaga@oracle.com>
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 15:54:34 -0800 Anthony Yznaga <anthony.yznaga@oracle.com> wrote:

> Some of the field deployments commonly see memory pages shared
> across 1000s of processes. On x86_64, each page requires a PTE that
> is 8 bytes long which is very small compared to the 4K page
> size.

Dumb question: why aren't these applications using huge pages?


