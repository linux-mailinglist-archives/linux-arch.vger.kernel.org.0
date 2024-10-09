Return-Path: <linux-arch+bounces-7915-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2473C996E3B
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 16:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405ED1C21A3D
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B921212EBEA;
	Wed,  9 Oct 2024 14:38:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DF66F307;
	Wed,  9 Oct 2024 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484686; cv=none; b=Yf1P71DeqaQSESjUqt0JY8Pf04E2i435NBp/kpJMZTSEEFRBRt7sPquae4SW1ZUX0LqWH6rG55CdcIxHH2qxXy5FFsm02keHXCyaBJTC1s4O2ep1yc1RVqIqf85yLogzTWcVlGMTjepHR0ZXjniE47ONUKpHNpEqmoLLaMGXlk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484686; c=relaxed/simple;
	bh=ur2p4B0Kvh0c7htyE18mhoCQu0JesSX5db+QwZipDxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpL2egbe0KAy75MUCgyC4glBw5zVJoli1zSemD03N4lVQ5iS2CliJr1HHv62YWrb4A1Upo4xFZZhR8LBae1BHsIx0erJ+d+KijZEM7uMdUw6AuI72bDcCY6yoEIhlast+HpmLuLhdS8utxlbPcML08yfxi2Zwbe+NTyMys/KNAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XNwTw0tTFz9sPd;
	Wed,  9 Oct 2024 16:37:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VPYRDQSqjFFY; Wed,  9 Oct 2024 16:37:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XNwTw03Cdz9rvV;
	Wed,  9 Oct 2024 16:37:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E33838B77C;
	Wed,  9 Oct 2024 16:37:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 5YCo0KwYOorb; Wed,  9 Oct 2024 16:37:55 +0200 (CEST)
Received: from [192.168.233.133] (unknown [192.168.233.133])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 33B378B770;
	Wed,  9 Oct 2024 16:37:54 +0200 (CEST)
Message-ID: <f9693d48-1018-460f-a1ff-5990bcf92b66@csgroup.eu>
Date: Wed, 9 Oct 2024 16:37:53 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] asm-generic: provide generic page_to_phys and
 phys_to_page implementations
To: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org
References: <20241009114334.558004-1-hch@lst.de>
 <20241009114334.558004-2-hch@lst.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241009114334.558004-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/10/2024 à 13:43, Christoph Hellwig a écrit :
> page_to_phys is duplicated by all architectures, and from some strange
> reason placed in <asm/io.h> where it doesn't fit at all.
> 
> phys_to_page is only provided by a few architectures despite having a lot
> of open coded users.
> 
> Provide generic versions in <asm-generic/memory_model.h> to make these
> helpers more easily usable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/alpha/include/asm/io.h         |  1 -
>   arch/arc/include/asm/io.h           |  3 ---
>   arch/arm/include/asm/memory.h       |  6 ------
>   arch/arm64/include/asm/memory.h     |  6 ------
>   arch/csky/include/asm/page.h        |  3 ---
>   arch/hexagon/include/asm/page.h     |  6 ------
>   arch/loongarch/include/asm/page.h   |  3 ---
>   arch/m68k/include/asm/virtconvert.h |  3 ---
>   arch/microblaze/include/asm/page.h  |  1 -
>   arch/mips/include/asm/io.h          |  5 -----
>   arch/nios2/include/asm/io.h         |  3 ---
>   arch/openrisc/include/asm/page.h    |  2 --
>   arch/parisc/include/asm/page.h      |  1 -
>   arch/powerpc/include/asm/io.h       | 12 ------------

As far as I understand, this patch silently drops part of commit 
6bf752daca07 ("powerpc: implement CONFIG_DEBUG_VIRTUAL").

Can you please clarify ?

Christophe

