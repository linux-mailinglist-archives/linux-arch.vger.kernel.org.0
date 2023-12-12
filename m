Return-Path: <linux-arch+bounces-909-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE27C80E4A8
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 08:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847721F2264C
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 07:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C681642B;
	Tue, 12 Dec 2023 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="loj03fvm"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5350DC;
	Mon, 11 Dec 2023 23:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3ses/ZsQ18kkMwgX82j0GHRHgEu7yezobRPEQDwOeVE=; b=loj03fvm+MJwW7UkZI87OSv2dM
	qeINzFTWACJoUVBnZlcSrmQkrWLr5xuEsDdRgvb5xBuN1aE/bWKNEgWHFUlBi/ZV9SF22qyvnJGUA
	DZ68pilvL8lEA0iIGTlXV2zGf7lHqaMbEX21rfTXZE6tuqmlioNpEuuuLEimLtiwvnN/Y7QaN0miK
	8Pw/X9MRFAr9i/CbFXHP2hssmAw31NucyJ04pGVjNFulPJR0JNcg2RsF/iul5D+xi4/72npQbSeXG
	AMPg9usdCOgER055N5knKYZHyWtjFPb5xvlUOXsPtI+/8n7GRnUxeWFCsRjRL0cG2Zs0GDs92YoTC
	1eySzcnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCwv4-00AuEj-0x;
	Tue, 12 Dec 2023 07:11:06 +0000
Date: Mon, 11 Dec 2023 23:11:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 05/12] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Message-ID: <ZXgHisDUsJMw7z3N@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-6-samuel.holland@sifive.com>
 <ZXczty+Y6dTDL4Xi@infradead.org>
 <7c40dfe8-f245-413f-a424-bde52ce21b6a@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c40dfe8-f245-413f-a424-bde52ce21b6a@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 11, 2023 at 10:12:27AM -0600, Samuel Holland wrote:
> On 2023-12-11 10:07 AM, Christoph Hellwig wrote:
> 
> Unfortunately, not all of the relevant options can be no-prefixed:

Ok.  That is another good argument for having the obj-fpu += syntax
I proposed.  You might need help from the kbuild maintainers from that
as trying to understand the kbuild magic isn't something I'd expect
from a normal contributor (including myself..).


