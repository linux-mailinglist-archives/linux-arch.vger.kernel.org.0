Return-Path: <linux-arch+bounces-12607-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9FEAFF3B8
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 23:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420C01C83956
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 21:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD91235BE8;
	Wed,  9 Jul 2025 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LCZPeXzK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95913B797;
	Wed,  9 Jul 2025 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752095642; cv=none; b=S0l1j0jPsAwpAMlPJv7qA4x1F5XjEnHlhJb69zAZOIfxE4GK1zIFfJPd7trguS7AHBO6H1q859+oxP2x5N+myQAYKMpI5+9SmLReR8MlEZDs3TdhE60kCfhQgpmjchhIjS8kuLSFQLK7Hlz/jep4iIIES38IjNAkFeIlQrohUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752095642; c=relaxed/simple;
	bh=CYo/mZw03O+EDuqFAlXNxX6aL4BphLCE1nJ1rHmAPhI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HoC7yjgUCrrtc3Pa5vXjWXzYwbDVAVTi7TQYAQv4UNF5/rd2aE1YA5dQBRzEfUvytGWrWQHcJMp2GTuak6LaQawus4iC11jg4M/lnuVbHtxfrB5Fgwg+DPerYE6+oaDZ+4R4gbwaITk5N6nzvii5sbkzUPYZ30heqWvO0ayv3KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LCZPeXzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E12EC4CEEF;
	Wed,  9 Jul 2025 21:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752095641;
	bh=CYo/mZw03O+EDuqFAlXNxX6aL4BphLCE1nJ1rHmAPhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LCZPeXzKGK9jv8LeXI7ebkvP22Xdz4m4XGL81JBozlZA5utTRHR4ZiWKlWSSKGc/a
	 YDmELrt7d/4U6Px8e535iiRiC2PAtZFsoZkljkI9dGmvXkyIH5//FgXcujk2OHWzsO
	 F7/f/mnScw2LLWu57V5g6hpPNSQ5wg+6F9pN09nw=
Date: Wed, 9 Jul 2025 14:13:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph
 Lameter <cl@gentwo.org>, "H . Peter Anvin" <hpa@zytor.com>, Alexander
 Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Juergen Gross <jgross@suse.com>, Kevin Brodsky
 <kevin.brodsky@arm.com>, Muchun Song <muchun.song@linux.dev>, Oscar
 Salvador <osalvador@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jane Chu
 <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>, Mike Rapoport
 <rppt@kernel.org>, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [RFC V1 PATCH mm-hotfixes 2/3] x86/mm: define
 p*d_populate_kernel() and top-level page table sync
Message-Id: <20250709141359.dc03e32a2319d85a25faaf32@linux-foundation.org>
In-Reply-To: <20250709131657.5660-3-harry.yoo@oracle.com>
References: <20250709131657.5660-1-harry.yoo@oracle.com>
	<20250709131657.5660-3-harry.yoo@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 22:16:56 +0900 Harry Yoo <harry.yoo@oracle.com> wrote:

> Fixes: 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory savings for compound devmaps")
> Fixes: faf1c0008a33 ("x86/vmemmap: optimize for consecutive sections in partial populated PMDs")

Fortunately both of these appeared in 6.9-rc7, which minimizes the
problem with having more than one Fixes:.

But still, the Fixes: is a pointer telling -stable maintainers where in
the kernel history we want them to insert the patch(es).  Giving them
multiple insertions points is confusing!  Can we narrow this down
to a single Fixes:?

