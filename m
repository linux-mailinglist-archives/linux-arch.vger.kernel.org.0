Return-Path: <linux-arch+bounces-14569-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D61CC43011
	for <lists+linux-arch@lfdr.de>; Sat, 08 Nov 2025 17:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B892A3ADC9C
	for <lists+linux-arch@lfdr.de>; Sat,  8 Nov 2025 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD211EB5C2;
	Sat,  8 Nov 2025 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gxvyVDo1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3E1A262D;
	Sat,  8 Nov 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762620446; cv=none; b=dJ/8NbAln96p1ky9avyHr1eQVy+8kS0xXbVPmOlyzbxngIti6ZK/6nUy8jZXt8zoOpGK/OGiFL5VU0/O85H8v/bZJEBWVUNQ533hX23hXJzw+AXVqOJTo62jOiWsmT7xQk99HgltBUKT8XoMlKV5RHvLMsSp99RE7fJYaKzsuwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762620446; c=relaxed/simple;
	bh=U9xaDAQiKEtdqRiUxXf+jkJqFleNQgrXm3B00EJk9jY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=adWQtUHJ4+I0uQJf51w30wOP/4qrVmaGR5uwOoQT33c+T6it6y34kTdXGeqd7kQhmy74FNn03ZaI5d6HdhigkwUBP3ITt2RumhY/vfHk7EtBs7RVtrYV+NUJ7n/yFSHLvpKRWpJ3OtmWHuFphFBBUwJ1hVEgHxMqGXUFMJAW1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gxvyVDo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA43C4CEFB;
	Sat,  8 Nov 2025 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762620445;
	bh=U9xaDAQiKEtdqRiUxXf+jkJqFleNQgrXm3B00EJk9jY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gxvyVDo1dmbhZXPx7hxq+/HrVPkk7Kc5qQrB7x5mYVjMdlCaBOhfDZX1m+3xeKOui
	 VzOyGeRM63eKiCjGHPv1/m5t7RFtp8kmoSUAUcH7s7WqHPDaUhswdYh84gc/3XbLXW
	 IOva6olKK51Jq+1xZ8A5E/zabqEax8ie1v879nQk=
Date: Sat, 8 Nov 2025 08:47:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Huacai Chen
 <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, Kevin Brodsky
 <kevin.brodsky@arm.com>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH Resend] mm: Refine __{pgd,p4d,pud,pmd,pte}_alloc_one_*()
 about HIGHMEM
Message-Id: <20251108084724.3e389b6597294900347b0476@linux-foundation.org>
In-Reply-To: <CAAhV-H5C_Af72a5QcJs25qUMsJqO26=8oNvvLrJ7z+xHZh8oKQ@mail.gmail.com>
References: <20251107095922.3106390-1-chenhuacai@loongson.cn>
	<aQ4lU02gPNCO9eXB@fedora>
	<CAAhV-H5C_Af72a5QcJs25qUMsJqO26=8oNvvLrJ7z+xHZh8oKQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 8 Nov 2025 16:34:20 +0800 Huacai Chen <chenhuacai@kernel.org> wrote:

> Hi, Vishal,
> 
> On Sat, Nov 8, 2025 at 12:59 AM Vishal Moola (Oracle)
> <vishal.moola@gmail.com> wrote:
> >
> > On Fri, Nov 07, 2025 at 05:59:22PM +0800, Huacai Chen wrote:
> > > __{pgd,p4d,pud,pmd,pte}_alloc_one_*() always allocate pages with GFP
> > > flag GFP_PGTABLE_KERNEL/GFP_PGTABLE_USER. These two macros are defined
> > > as follows:
> > >
> > >  #define GFP_PGTABLE_KERNEL   (GFP_KERNEL | __GFP_ZERO)
> > >  #define GFP_PGTABLE_USER     (GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
> > >
> > > There is no __GFP_HIGHMEM in them, so we needn't to clear __GFP_HIGHMEM
> > > explicitly.
> > >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> >
> > I'm not really sure what "Refine ... about HIGHMEM" is supposed to mean.
> > Might it be clearer to title this something like "Remove unnecessary
> > highmem in ..."?
> Yes, that is better, but Andrew has picked this patch, should I resend
> a new version?

Please just send along a v2 in the usual fashion.

