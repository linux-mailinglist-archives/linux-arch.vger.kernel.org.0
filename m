Return-Path: <linux-arch+bounces-892-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23DD80D09E
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 17:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43431C2126E
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58224C3D4;
	Mon, 11 Dec 2023 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LWVZJO7t"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FBC1700;
	Mon, 11 Dec 2023 08:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=LWVZJO7tpTs4Y8xpJT4RVM5j3i
	2CtgM9g7jg9IjFBbSO8tBora7qihSKKCs8MlTQbqDTbko/PqWkYmBXVbacMyT2djzR5uAtuUcBF/h
	fgaOURQzFvdD3hLZ04NmV2QDBJGF+0Nk+WAwUyxmr1sizsPCIoy3p9aG78DdT3JKg1IZrIL2j2Bol
	G8opT9PqK7pXsHqUQIpWBhvGYYdsDIxDdGKiL/ISVGMTb6JdqOE3MWWRCZsl3jLmqG9D6bKJKrBYE
	qLlAKmbkNTiLtP2ft5EKFFMk3BO1bdHo5c1YIi/5snlAZTHL5BIHOaUg8nVBXXvoyK/34WSnyV6xv
	6xz7BCBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCiq3-005fSN-1D;
	Mon, 11 Dec 2023 16:08:59 +0000
Date: Mon, 11 Dec 2023 08:08:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 08/12] x86: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Message-ID: <ZXc0GwtgeO3PL1K9@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-9-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-9-samuel.holland@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

