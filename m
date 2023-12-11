Return-Path: <linux-arch+bounces-897-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EADA080D10B
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 17:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95CAD1F21081
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48124C627;
	Mon, 11 Dec 2023 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4HnagbOJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B93FFF;
	Mon, 11 Dec 2023 08:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=4HnagbOJonb+x6IstHctUf9ht4
	OgV9P3OzAjZHHA+wBtF3soPL+84Q+8Ow5Dy+Tg0bBJi3pKlWMRn6liq03gzvVmLmsFiCJI27eai8K
	fDXtdcjcHZd8wWhJL+qm6215qCWUBTk0SSEkFbHcTftQnohN5Hi6VkRi96prYI6ZEUUuB5AUk7Guc
	D9X+eZ+K8uOeZaoUNo8SiBLHKOnwDO3kAo3gmg8rt4tz3gjcpi7P4JxDrWh6dxAIw71FcJuR8VYxM
	fyHVNAJN8VaRlFrugZy7Zo3+h08hWIvvbKWHPS5UWSdMFd30eF60CpVfSXPKE8CB0PmMzSlO2Lvm+
	kTdvx7ZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCizm-005kHT-2F;
	Mon, 11 Dec 2023 16:19:02 +0000
Date: Mon, 11 Dec 2023 08:19:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 12/12] selftests/fpu: Allow building on other
 architectures
Message-ID: <ZXc2diNGXH8vaEZ8@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-13-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-13-samuel.holland@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

