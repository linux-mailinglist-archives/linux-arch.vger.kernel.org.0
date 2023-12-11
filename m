Return-Path: <linux-arch+bounces-893-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022A180D0A4
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 17:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FD51F218E2
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350AF4C3DB;
	Mon, 11 Dec 2023 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZBI0pwfX"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD8E8E;
	Mon, 11 Dec 2023 08:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OpglHNMJJzSYx4T/kW665rmi/jtAX7GsOChv2TFobqY=; b=ZBI0pwfXyKO4WzDr/GoqiD07Co
	m9H1p0cuX7jyp3zfEsid8e96EHf+FruxRo/h9Z7aOTec1EOYzK3w7twOUDO+5r7Uvy7TgMg4AhN5A
	XPpQFSaIDNbG/IBqRqkMg8PSNXaQJhQT+kmZwtDwtvsmC5rBu6G0SQKuKeXZ7OMu9/F0IkykBurtB
	EEhOu4Snnpdf9XEFPoOtR5CXbfp/Nzs620D3v3x75LY3An5m3oy0jj0x0sxyL/OfsYUpD8097DPzd
	N08o8m6dQi9yotKcqJ65fCfFOrsa2THZBmM8Ys+fEUKATZ5MecKZO9sg24Lt1Q188iC+k4EOk+doJ
	ZqUnAXFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCisO-005gRx-1R;
	Mon, 11 Dec 2023 16:11:24 +0000
Date: Mon, 11 Dec 2023 08:11:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 09/12] riscv: Add support for kernel-mode FPU
Message-ID: <ZXc0rAdi7Vo8nbS8@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-10-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-10-samuel.holland@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +#ifdef __riscv_f
> +
> +#define kernel_fpu_begin() \
> +	static_assert(false, "floating-point code must use a separate translation unit")
> +#define kernel_fpu_end() kernel_fpu_begin()
> +
> +#else
> +
> +void kernel_fpu_begin(void);
> +void kernel_fpu_end(void);
> +
> +#endif

I'll assume this is related to trick that places code in a separate
translation unit, but I fail to understand it.  Can you add a comment
explaining it?


